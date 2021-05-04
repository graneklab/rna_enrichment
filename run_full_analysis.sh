#!/bin/bash

set -u
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source ${SCRIPT_DIR}/setup.sh

# singularity exec $BIND_ARGS $SINGULARITY_IMAGE Rscript -e "rmarkdown::render('${SCRIPT_DIR}/2018_analysis/test_callr.Rmd')"
singularity exec $BIND_ARGS $SINGULARITY_IMAGE Rscript -e "rmarkdown::render('${SCRIPT_DIR}/2018_analysis/meta_run_rrna_analysis.Rmd')"
singularity exec $BIND_ARGS $SINGULARITY_IMAGE Rscript -e "rmarkdown::render('${SCRIPT_DIR}/2019_analysis/meta_run_rrna_analysis_2019.Rmd')"

