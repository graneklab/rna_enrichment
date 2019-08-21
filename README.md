
https://cloud.sylabs.io/library/granek/default/mar1

# Running Singularity Image
## Run From Sylabs Cloud
Run a mar1 container with `singularity run library://granek/default/mar1`

## /tmp issues
It is recommended to do one of the following when running this image. There is no need to do both:

1. Set "mount tmp = no" in `/etc/singularity/singularity.conf`.
2. If #1 is not an option, the following command can be used to bind mount `/tmp` in the container to a "private" tmp directory:
```
SINGTMP="/tmp/${USER}_$$_tmp"; mkdir -p $SINGTMP; singularity run --bind $SINGTMP:/tmp library://granek/default/mar1
```
### /tmp issues TLDR
If a second user tries on the same server tries to run an RStudio container they will have permission issues with `/tmp/rstudio-server`, which will be owned by the user who first ran an RStudio container.




# Build, Sign, and Push
singularity build --remote --force ~/container_images/mar1_rnaseq_0005.sif \
  ~/project_repos/mar1_rnaseq/compute_environment/singularity/Singularity
singularity push -U ~/container_images/mar1_rnaseq_0005.sif library://granek/default/mar1_rnaseq:latest

## Build remote
singularity build --force --fakeroot ~/container_images/mar1_0005.sif \
  ~/project_repos/mar1_rnaseq/compute_environment/singularity/Singularity



