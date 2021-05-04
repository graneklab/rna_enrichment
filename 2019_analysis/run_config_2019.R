# Libraries
library(fs)
library(dplyr)

source("../common_config.R")

metadata.file=here("info/2019_pilot_metadata.tsv")

# input
metadata_2018.file=here("info/2018_pilot_metadata.tsv")

# 
# # output
out.dir="/workspace/2019_enrich_samples"
RZ_out.dir="/workspace/2018_tot_samples"

trimmed.dir=file.path(out.dir, "trimmed_fastqs")
enrich_samples_starout.dir=file.path(out.dir, "enrich_samples_starout")
RZ_enrich_samples_starout.dir=file.path(RZ_out.dir,"enrich_compare_starout")

rrna_oligo_starout.dir=file.path(out.dir, "rrna_oligo_starout")
enrich_compare_starout.dir=file.path(out.dir, "enrich_compare_starout")
Sys.setenv(INFO = info.dir)
Sys.setenv(ADAPTERS = adapters.file)
Sys.setenv(TRIMMED = trimmed.dir)
Sys.setenv(FA_URL = fa_url)
Sys.setenv(GTF_WITH_MITO_RRNA = gtf_with_mito_rrna.file)
Sys.setenv(FA_WITH_MITO_RRNA = fa_for_mito_rrna.file)
Sys.setenv(RRNA_OLIGO_STAROUT = rrna_oligo_starout.dir)
# #--------------------------------
Sys.setenv(ENRICH_COMPARE_STAROUT = enrich_compare_starout.dir)
# 
count_suffix = "_ReadsPerGene.out.tab"
bam_suffix = "_Aligned.sortedByCoord.out.bam"
# #--------------------------------

# From combined_config.R
starout_2019_dir="/workspace/2019_enrich_samples/enrich_compare_starout"
starout_2018_dir="/workspace/2018_tot_samples/enrich_compare_starout"

