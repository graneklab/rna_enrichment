echo "Maybe revert to lncpipe version 0.2.4?: https://github.com/nf-core/lncpipe/archive/V0.2.4.tar.gz"
echo "also need to make docker/singularity image that has STAR"
# exit 20

SCRATCH=/space/temp/run_lnc_pipe_001
LNCPIPE_DIR=$SCRATCH/lncpipe
GENOME_DIR=$SCRATCH/genome
FA=$GENOME_DIR/Cryptococcus_neoformans_var_grubii_h99_gca_000149245.CNA3.dna.toplevel.fa
GTF=$GENOME_DIR/Cryptococcus_neoformans_var_grubii_h99_gca_000149245.CNA3.46.gtf
# SINGULARITY_IMAGE="docker://granek/lncpipe"
SINGULARITY_IMAGE="docker://bioinformatist/lncpipe"

mkdir -p $SCRATCH $GENOME_DIR

# Download Genome

wget -P $GENOME_DIR "ftp://ftp.ensemblgenomes.org/pub/release-46/fungi/fasta/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99_gca_000149245/dna/Cryptococcus_neoformans_var_grubii_h99_gca_000149245.CNA3.dna.toplevel.fa.gz"
gunzip -f ${FA}.gz
wget -P $GENOME_DIR "ftp://ftp.ensemblgenomes.org/pub/release-46/fungi/gtf/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99_gca_000149245/Cryptococcus_neoformans_var_grubii_h99_gca_000149245.CNA3.46.gtf.gz"
gunzip -f ${GTF}.gz

# cd $GENOME_DIR
singularity exec --bind $GENOME_DIR:$GENOME_DIR $SINGULARITY_IMAGE STAR \
    --runMode genomeGenerate \
    --genomeDir $GENOME_DIR \
    --genomeFastaFiles ${FA} \
    --sjdbGTFfile ${GTF} \
    --genomeSAindexNbases 11

# wget --timestamping --directory-prefix $SCRATCH https://github.com/nf-core/lncpipe/archive/V0.2.4.tar.gz
# tar --directory $SCRATCH -zxf $SCRATCH/V0.2.4.tar.gz
git clone https://github.com/likelet/LncPipe.git $LNCPIPE_DIR

ln -s $PWD/nextflow.config $LNCPIPE_DIR/my_nextflow.config

cd $LNCPIPE_DIR
git checkout 5f910bb0f9ebad0b766429d4b80c4a2e2b509be5
# nextflow run LncRNAanalysisPipe.nf -c my_nextflow.config -with-singularity docker://nfcore/lncpipe
# nextflow run LncRNAanalysisPipe.nf -c my_nextflow.config -profile standard,singularity
nextflow run LncRNAanalysisPipe.nf -c my_nextflow.config -with-singularity $SINGULARITY_IMAGE

echo $SCRATCH
echo "NEED TO AUTO FIX PATHS IN my_nextflow.config"
