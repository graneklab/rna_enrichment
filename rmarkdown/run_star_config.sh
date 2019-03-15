set -u

# Run Configs
export THREADS=2
export MAX_JOBS=5

# Input
export RAW_FASTQS="/data/hts_2018_data/hts2018_pilot_rawdata"

# Output
export CUROUT=/workspace/2018_tot_samples
export INFO="$CUROUT/info"
export ADAPTERS="$INFO/neb_E7600_adapters_withrc.fasta"
export TRIMMED=$CUROUT/trimmed_fastqs
export GENOME_DIR=$CUROUT/genome
export STAR_OUT=$CUROUT/star_out
export MOSDEPTH_OUT=$CUROUT/mosdepth
# export FINAL_COUNTS=$DATA_BASE/star_counts

# Genome
SHARED_URL="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi"
export FA_URL="${SHARED_URL}/fasta/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/dna/Cryptococcus_neoformans_var_grubii_h99.CNA3.dna.toplevel.fa.gz"
export GTF_URL="${SHARED_URL}/gtf/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gtf.gz"
# export GFF=$(basename ${GFF_URL%.gz})
export GTF=${GENOME_DIR}/$(basename ${GTF_URL%.gz})
export FA=${GENOME_DIR}/$(basename ${FA_URL%.gz})
