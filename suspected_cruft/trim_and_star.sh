trim_and_star_func() {
    FASTQ=$1
    SAMPLE="$(basename ${FASTQ} .fastq.gz)" # directory and strip .fastq.gz file extension
    FASTQ_TRIMMED="$TRIMMED/${SAMPLE}_trimmed.fq.gz"
    echo $SAMPLE
    echo $FASTQ

    # make a pipe for trimmed fastq
    # CUR_PIPE=`mktemp --dry-run`_${SAMPLE}_pipe.fq
    # mkfifo $CUR_PIPE

    # Run fastq-mcf
    fastq-mcf \
        $ADAPTERS \
        $FASTQ \
        -o $FASTQ_TRIMMED \
        -q 20 -x 0.5
        
    STAR \
    --runMode alignReads \
    --runThreadN $THREADS \
    --genomeDir $GENOME_WITH_MITO_RRNA_DIR \
    --outSAMtype BAM SortedByCoordinate \
    --quantMode GeneCounts \
    --genomeLoad NoSharedMemory \
    --twopassMode None \
    --limitBAMsortRAM 1280000000 \
    --outFileNamePrefix ${ENRICH_COMPARE_STAROUT}/${SAMPLE}_ \
    --outFilterScoreMinOverLread 0 --outFilterMatchNminOverLread 0 \
    --outFilterMatchNmin 0 --outFilterMismatchNmax 2 \
    --readFilesCommand zcat \
    --readFilesIn $FASTQ_TRIMMED        
        
    # rm -f $CUR_PIPE
    samtools index ${ENRICH_COMPARE_STAROUT}/${SAMPLE}_Aligned.sortedByCoord.out.bam
}
export -f trim_and_star_func
