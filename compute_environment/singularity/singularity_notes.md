# Build, Sign, and Push
singularity build --force --fakeroot ~/container_images/mar1_0005.sif \
  ~/project_repos/mar1_rnaseq/compute_environment/singularity/Singularity
singularity push -U ~/container_images/mar1_0005.sif library://granek/default/mar1

# Run From Sylabs Cloud
singularity run library://granek/default/mar1
