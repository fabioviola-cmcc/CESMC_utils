#!/bin/bash

###############################################################
#
# Initialization
#
################################################################

DIVISION=opa
FILESETS=(/users_home/$DIVISION /work/$DIVISION /data/$DIVISION)


###############################################################
#
#
#
###############################################################

echo "Disk occupation:"

for FS in ${FILESETS[*]} ; do

    gpfsrepquota -f $FS | grep $USER | gawk '{
    useless1=$1
    useless2=$2
    user=$3
    fileset=$4
    used=$5
    softlimit=$6
    hardlimit=$7
    grace=$8

    # print
    printf "- FILESET %15s: using %s / %s\n", fileset, used, softlimit
    }'

done
