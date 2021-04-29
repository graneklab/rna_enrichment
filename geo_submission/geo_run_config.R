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
processed_files_table_tsv=file.path(table_dir, "processed_files_table.tsv")
raw_files_table_tsv=file.path(table_dir, "raw_files_table.tsv")

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

adapters.file= file.path(info.dir, "neb_e7600_adapters_withrc.fasta")
Sys.setenv(ADAPTERS = adapters.file)
