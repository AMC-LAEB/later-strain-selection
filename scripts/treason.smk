import os, random, sys, copy, dendropy,re
from Bio import SeqIO, Seq, SeqRecord
import multiprocessing as mp 
import pandas as pd
import numpy as np
from time import gmtime, strftime
from datetime import datetime, date
import calendar
from dateutil.relativedelta import relativedelta
from utils import *
import dendropy
from dateutil.rrule import rrule, MONTHLY
import math

############### VARS ####################
#molecular clock rates used for treetime determined for sequences from 2000 to 2019
clock_rates = {"H3N2":{'PB2':0.00227, 'PB1':0.00202, 'PA':0.00192, 'HA':0.00415, 'NP':0.00177, 'NA':0.00266, 'M':0.00190, 'NS':0.00167},
                "H1N1pdm":{'PB2':0.00277, 'PB1':.00230, 'PA':0.00279, 'HA':0.00357, 'NP':0.00221, 'NA':0.00326, }}


#get from period, start and end date of each period:
period_dates = []
for p in config["periods"]:
    ps, pe = p.split("-")
    try:
        psd = date(2000+int(ps[:2].lstrip("0")), int(ps[2:].lstrip("0")),1)
    except:
        psd = date(2000, int(ps[2:].lstrip("0")), 1)
    try:
        ped = date(2000+int(pe[:2].lstrip("0")), int(pe[2:].lstrip("0")), calendar.monthrange(2000+int(pe[:2].lstrip("0")), int(pe[2:].lstrip("0")))[1])
    except:
        ped = date(2000, int(pe[2:].lstrip("0")), calendar.monthrange(2000, int(pe[2:].lstrip("0")))[1])
    period_dates.append((psd,ped))

#if HA1 only need to do some filtering 
if config["HA1_only"]:
    pre_file_label = "pre-HA1"
    #need to make files per month 
    months = [] #string abbreviations of the months
    month_dates = [] #month start and month end
    months_per_period = {}
    for i, (ps, pe) in enumerate(period_dates):
        p = config['periods'][i]
        months_per_period[p] = []
        ms, me = ps, ps+relativedelta(months=+1, days=-1)
        while ms < pe:
            m = ''.join(str(ms).split('-')[:-1])[2:]
            months.append(m)
            months_per_period[p].append(m)
            month_dates.append((ms, me))
            ms = ms+relativedelta(months=+1)
            me = ms+relativedelta(months=+1, days=-1)
    
    #sequence per period should per month
    if len(config["hemispheres"]) > 0:
        spp_wcs = [f"{h}-{m}" for h in config["hemispheres"] for m in months]
    else:
        spp_wcs = months
else:
    pre_file_label = "pre"
    spp_wcs = config["file_names"]
    months_per_period = {} #only used when HA1_only is specified, specifying to avoid errors
    months = []  #only used when HA1_only is specified, specifying to avoid errors
    month_dates = []  #only used when HA1_only is specified, specifying to avoid errors

############### MAIN RULE ####################
if config["translate"]:
    rule all:
        input:
            tree = expand(f"{config['output']}/protein/{config['subtype']}_{config['segment']}_{{fn}}.nexus", fn=config["file_names"]),
            fasta = expand(f"{config['output']}/protein/{config['subtype']}_{config['segment']}_{{fn}}_proteins.fasta", fn=config["file_names"])
            #sequences = expand(f"{config['output']}/sequences/{config['subtype']}_{config['segment']}_{{fn}}.fasta", fn=config["file_names"])

            
else:
    rule all:
        input:
            LBI = expand(f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_timetree.nexus", fn=config["file_names"])
            

rule SequencesPerPeriod:
    input:
        fasta = f"{config['output']}/sequences/gisaid_sequences_{config['subtype']}_{config['segment']}.fasta", 
        metadata = f"{config['output']}/sequences/metadata_gisaid_{config['subtype']}.csv",
    params:
        hemispheres = config["hemispheres"],
        periods = config["periods"],
        period_dates = period_dates,
        passage_categories = config["passage_categories"],
        segment = config["segment"],
        subtype = config["subtype"],
        sequence_dir = f"{config['output']}/sequences",

        HA1_only = config["HA1_only"], 
        months = months,
        month_dates = month_dates,
        months_per_period = months_per_period
    output:
        metadata = temp(expand(f"{config['output']}/sequences/{pre_file_label}_{config['subtype']}_{config['segment']}_{{fn}}_metadata.csv", fn=config["file_names"])),
        sequences = temp(expand(f"{config['output']}/sequences/{pre_file_label}_{config['subtype']}_{config['segment']}_{{spp_wc}}.fasta", spp_wc=spp_wcs)),
        #metadata = expand(f"{config['output']}/sequences/{pre_file_label}_{config['subtype']}_{config['segment']}_{{fn}}_metadata.csv", fn=config["file_names"]),
        #sequences = expand(f"{config['output']}/sequences/{pre_file_label}_{config['subtype']}_{config['segment']}_{{spp_wc}}.fasta", spp_wc=spp_wcs)
    threads: 1
    run:
        #load metadata
        metadata = pd.read_csv(input.metadata)
        metadata["Collection_Date"] = pd.to_datetime(metadata["Collection_Date"], errors='coerce')
        metadata["Collection_Date"] = [d.date() for d in metadata["Collection_Date"]]

        #load sequences as pandas dataframe
        records = [[r.id.split("|")[0], r.id, r.seq] for r in SeqIO.parse(input.fasta, "fasta")]
        records = pd.DataFrame.from_records(records, columns=["Isolate_Id", "header", "sequence"])

        #filter metadata on desired passage catogories
        metadata = metadata[metadata["passage_category"].isin(params.passage_categories)]
        
        #for each period filter sequence within period
        for i, p in enumerate(params.periods):
            
            ps, pe = params.period_dates[i]
    
            mdf = metadata[(metadata["Collection_Date"]>=ps)&(metadata["Collection_Date"]<=pe)]
            
            #get sequencess
            sdf = records[records["Isolate_Id"].isin(mdf["Isolate_Id"].to_list())]

            #if HA1 only is required create files per month
            if params.HA1_only:
                for m in params.months_per_period[p]:
                    ms, me = params.month_dates[params.months.index(m)]
                    
                    mmdf = mdf[(mdf["Collection_Date"]>=ms)&(mdf["Collection_Date"]<=me)]
                    smdf = sdf[sdf["Isolate_Id"].isin(mmdf["Isolate_Id"].to_list())]

                    #determine if hemispheres need to be separated
                    if len(params.hemispheres)>0:
                        for h in params.hemispheres:
                            mhdf = mmdf[mmdf["hemisphere"]==h]
                            shdf = smdf[smdf["Isolate_Id"].isin(mhdf["Isolate_Id"].to_list())]

                            #write output
                            sfn = os.path.join(params.sequence_dir,f"pre-HA1_{params.subtype}_{params.segment}_{h}-{m}.fasta")
                            mfn = os.path.join(params.sequence_dir,f"pre-HA1_{params.subtype}_{params.segment}_{h}-{p}_metadata.csv")

                            with open(sfn, "w") as fw:
                                for i, row in shdf.iterrows():
                                    fw.write(f">{row['header']}\n{row['sequence']}\n")
                            
                            mhdf = mdf[mdf["hemisphere"]==h]
                            mhdf.to_csv(mfn, index=False)
                    else: #write output
                        sfn = os.path.join(params.sequence_dir,f"pre-HA1_{params.subtype}_{params.segment}_{m}.fasta")
                        mfn = os.path.join(params.sequence_dir,f"pre-HA1_{params.subtype}_{params.segment}_{p}_metadata.csv")
                        
                        with open(sfn, "w") as fw:
                            for i, row in smdf.iterrows():
                                fw.write(f">{row['header']}\n{row['sequence']}\n")
                            
                        mdf.to_csv(mfn, index=False)
                        
            else:
                if len(params.hemispheres)>0:
                    for h in params.hemispheres:
                        mhdf = mdf[mdf["hemisphere"]==h]
                        shdf = sdf[sdf["Isolate_Id"].isin(mhdf["Isolate_Id"].to_list())]

                        sfn = os.path.join(params.sequence_dir,f"pre_{params.subtype}_{params.segment}_{h}-{p}.fasta")
                        mfn = os.path.join(params.sequence_dir,f"pre_{params.subtype}_{params.segment}_{h}-{p}_metadata.csv")

                        with open(sfn, "w") as fw:
                            for i, row in shdf.iterrows():
                                fw.write(f">{row['header']}\n{row['sequence']}\n")
                        mhdf.to_csv(mfn, index=False)
                else:
                    sfn = os.path.join(params.sequence_dir, f"pre_{params.subtype}_{params.segment}_{p}.fasta")
                    mfn = os.path.join(params.sequence_dir,f"pre_{params.subtype}_{params.segment}_{p}_metadata.csv")

                    with open(sfn, "w") as fw:
                        for i, row in sdf.iterrows():
                            fw.write(f">{row['header']}\n{row['sequence']}\n")
                    #write metadata
                    mdf.to_csv(mfn, index=False)

rule HA1Aligment:
    input:
        sequences = f"{config['output']}/sequences/pre-HA1_{config['subtype']}_{config['segment']}_{{spp_wc}}.fasta", 
    params:
        refdir = config["refdir"],
        segment = config['segment'],
        subtype = config['subtype']
    output:
        alignment = temp(f"{config['output']}/alignment/HA1_{config['subtype']}_{config['segment']}_{{spp_wc}}.fasta"), 
        #alignment = f"{config['output']}/alignment/HA1_{config['subtype']}_{config['segment']}_{{spp_wc}}.fasta", 

    threads:  workflow.cores if workflow.cores < 3 else 3
    run:
        #get reference
        for f in os.listdir(params.refdir):
            if params.segment in f and params.subtype in f:
                reference = os.path.join(params.refdir, f)
        
        #run mafft
        try:
            cmd = ['mafft', '--auto', '--thread', str(threads), '--keeplength', '--addfragments', input.sequences, reference,'>', output.alignment]
            shell(" ".join(cmd))

            #remove ref > want ref for initial alignment but not relevant else
            records = list(SeqIO.parse(output.alignment, "fasta"))
            with open(output.alignment,"w")as fw:
                SeqIO.write(records[1:],fw,"fasta")
        except:
            shell (f"touch {output.alignment}")

rule FilterHA1: #trimming sequence to only cover HA1 and subsampling if required
    input:
        metadata = f"{config['output']}/sequences/pre-HA1_{config['subtype']}_{config['segment']}_{{fn}}_metadata.csv",
        alignment = expand( f"{config['output']}/alignment/HA1_{config['subtype']}_{config['segment']}_{{spp_wc}}.fasta", spp_wc=spp_wcs)
    params:
        months_per_period = months_per_period,
        segment = config["segment"],
        subsample = config["subsample"],
        subsample_time = config["subsample_time"],
        mxa = config["max_ambig"],
        ml = config["min_length"],
        passage_categories = config["passage_categories"],
        periods = config["periods"],
        period_dates = period_dates,
        seed = config['seed'], #in case seed is used
        no_seed = config['no_seed'], #whether or not seed needs to be used

        #H3N2 HA
        HA1_check_nuc_length = 948,
        HA1_complete_aa_length = 329, 
        HA1_complete_nuc_length = 987, 
        signal_protein_aa_length = 16,
        signal_protein_nuc_length = 16*3,
    output:
        metadata = f"{config['output']}/sequences/{config['subtype']}_{config['segment']}_{{fn}}_metadata.csv",
        sequences = f"{config['output']}/sequences/{config['subtype']}_{config['segment']}_{{fn}}.fasta", 
    threads: 1
    run:
        #determine period and hemisphere
        p = "-".join(wildcards.fn.split("-")[-2:])
        h = None if len(wildcards.fn.split("-"))<=2 else wildcards.fn.split("-")[0]

        #determine months in period
        months = params.months_per_period[p]

        #get sequences from alignments
        sequences = []
        for f in input.alignment:
            
            m = f.split("-")[-1].split("_")[-1].split(".")[0]

            if m in months:
                if h is not None:
                    if h in f:
                        sequences.extend([r for r in SeqIO.parse(f, "fasta")])
                else:
                    sequences.extend([r for r in SeqIO.parse(f, "fasta")])
        #sequence are aligned to CDS 
        HA1_sequences = []
        for r in sequences:
            #remove signal protein portion and trimmed to length to check quality for 
            HA1_seq_to_check = r.seq[params.signal_protein_nuc_length-1:]
            HA1_seq_to_check = HA1_seq_to_check[:params.HA1_check_nuc_length]

            if check_max_ambig(HA1_seq_to_check, mxa=params.mxa) and check_sequence_length(params.segment, HA1_seq_to_check, params.ml, params.HA1_check_nuc_length):
                HA1_seq =  r.seq[params.signal_protein_nuc_length-1:]
                HA1_seq = HA1_seq[:params.HA1_complete_nuc_length]

                HA1_sequences.append([r.id.split("|")[0], r.id, HA1_seq])
        
        #parse as dataframa 
        HA1_sequences = pd.DataFrame.from_records(HA1_sequences, columns=["Isolate_Id", "header", "sequence"])

        #read metadata and remove non HA1 sequences
        metadata = pd.read_csv(input.metadata)
        metadata["Collection_Date"] = pd.to_datetime(metadata["Collection_Date"], errors='coerce')
        metadata["Collection_Date"] = [d.date() for d in metadata["Collection_Date"]]

        metadata = metadata[metadata["Isolate_Id"].isin(HA1_sequences["Isolate_Id"].to_list())]
        #select only desired passage catogories > to be sure
        metadata = metadata[metadata["passage_category"].isin(params.passage_categories)]

        #check if subsampling needs to be done 
        if params.subsample:
            #set seed if required
            if not params.no_seed:
                random.seed(params.seed)
            #get period from wild card and determine period start and end month 
            p = "-".join(wildcards.fn.split("-")[-2:])
            ps, pe = params.period_dates[params.periods.index(p)]
            
            #subsample for each month with period 
            ids_to_select = []
            si = ps
            ei = si + relativedelta(months=+1, days=-1)
            while ei < pe:
                mdf = metadata[(metadata["Collection_Date"]>=si)&(metadata["Collection_Date"]<=ei)]
                si = si + relativedelta(months=+1)
                ei = si + relativedelta(months=+1, days=-1)

                #for each country in mdf subsample sequences based on passage category hierarchy
                for country in mdf['country'].unique():
                    cdf = mdf[mdf['country']==country]
                    if len(cdf) <= params.subsample:
                        ids_to_select.extend(cdf["Isolate_Id"].to_list())
                        continue
                    
                    sub_selection = []
                    for pl in params.passage_categories:
                        pdf = cdf[cdf["passage_category"]==pl]
                        try: 
                            sub_selection.extend(random.sample(pdf["Isolate_Id"].to_list(), params.subsample-len(sub_selection)))
                        except:
                            sub_selection.extend(pdf["Isolate_Id"].to_list())
                        if len(sub_selection) >= params.subsample:
                            break
                    ids_to_select.extend(sub_selection)
            
            metadata = metadata[metadata["Isolate_Id"].isin(ids_to_select)].drop_duplicates()

        HA1_sequences = HA1_sequences[HA1_sequences["Isolate_Id"].isin(metadata["Isolate_Id"].to_list())].drop_duplicates()

        metadata.to_csv(output.metadata, index="False")

        #write output sequence file 
        with open(output.sequences, "w") as fw:
            for i, row in HA1_sequences.iterrows():
                fw.write(f">{row['header']}\n{row['sequence']}\n")
    

rule FilterSequences:
    input:
        sequences = f"{config['output']}/sequences/pre_{config['subtype']}_{config['segment']}_{{fn}}.fasta", 
        metadata = f"{config['output']}/sequences/pre_{config['subtype']}_{config['segment']}_{{fn}}_metadata.csv",
    params:
        subsample = config["subsample"],
        subsample_time = config["subsample_time"],
        mxa = config["max_ambig"],
        ml = config["min_length"],
        segment = config["segment"],
        periods = config["periods"],
        period_dates = period_dates,
        passage_categories = config["passage_categories"],
        seed = config['seed'], #in case seed is used
        no_seed = config['no_seed'], #whether or not seed needs to be used
    output:
        metadata = f"{config['output']}/sequences/{config['subtype']}_{config['segment']}_{{fn}}_metadata.csv",
        sequences = f"{config['output']}/sequences/{config['subtype']}_{config['segment']}_{{fn}}.fasta", 
    threads: 1
    run:
       # #get sequences
        records = []
        for r in SeqIO.parse(input.sequences, "fasta"):
            #filter out low quality sequences 
            if check_sequence_length(params.segment, r.seq, mnlp=params.ml) and check_max_ambig(r.seq, mxa=params.mxa):
                records.append([r.id.split("|")[0], r.id, r.seq])

        records = pd.DataFrame.from_records(records, columns=["Isolate_Id", "header", "sequence"])

        #read metadata remove low quality sequences
        metadata = pd.read_csv(input.metadata)
        metadata = metadata[metadata["Isolate_Id"].isin(records["Isolate_Id"].to_list())]
        metadata["Collection_Date"] = pd.to_datetime(metadata["Collection_Date"], errors='coerce')
        metadata["Collection_Date"] = [d.date() for d in metadata["Collection_Date"]]

        #check if subsampling needs to be done 
        if params.subsample:
            #set seed if required
            if not params.no_seed:
                random.seed(params.seed)
            #get period from wild card and determine period start and end month 
            p = "-".join(wildcards.fn.split("-")[-2:])
            ps, pe = params.period_dates[params.periods.index(p)]
            
            #subsample for each month with period 
            ids_to_select = []
            si = ps
            ei = si + relativedelta(months=+1, days=-1)
            while ei < pe:
                mdf = metadata[(metadata["Collection_Date"]>=si)&(metadata["Collection_Date"]<=ei)]
                si = si + relativedelta(months=+1)
                ei = si + relativedelta(months=+1, days=-1)

                #for each country in mdf subsample sequences based on passage category hierarchy
                for country in mdf['country'].unique():
                    cdf = mdf[mdf['country']==country]
                    if len(cdf) <= params.subsample:
                        ids_to_select.extend(cdf["Isolate_Id"].to_list())
                        continue
                    
                    sub_selection = []
                    for pl in params.passage_categories:
                        pdf = cdf[cdf["passage_category"]==pl]
                        try: 
                            sub_selection.extend(random.sample(pdf["Isolate_Id"].to_list(), params.subsample-len(sub_selection)))
                        except:
                            sub_selection.extend(pdf["Isolate_Id"].to_list())
                        if len(sub_selection) >= params.subsample:
                            break
                    ids_to_select.extend(sub_selection)
            
            metadata = metadata[metadata["Isolate_Id"].isin(ids_to_select)]
            records = records[records["Isolate_Id"].isin(ids_to_select)]
        
        if params.subsample_time and len(metadata) > params.subsample_time:
            #set seed if required
            if not params.no_seed:
                random.seed(params.seed)
            
            #get months
            p = "-".join(wildcards.fn.split("-")[-2:])
            ps, pe = params.period_dates[params.periods.index(p)]
            months = len([dt for dt in rrule(MONTHLY, dtstart=ps, until=pe)])
            
            
            # #subsample for each month with period 
            ids_to_select = []
           
            for m in [1,2,3,4]:
            
                si = ps
                ei = si + relativedelta(months=+m, days=-1)
                seqs_per_month = math.floor((params.subsample_time-len(ids_to_select))/(months/m))
                
                while ei < pe:
                    mdf = metadata[(metadata["Collection_Date"]>=si)&(metadata["Collection_Date"]<=ei)&(~metadata["Isolate_Id"].isin(ids_to_select))]
                    si = si + relativedelta(months=+1)
                    ei = si + relativedelta(months=+1, days=-1)

                    if len(mdf) <= seqs_per_month:
                        ids_to_select.extend(mdf["Isolate_Id"].to_list())
                    else:
                        ids_to_select.extend(random.sample(mdf["Isolate_Id"].to_list(), seqs_per_month))
                    if len(ids_to_select) > params.subsample_time:
                        break

                if len(ids_to_select) > params.subsample_time:
                    break
        
            metadata = metadata[metadata["Isolate_Id"].isin(ids_to_select)]
            records = records[records["Isolate_Id"].isin(ids_to_select)]

        with open(output.sequences, "w") as fw:
            for i, row in records.iterrows():
                fw.write(f">{row['header']}\n{row['sequence']}\n")

        metadata.to_csv(output.metadata, index=False)

rule MSA:
    input:
        sequences =  f"{config['output']}/sequences/{config['subtype']}_{config['segment']}_{{fn}}.fasta"
    params:
        refdir = config["refdir"],
        segment = config['segment'],
        subtype = config['subtype']
    output:
        msa = f"{config['output']}/alignment/{config['subtype']}_{config['segment']}_{{fn}}_MSA.fasta"
    threads:  workflow.cores if workflow.cores < 3 else 3
    message: "Performing multiple sequence alignment for {wildcards.fn} sequences"
    run: 
        #get reference
        for f in os.listdir(params.refdir):
            if params.segment in f and params.subtype in f:
                reference = os.path.join(params.refdir, f)

        try:
            #run mafft
            cmd = ['mafft', '--auto', '--thread', str(threads), '--keeplength', '--addfragments', input.sequences, reference,'>', output.msa]
            shell(" ".join(cmd))

            #remove ref > want ref for initial alignment but not relevant else
            records = list(SeqIO.parse(output.msa, "fasta"))
            with open(output.msa,"w")as fw:
                SeqIO.write(records[1:],fw,"fasta")
        except:
            shell(f"touch {output.msa}")

        
rule PhyloTree:
    input:
        msa = rules.MSA.output.msa
    params:
        model = "GTR+G4",
        seed = config['seed'],
        no_seed = config['no_seed'],
        treefile = temp(f"{config['output']}/alignment/{config['subtype']}_{config['segment']}_{{fn}}_MSA.fasta.treefile"),
    output:
        tree = f"{config['output']}/tree/{config['subtype']}_{config['segment']}_{{fn}}.treefile",
    message: "Constructing phylogenetic maximum likelihood tree for {wildcards.fn}"
    threads: workflow.cores if workflow.cores < 3 else 3
    run:
        #run IQTREE 
        try:
            if not params.no_seed:
                # iqtree_command = ['iqtree', '-s', input.msa, '-B', '1000', '-alrt', '1000', '-m', params.model, 
                #                 '-nt', str(threads), '--seed', str(params.seed), '-redo']
                iqtree_command = ['iqtree', '-s', input.msa, '-m', params.model, '-nt', str(threads), '--seed', str(params.seed), '-redo']
            else:
                # iqtree_command = ['iqtree', '-s', input.msa, '-B', '1000', '-alrt', '1000', '-m', params.model,
                #                 '-nt', str(threads), '-redo']
                iqtree_command = ['iqtree', '-s', input.msa, '-m', params.model, '-nt', str(threads), '-redo']
            
            shell(" ".join(iqtree_command))

            #move tree file
            shell (f'mv {params.treefile} {output.tree}')
            
            #remove all IQtree files but the actual treefile
            files_ex = [".bionj",".ckp.gz",".iqtree",".mldist",".model.gz",".contree",".log",".splits.nex",".uniqueseq.phy",".model", ".parstree"]
            for ex in files_ex:
                if os.path.isfile(input.msa + ex):
                    os.remove(input.msa+ ex)
        except:
            shell (f"touch {output.tree}")

rule TreeTime:
    input:
        metadata = f"{config['output']}/sequences/{config['subtype']}_{config['segment']}_{{fn}}_metadata.csv",
        msa = rules.MSA.output.msa, 
        tree = rules.PhyloTree.output.tree,
    params: 
        molclock_rates = clock_rates,
        segment = config['segment'],
        subtype = config['subtype'],
        treetime_folder = temp(f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_tt"),
        timetree = temp(f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_tt/timetree.nexus"),
        divergence_tree = temp(f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_tt/divergence_tree.nexus"),
        mol_clock = temp(f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_tt/molecular_clock.txt"),
        ancestral_sequences = temp(f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_tt/ancestral_sequences.fasta"),
    output:
        temp_msa = temp(f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}.fasta"),
        dates = f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_inputdates.csv",
        timetree = f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_timetree.nexus",
        divergence_tree = f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_divergence.nexus",
        treelog = f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_treetime.txt",
        mol_clock = temp(f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_molecular_clock.txt"),
        ancestral_sequences = f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_ancestral_sequences.fasta",
        #dates_estimate = f"{config['output']}/treetime/{config['segment']}/dates.tsv",
    message: "Constructing time tree for {wildcards.fn}"
    threads: 1 #no multi threading possible for treetime
    run: 
        #get the correct metadata file(s) and load metadata as pandas df
        metadata = pd.read_csv(input.metadata, parse_dates=["Collection_Date"], index_col="Isolate_Id")
        if len(metadata) == 0:
            shell(f"touch {output.temp_msa}")
            shell(f"touch {output.dates}")
            shell(f"touch {output.timetree}")
            shell(f"touch {output.divergence_tree}")
            shell(f"touch {output.treelog}")
            shell(f"touch {output.mol_clock}")
            shell(f"touch {output.ancestral_sequences}")
        else:
            
            #iqtree fucks up the ids in the msa so fix that
            try:
                ids = [i.taxon.label.replace(" ", "_") for i in dendropy.Tree.get(path=input.tree, schema="newick").leaf_node_iter()]
            except:
                ids = []
                with open(input.tree, "r") as f:
                    for l in f:
                        l = l.split("EPI_ISL_")
                        for i in l:
                            if params.segment in i and params.subtype in i:
                                i = f"EPI_ISL_{i.split(f'{params.subtype}|{params.segment}:')[0]}{params.subtype}|{params.segment}"
                                ids.append(i)

            ids = {i.split("|")[0]:i for i in ids}
            records = [SeqRecord.SeqRecord(r.seq, id=ids[r.id.split("|")[0]]) for r in SeqIO.parse(input.msa, "fasta")] 
            with open(output.temp_msa, "w") as fw:
                SeqIO.write(records, fw, "fasta")
            #print (ids["EPI_ISL_363969"] =="EPI_ISL_363969|1487224|A/Cote_D_Ivoire/14/2019|A_/_H3N2|HA")
            
            #generate dates file
            header_date = []
            for rid, header in ids.items():
                d = metadata.loc[rid, "Collection_Date"].date()
                fd = d.year + (d.timetuple().tm_yday/365)
                header_date.append([header, fd])
            
            dates = pd.DataFrame.from_records(header_date, columns=["accession", "date"])
            dates.to_csv(output.dates, index=False)   
            #get clock rates 
            clock_rate = params.molclock_rates[params.subtype][params.segment]
            clock_stdev = clock_rate*0.2

            try:
                #run treetime 
                cmd = ['treetime', '--tree', input.tree, '--aln', output.temp_msa, '--dates', output.dates, '--outdir', params.treetime_folder,
                    '--clock-rate', str(clock_rate), '--clock-std-dev', str(clock_stdev)]
                #we need command line output > os tee as I also want to see what's happening
                cmd.extend(['|', 'tee', output.treelog])
                shell (" ".join(cmd))

                #mv treetime files of interest and then remove treetime folder > don't want to consume memory
                shell(f"mv {params.timetree} {output.timetree}")
                shell(f"mv {params.divergence_tree} {output.divergence_tree}")
                shell(f"mv {params.mol_clock} {output.mol_clock}")
                shell(f"mv {params.ancestral_sequences} {output.ancestral_sequences}")
                shell(f"rm -r -d {params.treetime_folder}") 
            except:
                shell(f"touch {output.temp_msa}")
                shell(f"touch {output.dates}")
                shell(f"touch {output.timetree}")
                shell(f"touch {output.divergence_tree}")
                shell(f"touch {output.treelog}")
                shell(f"touch {output.mol_clock}")
                shell(f"touch {output.ancestral_sequences}")

rule LBI:
    input:
        timetree = f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}_timetree.nexus"
    params:
        treeformat = "nexus",
        outputformat = "nexus",
        tau = 0.3, #might make these command line options
        normalize = True, #might make these command line options
    output:
        lbi_tree = f"{config['output']}/lbi/{config['subtype']}_{config['segment']}_{{fn}}_LBI.nexus"
    message: "constructing LBI tree for {wildcards.fn}"
    run:
        try:
            #read tree
            tree = dendropy.Tree.get(path=input.timetree, schema=params.treeformat)

            #prep tree
            tree = prep_tree_for_lbi(tree)

            #calculate LBI
            tree = calculate_LBI(tree, params.tau, normalize=params.normalize)

            #write output tree
            tree.write(path=output.lbi_tree, schema=params.outputformat)
        except:
            shell(f"touch {output.lbi_tree}")

###### Proteins ######
rule Translate:
    input:
        sequences = f"{config['output']}/sequences/{config['subtype']}_{config['segment']}_{{fn}}.fasta",
        msa = f"{config['output']}/alignment/{config['subtype']}_{config['segment']}_{{fn}}_MSA.fasta",
    params:
        refdir = config["refdir"],
        segment = config['segment'],
    output:
        proteins = f"{config['output']}/protein/{config['subtype']}_{config['segment']}_{{fn}}_proteins.fasta",
    message: "translating mcc sequences for {wildcards.fn} into proteins"
    run:
        #get length of reference sequence
        try:
            for f in os.listdir(params.refdir):
                if params.segment in f:
                    reference = os.path.join(params.refdir, f)
            ref_length = len(list(SeqIO.parse(reference,"fasta"))[0].seq)

            #get msa records 
            msa_recs = {}
            for record in SeqIO.parse(input.msa, "fasta"):
                msa_recs[record.id] = record.seq
            
            proteins = []
            for record in SeqIO.parse(input.sequences, "fasta"):
                msaseq = msa_recs[record.id] 
                #get coding region from MSA sequence
                seq = Seq.Seq(str(msaseq).replace("-","n")).translate()
                #make protein record and add to  protein dict        
                protrec = SeqRecord.SeqRecord(seq, id=record.id, name=record.name, description=record.description)
                proteins.append(protrec)
            
            #write output file
            with open(output.proteins,"w") as fw:
                SeqIO.write(proteins, fw, "fasta")
        except:
            shell(f"touch {output.proteins}")


rule TranslateMutations:
    input:
        #sequences = f"{config['output']}/clinical/{config['segment']}_{{fn}}_mcc.fasta",
        temp_msa = f"{config['output']}/treetime/{config['subtype']}_{config['segment']}_{{fn}}.fasta",
        tree = rules.LBI.output.lbi_tree,
    params:
        seed = config['seed'],
        no_seed = config['no_seed'],
        o_nonsyn = config['o_nonsyn'], 
        treeformat = "nexus", #lbi output format should not change
    output:
        tree = f"{config['output']}/protein/{config['subtype']}_{config['segment']}_{{fn}}.nexus",
    message: "translating the mutations within the phylogenetic tree for {wildcards.fn}"
    run:
        #making a dict of the isolates with the sequences > using MSA 
        try:
            isolates = {}
            for record in SeqIO.parse(input.temp_msa,"fasta"):
                if record.id not in isolates.keys():
                    #only appending from start codon onwards as tree was build this way > important for numbering 
                    isolates[record.id] = str(record.seq)
            
            #load the tree
            tree = dendropy.Tree.get(path=input.tree, schema=params.treeformat)

            #translate mutations
            if params.no_seed:
                tree = translate_tree_mutations(isolates,tree,params.o_nonsyn)
            else:
                tree = translate_tree_mutations(isolates,tree,params.o_nonsyn,seed=params.seed)
        
            #write tree to output file
            tree.write(path=output.tree, schema=params.treeformat) 
        except:
            shell(f"touch {output.tree}")
