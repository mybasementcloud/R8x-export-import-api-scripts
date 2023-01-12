#!/bin/bash
#
# (C) 2016-2023 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
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
# -#- Start Making Changes Here -#- 
#
# SCRIPTS 500 PLUS OBJECTS dump to json handler
#
#
ScriptVersion=00.60.12
ScriptRevision=100
ScriptSubRevision=275
ScriptDate=2023-01-10
TemplateVersion=00.60.12
APISubscriptsLevel=010
APISubscriptsVersion=00.60.12
APISubscriptsRevision=100


#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=500plus_objects_to_single_json_in_dump.lite
export APIScriptFileNameRoot=500plus_objects_to_single_json_in_dump
export APIScriptShortName=500plus_objects_1_json
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="500 PLUS OBJECTS dump to json handler"

# =================================================================================================
# =================================================================================================
# START script
# =================================================================================================
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START Initial Script Setup
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# =================================================================================================
# START:  Setup Root Parameters
# =================================================================================================


export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export dtgs_script_start=`date -u +%F-%T-%Z`

#
# rootsafeworkpath     :  This is the path where it is safe to store scripts, to survive upgrades and patching
# customerpathroot     :  Path to the customer work environment, should be under ${rootsafeworkpath}
# scriptspathroot      :  Path to the folder with bash 4 Check Point scripts installation (b4CP)
#

export rootsafeworkpath=/var/log
export customerpathroot=${rootsafeworkpath}/__customer
export scriptspathroot=${customerpathroot}/upgrade_export/scripts

export rootscriptconfigfile=__root_script_config.sh

export logfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log

export dtzs='date -u +%Y%m%d-%T-%Z'
export dtzsep=' | '


# -------------------------------------------------------------------------------------------------
# UI Display Prefix Parameters, check if user has set environment preferences
# -------------------------------------------------------------------------------------------------


export dot_enviroinfo_file='.environment_info.json'
export dot_enviroinfo_path=${customerpathroot}
export dot_enviroinfo_fqpn=
if [ -r "./${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path='.'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "../${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path='..'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "${scriptspathroot}/${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path=${scriptspathroot}
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "${customerpathroot}/${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path=${customerpathroot}
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
else
    export dot_enviroinfo_path='.'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
fi

if [ -r ${dot_enviroinfo_fqpn} ] ; then
    getdtzs=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."dtzs"`
    readdtzs=${getdtzs}
    if [ x"${readdtzs}" != x"" ] ; then
        export dtzs=${readdtzs}
    fi
    getdtzsep=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."dtzsep"`
    readdtzsep=${getdtzsep}
    if [ x"${readdtzsep}" != x"" ] ; then
        export dtzsep=${readdtzsep}
    fi
fi


# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script original call name :  '$0 | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ShowHelp - Show Help for the script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-13 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    echo '  tags'
    echo '  simple-gateways'
    echo '  times'
    echo '  time-groups'
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
    echo '  application-sites'
    echo '  application-site-categories'
    echo '  application-site-groups'
    echo '  users'
    echo '  user-groups'
    echo '  user-templates'
    echo '  access-roles'
    echo '  identity-tags'
    echo
    echo 'Valid details_level values:  full | standard'
    echo
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-04-13

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#ShowHelp

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

if [ -z "${1}" ]; then
    ShowHelp
    exit 1
fi

#OBJECTSTYPE=${1}
#OBJECTSTYPE=${OBJECTSTYPE//\"}
#OBJECTSTYPE=${OBJECTSTYPE//\'}

OPT=${1}
OPT=${OPT//\"}
OPT=${OPT//\'}

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
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    networks )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    groups )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'groups-with-exclusion' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'address-ranges' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'dns-domains' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'security-zones' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'dynamic-objects' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    tags )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'simple-gateways' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    times )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'time-groups' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'opsec-applications' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'services-tcp' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'services-udp' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'services-icmp' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'services-icmp6' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'services-sctp' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'services-other' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'services-dce-rpc' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'services-rpc' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'service-groups' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'application-sites' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'application-site-categories' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'application-site-groups' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'users' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'user-groups' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'user-templates' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'access-roles' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    'identity-tags' )
        OBJECTSTYPE=${OPT}
        OBJECTSTYPE=${OBJECTSTYPE//\"}
        OBJECTSTYPE=${OBJECTSTYPE//\'}
        ;;
    # Anything unknown is recorded for later
    * )
        ShowHelp
        exit 1
        ;;
esac


if [ -z "${2}" ]; then
    DETAILSSET=full
elif [ "${2}" == "full" ]; then
    DETAILSSET=full
elif [ "${2}" == "standard" ]; then
    DETAILSSET=standard
else
    DETAILSSET=full
fi


COMMAND="mgmt_cli -r true show ${OBJECTSTYPE}"
LIMIT="500"
OFFSET="0"


export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export OUTPUTFOLDER=./dump/${DATEDTGS}.${OBJECTSTYPE}'_1-json'
export OUTPUTFILEPREFIX=test.${OBJECTSTYPE}.${DETAILSSET}

if [ ! -r ${OUTPUTFOLDER} ] ; then
    mkdir -p -v ${OUTPUTFOLDER} >> ${logfilepath} 2>&1
    chmod 775 ${OUTPUTFOLDER} >> ${logfilepath} 2>&1
else
    chmod 775 ${OUTPUTFOLDER} >> ${logfilepath} 2>&1
fi


#Get Total number of items
echo "Running ${COMMAND}"
echo

TOTAL=`${COMMAND} limit 1 offset ${OFFSET} --format json details-level standard | jq '.total'`
echo "Total Elements = ${TOTAL}"
echo

#Loop through and get the data
while [ ${OFFSET} -lt ${TOTAL} ]; do
    OUTPUTFILE=${OUTPUTFOLDER}/${OUTPUTFILEPREFIX}.`printf "%05d" ${OFFSET}`.json
    
    echo "Getting data with offset of ${OFFSET}" to ${OUTPUTFILE}
    
    GETDATA=`${COMMAND} limit ${LIMIT} offset ${OFFSET} details-level "${DETAILSSET}" --format json | jq '.'`
    DATA=`echo ${GETDATA} | jq '.objects[]'`
    
    echo ${DATA} > ${OUTPUTFILE}
    
    OFFSET=`echo ${GETDATA} | jq '.to'`
done

echo 

export Slurpuglyfilefqpn=${OUTPUTFOLDER}/${OUTPUTFILEPREFIX}.ugly.json
export Slurpstarfilefqpn=${OUTPUTFILEPREFIX}.*.json

ls -alh ${OUTPUTFOLDER}/${Slurpstarfilefqpn}

echo 

jq -s '.' ${Slurpstarfilefqpn} > ${Slurpuglyfilefqpn}
#rm -rf test*.json

SLURP_TOTAL=`cat ${Slurpuglyfilefqpn} | jq '.[].uid' | sort -u | wc -l`
echo "Data output to total.ugly.json with ${SLURP_TOTAL} elements"
echo "Total elements from first query is ${TOTAL} elements"

# Make it pretty again

echo
echo "Make it pretty"
echo

export OUTPUTFILETOTALPREFIX=total.${OBJECTSTYPE}.${DETAILSSET}

export Slurpprettyfilefqpn=${OUTPUTFOLDER}/${OUTPUTFILETOTALPREFIX}.pretty.json

echo '{ ' > ${Slurpprettyfilefqpn}
echo -n '  "objects": ' >> ${Slurpprettyfilefqpn}

# need a way to read lines and dump them out

COUNTER=0

while read -r line; do
    if [ ${COUNTER} -eq 0 ]; then
        # Line 0 first line we don't want to add a return yet
        echo -n 'Start:.'
    else
        # Lines 1+ are the data
        echo >> ${Slurpprettyfilefqpn}
        #echo -n '.'
    fi
    
    #Write the line, but not the carriage return
    echo -n "${line}" >> ${Slurpprettyfilefqpn}
    let COUNTER=COUNTER+1
done < ${Slurpuglyfilefqpn}

echo

#Write the last comma after the original json file that is not pretty
echo ',' >> ${Slurpprettyfilefqpn}
echo '  "from": 0,' >> ${Slurpprettyfilefqpn}
echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpprettyfilefqpn}
echo '  "total": '${SLURP_TOTAL} >> ${Slurpprettyfilefqpn}
echo '}' >> ${Slurpprettyfilefqpn}

echo 
#head -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json; echo '...'; tail -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
head -n 10 ${Slurpprettyfilefqpn}
echo '...'
tail -n 10 ${Slurpprettyfilefqpn}
echo 

echo
echo "Now make it really pretty"
echo

export OUTPUTFILEREALLYPRETTY=${OUTPUTFOLDER}/${OUTPUTFILETOTALPREFIX}.reallypretty.json

jq -s '.[]' ${Slurpprettyfilefqpn} > ${OUTPUTFILEREALLYPRETTY}

echo 
head -n 10 ${OUTPUTFILEREALLYPRETTY}
echo '...'
tail -n 10 ${OUTPUTFILEREALLYPRETTY}
echo 

export Finaljsonfileexport=${OUTPUTFOLDER}/${OUTPUTFILETOTALPREFIX}.json

cp ${OUTPUTFILEREALLYPRETTY} ${Finaljsonfileexport}

echo 
head -n 10 ${Finaljsonfileexport}
echo '...'
tail -n 10 ${Finaljsonfileexport}
echo 

ls -alh ${OUTPUTFOLDER}/

echo
echo 'Final output file :  '${Finaljsonfileexport}
echo

