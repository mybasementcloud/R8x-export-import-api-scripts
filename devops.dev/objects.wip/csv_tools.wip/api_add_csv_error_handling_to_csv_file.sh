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
# SCRIPT Append CSV Error Handling to CSV files
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

ScriptName=cli_api_append_csv_error_handling_to_csv_file
export APIScriptFileNameRoot=cli_api_append_csv_error_handling_to_csv_file
export APIScriptShortName=append_csv_error_handling
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Append CSV Error Handling to CSV files"

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


# =================================================================================================
# =================================================================================================
# START script
# =================================================================================================
# =================================================================================================


export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export fileresults=api_add_csv_error_handling_to_csv_file_results_${DATEDTGS}.txt
#export fileimport=hosts_1.csv
export fileimport=$1
export filerefactor=$1.refactor.csv

FILELINEARR=()

#read -r -a ${FILELINEARR} -u ${fileimport}

echo `${dtzs}`${dtzsep} >> ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} >> ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script original call name :  '$0 >> ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} 'Collect File into array :' | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}

echo -n `${dtzs}`${dtzsep} | tee -a -i ${fileresults}

while read -r line; do
    if [ "${line}" == '' ]; then
        # ${line} value is nul, so skip adding to array
        echo -n '%' | tee -a -i ${fileresults}
    else
        # ${line} value is NOT nul, so add to array
        FILELINEARR+=("${line}")
        echo -n '.' | tee -a -i ${fileresults}
    fi
done < ${fileimport}
echo | tee -a -i ${fileresults}

echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} 'Dump file array and refactor lines :' | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}

COUNTER=0

for i in "${FILELINEARR[@]}"; do
    echo `${dtzs}`${dtzsep} "${COUNTER} >>${i}<<" | tee -a -i ${fileresults}
    if [ ${COUNTER} -eq 0 ]; then
        # Line 0 is the header
        echo "${i}"',"ignore-warnings","ignore-errors","set-if-exists"' > ${filerefactor}
    else
        # Lines 1+ are the data
        echo "${i}"',true,true,true' >> ${filerefactor}
    fi
    let COUNTER=COUNTER+1
done

echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}

echo `${dtzs}`${dtzsep} "Refactored file:" | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}
cat ${filerefactor} | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}

echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} 'Done!' | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}

echo `${dtzs}`${dtzsep} 'Input File      :  '${fileimport} | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} 'Refactored File :  '${filerefactor} | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} 'Operations log  :  '${fileresults} | tee -a -i ${fileresults}
echo `${dtzs}`${dtzsep} | tee -a -i ${fileresults}
