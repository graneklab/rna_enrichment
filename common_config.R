# Genome URLs
url_part1="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/"
url_part2="/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/"
url_part3="Cryptococcus_neoformans_var_grubii_h99.CNA3."

h99_ncrna_url = paste0(url_part1, "fasta", url_part2, "ncrna/", url_part3, "ncrna.fa.gz")
h99_cds_url = paste0(url_part1, "fasta", url_part2, "cds/", url_part3, "cds.all.fa.gz")
h99_genome_url = paste0(url_part1, "fasta", url_part2, "dna/", url_part3, "dna.toplevel.fa.gz")
h99_gtf_url= paste0(url_part1, "gtf", url_part2, url_part3, "39.gtf.gz")

fa_url = h99_genome_url
gtf_url = h99_gtf_url

basedir = "/workspace"
