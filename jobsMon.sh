#!/bin/bash

############################################
#
# Input params
#
############################################

NUMPROC=$1
if [[ -z $1 ]]; then
    echo "ERROR! Number of processes to analyse must be specified!"
    exit 255
fi

# check if a username was provided, otherwise use current user
U=$2
if [[ -z $2 ]]; then
    U=$USER
fi



############################################
#
# Initial config
#
############################################

source ~/.bashrc
source ~/.bash_profile
export DIVISION=opa


############################################
#
# Job resources
#
############################################

JOBS_REPORT=""
USEDPERC=0

echo "================================================================================="

bjobs -u $U -a -o "jobid avg_mem max_mem memlimit" | sed s/bytes//g | grep -e "-$" -v  | tail -n $NUMPROC 2> /dev/null

echo "================================================================================="
echo

while IFS=' ' read -r usedmem usedmemunit reqmem reqmemunit; do

    # skip lines with empty fields
    if [[ $usedmem = "-" ]]; then
	continue
    fi

    if [[ $reqmem = "-" ]]; then
	continue
    fi
    
    # convert used memory to GB
    if [[ $usedmemunit = "G" ]]; then
	usedmem=$(echo "$usedmem * 1024" | bc -l)
	usedmemunit=M
    fi

    # convert required memory to GB
    if [[ $reqmemunit = "G" ]]; then
	reqmem=$(echo "$reqmem * 1024" | bc -l)
	reqmemunit=M
    fi

    # determine percentage of used memory
    THIS_USEDPERC=$(echo "100 * $usedmem / $reqmem" | bc -l)
    USEDPERC=$(echo "$USEDPERC + $THIS_USEDPERC" | bc -l)
    NUMPROC=$(echo "$NUMPROC + 1" | bc -l)
    
done < <(bjobs -u $U -a -o "max_mem memlimit" -noheader | sed s/bytes//g | grep -e "-$" -v | tail -n $NUMPROC 2> /dev/null)


if [[ $NUMPROC -eq 0 ]]; then
    AVG_USEDPERC=-1
    echo "__________________________"
    echo "User $U has used ${AVG_USEDPERC} %"
    echo "__________________________"

else
    AVG_USEDPERC=$(echo "$USEDPERC / $NUMPROC" | bc -l)
    AVG_USEDPERC=$(printf "%0.2f" $AVG_USEDPERC)
    echo "User $U has used ${AVG_USEDPERC} % of the requested memory"
fi

echo
echo "================================================================================="
