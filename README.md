# Reproducible and later vaccine strain selection can improve vaccine match to A/H3N2 seasonal influenza viruses  

**Code and analysis/outfile files to replicate De Rooij, et al. (2025)**  

Complete analysis is compromised out of steps 5:

1. Sequence download from GISAID and NCBI (which needs to be performed by the user).
2. Reproducible and later strain selection using global 2-month HA consensus.
3. Dominant circulating strain identification for the US, Europe, and Australia and New Zealand.  
4. Comparison between dominant strains and WHO vaccine strain, reproducibly selected strain at WHO-timing, reproducibly selected strain at delayed timing on genetic level.  
5. Comparison between dominant strains and WHO vaccine strain, reproducibly selected strain at WHO-timing, reproducibly selected strain at delayed timing on antigenic level.  

Figure and tables as presented in the manuscript can be reproduced in [summarise_results](./notebooks/summarise_results.ipynb).
  
## 0. Requirements

to write requirements

## 1. Sequence download

### 1.1. NCBI genbank reference seqeunce  

within the data folder create the folder "references". Within the reference folder create "H3N2_HA.fasta" containing the NCBI genbank sequence: KX879573.1 and modify the header to look like ">KX879573.1-ref_1968-A/Alchi/2/1968|4-HA".

### 1.2. GISAID sequences

Within the data folder create the folder "gisaid_data" and within that folder create the folder "raw_downloads/H3N2". Download all A/H3N2 human lineage isolates collected from human hosts between 2000-01-01 and 2023-12-31 HA sequences and their corresponding metadata. sequence header should look like: "Isolate ID | DNA Accession no. | Isolate name | Type | Collection date | Segment ".  
(at the time of sequence download the lineage filter for A/H3N2 viruses was not available. Therefore the our original dataset is not filtered on human lineages only, but as we filter for this within the code, this should not affect the results)

## 2. Reproducible and later strain selection

Reprocudible and delayed strain selection for both Northern and Southern hemisphere seasons can be replicated following [reproducible_strain_selection.ipynb](./notebooks/reproducible_strain_selection.ipynb).  
selected reproducible strains are listed at [reproducible_selection_strains.fasta](./data/reproducible_selection_strains.fasta).  
(to note for analysis purposes reproducible strain as are region rather than per hemisphere. US and europe strains are identical as they're the same hemisphere)

## 3. Identification of dominant circulating strain for US, europe and Australia and New Zealand

Run the [run_treason](./scripts/run_treason.py) script to reproduce the [treason](./scripts/treason.py) outputs for the US, Europe, and Australia and New Zealand that are used to infer the dominant ciruclating strains.  
The dominant circulating strain identification can then be replicated in [dominant_clade_per_regional_season](./notebooks/dominant_clade_per_regional_season.ipynb).  
dominant circulating strains are listed at [dominant_strains.fasta](./data/dominant_strains.fasta).

## 4. Genetic comparison

Genetic comparison between the dominant circulating strains and WHO vaccine strain, reproducibly selected strain at WHO-timing, and reproducibly selected at (3-month) delayed timing can be reproduced in [genetic_strain_comparison](./notebooks/genetic_strain_comparison.ipynb)

## 5. Antigenic comparison  

Antigenic comparison between the dominant circulating strains and WHO vaccine strain, reproducibly selected strain at WHO-timing, and reproducibly selected at (3-month) delayed timing can be reproduced in [antigenic_strain_comparison](./notebooks/antigenic_strain_comparison.ipynb)

##

Please contact a.j.h.derooij@amsterdamumc.nl if you have question about the code.  