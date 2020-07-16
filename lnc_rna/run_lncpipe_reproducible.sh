echo "Maybe revert to lncpipe version 0.2.4?: https://github.com/nf-core/lncpipe/archive/V0.2.4.tar.gz"
echo "also need to make docker/singularity image that has STAR"
exit 20

SCRATCH=/space/temp/run_lnc_pipe_001
# LNCPIPE_DIR=$SCRATCH/lncpipe-0.2.4
mkdir -p $SCRATCH

# wget --timestamping --directory-prefix $SCRATCH https://github.com/nf-core/lncpipe/archive/V0.2.4.tar.gz
# tar --directory $SCRATCH -zxf $SCRATCH/V0.2.4.tar.gz
git clone https://github.com/likelet/LncPipe.git $SCRATCH

ln -s $PWD/nextflow.config $SCRATCH/my_nextflow.config

cd $SCRATCH
git checkout 5f910bb0f9ebad0b766429d4b80c4a2e2b509be5
# nextflow run LncRNAanalysisPipe.nf -c my_nextflow.config -with-singularity docker://nfcore/lncpipe
