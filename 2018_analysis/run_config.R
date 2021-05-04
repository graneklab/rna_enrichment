# Libraries
source("../common_config.R")
library(fs)
library(dplyr)


# input
# raw_fastq.dir="/data/hts_2018_data/hts2018_pilot_rawdata"
metadata.file=here("info/2018_pilot_metadata.tsv")


# output
info.dir=file.path(out.dir, "info")
adapters.file= file.path(info.dir, "neb_e7600_adapters_withrc.fasta")
adapters.fastqc= file.path(info.dir, "neb_e7600_adapters_fastqc.txt")

trimmed.dir=file.path(out.dir, "trimmed_fastqs")
genome.dir=file.path(out.dir, "genome")
total_samples_starout.dir=file.path(out.dir, "total_samples_starout")
mosdepth.dir=file.path(out.dir, "mosdepth")
seq.dir = file.path(out.dir, "seq_out"); dir.create(seq.dir, recursive = TRUE)
# export final_counts=$data_base/star_counts
igv_tarball = file.path(out.dir, "visualize_oligos.tgz")
qc.dir = file.path(out.dir, "qc"); dir.create(qc.dir, recursive = TRUE)
qc.raw.dir = file.path(qc.dir, "raw_read_qc"); dir.create(qc.raw.dir, recursive = TRUE)
qc.trim.dir = file.path(qc.dir, "trimmed_read_qc"); dir.create(qc.trim.dir, recursive = TRUE)

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


gtf.file %>%
  path_file %>%
  path_ext_remove %>%
  paste0("__with_mito_rrna.gtf") %>%
  file.path(seq.dir, .) ->
  gtf_with_mito_rrna.file

file_S2_path = file.path(fig.dir, "File_S2.gtf")

rrna_oligos.file = file.path(fig.dir, "rrna_oligos.tsv")
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
oligo_bam.file = file.path(rrna_oligo_starout.dir, "rrna_oligos_Aligned.sortedByCoord.out.bam")

# Setup Bash variables

# Input
# Sys.setenv(RAW_FASTQS = raw_fastq.dir)

# Output
Sys.setenv(CUROUT = out.dir)
Sys.setenv(INFO = info.dir)
Sys.setenv(ADAPTERS = adapters.file)
Sys.setenv(FASTQC_ADAPTERS = adapters.fastqc)
Sys.setenv(TRIMMED = trimmed.dir)
Sys.setenv(GENOME_DIR = genome.dir)
Sys.setenv(TOTAL_SAMPLES_STAROUT = total_samples_starout.dir)
Sys.setenv(MOSDEPTH_OUT = mosdepth.dir)
Sys.setenv(QC_DIR = qc.dir)
Sys.setenv(QC_RAW_DIR = qc.raw.dir)
Sys.setenv(QC_TRIM_DIR = qc.trim.dir)

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

count_suffix = "_ReadsPerGene.out.tab"
bam_suffix = "_Aligned.sortedByCoord.out.bam"


