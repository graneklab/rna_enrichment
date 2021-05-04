# Primary metadata
- Label: library label used for demultiplexed data
- RNA_sample_num: unique identifier corresponding to a specific biological replicate, each RNA sample was used to make 2 or 3 libraries (using different enrichment methods, see below)
- Media: Two different media were used to grow samples: YPD is control, TC is treatment
- Strain: Two different strains (i.e. genotypes) were used: H99 is wildtype, mar1d is mutant
- Replicate: There were 12 biological replicates of each Media x Strain combination, the best 6 replicates (based on RNA QC) were sequenced

# Secondary metadata
- experiment_person: Replicates were prepared in two batches by two different people: S and C (TLDR: the first 6 replicates were prepared by S, but not all 6 met QC standards, so C prepared another 6 replicates of each  Media x Strain combination)
- libprep_person:  Libraries were prepared by 3 different people: C, J, and P
- enrichment_method: Three different enrichment methods were tested: RZ is RiboZero rRNA depletion, MA is polyA enrichment, and TOT is total RNA (i.e. no enrichment).  There are both RZ and MA libraries for all samples, TOT was only sequenced for three samples.
- RIN: RNA integrity number (i.e. RNA quality) for RNA sample
concentration_fold_difference:

# Tertiary metadata (probably irrelevant)
- i7 index: i7 barcode id
- i5 index: i5 barcode id
- i5 primer: i7 barcode sequence
- i7 primer: i5 barcode sequence
- library#: library number required by sequencing facility
