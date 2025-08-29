#!/usr/bin/env python2

#script adapted from Alvin X Han, adaptations made by Annelies de Rooij

import glob, subprocess, os

threads=2 #number of threads to be used

dir_list = ["", #path to directory with US results
            "", #path to directory with Europe results
            ""] #path to directory with AU/NZ results

odir = "../analysis/phyclip_sensitivity"
#path to directory where output should be stored
if not os.path.isdir(odir):
    os.mkdir(odir)

for d in dir_list:
    tdir = os.path.join(d, "phyclip_input_trees") #path to directory with newick versions of the molecular clock trees without node annotations
    
    for f in glob.glob(tdir + "/*.tree"):
        
        size=[3, 5]
        fdr=[0.1, 0.2]
        gamma=[3]
        
        with open(f+"_parameters.txt", "w") as file1:
            file1.write(f)
            for s in size:
                for fd in fdr:
                    for g in gamma:
                        file1.write("\n"+str(s)+","+str(fd)+","+str(g))

 
        phyclpx = subprocess.call('phyclip.py --input_file ' +f+'_parameters.txt --collapse_zero_branch_length 1 --subsume_subclusters 1 --optimise intermediate --threads ' + str(threads), shell=True)
