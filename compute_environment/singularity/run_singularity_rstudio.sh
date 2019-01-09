#!/bin/bash

# SINGULARITY_IMAGE="singularity run shub://granek/crne_transposon:rstudio --app rstudio"
SINGULARITY_DIR="$HOME/container_images"
SINGULARITY_CACHEDIR="$SINGULARITY_DIR/cachedir"
export SINGULARITY_CACHEDIR
SINGULARITY_PULLFOLDER="$SINGULARITY_DIR/pulldir"
export SINGULARITY_PULLFOLDER

# SINGULARITY_IMAGE="shub://granek/mar1_rnaseq:rstudio"
SINGULARITY_IMAGE="${1:-$SINGULARITY_DIR/mar1_rstudio.simg}"

DATA="/mnt/hts_scratch/Members/josh/hst2018/rawdata"
WORKSPACE="/mnt/hts_scratch/Members/josh/hst2018/workspace"

 
if [ -d "${DATA}" ]; then
  BIND_ARGS="--bind ${DATA}:/data:ro"
fi

# mkdir -p $WORKSPACE
if [ -d "${WORKSPACE}" ]; then
    BIND_ARGS="$BIND_ARGS --bind ${WORKSPACE}:/workspace"
else
    echo "Make sure WORKSPACE exists: $WORKSPACE"
fi
# 
# if [ -d "${H99_GENOME}" ]; then
#     BIND_ARGS="$BIND_ARGS --bind ${H99_GENOME}:${H99_GENOME}"
# fi

mkdir -p $SINGULARITY_PULLFOLDER $SINGULARITY_CACHEDIR
#--------------------------------------------------------------------------------

# Look for an open port to use in range $LOWERPORT to $UPPERPORT
LOWERPORT=8780
UPPERPORT=8799
while :
do
        RSTUDIO_PORT="`shuf -i $LOWERPORT-$UPPERPORT -n 1`"
        echo "Testing port: $RSTUDIO_PORT"
        ss -lpn | grep -q ":$RSTUDIO_PORT " || break
done

SESSION_BASEDIR="/tmp/$(basename $SINGULARITY_IMAGE)_${RSTUDIO_PORT}"
SESSION_INFO_FILE="$SESSION_BASEDIR/session_info_$(basename $SINGULARITY_IMAGE)_${RSTUDIO_PORT}.txt"
SESSION_TMP_DIR="$SESSION_BASEDIR/tmp"
SESSION_RSTUDIO_DIR="$SESSION_BASEDIR/rstudio"
mkdir -p $SESSION_TMP_DIR $SESSION_RSTUDIO_DIR
BIND_ARGS="$BIND_ARGS --bind ${SESSION_TMP_DIR}:/tmp --bind ${SESSION_RSTUDIO_DIR}:${HOME}/.rstudio"
echo $SESSION_INFO_FILE
export RSTUDIO_PASSWORD="`openssl rand -base64 16 | colrm 20`"
printf "Image:\t$SINGULARITY_IMAGE\n" > $SESSION_INFO_FILE
printf "\n\nRStudio URL:\t\thttp://`hostname -A | cut -f1 -d' '`:${RSTUDIO_PORT}/\n" >> $SESSION_INFO_FILE
printf "\nRStudio Username:\t$USER\n"  >> $SESSION_INFO_FILE
printf "RStudio Password:\t$RSTUDIO_PASSWORD\n" >> $SESSION_INFO_FILE

cat $SESSION_INFO_FILE
trap "{ rm -rf $SESSION_INFO_FILE $SESSION_BASEDIR; }" EXIT

singularity run  --app rstudio $BIND_ARGS $SINGULARITY_IMAGE --auth-none 0 --auth-pam-helper rstudio_auth --www-port $RSTUDIO_PORT --server-working-dir $HOME/mar1_rnaseq


