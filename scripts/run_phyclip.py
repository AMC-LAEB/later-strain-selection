#!/usr/bin/env python2

#script adapted from Alvin X Han, adaptations made by Annelies de Rooij

import glob, subprocess, os

threads=2 #number of threads to be used
tdir = "" #path to directory with newick versions of the molecular clock trees without node annotations
odir = "" #path to directory where output should be stored
for f in glob.glob(tdir + "/*.tree"):
    
    size=[3]
    fdr=[0.2]
    gamma=[3]
    
    with open(f+"_parameters.txt", "w") as file1:
        file1.write(f)
        for s in size:
            for fd in fdr:
                for g in gamma:
                    file1.write("\n"+str(s)+","+str(fd)+","+str(g))

    if os.path.isfile('cluster_qn_kuiper_cs3_fdr0.2_gam3.0_sol0_f0_zero-branch-length-collapsed_' + f.replace(tdir, odir).replace('.tree', '.txt')):
        continue
    
    phyclpx = subprocess.call('phyclip.py --input_file ' +f+'_parameters.txt --collapse_zero_branch_length 1 --subsume_subclusters 1 --optimise intermediate --threads ' + str(threads), shell=True)
