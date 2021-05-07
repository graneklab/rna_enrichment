# Genome URLs
library(here)
library(dplyr)
library(fs)

#--------------------------------------
total_threads=60
# threads=3
max_jobs=10
threads=floor(total_threads/max_jobs)

Sys.setenv(THREADS = threads)
Sys.setenv(TOTAL_THREADS = total_threads)
Sys.setenv(MAX_JOBS = max_jobs)
#--------------------------------------

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

outdir_2018=file.path(basedir, "2018_sample_out")
outdir_2019=file.path(basedir, "2019_sample_out")
starout_2019_dir=file.path(outdir_2019, "enrich_compare_starout")
starout_2018_dir=file.path(outdir_2018, "enrich_compare_starout")

srafastq_md5file = here("info/sra_fastq_md5checksums.txt")
accessions_file = here("info/accession_table.csv")

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
  file.path(here::here("info"), .) ->
  gtf_with_mito_rrna.file

fig.dir = file.path(basedir, "figures"); dir.create(fig.dir)
info.dir=file.path(outdir_2018, "info")
Sys.setenv(INFO = info.dir)
adapters.file= file.path(info.dir, "neb_e7600_adapters_withrc.fasta")
adapters.fastqc= file.path(info.dir, "neb_e7600_adapters_fastqc.txt")
info.dir=file.path(outdir_2018, "info")
Sys.setenv(INFO = info.dir)
Sys.setenv(ADAPTERS = adapters.file)

lost_polya_file = file.path(fig.dir, "Table_S1.csv")

knit_output_dir = file.path(basedir, "knit_output_html"); dir.create(knit_output_dir, recursive = TRUE)


data_dir="/data"
file_chmod(data_dir, "u+w")
sra_dir=file.path(data_dir, "sra_fastqs"); dir.create(sra_dir, recursive = TRUE)
sra_tmp=file.path(basedir, "sra_tmp"); dir.create(sra_dir, recursive = TRUE)

# Genome with mito rRNA
genome_with_mito_rrna.dir=file.path(outdir_2018, "genome_with_mito_rrna")

genome.dir=file.path(outdir_2018, "genome")

gtf_url %>% 
  basename %>%
  path_ext_remove %>%
  file.path(genome.dir, .) ->
  gtf.file

fa_url %>% 
  basename %>%
  path_ext_remove %>%
  file.path(genome.dir, .) ->
  fa.file

fa.file %>% 
  basename %>%
  file.path(genome_with_mito_rrna.dir, .) ->
  fa_for_mito_rrna.file

Sys.setenv(GENOME_WITH_MITO_RRNA_DIR = genome_with_mito_rrna.dir)
Sys.setenv(ADAPTERS = adapters.file)
Sys.setenv(FASTQC_ADAPTERS = adapters.fastqc)
Sys.setenv(GTF = gtf.file)
Sys.setenv(FA = fa.file)

