#!/bin/bash
#
# SCRIPTS 500 PLUS OBJECTS dump to json handler
#
# (C) 2016-2021 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
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
ScriptVersion=00.60.02
ScriptRevision=010
ScriptDate=2021-01-27
TemplateVersion=00.60.02
APISubscriptsVersion=00.60.02
APISubscriptsRevision=006

#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=500plus_objects_to_json_dump.lite
export APIScriptFileNameRoot=500plus_objects_to_json_dump
export APIScriptShortName=500plus_objects_1_json
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="500 PLUS OBJECTS dump to json handler"


# -------------------------------------------------------------------------------------------------
# Logging variables
# -------------------------------------------------------------------------------------------------


# Logging to nirvana
logfilepath=/dev/null


# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision} | tee -a -i ${logfilepath}
echo 'Script original call name :  '$0 | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ShowHelp - Show Help for the script
# -------------------------------------------------------------------------------------------------

# MODIFIED YYYY-MM-DD -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ShowHelp () {
    #
    # Show Help for the script
    #
    
    echo '500plus_objects_to_json_dump.lite.sh <objecttype> | [<details_level>]'
    echo "Version:  ${ScriptVersion}  Script Date:  ${ScriptDate}  Script Revision:  ${ScriptRevision}"
    echo
    echo 'Valid objecttype values:'
    echo '  hosts'
    echo '  networks'
    echo '  groups'
    echo '  groups-with-exclusion'
    echo '  address-ranges'
    echo '  dns-domains'
    echo '  security-zones'
    echo '  dynamic-objects'
    echo '  application-sites'
    echo '  application-site-categories'
    echo '  application-site-groups'
    echo '  tags'
    echo '  simple-gateways'
    echo '  times'
    echo '  time-groups'
    echo '  access-roles'
    echo '  opsec-applications'
    echo '  services-tcp'
    echo '  services-udp'
    echo '  services-icmp'
    echo '  services-icmp6'
    echo '  services-sctp'
    echo '  services-other'
    echo '  services-dce-rpc'
    echo '  services-rpc'
    echo '  service-groups'
    echo '  users'
    echo '  user-groups'
    echo '  user-templates'
    echo '  identity-tags'
    echo
    echo 'Valid details_level values:  full | standard'
    echo
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED YYYY-MM-DD

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#ShowHelp

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

if [ -z "$1" ]; then
    ShowHelp
    exit 1
fi

#OBJECTSTYPE=$1
#OBJECTSTYPE=${OBJECTSTYPE//\"}

OPT=$1
OPT=${OPT//\"}

case "${OPT}" in
    # Help and Standard Operations
    '-?' | --help )
        ShowHelp
        exit 1
        ;;
    # Handle missing first parameter but having second
    full | standard )
        ShowHelp
        exit 1
        ;;
    # valid values
    hosts )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    networks )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    groups )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'groups-with-exclusion' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'address-ranges' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'dns-domains' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'security-zones' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'dynamic-objects' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'application-sites' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'application-site-categories' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'application-site-groups' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    tags )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'simple-gateways' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    times )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'time-groups' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'access-roles' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'opsec-applications' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'services-tcp' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'services-udp' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'services-icmp' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'services-icmp6' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'services-sctp' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'services-other' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'services-dce-rpc' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'services-rpc' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'service-groups' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'users' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'user-groups' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'user-templates' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    'identity-tags' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        ;;
    # Anything unknown is recorded for later
    * )
        ShowHelp
        exit 1
        ;;
esac


COMMAND="mgmt_cli -r true show ${OBJECTSTYPE}"
LIMIT="500"
OFFSET="0"
if [ -z "$2" ]; then
    DETAILSSET=full
elif [ "$2" == "full" ]; then
    DETAILSSET=full
elif [ "$2" == "standard" ]; then
    DETAILSSET=standard
else
    DETAILSSET=full
fi

#Get Total number of items
echo "Running ${COMMAND}"
echo

TOTAL=`${COMMAND} limit 1 offset ${OFFSET} --format json details-level "standard" | jq '.total'`
echo "Total Elements = ${TOTAL}"
echo

#Loop through and get the data
while [ ${OFFSET} -lt ${TOTAL} ]; do
    OUTPUTFILE=test.${OBJECTSTYPE}.${DETAILSSET}'_'${OFFSET}.json
    echo "Getting data with offset of ${OFFSET}" to ${OUTPUTFILE}
    GETDATA=`${COMMAND} limit ${LIMIT} offset ${OFFSET} details-level "${DETAILSSET}" --format json | jq '.'`
    DATA=`echo ${GETDATA} | jq '.objects[]'`
    echo ${DATA} > ${OUTPUTFILE}
    OFFSET=`echo ${GETDATA} | jq '.to'`
done

echo 

ls -alh test.${OBJECTSTYPE}.${DETAILSSET}'_'*.json

echo 

jq -s '.' test.${OBJECTSTYPE}.${DETAILSSET}'_'*.json > total.${OBJECTSTYPE}.${DETAILSSET}.json
#rm -rf test*.json

OUTPUT_TOTAL=`cat total.${OBJECTSTYPE}.${DETAILSSET}.json | jq '.[].uid' | sort -u | wc -l`
echo "Data output to total.json with ${OUTPUT_TOTAL} elements"

# Make it pretty again

echo
echo "Make it pretty"
echo

#echo '[' > total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
#echo '  { ' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
#echo -n '    "objects": ' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
echo '{ ' > total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
echo -n '  "objects": ' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json

# need a way to read lines and dump them out
#cat total.${OBJECTSTYPE}.${DETAILSSET}.json >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json

COUNTER=0

while read -r line; do
    if [ ${COUNTER} -eq 0 ]; then
        # Line 0 first line we don't want to add a return yet
        echo -n 'Start:.'
    else
        # Lines 1+ are the data
        echo >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
        #echo -n '.'
    fi

    #Write the line, but not the carriage return
    echo -n "${line}" >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
    let COUNTER=COUNTER+1
done < total.${OBJECTSTYPE}.${DETAILSSET}.json

echo

#Write the last comma after the original json file that is not pretty
echo ',' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
#echo '    "from": 0,' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
#echo '    "to": '${OUTPUT_TOTAL}',' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
#echo '    "total": '${OUTPUT_TOTAL} >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
#echo '  }' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
#echo ']' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
echo '  "from": 0,' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
echo '  "to": '${OUTPUT_TOTAL}',' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
echo '  "total": '${OUTPUT_TOTAL} >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
echo '}' >> total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json

echo 
head -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json; echo '...'; tail -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
echo 

echo
echo "Now make it really pretty"
echo
jq -s '.[]' total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json > total.${OBJECTSTYPE}.${DETAILSSET}.reallypretty.json

echo 
head -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.reallypretty.json; echo '...'; tail -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.reallypretty.json
echo 

ls -alh total*.json

