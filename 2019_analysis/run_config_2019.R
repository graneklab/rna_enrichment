# Libraries
library(fs)
library(dplyr)

source("../common_config.R")

# input
metadata.file=here("info/2019_pilot_metadata.tsv")
metadata_2018.file=here("info/2018_pilot_metadata.tsv")

# output

trimmed.dir=file.path(outdir_2019, "trimmed_fastqs")

rrna_oligo_starout.dir=file.path(outdir_2019, "rrna_oligo_starout")

Sys.setenv(TRIMMED = trimmed.dir)
Sys.setenv(FA_URL = fa_url)
Sys.setenv(GTF_WITH_MITO_RRNA = gtf_with_mito_rrna.file)
Sys.setenv(FA_WITH_MITO_RRNA = fa_for_mito_rrna.file)
Sys.setenv(RRNA_OLIGO_STAROUT = rrna_oligo_starout.dir)
# #--------------------------------
Sys.setenv(ENRICH_COMPARE_STAROUT = starout_2019_dir)
# 
count_suffix = "_ReadsPerGene.out.tab"
bam_suffix = "_Aligned.sortedByCoord.out.bam"
# #--------------------------------
