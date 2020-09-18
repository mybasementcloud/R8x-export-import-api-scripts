#!/bin/bash
#
# SCRIPT test read operations
#
# (C) 2016-2020 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
#
# ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR 
# DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE 
# RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
# TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
# OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
# APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
# AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
#
#
ScriptVersion=00.60.00
ScriptRevision=000
ScriptDate=2020-09-10
TemplateVersion=00.60.00
APISubscriptsVersion=00.60.00
APISubscriptsRevision=006

#

export APIScriptVersion=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion//./x}
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
