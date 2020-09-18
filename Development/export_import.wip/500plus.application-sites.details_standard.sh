#!/bin/bash
#
# SCRIPTS 500 PLUS OBJECTS handler
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

COMMAND="mgmt_cli -r true show application-sites"
LIMIT="500"
OFFSET="0"
DETAILSSET=standard

#Get Total number of items
echo "Running $COMMAND"
echo

TOTAL=`$COMMAND limit 1 offset $OFFSET --format json details-level "standard" |jq '.total'`
echo "Total Elements = $TOTAL"
echo

#Loop through and get the data
while [ $OFFSET -lt $TOTAL ]; do
    OUTPUTFILE=test_$DETAILSSET'_'$OFFSET.json
    echo "Getting data with offset of $OFFSET" to $OUTPUTFILE
    GETDATA=`$COMMAND limit $LIMIT offset $OFFSET details-level "$DETAILSSET" --format json |jq '.'`
    DATA=`echo $GETDATA |jq '.objects[]'`
    echo $DATA > $OUTPUTFILE
    OFFSET=`echo $GETDATA |jq '.to'`
done

echo 

ls -alh test_$DETAILSSET'_'*.json

echo 

jq -s '.' test_$DETAILSSET'_'*.json > total.$DETAILSSET.json
#rm -rf test*.json

OUTPUT_TOTAL=`cat total.$DETAILSSET.json |jq '.[].uid' |sort -u |wc -l`
echo "Data output to total.json with $OUTPUT_TOTAL elements"

# Make it pretty again

echo
echo "Make it pretty"
echo

#echo '[' > total.$DETAILSSET.pretty.json
#echo '  { ' >> total.$DETAILSSET.pretty.json
#echo -n '    "objects": ' >> total.$DETAILSSET.pretty.json
echo '{ ' > total.$DETAILSSET.pretty.json
echo -n '  "objects": ' >> total.$DETAILSSET.pretty.json

# need a way to read lines and dump them out
#cat total.$DETAILSSET.json >> total.$DETAILSSET.pretty.json

COUNTER=0

while read -r line; do
    if [ $COUNTER -eq 0 ]; then
        # Line 0 first line we don't want to add a return yet
        echo -n 'Start:.'
    else
        # Lines 1+ are the data
        echo >> total.$DETAILSSET.pretty.json
        #echo -n '.'
    fi

    #Write the line, but not the carriage return
    echo -n "$line" >> total.$DETAILSSET.pretty.json
    let COUNTER=COUNTER+1
done < total.$DETAILSSET.json

echo

#Write the last comma after the original json file that is not pretty
echo ',' >> total.$DETAILSSET.pretty.json
#echo '    "from": 0,' >> total.$DETAILSSET.pretty.json
#echo '    "to": '$OUTPUT_TOTAL',' >> total.$DETAILSSET.pretty.json
#echo '    "total": '$OUTPUT_TOTAL >> total.$DETAILSSET.pretty.json
#echo '  }' >> total.$DETAILSSET.pretty.json
#echo ']' >> total.$DETAILSSET.pretty.json
echo '  "from": 0,' >> total.$DETAILSSET.pretty.json
echo '  "to": '$OUTPUT_TOTAL',' >> total.$DETAILSSET.pretty.json
echo '  "total": '$OUTPUT_TOTAL >> total.$DETAILSSET.pretty.json
echo '}' >> total.$DETAILSSET.pretty.json

echo 
head -n 10 total.$DETAILSSET.pretty.json; echo '...'; tail -n 10 total.$DETAILSSET.pretty.json
echo 

echo
echo "Now make it really pretty"
echo
jq -s '.[]' total.$DETAILSSET.pretty.json > total.$DETAILSSET.reallypretty.json

echo 
head -n 10 total.$DETAILSSET.reallypretty.json; echo '...'; tail -n 10 total.$DETAILSSET.reallypretty.json
echo 

ls -alh total*.json

