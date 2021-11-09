#!/bin/bash
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
# Refresh JSON Object Repository - SMS
#
#
ScriptVersion=00.60.08
ScriptRevision=050
ScriptDate=2021-11-08
TemplateVersion=00.60.08
APISubscriptsLevel=006
APISubscriptsVersion=00.60.08
APISubscriptsRevision=050

#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=refresh_json_object_repository
export APIScriptFileNameRoot=refresh_json_object_repository
export APIScriptShortName=refresh_json_object_repository
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Refresh JSON Object Repository - SMS"

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

export customerpathroot=/var/log/__customer
export scriptspathroot=/var/log/__customer/upgrade_export/scripts

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

export common_exports_dtgs_script_start=${dtgs_script_start}

# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script original call name :  '$0 | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


if [ -r "cli_api_export_objects.sh" ] ; then
    # found the script in the local directory, use that
    export test_script_work_folder=.
else
    # DID NOT find the script in the local directory, use the standard
    export test_script_work_folder=${test_script_work_folder}
fi


# -------------------------------------------------------------------------------------------------


#${test_script_work_folder}/cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVERR --CSVALL
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

${test_script_work_folder}/cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

${test_script_work_folder}/cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------

export common_exports_dtgs_script_finish=`date -u +%F-%T-%Z`

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo
