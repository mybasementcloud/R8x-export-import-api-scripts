#!/bin/bash
#
# (C) 2016-2022 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
#
# ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR
# DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE
# RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
# TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
# OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
# APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
# AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
#
# Refresh JSON Object Repository - MDSM
#
#
ScriptVersion=00.60.09
ScriptRevision=005
ScriptSubRevision=20
ScriptDate=2022-05-03
TemplateVersion=00.60.09
APISubscriptsLevel=010
APISubscriptsVersion=00.60.09
APISubscriptsRevision=005

#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=refresh_all_json_object_repositories_mdsm
export APIScriptFileNameRoot=refresh_all_json_object_repositories_mdsm
export APIScriptShortName=refresh_all_json_object_repositories_mdsm
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Refresh ALL JSON Object Repositories [-SO, -NSO, -OSO] -  - MDSM"

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
export DATEDTG=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export dtgs_script_start_utc=`date -u +%F-%T-%Z`
export dtgs_script_start=`date +%F-%T-%Z`

#
# rootsafeworkpath     :  This is the path where it is safe to store scripts, to survive upgrades and patching
# customerpathroot     :  Path to the customer work environment, should be under ${rootsafeworkpath}
# scriptspathroot      :  Path to the folder with bash 4 Check Point scripts installation (b4CP)
#

export rootsafeworkpath=/var/log
export customerpathroot=${rootsafeworkpath}/__customer
export scriptspathroot=${customerpathroot}/upgrade_export/scripts

export rootscriptconfigfile=__root_script_config.sh

if [ -r "${customerpathroot}/devops.results" ] ; then
    export cexlogfolder=${customerpathroot}/devops.results/${DATEDTG}'.'${ScriptName//\.}
    if [ ! -r ${cexlogfolder} ] ; then
        mkdir -p -v ${cexlogfolder}
        chmod 775 ${cexlogfolder}
    else
        chmod 775 ${cexlogfolder}
    fi
    export cexlogfilepath=${cexlogfolder}/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log
else
    export cexlogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log
fi

export cexdtzs='date -u +%Y%m%d-%T-%Z'
export cexdtzsep=' | '


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
    getdtzs=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."cexdtzs"`
    readdtzs=${getdtzs}
    if [ x"${readdtzs}" != x"" ] ; then
        export cexdtzs=${readdtzs}
    fi
    getdtzsep=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."cexdtzsep"`
    readdtzsep=${getdtzsep}
    if [ x"${readdtzsep}" != x"" ] ; then
        export cexdtzsep=${readdtzsep}
    fi
fi


# -------------------------------------------------------------------------------------------------

export common_exports_dtgs_script_start_utc=${dtgs_script_start_utc}
export common_exports_dtgs_script_start=${dtgs_script_start}

# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Script original call name :  '$0 | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}

echo `${cexdtzs}`${cexdtzsep} 'Short nap to adjust for log files times...zzzz' | tee -a -i ${cexlogfilepath}
sleep 61

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export test_script_work_folder=/var/log/__customer/devops.dev

if [ -r "cli_api_export_objects.sh" ] ; then
    # found the script in the local directory, use that
    export test_script_work_folder=.
else
    # DID NOT find the script in the local directory, use the standard
    export test_script_work_folder=${test_script_work_folder}
fi


# -------------------------------------------------------------------------------------------------


#${test_script_work_folder}/cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO
#${test_script_work_folder}/cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


errorreturn=0

export cexcommand='cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO'
echo `${cexdtzs}`${cexdtzsep} 'Executing operation:  '${test_script_work_folder}/${cexcommand} | tee -a -i ${cexlogfilepath}

${test_script_work_folder}/${cexcommand}
errorreturn=$?

if [ ${errorreturn} != 0 ] ; then
    # Something went wrong, terminate
    echo `${cexdtzs}`${cexdtzsep} 'Error '${errorreturn}' in operation:  '${cexcommand} | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    exit ${errorreturn}
fi


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


errorreturn=0

export cexcommand='cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO'
echo `${cexdtzs}`${cexdtzsep} 'Executing operation:  '${test_script_work_folder}/${cexcommand} | tee -a -i ${cexlogfilepath}

${test_script_work_folder}/${cexcommand}
errorreturn=$?

if [ ${errorreturn} != 0 ] ; then
    # Something went wrong, terminate
    echo `${cexdtzs}`${cexdtzsep} 'Error '${errorreturn}' in operation:  '${cexcommand} | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    exit ${errorreturn}
fi


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


errorreturn=0

export cexcommand='cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO'
echo `${cexdtzs}`${cexdtzsep} 'Executing operation:  '${test_script_work_folder}/${cexcommand} | tee -a -i ${cexlogfilepath}

${test_script_work_folder}/${cexcommand}
errorreturn=$?

if [ ${errorreturn} != 0 ] ; then
    # Something went wrong, terminate
    echo `${cexdtzs}`${cexdtzsep} 'Error '${errorreturn}' in operation:  '${cexcommand} | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    exit ${errorreturn}
fi


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------

export common_exports_dtgs_script_finish_utc=`date -u +%F-%T-%Z`
export common_exports_dtgs_script_finish=`date +%F-%T-%Z`

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Script execution START  :'"${common_exports_dtgs_script_start}"' UTC :  '"${common_exports_dtgs_script_start_utc}" | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Script execution FINISH :'"${common_exports_dtgs_script_finish}"' UTC :  '"${common_exports_dtgs_script_finish_utc}" | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Common Execution Log File :'"${cexlogfilepath}" | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo