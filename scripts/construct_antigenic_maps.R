library(Racmacs)
options(RacOptimizer.num_cores = 10)
dir <- "./data/HI_data/individual_HI_tables"
acmap_dir <- "./analysis/antigenic_comparison/antigenic_maps/complete_maps"
coords_dir <- "./analysis/antigenic_comparison/antigenic_maps/coords"

t2003_5 <- read.titerTable(file.path(dir, '2003_table5.csv'))
t2003_6 <- read.titerTable(file.path(dir, '2003_table6.csv'))
tMar2007_4 <- read.titerTable(file.path(dir, 'Mar2007_table4.csv'))
tMar2007_5 <- read.titerTable(file.path(dir, 'Mar2007_table5.csv'))
tMar2006_4 <- read.titerTable(file.path(dir, 'Mar2006_table4.csv'))
tSep2006_4 <- read.titerTable(file.path(dir, 'Sep2006_table4.csv'))
tSep2006_6 <- read.titerTable(file.path(dir, 'Sep2006_table6.csv'))
tSep2008_4A <- read.titerTable(file.path(dir, 'Sep2008_table4A.csv'))
tSep2008_4B <- read.titerTable(file.path(dir, 'Sep2008_table4B.csv'))
tSep2007_8 <- read.titerTable(file.path(dir, 'Sep2007_table8.csv'))
tSep2007_7 <- read.titerTable(file.path(dir, 'Sep2007_table7.csv'))
tSep2007_6 <- read.titerTable(file.path(dir, 'Sep2007_table6.csv'))
tFeb2009_4 <- read.titerTable(file.path(dir, 'Feb2009_table4.csv'))
tMar2008_5 <- read.titerTable(file.path(dir, 'Mar2008_table5.csv'))
tSep2009_6 <- read.titerTable(file.path(dir, 'Sep2009_table6.csv'))
tSep2010_7B <- read.titerTable(file.path(dir, 'Sep2010_table7B.csv'))
tFeb2010_13 <- read.titerTable(file.path(dir, 'Feb2010_table13.csv'))
tSep2009_5 <- read.titerTable(file.path(dir, 'Sep2009_table5.csv'))
tSep2011_18 <- read.titerTable(file.path(dir, 'Sep2011_table18.csv'))
tSep2012_9 <- read.titerTable(file.path(dir, 'Sep2012_table9.csv'))
tFeb2012_12 <- read.titerTable(file.path(dir, 'Feb2012_table12.csv'))
tFeb2012_13 <- read.titerTable(file.path(dir, 'Feb2012_table13.csv'))
tSep2012_15 <- read.titerTable(file.path(dir, 'Sep2012_table15.csv'))
tFeb2012_10 <- read.titerTable(file.path(dir, 'Feb2012_table10.csv'))
tFeb2012_14 <- read.titerTable(file.path(dir, 'Feb2012_table14.csv'))
tSep2012_18 <- read.titerTable(file.path(dir, 'Sep2012_table18.csv'))
tSep2012_17 <- read.titerTable(file.path(dir, 'Sep2012_table17.csv'))
tSep2012_12 <- read.titerTable(file.path(dir, 'Sep2012_table12.csv'))
tFeb2012_9 <- read.titerTable(file.path(dir, 'Feb2012_table9.csv'))
tSep2012_10 <- read.titerTable(file.path(dir, 'Sep2012_table10.csv'))
tSep2013_7_7 <- read.titerTable(file.path(dir, 'Sep2013_table7-7.csv'))
tSep2013_7_10 <- read.titerTable(file.path(dir, 'Sep2013_table7-10.csv'))
tFeb2013_18 <- read.titerTable(file.path(dir, 'Feb2013_table18.csv'))
tSep2013_7_16 <- read.titerTable(file.path(dir, 'Sep2013_table7-16.csv'))
tSep2013_7_11 <- read.titerTable(file.path(dir, 'Sep2013_table7-11.csv'))
tSep2012_20 <- read.titerTable(file.path(dir, 'Sep2012_table20.csv'))
tSep2013_7_12 <- read.titerTable(file.path(dir, 'Sep2013_table7-12.csv'))
tSep2013_7_9 <- read.titerTable(file.path(dir, 'Sep2013_table7-9.csv'))
tFeb2013_20 <- read.titerTable(file.path(dir, 'Feb2013_table20.csv'))
tFeb2014_9_8 <- read.titerTable(file.path(dir, 'Feb2014_table9-8.csv'))
tSep2013_7_8 <- read.titerTable(file.path(dir, 'Sep2013_table7-8.csv'))
tFeb2014_9_2 <- read.titerTable(file.path(dir, 'Feb2014_table9-2.csv'))
tSep2014_8_10 <- read.titerTable(file.path(dir, 'Sep2014_table8-10.csv'))
tSep2014_8_14 <- read.titerTable(file.path(dir, 'Sep2014_table8-14.csv'))
tFeb2014_9_7 <- read.titerTable(file.path(dir, 'Feb2014_table9-7.csv'))
tFeb2015_9_10 <- read.titerTable(file.path(dir, 'Feb2015_table9-10.csv'))
tFeb2015_9_4 <- read.titerTable(file.path(dir, 'Feb2015_table9-4.csv'))
tSep2014_8_18 <- read.titerTable(file.path(dir, 'Sep2014_table8-18.csv'))
tSep2015_8_9 <- read.titerTable(file.path(dir, 'Sep2015_table8-9.csv'))
tSep2014_8_19 <- read.titerTable(file.path(dir, 'Sep2014_table8-19.csv'))
tSep2017_8_13 <- read.titerTable(file.path(dir, 'Sep2017_table8-13.csv'))
tSep2017_8_12 <- read.titerTable(file.path(dir, 'Sep2017_table8-12.csv'))
tSep2016_8_6 <- read.titerTable(file.path(dir, 'Sep2016_table8-6.csv'))
tSep2016_8_2 <- read.titerTable(file.path(dir, 'Sep2016_table8-2.csv'))
tFeb2016_9_3 <- read.titerTable(file.path(dir, 'Feb2016_table9-3.csv'))
tFeb2017_8_5 <- read.titerTable(file.path(dir, 'Feb2017_table8-5.csv'))
tSep2017_8_16 <- read.titerTable(file.path(dir, 'Sep2017_table8-16.csv'))
tSep2017_8_2 <- read.titerTable(file.path(dir, 'Sep2017_table8-2.csv'))
tSep2016_8_7 <- read.titerTable(file.path(dir, 'Sep2016_table8-7.csv'))
tFeb2018_8_3 <- read.titerTable(file.path(dir, 'Feb2018_table8-3.csv'))
tSep2018_8_5 <- read.titerTable(file.path(dir, 'Sep2018_table8-5.csv'))
tSep2017_8_20 <- read.titerTable(file.path(dir, 'Sep2017_table8-20.csv'))
tFeb2018_8_9 <- read.titerTable(file.path(dir, 'Feb2018_table8-9.csv'))
tFeb2020_7_11 <- read.titerTable(file.path(dir, 'Feb2020_table7-11.csv'))
tSep2019_8_3 <- read.titerTable(file.path(dir, 'Sep2019_table8-3.csv'))
tFeb2019_8_9 <- read.titerTable(file.path(dir, 'Feb2019_table8-9.csv'))
tSep2017_21 <- read.titerTable(file.path(dir, 'Sep2017_table21.csv'))
tFeb2021_7_2 <- read.titerTable(file.path(dir, 'Feb2021_table7-2.csv'))
tSep2019_8_1 <- read.titerTable(file.path(dir, 'Sep2019_table8-1.csv'))
tSep2020_7_2 <- read.titerTable(file.path(dir, 'Sep2020_table7-2.csv'))
tSep2019_8_18 <- read.titerTable(file.path(dir, 'Sep2019_table8-18.csv'))
tSep2019_8_14 <- read.titerTable(file.path(dir, 'Sep2019_table8-14.csv'))
tSep2020_7_1 <- read.titerTable(file.path(dir, 'Sep2020_table7-1.csv'))
tFeb2019_8_11 <- read.titerTable(file.path(dir, 'Feb2019_table8-11.csv'))
tSep2020_7_7 <- read.titerTable(file.path(dir, 'Sep2020_table7-7.csv'))
tSep2019_8_19 <- read.titerTable(file.path(dir, 'Sep2019_table8-19.csv'))
tSep2019_8_16 <- read.titerTable(file.path(dir, 'Sep2019_table8-16.csv'))
tSep2021_7_4 <- read.titerTable(file.path(dir, 'Sep2021_table7-4.csv'))
tFeb2022_9_1 <- read.titerTable(file.path(dir, 'Feb2022_table9-1.csv'))
tSep2021_7_7 <- read.titerTable(file.path(dir, 'Sep2021_table7-7.csv'))
tSep2022_10_6 <- read.titerTable(file.path(dir, 'Sep2022_table10-6.csv'))
tSep2022_10_20 <- read.titerTable(file.path(dir, 'Sep2022_table10-20.csv'))
tSep2021_7_1 <- read.titerTable(file.path(dir, 'Sep2021_table7-1.csv'))
tSep2021_7_6 <- read.titerTable(file.path(dir, 'Sep2021_table7-6.csv'))
tFeb2022_9_10 <- read.titerTable(file.path(dir, 'Feb2022_table9-10.csv'))
tSep2022_10_18 <- read.titerTable(file.path(dir, 'Sep2022_table10-18.csv'))
tFeb2022_9_2 <- read.titerTable(file.path(dir, 'Feb2022_table9-2.csv'))
tFeb2023_H3_10 <- read.titerTable(file.path(dir, 'Feb2023_tableH3-10.csv'))
tSep2023_H3_12 <- read.titerTable(file.path(dir, 'Sep2023_tableH3-12.csv'))
tSep2022_10_12 <- read.titerTable(file.path(dir, 'Sep2022_table10-12.csv'))
tSep2023_H3_1 <- read.titerTable(file.path(dir, 'Sep2023_tableH3-1.csv'))
tSep2022_10_25 <- read.titerTable(file.path(dir, 'Sep2022_table10-25.csv'))
tSep2022_10_10 <- read.titerTable(file.path(dir, 'Sep2022_table10-10.csv'))
t2004_5 <- read.titerTable(file.path(dir, '2004_table5.csv'))
tSep2006_3 <- read.titerTable(file.path(dir, 'Sep2006_table3.csv'))
tSep2006_5 <- read.titerTable(file.path(dir, 'Sep2006_table5.csv'))
tSep2007_5 <- read.titerTable(file.path(dir, 'Sep2007_table5.csv'))
tFeb2009_5 <- read.titerTable(file.path(dir, 'Feb2009_table5.csv'))
tFeb2013_13 <- read.titerTable(file.path(dir, 'Feb2013_table13.csv'))
tFeb2012_8 <- read.titerTable(file.path(dir, 'Feb2012_table8.csv'))
tSep2013_7_3 <- read.titerTable(file.path(dir, 'Sep2013_table7-3.csv'))
tSep2014_8_11 <- read.titerTable(file.path(dir, 'Sep2014_table8-11.csv'))
tSep2014_8_16 <- read.titerTable(file.path(dir, 'Sep2014_table8-16.csv'))
tFeb2016_9_2 <- read.titerTable(file.path(dir, 'Feb2016_table9-2.csv'))
tSep2015_8_4 <- read.titerTable(file.path(dir, 'Sep2015_table8-4.csv'))
tSep2015_8_13 <- read.titerTable(file.path(dir, 'Sep2015_table8-13.csv'))
tSep2015_8_6 <- read.titerTable(file.path(dir, 'Sep2015_table8-6.csv'))
tSep2015_8_8 <- read.titerTable(file.path(dir, 'Sep2015_table8-8.csv'))
tFeb2017_8_2 <- read.titerTable(file.path(dir, 'Feb2017_table8-2.csv'))
tSep2016_8_9 <- read.titerTable(file.path(dir, 'Sep2016_table8-9.csv'))
tFeb2019_8_5 <- read.titerTable(file.path(dir, 'Feb2019_table8-5.csv'))
tFeb2018_8_4 <- read.titerTable(file.path(dir, 'Feb2018_table8-4.csv'))
tSep2018_8_6 <- read.titerTable(file.path(dir, 'Sep2018_table8-6.csv'))
tFeb2018_8_6 <- read.titerTable(file.path(dir, 'Feb2018_table8-6.csv'))
tSep2018_8_7 <- read.titerTable(file.path(dir, 'Sep2018_table8-7.csv'))
tSep2018_8_2 <- read.titerTable(file.path(dir, 'Sep2018_table8-2.csv'))
tFeb2020_7_12 <- read.titerTable(file.path(dir, 'Feb2020_table7-12.csv'))
tSep2019_8_15 <- read.titerTable(file.path(dir, 'Sep2019_table8-15.csv'))
tSep2019_8_6 <- read.titerTable(file.path(dir, 'Sep2019_table8-6.csv'))
tSep2019_8_7 <- read.titerTable(file.path(dir, 'Sep2019_table8-7.csv'))
tSep2019_8_17 <- read.titerTable(file.path(dir, 'Sep2019_table8-17.csv'))
tFeb2019_8_10 <- read.titerTable(file.path(dir, 'Feb2019_table8-10.csv'))
tSep2019_8_13 <- read.titerTable(file.path(dir, 'Sep2019_table8-13.csv'))
tSep2019_8_5 <- read.titerTable(file.path(dir, 'Sep2019_table8-5.csv'))
tFeb2020_7_5 <- read.titerTable(file.path(dir, 'Feb2020_table7-5.csv'))
tFeb2021_7_3 <- read.titerTable(file.path(dir, 'Feb2021_table7-3.csv'))
tSep2020_7_9 <- read.titerTable(file.path(dir, 'Sep2020_table7-9.csv'))
tSep2021_7_5 <- read.titerTable(file.path(dir, 'Sep2021_table7-5.csv'))
tSep2021_7_10 <- read.titerTable(file.path(dir, 'Sep2021_table7-10.csv'))
tSep2022_10_17 <- read.titerTable(file.path(dir, 'Sep2022_table10-17.csv'))
tFeb2022_9_9 <- read.titerTable(file.path(dir, 'Feb2022_table9-9.csv'))
tFeb2022_9_7 <- read.titerTable(file.path(dir, 'Feb2022_table9-7.csv'))
tFeb2022_9_11 <- read.titerTable(file.path(dir, 'Feb2022_table9-11.csv'))
tSep2022_10_8 <- read.titerTable(file.path(dir, 'Sep2022_table10-8.csv'))
tFeb2023_H3_1 <- read.titerTable(file.path(dir, 'Feb2023_tableH3-1.csv'))
tSep2022_10_19 <- read.titerTable(file.path(dir, 'Sep2022_table10-19.csv'))
tSep2022_10_16 <- read.titerTable(file.path(dir, 'Sep2022_table10-16.csv'))
tFeb2010_12 <- read.titerTable(file.path(dir, 'Feb2010_table12.csv'))
tFeb2012_11 <- read.titerTable(file.path(dir, 'Feb2012_table11.csv'))
tSep2014_8_13 <- read.titerTable(file.path(dir, 'Sep2014_table8-13.csv'))
tFeb2015_9_3 <- read.titerTable(file.path(dir, 'Feb2015_table9-3.csv'))
tFeb2014_9_6 <- read.titerTable(file.path(dir, 'Feb2014_table9-6.csv'))
tFeb2015_9_2 <- read.titerTable(file.path(dir, 'Feb2015_table9-2.csv'))
tFeb2019_8_7 <- read.titerTable(file.path(dir, 'Feb2019_table8-7.csv'))
tSep2019_8_11 <- read.titerTable(file.path(dir, 'Sep2019_table8-11.csv'))
tSep2021_7_9 <- read.titerTable(file.path(dir, 'Sep2021_table7-9.csv'))
tSep2020_7_5 <- read.titerTable(file.path(dir, 'Sep2020_table7-5.csv'))
tFeb2022_9_6 <- read.titerTable(file.path(dir, 'Feb2022_table9-6.csv'))
tFeb2022_9_8 <- read.titerTable(file.path(dir, 'Feb2022_table9-8.csv'))

#load individual maps
map2003_5 <- acmap( titer_table=t2003_5, sr_names=colnames(t2003_5), ag_names=rownames(t2003_5))

map2003_6 <- acmap( titer_table=t2003_6, sr_names=colnames(t2003_6), ag_names=rownames(t2003_6))

mapMar2007_4 <- acmap( titer_table=tMar2007_4, sr_names=colnames(tMar2007_4), ag_names=rownames(tMar2007_4))

mapMar2007_5 <- acmap( titer_table=tMar2007_5, sr_names=colnames(tMar2007_5), ag_names=rownames(tMar2007_5))

mapMar2006_4 <- acmap( titer_table=tMar2006_4, sr_names=colnames(tMar2006_4), ag_names=rownames(tMar2006_4))

mapSep2006_4 <- acmap( titer_table=tSep2006_4, sr_names=colnames(tSep2006_4), ag_names=rownames(tSep2006_4))

mapSep2006_6 <- acmap( titer_table=tSep2006_6, sr_names=colnames(tSep2006_6), ag_names=rownames(tSep2006_6))

mapSep2008_4A <- acmap( titer_table=tSep2008_4A, sr_names=colnames(tSep2008_4A), ag_names=rownames(tSep2008_4A))

mapSep2008_4B <- acmap( titer_table=tSep2008_4B, sr_names=colnames(tSep2008_4B), ag_names=rownames(tSep2008_4B))

mapSep2007_8 <- acmap( titer_table=tSep2007_8, sr_names=colnames(tSep2007_8), ag_names=rownames(tSep2007_8))

mapSep2007_7 <- acmap( titer_table=tSep2007_7, sr_names=colnames(tSep2007_7), ag_names=rownames(tSep2007_7))

mapSep2007_6 <- acmap( titer_table=tSep2007_6, sr_names=colnames(tSep2007_6), ag_names=rownames(tSep2007_6))

mapFeb2009_4 <- acmap( titer_table=tFeb2009_4, sr_names=colnames(tFeb2009_4), ag_names=rownames(tFeb2009_4))

mapMar2008_5 <- acmap( titer_table=tMar2008_5, sr_names=colnames(tMar2008_5), ag_names=rownames(tMar2008_5))

mapSep2009_6 <- acmap( titer_table=tSep2009_6, sr_names=colnames(tSep2009_6), ag_names=rownames(tSep2009_6))

mapSep2010_7B <- acmap( titer_table=tSep2010_7B, sr_names=colnames(tSep2010_7B), ag_names=rownames(tSep2010_7B))

mapFeb2010_13 <- acmap( titer_table=tFeb2010_13, sr_names=colnames(tFeb2010_13), ag_names=rownames(tFeb2010_13))

mapSep2009_5 <- acmap( titer_table=tSep2009_5, sr_names=colnames(tSep2009_5), ag_names=rownames(tSep2009_5))

mapSep2011_18 <- acmap( titer_table=tSep2011_18, sr_names=colnames(tSep2011_18), ag_names=rownames(tSep2011_18))

mapSep2012_9 <- acmap( titer_table=tSep2012_9, sr_names=colnames(tSep2012_9), ag_names=rownames(tSep2012_9))

mapFeb2012_12 <- acmap( titer_table=tFeb2012_12, sr_names=colnames(tFeb2012_12), ag_names=rownames(tFeb2012_12))

mapFeb2012_13 <- acmap( titer_table=tFeb2012_13, sr_names=colnames(tFeb2012_13), ag_names=rownames(tFeb2012_13))

mapSep2012_15 <- acmap( titer_table=tSep2012_15, sr_names=colnames(tSep2012_15), ag_names=rownames(tSep2012_15))

mapFeb2012_10 <- acmap( titer_table=tFeb2012_10, sr_names=colnames(tFeb2012_10), ag_names=rownames(tFeb2012_10))

mapFeb2012_14 <- acmap( titer_table=tFeb2012_14, sr_names=colnames(tFeb2012_14), ag_names=rownames(tFeb2012_14))

mapSep2012_18 <- acmap( titer_table=tSep2012_18, sr_names=colnames(tSep2012_18), ag_names=rownames(tSep2012_18))

mapSep2012_17 <- acmap( titer_table=tSep2012_17, sr_names=colnames(tSep2012_17), ag_names=rownames(tSep2012_17))

mapSep2012_12 <- acmap( titer_table=tSep2012_12, sr_names=colnames(tSep2012_12), ag_names=rownames(tSep2012_12))

mapFeb2012_9 <- acmap( titer_table=tFeb2012_9, sr_names=colnames(tFeb2012_9), ag_names=rownames(tFeb2012_9))

mapSep2012_10 <- acmap( titer_table=tSep2012_10, sr_names=colnames(tSep2012_10), ag_names=rownames(tSep2012_10))

mapSep2013_7_7 <- acmap( titer_table=tSep2013_7_7, sr_names=colnames(tSep2013_7_7), ag_names=rownames(tSep2013_7_7))

mapSep2013_7_10 <- acmap( titer_table=tSep2013_7_10, sr_names=colnames(tSep2013_7_10), ag_names=rownames(tSep2013_7_10))

mapFeb2013_18 <- acmap( titer_table=tFeb2013_18, sr_names=colnames(tFeb2013_18), ag_names=rownames(tFeb2013_18))

mapSep2013_7_16 <- acmap( titer_table=tSep2013_7_16, sr_names=colnames(tSep2013_7_16), ag_names=rownames(tSep2013_7_16))

mapSep2013_7_11 <- acmap( titer_table=tSep2013_7_11, sr_names=colnames(tSep2013_7_11), ag_names=rownames(tSep2013_7_11))

mapSep2012_20 <- acmap( titer_table=tSep2012_20, sr_names=colnames(tSep2012_20), ag_names=rownames(tSep2012_20))

mapSep2013_7_12 <- acmap( titer_table=tSep2013_7_12, sr_names=colnames(tSep2013_7_12), ag_names=rownames(tSep2013_7_12))

mapSep2013_7_9 <- acmap( titer_table=tSep2013_7_9, sr_names=colnames(tSep2013_7_9), ag_names=rownames(tSep2013_7_9))

mapFeb2013_20 <- acmap( titer_table=tFeb2013_20, sr_names=colnames(tFeb2013_20), ag_names=rownames(tFeb2013_20))

mapFeb2014_9_8 <- acmap( titer_table=tFeb2014_9_8, sr_names=colnames(tFeb2014_9_8), ag_names=rownames(tFeb2014_9_8))

mapSep2013_7_8 <- acmap( titer_table=tSep2013_7_8, sr_names=colnames(tSep2013_7_8), ag_names=rownames(tSep2013_7_8))

mapFeb2014_9_2 <- acmap( titer_table=tFeb2014_9_2, sr_names=colnames(tFeb2014_9_2), ag_names=rownames(tFeb2014_9_2))

mapSep2014_8_10 <- acmap( titer_table=tSep2014_8_10, sr_names=colnames(tSep2014_8_10), ag_names=rownames(tSep2014_8_10))

mapSep2014_8_14 <- acmap( titer_table=tSep2014_8_14, sr_names=colnames(tSep2014_8_14), ag_names=rownames(tSep2014_8_14))

mapFeb2014_9_7 <- acmap( titer_table=tFeb2014_9_7, sr_names=colnames(tFeb2014_9_7), ag_names=rownames(tFeb2014_9_7))

mapFeb2015_9_10 <- acmap( titer_table=tFeb2015_9_10, sr_names=colnames(tFeb2015_9_10), ag_names=rownames(tFeb2015_9_10))

mapFeb2015_9_4 <- acmap( titer_table=tFeb2015_9_4, sr_names=colnames(tFeb2015_9_4), ag_names=rownames(tFeb2015_9_4))

mapSep2014_8_18 <- acmap( titer_table=tSep2014_8_18, sr_names=colnames(tSep2014_8_18), ag_names=rownames(tSep2014_8_18))

mapSep2015_8_9 <- acmap( titer_table=tSep2015_8_9, sr_names=colnames(tSep2015_8_9), ag_names=rownames(tSep2015_8_9))

mapSep2014_8_19 <- acmap( titer_table=tSep2014_8_19, sr_names=colnames(tSep2014_8_19), ag_names=rownames(tSep2014_8_19))

mapSep2017_8_13 <- acmap( titer_table=tSep2017_8_13, sr_names=colnames(tSep2017_8_13), ag_names=rownames(tSep2017_8_13))

mapSep2017_8_12 <- acmap( titer_table=tSep2017_8_12, sr_names=colnames(tSep2017_8_12), ag_names=rownames(tSep2017_8_12))

mapSep2016_8_6 <- acmap( titer_table=tSep2016_8_6, sr_names=colnames(tSep2016_8_6), ag_names=rownames(tSep2016_8_6))

mapSep2016_8_2 <- acmap( titer_table=tSep2016_8_2, sr_names=colnames(tSep2016_8_2), ag_names=rownames(tSep2016_8_2))

mapFeb2016_9_3 <- acmap( titer_table=tFeb2016_9_3, sr_names=colnames(tFeb2016_9_3), ag_names=rownames(tFeb2016_9_3))

mapFeb2017_8_5 <- acmap( titer_table=tFeb2017_8_5, sr_names=colnames(tFeb2017_8_5), ag_names=rownames(tFeb2017_8_5))

mapSep2017_8_16 <- acmap( titer_table=tSep2017_8_16, sr_names=colnames(tSep2017_8_16), ag_names=rownames(tSep2017_8_16))

mapSep2017_8_2 <- acmap( titer_table=tSep2017_8_2, sr_names=colnames(tSep2017_8_2), ag_names=rownames(tSep2017_8_2))

mapSep2016_8_7 <- acmap( titer_table=tSep2016_8_7, sr_names=colnames(tSep2016_8_7), ag_names=rownames(tSep2016_8_7))

mapFeb2018_8_3 <- acmap( titer_table=tFeb2018_8_3, sr_names=colnames(tFeb2018_8_3), ag_names=rownames(tFeb2018_8_3))

mapSep2018_8_5 <- acmap( titer_table=tSep2018_8_5, sr_names=colnames(tSep2018_8_5), ag_names=rownames(tSep2018_8_5))

mapSep2017_8_20 <- acmap( titer_table=tSep2017_8_20, sr_names=colnames(tSep2017_8_20), ag_names=rownames(tSep2017_8_20))

mapFeb2018_8_9 <- acmap( titer_table=tFeb2018_8_9, sr_names=colnames(tFeb2018_8_9), ag_names=rownames(tFeb2018_8_9))

mapFeb2020_7_11 <- acmap( titer_table=tFeb2020_7_11, sr_names=colnames(tFeb2020_7_11), ag_names=rownames(tFeb2020_7_11))

mapSep2019_8_3 <- acmap( titer_table=tSep2019_8_3, sr_names=colnames(tSep2019_8_3), ag_names=rownames(tSep2019_8_3))

mapFeb2019_8_9 <- acmap( titer_table=tFeb2019_8_9, sr_names=colnames(tFeb2019_8_9), ag_names=rownames(tFeb2019_8_9))

mapSep2017_21 <- acmap( titer_table=tSep2017_21, sr_names=colnames(tSep2017_21), ag_names=rownames(tSep2017_21))

mapFeb2021_7_2 <- acmap( titer_table=tFeb2021_7_2, sr_names=colnames(tFeb2021_7_2), ag_names=rownames(tFeb2021_7_2))

mapSep2019_8_1 <- acmap( titer_table=tSep2019_8_1, sr_names=colnames(tSep2019_8_1), ag_names=rownames(tSep2019_8_1))

mapSep2020_7_2 <- acmap( titer_table=tSep2020_7_2, sr_names=colnames(tSep2020_7_2), ag_names=rownames(tSep2020_7_2))

mapSep2019_8_18 <- acmap( titer_table=tSep2019_8_18, sr_names=colnames(tSep2019_8_18), ag_names=rownames(tSep2019_8_18))

mapSep2019_8_14 <- acmap( titer_table=tSep2019_8_14, sr_names=colnames(tSep2019_8_14), ag_names=rownames(tSep2019_8_14))

mapSep2020_7_1 <- acmap( titer_table=tSep2020_7_1, sr_names=colnames(tSep2020_7_1), ag_names=rownames(tSep2020_7_1))

mapFeb2019_8_11 <- acmap( titer_table=tFeb2019_8_11, sr_names=colnames(tFeb2019_8_11), ag_names=rownames(tFeb2019_8_11))

mapSep2020_7_7 <- acmap( titer_table=tSep2020_7_7, sr_names=colnames(tSep2020_7_7), ag_names=rownames(tSep2020_7_7))

mapSep2019_8_19 <- acmap( titer_table=tSep2019_8_19, sr_names=colnames(tSep2019_8_19), ag_names=rownames(tSep2019_8_19))

mapSep2019_8_16 <- acmap( titer_table=tSep2019_8_16, sr_names=colnames(tSep2019_8_16), ag_names=rownames(tSep2019_8_16))

mapSep2021_7_4 <- acmap( titer_table=tSep2021_7_4, sr_names=colnames(tSep2021_7_4), ag_names=rownames(tSep2021_7_4))

mapFeb2022_9_1 <- acmap( titer_table=tFeb2022_9_1, sr_names=colnames(tFeb2022_9_1), ag_names=rownames(tFeb2022_9_1))

mapSep2021_7_7 <- acmap( titer_table=tSep2021_7_7, sr_names=colnames(tSep2021_7_7), ag_names=rownames(tSep2021_7_7))

mapSep2022_10_6 <- acmap( titer_table=tSep2022_10_6, sr_names=colnames(tSep2022_10_6), ag_names=rownames(tSep2022_10_6))

mapSep2022_10_20 <- acmap( titer_table=tSep2022_10_20, sr_names=colnames(tSep2022_10_20), ag_names=rownames(tSep2022_10_20))

mapSep2021_7_1 <- acmap( titer_table=tSep2021_7_1, sr_names=colnames(tSep2021_7_1), ag_names=rownames(tSep2021_7_1))

mapSep2021_7_6 <- acmap( titer_table=tSep2021_7_6, sr_names=colnames(tSep2021_7_6), ag_names=rownames(tSep2021_7_6))

mapFeb2022_9_10 <- acmap( titer_table=tFeb2022_9_10, sr_names=colnames(tFeb2022_9_10), ag_names=rownames(tFeb2022_9_10))

mapSep2022_10_18 <- acmap( titer_table=tSep2022_10_18, sr_names=colnames(tSep2022_10_18), ag_names=rownames(tSep2022_10_18))

mapFeb2022_9_2 <- acmap( titer_table=tFeb2022_9_2, sr_names=colnames(tFeb2022_9_2), ag_names=rownames(tFeb2022_9_2))

mapFeb2023_H3_10 <- acmap( titer_table=tFeb2023_H3_10, sr_names=colnames(tFeb2023_H3_10), ag_names=rownames(tFeb2023_H3_10))

mapSep2023_H3_12 <- acmap( titer_table=tSep2023_H3_12, sr_names=colnames(tSep2023_H3_12), ag_names=rownames(tSep2023_H3_12))

mapSep2022_10_12 <- acmap( titer_table=tSep2022_10_12, sr_names=colnames(tSep2022_10_12), ag_names=rownames(tSep2022_10_12))

mapSep2023_H3_1 <- acmap( titer_table=tSep2023_H3_1, sr_names=colnames(tSep2023_H3_1), ag_names=rownames(tSep2023_H3_1))

mapSep2022_10_25 <- acmap( titer_table=tSep2022_10_25, sr_names=colnames(tSep2022_10_25), ag_names=rownames(tSep2022_10_25))

mapSep2022_10_10 <- acmap( titer_table=tSep2022_10_10, sr_names=colnames(tSep2022_10_10), ag_names=rownames(tSep2022_10_10))

map2004_5 <- acmap( titer_table=t2004_5, sr_names=colnames(t2004_5), ag_names=rownames(t2004_5))

mapSep2006_3 <- acmap( titer_table=tSep2006_3, sr_names=colnames(tSep2006_3), ag_names=rownames(tSep2006_3))

mapSep2006_5 <- acmap( titer_table=tSep2006_5, sr_names=colnames(tSep2006_5), ag_names=rownames(tSep2006_5))

mapSep2007_5 <- acmap( titer_table=tSep2007_5, sr_names=colnames(tSep2007_5), ag_names=rownames(tSep2007_5))

mapFeb2009_5 <- acmap( titer_table=tFeb2009_5, sr_names=colnames(tFeb2009_5), ag_names=rownames(tFeb2009_5))

mapFeb2013_13 <- acmap( titer_table=tFeb2013_13, sr_names=colnames(tFeb2013_13), ag_names=rownames(tFeb2013_13))

mapFeb2012_8 <- acmap( titer_table=tFeb2012_8, sr_names=colnames(tFeb2012_8), ag_names=rownames(tFeb2012_8))

mapSep2013_7_3 <- acmap( titer_table=tSep2013_7_3, sr_names=colnames(tSep2013_7_3), ag_names=rownames(tSep2013_7_3))

mapSep2014_8_11 <- acmap( titer_table=tSep2014_8_11, sr_names=colnames(tSep2014_8_11), ag_names=rownames(tSep2014_8_11))

mapSep2014_8_16 <- acmap( titer_table=tSep2014_8_16, sr_names=colnames(tSep2014_8_16), ag_names=rownames(tSep2014_8_16))

mapFeb2016_9_2 <- acmap( titer_table=tFeb2016_9_2, sr_names=colnames(tFeb2016_9_2), ag_names=rownames(tFeb2016_9_2))

mapSep2015_8_4 <- acmap( titer_table=tSep2015_8_4, sr_names=colnames(tSep2015_8_4), ag_names=rownames(tSep2015_8_4))

mapSep2015_8_13 <- acmap( titer_table=tSep2015_8_13, sr_names=colnames(tSep2015_8_13), ag_names=rownames(tSep2015_8_13))

mapSep2015_8_6 <- acmap( titer_table=tSep2015_8_6, sr_names=colnames(tSep2015_8_6), ag_names=rownames(tSep2015_8_6))

mapSep2015_8_8 <- acmap( titer_table=tSep2015_8_8, sr_names=colnames(tSep2015_8_8), ag_names=rownames(tSep2015_8_8))

mapFeb2017_8_2 <- acmap( titer_table=tFeb2017_8_2, sr_names=colnames(tFeb2017_8_2), ag_names=rownames(tFeb2017_8_2))

mapSep2016_8_9 <- acmap( titer_table=tSep2016_8_9, sr_names=colnames(tSep2016_8_9), ag_names=rownames(tSep2016_8_9))

mapFeb2019_8_5 <- acmap( titer_table=tFeb2019_8_5, sr_names=colnames(tFeb2019_8_5), ag_names=rownames(tFeb2019_8_5))

mapFeb2018_8_4 <- acmap( titer_table=tFeb2018_8_4, sr_names=colnames(tFeb2018_8_4), ag_names=rownames(tFeb2018_8_4))

mapSep2018_8_6 <- acmap( titer_table=tSep2018_8_6, sr_names=colnames(tSep2018_8_6), ag_names=rownames(tSep2018_8_6))

mapFeb2018_8_6 <- acmap( titer_table=tFeb2018_8_6, sr_names=colnames(tFeb2018_8_6), ag_names=rownames(tFeb2018_8_6))

mapSep2018_8_7 <- acmap( titer_table=tSep2018_8_7, sr_names=colnames(tSep2018_8_7), ag_names=rownames(tSep2018_8_7))

mapSep2018_8_2 <- acmap( titer_table=tSep2018_8_2, sr_names=colnames(tSep2018_8_2), ag_names=rownames(tSep2018_8_2))

mapFeb2020_7_12 <- acmap( titer_table=tFeb2020_7_12, sr_names=colnames(tFeb2020_7_12), ag_names=rownames(tFeb2020_7_12))

mapSep2019_8_15 <- acmap( titer_table=tSep2019_8_15, sr_names=colnames(tSep2019_8_15), ag_names=rownames(tSep2019_8_15))

mapSep2019_8_6 <- acmap( titer_table=tSep2019_8_6, sr_names=colnames(tSep2019_8_6), ag_names=rownames(tSep2019_8_6))

mapSep2019_8_7 <- acmap( titer_table=tSep2019_8_7, sr_names=colnames(tSep2019_8_7), ag_names=rownames(tSep2019_8_7))

mapSep2019_8_17 <- acmap( titer_table=tSep2019_8_17, sr_names=colnames(tSep2019_8_17), ag_names=rownames(tSep2019_8_17))

mapFeb2019_8_10 <- acmap( titer_table=tFeb2019_8_10, sr_names=colnames(tFeb2019_8_10), ag_names=rownames(tFeb2019_8_10))

mapSep2019_8_13 <- acmap( titer_table=tSep2019_8_13, sr_names=colnames(tSep2019_8_13), ag_names=rownames(tSep2019_8_13))

mapSep2019_8_5 <- acmap( titer_table=tSep2019_8_5, sr_names=colnames(tSep2019_8_5), ag_names=rownames(tSep2019_8_5))

mapFeb2020_7_5 <- acmap( titer_table=tFeb2020_7_5, sr_names=colnames(tFeb2020_7_5), ag_names=rownames(tFeb2020_7_5))

mapFeb2021_7_3 <- acmap( titer_table=tFeb2021_7_3, sr_names=colnames(tFeb2021_7_3), ag_names=rownames(tFeb2021_7_3))

mapSep2020_7_9 <- acmap( titer_table=tSep2020_7_9, sr_names=colnames(tSep2020_7_9), ag_names=rownames(tSep2020_7_9))

mapSep2021_7_5 <- acmap( titer_table=tSep2021_7_5, sr_names=colnames(tSep2021_7_5), ag_names=rownames(tSep2021_7_5))

mapSep2021_7_10 <- acmap( titer_table=tSep2021_7_10, sr_names=colnames(tSep2021_7_10), ag_names=rownames(tSep2021_7_10))

mapSep2022_10_17 <- acmap( titer_table=tSep2022_10_17, sr_names=colnames(tSep2022_10_17), ag_names=rownames(tSep2022_10_17))

mapFeb2022_9_9 <- acmap( titer_table=tFeb2022_9_9, sr_names=colnames(tFeb2022_9_9), ag_names=rownames(tFeb2022_9_9))

mapFeb2022_9_7 <- acmap( titer_table=tFeb2022_9_7, sr_names=colnames(tFeb2022_9_7), ag_names=rownames(tFeb2022_9_7))

mapFeb2022_9_11 <- acmap( titer_table=tFeb2022_9_11, sr_names=colnames(tFeb2022_9_11), ag_names=rownames(tFeb2022_9_11))

mapSep2022_10_8 <- acmap( titer_table=tSep2022_10_8, sr_names=colnames(tSep2022_10_8), ag_names=rownames(tSep2022_10_8))

mapFeb2023_H3_1 <- acmap( titer_table=tFeb2023_H3_1, sr_names=colnames(tFeb2023_H3_1), ag_names=rownames(tFeb2023_H3_1))

mapSep2022_10_19 <- acmap( titer_table=tSep2022_10_19, sr_names=colnames(tSep2022_10_19), ag_names=rownames(tSep2022_10_19))

mapSep2022_10_16 <- acmap( titer_table=tSep2022_10_16, sr_names=colnames(tSep2022_10_16), ag_names=rownames(tSep2022_10_16))

mapFeb2010_12 <- acmap( titer_table=tFeb2010_12, sr_names=colnames(tFeb2010_12), ag_names=rownames(tFeb2010_12))

mapFeb2012_11 <- acmap( titer_table=tFeb2012_11, sr_names=colnames(tFeb2012_11), ag_names=rownames(tFeb2012_11))

mapSep2014_8_13 <- acmap( titer_table=tSep2014_8_13, sr_names=colnames(tSep2014_8_13), ag_names=rownames(tSep2014_8_13))

mapFeb2015_9_3 <- acmap( titer_table=tFeb2015_9_3, sr_names=colnames(tFeb2015_9_3), ag_names=rownames(tFeb2015_9_3))

mapFeb2014_9_6 <- acmap( titer_table=tFeb2014_9_6, sr_names=colnames(tFeb2014_9_6), ag_names=rownames(tFeb2014_9_6))

mapFeb2015_9_2 <- acmap( titer_table=tFeb2015_9_2, sr_names=colnames(tFeb2015_9_2), ag_names=rownames(tFeb2015_9_2))

mapFeb2019_8_7 <- acmap( titer_table=tFeb2019_8_7, sr_names=colnames(tFeb2019_8_7), ag_names=rownames(tFeb2019_8_7))

mapSep2019_8_11 <- acmap( titer_table=tSep2019_8_11, sr_names=colnames(tSep2019_8_11), ag_names=rownames(tSep2019_8_11))

mapSep2021_7_9 <- acmap( titer_table=tSep2021_7_9, sr_names=colnames(tSep2021_7_9), ag_names=rownames(tSep2021_7_9))

mapSep2020_7_5 <- acmap( titer_table=tSep2020_7_5, sr_names=colnames(tSep2020_7_5), ag_names=rownames(tSep2020_7_5))

mapFeb2022_9_6 <- acmap( titer_table=tFeb2022_9_6, sr_names=colnames(tFeb2022_9_6), ag_names=rownames(tFeb2022_9_6))

mapFeb2022_9_8 <- acmap( titer_table=tFeb2022_9_8, sr_names=colnames(tFeb2022_9_8), ag_names=rownames(tFeb2022_9_8))

map1 <- mergeMaps(map2003_5, map2003_6, method='table', number_of_dimensions = 2)
map1 <- optimizeMap(map = map1, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map1, file.path(acmap_dir, 'map1.ace'))
save.coords(map1, file.path(coords_dir, 'map1.csv'))

map2 <- mergeMaps(map2003_5, method='table', number_of_dimensions = 2)
map2 <- optimizeMap(map = map2, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map2, file.path(acmap_dir, 'map2.ace'))
save.coords(map2, file.path(coords_dir, 'map2.csv'))

map3 <- mergeMaps(map2003_6, method='table', number_of_dimensions = 2)
map3 <- optimizeMap(map = map3, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map3, file.path(acmap_dir, 'map3.ace'))
save.coords(map3, file.path(coords_dir, 'map3.csv'))

map4 <- mergeMaps(mapMar2007_4, mapMar2007_5, mapMar2006_4, mapSep2006_4, mapSep2006_6, method='table', number_of_dimensions = 2)
map4 <- optimizeMap(map = map4, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map4, file.path(acmap_dir, 'map4.ace'))
save.coords(map4, file.path(coords_dir, 'map4.csv'))

map5 <- mergeMaps(mapMar2007_4, method='table', number_of_dimensions = 2)
map5 <- optimizeMap(map = map5, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map5, file.path(acmap_dir, 'map5.ace'))
save.coords(map5, file.path(coords_dir, 'map5.csv'))

map6 <- mergeMaps(mapMar2007_5, method='table', number_of_dimensions = 2)
map6 <- optimizeMap(map = map6, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map6, file.path(acmap_dir, 'map6.ace'))
save.coords(map6, file.path(coords_dir, 'map6.csv'))

map7 <- mergeMaps(mapSep2008_4A, mapSep2008_4B, mapSep2007_8, method='table', number_of_dimensions = 2)
map7 <- optimizeMap(map = map7, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map7, file.path(acmap_dir, 'map7.ace'))
save.coords(map7, file.path(coords_dir, 'map7.csv'))

map8 <- mergeMaps(mapSep2008_4B, mapSep2008_4A, mapSep2007_7, mapSep2007_6, method='table', number_of_dimensions = 2)
map8 <- optimizeMap(map = map8, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map8, file.path(acmap_dir, 'map8.ace'))
save.coords(map8, file.path(coords_dir, 'map8.csv'))

map9 <- mergeMaps(mapFeb2009_4, method='table', number_of_dimensions = 2)
map9 <- optimizeMap(map = map9, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map9, file.path(acmap_dir, 'map9.ace'))
save.coords(map9, file.path(coords_dir, 'map9.csv'))

map10 <- mergeMaps(mapSep2008_4A, mapMar2008_5, method='table', number_of_dimensions = 2)
map10 <- optimizeMap(map = map10, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map10, file.path(acmap_dir, 'map10.ace'))
save.coords(map10, file.path(coords_dir, 'map10.csv'))

map11 <- mergeMaps(mapSep2009_6, method='table', number_of_dimensions = 2)
map11 <- optimizeMap(map = map11, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map11, file.path(acmap_dir, 'map11.ace'))
save.coords(map11, file.path(coords_dir, 'map11.csv'))

map12 <- mergeMaps(mapSep2010_7B, mapFeb2010_13, method='table', number_of_dimensions = 2)
map12 <- optimizeMap(map = map12, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map12, file.path(acmap_dir, 'map12.ace'))
save.coords(map12, file.path(coords_dir, 'map12.csv'))

map13 <- mergeMaps(mapSep2009_5, mapSep2010_7B, mapFeb2010_13, method='table', number_of_dimensions = 2)
map13 <- optimizeMap(map = map13, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map13, file.path(acmap_dir, 'map13.ace'))
save.coords(map13, file.path(coords_dir, 'map13.csv'))

map14 <- mergeMaps(mapSep2011_18, method='table', number_of_dimensions = 2)
map14 <- optimizeMap(map = map14, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map14, file.path(acmap_dir, 'map14.ace'))
save.coords(map14, file.path(coords_dir, 'map14.csv'))

map15 <- mergeMaps(mapSep2012_9, method='table', number_of_dimensions = 2)
map15 <- optimizeMap(map = map15, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map15, file.path(acmap_dir, 'map15.ace'))
save.coords(map15, file.path(coords_dir, 'map15.csv'))

map16 <- mergeMaps(mapFeb2012_12, mapFeb2012_13, method='table', number_of_dimensions = 2)
map16 <- optimizeMap(map = map16, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map16, file.path(acmap_dir, 'map16.ace'))
save.coords(map16, file.path(coords_dir, 'map16.csv'))

map17 <- mergeMaps(mapSep2012_15, method='table', number_of_dimensions = 2)
map17 <- optimizeMap(map = map17, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map17, file.path(acmap_dir, 'map17.ace'))
save.coords(map17, file.path(coords_dir, 'map17.csv'))

map18 <- mergeMaps(mapFeb2012_10, method='table', number_of_dimensions = 2)
map18 <- optimizeMap(map = map18, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map18, file.path(acmap_dir, 'map18.ace'))
save.coords(map18, file.path(coords_dir, 'map18.csv'))

map19 <- mergeMaps(mapFeb2012_13, method='table', number_of_dimensions = 2)
map19 <- optimizeMap(map = map19, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map19, file.path(acmap_dir, 'map19.ace'))
save.coords(map19, file.path(coords_dir, 'map19.csv'))

map20 <- mergeMaps(mapFeb2012_14, method='table', number_of_dimensions = 2)
map20 <- optimizeMap(map = map20, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map20, file.path(acmap_dir, 'map20.ace'))
save.coords(map20, file.path(coords_dir, 'map20.csv'))

map21 <- mergeMaps(mapSep2012_18, mapSep2012_17, method='table', number_of_dimensions = 2)
map21 <- optimizeMap(map = map21, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map21, file.path(acmap_dir, 'map21.ace'))
save.coords(map21, file.path(coords_dir, 'map21.csv'))

map22 <- mergeMaps(mapSep2012_17, mapSep2012_12, method='table', number_of_dimensions = 2)
map22 <- optimizeMap(map = map22, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map22, file.path(acmap_dir, 'map22.ace'))
save.coords(map22, file.path(coords_dir, 'map22.csv'))

map23 <- mergeMaps(mapFeb2012_9, mapSep2012_10, method='table', number_of_dimensions = 2)
map23 <- optimizeMap(map = map23, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map23, file.path(acmap_dir, 'map23.ace'))
save.coords(map23, file.path(coords_dir, 'map23.csv'))

map24 <- mergeMaps(mapSep2013_7_7, mapSep2013_7_10, mapFeb2012_13, method='table', number_of_dimensions = 2)
map24 <- optimizeMap(map = map24, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map24, file.path(acmap_dir, 'map24.ace'))
save.coords(map24, file.path(coords_dir, 'map24.csv'))

map25 <- mergeMaps(mapFeb2013_18, mapFeb2012_13, method='table', number_of_dimensions = 2)
map25 <- optimizeMap(map = map25, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map25, file.path(acmap_dir, 'map25.ace'))
save.coords(map25, file.path(coords_dir, 'map25.csv'))

map26 <- mergeMaps(mapFeb2012_13, mapSep2013_7_16, mapSep2013_7_11, method='table', number_of_dimensions = 2)
map26 <- optimizeMap(map = map26, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map26, file.path(acmap_dir, 'map26.ace'))
save.coords(map26, file.path(coords_dir, 'map26.csv'))

map27 <- mergeMaps(mapSep2012_20, mapSep2013_7_12, mapSep2013_7_9, method='table', number_of_dimensions = 2)
map27 <- optimizeMap(map = map27, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map27, file.path(acmap_dir, 'map27.ace'))
save.coords(map27, file.path(coords_dir, 'map27.csv'))

map28 <- mergeMaps(mapSep2012_20, mapFeb2013_18, mapFeb2013_20, method='table', number_of_dimensions = 2)
map28 <- optimizeMap(map = map28, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map28, file.path(acmap_dir, 'map28.ace'))
save.coords(map28, file.path(coords_dir, 'map28.csv'))

map29 <- mergeMaps(mapSep2012_9, mapFeb2014_9_8, mapSep2013_7_8, method='table', number_of_dimensions = 2)
map29 <- optimizeMap(map = map29, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map29, file.path(acmap_dir, 'map29.ace'))
save.coords(map29, file.path(coords_dir, 'map29.csv'))

map30 <- mergeMaps(mapSep2012_9, mapSep2013_7_7, mapFeb2014_9_2, mapSep2014_8_10, mapSep2014_8_14, method='table', number_of_dimensions = 2)
map30 <- optimizeMap(map = map30, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map30, file.path(acmap_dir, 'map30.ace'))
save.coords(map30, file.path(coords_dir, 'map30.csv'))

map31 <- mergeMaps(mapSep2012_15, mapSep2013_7_12, mapFeb2014_9_7, mapSep2014_8_14, method='table', number_of_dimensions = 2)
map31 <- optimizeMap(map = map31, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map31, file.path(acmap_dir, 'map31.ace'))
save.coords(map31, file.path(coords_dir, 'map31.csv'))

map32 <- mergeMaps(mapSep2012_15, mapSep2013_7_12, mapFeb2014_9_2, mapFeb2014_9_8, method='table', number_of_dimensions = 2)
map32 <- optimizeMap(map = map32, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map32, file.path(acmap_dir, 'map32.ace'))
save.coords(map32, file.path(coords_dir, 'map32.csv'))

map33 <- mergeMaps(mapSep2012_15, mapSep2013_7_7, mapFeb2014_9_7, mapFeb2014_9_8, mapSep2014_8_14, method='table', number_of_dimensions = 2)
map33 <- optimizeMap(map = map33, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map33, file.path(acmap_dir, 'map33.ace'))
save.coords(map33, file.path(coords_dir, 'map33.csv'))

map34 <- mergeMaps(mapFeb2015_9_10, mapFeb2015_9_4, mapSep2014_8_18, method='table', number_of_dimensions = 2)
map34 <- optimizeMap(map = map34, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map34, file.path(acmap_dir, 'map34.ace'))
save.coords(map34, file.path(coords_dir, 'map34.csv'))

map35 <- mergeMaps(mapSep2015_8_9, mapFeb2015_9_10, mapSep2014_8_19, method='table', number_of_dimensions = 2)
map35 <- optimizeMap(map = map35, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map35, file.path(acmap_dir, 'map35.ace'))
save.coords(map35, file.path(coords_dir, 'map35.csv'))

map36 <- mergeMaps(mapSep2014_8_19, mapSep2014_8_18, mapSep2014_8_10, method='table', number_of_dimensions = 2)
map36 <- optimizeMap(map = map36, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map36, file.path(acmap_dir, 'map36.ace'))
save.coords(map36, file.path(coords_dir, 'map36.csv'))

map37 <- mergeMaps(mapSep2017_8_13, mapSep2017_8_12, mapSep2016_8_6, mapSep2016_8_2, method='table', number_of_dimensions = 2)
map37 <- optimizeMap(map = map37, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map37, file.path(acmap_dir, 'map37.ace'))
save.coords(map37, file.path(coords_dir, 'map37.csv'))

map38 <- mergeMaps(mapSep2017_8_13, mapFeb2016_9_3, mapFeb2017_8_5, method='table', number_of_dimensions = 2)
map38 <- optimizeMap(map = map38, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map38, file.path(acmap_dir, 'map38.ace'))
save.coords(map38, file.path(coords_dir, 'map38.csv'))

map39 <- mergeMaps(mapSep2017_8_16, mapSep2017_8_2, mapSep2016_8_2, method='table', number_of_dimensions = 2)
map39 <- optimizeMap(map = map39, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map39, file.path(acmap_dir, 'map39.ace'))
save.coords(map39, file.path(coords_dir, 'map39.csv'))

map40 <- mergeMaps(mapSep2017_8_13, mapSep2017_8_2, mapSep2016_8_2, method='table', number_of_dimensions = 2)
map40 <- optimizeMap(map = map40, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map40, file.path(acmap_dir, 'map40.ace'))
save.coords(map40, file.path(coords_dir, 'map40.csv'))

map41 <- mergeMaps(mapSep2017_8_13, mapSep2017_8_2, mapFeb2016_9_3, method='table', number_of_dimensions = 2)
map41 <- optimizeMap(map = map41, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map41, file.path(acmap_dir, 'map41.ace'))
save.coords(map41, file.path(coords_dir, 'map41.csv'))

map42 <- mergeMaps(mapSep2016_8_7, mapSep2017_8_13, mapSep2017_8_16, mapFeb2018_8_3, method='table', number_of_dimensions = 2)
map42 <- optimizeMap(map = map42, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map42, file.path(acmap_dir, 'map42.ace'))
save.coords(map42, file.path(coords_dir, 'map42.csv'))

map43 <- mergeMaps(mapSep2016_8_7, mapSep2017_8_13, mapSep2017_8_16, method='table', number_of_dimensions = 2)
map43 <- optimizeMap(map = map43, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map43, file.path(acmap_dir, 'map43.ace'))
save.coords(map43, file.path(coords_dir, 'map43.csv'))

map44 <- mergeMaps(mapSep2016_8_7, mapSep2017_8_13, mapSep2017_8_12, mapFeb2018_8_3, method='table', number_of_dimensions = 2)
map44 <- optimizeMap(map = map44, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map44, file.path(acmap_dir, 'map44.ace'))
save.coords(map44, file.path(coords_dir, 'map44.csv'))

map45 <- mergeMaps(mapSep2016_8_7, mapSep2017_8_13, mapFeb2018_8_3, method='table', number_of_dimensions = 2)
map45 <- optimizeMap(map = map45, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map45, file.path(acmap_dir, 'map45.ace'))
save.coords(map45, file.path(coords_dir, 'map45.csv'))

map46 <- mergeMaps(mapSep2018_8_5, mapSep2017_8_16, mapSep2017_8_20, method='table', number_of_dimensions = 2)
map46 <- optimizeMap(map = map46, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map46, file.path(acmap_dir, 'map46.ace'))
save.coords(map46, file.path(coords_dir, 'map46.csv'))

map47 <- mergeMaps(mapSep2018_8_5, mapFeb2018_8_9, mapSep2017_8_16, method='table', number_of_dimensions = 2)
map47 <- optimizeMap(map = map47, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map47, file.path(acmap_dir, 'map47.ace'))
save.coords(map47, file.path(coords_dir, 'map47.csv'))

map48 <- mergeMaps(mapFeb2020_7_11, mapSep2019_8_3, mapFeb2019_8_9, mapFeb2018_8_9, mapFeb2017_8_5, mapSep2017_21, mapSep2017_8_16, method='table', number_of_dimensions = 2)
map48 <- optimizeMap(map = map48, number_of_dimensions = 2, number_of_optimizations = 21000, options = list(ignore_disconnected = TRUE))
save.acmap(map48, file.path(acmap_dir, 'map48.ace'))
save.coords(map48, file.path(coords_dir, 'map48.csv'))

map49 <- mergeMaps(mapFeb2021_7_2, mapSep2019_8_1, mapSep2020_7_2, mapSep2019_8_18, method='table', number_of_dimensions = 2)
map49 <- optimizeMap(map = map49, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map49, file.path(acmap_dir, 'map49.ace'))
save.coords(map49, file.path(coords_dir, 'map49.csv'))

map50 <- mergeMaps(mapFeb2021_7_2, mapSep2019_8_14, mapSep2020_7_1, mapFeb2019_8_11, method='table', number_of_dimensions = 2)
map50 <- optimizeMap(map = map50, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map50, file.path(acmap_dir, 'map50.ace'))
save.coords(map50, file.path(coords_dir, 'map50.csv'))

map51 <- mergeMaps(mapSep2020_7_7, mapSep2019_8_19, mapSep2019_8_18, mapSep2019_8_16, method='table', number_of_dimensions = 2)
map51 <- optimizeMap(map = map51, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map51, file.path(acmap_dir, 'map51.ace'))
save.coords(map51, file.path(coords_dir, 'map51.csv'))

map52 <- mergeMaps(mapFeb2021_7_2, mapSep2021_7_4, mapFeb2022_9_1, method='table', number_of_dimensions = 2)
map52 <- optimizeMap(map = map52, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map52, file.path(acmap_dir, 'map52.ace'))
save.coords(map52, file.path(coords_dir, 'map52.csv'))

map53 <- mergeMaps(mapFeb2021_7_2, mapSep2021_7_7, mapFeb2022_9_1, method='table', number_of_dimensions = 2)
map53 <- optimizeMap(map = map53, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map53, file.path(acmap_dir, 'map53.ace'))
save.coords(map53, file.path(coords_dir, 'map53.csv'))

map54 <- mergeMaps(mapFeb2021_7_2, mapSep2021_7_7, mapSep2022_10_6, mapSep2022_10_20, method='table', number_of_dimensions = 2)
map54 <- optimizeMap(map = map54, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map54, file.path(acmap_dir, 'map54.ace'))
save.coords(map54, file.path(coords_dir, 'map54.csv'))

map55 <- mergeMaps(mapFeb2021_7_2, mapSep2021_7_7, mapSep2021_7_1, mapSep2022_10_6, mapSep2022_10_20, mapSep2019_8_16, method='table', number_of_dimensions = 2)
map55 <- optimizeMap(map = map55, number_of_dimensions = 2, number_of_optimizations = 18000, options = list(ignore_disconnected = TRUE))
save.acmap(map55, file.path(acmap_dir, 'map55.ace'))
save.coords(map55, file.path(coords_dir, 'map55.csv'))

map56 <- mergeMaps(mapSep2021_7_6, mapFeb2022_9_1, mapFeb2022_9_10, mapSep2022_10_18, method='table', number_of_dimensions = 2)
map56 <- optimizeMap(map = map56, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map56, file.path(acmap_dir, 'map56.ace'))
save.coords(map56, file.path(coords_dir, 'map56.csv'))

map57 <- mergeMaps(mapSep2021_7_6, mapFeb2022_9_1, mapFeb2022_9_2, mapSep2022_10_18, method='table', number_of_dimensions = 2)
map57 <- optimizeMap(map = map57, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map57, file.path(acmap_dir, 'map57.ace'))
save.coords(map57, file.path(coords_dir, 'map57.csv'))

map58 <- mergeMaps(mapSep2021_7_6, mapSep2022_10_20, mapFeb2022_9_1, mapSep2022_10_18, method='table', number_of_dimensions = 2)
map58 <- optimizeMap(map = map58, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map58, file.path(acmap_dir, 'map58.ace'))
save.coords(map58, file.path(coords_dir, 'map58.csv'))

map59 <- mergeMaps(mapFeb2023_H3_10, mapSep2023_H3_12, mapSep2022_10_20, mapSep2022_10_12, method='table', number_of_dimensions = 2)
map59 <- optimizeMap(map = map59, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map59, file.path(acmap_dir, 'map59.ace'))
save.coords(map59, file.path(coords_dir, 'map59.csv'))

map60 <- mergeMaps(mapFeb2023_H3_10, mapSep2023_H3_12, mapSep2023_H3_1, mapSep2022_10_25, mapSep2021_7_7, method='table', number_of_dimensions = 2)
map60 <- optimizeMap(map = map60, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map60, file.path(acmap_dir, 'map60.ace'))
save.coords(map60, file.path(coords_dir, 'map60.csv'))

map61 <- mergeMaps(mapFeb2023_H3_10, mapSep2023_H3_12, mapSep2022_10_12, mapFeb2022_9_1, method='table', number_of_dimensions = 2)
map61 <- optimizeMap(map = map61, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map61, file.path(acmap_dir, 'map61.ace'))
save.coords(map61, file.path(coords_dir, 'map61.csv'))

map62 <- mergeMaps(mapFeb2023_H3_10, mapSep2023_H3_12, mapSep2022_10_12, mapSep2022_10_10, mapFeb2022_9_1, method='table', number_of_dimensions = 2)
map62 <- optimizeMap(map = map62, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map62, file.path(acmap_dir, 'map62.ace'))
save.coords(map62, file.path(coords_dir, 'map62.csv'))

map63 <- mergeMaps(map2004_5, map2003_6, method='table', number_of_dimensions = 2)
map63 <- optimizeMap(map = map63, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map63, file.path(acmap_dir, 'map63.ace'))
save.coords(map63, file.path(coords_dir, 'map63.csv'))

map64 <- mergeMaps(map2004_5, method='table', number_of_dimensions = 2)
map64 <- optimizeMap(map = map64, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map64, file.path(acmap_dir, 'map64.ace'))
save.coords(map64, file.path(coords_dir, 'map64.csv'))

map65 <- mergeMaps(mapSep2006_3, mapSep2006_6, method='table', number_of_dimensions = 2)
map65 <- optimizeMap(map = map65, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map65, file.path(acmap_dir, 'map65.ace'))
save.coords(map65, file.path(coords_dir, 'map65.csv'))

map66 <- mergeMaps(mapSep2006_5, mapSep2006_3, method='table', number_of_dimensions = 2)
map66 <- optimizeMap(map = map66, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map66, file.path(acmap_dir, 'map66.ace'))
save.coords(map66, file.path(coords_dir, 'map66.csv'))

map67 <- mergeMaps(mapMar2007_4, mapSep2006_6, method='table', number_of_dimensions = 2)
map67 <- optimizeMap(map = map67, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map67, file.path(acmap_dir, 'map67.ace'))
save.coords(map67, file.path(coords_dir, 'map67.csv'))

map68 <- mergeMaps(mapMar2007_4, mapSep2006_6, mapSep2007_6, method='table', number_of_dimensions = 2)
map68 <- optimizeMap(map = map68, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map68, file.path(acmap_dir, 'map68.ace'))
save.coords(map68, file.path(coords_dir, 'map68.csv'))

map69 <- mergeMaps(mapSep2007_5, mapSep2007_6, mapSep2007_8, method='table', number_of_dimensions = 2)
map69 <- optimizeMap(map = map69, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map69, file.path(acmap_dir, 'map69.ace'))
save.coords(map69, file.path(coords_dir, 'map69.csv'))

map70 <- mergeMaps(mapSep2007_5, mapSep2007_6, mapSep2007_8, mapMar2007_4, mapSep2006_6, method='table', number_of_dimensions = 2)
map70 <- optimizeMap(map = map70, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map70, file.path(acmap_dir, 'map70.ace'))
save.coords(map70, file.path(coords_dir, 'map70.csv'))

map71 <- mergeMaps(mapSep2008_4A, mapSep2007_8, mapSep2008_4B, method='table', number_of_dimensions = 2)
map71 <- optimizeMap(map = map71, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map71, file.path(acmap_dir, 'map71.ace'))
save.coords(map71, file.path(coords_dir, 'map71.csv'))

map72 <- mergeMaps(mapSep2008_4A, mapSep2007_8, method='table', number_of_dimensions = 2)
map72 <- optimizeMap(map = map72, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map72, file.path(acmap_dir, 'map72.ace'))
save.coords(map72, file.path(coords_dir, 'map72.csv'))

map73 <- mergeMaps(mapFeb2009_5, method='table', number_of_dimensions = 2)
map73 <- optimizeMap(map = map73, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map73, file.path(acmap_dir, 'map73.ace'))
save.coords(map73, file.path(coords_dir, 'map73.csv'))

map74 <- mergeMaps(mapSep2013_7_12, mapSep2012_9, method='table', number_of_dimensions = 2)
map74 <- optimizeMap(map = map74, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map74, file.path(acmap_dir, 'map74.ace'))
save.coords(map74, file.path(coords_dir, 'map74.csv'))

map75 <- mergeMaps(mapSep2013_7_12, mapSep2012_10, method='table', number_of_dimensions = 2)
map75 <- optimizeMap(map = map75, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map75, file.path(acmap_dir, 'map75.ace'))
save.coords(map75, file.path(coords_dir, 'map75.csv'))

map76 <- mergeMaps(mapSep2013_7_12, mapFeb2012_12, method='table', number_of_dimensions = 2)
map76 <- optimizeMap(map = map76, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map76, file.path(acmap_dir, 'map76.ace'))
save.coords(map76, file.path(coords_dir, 'map76.csv'))

map77 <- mergeMaps(mapSep2013_7_12, mapFeb2013_13, method='table', number_of_dimensions = 2)
map77 <- optimizeMap(map = map77, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map77, file.path(acmap_dir, 'map77.ace'))
save.coords(map77, file.path(coords_dir, 'map77.csv'))

map78 <- mergeMaps(mapSep2013_7_12, mapSep2012_15, method='table', number_of_dimensions = 2)
map78 <- optimizeMap(map = map78, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map78, file.path(acmap_dir, 'map78.ace'))
save.coords(map78, file.path(coords_dir, 'map78.csv'))

map79 <- mergeMaps(mapFeb2012_13, mapFeb2013_18, mapFeb2013_13, method='table', number_of_dimensions = 2)
map79 <- optimizeMap(map = map79, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map79, file.path(acmap_dir, 'map79.ace'))
save.coords(map79, file.path(coords_dir, 'map79.csv'))

map80 <- mergeMaps(mapFeb2012_8, mapFeb2013_18, mapSep2013_7_16, method='table', number_of_dimensions = 2)
map80 <- optimizeMap(map = map80, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map80, file.path(acmap_dir, 'map80.ace'))
save.coords(map80, file.path(coords_dir, 'map80.csv'))

map81 <- mergeMaps(mapSep2012_18, mapSep2013_7_7, method='table', number_of_dimensions = 2)
map81 <- optimizeMap(map = map81, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map81, file.path(acmap_dir, 'map81.ace'))
save.coords(map81, file.path(coords_dir, 'map81.csv'))

map82 <- mergeMaps(mapSep2013_7_8, mapSep2012_17, method='table', number_of_dimensions = 2)
map82 <- optimizeMap(map = map82, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map82, file.path(acmap_dir, 'map82.ace'))
save.coords(map82, file.path(coords_dir, 'map82.csv'))

map83 <- mergeMaps(mapSep2013_7_3, mapSep2012_9, mapSep2013_7_16, method='table', number_of_dimensions = 2)
map83 <- optimizeMap(map = map83, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map83, file.path(acmap_dir, 'map83.ace'))
save.coords(map83, file.path(coords_dir, 'map83.csv'))

map84 <- mergeMaps(mapSep2012_9, mapSep2013_7_9, mapSep2013_7_7, method='table', number_of_dimensions = 2)
map84 <- optimizeMap(map = map84, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map84, file.path(acmap_dir, 'map84.ace'))
save.coords(map84, file.path(coords_dir, 'map84.csv'))

map85 <- mergeMaps(mapSep2012_9, mapSep2013_7_12, method='table', number_of_dimensions = 2)
map85 <- optimizeMap(map = map85, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map85, file.path(acmap_dir, 'map85.ace'))
save.coords(map85, file.path(coords_dir, 'map85.csv'))

map86 <- mergeMaps(mapSep2012_15, mapFeb2013_18, method='table', number_of_dimensions = 2)
map86 <- optimizeMap(map = map86, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map86, file.path(acmap_dir, 'map86.ace'))
save.coords(map86, file.path(coords_dir, 'map86.csv'))

map87 <- mergeMaps(mapSep2012_9, mapFeb2014_9_7, mapSep2013_7_10, method='table', number_of_dimensions = 2)
map87 <- optimizeMap(map = map87, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map87, file.path(acmap_dir, 'map87.ace'))
save.coords(map87, file.path(coords_dir, 'map87.csv'))

map88 <- mergeMaps(mapSep2012_15, mapSep2013_7_10, mapFeb2014_9_7, method='table', number_of_dimensions = 2)
map88 <- optimizeMap(map = map88, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map88, file.path(acmap_dir, 'map88.ace'))
save.coords(map88, file.path(coords_dir, 'map88.csv'))

map89 <- mergeMaps(mapSep2012_15, mapSep2013_7_7, mapSep2014_8_19, mapFeb2014_9_7, mapSep2014_8_11, method='table', number_of_dimensions = 2)
map89 <- optimizeMap(map = map89, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map89, file.path(acmap_dir, 'map89.ace'))
save.coords(map89, file.path(coords_dir, 'map89.csv'))

map90 <- mergeMaps(mapSep2015_8_9, mapSep2014_8_16, mapSep2014_8_10, mapFeb2014_9_2, mapFeb2015_9_4, mapSep2012_12, mapSep2012_15, method='table', number_of_dimensions = 2)
map90 <- optimizeMap(map = map90, number_of_dimensions = 2, number_of_optimizations = 21000, options = list(ignore_disconnected = TRUE))
save.acmap(map90, file.path(acmap_dir, 'map90.ace'))
save.coords(map90, file.path(coords_dir, 'map90.csv'))

map91 <- mergeMaps(mapSep2016_8_6, mapFeb2016_9_2, method='table', number_of_dimensions = 2)
map91 <- optimizeMap(map = map91, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map91, file.path(acmap_dir, 'map91.ace'))
save.coords(map91, file.path(coords_dir, 'map91.csv'))

map92 <- mergeMaps(mapSep2015_8_4, mapSep2015_8_13, mapSep2015_8_6, method='table', number_of_dimensions = 2)
map92 <- optimizeMap(map = map92, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map92, file.path(acmap_dir, 'map92.ace'))
save.coords(map92, file.path(coords_dir, 'map92.csv'))

map93 <- mergeMaps(mapSep2015_8_8, mapSep2015_8_9, method='table', number_of_dimensions = 2)
map93 <- optimizeMap(map = map93, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map93, file.path(acmap_dir, 'map93.ace'))
save.coords(map93, file.path(coords_dir, 'map93.csv'))

map94 <- mergeMaps(mapSep2015_8_13, mapSep2015_8_9, method='table', number_of_dimensions = 2)
map94 <- optimizeMap(map = map94, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map94, file.path(acmap_dir, 'map94.ace'))
save.coords(map94, file.path(coords_dir, 'map94.csv'))

map95 <- mergeMaps(mapFeb2016_9_3, method='table', number_of_dimensions = 2)
map95 <- optimizeMap(map = map95, number_of_dimensions = 2, number_of_optimizations = 3000, options = list(ignore_disconnected = TRUE))
save.acmap(map95, file.path(acmap_dir, 'map95.ace'))
save.coords(map95, file.path(coords_dir, 'map95.csv'))

map96 <- mergeMaps(mapSep2016_8_6, mapSep2016_8_7, method='table', number_of_dimensions = 2)
map96 <- optimizeMap(map = map96, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map96, file.path(acmap_dir, 'map96.ace'))
save.coords(map96, file.path(coords_dir, 'map96.csv'))

map97 <- mergeMaps(mapSep2016_8_7, mapFeb2016_9_3, method='table', number_of_dimensions = 2)
map97 <- optimizeMap(map = map97, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map97, file.path(acmap_dir, 'map97.ace'))
save.coords(map97, file.path(coords_dir, 'map97.csv'))

map98 <- mergeMaps(mapSep2016_8_7, mapFeb2016_9_3, mapSep2016_8_2, method='table', number_of_dimensions = 2)
map98 <- optimizeMap(map = map98, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map98, file.path(acmap_dir, 'map98.ace'))
save.coords(map98, file.path(coords_dir, 'map98.csv'))

map99 <- mergeMaps(mapSep2016_8_7, mapSep2016_8_2, method='table', number_of_dimensions = 2)
map99 <- optimizeMap(map = map99, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map99, file.path(acmap_dir, 'map99.ace'))
save.coords(map99, file.path(coords_dir, 'map99.csv'))

map100 <- mergeMaps(mapSep2016_8_7, mapSep2017_21, method='table', number_of_dimensions = 2)
map100 <- optimizeMap(map = map100, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map100, file.path(acmap_dir, 'map100.ace'))
save.coords(map100, file.path(coords_dir, 'map100.csv'))

map101 <- mergeMaps(mapSep2016_8_7, mapFeb2017_8_2, method='table', number_of_dimensions = 2)
map101 <- optimizeMap(map = map101, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map101, file.path(acmap_dir, 'map101.ace'))
save.coords(map101, file.path(coords_dir, 'map101.csv'))

map102 <- mergeMaps(mapSep2016_8_7, mapSep2016_8_9, mapSep2017_8_2, method='table', number_of_dimensions = 2)
map102 <- optimizeMap(map = map102, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map102, file.path(acmap_dir, 'map102.ace'))
save.coords(map102, file.path(coords_dir, 'map102.csv'))

map103 <- mergeMaps(mapSep2016_8_7, mapSep2016_8_9, mapFeb2017_8_2, method='table', number_of_dimensions = 2)
map103 <- optimizeMap(map = map103, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map103, file.path(acmap_dir, 'map103.ace'))
save.coords(map103, file.path(coords_dir, 'map103.csv'))

map104 <- mergeMaps(mapSep2016_8_7, mapFeb2017_8_2, mapSep2017_21, method='table', number_of_dimensions = 2)
map104 <- optimizeMap(map = map104, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map104, file.path(acmap_dir, 'map104.ace'))
save.coords(map104, file.path(coords_dir, 'map104.csv'))

map105 <- mergeMaps(mapFeb2019_8_5, mapFeb2018_8_4, mapSep2017_8_16, method='table', number_of_dimensions = 2)
map105 <- optimizeMap(map = map105, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map105, file.path(acmap_dir, 'map105.ace'))
save.coords(map105, file.path(coords_dir, 'map105.csv'))

map106 <- mergeMaps(mapSep2018_8_6, mapSep2018_8_5, mapFeb2018_8_6, method='table', number_of_dimensions = 2)
map106 <- optimizeMap(map = map106, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map106, file.path(acmap_dir, 'map106.ace'))
save.coords(map106, file.path(coords_dir, 'map106.csv'))

map107 <- mergeMaps(mapSep2018_8_6, mapFeb2018_8_6, mapSep2017_21, method='table', number_of_dimensions = 2)
map107 <- optimizeMap(map = map107, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map107, file.path(acmap_dir, 'map107.ace'))
save.coords(map107, file.path(coords_dir, 'map107.csv'))

map108 <- mergeMaps(mapFeb2018_8_6, mapSep2017_21, mapSep2018_8_7, method='table', number_of_dimensions = 2)
map108 <- optimizeMap(map = map108, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map108, file.path(acmap_dir, 'map108.ace'))
save.coords(map108, file.path(coords_dir, 'map108.csv'))

map109 <- mergeMaps(mapSep2018_8_7, mapSep2018_8_2, mapSep2018_8_5, method='table', number_of_dimensions = 2)
map109 <- optimizeMap(map = map109, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map109, file.path(acmap_dir, 'map109.ace'))
save.coords(map109, file.path(coords_dir, 'map109.csv'))

map110 <- mergeMaps(mapFeb2020_7_12, mapSep2019_8_15, mapSep2019_8_6, method='table', number_of_dimensions = 2)
map110 <- optimizeMap(map = map110, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map110, file.path(acmap_dir, 'map110.ace'))
save.coords(map110, file.path(coords_dir, 'map110.csv'))

map111 <- mergeMaps(mapSep2019_8_7, mapSep2019_8_17, mapFeb2019_8_10, method='table', number_of_dimensions = 2)
map111 <- optimizeMap(map = map111, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map111, file.path(acmap_dir, 'map111.ace'))
save.coords(map111, file.path(coords_dir, 'map111.csv'))

map112 <- mergeMaps(mapSep2019_8_13, mapSep2019_8_14, mapSep2019_8_15, method='table', number_of_dimensions = 2)
map112 <- optimizeMap(map = map112, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map112, file.path(acmap_dir, 'map112.ace'))
save.coords(map112, file.path(coords_dir, 'map112.csv'))

map113 <- mergeMaps(mapSep2019_8_17, mapSep2019_8_18, method='table', number_of_dimensions = 2)
map113 <- optimizeMap(map = map113, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map113, file.path(acmap_dir, 'map113.ace'))
save.coords(map113, file.path(coords_dir, 'map113.csv'))

map114 <- mergeMaps(mapSep2019_8_6, mapSep2019_8_3, mapSep2019_8_5, method='table', number_of_dimensions = 2)
map114 <- optimizeMap(map = map114, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map114, file.path(acmap_dir, 'map114.ace'))
save.coords(map114, file.path(coords_dir, 'map114.csv'))

map115 <- mergeMaps(mapFeb2020_7_5, mapFeb2021_7_3, mapFeb2020_7_12, method='table', number_of_dimensions = 2)
map115 <- optimizeMap(map = map115, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map115, file.path(acmap_dir, 'map115.ace'))
save.coords(map115, file.path(coords_dir, 'map115.csv'))

map116 <- mergeMaps(mapFeb2020_7_5, mapSep2019_8_16, mapSep2021_7_4, method='table', number_of_dimensions = 2)
map116 <- optimizeMap(map = map116, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map116, file.path(acmap_dir, 'map116.ace'))
save.coords(map116, file.path(coords_dir, 'map116.csv'))

map117 <- mergeMaps(mapFeb2020_7_5, mapSep2020_7_9, mapFeb2022_9_1, mapSep2021_7_4, method='table', number_of_dimensions = 2)
map117 <- optimizeMap(map = map117, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map117, file.path(acmap_dir, 'map117.ace'))
save.coords(map117, file.path(coords_dir, 'map117.csv'))

map118 <- mergeMaps(mapFeb2020_7_5, mapSep2020_7_1, mapSep2021_7_5, method='table', number_of_dimensions = 2)
map118 <- optimizeMap(map = map118, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map118, file.path(acmap_dir, 'map118.ace'))
save.coords(map118, file.path(coords_dir, 'map118.csv'))

map119 <- mergeMaps(mapFeb2020_7_5, mapFeb2021_7_2, mapSep2021_7_10, mapSep2022_10_17, method='table', number_of_dimensions = 2)
map119 <- optimizeMap(map = map119, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map119, file.path(acmap_dir, 'map119.ace'))
save.coords(map119, file.path(coords_dir, 'map119.csv'))

map120 <- mergeMaps(mapFeb2020_7_5, mapFeb2021_7_2, mapSep2021_7_10, mapFeb2022_9_9, method='table', number_of_dimensions = 2)
map120 <- optimizeMap(map = map120, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map120, file.path(acmap_dir, 'map120.ace'))
save.coords(map120, file.path(coords_dir, 'map120.csv'))

map121 <- mergeMaps(mapFeb2020_7_5, mapFeb2021_7_2, mapSep2021_7_10, mapFeb2022_9_7, method='table', number_of_dimensions = 2)
map121 <- optimizeMap(map = map121, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map121, file.path(acmap_dir, 'map121.ace'))
save.coords(map121, file.path(coords_dir, 'map121.csv'))

map122 <- mergeMaps(mapFeb2020_7_5, mapFeb2021_7_2, mapFeb2021_7_3, mapSep2021_7_10, method='table', number_of_dimensions = 2)
map122 <- optimizeMap(map = map122, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map122, file.path(acmap_dir, 'map122.ace'))
save.coords(map122, file.path(coords_dir, 'map122.csv'))

map123 <- mergeMaps(mapSep2021_7_6, mapFeb2022_9_11, mapSep2022_10_8, method='table', number_of_dimensions = 2)
map123 <- optimizeMap(map = map123, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map123, file.path(acmap_dir, 'map123.ace'))
save.coords(map123, file.path(coords_dir, 'map123.csv'))

map124 <- mergeMaps(mapSep2021_7_6, mapSep2022_10_8, mapFeb2023_H3_10, mapFeb2023_H3_1, method='table', number_of_dimensions = 2)
map124 <- optimizeMap(map = map124, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map124, file.path(acmap_dir, 'map124.ace'))
save.coords(map124, file.path(coords_dir, 'map124.csv'))

map125 <- mergeMaps(mapSep2021_7_6, mapSep2022_10_19, method='table', number_of_dimensions = 2)
map125 <- optimizeMap(map = map125, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map125, file.path(acmap_dir, 'map125.ace'))
save.coords(map125, file.path(coords_dir, 'map125.csv'))

map126 <- mergeMaps(mapSep2021_7_6, mapSep2022_10_18, method='table', number_of_dimensions = 2)
map126 <- optimizeMap(map = map126, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map126, file.path(acmap_dir, 'map126.ace'))
save.coords(map126, file.path(coords_dir, 'map126.csv'))

map127 <- mergeMaps(mapSep2021_7_6, mapSep2022_10_16, mapFeb2023_H3_1, mapFeb2023_H3_10, method='table', number_of_dimensions = 2)
map127 <- optimizeMap(map = map127, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map127, file.path(acmap_dir, 'map127.ace'))
save.coords(map127, file.path(coords_dir, 'map127.csv'))

map128 <- mergeMaps(mapMar2006_4, mapSep2006_4, mapSep2006_6, mapSep2007_6, mapSep2008_4A, mapSep2007_7, method='table', number_of_dimensions = 2)
map128 <- optimizeMap(map = map128, number_of_dimensions = 2, number_of_optimizations = 18000, options = list(ignore_disconnected = TRUE))
save.acmap(map128, file.path(acmap_dir, 'map128.ace'))
save.coords(map128, file.path(coords_dir, 'map128.csv'))

map129 <- mergeMaps(mapSep2009_6, mapFeb2010_12, method='table', number_of_dimensions = 2)
map129 <- optimizeMap(map = map129, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map129, file.path(acmap_dir, 'map129.ace'))
save.coords(map129, file.path(coords_dir, 'map129.csv'))

map130 <- mergeMaps(mapSep2013_7_12, mapFeb2012_14, method='table', number_of_dimensions = 2)
map130 <- optimizeMap(map = map130, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map130, file.path(acmap_dir, 'map130.ace'))
save.coords(map130, file.path(coords_dir, 'map130.csv'))

map131 <- mergeMaps(mapSep2013_7_10, mapFeb2012_12, method='table', number_of_dimensions = 2)
map131 <- optimizeMap(map = map131, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map131, file.path(acmap_dir, 'map131.ace'))
save.coords(map131, file.path(coords_dir, 'map131.csv'))

map132 <- mergeMaps(mapSep2013_7_10, mapFeb2012_13, method='table', number_of_dimensions = 2)
map132 <- optimizeMap(map = map132, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map132, file.path(acmap_dir, 'map132.ace'))
save.coords(map132, file.path(coords_dir, 'map132.csv'))

map133 <- mergeMaps(mapSep2013_7_10, mapFeb2012_14, method='table', number_of_dimensions = 2)
map133 <- optimizeMap(map = map133, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map133, file.path(acmap_dir, 'map133.ace'))
save.coords(map133, file.path(coords_dir, 'map133.csv'))

map134 <- mergeMaps(mapSep2013_7_10, mapFeb2012_11, method='table', number_of_dimensions = 2)
map134 <- optimizeMap(map = map134, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map134, file.path(acmap_dir, 'map134.ace'))
save.coords(map134, file.path(coords_dir, 'map134.csv'))

map135 <- mergeMaps(mapSep2013_7_10, mapSep2012_12, method='table', number_of_dimensions = 2)
map135 <- optimizeMap(map = map135, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map135, file.path(acmap_dir, 'map135.ace'))
save.coords(map135, file.path(coords_dir, 'map135.csv'))

map136 <- mergeMaps(mapSep2012_15, mapSep2013_7_10, mapFeb2014_9_2, mapSep2014_8_10, mapSep2014_8_19, method='table', number_of_dimensions = 2)
map136 <- optimizeMap(map = map136, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map136, file.path(acmap_dir, 'map136.ace'))
save.coords(map136, file.path(coords_dir, 'map136.csv'))

map137 <- mergeMaps(mapSep2012_9, mapSep2013_7_10, mapFeb2014_9_7, mapSep2014_8_13, mapFeb2015_9_3, mapFeb2015_9_4, method='table', number_of_dimensions = 2)
map137 <- optimizeMap(map = map137, number_of_dimensions = 2, number_of_optimizations = 18000, options = list(ignore_disconnected = TRUE))
save.acmap(map137, file.path(acmap_dir, 'map137.ace'))
save.coords(map137, file.path(coords_dir, 'map137.csv'))

map138 <- mergeMaps(mapSep2012_9, mapSep2013_7_7, mapFeb2014_9_7, mapSep2014_8_10, mapSep2014_8_16, mapFeb2015_9_4, mapSep2015_8_9, method='table', number_of_dimensions = 2)
map138 <- optimizeMap(map = map138, number_of_dimensions = 2, number_of_optimizations = 21000, options = list(ignore_disconnected = TRUE))
save.acmap(map138, file.path(acmap_dir, 'map138.ace'))
save.coords(map138, file.path(coords_dir, 'map138.csv'))

map139 <- mergeMaps(mapSep2013_7_8, mapSep2012_15, mapSep2014_8_19, mapSep2014_8_10, mapFeb2014_9_6, method='table', number_of_dimensions = 2)
map139 <- optimizeMap(map = map139, number_of_dimensions = 2, number_of_optimizations = 15000, options = list(ignore_disconnected = TRUE))
save.acmap(map139, file.path(acmap_dir, 'map139.ace'))
save.coords(map139, file.path(coords_dir, 'map139.csv'))

map140 <- mergeMaps(mapSep2013_7_8, mapFeb2015_9_4, mapSep2012_9, mapSep2014_8_19, mapSep2014_8_10, mapFeb2014_9_6, method='table', number_of_dimensions = 2)
map140 <- optimizeMap(map = map140, number_of_dimensions = 2, number_of_optimizations = 18000, options = list(ignore_disconnected = TRUE))
save.acmap(map140, file.path(acmap_dir, 'map140.ace'))
save.coords(map140, file.path(coords_dir, 'map140.csv'))

map141 <- mergeMaps(mapSep2014_8_19, mapFeb2015_9_2, method='table', number_of_dimensions = 2)
map141 <- optimizeMap(map = map141, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map141, file.path(acmap_dir, 'map141.ace'))
save.coords(map141, file.path(coords_dir, 'map141.csv'))

map142 <- mergeMaps(mapFeb2015_9_4, mapFeb2015_9_2, method='table', number_of_dimensions = 2)
map142 <- optimizeMap(map = map142, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map142, file.path(acmap_dir, 'map142.ace'))
save.coords(map142, file.path(coords_dir, 'map142.csv'))

map143 <- mergeMaps(mapSep2015_8_9, mapSep2015_8_8, method='table', number_of_dimensions = 2)
map143 <- optimizeMap(map = map143, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map143, file.path(acmap_dir, 'map143.ace'))
save.coords(map143, file.path(coords_dir, 'map143.csv'))

map144 <- mergeMaps(mapSep2016_8_6, mapSep2016_8_2, method='table', number_of_dimensions = 2)
map144 <- optimizeMap(map = map144, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map144, file.path(acmap_dir, 'map144.ace'))
save.coords(map144, file.path(coords_dir, 'map144.csv'))

map145 <- mergeMaps(mapSep2016_8_7, mapSep2016_8_6, method='table', number_of_dimensions = 2)
map145 <- optimizeMap(map = map145, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map145, file.path(acmap_dir, 'map145.ace'))
save.coords(map145, file.path(coords_dir, 'map145.csv'))

map146 <- mergeMaps(mapSep2016_8_7, mapSep2016_8_2, mapFeb2016_9_3, method='table', number_of_dimensions = 2)
map146 <- optimizeMap(map = map146, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map146, file.path(acmap_dir, 'map146.ace'))
save.coords(map146, file.path(coords_dir, 'map146.csv'))

map147 <- mergeMaps(mapSep2016_8_7, mapSep2017_8_16, mapSep2017_8_2, method='table', number_of_dimensions = 2)
map147 <- optimizeMap(map = map147, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map147, file.path(acmap_dir, 'map147.ace'))
save.coords(map147, file.path(coords_dir, 'map147.csv'))

map148 <- mergeMaps(mapSep2016_8_7, mapSep2017_8_2, method='table', number_of_dimensions = 2)
map148 <- optimizeMap(map = map148, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map148, file.path(acmap_dir, 'map148.ace'))
save.coords(map148, file.path(coords_dir, 'map148.csv'))

map149 <- mergeMaps(mapSep2017_8_16, mapFeb2018_8_6, mapFeb2019_8_7, method='table', number_of_dimensions = 2)
map149 <- optimizeMap(map = map149, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map149, file.path(acmap_dir, 'map149.ace'))
save.coords(map149, file.path(coords_dir, 'map149.csv'))

map150 <- mergeMaps(mapFeb2019_8_9, mapFeb2018_8_9, mapSep2017_8_2, method='table', number_of_dimensions = 2)
map150 <- optimizeMap(map = map150, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map150, file.path(acmap_dir, 'map150.ace'))
save.coords(map150, file.path(coords_dir, 'map150.csv'))

map151 <- mergeMaps(mapFeb2018_8_9, mapFeb2019_8_7, mapSep2017_21, method='table', number_of_dimensions = 2)
map151 <- optimizeMap(map = map151, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map151, file.path(acmap_dir, 'map151.ace'))
save.coords(map151, file.path(coords_dir, 'map151.csv'))

map152 <- mergeMaps(mapSep2019_8_1, mapSep2019_8_11, mapSep2019_8_14, method='table', number_of_dimensions = 2)
map152 <- optimizeMap(map = map152, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map152, file.path(acmap_dir, 'map152.ace'))
save.coords(map152, file.path(coords_dir, 'map152.csv'))

map153 <- mergeMaps(mapSep2019_8_6, mapSep2019_8_3, mapSep2019_8_1, method='table', number_of_dimensions = 2)
map153 <- optimizeMap(map = map153, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map153, file.path(acmap_dir, 'map153.ace'))
save.coords(map153, file.path(coords_dir, 'map153.csv'))

map154 <- mergeMaps(mapFeb2019_8_11, mapSep2019_8_14, mapSep2019_8_15, method='table', number_of_dimensions = 2)
map154 <- optimizeMap(map = map154, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map154, file.path(acmap_dir, 'map154.ace'))
save.coords(map154, file.path(coords_dir, 'map154.csv'))

map155 <- mergeMaps(mapSep2019_8_1, mapSep2019_8_18, method='table', number_of_dimensions = 2)
map155 <- optimizeMap(map = map155, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map155, file.path(acmap_dir, 'map155.ace'))
save.coords(map155, file.path(coords_dir, 'map155.csv'))

map156 <- mergeMaps(mapSep2021_7_9, mapSep2020_7_5, method='table', number_of_dimensions = 2)
map156 <- optimizeMap(map = map156, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map156, file.path(acmap_dir, 'map156.ace'))
save.coords(map156, file.path(coords_dir, 'map156.csv'))

map157 <- mergeMaps(mapSep2020_7_9, mapSep2021_7_4, method='table', number_of_dimensions = 2)
map157 <- optimizeMap(map = map157, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map157, file.path(acmap_dir, 'map157.ace'))
save.coords(map157, file.path(coords_dir, 'map157.csv'))

map158 <- mergeMaps(mapFeb2021_7_3, mapFeb2020_7_12, method='table', number_of_dimensions = 2)
map158 <- optimizeMap(map = map158, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map158, file.path(acmap_dir, 'map158.ace'))
save.coords(map158, file.path(coords_dir, 'map158.csv'))

map159 <- mergeMaps(mapFeb2022_9_6, mapFeb2022_9_8, method='table', number_of_dimensions = 2)
map159 <- optimizeMap(map = map159, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map159, file.path(acmap_dir, 'map159.ace'))
save.coords(map159, file.path(coords_dir, 'map159.csv'))

map160 <- mergeMaps(mapSep2021_7_4, mapSep2020_7_5, method='table', number_of_dimensions = 2)
map160 <- optimizeMap(map = map160, number_of_dimensions = 2, number_of_optimizations = 6000, options = list(ignore_disconnected = TRUE))
save.acmap(map160, file.path(acmap_dir, 'map160.ace'))
save.coords(map160, file.path(coords_dir, 'map160.csv'))

map161 <- mergeMaps(mapFeb2021_7_2, mapFeb2020_7_5, mapSep2022_10_18, mapSep2021_7_4, method='table', number_of_dimensions = 2)
map161 <- optimizeMap(map = map161, number_of_dimensions = 2, number_of_optimizations = 12000, options = list(ignore_disconnected = TRUE))
save.acmap(map161, file.path(acmap_dir, 'map161.ace'))
save.coords(map161, file.path(coords_dir, 'map161.csv'))

map162 <- mergeMaps(mapSep2021_7_6, mapSep2022_10_17, mapSep2022_10_16, method='table', number_of_dimensions = 2)
map162 <- optimizeMap(map = map162, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map162, file.path(acmap_dir, 'map162.ace'))
save.coords(map162, file.path(coords_dir, 'map162.csv'))

map163 <- mergeMaps(mapSep2021_7_6, mapFeb2023_H3_10, mapFeb2023_H3_1, method='table', number_of_dimensions = 2)
map163 <- optimizeMap(map = map163, number_of_dimensions = 2, number_of_optimizations = 9000, options = list(ignore_disconnected = TRUE))
save.acmap(map163, file.path(acmap_dir, 'map163.ace'))
save.coords(map163, file.path(coords_dir, 'map163.csv'))

