#!/bin/bash

set -u
SINGULARITY_DIR="$HOME/container_images"
SINGULARITY_CACHEDIR="${SINGULARITY_CACHEDIR:-$SINGULARITY_DIR/cachedir}"
SINGULARITY_PULLFOLDER="${SINGULARITY_PULLFOLDER:-$SINGULARITY_DIR/pulldir}"
export SINGULARITY_CACHEDIR
export SINGULARITY_PULLFOLDER

SINGULARITY_IMAGE="${1:-library://granek/published/rna_enrichment:latest}"

DATA_BASE_DIR="${DATA_BASE_DIR:-$HOME}"
WORKSPACE_BASE_DIR="${WORKSPACE_BASE_DIR:-$HOME}"
SPACE_DIR="${SPACE_BASE_DIR:-$HOME}"

DATA="$DATA_BASE_DIR/rnaseq_enrichment/rawdata"
WORKSPACE="$WORKSPACE_BASE_DIR/rnaseq_enrichment/workspace"

 
if [ -d "${DATA}" ]; then
    # BIND_ARGS="--bind ${DATA}:/data:ro"
    BIND_ARGS="--bind ${DATA}:/data"
else
    echo "Make sure DATA exists: $DATA"
    echo "The location of DATA can be controlled by setting DATA_BASE_DIR before running this or in your .bashrc file"
    exit 1
fi

if [ -d "${WORKSPACE}" ]; then
    BIND_ARGS="$BIND_ARGS --bind ${WORKSPACE}:/workspace"
else
    echo "Make sure WORKSPACE exists: $WORKSPACE"
    echo "The location of WORKSPACE can be controlled by setting WORKSPACE_BASE_DIR before running this or in your .bashrc file"
    exit 1
fi

if [ -d "${SPACE_DIR}" ]; then
    BIND_ARGS="$BIND_ARGS --bind ${SPACE_DIR}:/space"
else
    echo "Make sure SPACE exists: $SPACE_DIR"
    echo "The location of SPACE can be controlled by setting SPACE_DIR before running this or in your .bashrc file"
    exit 1
fi


#-----------------
SINGTMP="${WORKSPACE_BASE_DIR}/.tmp/`date +%s`_tmp"
mkdir -p $SINGTMP
echo "Binding /tmp to $SINGTMP"

trap "{ rm -rf $SINGTMP; }" EXIT

BIND_ARGS="$BIND_ARGS --bind $SINGTMP:/tmp"
#-----------------

mkdir -p $SINGULARITY_PULLFOLDER $SINGULARITY_CACHEDIR
