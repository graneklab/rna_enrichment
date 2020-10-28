# # Libraries
source("../common_config.R")

geo_base_dir="/workspace/geo_dir"

geo_upload_dir=file.path(geo_base_dir, "upload_to_geo")

geo_fastq_dir=file.path(geo_upload_dir, "raw_fastqs")
dir.create(geo_fastq_dir, recursive = TRUE)

pilot2018_fastq_dir = file.path(geo_fastq_dir, "hts_2018_data", "hts2018_pilot_rawdata")
pilot2019_fastq_dir = file.path(geo_fastq_dir, "hts_2019_data", "hts2019_pilot_rawdata")

Sys.setenv(FASTQ_2018_DIR = pilot2018_fastq_dir)
Sys.setenv(FASTQ_2019_DIR = pilot2019_fastq_dir)

                      
# output
info.dir=file.path(geo_base_dir, "info")
Sys.setenv(INFO = info.dir)

genome.dir=file.path(geo_base_dir, "genome")
Sys.setenv(GENOME_DIR = genome.dir)

geo_starout_dir=file.path(geo_upload_dir, "geo_starout")
Sys.setenv(GEO_STAROUT_DIR = geo_starout_dir)

pilot2019_count_dir = geo_starout_dir
pilot2018_count_dir = geo_starout_dir


table_dir=file.path(geo_base_dir, "table_dir")
dir.create(table_dir)
sample_table_tsv=file.path(table_dir, "sample_table.tsv")


# genome
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

Sys.setenv(FA_URL = fa_url)
Sys.setenv(GTF_URL = gtf_url)
Sys.setenv(GTF = gtf.file)
Sys.setenv(FA = fa.file)


# library(fs)
# library(dplyr)
# 
# # Setup R variables
threads=3
max_jobs=4
Sys.setenv(THREADS = threads)
Sys.setenv(MAX_JOBS = max_jobs)

adapters.file= file.path(info.dir, "neb_e7600_adapters_withrc.fasta")
Sys.setenv(ADAPTERS = adapters.file)

# 
# # input
# raw_fastq.dir="/data/hts_2018_data/hts2018_pilot_rawdata"
# metadata.file=file.path(raw_fastq.dir, "2018_pilot_metadata.tsv")
# 
# # output
# trimmed.dir=file.path(out.dir, "trimmed_fastqs")
# total_samples_starout.dir=file.path(out.dir, "total_samples_starout")
# mosdepth.dir=file.path(out.dir, "mosdepth")
# seq.dir = file.path(out.dir, "seq_out"); dir.create(seq.dir, recursive = TRUE)
# # export final_counts=$data_base/star_counts
# igv_tarball = file.path(out.dir, "visualize_oligos.tgz")
# 

# 
# rrna_oligos.file = file.path(seq.dir, "rrna_oligos.tsv")
# rrna_oligos.fastq = file.path(seq.dir, "rrna_oligos.fastq")
# rrna_oligos.fastq = file.path(seq.dir, "rrna_oligos.fastq")
# 
# # Genome with mito rRNA
# genome_with_mito_rrna.dir=file.path(out.dir, "genome_with_mito_rrna")
# fa.file %>% 
#   basename %>%
#   file.path(genome_with_mito_rrna.dir, .) ->
#   fa_for_mito_rrna.file
# 
# rrna_oligo_starout.dir=file.path(out.dir, "rrna_oligo_starout")
# enrich_compare_starout.dir=file.path(out.dir, "enrich_compare_starout")
# oligo_bam.file = file.path(rrna_oligo_starout.dir, "rrna_oligos_Aligned.sortedByCoord.out.bam")
# 
# # Setup Bash variables
# 
# 
# # Input
# Sys.setenv(RAW_FASTQS = raw_fastq.dir)
# 
# # Output
# Sys.setenv(CUROUT = out.dir)
# Sys.setenv(TRIMMED = trimmed.dir)

# Sys.setenv(TOTAL_SAMPLES_STAROUT = total_samples_starout.dir)
# Sys.setenv(MOSDEPTH_OUT = mosdepth.dir)
# 

# 
# Sys.setenv(GTF_WITH_MITO_RRNA = gtf_with_mito_rrna.file)
# Sys.setenv(FA_WITH_MITO_RRNA = fa_for_mito_rrna.file)
# Sys.setenv(GENOME_WITH_MITO_RRNA_DIR = genome_with_mito_rrna.dir)
# Sys.setenv(RRNA_OLIGOS_FASTQ = rrna_oligos.fastq)
# Sys.setenv(RRNA_OLIGO_STAROUT = rrna_oligo_starout.dir)
# #--------------------------------
# Sys.setenv(ENRICH_COMPARE_STAROUT = enrich_compare_starout.dir)
# 
# count_suffix = "_ReadsPerGene.out.tab"
# bam_suffix = "_Aligned.sortedByCoord.out.bam"
# 
# 
