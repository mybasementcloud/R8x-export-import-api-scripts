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
# Test Export Execution collection - test environment
#
#
ScriptVersion=00.60.09
ScriptRevision=010
ScriptSubRevision=030
ScriptDate=2022-05-05
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

ScriptName=test_exports_csv
export APIScriptFileNameRoot=test_exports_csv
export APIScriptShortName=test_exports_csv
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Test Export to CSV Execution collection"

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

export cexlogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log
export cextemplogfilepath=${cexlogfilepath}


# -------------------------------------------------------------------------------------------------


export cexdtzs='date -u +%Y%m%d-%T-%Z'
export cexdtzsep=' | '


# -------------------------------------------------------------------------------------------------


if [ -r "${customerpathroot}/devops.results" ] ; then
    export cexlogfolder=${customerpathroot}/devops.results/${DATEDTG}'_'${ScriptName}
    if [ ! -r ${cexlogfolder} ] ; then
        mkdir -p -v ${cexlogfolder} >> ${cexlogfilepath}
        chmod 775 ${cexlogfolder} >> ${cexlogfilepath}
    else
        chmod 775 ${cexlogfolder} >> ${cexlogfilepath}
    fi
    export cexlogfilepath=${cexlogfolder}/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log
fi

if [ "${cexlogfilepath}" != "${cextemplogfilepath}" ] ; then
    cat ${cextemplogfilepath} >> ${cexlogfilepath}
    rm ${cextemplogfilepath} >> ${cexlogfilepath}
fi

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


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export test_script_work_folder=../export_import.wip

if [ -r "cli_api_export_objects.sh" ] ; then
    # found the script in the local directory, use that
    #export test_script_work_folder=.
    export test_script_work_folder=`pwd`
else
    # DID NOT find the script in the local directory, use the standard assumption
    pushd ${test_script_work_folder} >> ${cexlogfilepath}
    errorreturn=$?
    
    if [ ${errorreturn} -ne 0 ] ; then
        # we apparently didn't start where expected, so dumping
        echo `${cexdtzs}`${cexdtzsep} 'Required target folder '"${test_script_work_folder}"' not found, exiting!' | tee -a -i ${cexlogfilepath}
        #popd >> ${cexlogfilepath}
        exit 254
    else
        #OK, so we are where we want to be relative to the script targets
        export test_script_work_folder=`pwd`
    fi
    
    # Return to the script operations folder
    popd >> ${cexlogfilepath}
fi

echo `${cexdtzs}`${cexdtzsep} 'test_script_work_folder = '"${test_script_work_folder}" | tee -a -i ${logfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export TESTOPSARRAY=()

#export TESTOPSARRAY+=("")

#
# JSON and CSV Exports, builds JSON Repository
#
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL")
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR")
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL")

#
# JSON only Exports, builds JSON Repository
#
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO")
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO")
#export TESTOPSARRAY+=("cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO")

#
# CSV only Exports
#
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL")

# --type-of-export <export_type> | --type-of-export=<export_type>
#  Supported <export_type> values for export to CSV :  <"standard"|'name-only'|'name-and-uid'|'uid-only'|'rename-to-new-name'>
#    "standard" {DEFAULT} :  Standard Export of all supported object key values
#    'name-only'          :  Export of just the name key value for object
#    'name-and-uid'       :  Export of name and uid key value for object
#    'uid-only'           :  Export of just the uid key value of objects
#    'rename-to-new-name' :  Export of name key value for object rename
#    For an export for a delete operation via CSV, use 'name-only'

export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only'")
export TESTOPSARRAY+=("cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name'")


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${logfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} These test will be executed: | tee -a -i ${logfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${logfilepath}

for cjlocalop in "${TESTOPSARRAY[@]}" ; do
    
    #echo `${cexdtzs}`${cexdtzsep} "${cjlocalop}, ${cjlocalop//\'/}" | tee -a -i ${logfilepath}
    echo `${cexdtzs}`${cexdtzsep} "${cjlocalop}" | tee -a -i ${logfilepath}
    
done

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${logfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${cexdtzs}`${cexdtzsep} 'Short nap to adjust for log files times...zzzz' | tee -a -i ${cexlogfilepath}
sleep 61

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} 'Starting Test Series:'| tee -a -i ${cexlogfilepath}

errorreturn=0

echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}

for clocalop in "${TESTOPSARRAY[@]}" ; do
    # Loop through array of testing or export operations
    
    errorreturn=0
    
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} 'Starting folder:      '`pwd` | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    
    pushd ${test_script_work_folder} >>  ${cexlogfilepath}
    
    export cexcommand="${clocalop}"
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} 'Executing operation:  '"${clocalop}" | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} 'In folder:            '"${test_script_work_folder}" | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} 'Current folder:       '`pwd` | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    
    . ${cexcommand} "$@"
    errorreturn=$?
    
    popd >>  ${cexlogfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${cexdtzs}`${cexdtzsep} 'Error '${errorreturn}' in operation:  '"${cexcommand}" | tee -a -i ${cexlogfilepath}
        echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
        exit ${errorreturn}
    fi
    
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
    echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
    
done


echo `${cexdtzs}`${cexdtzsep} 'Test Series Completed'| tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} '--------------------------------------------------------------------------------' | tee -a -i ${cexlogfilepath}
echo `${cexdtzs}`${cexdtzsep} | tee -a -i ${cexlogfilepath}

errorreturn=0

export cexcommand='cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVERR --CSVALL'
echo `${cexdtzs}`${cexdtzsep} 'Executing operation:  '${test_script_work_folder}/${cexcommand} | tee -a -i ${cexlogfilepath}

#${test_script_work_folder}/${cexcommand}
#errorreturn=$?

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

export cexcommand='cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO'
echo `${cexdtzs}`${cexdtzsep} 'Executing operation:  '${test_script_work_folder}/${cexcommand} | tee -a -i ${cexlogfilepath}

#${test_script_work_folder}/${cexcommand}
#errorreturn=$?

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

export cexcommand='cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO'
echo `${cexdtzs}`${cexdtzsep} 'Executing operation:  '${test_script_work_folder}/${cexcommand} | tee -a -i ${cexlogfilepath}

#${test_script_work_folder}/${cexcommand}
#errorreturn=$?

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

export cexcommand='cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL'
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

export cexcommand='cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR'
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

export cexcommand='cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL'
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

export cexcommand='cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name''
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
