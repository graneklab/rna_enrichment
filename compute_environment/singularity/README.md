
https://cloud.sylabs.io/library/granek/default/mar1

# Running Singularity Image
## Run From Sylabs Cloud
Run a mar1 container with `singularity run library://granek/default/mar1_rnaseq:latest`

## /tmp issues
It is recommended to do one of the following when running this image. There is no need to do both:

1. Set "mount tmp = no" in `/etc/singularity/singularity.conf`.
2. If #1 is not an option, the following command can be used to bind mount `/tmp` in the container to a "private" tmp directory:
```
SINGTMP="/tmp/${USER}_$$_tmp"; mkdir -p $SINGTMP; singularity run --bind $SINGTMP:/tmp library://granek/default/mar1_rnaseq:latest
```
### /tmp issues TLDR
If a second user tries on the same server tries to run an RStudio container they will have permission issues with `/tmp/rstudio-server`, which will be owned by the user who first ran an RStudio container.




# Build and Push
## Build with fakeroot
```
IMAGE_NUM=0003
IMAGE_NAME=rna_enrichment_${IMAGE_NUM}.sif
IMAGE_PATH=$HOME/container_images/${IMAGE_NAME}

singularity build --force --fakeroot $IMAGE_PATH \
  ~/project_repos/mar1_rnaseq/compute_environment/singularity/Singularity

singularity push -U $IMAGE_PATH library://granek/published/rna_enrichment:latest
singularity push -U $IMAGE_PATH library://granek/published/rna_enrichment:${IMAGE_NUM}
```

## Build Remote
`--fakeroot` is not enabled on some machines, in this case the `--remote` option can be used instead to build on the Sylabs Cloud.  This requires setting up an account.
