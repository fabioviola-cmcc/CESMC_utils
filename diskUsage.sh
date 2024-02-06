#!/bin/bash

###############################################################
#
# Initialization
#
################################################################

DIVISION=opa; 

FILESETS=(/users_home/$DIVISION /work/$DIVISION /data/$DIVISION)
if [[ -z $1 ]]; then
    user=$USER
else
    user=$1
fi


###############################################################
#
#
#
###############################################################

echo "Disk occupation for user $user:"

for FS in ${FILESETS[*]} ; do

    gpfsrepquota -f $FS | grep $user | gawk '{
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
