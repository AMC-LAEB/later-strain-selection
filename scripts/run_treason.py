#!/usr/bin/env python3 

import  os, sys
import pandas as pd
import numpy as np
from Bio import SeqIO
from datetime import date
from dateutil.relativedelta import relativedelta
from labels import *

filedir = os.path.abspath(os.path.dirname(__file__))
analysis_dir = os.path.join(filedir,"../analysis_dir")
treason_file = os.path.join(filedir, "treason.py")

threads = 12
if threads == 1:
    print ("number of threads is currently 1. It's recommended to increase the number of threads to speed up the analysis.\n")



regions = ["us", "europe", "aunz"]
region_hemispheres = {"us":"nh", "europe":"nh", "aunz":"sh"}
treason_start_month = {"nh":"February", "sh":"September"} #should match with vaccine strain selection
region_countries = {"us":us_countries, "europe":europe_countries, "aunz":aunz_countries}


pdur = 16 #period duration for treason
pp = 24 #preceeding period for treason 
full_tf = "0023" #full time frame

def main():

    #get GISAID sequence files and corresponding metadata from 
    gisaid_dir = os.path.join(filedir, "../data/gisaid_data/raw_downloads/H3N2_HA")
    if not os.path.isdir(gisaid_dir) or len(os.listdir(gisaid_dir))==0:
        sys.stderr.write(f"Error: can not find GISAID sequences")
        sys.exit(-1)

    seq_files = [os.path.join(gisaid_dir, f) for f in os.listdir(gisaid_dir) if f.endswith(".fasta")]
    metadata_files = [os.path.join(gisaid_dir, f) for f in os.listdir(gisaid_dir) if f.endswith(".xls") or f.endswith(".xlsx")]

    for f in metadata_files:
        try:
            metadf = pd.concat([metadf, pd.read_excel(f,usecols=metcols+['Host'])])
        except:
            metadf = pd.read_excel(f,usecols=metcols+['Host'])

    #filter out all sequences for which there is no complete collection date
    metadf = metadf[metadf["Host"]=="Human"]
    metadf["Collection_Date"] = pd.to_datetime(metadf["Collection_Date"], errors='coerce')
    metadf = metadf.dropna(subset=["Collection_Date"]).reset_index(drop=True)
    #also filter out sequences that have no country specification 
    metadf = metadf.drop(metadf[metadf["Location"].str.count("/") < 1].index).reset_index(drop=True)
    #add country 
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

    #read sequences
    sequences, seq_ids = {}, {}
    for f in seq_files:
        for r in SeqIO.parse(f, "fasta"):
            sequences[r.id] = r.seq
            try:
                seq_ids[r.id.split("|")[0]].append(r.id)
            except:
                seq_ids[r.id.split("|")[0]] = [r.id]
    
    
    seq_dir = os.path.join(filedir, "../data/gisaid_data/regional_sequences")
    if not os.path.isdir(seq_dir):
        os.mkdir(seq_dir)

    #create data
    for region in regions:
        if not os.path.isdir(os.path.join(seq_dir, region)):
            os.mkdir(os.path.join(seq_dir, region))
        region_seq_file = os.path.join(seq_dir, region, f"{region}_HA_{full_tf}.fasta")
        region_md_file = os.path.join(seq_dir, region, f"{region}_HA_{full_tf}.xlsx")

        #if one of the file doesnt exists > create both 
        if not os.path.isfile(region_seq_file) or not os.path.isfile(region_md_file):

            md = metadf[metadf["country"].isin(region_countries[region])]
            seqs = {}
            for rid in md["Isolate_Id"].tolist():
                rids = seq_ids[rid]
                for rid_ in rids:
                    seqs[rid_] = sequences[rid_]
                

            md.to_excel(region_md_file, index=False)
            with open(region_seq_file, "w") as fw:
                for rid, seq in seqs.items():
                    fw.write(f">{rid}\n{seq}\n")
    
    sequences = {}
    #run actual analysis 
    for region in regions:

        sm = treason_start_month[region_hemispheres[region]]
        input_dir = os.path.join(seq_dir, region)
        output_dir = os.path.join(filedir, "..", "analysis", f"{region}_{full_tf}_{sm}_pp{pp}_pd{pdur}_test")

        #early season only running HA1
        cmd = ['python', treason_file, '-s' ,"HA", '-d', input_dir , '-o', output_dir, '-tf', '2000-2012',
               '-HA1', '-pl', '"clinical, cell-based MDCK or SIAT, cell-based other"', '-pp', str(pp), 
               '-pd', str(pdur), '-ps', sm, '-t', str(threads)]
        
        os.system(" ".join(cmd))
        
        tf = "2010-2023" if region_hemispheres[region] == 'nh' else "2009-2024"
        cmd = ['python', treason_file, '-s' ,"HA", '-d', input_dir , '-o', output_dir, '-tf', tf,
                '-pl', '"clinical, cell-based MDCK or SIAT, cell-based other"', '-pp', str(pp), 
               '-pd', str(pdur), '-ps', sm, '-t', str(threads)]
        os.system(" ".join(cmd))

if __name__ == "__main__":
    main()
