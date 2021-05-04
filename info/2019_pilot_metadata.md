This dataset includes libraries from two different experiments:
Libraries with sample_year "2019" are from an experiment that seeks to identify genes that are differentially expressed when a mutant strain with a deletion of the SRE1 gene is grown under pH stress (pH8).  This experiment includes a WT strain (H99 wildtype) as a genotype control.  Both strains were also grown under control (pH4) conditions.

Libraries with sample_year "2018" are from an experiment that seeks to compare two different methods for rRNA depletion: polyA specific mRNA enrichment (M) and the RNaseH (H) method for targeted degradation of rRNA.  Undepleted total RNA (T) is included as a gold-standard control.  These libraries are made from RNA samples prepared for the 2018 course, all were H99 wildtype and were grown in YPD.

# Primary metadata
- Label: library label used for demultiplexed data
- sample_year: was this RNA sample prepared in 2018 or 2019?
- group: group that prepared the library (P is pilot)
- enrich_rep: for the RNaseH enrichment method there were two technical replicates of the enrichment for each RNA sample
- RNA_sample_num: identifier corresponding to a specific sample each RNA sample was used to make 1 or 3 libraries using different enrichment methods (see below). Note that sample_year AND RNA_sample_num are required to uniquely identify a sample since 2018 samples are UNRELATED to 2019 samples with the same number
- genotype: Two different strains (i.e. genotypes) were used: WT (H99 wildtype) and sre1d (deletion of the SRE1 gene in the H99 background)
- condition: Two different growth conditions were used for the 2019 samples: pH4 (control) and pH8 (stress treatment).  All of the 2018 samples were grown in YPD.
- bio_replicate: biological replicate of Media x Strain combination.  Each 2019 combination has 6 biological replicates, 2018 samples have 3 biological replicates.

# Secondary metadata
- libprep_person:  Libraries were prepared by 3 different people: C, J, and P
- enrichment_method: Three different enrichment methods were used: mRNA is polyA enrichment, RNaseH depletion of rRNA, and Total is total RNA (i.e. no enrichment).  All three methods were tested on 2018 samples, only mRNA was used for 2019 samples.
- enrichment_short: abbreviation of enrichment method mRNA (M), RNaseH (H), Total (T)

# Tertiary metadata (probably irrelevant)
- i7 index: i7 barcode id
- i5 index: i5 barcode id
- i5 primer: i7 barcode sequence
- i7 primer: i5 barcode sequence
- library_num: library number required by sequencing facility
- Nanodrop_260_280: ratio of absorbance at 260nm and 280nm, a measure of RNA extraction quality
- Nanodrop_260_230: ratio of absorbance at 260nm and 230nm, a measure of RNA extraction quality
- Nanodrop_concentration_ng_ul: RNA concentration as determined by nanodrop
- Bioanalyzer_concentration_ng_ul: RNA concentration as determined by nanodrop
- RIN_normal_threshold: RNA integrity number (i.e. RNA quality) for RNA sample
- RIN_lowered_threshold: RNA integrity number (i.e. RNA quality) for RNA sample

