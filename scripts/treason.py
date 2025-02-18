#!/usr/bin/env python3 

import argparse, os, sys, snakemake
import pandas as pd
import numpy as np
from Bio import SeqIO
from time import gmtime, strftime
from datetime import date
from dateutil.relativedelta import relativedelta
from utils import check_max_ambig, check_sequence_length
from labels import *
import calendar

#get file path
cwd = os.getcwd()
filedir = os.path.abspath(os.path.dirname(__file__))
refdir = os.path.join(filedir, "..","data","references")
dropdir = os.path.join(filedir, "..","data","outliers") #gisaid ID of isolates that should not be included

#general variables 
passage_labels = ["clinical", "cell-based MDCK or SIAT", "cell-based other", "egg-based", "unknown"]
hemisphere_labels = {"nh":"northern", "sh":"southern"}
valid_nucs = ['A','T','C','G','R','Y','B','D','K','M','H','V','S','W','N']


def ArgumentParser():
    """Argument parser"""

    parser = argparse.ArgumentParser(prog = "treason.py", #changing this later
        formatter_class = argparse.RawTextHelpFormatter,
        description = "Filter clinical A/H3N2 samples from GISAID and construct phylogenetic tree per season (and previous sseason)" ) 
    
    parser.add_argument('-d','--data-folder', required=True, action="store", type=str, help="data folder where raw GISAID sequence and metadata are stored")
    parser.add_argument('-o','--output', required=False, action="store", type=str, help="output directory to store all generated output file (default: ./)")
    parser.add_argument('-s','--segment', required=False, action="store", type=str, default="HA", choices=["PB2", "PB1", "PA", "HA", "NP", "NA", "M", "NS"], help="segment abbreviations that will be analyzed")
    parser.add_argument('-st','--subtype', required=False, action="store", type=str, default="H3N2", choices=["H3N2", "H1N1pdm"], help="subtype to be analyzed (default: A/H3N2)")
    parser.add_argument('-HA1', required=False, action="store_true", help="if only HA1 part of sequence should be analyzed (! ONLY AVAILABLE FOR A/H3N2 HA)")

    parser.add_argument('-mxa','--max-ambig', required=False, action="store", type=float, default=0.01, help="maximum percentage of ambiguous nucleotides allowed (default: 0.01)")
    parser.add_argument('-ml','--min-length', required=False, action="store", type=float, default=0.95, help="miminum percentage of length w.r.t. the reference segment")
   
    parser.add_argument('-sh','--separate-hemispheres', nargs="?", required=False, const="both", action="store", type=str,
                        help="if analysis needs to be performed for northern and southern hemisphere separately. If only one of the two hemispheres needs to be analyzed specify which.")
    parser.add_argument('-tf','--time-frame', required=False, action="store", type=str, default='2015-2019', 
                        help="time-frame in years for which periods with be determine  (default: 2015-2019)")
    
    parser.add_argument('-ps','--period-start', required=False, action="store", type=str, default="January",
                        choices=["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
                        help="specify the desired start of the period (default: January)")
    parser.add_argument('-pd','--period-duration', required=False, action="store", type=int, default=12, help="The duration of the period in months (default=12).")
    parser.add_argument('-ndp','--no-dynamic-periods', required=False, action="store_true", 
                        help="if period duration <= 12 months periods will be treated dynamic unless this flag is specified. (if '-pd' > 12 this flag will be ignored.)")
    parser.add_argument('-pp', '--preceding-period', required=False,  action="store", type=int, default=0, help="Number of months preceding period from which sequences to be included (default=0)")
    
    parser.add_argument('-ss','--sub-sample',required=False, nargs="?", const=10, action="store",type=int, 
                        help="If season needs to be down sample for a max number of sequences/country/month (if specified default:10)")
    parser.add_argument('-sst','--sub-sample-time', required=False, nargs="?", const=2000, action="store",type=int, 
                        help="subsample by time to maximum number of sequence supplied (if specified, default: 2000)")
    
    parser.add_argument('-pl', '--passage-labels', nargs="+", type=str, required=False, action="store",
                        help=f"Whether only sequence specific passage categories should be analysis and if so which. Choices {', '.join(passage_labels)}. Specify as string")

    parser.add_argument('-c','--seed', required=False, action="store", type=int, default=29, help="Seed to use for random sampling (default:29)")
    parser.add_argument('-nc','--no-seed', required=False, action="store_true", help="If flag is specified no seed will be used")

    parser.add_argument('-r','--redo', required=False, action="store_true", help="Redo all steps except the initial merging step if data already exists")
    parser.add_argument('-ra','--redo-all', required=False, action="store_true", help="Redo ALL steps if data already exists")
    parser.add_argument('-t','--threads',required=False,action='store',type=int,help="Number of threads (default 1)")
    parser.add_argument('-f','--force-rule', required=False,action='store',choices=["FilterClinical","GetSeason","MSA","PhyloTree","TreeTime","FilterMolecularClockOutliers",
                                                                                    "RedoMSA","RedoPhyloTree","RedoTreeTime", "LBI", "TranslateMutations", "Translate"],
                        help="Force execution of specific snakemake rule")

    parser.add_argument('-v', '--verbose', required=False,action="store_false",help="print a bunch of stuff")

    #check if arguments were entered 
    if len(sys.argv[2:])<1: 
        parser.print_help()
        sys.exit(-1)
    else:
        return parser.parse_args()

def main():
    args = ArgumentParser()

    #get threads
    threads = args.threads if args.threads else 1
    print("Number of threads is: ", threads) 

    #get timeframe
    try:
        time_frame_start_year = int(args.time_frame.split("-")[0])
        time_frame_end_year = int(args.time_frame.split("-")[-1])
    except:
        sys.stderr.write(f"Error: time frame is not properly specified. Specify with '-tf' or '--time-frame' as: yyyy-yyyy")
        sys.exit(-1)
    time_frame_start = date(time_frame_start_year, 1,1)
    time_frame_end = date(time_frame_end_year,12,31)
        
    #get interval start 
    period_start_month = list(calendar.month_name).index(args.period_start)
    #get interval duration
    period_duration = args.period_duration
    preceding_period = args.preceding_period
    ndp = args.no_dynamic_periods
    if period_duration <= 0:
        sys.stderr.write(f"Error: period duration is not properly specified. Specify with '-pd' or --period-duration. Must at least 1 month")
        sys.exit(-1)

    #lol note: I have no idea how to make this more clear. suggestions are welcome
    if period_duration > 12:
        print ("NOTICE: period duration is >12 months/1 year, period will be restarted every year within the specified time frame")
    elif ndp:
        print ("NOTICE: period duration is <=12 months/1 year and no-dynamic period flag ('-npd') is specified so period will started every year within the frame in the specified starting month.\n\
               If this is not desired remove '-npd' from command")
    else:
        print ("NOTICE: period duration is <=12 months/1 year, therefore dynamic periods will be initialized (e.g. if time-period=2015-2017, period_start=January, and period_duration=1 months, \n\
               periods will look like 2015-01, 2015-02, 2015-03, etc. and not 2015-01, 2016-01). If non-dynamic periods (e.g. 2015-01, 2016-01) are desired add '-npd' to command")

    #relativedelta(months=+6)
    periods = [] #labels
    #get period start and 'real' period start given specified preceding period
    ps = date(time_frame_start_year, period_start_month, 1) #+ relativedelta(months=-preceding_period)
    rps = date(time_frame_start_year, period_start_month, 1) + relativedelta(months=-preceding_period)

    # period start should be within time frame 
    #potentially need to change this to ps > to include more early periods within time frame
    while rps <= time_frame_start:
        ps = ps + relativedelta(years=+1)
        rps = ps + relativedelta(months=-preceding_period)

    #get  period end 
    pe = ps + relativedelta(months=+period_duration, days=-1)

    #determine all periods
    if not ndp and period_duration <= 12:
        while pe < time_frame_end:
            if period_duration == 1:
                p = f"{(''.join(str(rps).split('-')[:-1]))[2:]}"
            else:
                p = f"{(''.join(str(rps).split('-')[:-1]))[2:]}-{(''.join(str(pe).split('-')[:-1]))[2:]}"
            periods.append(p)
            ps = ps + relativedelta(months=+period_duration)
            pe = ps + relativedelta(months=+period_duration, days=-1)
            rps = ps + relativedelta(months=-preceding_period)
    else:
        while pe < time_frame_end:
            p = f"{(''.join(str(rps).split('-')[:-1]))[2:]}-{(''.join(str(pe).split('-')[:-1]))[2:]}"
            periods.append(p)
            ps = ps + relativedelta(years=+1)
            pe = ps + relativedelta(months=+period_duration, days=-1)
            rps = ps + relativedelta(months=-preceding_period)

    #get segments of interest
    segment = args.segment
    segment_col = f"{segment} Segment_Id"
    #get subtype
    subtype = args.subtype
    

    #get data folder
    datafolder = os.path.join(cwd, args.data_folder)
    if not os.path.isdir (datafolder):
        sys.stderr.write(f"Error: cannot find{datafolder}. Check if the directory is properly specified.")
        sys.exit(-1)

    #get to drop files
    for f in os.listdir(dropdir):
        if f.split("_")[1] == segment and f.split("_")[0] == subtype:
            to_drop_file = os.path.join(dropdir,f)
    itr = set(pd.read_csv(to_drop_file)["Isolate_Id"]) #ids to remove
    
    #get the output directory
    if args.output:
        output = os.path.join(cwd, args.output)
        os.makedirs(output, exist_ok=True)
    else:
        output = cwd

    #determine if we need to filter on hemispheres and if so which 
    if args.separate_hemispheres:
        if args.separate_hemispheres == "both":
            hemispheres = list(hemisphere_labels.keys())
        else:
            hs = [args.separate_hemispheres]
            hemispheres = []
            for h in hs:
                if h not in list(hemisphere_labels.keys()):
                    if h in list(hemisphere_labels.values()):
                        hemispheres.append(hemisphere_labels[h])
                    else:
                        sys.stderr.write(f"Error: Specified hemisphere label: {h} is not a possible choice. Specify northern hemisphere as 'nh' or 'northern' and southern as 'sh' or 'southern'.")
                        sys.exit(-1)
                else: 
                    hemispheres.append(h)
    else:
        hemispheres = []

    #determine if there needs to be filtered on passage labels
    if args.passage_labels:
        passage_categories = " ".join(args.passage_labels)
        passage_categories = [pl.lstrip().rstrip()for pl in passage_categories.split(",")]
        for pl in passage_categories:
            if pl not in passage_labels:
                sys.stderr.write(f"Error: Specified passage category: {pl} is not a possible choice. Chose from {', '.join(passage_labels)}")
                sys.exit(-1)
        #sort by hierarchy
        passage_categories = [pl for pl in passage_labels if pl in passage_categories]
        
    else:
        passage_categories = passage_labels

    #for metadata only getting the columns of interest
    if not os.path.isfile(f"{output}/sequences/metadata_gisaid_{subtype}.csv") or args.redo_all:
        print (f"Merging Raw GISAID sequences into a single file per segment: {strftime('%Y-%m-%d %H:%M:%S', gmtime())}")
        
        records = []
        for f in os.listdir(datafolder):
            if os.path.isdir(os.path.join(datafolder,f)) and f == segment:
                records = [[r.id.split("|")[0], r.id.split("|")[1], r.id,str(r.seq)] for f2 in os.listdir(os.path.join(datafolder, f)) if f2.endswith(".fasta") \
                                  for r in SeqIO.parse(os.path.join(os.path.join(datafolder, f), f2), "fasta")]
                # records = [r for  f2 in os.listdir(os.path.join(datafolder, f)) if f2.endswith(".fasta") \
                #            for r in SeqIO.parse(os.path.join(os.path.join(datafolder, f), f2), "fasta")]
            #load sequences
            elif os.path.isfile(os.path.join(datafolder,f)):
                if f.endswith(".fasta") and segment in f:
                    records.extend([[r.id.split("|")[0],r.id.split("|")[1],r.id,str(r.seq)] for r in list(SeqIO.parse(os.path.join(datafolder,f),"fasta"))])
                    #records.extend([r for r in list(SeqIO.parse(os.path.join(datafolder,f),"fasta"))])
                
                #read metadata
                elif f.endswith(".xls") or f.endswith(".xlsx") or f.endswith(".csv"):
                    
                    try:
                        if f.endswith(".xls") or f.endswith(".xlsx"):
                            metadf = pd.concat([metadf, pd.read_excel(os.path.join(datafolder,f),usecols=metcols+['Host'])])
                            
                        else: 
                            metadf = pd.concat([metadf, pd.read_csv(os.path.join(datafolder, f))], usecols=metcols+['Host'])
                    except:
                        if f.endswith(".xls") or f.endswith(".xlsx"):
                            metadf = pd.read_excel(os.path.join(datafolder,f),usecols=metcols+['Host']) 
                            
                        else: 
                            metadf =  pd.read_csv(os.path.join(datafolder,f),usecols=metcols+['Host']) 
        #parse sequences into data frame
        records = pd.DataFrame.from_records(records, columns=["Isolate_Id", segment_col, "header", "sequence"])
        
        #filter out all sequences for which there is no complete collection date

        metadf = metadf[metadf["Host"]=="Human"].drop(columns=["Host"])
        metadf["Collection_Date"] = pd.to_datetime(metadf["Collection_Date"], errors='coerce')
        metadf = metadf.dropna(subset=["Collection_Date"]).reset_index(drop=True)

        #also filter out sequences that have no country specification 
        metadf = metadf.drop(metadf[metadf["Location"].str.count("/") < 1].index).reset_index(drop=True)
        metadf[segment_col] = [v.split("|")[0].lstrip("EPI") for v in  metadf[segment_col]]
        records[segment_col] = [v.split("|")[0].lstrip("EPI") for v in records[segment_col]]

        #join > as some Isolates have multiple submissions
        metadf["Isolate_Id|"+segment_col] = metadf[["Isolate_Id", segment_col]].agg("|".join, axis=1)
        records["Isolate_Id|"+segment_col] = records[["Isolate_Id", segment_col]].agg("|".join, axis=1)

        #determine passage category > determining anyway as it might be used for subsampling
        for i, row in metadf.iterrows():
            ph = row["Passage_History"]
            if ph in cpl:
                metadf.loc[i, "passage_category"] = "clinical"
            elif ph in cbpl:
                metadf.loc[i, "passage_category"] = "cell-based MDCK or SIAT"
            elif ph in epl:
                metadf.loc[i, "passage_category"] = "egg-based"
            elif ph in ocbpl:
                metadf.loc[i, "passage_category"] = "cell-based other"
            else:
                metadf.loc[i, "passage_category"] = "unknown"
        
        #determine hemisphere and country of samples anyway
        for i, row in metadf.iterrows():
            l = row["Location"]
            #determine country
            try:
                country = l.split(" / ")[1]
            except:
                country = pd.NA
            country = cs[country] if country in cs.keys() and not pd.isna(country) else country
            if not pd.isna(country) and country.upper() == country:
                country = country.lower().capitalize()
            metadf.loc[i, "country"] = country
            
            #determine hemisphere
            if not pd.isna(country):
                if country in nhc:
                    metadf.loc[i, "hemisphere"] = "nh"
                elif country in shc:
                    metadf.loc[i, "hemisphere"] = "sh"
                else:
                    print (country)
                    metadf.loc[i, "hemisphere"] = pd.NA
            else:
                metadf.loc[i, "hemisphere"] = pd.NA
                        
                
        #remove duplicate strains > based on passage label hierarchy
        duplicate_strains = metadf[metadf.duplicated(subset="Isolate_Name", keep=False)]
       
        duplicate_strain_ids_to_remove = []
        
        for strain in duplicate_strains["Isolate_Name"].unique():
            l = len(duplicate_strain_ids_to_remove)
            df = duplicate_strains[duplicate_strains["Isolate_Name"]==strain]
            
            #filter on pl 
            for pl in passage_labels:
                if len(df[df["passage_category"]==pl]) == 1:
                    duplicate_strain_ids_to_remove.append(f'{df[df["passage_category"]!=pl]["Isolate_Id"].values[0]}|{df[df["passage_category"]!=pl][segment_col].values[0]}')
                    break
                #if two have the same passage category, check if hemispheres must be filtered
                elif len(df[df["passage_category"]==pl]) > 1:
                    if len(df[df["hemisphere"].isin(hemispheres)]) > 1:
                        sdf = df[df["hemisphere"].isin(hemispheres)].sort_values(["Collection_Date"])
                        duplicate_strain_ids_to_remove.append(f'{sdf["Isolate_Id"].values[0]}|{sdf[segment_col].values[0]}')
                    else:
                        duplicate_strain_ids_to_remove.append(f'{df[~df["hemisphere"].isin(hemispheres)]["Isolate_Id"].values[0]}|{df[~df["hemisphere"].isin(hemispheres)][segment_col].values[0]}')
                    break

        #remove duplicate strains from metadata
        metadf = metadf[~metadf[f"Isolate_Id|{segment_col}"].isin(duplicate_strain_ids_to_remove)]
        #remove to drop strains
        metadf = metadf[~metadf[f"Isolate_Id"].isin(itr)]

        #remove isolate id not in metadata for
        #records = [r for r in records if r.id.split("|")[0] in list(metadf["Isolate_Id"])] 
        records = records[records[f"Isolate_Id|{segment_col}"].isin(metadf[f"Isolate_Id|{segment_col}"].to_list())]

        invalid_nuc_ids = []
        #check if sequence in sequence has valid nucleotide character > if not kick it out
        for i , row in records.iterrows():
            if not all(b in valid_nucs for b in row["sequence"].upper()):
                invalid_nuc_ids.append(row["Isolate_Id"])
        records = records[~records["Isolate_Id"].isin(invalid_nuc_ids)]
        metadf = metadf[~metadf["Isolate_Id"].isin(invalid_nuc_ids)]
    
        #creating sequence merge files of all segments in the output folder
        seqdir = os.path.join(output, "sequences")
        if not os.path.isdir(seqdir):
            os.mkdir(seqdir)

        #write output 
        merge_file = os.path.join(seqdir, f"gisaid_sequences_{subtype}_{segment}.fasta")
        with open(merge_file, 'w') as fw:
            for i, row in records.iterrows():
                fw.write(f'>{row["header"]}\n{row["sequence"]}\n')
            
        print (f"finished: {strftime('%Y-%m-%d %H:%M:%S', gmtime())}")

        #write merge metadata file to rawdata folder
        print (f"creating merge file for metadata: {strftime('%Y-%m-%d %H:%M:%S', gmtime())}")
        try:
            metadf.to_csv(os.path.join(seqdir, f"metadata_gisaid_{subtype}.csv"), index=False)
        except:
            sys.stderr.write(f"Could not find metadata file(s) in {datafolder}. Check if metadata is in correct directory and in correct format")
            sys.exit(-1)
        print (f"finished: {strftime('%Y-%m-%d %H:%M:%S', gmtime())}")

    # generate file_name list
    if len(hemispheres) == 0:
        file_names = periods
    else:
        file_names = [f'{h}-{p}' for h in hemispheres for p in periods]
            

    #get snakefile 
    snakefile = os.path.join(filedir, "treason.smk")
    if not os.path.isfile(snakefile):
        sys.stderr.write(f"Error: cannot find {snakefile}.")#\nCheck if installed properly")
        sys.exit(-1)

    subsample = args.sub_sample if args.sub_sample is not None else False
    subsample_time = args.sub_sample_time if args.sub_sample_time is not None else False


    if args.HA1:
        if subtype!= "H3N2" or segment !="HA":
            sys.stderr.write(f"Error: -HA1 flag was specified but this option is only available for A/H3N2 HA")#\nCheck if installed properly")
            sys.exit(-1)
        else:
            HA1_only = True
    else:
        HA1_only = False   

    #to use as wild cards
    passage_names = [pl.replace(" ", "_") for pl in passage_categories]  

    #setup snakemake config
    config = {
        "segment":segment,
        "subtype":subtype,
        "output":output,
        "refdir":refdir,
        "periods": periods,
        "file_names":file_names, 
        "passage_categories":passage_categories, 
        "passage_names":passage_names,
        "hemispheres":hemispheres,
        'HA1_only':HA1_only, 
        "max_ambig":args.max_ambig,
        "min_length":args.min_length, 
        "subsample":subsample,
        "subsample_time":subsample_time,

        "seed": args.seed,
        "no_seed":args.no_seed,
    }

    quite_mode = args.verbose
    
    redo = True if args.redo or args.redo_all else False
    
    force_rule= args.force_rule 

    #start snakemake
    if force_rule is not None and len(force_rule) > 0:
        snakemake.snakemake(snakefile, printshellcmds=True, forceall=redo, forcerun=force_rule, config=config, cores=threads, lock=False, latency_wait=15,
                            quiet=quite_mode)
    else:
        snakemake.snakemake(snakefile, printshellcmds=True, forceall=redo, config=config, cores=threads, lock=False, latency_wait=15,
                            quiet=quite_mode)


if __name__ == "__main__":
    main()

