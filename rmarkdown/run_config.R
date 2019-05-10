# Libraries
library(fs)
library(tidyverse)

# Setup R variables
threads=3
max_jobs=4

# input
raw_fastq.dir="/data/hts_2018_data/hts2018_pilot_rawdata"
metadata.file=file.path(raw_fastq.dir, "2018_pilot_metadata.tsv")

# output
out.dir="/workspace/2018_tot_samples"
info.dir=file.path(out.dir, "info")
adapters.file= file.path(info.dir, "neb_e7600_adapters_withrc.fasta")
trimmed.dir=file.path(out.dir, "trimmed_fastqs")
genome.dir=file.path(out.dir, "genome")
total_samples_starout.dir=file.path(out.dir, "total_samples_starout")
mosdepth.dir=file.path(out.dir, "mosdepth")
seq.dir = file.path(out.dir, "seq_out"); dir.create(seq.dir, recursive = TRUE)
# export final_counts=$data_base/star_counts
igv_tarball = file.path(out.dir, "visualize_oligos.tgz")

# genome
shared_url = "ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/"
fa_url = paste0(shared_url,"fasta/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/dna/Cryptococcus_neoformans_var_grubii_h99.CNA3.dna.toplevel.fa.gz")
gtf_url = paste0(shared_url,"gtf/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gtf.gz")

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


gtf.file %>%
  path_file %>%
  path_ext_remove %>%
  paste0("__with_mito_rrna.gtf") %>%
  file.path(seq.dir, .) ->
  gtf_with_mito_rrna.file

rrna_oligos.file = file.path(seq.dir, "rrna_oligos.tsv")
rrna_oligos.fastq = file.path(seq.dir, "rrna_oligos.fastq")
rrna_oligos.fastq = file.path(seq.dir, "rrna_oligos.fastq")

# Genome with mito rRNA
genome_with_mito_rrna.dir=file.path(out.dir, "genome_with_mito_rrna")
fa.file %>% 
  basename %>%
  file.path(genome_with_mito_rrna.dir, .) ->
  fa_for_mito_rrna.file

rrna_oligo_starout.dir=file.path(out.dir, "rrna_oligo_starout")
enrich_compare_starout.dir=file.path(out.dir, "enrich_compare_starout")

# Setup Bash variables

Sys.setenv(THREADS = threads)
Sys.setenv(MAX_JOBS = max_jobs)

# Input
Sys.setenv(RAW_FASTQS = raw_fastq.dir)

# Output
Sys.setenv(CUROUT = out.dir)
Sys.setenv(INFO = info.dir)
Sys.setenv(ADAPTERS = adapters.file)
Sys.setenv(TRIMMED = trimmed.dir)
Sys.setenv(GENOME_DIR = genome.dir)
Sys.setenv(TOTAL_SAMPLES_STAROUT = total_samples_starout.dir)
Sys.setenv(MOSDEPTH_OUT = mosdepth.dir)

Sys.setenv(FA_URL = fa_url)
Sys.setenv(GTF_URL = gtf_url)


Sys.setenv(GTF = gtf.file)
Sys.setenv(FA = fa.file)

Sys.setenv(GTF_WITH_MITO_RRNA = gtf_with_mito_rrna.file)
Sys.setenv(FA_WITH_MITO_RRNA = fa_for_mito_rrna.file)
Sys.setenv(GENOME_WITH_MITO_RRNA_DIR = genome_with_mito_rrna.dir)
Sys.setenv(RRNA_OLIGOS_FASTQ = rrna_oligos.fastq)
Sys.setenv(RRNA_OLIGO_STAROUT = rrna_oligo_starout.dir)
#--------------------------------
Sys.setenv(ENRICH_COMPARE_STAROUT = enrich_compare_starout.dir)



