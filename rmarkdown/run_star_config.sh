set -u

# Run Configs
export THREADS=2
export MAX_JOBS=10

# Input
export DATA_BASE="/data/hts2018_pilot"
export RAW_FASTQS="$DATA_BASE/Granek_4837_180427A5"

# Output
export CUROUT=/workspace/2018_tot_samples
export INFO="$CUROUT/info"
export ADAPTERS="$INFO/neb_E7600_adapters_withrc.fasta"
export TRIMMED=$CUROUT/trimmed_fastqs
export GENOME_DIR=$CUROUT/genome
export STAR_OUT=$CUROUT/star_out
export FINAL_COUNTS=$DATA_BASE/star_counts

# Genome
SHARED_URL="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi"
export FA_URL="${SHARED_URL}/fasta/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/dna/Cryptococcus_neoformans_var_grubii_h99.CNA3.dna.toplevel.fa.gz"
export GTF_URL="${SHARED_URL}/gtf/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gtf.gz"
# export GFF=$(basename ${GFF_URL%.gz})
export GTF=${GENOME_DIR}/$(basename ${GTF_URL%.gz})
export FA=${GENOME_DIR}/$(basename ${FA_URL%.gz})
