#!/bin/bash

# SINGULARITY_IMAGE="singularity run shub://granek/crne_transposon:rstudio --app rstudio"
SINGULARITY_DIR="$HOME/container_images"
SINGULARITY_CACHEDIR="$SINGULARITY_DIR/cachedir"
export SINGULARITY_CACHEDIR
SINGULARITY_PULLFOLDER="$SINGULARITY_DIR/pulldir"
export SINGULARITY_PULLFOLDER

# SINGULARITY_IMAGE="shub://granek/mar1_rnaseq:rstudio"
SINGULARITY_IMAGE="${1:-$SINGULARITY_DIR/mar1_rstudio.simg}"

DATA="/mnt/hts_scratch/Members/josh/hst2018"
 
if [ -d "${DATA}" ]; then
  BIND_ARGS="--bind ${DATA}:/data"
fi

# WORKSPACE="/home/crypto2/josh"
# H99_GENOME="/home/crypto1"
# 
# if [ -d "${WORKSPACE}" ]; then
#     BIND_ARGS="--bind ${WORKSPACE}:${WORKSPACE}"
# fi
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

SESSION_INFO_FILE="session_info_$(basename $SINGULARITY_IMAGE)_${RSTUDIO_PORT}.txt"
echo $SESSION_INFO_FILE
export RSTUDIO_PASSWORD="`openssl rand -base64 16 | colrm 20`"
printf "\n\nRStudio URL:\t\thttp://`hostname -A | cut -f1 -d' '`:${RSTUDIO_PORT}/\n" > $SESSION_INFO_FILE
printf "\nRStudio Username:\t$USER\n"  >> $SESSION_INFO_FILE
printf "RStudio Password:\t$RSTUDIO_PASSWORD\n" >> $SESSION_INFO_FILE

cat $SESSION_INFO_FILE
trap "{ rm -f $SESSION_INFO_FILE; }" EXIT

singularity run  --app rstudio $BIND_ARGS $SINGULARITY_IMAGE --auth-none 0 --auth-pam-helper rstudio_auth --www-port $RSTUDIO_PORT


