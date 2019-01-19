#!/bin/bash
#
# SCRIPT test read operations
#
# (C) 2016-2019 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
#
ScriptVersion=00.33.00
ScriptRevision=000
ScriptDate=2019-01-18
TemplateVersion=00.33.00
CommonScriptsVersion=00.33.00
CommonScriptsRevision=005

#

export APIScriptVersion=v${ScriptVersion//./x}
export APIExpectedCommonScriptsVersion=v${CommonScriptsVersion//./x}
export APIExpectedActionScriptsVersion=v${ScriptVersion//./x}
ScriptName=cli_api_append_csv_error_handling_to_csv_file

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
        echo "$i"',"ignore-warnings","ignore-errors","set-if-exists"' > $filerefactor
    else
        # Lines 1+ are the data
        echo "$i"',true,true,true' >> $filerefactor
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
