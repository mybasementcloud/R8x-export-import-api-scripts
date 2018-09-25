#!/bin/bash
#
# SCRIPT test read operations
#
ScriptVersion=00.30.00
ScriptDate=2018-09-21

#

export APIScriptVersion=v00x30x00
ScriptNamecli_api_append_csv_error_handling_to_csv_file

# =================================================================================================
# =================================================================================================
# START script
# =================================================================================================
# =================================================================================================


export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export fileresults=api_add_csv_error_handling_to_csv_file_results_$DATEDTGS.txt
#export fileimport=hosts_1.csv
export fileimport=$1
export filerefactor=$1.refactor.csv

FILELINEARR=()

#read -r -a $FILELINEARR -u $fileimport

echo
echo 'Collect File into array :'
echo

while read -r line; do
    FILELINEARR+=("$line")
    echo -n '.'
done < $fileimport

echo
echo 'Dump file array and refactor lines :'
echo

COUNTER=0

for i in "${FILELINEARR[@]}"; do
    echo "$COUNTER >>$i<<" | tee -a -i $fileresults
    if [ $COUNTER -eq 0 ]; then
        # Line 0 is the header
        echo '"ignore-warnings","ignore-errors","set-if-exists",'"$i" > $filerefactor
    else
        # Lines 1+ are the data
        echo '"true","true","true",'"$i" >> $filerefactor
    fi
    let COUNTER=COUNTER+1
done

echo | tee -a -i $fileresults

echo "Refactored file:" | tee -a -i $fileresults
echo | tee -a -i $fileresults
cat $filerefactor | tee -a -i $fileresults
echo | tee -a -i $fileresults

echo
echo 'Done!'
echo

echo 'Input File      :  '$fileimport
echo 'Refactored File :  '$filerefactor
echo 'Operations log  :  '$fileresults
echo
