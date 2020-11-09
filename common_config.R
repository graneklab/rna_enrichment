# Genome URLs
library(here)
library(dplyr)
library(fs)

url_part1="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/"
url_part2="/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/"
url_part3="Cryptococcus_neoformans_var_grubii_h99.CNA3."

h99_ncrna_url = paste0(url_part1, "fasta", url_part2, "ncrna/", url_part3, "ncrna.fa.gz")
h99_cds_url = paste0(url_part1, "fasta", url_part2, "cds/", url_part3, "cds.all.fa.gz")
h99_genome_url = paste0(url_part1, "fasta", url_part2, "dna/", url_part3, "dna.toplevel.fa.gz")
h99_gtf_url= paste0(url_part1, "gtf", url_part2, url_part3, "39.gtf.gz")

fa_url = h99_genome_url
gtf_url = h99_gtf_url

basedir = "/workspace"
out.dir=file.path(basedir, "2018_tot_samples")

# The following are determined in 2018_analysis/enrichment_correlation.Rmd 
all_rrna_homologs = c("CNAG_12438","CNAG_07466","CNAG_10500",
                      "CNAG_12145","CNAG_10501","CNAG_10502",
                      "CNAG_10503","CNAG_04124","CNAG_06164",
                      "CNAG_13073","small_MTrRNA","large_MTrRNA")
strand_specific_rrna_homologs = c("CNAG_10500","CNAG_10501","CNAG_10502",
                                  "CNAG_10503","CNAG_13073","small_MTrRNA",
                                  "large_MTrRNA")

gtf_url %>% 
  basename %>%
  path_ext_remove %>%
  path_ext_remove %>%
  paste0("__with_mito_rrna.gtf") %>%
  file.path(here("info"), .) ->
  gtf_with_mito_rrna.file

fig.dir = file.path(out.dir, "figures")
dir.create(fig.dir)
