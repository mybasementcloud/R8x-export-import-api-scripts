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
# SCRIPT Special Object export to CSV file for API CLI Operations
#
#
ScriptVersion=00.60.12
ScriptRevision=100
ScriptSubRevision=750
ScriptDate=2023-03-14
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

ScriptName=cli_api_export_special_objects_to_csv
export APIScriptFileNameRoot=cli_api_export_special_objects_to_csv
export APIScriptShortName=export_special_objects_to_csv
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Special Object export to CSV file for API CLI Operations"

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
# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo `${dtzs}`${dtzsep} '_______________________________________________________________________________' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script original call name :  '$0 | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script initial parameters :  '"$@" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Root script declarations
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetScriptSourceFolder - Get the actual source folder for the running script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetScriptSourceFolder () {
    #
    # Get the actual source folder for the running script
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'GetScriptSourceFolder procedure Starting...' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    #printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'X' "${X}" >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'X' "${X}" | tee -a -i ${logfilepath}
    
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "${SOURCE}" ]; do # resolve ${SOURCE} until the file is no longer a symlink
        TARGET="$(readlink "${SOURCE}")"
        if [[ ${TARGET} == /* ]]; then
            echo `${dtzs}`${dtzsep} "SOURCE '${SOURCE}' is an absolute symlink to '${TARGET}'" >> ${logfilepath}
            SOURCE="${TARGET}"
        else
            DIR="$( dirname "${SOURCE}" )"
            echo `${dtzs}`${dtzsep} "SOURCE '${SOURCE}' is a relative symlink to '${TARGET}' (relative to '${DIR}')" >> ${logfilepath}
            SOURCE="${DIR}/${TARGET}" # if ${SOURCE} was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        fi
    done
    
    RDIR="$( dirname "${SOURCE}" )"
    DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
    if [ "${DIR}" != "${RDIR}" ]; then
        echo `${dtzs}`${dtzsep} "DIR '${RDIR}' resolves to '${DIR}'" >> ${logfilepath}
    fi
    
    export ScriptSourceFolder=${DIR}
    
    printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'SOURCE' "${SOURCE}" | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'DIR' "${DIR}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-20s = %s\n' 'ScriptSourceFolder' "${ScriptSourceFolder}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'GetScriptSourceFolder procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# We need the Script's actual source folder to find subscripts
#
GetScriptSourceFolder


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# ADDED 2018-11-20 -

# Output folder is relative to local folder where script is started, e.g. ./dump
#
export OutputRelLocalPath=true


# If there are issues with running in /home/ subfolder set this to false
#
export IgnoreInHome=true


# Configure output file folder target
# One of these needs to be set to true, just one
#
export OutputToRoot=false
export OutputToDump=true
export OutputToChangeLog=false
export OutputToOther=false
#
# if OutputToOther is true, then this next value needs to be set
#
export OtherOutputFolder=Specify_The_Folder_Here

# if we are date-time stamping the output location as a subfolder of the 
# output folder set this to true,  otherwise it needs to be false
#
export OutputDATESubfolder=true
export OutputDTGSSubfolder=false
export OutputSubfolderScriptName=false
export OutputSubfolderScriptShortName=true

# MODIFIED 2021-02-13 -
export notthispath=/home/
export localdotpathroot=.

export localdotpath=`echo ${PWD}`
export currentlocalpath=${localdotpath}
export workingpath=$currentlocalpath

# MODIFIED 2021-02-13 -
export expandedpath=$(cd ${localdotpathroot} ; pwd)
export startpathroot=${expandedpath}

# -------------------------------------------------------------------------------------------------

# Set these to a starting state we know before we begin
#
export APISCRIPTVERBOSE=false


# MODIFIED 2022-02-15 -
# Set ABORTONERROR to true to force any error to exit, versus reporting or waiting, and then carrying on
#
export ABORTONERROR=true

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# ADDED 2018-05-03 -
# ================================================================================================
# NOTE:  
#   DefaultMgmtAdmin value is used to set the APICLIadmin value in the setup for logon.  This is
#   the default fall back value if the --user parameter is not used to set the actual management 
#   server admininstrator name.  This value should be set to the organizational standard to
#   simplify operation, since it is the default that is used for mgmt_cli login user, where the
#   password must still be entered
# ================================================================================================

#export DefaultMgmtAdmin=admin
export DefaultMgmtAdmin=administrator


# MODIFIED 2021-11-09 -

# Configure whether this script operates only on MDSM
export OpsModeMDSM=false

# Configure whether this script operates against all domains by default, which affects -d CLI parameter handling for authentication
export OpsModeMDSMAllDomains=false


# 2018-05-02 - script type - export objects (specific to CSV)

export script_use_publish=false

#
# Provide a primary operation mission for the script
#
#  other       : catch-all for non-specific scripts
#  export      : script exports data via Management API
#  import      : script imports data via Management API
#  set-update  : script sets or updates data via Management API
#  rename      : script renames data via Management API
#  delete      : script deletes data via Management API
#  process     : script processes other operation outputs
#
# script_main_operation is used to identify elements needed in help and other action control
#export script_main_operation='other|export|import|set-update|rename|delete|process'
# script_target_specail_objects boolean is used to identify if the script is targetting special objects to control execution

export script_main_operation='export'
export script_target_special_objects=true

export scriptpurposeexport=false
export scriptpurposeimport=false
export scriptpurposeupdate=false
export scriptpurposerename=false
export scriptpurposedelete=false
export scriptpurposeother=false
export scriptpurposeprocess=false

case "${script_main_operation}" in
    'other' )
        export scriptpurposeexport=true
        export scriptpurposeimport=true
        export scriptpurposeupdate=true
        export scriptpurposerename=true
        export scriptpurposedelete=true
        export scriptpurposeother=true
        ;;
    'export' )
        export scriptpurposeexport=true
        ;;
    'import' )
        export scriptpurposeimport=true
        ;;
    'set-update' )
        export scriptpurposeupdate=true
        ;;
    'rename' )
        export scriptpurposerename=true
        ;;
    'delete' )
        export scriptpurposedelete=true
        ;;
    'process' )
        export scriptpurposeprocess=true
        ;;
    # Anything unknown is recorded for later
    * )
        # MODIFIED 2022-04-22
        export scriptpurposeother=true
        export scriptpurposeprocess=true
        ;;
esac

export script_use_export=true
export script_use_import=false
export script_use_delete=false
export script_use_csvfile=false

export script_dump_csv=true
export script_dump_json=false
export script_dump_standard=false
export script_dump_full=false

export script_uses_wip=true
export script_uses_wip_json=false

export script_slurp_json=true
export script_slurp_json_full=true
export script_slurp_json_standard=true

export script_save_json_repo=true
export script_use_json_repo=true
export script_json_repo_detailslevel="full"
export script_json_repo_folder="__json_objects_repository"

# ADDED 2018-10-27 -
export UseR8XAPI=true
export UseJSONJQ=true

# ADDED 2020-02-07 -
export UseJSONJQ16=true

# MODIFIED 2022-10-27 -
# R80           version 1.0
# R80.10        version 1.1
# R80.20.M1     version 1.2
# R80.20 GA     version 1.3
# R80.20.M2     version 1.4
# R80.30        version 1.5
# R80.40        version 1.6
# R80.40 JHF 78 version 1.6.1
# R81           version 1.7
# R81 JHF 34    version 1.7.1
# R81.10        version 1.8
# R81.10 JHF 79 version 1.8.1
# R81.20        version 1.9
#
# For common scripts minimum API version at 1.0 should suffice, otherwise get explicit
#
export MinAPIVersionRequired=1.1

# ADDED 2022-03-09 - 
#    
#    mgmt_cli command-name command-parameters optional-switches
#    
#    optional-switches:
#    ---------------
#    [--conn-timeout]
#            Defines maximum time the request is allowed to take in seconds.
#            Default {180}
#            Environment variable: MGMT_CLI_CONNECTION_TIMEOUT
#
export APICLIconntimeout=600

# ADDED 2021-11-09 - 
# MaaS (Smart-1 Cloud) current versions
# R81           version 1.7
# R81 JHF 34    version 1.7.1  !! ????
# R81.10        version 1.8
#
# for MaaS (Smart-1 Cloud) operation assume at least the minimum API version as 1.7 for R81
#
export MinMaaSAPIVersion=1.7
export MaxMaaSAPIVersion=1.8

# If the API version needs to be enforced in commands set this to true
# NOTE not currently used!
#
export ForceAPIVersionToMinimum=false

# Wait time in seconds
export WAITTIME=15


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Configure location for api subscripts
# -------------------------------------------------------------------------------------------------

# ADDED 2021-11-09 - MODIFIED 2023-03-07:01 -
#
# Presumptive folder structure for R8X API Management CLI (mgmt_cli) Template based scripts
#
# <script_home_folder> is the folder containing the script set, generally /var/log/__customer/devops|devops.dev|devops.dev.test
# [.wip] named folders are for development operations
#
# ...<script_home_folder>/_api_subscripts                             ## _api_subscripts folder for all scripts
# ...<script_home_folder>/_templates[.wip]                            ## _templates[.wip] folder for all scripts
# ...<script_home_folder>/tools                                       ## tools folder for all scripts with additional tools not assumed on system
# ...<script_home_folder>/objects[.wip]                               ## objects[.wip] folder for objects operations focused scripts
# ...<script_home_folder>/objects[.wip]/csv_tools[.wip]               ## csv_tools[.wip] folder for objects operations for csv handling focused scripts
# ...<script_home_folder>/objects[.wip]/export_import[.wip]           ## export_import[.wip] folder for objects operations export, import, set, rename, and delete focused scripts
# ...<script_home_folder>/objects[.wip]/export_import_research[.wip]  ## export_import_research[.wip] folder for objects operations research focused scripts
# ...<script_home_folder>/objects[.wip]/object_operations             ## object_operations folder for objects operations and testing scripts
# ...<script_home_folder>/Policy_and_Layers[.wip]                     ## Policy_and_Layers[.wip] folder for policy and layers operations focused scripts
# ...<script_home_folder>/Session_Cleanup[.wip]                       ## Session_Cleanup[.wip] folder for Session Cleanup operation focused scripts
# ...<script_home_folder>/tools.MDSM[.wip]                            ## tools.MDSM[.wip] folder for Tools focused on MDSM operations scripts
#
#
# api_subscripts_default_root is defined with the assumption that scripts are running in a subfolder of the <script_home_folder> folder


# MODIFIED 2023-03-07:01 -
# Configure basic location for api subscripts
export api_subscripts_default_root=..
export api_subscripts_default_folder=_api_subscripts
export api_subscripts_checkfile=api_subscripts_version.${APISubscriptsLevel}.v${APISubscriptsVersion}.version

#
# Check for whether the subscripts are present where expected, if not hard EXIT
#
if [ -r "${api_subscripts_default_root}/${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, found the api subscripts in the default root
    export api_subscripts_root=${api_subscripts_default_root}
    echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
    pushd ${api_subscripts_root} >> ${logfilepath}
    errorreturn=$?
    
    if [ ${errorreturn} -ne 0 ] ; then
        # we apparently didn't start where expected, so dumping
        echo `${dtzs}`${dtzsep} 'Required target folder '"${api_subscripts_root}"' not found, exiting!' | tee -a -i ${logfilepath}
        #popd >> ${logfilepath}
        exit 254
    else
        #OK, so we are where we want to be relative to the script targets
        export api_subscripts_root=`pwd`
    fi
    
    # Return to the script operations folder
    echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
    popd >> ${logfilepath}
elif [ -r "./${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, didn't find the api subscripts in the default root, instead found them in the working folder
    export api_subscripts_root=.
    echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
    pushd ${api_subscripts_root} >> ${logfilepath}
    errorreturn=$?
    
    if [ ${errorreturn} -ne 0 ] ; then
        # we apparently didn't start where expected, so dumping
        echo `${dtzs}`${dtzsep} 'Required target folder '"${api_subscripts_root}"' not found, exiting!' | tee -a -i ${logfilepath}
        #popd >> ${logfilepath}
        exit 254
    else
        #OK, so we are where we want to be relative to the script targets
        export api_subscripts_root=`pwd`
    fi
    
    # Return to the script operations folder
    popd >> ${logfilepath}
elif [ -r "../../${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, didn't find the api subscripts in the default root, or in the working folder, but they were two (2) levels up
    export api_subscripts_root=../..
    echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
    pushd ${api_subscripts_root} >> ${logfilepath}
    errorreturn=$?
    
    if [ ${errorreturn} -ne 0 ] ; then
        # we apparently didn't start where expected, so dumping
        echo `${dtzs}`${dtzsep} 'Required target folder '"${api_subscripts_root}"' not found, exiting!' | tee -a -i ${logfilepath}
        #popd >> ${logfilepath}
        exit 254
    else
        #OK, so we are where we want to be relative to the script targets
        export api_subscripts_root=`pwd`
    fi
    
    # Return to the script operations folder
    echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
    popd >> ${logfilepath}
else
    # OK, didn't find the api subscripts where we expect to find them, so this is bad!
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Missing critical api subscript files that are expected in the one of the following locations:' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' PREFERRED Location   :  '"${api_subscripts_default_root}/${api_subscripts_default_folder}/${api_subscripts_checkfile}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' ALTERNATE Location 1 :  '"./${api_subscripts_default_folder}/${api_subscripts_checkfile}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' ALTERNATE Location 2 :  '"../../${api_subscripts_default_folder}/${api_subscripts_checkfile}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Unable to continue without these api subscript files, so exiting!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Log File location : '"${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    exit 1
fi

export api_subscripts_default_root=${api_subscripts_root}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-11-08 -
# Configure basic information for formation of file path for basic script setup API Scripts handler script
#
# basic_script_setup_API_handler_root - root path to basic script setup API Scripts handler script. Period (".") indicates root of script source folder
# basic_script_setup_API_handler_folder - folder for under root path to basic script setup API Scripts handler script
# basic_script_setup_API_handler_file - filename, without path, for basic script setup API Scripts handler script
#

# MODIFIED 2021-11-08 -
export basic_script_setup_API_handler_root=${api_subscripts_root}
export basic_script_setup_API_handler_folder=${api_subscripts_default_folder}
export basic_script_setup_API_handler_file=basic_script_setup_API_scripts.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-11-08 -
# Configure basic information for formation of file path for command line parameter handler script
#
# cli_api_cmdlineparm_handler_root - root path to command line parameter handler script
# cli_api_cmdlineparm_handler_folder - folder for under root path to command line parameter handler script
# cli_api_cmdlineparm_handler_file - filename, without path, for command line parameter handler script
#

# MODIFIED 2021-11-08 -
export cli_api_cmdlineparm_handler_root=${api_subscripts_root}
export cli_api_cmdlineparm_handler_folder=${api_subscripts_default_folder}
export cli_api_cmdlineparm_handler_file=cmd_line_parameters_handler.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-11-08 -
# Configure basic information for formation of file path for gaia version handler script
#
# gaia_version__handler_root - root path to gaia version handler script. Period (".") indicates root of script source folder
# gaia_version__handler_folder - folder for under root path to gaia version handler script
# gaia_version__handler_file - filename, without path, for gaia version handler script
#

# MODIFIED 2021-11-08 -
export gaia_version_handler_root=${api_subscripts_root}
export gaia_version_handler_folder=${api_subscripts_default_folder}
export gaia_version_handler_file=identify_gaia_and_installation.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-11-08 -
# Configure basic information for formation of file path for Script Output Paths and Folders for API scripts handler script
#
# script_output_paths_API_handler_root - root path to Script Output Paths and Folders for API scripts handler script. Period (".") indicates root of script source folder
# script_output_paths_API_handler_folder - folder for under root path to Script Output Paths and Folders for API scripts handler script
# script_output_paths_API_handler_file - filename, without path, for Script Output Paths and Folders for API scripts handler script
#

# MODIFIED 2021-11-08 -
export script_output_paths_API_handler_root=${api_subscripts_root}
export script_output_paths_API_handler_folder=${api_subscripts_default_folder}
export script_output_paths_API_handler_file=script_output_paths_and_folders_API_scripts.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-11-08 -
# Configure basic information for formation of file path for basic script setup API Scripts handler script
#
# mgmt_cli_API_operations_handler_root - root path to basic script setup API Scripts handler script. Period (".") indicates root of script source folder
# mgmt_cli_API_operations_handler_folder - folder for under root path to basic script setup API Scripts handler script
# mgmt_cli_API_operations_handler_file - filename, without path, for basic script setup API Scripts handler script
#

# MODIFIED 2021-11-08 -
export mgmt_cli_API_operations_handler_root=${api_subscripts_root}
export mgmt_cli_API_operations_handler_folder=${api_subscripts_default_folder}
export mgmt_cli_API_operations_handler_file=mgmt_cli_api_operations.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-20 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export FileExtJSON=json
export FileExtCSV=csv
export FileExtTXT=txt

export JSONRepofilepre=repo_

export JSONRepofileext=${FileExtJSON}
export JSONRepofilesuffix='LATEST.'${JSONRepofileext}

export APICLIfileexportpre=dump_

export APICLIfileexportext=${FileExtJSON}
export APICLIfileexportsuffix=${DATE}'.'${APICLIfileexportext}

export APICLICSVfileexportext=${FileExtCSV}
export APICLICSVfileexportsuffix='.'${APICLICSVfileexportext}

export APICLIJSONfileexportext=${FileExtJSON}
export APICLIJSONfileexportsuffix='.'${APICLIJSONfileexportext}

# MODIFIED 2022-03-10 -
#
export AbsoluteAPIMaxObjectLimit=500
export MinAPIObjectLimit=50
export MaxAPIObjectLimit=${AbsoluteAPIMaxObjectLimit}
export MaxAPIObjectLimitSlowObjects=100
export DefaultAPIObjectLimitMDSMXtraSlow=50
export DefaultAPIObjectLimitMDSMSlow=100
export DefaultAPIObjectLimitMDSMMedium=250
export DefaultAPIObjectLimitMDSMFast=500
export SlowObjectAPIObjectLimitMDSMXtraSlow=25
export SlowObjectAPIObjectLimitMDSMSlow=50
export SlowObjectAPIObjectLimitMDSMMedium=100
export SlowObjectAPIObjectLimitMDSMFast=200
#export RecommendedAPIObjectLimitMDSM=200
export RecommendedAPIObjectLimitMDSM=${DefaultAPIObjectLimitMDSMMedium}
export DefaultAPIObjectLimit=${MaxAPIObjectLimit}
export DefaultAPIObjectLimitMDSM=${RecommendedAPIObjectLimitMDSM}
export DefaultAPIObjectLimitMDSMSlowObjects=${SlowObjectAPIObjectLimitMDSMSlow}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-02-24:01 -

# Configure basic information for formation of file path for action handler scripts
#
# APIScriptActionFileRoot - root path to for action handler scripts
# APIScriptActionFileFolder - folder under root path to for action handler scripts
# APIScriptActionFilePath - path, for action handler scripts
#

export APIScriptActionFileRoot=${ScriptSourceFolder}

export APIScriptActionFileFolder=

export APIScriptActionFilePrefix=cli_api_actions

export APIScriptJSONActionFilename=${APIScriptActionFilePrefix}.'export_objects_to_json'.sh
#export APIScriptJSONActionFilename=${APIScriptActionFilePrefix}'_actions_'${APIScriptVersion}.sh

export APIScriptJSONSpecialActionFilename=${APIScriptActionFilePrefix}.'export_special_objects_to_json'.sh
#export APIScriptJSONSpecialActionFilename=${APIScriptActionFilePrefix}'_actions_'${APIScriptVersion}.sh

export APIScriptCSVActionFilename=${APIScriptActionFilePrefix}.'export_objects_to_csv'.sh
#export APIScriptCSVActionFilename=${APIScriptActionFilePrefix}'_actions_to_csv_'${APIScriptVersion}.sh

export APIScriptCSVSpecialActionFilename=${APIScriptActionFilePrefix}.'export_special_objects_to_csv'.sh
#export APIScriptCSVSpecialActionFilename=${APIScriptActionFilePrefix}'_actions_to_csv_'${APIScriptVersion}.sh


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-20

# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Setup Root Parameters
# =================================================================================================
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Start of procedures block
# -------------------------------------------------------------------------------------------------

export templogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log

# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #
    
    if [ -z "$1" ]; then
        # No explicit name passed for action
        export templogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log
    else
        # explicit name passed for action
        export templogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'$1'_'${DATEDTGS}.log
    fi
    
    echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
    rm ${templogfilepath} >> ${logfilepath} 2>&1
    
    touch ${templogfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleShowTempLogFile () {
    #
    # HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
    #
    
    if ${APISCRIPTVERBOSE} ; then
        # verbose mode so show the logged results and copy to normal log file
        cat ${templogfilepath} | tee -a -i ${logfilepath}
    else
        # NOT verbose mode so push logged results to normal log file
        cat ${templogfilepath} >> ${logfilepath}
    fi
    
    echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
    rm ${templogfilepath} >> ${logfilepath} 2>&1
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ForceShowTempLogFile () {
    #
    # ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
    #
    
    cat ${templogfilepath} | tee -a -i ${logfilepath}
    
    echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
    rm ${templogfilepath} >> ${logfilepath} 2>&1
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# End of procedures block
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END Initial Script Setup
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Basic Script Setup for API Scripts
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# BasicScriptSetupAPIScripts - Basic Script Setup for API Scripts Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

BasicScriptSetupAPIScripts () {
    #
    # BasicScriptSetupAPIScripts - Basic Script Setup for API Scripts Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Basic Script Setup for API Scripts Handler Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${basic_script_setup_API_handler} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling Basic Script Setup for API Scripts Handler Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${basic_script_setup_API_handler} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    . ${basic_script_setup_API_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Basic Script Setup for API Scripts Handler Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Basic Script Setup for API Scripts Handler Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call Basic Script Setup for API Scripts Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -

export configured_handler_root=${basic_script_setup_API_handler_root}
export actual_handler_root=${configured_handler_root}

if [ "${configured_handler_root}" == "." ] ; then
    if [ ${ScriptSourceFolder} != ${localdotpath} ] ; then
        # Script is not running from it's source folder, might be linked, so since we expect the handler folder
        # to be relative to the script source folder, use the identified script source folder instead
        export actual_handler_root=${ScriptSourceFolder}
    else
        # Script is running from it's source folder
        export actual_handler_root=${configured_handler_root}
    fi
else
    # handler root path is not period (.), so stipulating fully qualified path
    export actual_handler_root=${configured_handler_root}
fi

export basic_script_setup_API_handler_path=${actual_handler_root}/${basic_script_setup_API_handler_folder}
export basic_script_setup_API_handler=${basic_script_setup_API_handler_path}/${basic_script_setup_API_handler_file}

# Check that we can finde the Basic Script Setup for API Scripts Handler file
#
if [ ! -r ${basic_script_setup_API_handler} ] ; then
    # no file found, that is a problem
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Basic script setup API Scripts handler script file missing' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  File not found : '${basic_script_setup_API_handler} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Root of folder path : '${basic_script_setup_API_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder in Root path : '${basic_script_setup_API_handler_folder} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder Root path    : '${basic_script_setup_API_handler_path} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Script Filename     : '${basic_script_setup_API_handler_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 251
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -

BasicScriptSetupAPIScripts "$@"


# =================================================================================================
# END:  Basic Script Setup for API Scripts
# =================================================================================================
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Command Line Parameter Handling and Help
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# START Define command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-03-10 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#


#
# Standard R8X API Scripts Command Line Parameters
#
# -? | --help
# -v | --verbose
#
# --NOWAIT
#
# -P <web-ssl-port> | --port <web-ssl-port> | -P=<web-ssl-port> | --port=<web-ssl-port>
# -r | --root
# -u <admin_name> | --user <admin_name> | -u=<admin_name> | --user=<admin_name>
# -p <password> | --password <password> | -p=<password> | --password=<password>
# --api-key "<api_key_value>" | --api-key="<api_key_value>" 
# --MaaS | --maas | --MAAS
# --context <web_api|gaia_api|{MaaSGUID}/web_api> | --context=<web_api|gaia_api|{MaaSGUID}/web_api> 
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# --domain-System-Data | --dSD | --dsd
# --domain-Global | --dG | --dg
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# --session-timeout <session_time_out[ 10-3600]
# --conn-timeout <connection_time_out, [180,180-3600]> | --CTO <connection_time_out> | --conn-timeout=<connection_time_out, [180,180-3600]> | --CTO=<connection_time_out>
# -l <log_path> | --log-path <log_path> | -l=<log_path> | --log-path=<log_path>'
#
# -o <output_path> | --output <output_path> | -o=<output_path> | --output=<output_path> 
# -c <csv_path> | --csv <csv_path> | -c=<csv_path> | --csv=<csv_path>'
#
# --NOHUP
# --NOHUP-Script <NOHUP_SCRIPT_NAME> | --NOHUP-Script=<NOHUP_SCRIPT_NAME>
# --NOHUP-DTG <NOHUP_SCRIPT_DATE_TIME_GROUP> | --NOHUP-DTG=<NOHUP_SCRIPT_DATE_TIME_GROUP>
# --NOHUP-PATH <NOHUP_SCRIPT_EXECUTION_PATH> | --NOHUP-PATH=<NOHUP_SCRIPT_EXECUTION_PATH>
#
#

# MODIFIED 2020-09-30
export REMAINS=

export SHOWHELP=false
export CLIparm_NOWAIT=

# MODIFIED 2018-09-21 -
#export CLIparm_websslport=443
export CLIparm_websslport=

export CLIparm_rootuser=false
export CLIparm_user=
export CLIparm_password=
# ADDED 2020-08-19 -
export CLIparm_api_key=
export CLIparm_use_api_key=false
# ADDED 2021-11-09 -
export CLIparm_MaaS=false
# ADDED 2021-10-19 -
export CLIparm_api_context=
export CLIparm_use_api_context=false

# ADDED 2023-01-10 -
export CLIparm_domain_System_Data=false
export CLIparm_domain_Global=false

export CLIparm_domain=

export CLIparm_sessionidfile=

export CLIparm_sessiontimeout=
export CLIparm_logpath=

export CLIparm_connectiontimeout=${APICLIconntimeout}

export CLIparm_outputpath=
export CLIparm_csvpath=

# --NOWAIT
#
if [ -z "${NOWAIT}" ]; then
    # NOWAIT mode not set from shell level
    export CLIparm_NOWAIT=false
    export NOWAIT=false
elif [ x"`echo "${NOWAIT}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NOWAIT mode set OFF from shell level
    export CLIparm_NOWAIT=false
    export NOWAIT=false
elif [ x"`echo "${NOWAIT}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NOWAIT mode set ON from shell level
    export CLIparm_NOWAIT=true
    export NOWAIT=true
else
    # NOWAIT mode set to wrong value from shell level
    export CLIparm_NOWAIT=false
    export NOWAIT=false
fi

# ADDED 2021-02-06 - MODIFIED 2021-02-13 -
# Provide capability to work with NOHUP mode script do_script_nohup from "bash 4 Check Point" scripts

export CLIparm_NOHUP=false
export CLIparm_NOHUPScriptName=
export CLIparm_NOHUPDTG=
export CLIparm_NOHUPPATH=

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-03-10
# MODIFIED 2022-06-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Specific Scripts Command Line Parameters
#
# --type-of-export <export_type> | --type-of-export=<export_type>
#  Supported <export_type> values for export to CSV :  <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"|"name-for-delete">
#    "standard" {DEFAULT} :  Standard Export of all supported object key values
#    "name-only"          :  Export of just the name key value for object
#    "name-and-uid"       :  Export of name and uid key value for object
#    "uid-only"           :  Export of just the uid key value of objects
#    "rename-to-new-name" :  Export of name key value for object rename
#    "name-for-delete"    :  Export of name key value for object delete also sets other settings needed for clean delete control CSV
#    For an export for a delete operation via CSV, use "name-only"
#
# -f <format[all|csv|json]> | --format <format[all|csv|json]> | -f=<format[all|csv|json]> | --format=<format[all|csv|json]> 
#
# --details <level[all|full|standard]> | --DETAILSLEVEL <level[all|full|standard]> | --details=<level[all|full|standard]> | --DETAILSLEVEL=<level[all|full|standard]> 
#
# --DEVOPSRESULTS | --RESULTS
# --DEVOPSRESULTSPATH <results_path> | --RESULTSPATH <results_path> | --DEVOPSRESULTSPATH=<results_path> | --RESULTSPATH=<results_path> 
#
# --DO-CPI | --Override-Critical-Performance-Impact
# --NO-CPI | --NO-Critical-Performance-Impact
#
# --JSONREPO
# --NOJSONREPO
# --SAVEJSONREPO
# --NOSAVEJSONREPO
# --FORCEJSONREPOREBUILD
# --JSONREPOPATH <json_repository_path> | --JSONREPOPATH=<json_repository_path> 
#
# --SO | --system-objects | --all-objects
# --NSO | --no-system-objects
# --OSO | --only-system-objects
#
#  --CREATORISNOTSYSTEM | --NOSYS
#  --CREATORISSYSTEM
#
# --CSVERR | --CSVADDEXPERRHANDLE
#
# --5-TAGS | --CSVEXPORT05TAGS
# --10-TAGS | --CSVEXPORT10TAGS
# --NO-TAGS | --CSVEXPORTNOTAGS
#
# --OVERRIDEMAXOBJECTS
# --MAXOBJECTS <maximum_objects_10-500> | --MAXOBJECTS=<maximum_objects_10-500>
#
# --CSVEXPORTDATADOMAIN
# --CSVEXPORTDATACREATOR
# --CSVEXPORTDATAALL
#
# --KEEPCSVWIP
# --CLEANUPCSVWIP
# --NODOMAINFOLDERS
#
# -x <export_path> | --export-path <export_path> | -x=<export_path> | --export-path=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path> 
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path> 
#

# Type of Object Export  :  --type-of-export <export_type> | --type-of-export=<export_type>
#  export_type :  <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name">
#      For an export for a delete operation via CSV, use "name-only"
#
#export TypeOfExport="standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name|"name-for-delete""
export TypeOfExport="standard"
export CLIparm_TypeOfExport=${TypeOfExport}
export ExportTypeIsStandard=true
export ExportTypeIsName4Delete=false

# ADDED 2020-11-23 -
# Define output format from all, csv, or json

export CLIparm_format=all
export CLIparm_formatall=true
export CLIparm_formatcsv=true
export CLIparm_formatjson=true

# ADDED 2020-11-23 -
# Define output details level from all, full, or standard for json format output
# Default output details level for json format output is all
export CLIparm_detailslevel=all
export CLIparm_detailslevelall=true
export CLIparm_detailslevelfull=true
export CLIparm_detailslevelstandard=true

# ADDED 2020-11-23 -
# Determine utilization of devops.results folder in parent folder

export UseDevOpsResults=false
export CLIparm_UseDevOpsResults=${UseDevOpsResults}
export CLIparm_resultspath=

# ADDED 2022-12-08 -
# Determine override of disabling export for critical performance impact objects
# Object with Critical Performance Impact (OCPI)

export CLIparm_EXCPIObjectsEnabled=false
export ExportCritPerfImpactObjects=false

# MODIFIED 2022-02-15 -
# Determine utilization of json repository folder in devops.results subfolder or defined folder

# UseJSONRepo      TRUE      --JSONREPO
# UseJSONRepo      FALSE     --NOJSONREPO
# SaveJSONRepo     TRUE      --SAVEJSONREPO
# SaveJSONRepo     FALSE     --NOSAVEJSONREPO
# RebuildJSONRepo  TRUE      --FORCEJSONREPOREBUILD
# RebuildJSONRepo  FALSE     <default>

export UseJSONRepo=${script_use_json_repo}
export CLIparm_UseJSONRepo=${UseJSONRepo}
export SaveJSONRepo=${script_save_json_repo}
export CLIparm_SaveJSONRepo=${SaveJSONRepo}
export CLIparm_ForceJSONRepoRebuild=false
export RebuildJSONRepo=${CLIparm_ForceJSONRepoRebuild}
export CLIparm_jsonrepopath=

# MODIFIED 2022-04-22 -
# --SO | --system-objects | --all-objects
#export CLIparm_NoSystemObjects=false
#export CLIparm_OnlySystemObjects=false
# --NSO | --no-system-objects
#export CLIparm_NoSystemObjects=true
#export CLIparm_OnlySystemObjects=false
# --OSO | --only-system-objects
#export CLIparm_NoSystemObjects=false
#export CLIparm_OnlySystemObjects=true

export NoSystemObjects=false
export CLIparm_NoSystemObjects=${NoSystemObjects}
export OnlySystemObjects=false
export CLIparm_OnlySystemObjects=${OnlySystemObjects}

# MODIFIED 2022-04-22 -
# Ignore object where Creator is System  :  --CREATORISNOTSYSTEM | --NOSYS
#
#export CreatorIsNotSystem=false|true
export CreatorIsNotSystem=false
export CLIparm_CreatorIsNotSystem=${CreatorIsNotSystem}

# MODIFIED 2022-04-22 -
# Select object where Creator is System  :  --CREATORISSYSTEM
#
#export CLIparm_CreatorIsSystemm=false|true
export CreatorIsSystem=false
export CLIparm_CreatorIsSystemm=${CreatorIsSystem}

export CLIparm_CSVADDEXPERRHANDLE=

# --CSVERR | --CSVADDEXPERRHANDLE
#
if [ -z "${CSVADDEXPERRHANDLE}" ]; then
    # CSVADDEXPERRHANDLE mode not set from shell level
    export CSVADDEXPERRHANDLE=false
    export CLIparm_CSVADDEXPERRHANDLE=${CSVADDEXPERRHANDLE}
elif [ x"`echo "${CSVADDEXPERRHANDLE}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CSVADDEXPERRHANDLE mode set OFF from shell level
    export CSVADDEXPERRHANDLE=false
    export CLIparm_CSVADDEXPERRHANDLE=${CSVADDEXPERRHANDLE}
elif [ x"`echo "${CSVADDEXPERRHANDLE}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CSVADDEXPERRHANDLE mode set ON from shell level
    export CSVADDEXPERRHANDLE=true
    export CLIparm_CSVADDEXPERRHANDLE=${CSVADDEXPERRHANDLE}
else
    # CLEANUPCSVWIP mode set to wrong value from shell level
    export CSVADDEXPERRHANDLE=false
    export CLIparm_CSVADDEXPERRHANDLE=${CSVADDEXPERRHANDLE}
fi

# ADDED 2021-01-16 -
# Define number tags to export to CSV :  5, 10, none

export CSVEXPORT05TAGS=true
export CSVEXPORT10TAGS=false
export CSVEXPORTNOTAGS=false
export CLIparm_CSVEXPORT05TAGS=${CSVEXPORT05TAGS}
export CLIparm_CSVEXPORT10TAGS=${CSVEXPORT10TAGS}
export CLIparm_CSVEXPORTNOTAGS=${CSVEXPORTNOTAGS}

# ADDED 2021-11-09 - MODIFIED 2021-11-10
# --OVERRIDEMAXOBJECTS
# --MAXOBJECTS <maximum_objects_10-500> | --MAXOBJECTS=<maximum_objects_10-500>

export CLIparm_OVERRIDEMAXOBJECTS=false
export CLIparm_MAXOBJECTS=
export OverrideMaxObjects=${CLIparm_OVERRIDEMAXOBJECTS}
export OverrideMaxObjectsNumber=${CLIparm_MAXOBJECTS}
export MinMaxObjectsLimit=10
export MaxMaxObjectsLimit=${AbsoluteAPIMaxObjectLimit}

# ADDED 2020-09-30 -
# --CSVEXPORTDATADOMAIN :  Export Data Domain information to CSV
# --CSVEXPORTDATACREATOR :  Export Data Creator and other MetaData to CSV
# --CSVEXPORTDATAALL :  Export Data Domain and Data Creator and other MetaData to CSV

export CLIparm_CSVEXPORTDATADOMAIN=false
export CLIparm_CSVEXPORTDATACREATOR=false

export CLIparm_KEEPCSVWIP=
export CLIparm_CLEANUPCSVWIP=

# --KEEPCSVWIP
#
if [ -z "${KEEPCSVWIP}" ]; then
    # KEEPCSVWIP mode not set from shell level, default to not set
    export KEEPCSVWIP=
    export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
elif [ x"`echo "${KEEPCSVWIP}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # KEEPCSVWIP mode set ON from shell level
    export KEEPCSVWIP=true
    export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
elif [ x"`echo "${KEEPCSVWIP}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CLEANUPCSVWIP mode set OFF from shell level
    export KEEPCSVWIP=false
    export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
else
    # CLEANUPCSVWIP mode set to wrong value from shell level, default to not set
    export KEEPCSVWIP=
    export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
fi

# --CLEANUPCSVWIP
#
if [ -z "${CLEANUPCSVWIP}" ]; then
    # CLEANUPCSVWIP mode not set from shell level, set default TRUE
    export CLEANUPCSVWIP=true
    export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
elif [ x"`echo "${CLEANUPCSVWIP}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CLEANUPCSVWIP mode set OFF from shell level
    export CLEANUPCSVWIP=false
    export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
elif [ x"`echo "${CLEANUPCSVWIP}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CLEANUPCSVWIP mode set ON from shell level
    export CLEANUPCSVWIP=true
    export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
else
    # CLEANUPCSVWIP mode set to wrong value from shell level, set default TRUE
    export CLEANUPCSVWIP=true
    export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
fi

if [ x"${KEEPCSVWIP}" == x"" ] ; then
    # KEEPCSVWIP was NOT set so check what we configured for CLEANUPCSVWIP
    if ${CLEANUPCSVWIP} ; then
        # CLEANUPCSVWIP mode set ON
        export KEEPCSVWIP=false
        export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
        export CLEANUPCSVWIP=true
        export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
    else
        # CLEANUPCSVWIP mode set OFF
        export KEEPCSVWIP=true
        export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
        export CLEANUPCSVWIP=false
        export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
    fi
elif ${KEEPCSVWIP} ; then
    # KEEPCSVWIP was set true, so override everything
    export KEEPCSVWIP=true
    export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
    export CLEANUPCSVWIP=false
    export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
else
    # KEEPCSVWIP was set false, so override everything
    export KEEPCSVWIP=false
    export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
    export CLEANUPCSVWIP=true
    export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
fi

export CLIparm_NODOMAINFOLDERS=

# --NODOMAINFOLDERS
#
if [ -z "${NODOMAINFOLDERS}" ]; then
    # NODOMAINFOLDERS mode not set from shell level
    export NODOMAINFOLDERS=false
    export CLIparm_NODOMAINFOLDERS=${NODOMAINFOLDERS}
elif [ x"`echo "${NODOMAINFOLDERS}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NODOMAINFOLDERS mode set OFF from shell level
    export NODOMAINFOLDERS=false
    export CLIparm_NODOMAINFOLDERS=${NODOMAINFOLDERS}
elif [ x"`echo "${NODOMAINFOLDERS}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NODOMAINFOLDERS mode set ON from shell level
    export NODOMAINFOLDERS=true
    export CLIparm_NODOMAINFOLDERS=${NODOMAINFOLDERS}
else
    # NODOMAINFOLDERS mode set to wrong value from shell level
    export NODOMAINFOLDERS=false
    export CLIparm_NODOMAINFOLDERS=${NODOMAINFOLDERS}
fi

export CLIparm_exportpath=
export CLIparm_importpath=
export CLIparm_deletepath=

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-18


# -------------------------------------------------------------------------------------------------
# END Define command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START:  Local CLI parameter processing proceedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Define local command line parameter CLIparm values
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Set the value of localCLIparms to true to utilize and execute on script local command line parameters
#
export localCLIparms=false
#export localCLIparms=true

#export CLIparm_local1=

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# processcliremains - Local command line parameter processor
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-31 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

processcliremains () {
    #
    
    # -------------------------------------------------------------------------------------------------
    # Process command line parameters from the REMAINS returned from the standard handler
    # -------------------------------------------------------------------------------------------------
    
    while [ -n "$1" ]; do
        # Copy so we can modify it (can't modify $1)
        OPT="$1"
        
        # testing
        echo 'OPT = '${OPT}
        #
            
        # Detect argument termination
        if [ x"${OPT}" = x"--" ]; then
            
            shift
            for OPT ; do
                # MODIFIED 2019-03-08
                LOCALREMAINS="${LOCALREMAINS} ${OPT}"
            done
            break
        fi
        # Parse current opt
        while [ x"${OPT}" != x"-" ] ; do
            case "${OPT}" in
                # Help and Standard Operations
                '-?' | --help )
                    SHOWHELP=true
                    ;;
                # Handle --flag=value opts like this
                -q=* | --qlocal1=* )
                    CLIparm_local1="${OPT#*=}"
                    #shift
                    ;;
                # and --flag value opts like this
                -q* | --qlocal1 )
                    CLIparm_local1="$2"
                    shift
                    ;;
                # Anything unknown is recorded for later
                * )
                    # MODIFIED 2019-03-08
                    LOCALREMAINS="${LOCALREMAINS} ${OPT}"
                    break
                    ;;
            esac
            # Check for multiple short options
            # NOTICE: be sure to update this pattern to match valid options
            # Remove any characters matching "-", and then the values between []'s
            #NEXTOPT="${OPT#-[upmdsor?]}" # try removing single short opt
            NEXTOPT="${OPT#-[vrf?]}" # try removing single short opt
            if [ x"${OPT}" != x"${NEXTOPT}" ] ; then
                OPT="-${NEXTOPT}"  # multiple short opts, keep going
            else
                break  # long form, exit inner loop
            fi
        done
        # Done with that param. move to next
        shift
    done
    # Set the non-parameters back into the positional parameters ($1 $2 ..)
    eval set -- ${LOCALREMAINS}
    
    export CLIparm_local1=${CLIparm_local1}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-31

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# dumpcliparmparselocalresults
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumpcliparmparselocalresults () {
    
    #
    # Testing - Dump acquired local values
    #
    #
    workoutputfile=/var/tmp/workoutputfile.2.${DATEDTGS}.txt
    echo > ${workoutputfile}
    
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo 'Local CLI Parameters :' >> ${workoutputfile}
    echo >> ${workoutputfile}
    
    #echo 'CLIparm_local1          = '${CLIparm_local1} >> ${workoutputfile}
    #echo 'CLIparm_local2          = '$CLIparm_local2 >> ${workoutputfile}
    
    #                  1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #       01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo  >> ${workoutputfile}
    echo 'LOCALREMAINS            = '${LOCALREMAINS} >> ${workoutputfile}
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo | tee -a -i ${logfilepath}
        cat ${workoutputfile} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        for i ; do echo - $i | tee -a -i ${logfilepath} ; done
        echo | tee -a -i ${logfilepath}
        echo 'CLI parms - number :  '"$#"' parms :  >'"$@"'<' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo | tee -a -i ${logfilepath}
        echo "End of local execution" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    
    else
        # Verbose mode OFF
        
        echo >> ${logfilepath}
        cat ${workoutputfile} >> ${logfilepath}
        echo >> ${logfilepath}
        for i ; do echo - $i >> ${logfilepath} ; done
        echo >> ${logfilepath}
        echo 'CLI parms - number :  '"$#"' parms :  >'"$@"'<' >> ${logfilepath}
        echo >> ${logfilepath}
        
    fi
    
    rm ${workoutputfile}
}


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# dumprawcliremains
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumprawcliremains () {
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Command line parameters remains : " | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Number parms :  '"$#" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "remains raw : \> $@ \<" | tee -a -i ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e `${dtzs}`${dtzsep}"${parmnum} \t ${k}" | tee -a -i ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
    else
        # Verbose mode OFF
        
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Command line parameters remains : " >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Number parms :  '"$#" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "remains raw : \> $@ \<" >> ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e `${dtzs}`${dtzsep}"${parmnum} \t ${k}" >> ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        
    fi

}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# END:  Local CLI parameter processing proceedures
# -------------------------------------------------------------------------------------------------
# =================================================================================================

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START:  Local Help display proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Show local help information.  Add script specific information here to show when help requested

doshowlocalhelp () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo
    echo 'Local Script Specific Help Information : '
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    return 1
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30

# -------------------------------------------------------------------------------------------------
# END:  Local Help display proceedure
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# CommandLineParameterHandler - Command Line Parameter Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CommandLineParameterHandler () {
    #
    # CommandLineParameterHandler - Command Line Parameter Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Command Line Paramenter Handling Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${cli_api_cmdlineparm_handler} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Command Line Paramenter Handling Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${cli_api_cmdlineparm_handler} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    . ${cli_api_cmdlineparm_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Command Line Paramenter Handling Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Command Line Paramenter Handling Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    # -------------------------------------------------------------------------------------------------
    # Handle locally defined command line parameters
    # -------------------------------------------------------------------------------------------------
    
    # Check if we have left over parameters that might be handled locally
    #
    if ${localCLIparms}; then
        # Local CLII Parameters are defined
        if [ -n "${REMAINS}" ]; then
             
            dumprawcliremains ${REMAINS}
            
            processcliremains ${REMAINS}
            
            dumpcliparmparselocalresults ${REMAINS}
        fi
    fi
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call command line parameter handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -

export configured_handler_root=${cli_api_cmdlineparm_handler_root}
export actual_handler_root=${configured_handler_root}

if [ "${configured_handler_root}" == "." ] ; then
    if [ ${ScriptSourceFolder} != ${localdotpath} ] ; then
        # Script is not running from it's source folder, might be linked, so since we expect the handler folder
        # to be relative to the script source folder, use the identified script source folder instead
        export actual_handler_root=${ScriptSourceFolder}
    else
        # Script is running from it's source folder
        export actual_handler_root=${configured_handler_root}
    fi
else
    # handler root path is not period (.), so stipulating fully qualified path
    export actual_handler_root=${configured_handler_root}
fi

export cli_api_cmdlineparm_handler_path=${actual_handler_root}/${cli_api_cmdlineparm_handler_folder}
export cli_api_cmdlineparm_handler=${cli_api_cmdlineparm_handler_path}/${cli_api_cmdlineparm_handler_file}

# Check that we can finde the command line parameter handler file
#
if [ ! -r ${cli_api_cmdlineparm_handler} ] ; then
    # no file found, that is a problem
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Command Line Parameter handler script file missing' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  File not found : '${cli_api_cmdlineparm_handler} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Root of folder path : '${cli_api_cmdlineparm_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder in Root path : '${cli_api_cmdlineparm_handler_folder} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder Root path    : '${cli_api_cmdlineparm_handler_path} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Script Filename     : '${cli_api_cmdlineparm_handler_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 251
fi

# MODIFIED 2021-10-21 -

CommandLineParameterHandler "$@"


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Local Handle request for help and return
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Was help requested, if so show local content and return
#
if ${SHOWHELP} ; then
    # Show Local Help
    if ${localCLIparms}; then
        doshowlocalhelp
    fi
    exit 255 
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Command Line Parameter Handling and Help
# =================================================================================================
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Setup Standard Parameters
# =================================================================================================

if ${APISCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} 'Date Time Group   :  '${DATE} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Date Time Group S :  '${DATEDTGS} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} 'Date Time Group   :  '${DATE} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Date Time Group S :  '${DATEDTGS} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
fi

# -------------------------------------------------------------------------------------------------
# GetGaiaVersionAndInstallationType - Gaia version and installation type Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetGaiaVersionAndInstallationType () {
    #
    # GetGaiaVersionAndInstallationType - Gaia version and installation type Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Gaia version and installation type Handling Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${gaia_version_handler} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Gaia version and installation type Handling Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${gaia_version_handler} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    . ${gaia_version_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Gaia version and installation type Handling Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Gaia version and installation type Handling Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi

}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call Gaia version and installation type Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export configured_handler_root=${gaia_version_handler_root}
export actual_handler_root=${configured_handler_root}

if [ "${configured_handler_root}" == "." ] ; then
    if [ ${ScriptSourceFolder} != ${localdotpath} ] ; then
        # Script is not running from it's source folder, might be linked, so since we expect the handler folder
        # to be relative to the script source folder, use the identified script source folder instead
        export actual_handler_root=${ScriptSourceFolder}
    else
        # Script is running from it's source folder
        export actual_handler_root=${configured_handler_root}
    fi
else
    # handler root path is not period (.), so stipulating fully qualified path
    export actual_handler_root=${configured_handler_root}
fi

export gaia_version_handler_path=${actual_handler_root}/${gaia_version_handler_folder}
export gaia_version_handler=${gaia_version_handler_path}/${gaia_version_handler_file}

# Check that we can finde the command line parameter handler file
#
if [ ! -r ${gaia_version_handler} ] ; then
    # no file found, that is a problem
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' Gaia version and installation type handler script file missing' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  File not found : '${gaia_version_handler} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Root of folder path : '${gaia_version_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder in Root path : '${gaia_version_handler_folder} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder Root path    : '${gaia_version_handler_path} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Script Filename     : '${gaia_version_handler_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 251
fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

GetGaiaVersionAndInstallationType "$@"


# =================================================================================================
# END:  Setup Standard Parameters
# =================================================================================================
# =================================================================================================


# REMOVED 2020-11-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# =================================================================================================
# =================================================================================================
# START:  Setup Login Parameters and Mgmt_CLI handler procedures
# =================================================================================================


# Moved to mgmt_cli_api_operations.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh script
#
#HandleMgmtCLIPublish
#HandleMgmtCLILogout
#HandleMgmtCLILogin
#SetupLogin2MgmtCLI
#Login2MgmtCLI


# =================================================================================================
# END:  Setup Login Parameters and Mgmt_CLI handler procedures
# =================================================================================================
# =================================================================================================

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ REMOVED 2020-11-16

# =================================================================================================
# =================================================================================================
# START:  Setup CLI Parameter based values
# =================================================================================================

# =================================================================================================
# =================================================================================================
# START:  Common Procedures
# -------------------------------------------------------------------------------------------------


# REMOVED 2020-11-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Moved to script_output_paths_and_folders_API_scripts.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh script
#
#localrootscriptconfiguration
#HandleRootScriptConfiguration
#HandleLaunchInHomeFolder
#ShowFinalOutputAndLogPaths
#ConfigureRootPath
#ConfigureLogPath
#ConfigureCommonCLIParameterValues

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ REMOVED 2020-11-16


# -------------------------------------------------------------------------------------------------
# END:  Common Procedures
# =================================================================================================
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Script Output Paths and Folders for API scripts
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# ScriptOutputPathsforAPIScripts - Script Output Paths and Folders for API scripts Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ScriptOutputPathsforAPIScripts () {
    #
    # ScriptOutputPathsforAPIScripts - Script Output Paths and Folders for API scripts Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Script Output Paths and Folders for API scripts Handler Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${script_output_paths_API_handler} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling Script Output Paths and Folders for API scripts Handler Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${script_output_paths_API_handler} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    . ${script_output_paths_API_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Script Output Paths and Folders for API scripts Handler Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Script Output Paths and Folders for API scripts Handler Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call Script Output Paths and Folders for API scripts Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -

export configured_handler_root=${script_output_paths_API_handler_root}
export actual_handler_root=${configured_handler_root}

if [ "${configured_handler_root}" == "." ] ; then
    if [ ${ScriptSourceFolder} != ${localdotpath} ] ; then
        # Script is not running from it's source folder, might be linked, so since we expect the handler folder
        # to be relative to the script source folder, use the identified script source folder instead
        export actual_handler_root=${ScriptSourceFolder}
    else
        # Script is running from it's source folder
        export actual_handler_root=${configured_handler_root}
    fi
else
    # handler root path is not period (.), so stipulating fully qualified path
    export actual_handler_root=${configured_handler_root}
fi

export script_output_paths_API_handler_path=${actual_handler_root}/${script_output_paths_API_handler_folder}
export script_output_paths_API_handler=${script_output_paths_API_handler_path}/${script_output_paths_API_handler_file}

# Check that we can finde the Script Output Paths and Folders for API scripts Handler file
#
if [ ! -r ${script_output_paths_API_handler} ] ; then
    # no file found, that is a problem
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Script Output Paths and Folders for API scripts handler script file missing' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  File not found : '${script_output_paths_API_handler} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Root of folder path : '${script_output_paths_API_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder in Root path : '${script_output_paths_API_handler_folder} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder Root path    : '${script_output_paths_API_handler_path} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Script Filename     : '${script_output_paths_API_handler_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 251
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -

ScriptOutputPathsforAPIScripts "$@"


# =================================================================================================
# END:  Script Output Paths and Folders for API scripts
# =================================================================================================
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Management CLI API Operations Handling
# =================================================================================================




# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-08:01 - 

# -------------------------------------------------------------------------------------------------
# mgmt_cli keep alive configuration parameters
# -------------------------------------------------------------------------------------------------

#
# mgmtclikeepalivelast       : Very First or Last time CheckAPIKeepAlive was checked, using ${SECONDS}
# mgmtclikeepalivenow        : Current time for check versus last, using ${SECONDS}
# mgmtclikeepaliveelapsed    : The calculated seconds between the current check and last time CheckAPIKeepAlive was checked
# mgmtclikeepaliveinterval   : Interval between executions of CheckAPIKeepAlive desired, with default at 60 seconds
#
# Need to add CLI configuration parameter for this value ${mgmtclikeepaliveinterval} in the future to tweak
#

export mgmtclikeepalivelast=${SECONDS}
export mgmtclikeepalivenow=
export mgmtclikeepaliveelapsed=
export mgmtclikeepaliveinterval=60


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Check API Keep Alive Status - CheckAPIKeepAlive
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Check API Keep Alive Status.
#
CheckAPIKeepAlive () {
    #
    # Check API Keep Alive Status and on error try a login attempt
    #
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-08:01 - 
    
    #export mgmtclikeepalivelast=${SECONDS}
    #export mgmtclikeepalivenow=
    #export mgmtclikeepaliveinterval=60
    #export mgmtclikeepaliveelapsed=
    
    export mgmtclikeepalivenow=${SECONDS}
    export mgmtclikeepaliveelapsed=$(( ${mgmtclikeepalivenow} - ${mgmtclikeepalivelast} ))
    
    echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  last = '${mgmtclikeepalivelast}' current = '${mgmtclikeepalivenow}' elapsed = '${mgmtclikeepaliveelapsed} >> ${logfilepath}
    
    if [[ ${mgmtclikeepaliveelapsed} -gt ${mgmtclikeepaliveinterval} ]] ; then
        # Last check for keep alive was longer ago than the ${mgmtclikeepaliveinterval} so do the check
        
        # -------------------------------------------------------------------------------------------------
        
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
        tempworklogfile=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.keepalivecheck.log
        
        if ${LoggedIntoMgmtCli} ; then
            #echo -n `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  ' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  Elapsed seoconds since last check = '${mgmtclikeepaliveelapsed}', which is greater than the interval = '${mgmtclikeepaliveinterval} >> ${tempworklogfile}
            echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${tempworklogfile}
            
            echo -n `${dtzs}`${dtzsep}' ' > ${tempworklogfile}
            if ${addversion2keepalive} ; then
                #mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
                mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${tempworklogfile} 2>&1
                export errorreturn=$?
            else
                #mgmt_cli keepalive -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
                mgmt_cli keepalive -s ${APICLIsessionfile} >> ${tempworklogfile} 2>&1
                export errorreturn=$?
            fi
            
            echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${tempworklogfile}
            
            cat ${tempworklogfile} >> ${logfilepath}
            
            echo `${dtzs}`${dtzsep}' Remove temporary log file:  "'${tempworklogfile}'"' >> ${logfilepath}
            echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
            rm -v ${tempworklogfile} >> ${logfilepath} 2>&1
            
            echo `${dtzs}`${dtzsep} 'Keep Alive Check errorreturn = [ '${errorreturn}' ]' | tee -a -i ${logfilepath}
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli keepalive operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Lets see if we can login again' | tee -a -i ${logfilepath}
                
                export LoggedIntoMgmtCli=false
                
                . ${mgmt_cli_API_operations_handler} LOGIN "$@"
                LOGINEXITCODE=$?
                
                if [ ${LOGINEXITCODE} != 0 ] ; then
                    exit ${LOGINEXITCODE}
                else
                    export LoggedIntoMgmtCli=true
                    export errorreturn=0
                fi
            fi
        else
            # Uhhh what, this check should only happen if logged in
            echo `${dtzs}`${dtzsep} ' Executing mgmt_cli login instead of mgmt_cli keepalive check ?!?...  ' | tee -a -i ${logfilepath}
            
            export LoggedIntoMgmtCli=false
            
            . ${mgmt_cli_API_operations_handler} LOGIN "$@"
            LOGINEXITCODE=$?
            
            if [ ${LOGINEXITCODE} != 0 ] ; then
                exit ${LOGINEXITCODE}
            else
                export LoggedIntoMgmtCli=true
                export errorreturn=0
            fi
        fi
        
        echo `${dtzs}`${dtzsep} 'Keep Alive Check completed!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
    else
        # Last check for keep alive was more recent than the ${mgmtclikeepaliveinterval} so skip this one
        echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  Elapsed seoconds since last check = '${mgmtclikeepaliveelapsed}', which is within the interval = '${mgmtclikeepaliveinterval} >> ${logfilepath}
    fi
    export mgmtclikeepalivelast=${SECONDS}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-08:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckMgmtCLIAPIOperationsHandler - Management CLI API Operations Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckMgmtCLIAPIOperationsHandler () {
    #
    # CheckMgmtCLIAPIOperationsHandler - Management CLI API Operations Handler calling routine
    #
    
    errorresult=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Management CLI API Operations Handler Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${mgmt_cli_API_operations_handler} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Calling external Management CLI API Operations Handler Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} " - External Script : "${mgmt_cli_API_operations_handler} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    . ${mgmt_cli_API_operations_handler} CHECK "$@"
    errorresult=$?
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Management CLI API Operations Handler Script" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Error Return Code = '${errorresult} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Returned from external Management CLI API Operations Handler Script" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Error Return Code = '${errorresult} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Continueing local execution" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    return  ${errorresult}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Call Basic Script Setup for API Scripts Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -

export configured_handler_root=${mgmt_cli_API_operations_handler_root}
export actual_handler_root=${configured_handler_root}

if [ "${configured_handler_root}" == "." ] ; then
    if [ ${ScriptSourceFolder} != ${localdotpath} ] ; then
        # Script is not running from it's source folder, might be linked, so since we expect the handler folder
        # to be relative to the script source folder, use the identified script source folder instead
        export actual_handler_root=${ScriptSourceFolder}
    else
        # Script is running from it's source folder
        export actual_handler_root=${configured_handler_root}
    fi
else
    # handler root path is not period (.), so stipulating fully qualified path
    export actual_handler_root=${configured_handler_root}
fi

export mgmt_cli_API_operations_handler_path=${actual_handler_root}/${mgmt_cli_API_operations_handler_folder}
export mgmt_cli_API_operations_handler=${mgmt_cli_API_operations_handler_path}/${mgmt_cli_API_operations_handler_file}

# Check that we can finde the Basic Script Setup for API Scripts Handler file
#
if [ ! -r ${mgmt_cli_API_operations_handler} ] ; then
    # no file found, that is a problem
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Basic script setup API Scripts handler script file missing' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  File not found : '${mgmt_cli_API_operations_handler} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Root of folder path : '${mgmt_cli_API_operations_handler_root} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder in Root path : '${mgmt_cli_API_operations_handler_folder} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Folder Root path    : '${mgmt_cli_API_operations_handler_path} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Script Filename     : '${mgmt_cli_API_operations_handler_file} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 251
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-10-21 -

# Commands to execute specific actions in this script:
# CHECK |INIT - Initialize the API operations with checks of wether API is running, get port, API minimum version
# SETUPLOGIN  - Execute setup of API login based on CLI parameters passed and processed previously
# LOGIN       - Execute API login based on CLI parameters passed and processed previously
# PUBLISH     - Execute API publish based on previous login and session file
# LOGOUT      - Execute API logout based on previous login and session file
# APISTATUS   - Execute just the API Status check

SUBEXITCODE=0

CheckMgmtCLIAPIOperationsHandler "$@"
SUBEXITCODE=$?

if [ "${SUBEXITCODE}" != "0" ] ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Terminating script..." | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Exitcode ${SUBEXITCODE}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit ${SUBEXITCODE}
else
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
fi


# =================================================================================================
# END:  Management CLI API Operations Handling
# =================================================================================================
# =================================================================================================


# =================================================================================================
# START:  Specific Procedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END:  Specific Procedures
# =================================================================================================


# =================================================================================================
# END:  Setup CLI Parameter based values
# =================================================================================================
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# =================================================================================================
# START:  Main operations - 
# =================================================================================================


# MODIFIED 2021-11-09 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if ${OpsModeMDSM} ; then
    # Operations Mode All Domains implies MDSM operation requirement, so check that first
    if ! ${sys_type_MDS} ; then
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!! This script is expected to run on Multi-Domain Security Management (MDSM) !!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Exiting...!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        exit 255
        
    fi
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-11-09


# =================================================================================================
# START:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================

# MODIFIED 2021-11-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if ${UseR8XAPI} ; then
    
    echo `${dtzs}`${dtzsep} 'Setting up mgmt_cli login...' | tee -a -i ${logfilepath}
    
    . ${mgmt_cli_API_operations_handler} SETUPLOGIN "$@"
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if ${AuthenticationMaaS} ; then
        # AuthenticateMaaS is set, it is assumed we are connecting to Smart-1 Cloud MaaS
        echo `${dtzs}`${dtzsep} 'A CLI Parameter MaaS (--Maas|--maas|--MAAS) (Smart-1 Cloud) was passed so check for MaaS (Smart-1 Cloud) authentication requirements' | tee -a -i ${logfilepath}
        if [ ! -z "${CLIparm_mgmt}" ] ; then
            #Context also requires setting the management server value -m which is done
            echo `${dtzs}`${dtzsep} 'A CLI Parameter for management server (-m) was passed - namely '${CLIparm_mgmt} | tee -a -i ${logfilepath}
            if [ ! -z "${CLIparm_domain}" ] ; then
                # Since a context was set in the CLI parameters, we require a domain -d value, which was found
                echo `${dtzs}`${dtzsep} 'A CLI Parameter for domains (-d) was passed - namely '${CLIparm_domain} | tee -a -i ${logfilepath}
                if ${CLIparm_use_api_key} ; then
                    #Context also requires setting the api-key value --api-key which is done
                    echo `${dtzs}`${dtzsep} 'A CLI Parameter for api-key (--api-key) was passed - namely '${CLIparm_api_key} | tee -a -i ${logfilepath}
                else
                    # Since a context was set in the CLI parameters, we require a api-key --api-key value, which was NOT found so exiting
                    # Houston, we have a problem... the CLIparm_domain was not set
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} '!!!! NO api-key (--api-key "<api-key-value>") was passed, which is required!!!!' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Exiting...!' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                    
                    exit 245
                fi
            else
                # Since a context was set in the CLI parameters, we require a domain -d value, which was NOT found so exiting
                # Houston, we have a problem... the CLIparm_domain was not set
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '!!!! NO domain (-d <domain_name>)was passed, which is required!!!!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Exiting...!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                
                exit 246
            fi
        else
            # Since a context was set in the CLI parameters, we require a management server address (-m <ip-address>), which was NOT found so exiting
            # Houston, we have a problem... the CLIparm_domain was not set
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '!!!! NO management server address (-m <ip-address>) was passed, which is required!!!!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Exiting...!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            exit 247
        fi
    else
        # AuthenticateMaaS not set, so it is assumed we are not connecting to Smart-1 Cloud MaaS
        
        if [ "${CLIparm_domain}" == "System Data" ] ; then
            # A CLI Parameter for domains (-d) was passed - namely "System Data" a known domain
            echo `${dtzs}`${dtzsep} 'A CLI Parameter for domains (-d) was passed - namely "System Data" a known domain.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'The requested domain : '${CLIparm_domain}' actually exists on the management host queried' | tee -a -i ${logfilepath}
        elif [ "${CLIparm_domain}" == "Global" ] ; then
            # A CLI Parameter for domains (-d) was passed - namely "Global" a known domain
            echo `${dtzs}`${dtzsep} 'A CLI Parameter for domains (-d) was passed - namely "Global" a known domain.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'The requested domain : '${CLIparm_domain}' actually exists on the management host queried' | tee -a -i ${logfilepath}
        elif [ ! -z "${CLIparm_domain}" ] ; then
            # A CLI Parameter for domains (-d) was passed, so check if that domain exists and then add it as the last element to the domains array
            echo `${dtzs}`${dtzsep} 'A CLI Parameter for domains (-d) was passed.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Check if the requested domain : '${CLIparm_domain}' actually exists on the management host queried' | tee -a -i ${logfilepath}
            
            export MgmtCLI_Base_OpParms='-f json'
            export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
            export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}
            
            if [ ! -z "${CLIparm_mgmt}" ] ; then
            # working with remote management server
                Check4DomainByName=$(mgmt_cli --port ${APICLIwebsslport} --conn-timeout ${APICLIconntimeout} --unsafe-auto-accept true -m "${CLIparm_mgmt}" -d "System Data" show domains limit 500 offset 0 details-level standard -f json | ${JQ} '.objects[] | select(."name"=="'${CLIparm_domain}'") | ."name"' -r)
                echo `${dtzs}`${dtzsep} 'You may be required to provide credentials for "System Data" domain logon!' | tee -a -i ${logfilepath}
            else
                Check4DomainByName=$(mgmt_cli -r true --port ${APICLIwebsslport} --conn-timeout ${APICLIconntimeout} --unsafe-auto-accept true -d "System Data" show domains limit 500 offset 0 details-level standard -f json | ${JQ} '.objects[] | select(."name"=="'${CLIparm_domain}'") | ."name"' -r)
            fi
            CheckCLIParmDomain=${Check4DomainByName}
            
            if [ x"${CheckCLIParmDomain}" == x"" ] ; then
                # Houston, we have a problem... the CLIparm_domain check result was null for this MDSM MDS host
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '!!!! The requested domain : '${CLIparm_domain}' was not found on this MDSM MDS host!!!!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Exiting...!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                
                exit 250
            else
                # we are good to go, so add this domain to the array and stop processing other domains
                echo `${dtzs}`${dtzsep} 'The requested domain : '${CLIparm_domain}' is found on this MDSM MDS host.' | tee -a -i ${logfilepath}
            fi
        else
            # no CLI Parameter for domains (-d) was passed
            echo `${dtzs}`${dtzsep} 'No CLI Parameter for domains (-d) was passed.' | tee -a -i ${logfilepath}
        fi
    fi
    
    if ${OpsModeMDSMAllDomains} ; then
        # Handle x_All_Domains_y script, so logon to "System Data" domain
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Operating in *_all_domains_* script so using "System Data" domain initially' | tee -a -i ${logfilepath}
        fi
        export domaintarget="System Data"
    elif [ ! -z "${CLIparm_domain}" ] ; then
        # Handle domain parameter for login string
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Command line parameter for domain set!  Using Domain = '${CLIparm_domain} | tee -a -i ${logfilepath}
        fi
        export domaintarget=${CLIparm_domain}
    else
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Command line parameter for domain NOT set!' | tee -a -i ${logfilepath}
        fi
        export domaintarget=
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'domaintarget = "'${domaintarget}'" ' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'domaintarget = "'${domaintarget}'" ' >> ${logfilepath}
    fi
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export LoggedIntoMgmtCli=false
    
    . ${mgmt_cli_API_operations_handler} LOGIN "$@"
    LOGINEXITCODE=$?
    
    if [ "${LOGINEXITCODE}" != "0" ] ; then
        exit ${LOGINEXITCODE}
    else
        export LoggedIntoMgmtCli=true
    fi
    
fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-09

# =================================================================================================
# END:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations - Other Path Values
# -------------------------------------------------------------------------------------------------

if ${script_dump_csv} ; then
    export APICLIdumppathcsv=${APICLICSVExportpathbase}/csv
fi

if ${script_dump_json} ; then
    export APICLIdumppathjson=${APICLICSVExportpathbase}/json
fi

if ${script_dump_full} ; then
    export APICLIdumppathjsonfull=${APICLIdumppathjson}/full
fi

if ${script_dump_standard} ; then
    export APICLIdumppathjsonstandard=${APICLIdumppathjson}/standard
fi



# =================================================================================================
# START:  Export object to CSV
# =================================================================================================


#export APICLIdetaillvl=standard

export APICLIdetaillvl=full

# ADDED 2018-05-04-2 -
# Only changes this parameter to force the specific state of CLIparm_NoSystemObjects
# since it is set using the command line parameters --SO (false) and --NSO (true)
#
#export CLIparm_NoSystemObjects=false

# ADDED 2018-04-25 -
export primarytargetoutputformat=${FileExtCSV}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Execution Common Initial File and Path Location Handlers
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CommonInitialFileAndPathLocationHandlerFirst
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-06:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The CommonInitialFileAndPathLocationHandlerFirst is EXPLAIN.
#

CommonInitialFileAndPathLocationHandlerFirst () {
    
    # ------------------------------------------------------------------------
    #
    # SANITY CHECK FOR ${templogfilepath} and associated log file or HARD EXIT
    #
    
    if [ x"${templogfilepath}" = x"" ] ; then
        # Missing temporary log file path value
        echo `${dtzs}`${dtzsep}
        echo `${dtzs}`${dtzsep} '!!!! ERROR - missing value for ${templogfilepath} ! - EXITING !!!!'
        exit 253
    fi
    if [ ! -r ${templogfilepath} ] ; then
        # Unable to write to temporary log file path
        echo `${dtzs}`${dtzsep}
        echo `${dtzs}`${dtzsep} '!!!! ERROR - Unable to write to temporary log file path : "'${templogfilepath}'" ! - EXITING !!!!'
        exit 252
    fi
    
    # ------------------------------------------------------------------------
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-07:01 -
    #
    
    #printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'X' "${X}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'MinAPIObjectLimit' "${MinAPIObjectLimit}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'MaxAPIObjectLimit' "${MaxAPIObjectLimit}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'RecommendedAPIObjectLimitMDSM' "${RecommendedAPIObjectLimitMDSM}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'DefaultAPIObjectLimit' "${DefaultAPIObjectLimit}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'DefaultAPIObjectLimitMDSM' "${DefaultAPIObjectLimitMDSM}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'domainnamenospace' "${domainnamenospace}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'CLIparm_NODOMAINFOLDERS' "${CLIparm_NODOMAINFOLDERS}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'primarytargetoutputformat' "${primarytargetoutputformat}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLICSVExportpathbase' "${APICLICSVExportpathbase}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIpathexport' "${APICLIpathexport}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathroot' "${JSONRepopathroot}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathbase' "${JSONRepopathbase}" >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:02 -
    #
    
    echo `${dtzs}`${dtzsep} 'Handle adding domain name = ['"${domainnamenospace}"'] to path for MDM operations' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Current APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Current JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
    
    if ! ${CLIparm_NODOMAINFOLDERS} ; then
        # adding domain name to path for MDM operations
        if [ ! -z "${domainnamenospace}" ] ; then
            # Handle adding domain name to path for MDM operations
            export APICLIpathexport=${APICLICSVExportpathbase}/${domainnamenospace}
            
            echo `${dtzs}`${dtzsep} 'Handle adding domain name = ['"${domainnamenospace}"'] to path for MDM operations' >> ${templogfilepath}
            echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
            
            if [ ! -r ${APICLIpathexport} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
            fi
            
            export JSONRepopathbase=${JSONRepopathroot}/${domainnamenospace}
            
            echo `${dtzs}`${dtzsep} 'Handle adding domain name = ['"${domainnamenospace}"'] to JSON repository path for MDM operations' >> ${templogfilepath}
            echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
            
            if [ ! -r ${JSONRepopathbase} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>&1
            fi
        else
            # Domain name is empty so not adding
            export APICLIpathexport=${APICLICSVExportpathbase}
            
            echo `${dtzs}`${dtzsep} 'Handle empty domain name to path for MDM operations, so NO CHANGE' >> ${templogfilepath}
            echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
            
            if [ ! -r ${APICLIpathexport} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
            fi
            
            export JSONRepopathbase=${JSONRepopathroot}
            
            echo `${dtzs}`${dtzsep} 'Handle empty domain name to JSON repository path for MDM operations, so NO CHANGE' >> ${templogfilepath}
            echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
            
            if [ ! -r ${JSONRepopathbase} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>&1
            fi
        fi
    else
        # NOT adding domain name to path for MDM operations
        export APICLIpathexport=${APICLICSVExportpathbase}
        
        echo `${dtzs}`${dtzsep} 'NOT adding domain name = ['"${domainnamenospace}"'] to path for MDM operations' >> ${templogfilepath}
        echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
        
        if [ ! -r ${APICLIpathexport} ] ; then
            echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
            mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
        fi
        
        export JSONRepopathbase=${JSONRepopathroot}
        
        echo `${dtzs}`${dtzsep} 'NOT adding domain name = ['"${domainnamenospace}"'] to JSON repository path for MDM operations' >> ${templogfilepath}
        echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
        
        if [ ! -r ${JSONRepopathbase} ] ; then
            echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
            mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>&1
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'Final APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Final JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CommonInitialFileAndPathLocationHandlerLast
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-06:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The CommonInitialFileAndPathLocationHandlerLast is EXPLAIN.
#

CommonInitialFileAndPathLocationHandlerLast () {
    
    # ------------------------------------------------------------------------
    #
    # SANITY CHECK FOR ${templogfilepath} and associated log file or HARD EXIT
    #
    
    if [ x"${templogfilepath}" = x"" ] ; then
        # Missing temporary log file path value
        echo `${dtzs}`${dtzsep}
        echo `${dtzs}`${dtzsep} '!!!! ERROR - missing value for ${templogfilepath} ! - EXITING !!!!'
        exit 253
    fi
    if [ ! -r ${templogfilepath} ] ; then
        # Unable to write to temporary log file path
        echo `${dtzs}`${dtzsep}
        echo `${dtzs}`${dtzsep} '!!!! ERROR - Unable to write to temporary log file path : "'${templogfilepath}'" ! - EXITING !!!!'
        exit 252
    fi
    
    # ------------------------------------------------------------------------
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:02 -
    #
    
    if [ x"${primarytargetoutputformat}" = x"${FileExtJSON}" ] ; then
        # for JSON provide the detail level
        
        export APICLIpathexport=${APICLIpathexport}/${APICLIdetaillvl}
        
        if [ ! -r ${APICLIpathexport} ] ; then
            echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
            mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
        fi
        
        export APICLIJSONpathexportwip=
        if ${script_uses_wip_json} ; then
            # script uses work-in-progress (wip) folder for json
            
            export APICLIJSONpathexportwip=${APICLIpathexport}/wip
            
            if [ ! -r ${APICLIJSONpathexportwip} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${APICLIJSONpathexportwip} >> ${templogfilepath} 2>&1
            fi
        fi
    else
        export APICLIJSONpathexportwip=
    fi
    
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'After handling json target' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'APICLIJSONpathexportwip = '${APICLIJSONpathexportwip} >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:02 -
    #
    
    if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
        # for CSV handle specifics, like wip
        
        export APICLICSVpathexportwip=
        if ${script_uses_wip} ; then
            # script uses work-in-progress (wip) folder for csv
            
            export APICLICSVpathexportwip=${APICLIpathexport}/wip
            
            if [ ! -r ${APICLICSVpathexportwip} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${APICLICSVpathexportwip} >> ${templogfilepath} 2>&1
            fi
        fi
    else
        export APICLICSVpathexportwip=
    fi
    
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'After handling csv target' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'APICLICSVpathexportwip = '${APICLICSVpathexportwip} >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:02 -
    #
    
    export APICLIfileexportpost='_'${APICLIdetaillvl}'_'${APICLIfileexportsuffix}
    
    export APICLICSVheaderfilesuffix=header
    
    export APICLICSVfileexportpost='_'${APICLIdetaillvl}'_'${APICLICSVfileexportsuffix}
    
    export APICLIJSONheaderfilesuffix=header
    export APICLIJSONfooterfilesuffix=footer
    
    export APICLIJSONfileexportpost='_'${APICLIdetaillvl}'_'${APICLIJSONfileexportsuffix}
    
    # In export operations, we do not utilize the details level of other than "standard" export types, so either "full" or "standard"
    export JSONRepoDetailname=${APICLIdetaillvl}
    case ${APICLIdetaillvl} in
        'full' )
            export JSONRepoDetailname=${APICLIdetaillvl}
            ;;
        'standard' )
            export JSONRepoDetailname=${APICLIdetaillvl}
            ;;
        * )
            export JSONRepoDetailname='full'
            ;;
    esac
    
    export JSONRepofilepost='_'${JSONRepoDetailname}'_'${JSONRepofilesuffix}
    
    #printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'X' "${X}" >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Setup other file and path variables' >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIfileexportpost' "${APICLIfileexportpost}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLICSVheaderfilesuffix' "${APICLICSVheaderfilesuffix}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLICSVfileexportpost' "${APICLICSVfileexportpostX}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIJSONheaderfilesuffix' "${APICLIJSONheaderfilesuffix}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIJSONfooterfilesuffix' "${APICLIJSONfooterfilesuffix}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIJSONfileexportpost' "${APICLIJSONfileexportpost}" >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:02 -
    #
    
    #printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'X' "${X}" >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Working operations file and path variables' >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'primarytargetoutputformat' "${primarytargetoutputformat}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIpathexport' "${APICLIpathexport}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathroot' "${JSONRepopathroot}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathbase' "${JSONRepopathbase}" >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------'  >>  ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END : Execution Common Initial File and Path Location Handlers
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# Start executing Main operations
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Configure working paths for export and dump
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-06:02 -
#

# ------------------------------------------------------------------------
# Set and clear temporary log file
# ------------------------------------------------------------------------

export templogfilepath=/var/tmp/templog_${ScriptName}.`date +%Y%m%d-%H%M%S%Z`.log
echo `${dtzs}`${dtzsep} > ${templogfilepath}

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------'  >>  ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Configure working paths for export and dump' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}

# ------------------------------------------------------------------------

CommonInitialFileAndPathLocationHandlerFirst

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
# ------------------------------------------------------------------------
# START:  This section is specific to scripts that are NOT action handlers
# ------------------------------------------------------------------------

# MODIFIED 2023-03-06:02 -
#

if ${script_use_delete} ; then
    # primary operation is delete
    
    export APICLIpathexport=${APICLIpathexport}/delete
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Delete using '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}
    
elif ${script_use_import} ; then
    # primary operation is import
    
    export APICLIpathexport=${APICLIpathexport}/import
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Import using '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}
    
elif ${script_use_export} ; then
    # primary operation is export
    
    # primary operation is export to primarytargetoutputformat
    export APICLIpathexport=${APICLIpathexport}/${primarytargetoutputformat}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Export to '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}
    
else
    # primary operation is something else
    
    export APICLIpathexport=${APICLIpathbase}
    
fi

if [ ! -r ${APICLIpathexport} ] ; then
    echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
    mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
fi

echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'After Evaluation of script type' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}


# ------------------------------------------------------------------------
# END:  This section is specific to scripts that are NOT action handlers
# ------------------------------------------------------------------------
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
# ------------------------------------------------------------------------

CommonInitialFileAndPathLocationHandlerLast

# ------------------------------------------------------------------------

# MODIFIED 2023-03-06:02 -
#

echo `${dtzs}`${dtzsep} 'Import temporary log file from "'${templogfilepath}'"' >> ${templogfilepath}

echo `${dtzs}`${dtzsep} >> ${logfilepath}

##echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
cat ${templogfilepath} >> ${logfilepath} 2>&1

echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
rm -v ${templogfilepath} >> ${logfilepath} 2>&1

echo `${dtzs}`${dtzsep} >> ${logfilepath}

# ------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Configure working paths for export and dump - Completed
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------



# MODIFIED 2021-10-22 -
#

echo `${dtzs}`${dtzsep} 'Dump "'${APICLIdetaillvl}'" details to path:  '${APICLIpathexport} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# MODIFIED 2021-10-22 -


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Main Operational repeated proceedures - Export Objects to CSV
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Configure mgmt_cli operational show parameters - ConfigureMgmtCLIOperationalParametersExport
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-12:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Configure mgmt_cli operational show parameters.
#
ConfigureMgmtCLIOperationalParametersExport () {
    #
    # Configure mgmt_cli operational show parameters
    #
    
    errorreturn=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Procedure ConfigureMgmtCLIOperationalParametersExport Starting!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}' --conn-timeout '${APICLIconntimeout}
    
    #export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    export MgmtCLI_IgnoreErr_OpParms='--ignore-errors true'
    if ${APIobjectcanignoreerror} ; then
        export MgmtCLI_IgnoreErr_OpParms='ignore-errors true '${MgmtCLI_IgnoreErr_OpParms}
    fi
    if ${APIobjectcanignorewarning} ; then
        export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true '${MgmtCLI_IgnoreErr_OpParms}
    fi
    
    if ${APIobjectusesdetailslevel} ; then
        #export MgmtCLI_Show_OpParms='details-level "'${WorkingAPICLIdetaillvl}'" '${MgmtCLI_IgnoreErr_OpParms}' '${MgmtCLI_Base_OpParms}
        export MgmtCLI_Show_OpParms='details-level "'${WorkingAPICLIdetaillvl}'" '${MgmtCLI_Base_OpParms}
    else
        #export MgmtCLI_Show_OpParms=${MgmtCLI_IgnoreErr_OpParms}' '${MgmtCLI_Base_OpParms}
        export MgmtCLI_Show_OpParms=${MgmtCLI_Base_OpParms}
    fi
    
    if ${APIobjectderefgrpmem} ; then
        export MgmtCLI_Show_OpParms='dereference-group-members true '${MgmtCLI_Show_OpParms}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_Base_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_Base_OpParms} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectcanignoreerror' ' : ' >> ${logfilepath} ; echo ${APIobjectcanignoreerror} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectcanignorewarning' ' : ' >> ${logfilepath} ; echo ${APIobjectcanignorewarning} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_IgnoreErr_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_IgnoreErr_OpParms} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'WorkingAPICLIdetaillvl' ' : ' >> ${logfilepath} ; echo ${WorkingAPICLIdetaillvl} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectusesdetailslevel' ' : ' >> ${logfilepath} ; echo ${APIobjectusesdetailslevel} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_Show_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_Show_OpParms} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Procedure ConfigureMgmtCLIOperationalParametersExport completed!  errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-06-12:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ClearObjectDefinitionData
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ClearObjectDefinitionData clear the data associated with objects to zero and start clean.
#

ClearObjectDefinitionData () {
    
    #
    # Maximum Object defined
    #
    
    # +-------------------------------------------------------------------------------------------------
    # | Complex Object : Specific Complex OBJECT : 
    # |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
    # |  - Reference Details and initial object
    # +-------------------------------------------------------------------------------------------------
    
    #export APICLIobjecttype=<object_type_singular>
    #export APICLIobjectstype=<object_type_plural>
    #export APICLIcomplexobjecttype=<complex_object_type_singular>
    #export APICLIcomplexobjectstype=<complex_object_type_plural>
    #export APIobjectminversion=<object_type_api_version>|example:  1.1
    #export APIobjectexportisCPI=false|true
    
    #export APIGenObjectTypes=<Generic-Object-Type>|example:  generic-objects
    #export APIGenObjectClassField=<Generic-Object-ClassField>|example:  class-name
    #export APIGenObjectClass=<Generic-Object-Class>|example:  "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
    #export APIGenObjectClassShort=<Generic-Object-Class-Short>|example:  "appfw.CpmiUserApplication"
    #export APIGenObjectField=<Generic-Object-Key-Field>|example:  uid
    
    #export APIGenObjobjecttype=<Generic-Object-Type>|example:  appfw_CpmiUserApplication_application-site
    #export APIGenObjobjectstype=<Generic-Objects-Type-plural>|example:  appfw_CpmiUserApplication_application-sites
    #export APIGenObjcomplexobjecttype=<Generic-Complex-Object-Type>|example:  appfw_CpmiUserApplication_application-site
    #export APIGenObjcomplexobjectstype=<Generic-Complex-Objects-Type-plural>|example:  appfw_CpmiUserApplication_application-sites
    #export APIGenObjobjectkey=name
    #export APIGenObjobjectkeydetailslevel=standard
    
    #export APIobjectspecifickey='url-list'
    
    #export APIobjectspecificselector00key=
    #export APIobjectspecificselector00value=
    #export APICLIexportnameaddon=
    
    #export APICLIexportcriteria01key=
    #export APICLIexportcriteria01value=
    
    #export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
    #export APICLICSVobjecttype=${APICLIobjectstype}
    #export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
    #export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
    #export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
    #export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}
    #
    #export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
    #export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
    
    #export APIobjectdoexport=true
    #export APIobjectdoexportJSON=true
    #export APIobjectdoexportCSV=true
    #export APIobjectdoimport=true
    #export APIobjectdorename=true
    #export APIobjectdoupdate=true
    #export APIobjectdodelete=true
    
    #export APIobjectusesdetailslevel=true
    #export APIobjectcanignorewarning=true
    #export APIobjectcanignoreerror=true
    #export APIobjectcansetifexists=false
    #export APIobjectderefgrpmem=false
    #export APIobjecttypehasname=true
    #export APIobjecttypehasuid=true
    #export APIobjecttypehasdomain=true
    #export APIobjecttypehastags=true
    #export APIobjecttypehasmeta=true
    #export APIobjecttypeimportname=true
    
    #export APIobjectCSVFileHeaderAbsoluteBase=false
    #export APIobjectCSVJQparmsAbsoluteBase=false
    
    #export APIobjectCSVexportWIP=false
    
    #export AugmentExportedFields=false
    
    #if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        #export AugmentExportedFields=true
    #elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
        #export AugmentExportedFields=true
    #elif ${OnlySystemObjects} ; then
        #export AugmentExportedFields=true
    #else
        #export AugmentExportedFields=false
    #fi
    
    #if ! ${AugmentExportedFields} ; then
        #export APICLIexportnameaddon=
    #else
        #export APICLIexportnameaddon=FOR_REFERENCE_ONLY
    #fi
    
    ##
    ## APICLICSVsortparms can change due to the nature of the object
    ##
    #export APICLICSVsortparms='-f -t , -k 1,1'
    
    #export CSVFileHeader=
    #if ! ${AugmentExportedFields} ; then
        #export CSVFileHeader='"primary-category"'
        ## The risk key is not imported
        ##export CSVFileHeader=${CSVFileHeader}',"risk"'
    #else
        #export CSVFileHeader='"application-id","primary-category"'
        ## The risk key is not imported
        ##export CSVFileHeader=${CSVFileHeader}',"risk"'
    #fi
    ##export CSVFileHeader=
    ##export CSVFileHeader='"key","key"'
    ##export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
    ##export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
    ##export CSVFileHeader=${CSVFileHeader}',"icon"'
    
    #export CSVJQparms=
    #if ! ${AugmentExportedFields} ; then
        #export CSVJQparms='.["primary-category"]'
        ## The risk key is not imported
        ##export CSVJQparms=${CSVJQparms}', .["risk"]'
    #else
        #export CSVJQparms='.["application-id"], .["primary-category"]'
        ## The risk key is not imported
        #export CSVJQparms=${CSVJQparms}', .["risk"]'
    #fi
    ##export CSVJQparms=
    ##export CSVJQparms='.["value"], .["value"]'
    ##export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
    ##export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
    ##export CSVJQparms=${CSVJQparms}', .["icon"]'
    
    # +-------------------------------------------------------------------------------------------------
    # +-------------------------------------------------------------------------------------------------
    
    export APICLIobjecttype=
    export APICLIobjectstype=
    export APICLIcomplexobjecttype=
    export APICLIcomplexobjectstype=
    export APIobjectminversion=
    export APIobjectexportisCPI=
    
    export APIGenObjectTypes=
    export APIGenObjectClassField=
    export APIGenObjectClass=
    export APIGenObjectClassShort=
    export APIGenObjectField=
    
    export APIGenObjobjecttype=
    export APIGenObjobjectstype=
    export APIGenObjcomplexobjecttype=
    export APIGenObjcomplexobjectstype=
    export APIGenObjjsonrepofileobject=
    export APIGenObjcomplexjsonrepofileobject=
    export APIGenObjCSVobjecttype=
    export APIGenObjcomplexCSVobjecttype=
    export APIGenObjobjectkey=
    export APIGenObjobjectkeydetailslevel=
    
    export APIobjectspecifickey=
    
    export APIobjectspecificselector00key=
    export APIobjectspecificselector00value=
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key=
    export APICLIexportcriteria01value=
    
    export APIobjectjsonrepofileobject=
    export APICLICSVobjecttype=
    export APIobjectrecommendedlimit=
    export APIobjectrecommendedlimitMDSM=
    
    export APIobjectdoexport=
    export APIobjectdoexportJSON=
    export APIobjectdoexportCSV=
    export APIobjectdoimport=
    export APIobjectdorename=
    export APIobjectdoupdate=
    export APIobjectdodelete=
    
    export APIobjectusesdetailslevel=
    export APIobjectcanignorewarning=
    export APIobjectcanignoreerror=
    export APIobjectcansetifexists=
    export APIobjectderefgrpmem=
    export APIobjecttypehasname=
    export APIobjecttypehasuid=
    export APIobjecttypehasdomain=
    export APIobjecttypehastags=
    export APIobjecttypehasmeta=
    export APIobjecttypeimportname=
    
    export APIobjectCSVFileHeaderAbsoluteBase=
    export APIobjectCSVJQparmsAbsoluteBase=
    
    export APIobjectCSVexportWIP=
    
    export AugmentExportedFields=
    
    export CSVFileHeader=
    export CSVJQparms=
    
    # +-------------------------------------------------------------------------------------------------
    # +-------------------------------------------------------------------------------------------------
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-08:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DumpObjectDefinitionData
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The DumpObjectDefinitionData dump the content of the current object definition data to terminal and/or log.
#

DumpObjectDefinitionData () {
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Object Definition Data details - show and log' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AAA' "${AAA}" | tee -a -i ${logfilepath}
        #
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjecttype' "${APICLIobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjectstype' "${APICLIobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjecttype' "${APICLIcomplexobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjectstype' "${APICLIcomplexobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectminversion' "${APIobjectminversion}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectexportisCPI' "${APIobjectexportisCPI}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectTypes' "${APIGenObjectTypes}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassField' "${APIGenObjectClassField}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClass' "${APIGenObjectClass}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassShort' "${APIGenObjectClassShort}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectField' "${APIGenObjectField}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjecttype' "${APIGenObjobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjecttype' "${APIGenObjcomplexobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjectstype' "${APIGenObjcomplexobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjjsonrepofileobject' "${APIGenObjjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexjsonrepofileobject' "${APIGenObjcomplexjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjCSVobjecttype' "${APIGenObjCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexCSVobjecttype' "${APIGenObjcomplexCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkey' "${APIGenObjobjectkey}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkeydetailslevel' "${APIGenObjobjectkeydetailslevel}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecifickey' "${APIobjectspecifickey}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00key' "${APIobjectspecificselector00key}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00value' "${APIobjectspecificselector00value}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportnameaddon' "${APICLIexportnameaddon}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01key' "${APICLIexportcriteria01key}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01value' "${APICLIexportcriteria01value}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVobjecttype' "${APICLICSVobjecttype}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimit' "${APIobjectrecommendedlimit}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimitMDSM' "${APIobjectrecommendedlimitMDSM}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexport' "${APIobjectdoexport}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportJSON' "${APIobjectdoexportJSON}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportCSV' "${APIobjectdoexportCSV}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoimport' "${APIobjectdoimport}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdorename' "${APIobjectdorename}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoupdate' "${APIobjectdoupdate}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdodelete' "${APIobjectdodelete}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectusesdetailslevel' "${APIobjectusesdetailslevel}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignorewarning' "${APIobjectcanignorewarning}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignoreerror' "${APIobjectcanignoreerror}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcansetifexists' "${APIobjectcansetifexists}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectderefgrpmem' "${APIobjectderefgrpmem}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasname' "${APIobjecttypehasname}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasuid' "${APIobjecttypehasuid}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasdomain' "${APIobjecttypehasdomain}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehastags' "${APIobjecttypehastags}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasmeta' "${APIobjecttypehasmeta}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypeimportname' "${APIobjecttypeimportname}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVFileHeaderAbsoluteBase' "${APIobjectCSVFileHeaderAbsoluteBase}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVJQparmsAbsoluteBase' "${APIobjectCSVJQparmsAbsoluteBase}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVexportWIP' "${APIobjectCSVexportWIP}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AugmentExportedFields' "${AugmentExportedFields}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVFileHeader' "${CSVFileHeader}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVJQparms' "${CSVJQparms}" >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
    else
        echo `${dtzs}`${dtzsep} 'Object Definition Data details - dump to log' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AAA' "${AAA}" >> ${logfilepath}
        #
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjecttype' "${APICLIobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjectstype' "${APICLIobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjecttype' "${APICLIcomplexobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjectstype' "${APICLIcomplexobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectminversion' "${APIobjectminversion}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectexportisCPI' "${APIobjectexportisCPI}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectTypes' "${APIGenObjectTypes}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassField' "${APIGenObjectClassField}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClass' "${APIGenObjectClass}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassShort' "${APIGenObjectClassShort}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectField' "${APIGenObjectField}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjecttype' "${APIGenObjobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjecttype' "${APIGenObjcomplexobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjectstype' "${APIGenObjcomplexobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjjsonrepofileobject' "${APIGenObjjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexjsonrepofileobject' "${APIGenObjcomplexjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjCSVobjecttype' "${APIGenObjCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexCSVobjecttype' "${APIGenObjcomplexCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkey' "${APIGenObjobjectkey}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkeydetailslevel' "${APIGenObjobjectkeydetailslevel}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecifickey' "${APIobjectspecifickey}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00key' "${APIobjectspecificselector00key}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00value' "${APIobjectspecificselector00value}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportnameaddon' "${APICLIexportnameaddon}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01key' "${APICLIexportcriteria01key}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01value' "${APICLIexportcriteria01value}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVobjecttype' "${APICLICSVobjecttype}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimit' "${APIobjectrecommendedlimit}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimitMDSM' "${APIobjectrecommendedlimitMDSM}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexport' "${APIobjectdoexport}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportJSON' "${APIobjectdoexportJSON}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportCSV' "${APIobjectdoexportCSV}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoimport' "${APIobjectdoimport}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdorename' "${APIobjectdorename}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoupdate' "${APIobjectdoupdate}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdodelete' "${APIobjectdodelete}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectusesdetailslevel' "${APIobjectusesdetailslevel}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignorewarning' "${APIobjectcanignorewarning}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignoreerror' "${APIobjectcanignoreerror}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcansetifexists' "${APIobjectcansetifexists}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectderefgrpmem' "${APIobjectderefgrpmem}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasname' "${APIobjecttypehasname}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasuid' "${APIobjecttypehasuid}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasdomain' "${APIobjecttypehasdomain}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehastags' "${APIobjecttypehastags}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasmeta' "${APIobjecttypehasmeta}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypeimportname' "${APIobjecttypeimportname}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVFileHeaderAbsoluteBase' "${APIobjectCSVFileHeaderAbsoluteBase}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVJQparmsAbsoluteBase' "${APIobjectCSVJQparmsAbsoluteBase}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVexportWIP' "${APIobjectCSVexportWIP}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AugmentExportedFields' "${AugmentExportedFields}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVFileHeader' "${CSVFileHeader}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVJQparms' "${CSVJQparms}" >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
    fi
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-08:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureWorkAPIObjectLimit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-03:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureWorkAPIObjectLimit handles the stanard configuration of the ${WorkAPIObjectLimit} value.
#

ConfigureWorkAPIObjectLimit () {
    
    # MODIFIED 2023-03-03:02 -
    
    if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        export WorkAPIObjectLimit=1
        echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit set to '${WorkAPIObjectLimit}' because this object is singular and special' | tee -a -i ${logfilepath}
    else
        export WorkAPIObjectLimit=${MaxAPIObjectLimit}
        if [ -z "${domainnamenospace}" ] ; then
            # an empty ${domainnamenospace} indicates that we are not working towards an MDSM
            export WorkAPIObjectLimit=${APIobjectrecommendedlimit}
        else
            # an empty ${domainnamenospace} indicates that we are working towards an MDSM
            export WorkAPIObjectLimit=${APIobjectrecommendedlimitMDSM}
        fi
        
        echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
        
        if ${OverrideMaxObjects} ; then
            echo `${dtzs}`${dtzsep} 'Override Maximum Objects with OverrideMaxObjectsNumber :  '${OverrideMaxObjectsNumber}' objects value' | tee -a -i ${logfilepath}
            export WorkAPIObjectLimit=${OverrideMaxObjectsNumber}
        fi
        
        echo `${dtzs}`${dtzsep} 'Final WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimit' "${APIobjectrecommendedlimit}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimitMDSM' "${APIobjectrecommendedlimitMDSM}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'WorkAPIObjectLimit' "${WorkAPIObjectLimit}" >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-03:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureCSVFileNamesForExport
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureCSVFileNamesForExport Configures the CSV File name for Export operations.
#

ConfigureCSVFileNamesForExport () {
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APICLICSVobjecttype}" != x"" ] ; then
        export APICLICSVfilename=${APICLICSVobjecttype}
    elif [ x"${APICLIcomplexobjectstype}" != x"" ] ; then
        export APICLICSVfilename=${APICLIcomplexobjectstype}
    else
        export APICLICSVfilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLICSVfilename=${APICLICSVfilename}'_'${APICLIexportnameaddon}
    fi
    export APICLICSVfilename=${APICLICSVfilename}'_'${APICLIdetaillvl}'_csv'${APICLICSVfileexportsuffix}
    export APICLICSVfile=${APICLIpathexport}/${APICLICSVfilename}
    export APICLICSVfilewip=${APICLICSVpathexportwip}/${APICLICSVfilename}
    export APICLICSVfileheader=${APICLICSVfilewip}.${APICLICSVheaderfilesuffix}
    export APICLICSVfiledata=${APICLICSVfilewip}.data
    export APICLICSVfilesort=${APICLICSVfilewip}.sort
    export APICLICSVfiledatalast=${APICLICSVfilewip}.datalast
    export APICLICSVfileoriginal=${APICLICSVfilewip}.original
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVpathexportwip' "${APICLICSVpathexportwip}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportnameaddon' "${APICLIexportnameaddon}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIdetaillvl' "${APICLIdetaillvl}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfileexportsuffix' "${APICLICSVfileexportsuffix}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIpathexport' "${APICLIpathexport}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfilename' "${APICLICSVfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfile' "${APICLICSVfile}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVpathexportwip' "${APICLICSVpathexportwip}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfilewip' "${APICLICSVfilewip}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVheaderfilesuffix' "${APICLICSVheaderfilesuffix}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfileheader' "${APICLICSVfileheader}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfiledata' "${APICLICSVfiledata}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfilesort' "${APICLICSVfilesort}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfiledatalast' "${APICLICSVfiledatalast}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfileoriginal' "${APICLICSVfileoriginal}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureJSONRepoFileNamesAndPaths
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureJSONRepoFileNamesAndPaths sets up the file name and paths to the JSON Repository.
#

ConfigureJSONRepoFileNamesAndPaths () {
    
    echo `${dtzs}`${dtzsep} 'Using the following details level for the JSON Repository = '${JSONRepoDetailname} >> ${logfilepath}
    
    # Configure the JSON Repository File information
    
    # In export operations, we do not utilize the details level of other than "standard" export types, so either "full" or "standard"
    export JSONRepoDetailname=${APICLIdetaillvl}
    case ${APICLIdetaillvl} in
        'full' )
            export JSONRepoDetailname=${APICLIdetaillvl}
            ;;
        'standard' )
            export JSONRepoDetailname=${APICLIdetaillvl}
            ;;
        * )
            export JSONRepoDetailname='full'
            ;;
    esac
    
    if ${NoSystemObjects} ; then
        if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
            # In CSV export operations, we do not utilize the ${APICLIdetaillvl}.NoSystemObjects to ensure we harvest from the repository
            export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
        else
            export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}.NoSystemObjects
        fi
    elif ${OnlySystemObjects} ; then
        if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
            # In CSV export operations, we do not utilize the ${APICLIdetaillvl}.OnlySystemObjects to ensure we harvest from the repository
            export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
        else
            export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}.OnlySystemObjects
        fi
    else
        export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
    fi
    
    export JSONRepofilepost='_'${JSONRepoDetailname}'_'${JSONRepofilesuffix}
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APIobjectjsonrepofileobject}" != x"" ] ; then
        export JSONRepofilename=${APIobjectjsonrepofileobject}
    else
        export JSONRepofilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        # We need to check if we can actually use the ${APICLIexportnameaddon}
        if [ -r "${JSONRepopathworking}/${JSONRepofilepre}${JSONRepofilename}'_'${APICLIexportnameaddon}${JSONRepofilepost}" ] ; then
            # the JSON repository actually contains the file with the ${APICLIexportnameaddon}, so use it
            export JSONRepofilename=${JSONRepofilename}'_'${APICLIexportnameaddon}
        else
            # the JSON repository does not contain the file with the ${APICLIexportnameaddon}, so use the basic value
            export JSONRepofilename=${JSONRepofilename}
        fi
    fi
    
    export JSONRepoFile=${JSONRepopathworking}/${JSONRepofilepre}${JSONRepofilename}${JSONRepofilepost}
    
    export APICLIJSONfilelast=${APICLICSVpathexportwip}/${APICLICSVfilename}'_json_last'${APICLIJSONfileexportsuffix}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjectstype' "${APICLIobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoDetailname' "${JSONRepoDetailname}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepopathbase' "${JSONRepopathbase}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoDetailname' "${JSONRepoDetailname}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepopathworking' "${JSONRepopathworking}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepofilepre' "${JSONRepofilepre}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepofilename' "${JSONRepofilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepofilepost' "${JSONRepofilepost}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepopathworking' "${JSONRepopathworking}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoFile' "${JSONRepoFile}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIJSONfilelast' "${APICLIJSONfilelast}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureComplexObjectJSONRepoFileNamesAndPaths
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureComplexObjectJSONRepoFileNamesAndPaths sets up the file name and paths to the JSON Repository for a  Complex Object.
#

ConfigureComplexObjectJSONRepoFileNamesAndPaths () {
    
    # First configure the default plumbing for a JSON Repository File and Path
    
    ConfigureJSONRepoFileNamesAndPaths
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APIobjectjsonrepofileobject}" != x"" ] ; then
        export JSONRepoComplexObjectfilename=${APIobjectjsonrepofileobject}
    elif [ x"${APICLIcomplexobjectstype}" != x"" ] ; then
        export JSONRepoComplexObjectfilename=${APICLIcomplexobjectstype}
    else
        export JSONRepofilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        # We need to check if we can actually use the ${APICLIexportnameaddon}
        if [ -r "${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoComplexObjectfilename}'_'${APICLIexportnameaddon}${JSONRepofilepost}" ] ; then
            # the JSON repository actually contains the file with the ${APICLIexportnameaddon}, so use it
            export JSONRepoComplexObjectfilename=${JSONRepoComplexObjectfilename}'_'${APICLIexportnameaddon}
        else
            # the JSON repository does not contain the file with the ${APICLIexportnameaddon}, so use the basic value
            export JSONRepoComplexObjectfilename=${JSONRepoComplexObjectfilename}
        fi
    fi
    
    export JSONRepoComplexObjectFile=${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoComplexObjectfilename}${JSONRepofilepost}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjectstype' "${APICLIcomplexobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoComplexObjectfilename' "${JSONRepoComplexObjectfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoComplexObjectFile' "${JSONRepoComplexObjectFile}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureGenericObjectJSONRepoFileNamesAndPaths
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureGenericObjectJSONRepoFileNamesAndPaths sets up the file name and paths to the JSON Repository for a Generic API Object.
#

ConfigureGenericObjectJSONRepoFileNamesAndPaths () {
    
    # First configure the default plumbing for a JSON Repository File and Path
    
    ConfigureJSONRepoFileNamesAndPaths
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APIGenObjjsonrepofileobject}" != x"" ] ; then
        export JSONRepoAPIGenObjectfilename=${APIGenObjjsonrepofileobject}
    elif [ x"${APIGenObjobjectstype}" != x"" ] ; then
        export JSONRepoAPIGenObjectfilename=${APIGenObjobjectstype}
    else
        export JSONRepoAPIGenObjectfilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        # We need to check if we can actually use the ${APICLIexportnameaddon}
        if [ -r "${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoAPIGenObjectfilename}'_'${APICLIexportnameaddon}${JSONRepofilepost}" ] ; then
            # the JSON repository actually contains the file with the ${APICLIexportnameaddon}, so use it
            export JSONRepoAPIGenObjectfilename=${JSONRepoAPIGenObjectfilename}'_'${APICLIexportnameaddon}
        else
            # the JSON repository does not contain the file with the ${APICLIexportnameaddon}, so use the basic value
            export JSONRepoAPIGenObjectfilename=${JSONRepoAPIGenObjectfilename}
        fi
    fi
    
    export JSONRepoAPIGenObjectFile=${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoAPIGenObjectfilename}${JSONRepofilepost}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjjsonrepofileobject' "${APIGenObjjsonrepofileobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenObjectfilename' "${JSONRepoAPIGenObjectfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenObjectFile' "${JSONRepoAPIGenObjectFile}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureGenericComplexObjectJSONRepoFileNamesAndPaths
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureGenericComplexObjectJSONRepoFileNamesAndPaths sets up the file name and paths to the JSON Repository for a Generic API Complex Object.
#

ConfigureGenericComplexObjectJSONRepoFileNamesAndPaths () {
    
    # First configure the default plumbing for a JSON Repository File and Path
    
    ConfigureJSONRepoFileNamesAndPaths
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APIGenObjcomplexjsonrepofileobject}" != x"" ] ; then
        export JSONRepoAPIGenComplexObjectfilename=${APIGenObjcomplexjsonrepofileobject}
    elif [ x"${APIGenObjcomplexobjectstype}" != x"" ] ; then
        export JSONRepoAPIGenComplexObjectfilename=${APIGenObjcomplexobjectstype}
    elif [ x"${APIGenObjobjectstype}" != x"" ] ; then
        export JSONRepoAPIGenComplexObjectfilename=${APIGenObjobjectstype}
    else
        export JSONRepoAPIGenComplexObjectfilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        # We need to check if we can actually use the ${APICLIexportnameaddon}
        if [ -r "${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoAPIGenComplexObjectfilename}'_'${APICLIexportnameaddon}${JSONRepofilepost}" ] ; then
            # the JSON repository actually contains the file with the ${APICLIexportnameaddon}, so use it
            export JSONRepoAPIGenComplexObjectfilename=${JSONRepoAPIGenComplexObjectfilename}'_'${APICLIexportnameaddon}
        else
            # the JSON repository does not contain the file with the ${APICLIexportnameaddon}, so use the basic value
            export JSONRepoAPIGenComplexObjectfilename=${JSONRepoAPIGenComplexObjectfilename}
        fi
    fi
    
    export JSONRepoAPIGenComplexObjectFile=${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoAPIGenComplexObjectfilename}${JSONRepofilepost}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexjsonrepofileobject' "${APIGenObjcomplexjsonrepofileobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjectstype' "${APIGenObjcomplexobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenComplexObjectfilename' "${JSONRepoAPIGenComplexObjectfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenComplexObjectFile' "${JSONRepoAPIGenComplexObjectFile}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureObjectQuerySelector - Configure Object Query Selector value objectqueryselector
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-18:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ConfigureObjectQuerySelector () {
    #
    
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} ' -- ConfigureObjectQuerySelector:' >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'XX' "${XX}" >> ${logfilepath}
    #echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'XX' ' : ' >> ${logfilepath} ; echo ${XX} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure specific object selection query elements
    # -------------------------------------------------------------------------------------------------
    
    # Reference Example for the new objecttype specific criteria from the criteria based exports in the complex objects
    
    #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" == "'"${APICLIexportcriteria01value}"'"'
    # For the Boolean values of ${APICLIexportcriteria01value} we need to check that the text value is true or folse, to be specific
    #if [ "${APICLIexportcriteria01value}" == "true" ] ; then 
        # The value of ${APICLIexportcriteria01value} is boolean true, so check if the value of ${APICLIexportcriteria01key} is true
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'"' 
    #elif [ "${APICLIexportcriteria01value}" == "false" ] ; then 
        # The value of ${APICLIexportcriteria01value} is boolean false, so check if the value of ${APICLIexportcriteria01key} is not true
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" | not'
    #else 
        # The value of ${APICLIexportcriteria01value} is a string, not boolean, so check if the value of ${APICLIexportcriteria01key} is the same
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" == "'"${APICLIexportcriteria01value}"'"'
    #fi
    
    #echo `${dtzs}`${dtzsep} '    - APICLIexportcriteria01value       :  '${APICLIexportcriteria01value} >> ${logfilepath}
    #echo `${dtzs}`${dtzsep} '    - APICLIexportcriteria01value       :  '${APICLIexportcriteria01value} >> ${logfilepath}
    #echo `${dtzs}`${dtzsep} '    - objecttypecriteriaselectorelement :  '${objecttypecriteriaselectorelement} >> ${logfilepath}
    
    # MODIFIED 2022-06-13 -
    
    export objecttypeselectorelement=
    
    if [ x"${APIobjectspecificselector00key}" == x"" ] ; then
        # The value of ${APIobjectspecificselector00key} is empty
        export objecttypeselectorelement=
    elif [ x"${APIobjectspecificselector00value}" == x"" ] ; then
        # The value of ${APIobjectspecificselector00value} is empty
        export objecttypeselectorelement=
    elif [ "${APIobjectspecificselector00value}" == "true" ] ; then 
        # The value of ${APIobjectspecificselector00value} is boolean true, so check if the value of ${APICLIexportcriteria01key} is true
        #export objecttypeselectorelement='."'"${APIobjectspecificselector00key}"'"' 
        export objecttypeselectorelement=${APIobjectspecificselector00key}
    elif [ "${APIobjectspecificselector00value}" == "false" ] ; then 
        # The value of ${APIobjectspecificselector00value} is boolean false, so check if the value of ${APICLIexportcriteria01key} is not true
        #export objecttypeselectorelement='."'"${APIobjectspecificselector00key}"'" | not'
        export objecttypeselectorelement=${APIobjectspecificselector00key}' | not'
    else 
        # The value of ${APIobjectspecificselector00key} is a string, not boolean or empty so we assume ${APIobjectspecificselector00value} is the target value
        if [ x"${APIobjectspecificselector00value}" != x"" ] ; then
            #export objecttypeselectorelement='."'"${APIobjectspecificselector00key}"'" == "'"${APIobjectspecificselector00value}"'"'
            export objecttypeselectorelement=${APIobjectspecificselector00key}' == "'"${APIobjectspecificselector00value}"'"'
        else
            echo `${dtzs}`${dtzsep} ' -- APIobjectspecificselector00key Passed EMPTY!' >> ${logfilepath}
            export objecttypeselectorelement=
        fi
    fi
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'APIobjectspecificselector00key' ${APIobjectspecificselector00key} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'APIobjectspecificselector00value' ${APIobjectspecificselector00value} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'objecttypeselectorelement' ${objecttypeselectorelement} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectspecificselector00key' ' : ' >> ${logfilepath} ; echo ${APIobjectspecificselector00key} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectspecificselector00value' ' : ' >> ${logfilepath} ; echo ${APIobjectspecificselector00value} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'objecttypeselectorelement' ' : ' >> ${logfilepath} ; echo ${objecttypeselectorelement} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure specific query elements for system object selection
    # -------------------------------------------------------------------------------------------------
    
    # Current alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    
    # selector for objects created by customer and not from Check Point
    
    export notsystemobjectselector='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not'
    
    # based on some interesting feedback, adding ability to dump only system objects, not created by customer
    
    export onlysystemobjectselector='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a)'
    
    # also handle the specifics around whether meta-info.creator is or is not "System"
    
    export notcreatorissystemselector='."meta-info"."creator" != "System"'
    
    export creatorissystemselector='."meta-info"."creator" = "System"'
    
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'systemobjectdomains' ${systemobjectdomains} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'notsystemobjectselector' ${notsystemobjectselector} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'onlysystemobjectselector' ${onlysystemobjectselector} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'notcreatorissystemselector' ${notcreatorissystemselector} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'creatorissystemselector' ${creatorissystemselector} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'systemobjectdomains' ' : ' >> ${logfilepath} ; echo ${systemobjectdomains} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'notsystemobjectselector' ' : ' >> ${logfilepath} ; echo ${notsystemobjectselector} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'onlysystemobjectselector' ' : ' >> ${logfilepath} ; echo ${onlysystemobjectselector} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'notcreatorissystemselector' ' : ' >> ${logfilepath} ; echo ${notcreatorissystemselector} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'creatorissystemselector' ' : ' >> ${logfilepath} ; echo ${creatorissystemselector} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    printf "`${dtzs}`${dtzsep}    - %-40s  : %s\n" 'NoSystemObjects' ${NoSystemObjects} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s  : %s\n" 'OnlySystemObjects' ${OnlySystemObjects} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s  : %s\n" 'CreatorIsNotSystem' ${CreatorIsNotSystem} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s  : %s\n" 'CreatorIsSystem' ${CreatorIsSystem} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure Object Query Selector element value systemobjectqueryselectorelement
    # -------------------------------------------------------------------------------------------------
    
    export systemobjectqueryselectorelement=
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        if ${CreatorIsNotSystem} ; then
            # Ignore System Objects and no creator = System
            export systemobjectqueryselectorelement='( '"${notsystemobjectselector}"' ) and ( '"${notcreatorissystemselector}"' )'
        else
            # Ignore System Objects
            export systemobjectqueryselectorelement=${notsystemobjectselector}
        fi
    elif ${OnlySystemObjects} ; then
        # Select only System Objects
        if ${CreatorIsSystem} ; then
            # select only System Objects and creator = System
            export systemobjectqueryselectorelement='( '"${onlysystemobjectselector}"' ) and ( '"${creatorissystemselector}"' )'
        else
            # select only System Objects
            export systemobjectqueryselectorelement=${onlysystemobjectselector}
        fi
    else
        # Include System Objects
        if ${CreatorIsNotSystem} ; then
            # Include System Objects and no creator = System
            export systemobjectqueryselectorelement=${notcreatorissystemselector}
        elif ${CreatorIsSystem} ; then
            # Include System Objects and no creator = System
            export systemobjectqueryselectorelement=${creatorissystemselector}
        else
            # Include System Objects
            export systemobjectqueryselectorelement=
        fi
    fi
    
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'systemobjectqueryselectorelement' ${systemobjectqueryselectorelement} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'systemobjectqueryselectorelement' ' : ' >> ${logfilepath} ; echo ${systemobjectqueryselectorelement} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure Object Query Selector value objectqueryselector
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-06-18 -
    
    export objectqueryselector=
    
    if [ x"${objecttypeselectorelement}" != x"" ] ; then
        # ${objecttypeselectorelement} is not empty, so we have a starting selector
        export objectqueryselector='select( '
        if [ x"${systemobjectqueryselectorelement}" != x"" ] ; then
            # ${objecttypeselectorelement} is not empty, so we have a starting selector
            export objectqueryselector=${objectqueryselector}'( '"${objecttypeselectorelement}"' )'
            export objectqueryselector=${objectqueryselector}' and ( '"${systemobjectqueryselectorelement}"' )'
        else
            export objectqueryselector=${objectqueryselector}"${objecttypeselectorelement}"
        fi
        export objectqueryselector=${objectqueryselector}' )'
    else
        if [ x"${systemobjectqueryselectorelement}" != x"" ] ; then
            # ${objecttypeselectorelement} is not empty, so we have a starting selector
            export objectqueryselector='select( '
            export objectqueryselector=${objectqueryselector}"${systemobjectqueryselectorelement}"
            export objectqueryselector=${objectqueryselector}' )'
        fi
    fi
    
    echo `${dtzs}`${dtzsep} '    Object Query Selector in []s is ['${objectqueryselector}']' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-18:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-03:02\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportObjectsToCSVviaJQ () {
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIobjectstype}'  Number of Objects :  '${number_of_objects} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'X' "${X}" >> ${logfilepath}
    #
    
    ConfigureWorkAPIObjectLimit
    
    # Build the object type specific output file
    
    ConfigureCSVFileNamesForExport
    
    ConfigureJSONRepoFileNamesAndPaths
    
    if [ ! -r ${APICLICSVpathexportwip} ] ; then
        mkdir -p -v ${APICLICSVpathexportwip} >> ${logfilepath} 2>&1
    fi
    
    if [ -r ${APICLICSVfile} ] ; then
        rm ${APICLICSVfile} >> ${logfilepath} 2>&1
    fi
    if [ -r ${APICLICSVfileheader} ] ; then
        rm ${APICLICSVfileheader} >> ${logfilepath} 2>&1
    fi
    if [ -r ${APICLICSVfiledata} ] ; then
        rm ${APICLICSVfiledata} >> ${logfilepath} 2>&1
    fi
    if [ -r ${APICLICSVfilesort} ] ; then
        rm ${APICLICSVfilesort} >> ${logfilepath} 2>&1
    fi
    if [ -r ${APICLICSVfileoriginal} ] ; then
        rm ${APICLICSVfileoriginal} >> ${logfilepath} 2>&1
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Creat '${APICLIobjectstype}' CSV File : '${APICLICSVfile} | tee -a -i ${logfilepath}
    
    #
    # Troubleshooting output
    #
    echo `${dtzs}`${dtzsep} 'CSVFileHeader : ' >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo ${CSVFileHeader} >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    
    echo ${CSVFileHeader} > ${APICLICSVfileheader}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-03:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# The FinalizeExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-11 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeExportObjectsToCSVviaJQ () {
    #
    # The FinalizeExportObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
    #
    
    if [ ! -r "${APICLICSVfileheader}" ] ; then
        # Uh, Oh, something went wrong, no header file
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!! Error header file missing : '${APICLICSVfileheader} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Terminating!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 254
    fi
    
    # Changing this behavior since it's nonsense to quit here because of missing data file, that could be on purpose
    if [ ! -r "${APICLICSVfiledata}" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} '!!!! Error data file missing : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} 'Terminating!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!! data file is missing so no data : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping CSV creation!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #return 253
        return 0
    fi
    
    if [ ! -s "${APICLICSVfiledata}" ] ; then
        # data file is empty, nothing was found
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!! data file is empty : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping CSV creation!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 0
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Sort data and build CSV export file" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfileoriginal}
    cat ${APICLICSVfiledata} >> ${APICLICSVfileoriginal}
    
    sort ${APICLICSVsortparms} ${APICLICSVfiledata} > ${APICLICSVfilesort}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfile}
    cat ${APICLICSVfilesort} >> ${APICLICSVfile}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Done creating '${APICLIobjectstype}' CSV File : "'${APICLICSVfile}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    head ${APICLICSVfile} | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-11


# -------------------------------------------------------------------------------------------------
# StandardExportCSVandJQParameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-09-14:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The StandardExportCSVandJQParameters handles standard configuration of the CSV and JQ export parameters.
#

StandardExportCSVandJQParameters () {
    #
    
    errorreturn=0
    
    # MODIFIED 2022-09-14:01 -
    #
    # The standard output for most CSV is name, color, comments block, by default.  This
    # object data exists for almost all objects, plus the UID.  In the future there may be  more
    # CLI Parameter controls provided to just dump the name, name & UID, or just UID 
    # instead of the full dump of values.  These are useful for things like delete operations
    #
    
    if ${APIobjecttypeimportname} ; then
        # The object type has "name" parameter for export / import
        if [ x"${CSVFileHeader}" != x"" ] ; then
            # CSVFileHeader is NOT blank or empty
            export CSVFileHeader='"name","color","comments",'${CSVFileHeader}
        else
            # CSVFileHeader is blank or empty
            export CSVFileHeader='"name","color","comments"'
        fi
        
        if [ x"${CSVJQparms}" != x"" ] ; then
            # CSVFileHeader is NOT blank or empty
            export CSVJQparms='.["name"], .["color"], .["comments"], '${CSVJQparms}
        else
            # CSVFileHeader is blank or empty
            export CSVJQparms='.["name"], .["color"], .["comments"]'
        fi
    elif ${APIobjecttypehasname} ; then
        # The object type has "name" parameter for export but not used or valid for import
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            # For a reference only output, we can export the name, since it can't import that exported file
            if [ x"${CSVFileHeader}" != x"" ] ; then
                # CSVFileHeader is NOT blank or empty
                export CSVFileHeader='"name","color","comments",'${CSVFileHeader}
            else
                # CSVFileHeader is blank or empty
                export CSVFileHeader='"name","color","comments"'
            fi
            
            if [ x"${CSVJQparms}" != x"" ] ; then
                # CSVFileHeader is NOT blank or empty
                export CSVJQparms='.["name"], .["color"], .["comments"], '${CSVJQparms}
            else
                # CSVFileHeader is blank or empty
                export CSVJQparms='.["name"], .["color"], .["comments"]'
            fi
        else
            if [ x"${CSVFileHeader}" != x"" ] ; then
                # CSVFileHeader is NOT blank or empty
                export CSVFileHeader='"color","comments",'${CSVFileHeader}
            else
                # CSVFileHeader is blank or empty
                export CSVFileHeader='"color","comments"'
            fi
            
            if [ x"${CSVJQparms}" != x"" ] ; then
                # CSVFileHeader is NOT blank or empty
                export CSVJQparms='.["color"], .["comments"], '${CSVJQparms}
            else
                # CSVFileHeader is blank or empty
                export CSVJQparms='.["color"], .["comments"]'
            fi
        fi
    elif ${APIobjecttypehasuid} ; then
        # The object type DOES NOT HAVE "name" parameter for export / import
        if [ x"${CSVFileHeader}" != x"" ] ; then
            # CSVFileHeader is NOT blank or empty, so put that before the color and comments
            export CSVFileHeader=${CSVFileHeader}',"color","comments"'
        else
            # CSVFileHeader is blank or empty
            export CSVFileHeader='"color","comments"'
        fi
        
        if [ x"${CSVJQparms}" != x"" ] ; then
            # CSVFileHeader is NOT blank or empty, so put that before the color and comments
            export CSVJQparms=${CSVJQparms}', .["color"], .["comments"]'
        else
            # CSVFileHeader is blank or empty
            export CSVJQparms='.["color"], .["comments"]'
        fi
    else
        # The object type DOES NOT HAVE "name" or "uid" parameter for export / import
        if [ x"${CSVFileHeader}" != x"" ] ; then
            # CSVFileHeader is NOT blank or empty, so put that in
            export CSVFileHeader=${CSVFileHeader}
        else
            # CSVFileHeader is blank or empty
            export CSVFileHeader=
        fi
        
        if [ x"${CSVJQparms}" != x"" ] ; then
            # CSVFileHeader is NOT blank or empty, so put that in
            export CSVJQparms=${CSVJQparms}
        else
            # CSVFileHeader is blank or empty
            export CSVJQparms=
        fi
    fi
    
    # MODIFIED 2022-09-14:01 -
    # Let's only do this one time for each object and put this at the end of the collected data
    
    if ${APIobjecttypehastags} ; then
        if ${CSVEXPORT05TAGS} ; then
            export CSVFileHeader=${CSVFileHeader}',"tags.0","tags.1","tags.2","tags.3","tags.4"'
            export CSVJQparms=${CSVJQparms}', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"]'
        fi
        
        if ${CSVEXPORT10TAGS} ; then
            export CSVFileHeader=${CSVFileHeader}',"tags.5","tags.6","tags.7","tags.8","tags.9"'
            export CSVJQparms=${CSVJQparms}', .["tags"][5]["name"], .["tags"][6]["name"], .["tags"][7]["name"], .["tags"][8]["name"], .["tags"][9]["name"]'
        fi
    fi
    
    if ${APIobjecttypehasuid} ; then
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            export CSVFileHeader=${CSVFileHeader}',"uid"'
            export CSVJQparms=${CSVJQparms}', .["uid"]'
        fi
    fi
    
    if ${APIobjecttypehasdomain} ; then
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            export CSVFileHeader=${CSVFileHeader}',"domain.name","domain.domain-type"'
            export CSVJQparms=${CSVJQparms}', .["domain"]["name"], .["domain"]["domain-type"]'
        fi
    fi
    
    if ${APIobjecttypehasmeta} ; then
        if ${CLIparm_CSVEXPORTDATACREATOR} ; then
            export CSVFileHeader=${CSVFileHeader}',"meta-info.creator","meta-info.creation-time.iso-8601","meta-info.last-modifier","meta-info.last-modify-time.iso-8601"'
            export CSVJQparms=${CSVJQparms}', .["meta-info"]["creator"], .["meta-info"]["creation-time"]["iso-8601"], .["meta-info"]["last-modifier"], .["meta-info"]["last-modify-time"]["iso-8601"]'
        fi
    fi
    
    # MODIFIED 2022-09-16:01 -
    # Account for whether the original object definition is for REFERENCE, NO IMPORT already
    
    if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${OnlySystemObjects} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    else
        export APICLIexportnameaddon=${APICLIexportnameaddon}
    fi
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-14:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SpecialExportCSVandJQParameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-09-14:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SpecialExportCSVandJQParameters handles Special configuration of the CSV and JQ export parameters.
#

SpecialExportCSVandJQParameters () {
    #
    
    errorreturn=0
    
    # MODIFIED 2022-09-14:01 -
    # Let's only do this one time for each object and put this at the end of the collected data
    
    if ${APIobjecttypehastags} ; then
        if ${CSVEXPORT05TAGS} ; then
            export CSVFileHeader=${CSVFileHeader}',"tags.0","tags.1","tags.2","tags.3","tags.4"'
            export CSVJQparms=${CSVJQparms}', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"]'
        fi
        
        if ${CSVEXPORT10TAGS} ; then
            export CSVFileHeader=${CSVFileHeader}',"tags.5","tags.6","tags.7","tags.8","tags.9"'
            export CSVJQparms=${CSVJQparms}', .["tags"][5]["name"], .["tags"][6]["name"], .["tags"][7]["name"], .["tags"][8]["name"], .["tags"][9]["name"]'
        fi
    fi
    
    if ${APIobjecttypehasuid} ; then
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            case "${TypeOfExport}" in
                # Already include UID
                'name-and-uid' | 'uid-only' )
                    export CSVFileHeader=${CSVFileHeader}
                    export CSVJQparms=${CSVJQparms}
                    ;;
                # Anything else or unknown
                * )
                    export CSVFileHeader=${CSVFileHeader}',"uid"'
                    export CSVJQparms=${CSVJQparms}', .["uid"]'
                    ;;
            esac
        fi
    fi
    
    if ${APIobjecttypehasdomain} ; then
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            export CSVFileHeader=${CSVFileHeader}',"domain.name","domain.domain-type"'
            export CSVJQparms=${CSVJQparms}', .["domain"]["name"], .["domain"]["domain-type"]'
        fi
    fi
    
    if ${APIobjecttypehasmeta} ; then
        if ${CLIparm_CSVEXPORTDATACREATOR} ; then
            export CSVFileHeader=${CSVFileHeader}',"meta-info.creator","meta-info.creation-time.iso-8601","meta-info.last-modifier","meta-info.last-modify-time.iso-8601"'
            export CSVJQparms=${CSVJQparms}', .["meta-info"]["creator"], .["meta-info"]["creation-time"]["iso-8601"], .["meta-info"]["last-modifier"], .["meta-info"]["last-modify-time"]["iso-8601"]'
        fi
    fi
    
    if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    else
        export APICLIexportnameaddon=${APICLIexportnameaddon}
    fi
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureExportCSVandJQParameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-09-15:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureExportCSVandJQParameters handles standard configuration of the CSV and JQ export parameters.
#

ConfigureExportCSVandJQParameters () {
    #
    
    errorreturn=0
    
    # Type of Object Export  :  --type-of-export ["standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"]
    #      For an export for a delete operation via CSV, use "name-only"
    #
    #export TypeOfExport="standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"
    if [ x"${TypeOfExport}" == x"" ] ; then
        # Value not set, so set to default
        export TypeOfExport="standard"
    fi
    
    echo `${dtzs}`${dtzsep} 'Type of export :  '${TypeOfExport}' for objects of type '${APICLIobjecttype} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-09-15:01 -
    #
    # Temporary rollback on check for having the necessary elements for an export.  Looking into solving that before things get here.
    
    if ${APIobjecttypeimportname} ; then
        case "${TypeOfExport}" in
            # a "Standard" export operation
            'standard' )
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon=${APICLIexportnameaddon}
                StandardExportCSVandJQParameters
                ;;
            # a "name-only" export operation
            'name-only' )
                #if ! ${APIobjecttypehasname} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=4
                    #return ${errorreturn}
                #fi
                export CSVFileHeader='"name"'
                export CSVJQparms='.["name"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='name-only'
                export APICLIdetaillvl=name
                SpecialExportCSVandJQParameters
                ;;
            # a "name-and-uid" export operation
            'name-and-uid' )
                #if ! ${APIobjecttypehasname} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=4
                    #return ${errorreturn}
                #fi
                #if ! ${APIobjecttypehasuid} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=5
                    #return ${errorreturn}
                #fi
                export CSVFileHeader='"name","uid"'
                export CSVJQparms='.["name"], .["uid"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='name-and-uid'
                export APICLIdetaillvl=name_and_uid
                SpecialExportCSVandJQParameters
                ;;
            # a "uid-only" export operation
            'uid-only' )
                #if ! ${APIobjecttypehasuid} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=5
                    #return ${errorreturn}
                #fi
                export CSVFileHeader='"uid"'
                export CSVJQparms='.["uid"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='uid-only'
                export APICLIdetaillvl=uid
                SpecialExportCSVandJQParameters
                ;;
            # a "rename-to-new-name" export operation
            'rename-to-new-name' )
                #if ! ${APIobjecttypehasname} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=4
                    #return ${errorreturn}
                #fi
                export CSVFileHeader='"name","new-name"'
                export CSVJQparms='.["name"], .["name"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='rename-to-new-name'
                export APICLIdetaillvl=rename
                # rename-to-new-name is a specific operation and we don't support the other extensions like taks and complete meta information
                #
                #SpecialExportCSVandJQParameters
                ;;
            # a "name-for-delete" export operation
            'name-for-delete' )
                #if ! ${APIobjecttypehasname} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=4
                    #return ${errorreturn}
                #fi
                export CSVFileHeader='"name"'
                export CSVJQparms='.["name"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='name-only'
                export APICLIdetaillvl=name
                #SpecialExportCSVandJQParameters
                ;;
            # Anything unknown is handled as "standard"
            * )
                StandardExportCSVandJQParameters
                ;;
        esac
    else
        case "${TypeOfExport}" in
            # a "Standard" export operation
            'standard' )
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon=${APICLIexportnameaddon}
                StandardExportCSVandJQParameters
                ;;
            # a "name-only" export operation
            'name-only' )
                #if ! ${APIobjecttypehasname} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=4
                    #return ${errorreturn}
                #fi
                #export CSVFileHeader='"name"'
                #export CSVJQparms='.["name"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='name-only'
                export APICLIdetaillvl=name
                SpecialExportCSVandJQParameters
                ;;
            # a "name-and-uid" export operation
            'name-and-uid' )
                #if ! ${APIobjecttypehasname} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=4
                    #return ${errorreturn}
                #fi
                #if ! ${APIobjecttypehasuid} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=5
                    #return ${errorreturn}
                #fi
                #export CSVFileHeader='"name","uid"'
                #export CSVJQparms='.["name"], .["uid"]'
                export CSVFileHeader='"uid"'
                export CSVJQparms='.["uid"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='name-and-uid'
                export APICLIdetaillvl=name_and_uid
                SpecialExportCSVandJQParameters
                ;;
            # a "uid-only" export operation
            'uid-only' )
                #if ! ${APIobjecttypehasuid} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=5
                    #return ${errorreturn}
                #fi
                export CSVFileHeader='"uid"'
                export CSVJQparms='.["uid"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='uid-only'
                export APICLIdetaillvl=uid
                SpecialExportCSVandJQParameters
                ;;
            # a "rename-to-new-name" export operation
            'rename-to-new-name' )
                #if ! ${APIobjecttypehasname} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=4
                    #return ${errorreturn}
                #fi
                #export CSVFileHeader='"name","new-name"'
                #export CSVJQparms='.["name"], .["name"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='rename-to-new-name'
                export APICLIdetaillvl=rename
                # rename-to-new-name is a specific operation and we don't support the other extensions like taks and complete meta information
                #
                #SpecialExportCSVandJQParameters
                ;;
            # a "name-for-delete" export operation
            'name-for-delete' )
                #if ! ${APIobjecttypehasname} ; then
                    ## Required name key value not available in object, erroring out
                    #errorreturn=4
                    #return ${errorreturn}
                #fi
                #export CSVFileHeader='"name"'
                #export CSVJQparms='.["name"]'
                #export APICLIexportnameaddon=
                #export APICLIexportnameaddon='name-only'
                export APICLIdetaillvl=name
                #SpecialExportCSVandJQParameters
                ;;
            # Anything unknown is handled as "standard"
            * )
                StandardExportCSVandJQParameters
                ;;
        esac
    fi
    
    # MODIFIED 2022-06-18 -
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        if ! ${ExportTypeIsName4Delete} ; then 
            if ${APIobjectcansetifexists} ; then
                export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
                export CSVJQparms=${CSVJQparms}', true'
            fi
        fi
    fi
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-15:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DetermineIfDoMgmtCLIQuery
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# DetermineIfDoMgmtCLIQuery executes check if executing export using mgmt_cli command.
#

DetermineIfDoMgmtCLIQuery () {
    #
    # Expected configured key input values
    #
    # ${script_use_json_repo}
    # ${UseJSONRepo}
    # ${objectstoshow}
    # ${APICLIobjectstype}
    # ${JSONRepoObjectsTotal}
    # ${JSONRepoFile}
    #
    # Output values:
    #
    # ${domgmtcliquery}
    # ${errorreturn}
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    export domgmtcliquery=false
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQuery procedure Starting...' | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'objectstoshow' "${objectstoshow}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoObjectsTotal' "${JSONRepoObjectsTotal}" >> ${logfilepath}
    
    if ! ${script_use_json_repo} ; then
        # Script use of JSON Repository is denied
        echo `${dtzs}`${dtzsep} 'Script use of JSON Repository file "'${JSONRepoFile}'" is DENIED by script!' | tee -a -i ${logfilepath}
        export domgmtcliquery=true
    elif ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            CompareObjectsTotalEqual=false
        elif ${OnlySystemObjects} ; then
            CompareObjectsTotalEqual=false
        else
            CompareObjectsTotalEqual=true
        fi
        
        if ${CompareObjectsTotalEqual} ; then
            if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                export domgmtcliquery=false
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'Object count of '${APICLIobjectstype}' objects [ '${objectstoshow}' ] does not match count of [ '${JSONRepoObjectsTotal}' ] in JSON Repository file!' | tee -a -i ${logfilepath}
            fi
        else
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                    # JSON Repository has the same number of objects as the management database
                    export domgmtcliquery=false
                else
                    # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'Object count of '${APICLIobjectstype}' objects [ '${objectstoshow}' ] does not match count of [ '${JSONRepoObjectsTotal}' ] in JSON Repository file!' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
            fi
        fi
    else
        # Use of JSON Repository Disabled
        echo `${dtzs}`${dtzsep} 'Script use of JSON Repository file "'${JSONRepoFile}'" is DENIED by operation!' | tee -a -i ${logfilepath}
        export domgmtcliquery=true
    fi
    
    if ${domgmtcliquery} ; then
        echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation, shift to mgmt_cli query.' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Using JSON Repository for [ '${objectstoshow}' : '${JSONRepoObjectsTotal}' ] of '${APICLIobjectstype}' objects for operation' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' -- In file "'${JSONRepoFile}'"' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQuery result domgmtcliquery [ '${domgmtcliquery}' ], procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DetermineIfDoMgmtCLIQueryComplexObject
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# DetermineIfDoMgmtCLIQueryComplexObject executes check if executing export using mgmt_cli command.
#

DetermineIfDoMgmtCLIQueryComplexObject () {
    #
    # Expected configured key input values
    #
    # ${script_use_json_repo}
    # ${UseJSONRepo}
    # ${objectstoshowcomplexobject}
    # ${APICLIcomplexobjectstype}
    # ${JSONRepoComplexObjectsTotal}
    # ${JSONRepoComplexObjectFile}
    #
    # Output values:
    #
    # ${domgmtcliquerycomplexobject}
    # ${errorreturn}
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    export domgmtcliquerycomplexobject=false
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryComplexObject procedure Starting...' | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'objectstoshowcomplexobject' "${objectstoshowcomplexobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoComplexObjectsTotal' "${JSONRepoComplexObjectsTotal}" >> ${logfilepath}
    
    if ! ${script_use_json_repo} ; then
        # Script use of JSON Repository is denied
        echo `${dtzs}`${dtzsep} 'Script use of Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" is DENIED by script!' | tee -a -i ${logfilepath}
        export domgmtcliquerycomplexobject=true
    elif ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" for operation.' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            CompareObjectsTotalEqual=false
        elif ${OnlySystemObjects} ; then
            CompareObjectsTotalEqual=false
        else
            CompareObjectsTotalEqual=true
        fi
        
        if ${CompareObjectsTotalEqual} ; then
            if [[ ${objectstoshowcomplexobject} -eq ${JSONRepoComplexObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                export domgmtcliquerycomplexobject=false
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerycomplexobject=true
                echo `${dtzs}`${dtzsep} 'Object count of '${APICLIcomplexobjectstype}' objects [ '${objectstoshowcomplexobject}' ] does not match count of [ '${JSONRepoComplexObjectsTotal}' ] in Complex Object JSON Repository file!' | tee -a -i ${logfilepath}
            fi
        else
            if [[ ${JSONRepoComplexObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if [[ ${objectstoshowcomplexobject} -eq ${JSONRepoComplexObjectsTotal} ]] ; then
                    # JSON Repository has the same number of objects as the management database
                    export domgmtcliquerycomplexobject=false
                else
                    # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                    export domgmtcliquerycomplexobject=true
                    echo `${dtzs}`${dtzsep} 'Object count of '${APICLIcomplexobjectstype}' objects [ '${objectstoshowcomplexobject}' ] does not match count of [ '${JSONRepoComplexObjectsTotal}' ] in Complex Object JSON Repository file!' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerycomplexobject=true
            fi
        fi
    else
        # Use of JSON Repository Disabled
        echo `${dtzs}`${dtzsep} 'Script use of Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" is DENIED by operation!' | tee -a -i ${logfilepath}
        export domgmtcliquerycomplexobject=true
    fi
    
    if ${domgmtcliquerycomplexobject} ; then
        echo `${dtzs}`${dtzsep} 'NOT Using Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" for operation, shift to mgmt_cli query.' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Using JSON Repository for [ '${objectstoshowcomplexobject}' : '${JSONRepoComplexObjectsTotal}' ] of '${APICLIcomplexobjectstype}' objects for operation' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' -- In file "'${JSONRepoComplexObjectFile}'"' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryComplexObject result domgmtcliquerycomplexobject [ '${domgmtcliquerycomplexobject}' ], procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DetermineIfDoMgmtCLIQueryGenericObject
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# DetermineIfDoMgmtCLIQueryGenericObject executes check if executing export using mgmt_cli command.
#

DetermineIfDoMgmtCLIQueryGenericObject () {
    #
    # Expected configured key input values
    #
    # ${script_use_json_repo}
    # ${UseJSONRepo}
    # ${objectstoshowgenericobject}
    # ${APIGenObjobjectstype}
    # ${JSONRepoAPIGenObjectsTotal}
    # ${JSONRepoAPIGenObjectFile}
    #
    # Output values:
    #
    # ${domgmtcliquerygenericobject}
    # ${errorreturn}
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    export domgmtcliquerygenericobject=false
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryGenericObject procedure Starting...' | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'objectstoshowgenericobject' "${objectstoshowgenericobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenObjectsTotal' "${JSONRepoAPIGenObjectsTotal}" >> ${logfilepath}
    
    if ! ${script_use_json_repo} ; then
        # Script use of JSON Repository is denied
        echo `${dtzs}`${dtzsep} 'Script use of Generic Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" is DENIED by script!' | tee -a -i ${logfilepath}
        export domgmtcliquerygenericobject=true
    elif ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of Generic Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" for operation.' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            CompareObjectsTotalEqual=false
        elif ${OnlySystemObjects} ; then
            CompareObjectsTotalEqual=false
        else
            CompareObjectsTotalEqual=true
        fi
        
        if ${CompareObjectsTotalEqual} ; then
            if [[ ${objectstoshowgenericobject} -eq ${JSONRepoAPIGenObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                export domgmtcliquerygenericobject=false
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerygenericobject=true
                echo `${dtzs}`${dtzsep} 'Object count of '${APIGenObjobjectstype}' objects [ '${objectstoshowgenericobject}' ] does not match count of [ '${JSONRepoAPIGenObjectsTotal}' ] in Generic Object JSON Repository file!' | tee -a -i ${logfilepath}
            fi
        else
            if [[ ${JSONRepoAPIGenObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if [[ ${objectstoshowgenericobject} -eq ${JSONRepoAPIGenObjectsTotal} ]] ; then
                    # JSON Repository has the same number of objects as the management database
                    export domgmtcliquerygenericobject=false
                else
                    # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                    export domgmtcliquerygenericobject=true
                    echo `${dtzs}`${dtzsep} 'Object count of '${APIGenObjobjectstype}' objects [ '${objectstoshowgenericobject}' ] does not match count of [ '${JSONRepoAPIGenObjectsTotal}' ] in Generic Object JSON Repository file!' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerygenericobject=true
            fi
        fi
    else
        # Use of JSON Repository Disabled
        echo `${dtzs}`${dtzsep} 'Script use of Generic Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" is DENIED by operation!' | tee -a -i ${logfilepath}
        export domgmtcliquerygenericobject=true
    fi
    
    if ${domgmtcliquerygenericobject} ; then
        echo `${dtzs}`${dtzsep} 'NOT Using Generic Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" for operation, shift to mgmt_cli query.' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Using JSON Repository for [ '${objectstoshowgenericobject}' : '${JSONRepoAPIGenObjectsTotal}' ] of '${APIGenObjobjectstype}' objects for operation' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' -- In file "'${JSONRepoAPIGenObjectFile}'"' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryGenericObject result domgmtcliquerygenericobject [ '${domgmtcliquerygenericobject}' ], procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DetermineIfDoMgmtCLIQueryGenericComplexObject
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# DetermineIfDoMgmtCLIQueryGenericComplexObject executes check if executing export using mgmt_cli command.
#

DetermineIfDoMgmtCLIQueryGenericComplexObject () {
    #
    # Expected configured key input values
    #
    # ${script_use_json_repo}
    # ${UseJSONRepo}
    # ${objectstoshowgenericcomplexobject}
    # ${APIGenObjcomplexobjectstype}
    # ${JSONRepoAPIGenComplexObjectsTotal}
    # ${JSONRepoAPIGenComplexObjectFile}
    #
    # Output values:
    #
    # ${domgmtcliquerygenericcomplexobject}
    # ${errorreturn}
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    export domgmtcliquerygenericcomplexobject=false
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryGenericComplexObject procedure Starting...' | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'objectstoshowgenericcomplexobject' "${objectstoshowgenericcomplexobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenComplexObjectsTotal' "${JSONRepoAPIGenComplexObjectsTotal}" >> ${logfilepath}
    
    if ! ${script_use_json_repo} ; then
        # Script use of JSON Repository is denied
        echo `${dtzs}`${dtzsep} 'Script use of Generic Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" is DENIED by script!' | tee -a -i ${logfilepath}
        export domgmtcliquerygenericcomplexobject=true
    elif ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of Generic Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" for operation.' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            CompareObjectsTotalEqual=false
        elif ${OnlySystemObjects} ; then
            CompareObjectsTotalEqual=false
        else
            CompareObjectsTotalEqual=true
        fi
        
        if ${CompareObjectsTotalEqual} ; then
            if [[ ${objectstoshowgenericcomplexobject} -eq ${JSONRepoAPIGenComplexObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                export domgmtcliquerygenericcomplexobject=false
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerygenericcomplexobject=true
                echo `${dtzs}`${dtzsep} 'Object count of '${APIGenObjcomplexobjectstype}' objects [ '${objectstoshowgenericcomplexobject}' ] does not match count of [ '${JSONRepoAPIGenComplexObjectsTotal}' ] in Generic Object JSON Repository file!' | tee -a -i ${logfilepath}
            fi
        else
            if [[ ${JSONRepoAPIGenComplexObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if [[ ${objectstoshowgenericcomplexobject} -eq ${JSONRepoAPIGenComplexObjectsTotal} ]] ; then
                    # JSON Repository has the same number of objects as the management database
                    export domgmtcliquerygenericcomplexobject=false
                else
                    # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                    export domgmtcliquerygenericcomplexobject=true
                    echo `${dtzs}`${dtzsep} 'Object count of '${APIGenObjcomplexobjectstype}' objects [ '${objectstoshowgenericcomplexobject}' ] does not match count of [ '${JSONRepoAPIGenComplexObjectsTotal}' ] in Generic Object JSON Repository file!' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerygenericcomplexobject=true
            fi
        fi
    else
        # Use of JSON Repository Disabled
        echo `${dtzs}`${dtzsep} 'Script use of Generic Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" is DENIED by operation!' | tee -a -i ${logfilepath}
        export domgmtcliquerygenericcomplexobject=true
    fi
    
    if ${domgmtcliquerygenericcomplexobject} ; then
        echo `${dtzs}`${dtzsep} 'NOT Using Generic Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" for operation, shift to mgmt_cli query.' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Using JSON Repository for [ '${objectstoshowgenericcomplexobject}' : '${JSONRepoAPIGenComplexObjectsTotal}' ] of '${APIGenObjcomplexobjectstype}' objects for operation' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' -- In file "'${JSONRepoAPIGenComplexObjectFile}'"' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryGenericComplexObject result domgmtcliquerygenericcomplexobject [ '${domgmtcliquerygenericcomplexobject}' ], procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckJSONRepoFileObjectTotal
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# CheckJSONRepoFileObjectTotal executes a check of the total number of objects for that type using standard object JSON Repository File.
#

CheckJSONRepoFileObjectTotal () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileObjectTotal procedure Starting...' >> ${logfilepath}
    
    if [ -r ${JSONRepoFile} ] ; then
        # JSON Repository File for the target object exists, lets check for the number objects
        
        export JSONRepoObjectsTotal=0
        
        if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
            # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
            export checkJSONRepoTotal=1
        else
            export checkJSONRepoTotal=`cat ${JSONRepoFile} | ${JQ} ".total"`
        fi
        
        export JSONRepoObjectsTotal=${checkJSONRepoTotal}
        echo `${dtzs}`${dtzsep} 'JSONRepoObjectsTotal = [ '${JSONRepoObjectsTotal}' ]' >> ${logfilepath}
        
        if [ x"${JSONRepoObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            export JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoObjectsTotal}' ] (so zero)' | tee -a -i ${logfilepath}
            export JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # JSON Repository File for the target object DOES NOT exists
        echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        export JSONRepoObjectsTotal=0
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepoObjectsTotal = [ '${JSONRepoObjectsTotal}' ]' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileObjectTotal procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckJSONRepoFileComplexObjectTotal
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# CheckJSONRepoFileComplexObjectTotal executes a check of the total number of objects for that type using Complex Object JSON Repository file.
#

CheckJSONRepoFileComplexObjectTotal () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileComplexObjectTotal procedure Starting...' >> ${logfilepath}
    
    if [ -r ${JSONRepoComplexObjectFile} ] ; then
        # Complex Object JSON Repository file for the target object exists, lets check for the number objects
        
        export JSONRepoComplexObjectsTotal=0
        
        if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
            # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
            export checkJSONRepoComplexObjectsTotal=1
        else
            export checkJSONRepoComplexObjectsTotal=`cat ${JSONRepoComplexObjectFile} | ${JQ} ".total"`
        fi
        
        export JSONRepoComplexObjectsTotal=${checkJSONRepoComplexObjectsTotal}
        echo `${dtzs}`${dtzsep} 'JSONRepoComplexObjectsTotal = [ '${JSONRepoComplexObjectsTotal}' ]' >> ${logfilepath}
        
        if [ x"${JSONRepoComplexObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            export JSONRepoComplexObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoComplexObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoComplexObjectsTotal}' ] (so zero)' | tee -a -i ${logfilepath}
            export JSONRepoComplexObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoComplexObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # Complex Object JSON Repository file for the target object DOES NOT exists
        export JSONRepoComplexObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepoComplexObjectsTotal = [ '${JSONRepoComplexObjectsTotal}' ]' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileComplexObjectTotal procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckJSONRepoFileAPIGenericObjectTotal
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# CheckJSONRepoFileAPIGenericObjectTotal executes a check of the total number of objects for that type using API Generic Object JSON Repository file.
#

CheckJSONRepoFileAPIGenericObjectTotal () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileAPIGenericObjectTotal procedure Starting...' >> ${logfilepath}
    
    if [ -r ${JSONRepoAPIGenObjectFile} ] ; then
        # Complex Object JSON Repository file for the target object exists, lets check for the number objects
        
        export JSONRepoAPIGenObjectsTotal=0
        
        if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
            # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
            export checkJSONRepoAPIGenObjectsTotal=1
        else
            export checkJSONRepoAPIGenObjectsTotal=`cat ${JSONRepoAPIGenObjectFile} | ${JQ} ".total"`
        fi
        
        export JSONRepoAPIGenObjectsTotal=${checkJSONRepoAPIGenObjectsTotal}
        echo `${dtzs}`${dtzsep} 'JSONRepoAPIGenObjectsTotal = [ '${JSONRepoAPIGenObjectsTotal}' ]' >> ${logfilepath}
        
        if [ x"${JSONRepoAPIGenObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            export JSONRepoAPIGenObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoAPIGenObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoAPIGenObjectsTotal}' ] (so zero)' | tee -a -i ${logfilepath}
            export JSONRepoAPIGenObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoAPIGenObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # Complex Object JSON Repository file for the target object DOES NOT exists
        export JSONRepoAPIGenObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepoAPIGenObjectsTotal = [ '${JSONRepoAPIGenObjectsTotal}' ]' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileAPIGenericObjectTotal procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckJSONRepoFileAPIGenericComplexObjectTotal
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# CheckJSONRepoFileAPIGenericComplexObjectTotal executes a check of the total number of objects for that type using API Generic Complex Object JSON Repository file.
#

CheckJSONRepoFileAPIGenericComplexObjectTotal () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileAPIGenericComplexObjectTotal procedure Starting...' >> ${logfilepath}
    
    if [ -r ${JSONRepoAPIGenComplexObjectFile} ] ; then
        # Complex Object JSON Repository file for the target object exists, lets check for the number objects
        
        export JSONRepoAPIGenComplexObjectsTotal=0
        
        if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
            # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
            export checkJSONRepoAPIGenComplexObjectsTotal=1
        else
            export checkJSONRepoAPIGenComplexObjectsTotal=`cat ${JSONRepoAPIGenComplexObjectFile} | ${JQ} ".total"`
        fi
        
        export JSONRepoAPIGenComplexObjectsTotal=${checkJSONRepoAPIGenComplexObjectsTotal}
        echo `${dtzs}`${dtzsep} 'JSONRepoAPIGenComplexObjectsTotal = [ '${JSONRepoAPIGenComplexObjectsTotal}' ]' >> ${logfilepath}
        
        if [ x"${JSONRepoAPIGenComplexObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            export JSONRepoAPIGenComplexObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoAPIGenComplexObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoAPIGenComplexObjectsTotal}' ] (so zero)' | tee -a -i ${logfilepath}
            export JSONRepoAPIGenComplexObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoAPIGenComplexObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # Complex Object JSON Repository file for the target object DOES NOT exists
        export JSONRepoAPIGenComplexObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepoAPIGenComplexObjectsTotal = [ '${JSONRepoAPIGenComplexObjectsTotal}' ]' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileAPIGenericComplexObjectTotal procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# MgmtCLIExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# MgmtCLIExportObjectsToCSVviaJQ executes the export of the objects data to CSV using mgmt_cli command.
#

MgmtCLIExportObjectsToCSVviaJQ () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # Execute the mgmt_cli query of the management host database
    
    echo `${dtzs}`${dtzsep} 'Processing [ '${objectstoshow}' ] '${APICLIobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Export '${APICLIobjectstype}' to CSV File' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  and dump to '${APICLICSVfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo ${CSVJQparms} >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo `${dtzs}`${dtzsep} '  Now processing up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        #errorreturn=$?
        
        #if [ x"${objectqueryselector}" == x"" ] ; then
            # object query selector is empty, get it all
            #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            #errorreturn=$?
        #else
            # Use object query selector
            #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${objectqueryselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            #errorreturn=$?
        #fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLICSVfiledatalast} >> ${logfilepath}
        fi
        
        mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLICSVfiledatalast}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'MgmtCLIExportObjectsToCSVviaJQ : Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLICSVfiledatalast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        if [ x"${objectqueryselector}" == x"" ] ; then
            # object query selector is empty, get it all
            cat ${APICLICSVfiledatalast} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
        else
            # Use object query selector
            cat ${APICLICSVfiledatalast} | ${JQ} '.objects[] | '"${objectqueryselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
        fi
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'MgmtCLIExportObjectsToCSVviaJQ : Problem during mgmt_cli JQ Parsing operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents (first 3 and last 10 lines) with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            head -n 3 ${APICLICSVfiledata} | tee -a -i ${logfilepath}
            echo '...' | tee -a -i ${logfilepath}
            tail ${APICLICSVfiledata} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        
        # MODIFIED 2022-03-10 -
        
        CheckAPIKeepAlive
        
    done
    
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'MgmtCLIExportObjectsToCSVviaJQ procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# JSONRepositoryExportObjectsToCSV
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-07-12:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# JSONRepositoryExportObjectsToCSV executes the export of the objects data to CSV using the JSON Repository.
#

JSONRepositoryExportObjectsToCSV () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # Execute the JSON repository query instead
    
    echo `${dtzs}`${dtzsep} 'Processing [ '${objectstoshow}' ] '${APICLIobjecttype}' objects' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' - From the JSON repository file '${JSONRepoFile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Export '${APICLIobjectstype}' to CSV File' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  and dump to '${APICLICSVfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo ${CSVJQparms} >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ x"${objectqueryselector}" == x"" ] ; then
        # object query selector is empty, get it all
        cat ${JSONRepoFile} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
    else
        # Use object query selector
        cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'JSONRepositoryExportObjectsToCSV : Problem during JSON Repository file query operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepositoryExportObjectsToCSV procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-07-12:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-04:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportObjectsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjectstype} item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectsToCSVviaJQ () {
    #
    
    export Workingfilename=
    export APICLIfileexport=
    export APICLIJSONfilelast=
    
    errorreturn=0
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 0
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 0
    fi
    
    if [ x"${CreatorIsNotSystem}" == x"" ] ; then
        # Value not set, so set to default
        export CreatorIsNotSystem=false
    fi
    
    if [ x"${number_of_objects}" == x"" ] ; then
        # There are null objects, so skip
        
        echo `${dtzs}`${dtzsep} 'No objects (null) of type '${APICLIobjecttype}' to process, skipping...' | tee -a -i ${logfilepath}
        
        return 0
       
    elif [[ ${number_of_objects} -lt 1 ]] ; then
        # no objects of this type
        
        echo `${dtzs}`${dtzsep} 'No objects (<1) of type '${APICLIobjecttype}' to process, skipping...' | tee -a -i ${logfilepath}
        
        return 0
       
    else
        # we have objects to handle
        echo `${dtzs}`${dtzsep} 'Processing '${number_of_objects}' '${APICLIobjecttype}' objects...' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    DumpObjectDefinitionData
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-02-01 -
    #
    
    errorreturn=0
    
    ConfigureExportCSVandJQParameters
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem found in procedure ConfigureExportCSVandJQParameters! error returned = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    SetupExportObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem found in procedure SetupExportObjectsToCSVviaJQ! error returned = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-04-22
    
    # This should work, but might need more tweeks if other data types use more values
    #export notsystemobjectselector='select(."domain"."name" | contains ("Check Point Data", "APPI Data", "IPS Data") | not)'
    #export notsystemobjectselector='select(any(."domain"."name"; in("Check Point Data", "APPI Data", "IPS Data")) | not)'
    #export notsystemobjectselector='select((."domain"."name" != "Check Point Data") and (."domain"."name" != "APPI Data") and (."domain"."name" != "IPS Data"))'
    #
    # MODIFIED 2022-04-22 - 
    # Current alternative if more options to exclude are needed
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-07-12:02 -
    
    export WorkingAPICLIdetaillvl='full'
    
    ConfigureMgmtCLIOperationalParametersExport
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-01-05:01 -
    
    if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
        objectstotal=1
    else
        objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    fi
    objectstoshow=${objectstotal}
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    # MODIFIED 2023-03-04:01 -
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    # MODIFIED 2023-03-04:01 -
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        MgmtCLIExportObjectsToCSVviaJQ
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ : Problem during mgmt_cli JQ Parsing operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # Execute the JSON repository query instead
        
        JSONRepositoryExportObjectsToCSV
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ : Problem during JSON Repository file query operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    errorreturn=0
    
    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ : Problem found in procedure FinalizeExportObjectsToCSVviaJQ! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetNumberOfObjectsviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetNumberOfObjectsviaJQ () {
    #
    # The GetNumberOfObjectsviaJQ obtains the number of objects for that object type indicated.
    #
    
    export objectstotal=
    
    #
    # Troubleshooting output
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Get objectstotal of object type '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    CheckAPIKeepAlive
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli objectstotal operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    export number_of_objects=${objectstotal}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckAPIVersionAndExecuteOperation :  Check the API Version running where we're logged in and if good execute operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckAPIVersionAndExecuteOperation () {
    #
    # Check the API Version running where we're logged in and if good execute operation
    #
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    # ADDED 2022-12-08 -
    if ${APIobjectexportisCPI} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' has Critical Performance Impact, APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        if ! ${ExportCritPerfImpactObjects} ; then
            echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
            
            return 0
        else
            echo `${dtzs}`${dtzsep} 'Critical Performance Impact (CPI) Override is active!  ExportCritPerfImpactObjects = '${ExportCritPerfImpactObjects} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does not have Critical Performance Impact(CPI), APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    # MODIFIED 2021-10-25 -
    
    GetAPIVersion=$(mgmt_cli show api-versions -f json -s ${APICLIsessionfile} | ${JQ} '.["current-version"]' -r)
    export CheckAPIVersion=${GetAPIVersion}
    
    if [ ${CheckAPIVersion} = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=${CheckAPIVersion}
    fi
    
    export addversion2keepalive=false
    if [ $(expr ${CurrentAPIVersion} '<=' 1.5) ] ; then
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=true
    else
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=false
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'For Objects Type : '${APICLIobjectstype}' Required minimum API version = ( '${APIobjectminversion}' )' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Logged in management server API version = ( '${CurrentAPIVersion}' ) Check version = ( '${CheckAPIVersion}' )' | tee -a -i ${logfilepath}
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) -eq 1 ] ; then
        # API is sufficient version
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        ExportObjectsToCSVviaJQ
        errorreturn=$?
        
        echo `${dtzs}`${dtzsep} 'CheckAPIVersionAndExecuteOperation call to ExportObjectsToCSVviaJQ procedure returned :  !{ '${errorreturn}' }!' >> ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in ExportObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} ' Contents of file '${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-   --  --  --  --  --  --  --  --  --   --  --  --  --  --  --  --  --  --   -' | tee -a -i ${logfilepath}
            cat ${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-   --  --  --  --  --  --  --  --  --   --  --  --  --  --  --  --  --  --   -' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
    else
        # API is not of a sufficient version to operate on for this object
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Current API Version ( '${CurrentAPIVersion}' ) does not meet minimum API version expected requirement ( '${APIobjectminversion}' )' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! skipping object '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        if ${ABORTONERROR} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIVersionAndExecuteOperation procedure, but continueing' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'CheckAPIVersionAndExecuteOperation procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-15:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END : Main Operational repeated proceedures - Export Objects to CSV
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export scriptactiontext='Export'
#export scriptformattext='JSON'
export scriptformattext='CSV'
export scriptactiondescriptor='Export to CSV'

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Handle Simple Objects
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - simple objects - '${scriptactiondescriptor}' starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  Standard Simple objects
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype='<object_type_singular>'
#export APICLIobjectstype='<object_type_plural>'
#export APIobjectminversion='<object_type_api_version>'
#export APIobjectexportisCPI=false

#export APIobjectspecifickey=

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#export APIobjectjsonrepofileobject=${APICLIobjectstype}
#export APICLICSVobjecttype=${APICLIobjectstype}

#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

#export APIobjectdoexport=true
#export APIobjectdoexportJSON=true
#export APIobjectdoexportCSV=true
#export APIobjectdoimport=true
#export APIobjectdorename=true
#export APIobjectdoupdate=true
#export APIobjectdodelete=true

#export APIobjectusesdetailslevel=true
#export APIobjectcanignorewarning=true
#export APIobjectcanignoreerror=true
#export APIobjectcansetifexists=true
#export APIobjectderefgrpmem=false
#export APIobjecttypehasname=true
#export APIobjecttypehasuid=true
#export APIobjecttypehasdomain=true
#export APIobjecttypehastags=true
#export APIobjecttypehasmeta=true
#export APIobjecttypeimportname=true

#export APIobjectCSVFileHeaderAbsoluteBase=false
#export APIobjectCSVJQparmsAbsoluteBase=false

#export APIobjectCSVexportWIP=false

##
## APICLICSVsortparms can change due to the nature of the object
##
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
##export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
##export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
##export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
##export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
##export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
##export CSVJQparms=${CSVJQparms}', .["icon"]'

#objectstotal_object_type_plural=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
#export number_object_type_plural="${objectstotal_object_type_plural}"
#export number_of_objects=${number_object_type_plural}

#CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Manage & Settings Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Manage & Settings Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Network Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Network Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Servers Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Servers Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Gateways & Clusters Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Gateways & Clusters' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Service & Applications Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Service & Applications' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  application-sites objects
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APIobjectminversion=1.1
export APIobjectexportisCPI=true

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export AugmentExportedFields=false

if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export AugmentExportedFields=true
elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    export AugmentExportedFields=true
elif ${OnlySystemObjects} ; then
    export AugmentExportedFields=true
else
    export AugmentExportedFields=false
fi

if ! ${AugmentExportedFields} ; then
    export APICLIexportnameaddon=
else
    export APICLIexportnameaddon=FOR_REFERENCE_ONLY
fi

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
if ! ${AugmentExportedFields} ; then
    export CSVFileHeader='"primary-category"'
    # The risk key is not imported
    #export CSVFileHeader=${CSVFileHeader}',"risk"'
else
    export CSVFileHeader='"application-id","primary-category"'
    # The risk key is not imported
    export CSVFileHeader=${CSVFileHeader}',"risk"'
fi
export CSVFileHeader=${CSVFileHeader}',"urls-defined-as-regular-expression"'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVFileHeader=${CSVFileHeader}',"user-defined"'
fi
export CSVFileHeader=${CSVFileHeader}',"url-list.0"'
# The next elements are more complex elements, but required for import add operation
if ${AugmentExportedFields} ; then
    export CSVFileHeader=${CSVFileHeader}',"url-list.1"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.2"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.3"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.4"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.5"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.6"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.7"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.8"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.9"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.10"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.11"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.12"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.13"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.14"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.15"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.16"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.17"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.18"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.19"'
fi
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
if ${AugmentExportedFields} ; then
    # The next elements are more complex elements, but NOT required for import add operation
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.1"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.2"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.3"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.4"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.5"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.6"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.7"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.8"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.9"'
fi
export CSVFileHeader=${CSVFileHeader}',"application-signature"'
export CSVFileHeader=${CSVFileHeader}',"description"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
if ! ${AugmentExportedFields} ; then
    export CSVJQparms='.["primary-category"]'
    # The risk key is not imported
    #export CSVJQparms=${CSVJQparms}', .["risk"]'
else
    export CSVJQparms='.["application-id"], .["primary-category"]'
    # The risk key is not imported
    export CSVJQparms=${CSVJQparms}', .["risk"]'
fi
export CSVJQparms=${CSVJQparms}', .["urls-defined-as-regular-expression"]'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVJQparms=${CSVJQparms}', .["user-defined"]'
fi
export CSVJQparms=${CSVJQparms}', .["url-list"][0]'
# The next elements are more complex elements, but required for import add operation
if ${AugmentExportedFields} ; then
    export CSVJQparms=${CSVJQparms}', .["url-list"][1]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][2]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][3]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][4]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][5]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][6]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][7]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][8]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][9]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][10]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][11]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][12]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][13]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][14]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][15]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][16]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][17]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][18]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][19]'
fi
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
if ${AugmentExportedFields} ; then
    # The next elements are more complex elements, but NOT required for import add operation
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][1]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][2]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][3]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][4]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][5]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][6]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][7]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][8]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][9]'
fi
export CSVJQparms=${CSVJQparms}', .["application-signature"]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_application_sites=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_sites="${objectstotal_application_sites}"
export number_of_objects=${number_application_sites}

CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APIobjectminversion=1.1
export APIobjectexportisCPI=true

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=_SINGLE_ALTERNATIVE_

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export AugmentExportedFields=false

if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export AugmentExportedFields=true
elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    export AugmentExportedFields=true
elif ${OnlySystemObjects} ; then
    export AugmentExportedFields=true
else
    export AugmentExportedFields=false
fi

if ! ${AugmentExportedFields} ; then
    export APICLIexportnameaddon=${APICLIexportnameaddon}
else
    export APICLIexportnameaddon=${APICLIexportnameaddon}_REFERENCE
fi

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
if ! ${AugmentExportedFields} ; then
    export CSVFileHeader='"primary-category"'
    # The risk key is not imported
    #export CSVFileHeader=${CSVFileHeader}',"risk"'
else
    export CSVFileHeader='"application-id","primary-category"'
    # The risk key is not imported
    export CSVFileHeader=${CSVFileHeader}',"risk"'
fi
export CSVFileHeader=${CSVFileHeader}',"urls-defined-as-regular-expression"'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVFileHeader=${CSVFileHeader}',"user-defined"'
fi
export CSVFileHeader=${CSVFileHeader}',"url-list.0"'
export CSVFileHeader=${CSVFileHeader}',"url-list.1"'
export CSVFileHeader=${CSVFileHeader}',"url-list.2"'
export CSVFileHeader=${CSVFileHeader}',"url-list.3"'
export CSVFileHeader=${CSVFileHeader}',"url-list.4"'
export CSVFileHeader=${CSVFileHeader}',"url-list.5"'
export CSVFileHeader=${CSVFileHeader}',"url-list.6"'
export CSVFileHeader=${CSVFileHeader}',"url-list.7"'
export CSVFileHeader=${CSVFileHeader}',"url-list.8"'
export CSVFileHeader=${CSVFileHeader}',"url-list.9"'
export CSVFileHeader=${CSVFileHeader}',"url-list.10"'
export CSVFileHeader=${CSVFileHeader}',"url-list.11"'
export CSVFileHeader=${CSVFileHeader}',"url-list.12"'
export CSVFileHeader=${CSVFileHeader}',"url-list.13"'
export CSVFileHeader=${CSVFileHeader}',"url-list.14"'
export CSVFileHeader=${CSVFileHeader}',"url-list.15"'
export CSVFileHeader=${CSVFileHeader}',"url-list.16"'
export CSVFileHeader=${CSVFileHeader}',"url-list.17"'
export CSVFileHeader=${CSVFileHeader}',"url-list.18"'
export CSVFileHeader=${CSVFileHeader}',"url-list.19"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.1"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.2"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.3"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.4"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.5"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.6"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.7"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.8"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.9"'
export CSVFileHeader=${CSVFileHeader}',"application-signature"'
export CSVFileHeader=${CSVFileHeader}',"description"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
if ! ${AugmentExportedFields} ; then
    export CSVJQparms='.["primary-category"]'
    # The risk key is not imported
    #export CSVJQparms=${CSVJQparms}', .["risk"]'
else
    export CSVJQparms='.["application-id"], .["primary-category"]'
    # The risk key is not imported
    export CSVJQparms=${CSVJQparms}', .["risk"]'
fi
export CSVJQparms=${CSVJQparms}', .["urls-defined-as-regular-expression"]'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVJQparms=${CSVJQparms}', .["user-defined"]'
fi
export CSVJQparms=${CSVJQparms}', .["url-list"][0]'
export CSVJQparms=${CSVJQparms}', .["url-list"][1]'
export CSVJQparms=${CSVJQparms}', .["url-list"][2]'
export CSVJQparms=${CSVJQparms}', .["url-list"][3]'
export CSVJQparms=${CSVJQparms}', .["url-list"][4]'
export CSVJQparms=${CSVJQparms}', .["url-list"][5]'
export CSVJQparms=${CSVJQparms}', .["url-list"][6]'
export CSVJQparms=${CSVJQparms}', .["url-list"][7]'
export CSVJQparms=${CSVJQparms}', .["url-list"][8]'
export CSVJQparms=${CSVJQparms}', .["url-list"][9]'
export CSVJQparms=${CSVJQparms}', .["url-list"][10]'
export CSVJQparms=${CSVJQparms}', .["url-list"][11]'
export CSVJQparms=${CSVJQparms}', .["url-list"][12]'
export CSVJQparms=${CSVJQparms}', .["url-list"][13]'
export CSVJQparms=${CSVJQparms}', .["url-list"][14]'
export CSVJQparms=${CSVJQparms}', .["url-list"][15]'
export CSVJQparms=${CSVJQparms}', .["url-list"][16]'
export CSVJQparms=${CSVJQparms}', .["url-list"][17]'
export CSVJQparms=${CSVJQparms}', .["url-list"][18]'
export CSVJQparms=${CSVJQparms}', .["url-list"][19]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][1]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][2]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][3]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][4]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][5]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][6]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][7]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][8]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][9]'
export CSVJQparms=${CSVJQparms}', .["application-signature"]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        CheckAPIVersionAndExecuteOperation
        ;;
    # a "name-only" export operation
    #'name-only' )
    # a "name-and-uid" export operation
    #'name-and-uid' )
    # a "uid-only" export operation
    #'uid-only' )
    # a "rename-to-new-nam" export operation
    #'rename-to-new-name' )
    # Anything unknown is handled as "standard"
    * )
        echo `${dtzs}`${dtzsep} 'Skipping '${APICLIobjecttype}' '${APICLIexportnameaddon}' for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        ;;
esac

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-08:01


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Users Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Users' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Updatable Object Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Updatable Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Script Type Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script Type Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  SmartTasks
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=smart-task
export APICLIobjectstype=smart-tasks
export APIobjectminversion=1.6
export APIobjectexportisCPI=false

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"enabled","fail-open"'
export CSVFileHeader=${CSVFileHeader}'"action.send-web-request.url"'
export CSVFileHeader=${CSVFileHeader}',"action.send-web-request.fingerprint"'
export CSVFileHeader=${CSVFileHeader}',"action.send-web-request.override-proxy"'
export CSVFileHeader=${CSVFileHeader}',"action.send-web-request.proxy-url"'
export CSVFileHeader=${CSVFileHeader}',"action.send-web-request.shared-secret"'
export CSVFileHeader=${CSVFileHeader}',"action.send-web-request.time-out"'
export CSVFileHeader=${CSVFileHeader}',"action.run-script.repository-script"'
export CSVFileHeader=${CSVFileHeader}',"action.run-script.time-out"'
export CSVFileHeader=${CSVFileHeader}',"action.run-script.targets.0"'
export CSVFileHeader=${CSVFileHeader}',"action.run-script.targets.1"'
export CSVFileHeader=${CSVFileHeader}',"action.run-script.targets.2"'
export CSVFileHeader=${CSVFileHeader}',"action.run-script.targets.3"'
export CSVFileHeader=${CSVFileHeader}',"action.run-script.targets.4"'
export CSVFileHeader=${CSVFileHeader}',"action.send-mail.mail-settings.recipients"'
export CSVFileHeader=${CSVFileHeader}',"action.send-mail.mail-settings.sender-email"'
export CSVFileHeader=${CSVFileHeader}',"action.send-mail.mail-settings.subject"'
export CSVFileHeader=${CSVFileHeader}',"action.send-mail.mail-settings.body"'
export CSVFileHeader=${CSVFileHeader}',"action.send-mail.mail-settings.attachment"'
export CSVFileHeader=${CSVFileHeader}',"action.send-mail.mail-settings.bcc-recipients"'
export CSVFileHeader=${CSVFileHeader}',"action.send-mail.mail-settings.cc-recipients"'
export CSVFileHeader=${CSVFileHeader}',"action.send-mail.smtp-server"'
export CSVFileHeader=${CSVFileHeader}',"trigger"'
export CSVFileHeader=${CSVFileHeader}',"custom-data"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["enabled"], .["fail-open"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-web-request"]["url"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-web-request"]["fingerprint"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-web-request"]["override-proxy"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-web-request"]["proxy-url"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-web-request"]["shared-secret"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-web-request"]["time-out"]'
export CSVJQparms=${CSVJQparms}', .["action"]["run-script"]["repository-script"]["name"]'
export CSVJQparms=${CSVJQparms}', .["action"]["run-script"]["time-out"]'
export CSVJQparms=${CSVJQparms}', .["action"]["run-script"]["targets"][0]["name"]'
export CSVJQparms=${CSVJQparms}', .["action"]["run-script"]["targets"][1]["name"]'
export CSVJQparms=${CSVJQparms}', .["action"]["run-script"]["targets"][2]["name"]'
export CSVJQparms=${CSVJQparms}', .["action"]["run-script"]["targets"][3]["name"]'
export CSVJQparms=${CSVJQparms}', .["action"]["run-script"]["targets"][4]["name"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-mail"]["mail-settings"]["recipients"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-mail"]["mail-settings"]["sender-email"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-mail"]["mail-settings"]["subject"]'
# The body presents a problem because it will contain escaped characters that wreck the CSV output, so convert that to JSON
# There may be a better way, but that is yet to be found
#export CSVJQparms=${CSVJQparms}', .["action"]["send-mail"]["mail-settings"]["body"]'
export CSVJQparms=${CSVJQparms}', ( .["action"]["send-mail"]["mail-settings"]["body"] | tojson )'
export CSVJQparms=${CSVJQparms}', .["action"]["send-mail"]["mail-settings"]["attachment"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-mail"]["mail-settings"]["bcc-recipients"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-mail"]["mail-settings"]["cc-recipients"]'
export CSVJQparms=${CSVJQparms}', .["action"]["send-mail"]["smtp-server"]["name"]'
export CSVJQparms=${CSVJQparms}', .["trigger"]["name"]'
export CSVJQparms=${CSVJQparms}', .["custom-data"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_object_type_plural=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_object_type_plural="${objectstotal_object_type_plural}"
export number_of_objects=${number_object_type_plural}

CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  Repository Scripts
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=repository-script
export APICLIobjectstype=repository-scripts
export APIobjectminversion=1.9
export APIobjectexportisCPI=false

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"script-body-base64"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["script-body"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_repository_scripts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_repository_scripts="${objectstotal_repository_scripts}"
export number_of_objects=${number_repository_scripts}

CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Compliance Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Compliance Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Data Center Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Data Center Objectsö' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# ADDED 2023-01-30 -

# +-------------------------------------------------------------------------------------------------
# | Simple Object :  Data Center Servers
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=data-center-server
export APICLIobjectstype=data-center-servers
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

case "${CurrentAPIVersion}" in
    1.1 | 1.2 | 1.3 | 1.4 | 1.5 )
        export APICLIobjecttype=data-center
        export APICLIobjectstype=data-centers
        
        export APIobjectdoexport=true
        export APIobjectdoexportJSON=true
        export APIobjectdoexportCSV=false
        export APIobjectdoimport=false
        export APIobjectdorename=false
        export APIobjectdoupdate=false
        export APIobjectdodelete=false
        
        export APICLIexportnameaddon=REFERENCE_NO_IMPORT
        
        CheckAPIVersionAndExecuteOperation
        ;;
    1 | 1.0 )
        export APICLIobjecttype=data-center
        export APICLIobjectstype=data-centers
        
        export APIobjectdoexport=false
        export APIobjectdoexportJSON=false
        export APIobjectdoexportCSV=false
        export APIobjectdoimport=false
        export APIobjectdorename=false
        export APIobjectdoupdate=false
        export APIobjectdodelete=false
        
        export APICLIexportnameaddon=REFERENCE_NO_IMPORT
        
        #CheckAPIVersionAndExecuteOperation
        ;;
    # Anything unknown is recorded for later
    * )
        export APICLIobjecttype=data-center-server
        export APICLIobjectstype=data-center-servers
        
        export APIobjectdoexport=true
        export APIobjectdoexportJSON=true
        export APIobjectdoexportCSV=true
        export APIobjectdoimport=true
        export APIobjectdorename=true
        export APIobjectdoupdate=true
        export APIobjectdodelete=true
        
        export APICLIexportnameaddon=
        
        CheckAPIVersionAndExecuteOperation
        ;;
esac


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  Data Center Object
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=data-center-object
export APICLIobjectstype=data-center-objects
export APIobjectminversion=1.4
export APIobjectexportisCPI=false

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=false
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  Data Center Query Object
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=data-center-query
export APICLIobjectstype=data-center-queries
export APIobjectminversion=1.7
export APIobjectexportisCPI=false

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=false
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Azure Active Directory Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Azure Active Directory Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# VPN Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'VPN Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# HTTPS Inspection Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'HTTPS Inspection Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Multi-Domain Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Multi-Domain Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Provisioning LSM Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Provisioining LSM Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# No more Simple Objects
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - simple objects - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Handle Special Objects and Properties
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


# ADDED 2022-07-07 -

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

# MODIFIED 2022-07-07 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Special objects and properties - '${scriptactiondescriptor}' Starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-07-07


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Main Operational repeated proceedures - Export Special Singular Objects to CSV
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-10-28:01 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# SpecialObjectStandardExportCSVandJQParameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-10-28:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SpecialObjectStandardExportCSVandJQParameters handles Special Objects standard configuration of the CSV and JQ export parameters.
#

SpecialObjectStandardExportCSVandJQParameters () {
    #
    
    errorreturn=0
    
    # MODIFIED 2022-09-14 -
    #
    # The standard output for most CSV is name, color, comments block, by default.  This
    # object data exists for almost all objects, plus the UID.  In the future there may be  more
    # CLI Parameter controls provided to just dump the name, name & UID, or just UID 
    # instead of the full dump of values.  These are useful for things like delete operations
    #
    
    # MODIFIED 2022-09-14 -
    # Let's only do this one time for each object and put this at the end of the collected data
    
    if ${APIobjecttypehastags} ; then
        if ${CSVEXPORT05TAGS} ; then
            export CSVFileHeader=${CSVFileHeader}',"tags.0","tags.1","tags.2","tags.3","tags.4"'
            export CSVJQparms=${CSVJQparms}', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"]'
        fi
        
        if ${CSVEXPORT10TAGS} ; then
            export CSVFileHeader=${CSVFileHeader}',"tags.5","tags.6","tags.7","tags.8","tags.9"'
            export CSVJQparms=${CSVJQparms}', .["tags"][5]["name"], .["tags"][6]["name"], .["tags"][7]["name"], .["tags"][8]["name"], .["tags"][9]["name"]'
        fi
    fi
    
    if ${APIobjecttypehasuid} ; then
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            export CSVFileHeader=${CSVFileHeader}',"uid"'
            export CSVJQparms=${CSVJQparms}', .["uid"]'
        fi
    fi
    
    if ${APIobjecttypehasdomain} ; then
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            export CSVFileHeader=${CSVFileHeader}',"domain.name","domain.domain-type"'
            export CSVJQparms=${CSVJQparms}', .["domain"]["name"], .["domain"]["domain-type"]'
        fi
    fi
    
    if ${APIobjecttypehasmeta} ; then
        if ${CLIparm_CSVEXPORTDATACREATOR} ; then
            export CSVFileHeader=${CSVFileHeader}',"meta-info.creator","meta-info.creation-time.iso-8601","meta-info.last-modifier","meta-info.last-modify-time.iso-8601"'
            export CSVJQparms=${CSVJQparms}', .["meta-info"]["creator"], .["meta-info"]["creation-time"]["iso-8601"], .["meta-info"]["last-modifier"], .["meta-info"]["last-modify-time"]["iso-8601"]'
        fi
    fi
    
    # MODIFIED 2022-09-16:01 -
    # Account for whether the original object definition is for REFERENCE, NO IMPORT already
    
    if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${OnlySystemObjects} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    else
        export APICLIexportnameaddon=${APICLIexportnameaddon}
    fi
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-10-28:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureSpecialObjectCSVandJQParameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-10-28:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureSpecialObjectCSVandJQParameters handles Special Object configuration of the CSV and JQ export parameters.
#

ConfigureSpecialObjectCSVandJQParameters () {
    #
    
    errorreturn=0
    
    # Type of Object Export  :  --type-of-export ["standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"]
    #      For an export for a delete operation via CSV, use "name-only"
    #
    #export TypeOfExport="standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"
    if [ x"${TypeOfExport}" == x"" ] ; then
        # Value not set, so set to default
        export TypeOfExport="standard"
    fi
    
    echo `${dtzs}`${dtzsep} 'Type of export :  '${TypeOfExport}' for objects of type '${APICLIobjecttype} | tee -a -i ${logfilepath}
    
    SpecialObjectStandardExportCSVandJQParameters
    
    # MODIFIED 2022-06-18 -
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        if ! ${ExportTypeIsName4Delete} ; then 
            if ${APIobjectcansetifexists} ; then
                export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
                export CSVJQparms=${CSVJQparms}', true'
            fi
        fi
    fi
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-10-28:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# MgmtCLIExportSpecialObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-10-28:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# MgmtCLIExportSpecialObjectsToCSVviaJQ executes the export of the objects data to CSV using mgmt_cli command.
#

MgmtCLIExportSpecialObjectsToCSVviaJQ () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # Execute the mgmt_cli query of the management host database
    
    echo `${dtzs}`${dtzsep} 'Processing [ '${objectstoshow}' ] '${APICLIobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Export '${APICLIobjectstype}' to CSV File' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  and dump to '${APICLICSVfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo ${CSVJQparms} >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo `${dtzs}`${dtzsep} '  Now processing up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        #errorreturn=$?
        
        #if [ x"${objectqueryselector}" == x"" ] ; then
            # object query selector is empty, get it all
            #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            #errorreturn=$?
        #else
            # Use object query selector
            #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${objectqueryselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            #errorreturn=$?
        #fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLICSVfiledatalast} >> ${logfilepath}
        fi
        
        mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLICSVfiledatalast}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'MgmtCLIExportSpecialObjectsToCSVviaJQ : Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLICSVfiledatalast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        if [ x"${objectqueryselector}" == x"" ] ; then
            # object query selector is empty, get it all
            cat ${APICLICSVfiledatalast} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
        else
            # Use object query selector
            cat ${APICLICSVfiledatalast} | ${JQ} '.objects[] | '"${objectqueryselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
        fi
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'MgmtCLIExportSpecialObjectsToCSVviaJQ : Problem during mgmt_cli JQ Parsing operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents (first 3 and last 10 lines) with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            head -n 3 ${APICLICSVfiledata} | tee -a -i ${logfilepath}
            echo '...' | tee -a -i ${logfilepath}
            tail ${APICLICSVfiledata} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        
        # MODIFIED 2022-03-10 -
        
        CheckAPIKeepAlive
        
    done
    
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'MgmtCLIExportSpecialObjectsToCSVviaJQ procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-10-28:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# JSONRepositoryExportSpecialObjectsToCSV
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-10-28:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# JSONRepositoryExportSpecialObjectsToCSV executes the export of the objects data to CSV using the JSON Repository.
#

JSONRepositoryExportSpecialObjectsToCSV () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # Execute the JSON repository query instead
    
    echo `${dtzs}`${dtzsep} 'Processing [ '${objectstoshow}' ] '${APICLIobjecttype}' objects' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' - From the JSON repository file '${JSONRepoFile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Export '${APICLIobjectstype}' to CSV File' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  and dump to '${APICLICSVfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo ${CSVJQparms} >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ x"${objectqueryselector}" == x"" ] ; then
        # object query selector is empty, get it all
        cat ${JSONRepoFile} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
    else
        # Use object query selector
        cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'JSONRepositoryExportSpecialObjectsToCSV : Problem during JSON Repository file query operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  File contents (first 3 and last 10 lines) with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
        echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo >> ${logfilepath}
        
        head -n 3 ${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo '...' | tee -a -i ${logfilepath}
        tail ${APICLICSVfiledata} | tee -a -i ${logfilepath}
        
        echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepositoryExportSpecialObjectsToCSV procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-10-28:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - ExportSpecialObjectToCSVWithoutLimitsAndDetailLevel
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-01-06:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Export Special Objects or Properties without utilization of limits and details-level
#

ExportSpecialObjectToCSVWithoutLimitsAndDetailLevel () {
    #
    # Export Objects to CSV from RAW JSON, either existing or mgmt_cli queried
    #
    # This object does not have limits to check and probably does not have more than one object entry
    echo `${dtzs}`${dtzsep} '  Now processing '${APICLIobjecttype}' special object/properties to CSV!' | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} >> ${logfilepath}
    fi
    
    errorreturn=0
    
    # MODIFIED 2022-10-28:01 -
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    # MODIFIED 2022-10-28:01 -
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    errorreturn=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APICLIobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Export '${APICLIobjectstype}' to CSV File' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  and dump CSV to:  "'${APICLICSVfile}'"' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  using JSON file:  "'${APICLIJSONfilelast}'"' | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
            echo ${CSVJQparms} >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
        else
            # Verbose mode OFF
            echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
            echo ${CSVJQparms} >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
        fi
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' '${MgmtCLI_Show_OpParms}' \> "'${APICLIJSONfilelast}'"' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' '${MgmtCLI_Show_OpParms}' \> "'${APICLIJSONfilelast}'"' >> ${logfilepath}
        fi
        
        mgmt_cli show ${APICLIobjectstype} ${MgmtCLI_Show_OpParms} > ${APICLIJSONfilelast}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToCSVWithoutLimitsAndDetailLevel : Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLIJSONfilelast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLIJSONfilelast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # Execute the JSON repository query instead
        
        echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APICLIobjecttype}' objects from the JSON repository file '${JSONRepoFile} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Export '${APICLIobjectstype}' to CSV File' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  and dump CSV to:  '${APICLICSVfile}'"' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  using JSON file:  '${APICLIJSONfilelast}'"' | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
            echo ${CSVJQparms} >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
        else
            # Verbose mode OFF
            echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
            echo ${CSVJQparms} >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
        fi
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        cp ${JSONRepoFile} ${APICLIJSONfilelast} >> ${logfilepath}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToCSVWithoutLimitsAndDetailLevel : Problem during JSON Repo copy operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLIJSONfilelast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLIJSONfilelast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    # MODIFIED 2023-01-05:02 -
    
    #
    # Generate an objects[array] from a non-array json file to simplify the CSV generation process, like all the rest
    #
    
    export APICLIJSONfileworking=${APICLIJSONfilelast}'.objects.json'
    
    echo '{ "objects": [ ' > ${APICLIJSONfileworking}
    cat ${APICLIJSONfilelast} >> ${APICLIJSONfileworking}
    echo ' ] } ' >> ${APICLIJSONfileworking}
    
    echo `${dtzs}`${dtzsep} 'Use JQ on file "'${APICLIJSONfileworking}'"' | tee -a -i ${logfilepath}
    
    cat ${APICLIJSONfileworking} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToCSVWithoutLimitsAndDetailLevel : Problem during JSON query operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  File contents with potential error from "'${APICLIJSONfileworking}'" : ' >> ${logfilepath}
        echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo >> ${logfilepath}
        
        cat ${APICLIJSONfileworking} | tee -a -i ${logfilepath}
        
        echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Output file with potential error "'${APICLICSVfiledata}'" : ' >> ${logfilepath}
        echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo >> ${logfilepath}
        
        cat ${APICLICSVfiledata} | tee -a -i ${logfilepath}
        
        echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToCSVWithoutLimitsAndDetailLevel procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-01-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - ExportSpecialObjectToCSVStandard
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-01-05:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Export Special Objects or Properties with utilization of limits and details-level as a standard
#

ExportSpecialObjectToCSVStandard () {
    #
    # Export Objects to CSV from RAW JSON, either existing or mgmt_cli queried
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToCSVStandard:  '${APICLIobjecttype} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-10-28:01 -
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    # MODIFIED 2022-10-28:01 -
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        MgmtCLIExportSpecialObjectsToCSVviaJQ
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToCSVStandard : Problem during MgmtCLIExportSpecialObjectsToCSVviaJQ operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # Execute the JSON repository query instead
        
        JSONRepositoryExportSpecialObjectsToCSV
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToCSVStandard : Problem during JSONRepositoryExportSpecialObjectsToCSV operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToCSVStandard procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-01-05:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - SpecialExportRAWObjectToCSV
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjecttype} details is exported to a CSV.

SpecialExportRAWObjectToCSV () {
    #
    # Export Objects to raw JSON
    #
    
    export Workingfilename=
    export APICLIfileexport=
    export APICLIJSONfilelast=
    
    errorreturn=0
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIobjectstype}'  Number of Objects :  '${number_of_objects} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToCSV procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        return 0
    fi
    
    if [ "${APICLIdetaillvl}" == "standard" ] ; then
        # Need to check if we have object type selector values, since that won't work with details-level standard!
        if [ x"${APIobjectspecificselector00key}" != x"" ] ; then
            # OK, need to skip this because we can't process this with detials-level "standard"
            echo `${dtzs}`${dtzsep} 'Object type :  '${APICLIobjectstype}' has defined object type selectors set, but details-level is "'${APICLIdetaillvl}'", so skipping to avoid fail!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToCSV procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    if [ x"${CreatorIsNotSystem}" == x"" ] ; then
        # Value not set, so set to default
        export CreatorIsNotSystem=false
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'Start Processing '${APICLIobjecttype}':' | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    DumpObjectDefinitionData
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-02-01 -
    #
    
    errorreturn=0
    
    ConfigureSpecialObjectCSVandJQParameters
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem found in procedure ConfigureSpecialObjectCSVandJQParameters! error returned = '${errorreturn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToCSV procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    SetupExportObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem found in procedure SetupExportObjectsToCSVviaJQ! error returned = '${errorreturn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToCSV procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    # Configure object selection query selector
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-09-14 - 
    # Current alternative if more options to exclude are needed, now there is a procedure for that
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    # Configure basic parameters
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-10-28:01 -
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    ConfigureMgmtCLIOperationalParametersExport
    
    # MODIFIED 2023-03-03:03 -
    
    if [ x"${APICLICSVobjecttype}" != x"" ] ; then
        export APICLIfilename=${APICLICSVobjecttype}
    else
        export APICLIfilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
    fi
    
    if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        export objectstotal=1
    else
        # This object has limits to check, so handle as such
        export objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    fi
    
    export objectstoshow=${objectstotal}
    
    # -------------------------------------------------------------------------------------------------
    
    export Workingfilename=${APICLIfilename}
    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
    export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}'_last'${APICLIJSONfileexportpost}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'Workingfilename' "${Workingfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIfileexport' "${APICLIfileexport}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIJSONfilelast' "${APICLIJSONfilelast}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    errorreturn=0
    
    if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        
        ExportSpecialObjectToCSVWithoutLimitsAndDetailLevel
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToCSV : Problem found in procedure ExportSpecialObjectToCSVWithoutLimitsAndDetailLevel! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # This object has limits to check and probably has more than one object entry
        
        ExportSpecialObjectToCSVStandard
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToCSV : Problem found in procedure ExportSpecialObjectToCSVStandard! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    fi
    
    errorreturn=0
    
    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToCSV : Problem found in procedure FinalizeExportObjectsToCSVviaJQ! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToCSV procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-03-04:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SpecialObjectsCheckAPIVersionAndExecuteOperation :  Check the API Version running where we're logged in and if good execute operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-10-28:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SpecialObjectsCheckAPIVersionAndExecuteOperation () {
    #
    
    export errorreturn=0
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    # ADDED 2022-12-08 -
    if ${APIobjectexportisCPI} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' has Critical Performance Impact, APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        if ! ${ExportCritPerfImpactObjects} ; then
            echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
            
            return 0
        else
            echo `${dtzs}`${dtzsep} 'Critical Performance Impact (CPI) Override is active!  ExportCritPerfImpactObjects = '${ExportCritPerfImpactObjects} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does not have Critical Performance Impact(CPI), APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    GetAPIVersion=$(mgmt_cli show api-versions -f json -s ${APICLIsessionfile} | ${JQ} '.["current-version"]' -r)
    export CheckAPIVersion=${GetAPIVersion}
    
    if [ ${CheckAPIVersion} = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=${CheckAPIVersion}
    fi
    
    export addversion2keepalive=false
    if [ $(expr ${CurrentAPIVersion} '<=' 1.5) ] ; then
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=true
    else
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=false
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'For Objects Type : '${APICLIobjectstype}' Required minimum API version = ( '${APIobjectminversion}' )' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Logged in management server API version = ( '${CurrentAPIVersion}' ) Check version = ( '${CheckAPIVersion}' )' | tee -a -i ${logfilepath}
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) -eq 1 ] ; then
        # API is sufficient version
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        SpecialExportRAWObjectToCSV
        errorreturn=$?
        
        echo `${dtzs}`${dtzsep} 'SpecialObjectsCheckAPIVersionAndExecuteOperation call to SpecialExportRAWObjectToCSV procedure returned :  !{ '${errorreturn}' }!' >> ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
    else
        # API is not of a sufficient version to operate on for this object
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Current API Version ( '${CurrentAPIVersion}' ) does not meet minimum API version expected requirement ( '${APIobjectminversion}' )' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! skipping object '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        if ${ABORTONERROR} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure, but continueing' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'SpecialObjectsCheckAPIVersionAndExecuteOperation procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-12:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END : Main Operational repeated proceedures - Export Special Singular Objects to CSV
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Special Object : Special Singular Objects - export object
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype='<object_type_singular>'
#export APICLIobjectstype='<object_type_plural>'
#export APIobjectminversion='<object_type_api_version>'
#export APIobjectexportisCPI=false|true
#export APIobjectjsonrepofileobject=${APICLIobjectstype}
#export APICLICSVobjecttype=${APICLIobjectstype}
#export APIobjectrecommendedlimit=0
#export APIobjectrecommendedlimitMDSM=0

#export APIobjectdoexport=true|false
#export APIobjectdoexportJSON=true|false
#export APIobjectdoexportCSV=true|false
#export APIobjectdoimport=true|false
#export APIobjectdorename=true|false
#export APIobjectdoupdate=true|false
#export APIobjectdodelete=true|false

#export APIobjectusesdetailslevel=true|false
#export APIobjectcanignorewarning=true|false
#export APIobjectcanignoreerror=true|false
#export APIobjectcansetifexists=false|true
#export APIobjectderefgrpmem=false|true
#export APIobjecttypehasname=true|false
#export APIobjecttypehasuid=true|false
#export APIobjecttypehasdomain=true|false
#export APIobjecttypehastags=true|false
#export APIobjecttypehasmeta=true|false
#export APIobjecttypeimportname=true|false

#export APIobjectCSVFileHeaderAbsoluteBase=false|true
#export APIobjectCSVJQparmsAbsoluteBase=false|true

#export APIobjectCSVexportWIP=false|true

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=


##SpecialObjectsCheckAPIVersionAndExecuteOperation

#case "${domaintarget}" in
    #'System Data' )
        ## We don't execute this action for the domain "System Data"
        #echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} 'For Objects Type : '${APICLIobjectstype}'  This will NOT work with Domain ["'${domaintarget}'"]' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        #;;
    ## Anything unknown is recorded for later
    #* )
        ## All other domains and no domain should work for this
        #case "${TypeOfExport}" in
            ## a "Standard" export operation
            #'standard' )
                #SpecialObjectsCheckAPIVersionAndExecuteOperation
                #;;
            ## a "name-only" export operation
            ##'name-only' )
            ## a "name-and-uid" export operation
            ##'name-and-uid' )
            ## a "uid-only" export operation
            ##'uid-only' )
            ## a "rename-to-new-nam" export operation
            ##'rename-to-new-name' )
            ## Anything unknown is handled as "standard"
            #* )
                #echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                #echo `${dtzs}`${dtzsep} 'Objects Type : '${APICLIobjectstype}'  DOES NOT support an Export of type ["'${TypeOfExport}'"]' | tee -a -i ${logfilepath}
                #echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
                #echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                #;;
        #esac
        #;;
#esac


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# No more Special Objects and Properties
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


# MODIFIED 2022-07-07 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Special objects and properties - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-07-07


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Simple Object via Generic-Objects Handler
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Simple Object via Generic-Objects Handler' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Simple Object via Generic-Objects Handling Procedures
# -------------------------------------------------------------------------------------------------

# PENDING -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Simple Object via Generic-Objects Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Specific Simple OBJECT : application-sites
# | Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# | Reference Details and initial object
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APICLICSVobjecttype=${APIGenObjcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export AugmentExportedFields=false

if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export AugmentExportedFields=true
elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    export AugmentExportedFields=true
elif ${OnlySystemObjects} ; then
    export AugmentExportedFields=true
else
    export AugmentExportedFields=false
fi

#SimpleObjectsJSONViaGenericObjectsHandler


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# No more Simple Object via Generic-Objects Handler objects
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


# MODIFIED 2022-12-14:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Simple Object via Generic-Objects Handler - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-12-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Handle Complex Objects
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - complex objects - '${scriptactiondescriptor}' Starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Common Complex Object Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2017-11-09 -


# -------------------------------------------------------------------------------------------------
# SetupExportComplexObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-03:04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportComplexObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportComplexObjectsToCSVviaJQ () {
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'X' "${X}" >> ${logfilepath}
    #
    
    ConfigureWorkAPIObjectLimit
    
    ConfigureCSVFileNamesForExport
    
    ConfigureJSONRepoFileNamesAndPaths
    
    if [ ! -r ${APICLICSVpathexportwip} ] ; then
        mkdir -p -v ${APICLICSVpathexportwip} >> ${logfilepath} 2>&1
    fi
    
    if [ -r ${APICLICSVfile} ] ; then
        rm ${APICLICSVfile} >> ${logfilepath} 2>&1
    fi
    if [ -r ${APICLICSVfileheader} ] ; then
        rm ${APICLICSVfileheader} >> ${logfilepath} 2>&1
    fi
    if [ -r ${APICLICSVfiledata} ] ; then
        rm ${APICLICSVfiledata} >> ${logfilepath} 2>&1
    fi
    if [ -r ${APICLICSVfilesort} ] ; then
        rm ${APICLICSVfilesort} >> ${logfilepath} 2>&1
    fi
    if [ -r ${APICLICSVfileoriginal} ] ; then
        rm ${APICLICSVfileoriginal} >> ${logfilepath} 2>&1
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Create ${APICLIcomplexobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    
    #
    # Troubleshooting output
    #
    echo `${dtzs}`${dtzsep} 'CSVFileHeader : ' >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo ${CSVFileHeader} >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    
    echo ${CSVFileHeader} > ${APICLICSVfileheader}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-03:04


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# FinalizeExportComplexObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-11 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeExportComplexObjectsToCSVviaJQ () {
    #
    # The FinalizeExportComplexObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
    #
    
    if [ ! -r "${APICLICSVfileheader}" ] ; then
        # Uh, Oh, something went wrong, no header file
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!! Error header file missing : '${APICLICSVfileheader} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Terminating!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 254
    fi
    
    # Changing this behavior since it's nonsense to quit here because of missing data file, that could be on purpose
    if [ ! -r "${APICLICSVfiledata}" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} '!!!! Error data file missing : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} 'Terminating!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!! data file is missing so no data : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping CSV creation!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #return 253
        return 0
    fi
    
    if [ ! -s "${APICLICSVfiledata}" ] ; then
        # data file is empty, nothing was found
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!! data file is empty : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping CSV creation!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 0
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Sort data and build CSV export file" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfileoriginal} 2>>  ${logfilepath}
    cat ${APICLICSVfiledata} >> ${APICLICSVfileoriginal} 2>>  ${logfilepath}
    
    sort ${APICLICSVsortparms} ${APICLICSVfiledata} > ${APICLICSVfilesort} 2>>  ${logfilepath}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfile} 2>>  ${logfilepath}
    cat ${APICLICSVfilesort} >> ${APICLICSVfile} 2>>  ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Done creating ${APICLIcomplexobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    head ${APICLICSVfile} | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return 0
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-11


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Common Complex Object Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Generic Complex Objects Type Handler
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Generic Complex Objects Type Handler' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2021-01-18 -


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfObjectsTypeFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfObjectsTypeFromMgmtDB generates an array of objects type objects for further processing.

PopulateArrayOfObjectsTypeFromMgmtDB () {
    
    errorreturn=0
    
    # MODIFIED 2023-03-04:01 - 
    # System Object selection operands
    # Current alternative if more options to exclude are needed
    
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} '  '${APICLIobjectstype}' - Populate up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentobjecttypesoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIobjectstype}'   Using Object Query Selector "'${objectqueryselector}'"' | tee -a -i ${logfilepath}
    
    if [ x"${objectqueryselector}" != x"" ] ; then
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        # Don't Ignore System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level standard -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} '    Read Objects into array:  ' | tee -a -i ${logfilepath}
    
    while read -r line; do
        if [ "${line}" == '' ]; then
            # ${line} value is nul, so skip adding to array
            echo -n '%' | tee -a -i ${logfilepath}
        else
            # ${line} value is NOT nul, so add to array
            ALLOBJECTSTYPARRAY+=("${line}")
            echo -n '.' | tee -a -i ${logfilepath}
        fi
    done <<< "${MGMT_CLI_OBJECTSTYPE_STRING}"
    errorreturn=$?
    
    echo | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfObjectsTypeFromMgmtDB procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfObjectsTypeFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 -  \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfObjectsTypeFromJSONRepository generates an array of objects type objects from the JSON Repository file for further processing.

PopulateArrayOfObjectsTypeFromJSONRepository () {
    
    errorreturn=0
    
    # MODIFIED 2023-03-04:01 - 
    # System Object selection operands
    # Current alternative if more options to exclude are needed
    
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} '  '${APICLIobjectstype}' - Populate up to this number ['${JSONRepoObjectsTotal}'] of '${APICLIobjecttype}' objects' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIobjectstype}'   Using Object Query Selector "'${objectqueryselector}'"' | tee -a -i ${logfilepath}
    
    if [ x"${objectqueryselector}" != x"" ] ; then
        JSON_REPO_OBJECTSTYPE_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        JSON_REPO_OBJECTSTYPE_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} '    Read Objects into array:  ' | tee -a -i ${logfilepath}
    
    while read -r line; do
        if [ "${line}" == '' ]; then
            # ${line} value is nul, so skip adding to array
            echo -n '%' | tee -a -i ${logfilepath}
        else
            # ${line} value is NOT nul, so add to array
            ALLOBJECTSTYPARRAY+=("${line}")
            echo -n '.' | tee -a -i ${logfilepath}
        fi
    done <<< "${JSON_REPO_OBJECTSTYPE_STRING}"
    errorreturn=$?
    
    echo | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfObjectsTypeFromJSONRepository procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-13:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfObjectsType generates an array of objects type objects for further processing.

GetArrayOfObjectsType () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    errorreturn=0
    
    export ALLOBJECTSTYPARRAY=()
    export ObjectsOfTypeToProcess=false
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Generate array of '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-09-13:01 -
    
    CheckAPIKeepAlive
    
    # MODIFIED 2022-09-13:01 -
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    ConfigureMgmtCLIOperationalParametersExport
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    export objectstoshow=${objectstotal}
    
    # MODIFIED 2022-07-12:01 -
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    # MODIFIED 2022-07-12:01 -
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    export currentobjecttypesoffset=0
    export objectslefttoshow=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        echo `${dtzs}`${dtzsep} "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
        
        export objectslefttoshow=${objectstoshow}
        
        while [ ${objectslefttoshow} -ge 1 ] ; do
            # we have objects to process
            echo `${dtzs}`${dtzsep} '  Now processing up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentobjecttypesoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
            
            PopulateArrayOfObjectsTypeFromMgmtDB
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfObjectsTypeFromMgmtDB procedure' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            export objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
            export currentobjecttypesoffset=`expr ${currentobjecttypesoffset} + ${WorkAPIObjectLimit}`
            
            CheckAPIKeepAlive
            
        done
        
    else
        # Execute the JSON repository query instead
        
        echo `${dtzs}`${dtzsep} 'Processing '${JSONRepoObjectsTotal}' ['${objectstoshow}'] '${APICLIobjecttype}' objects from the JSON repository file '${JSONRepoFile} | tee -a -i ${logfilepath}
        
        PopulateArrayOfObjectsTypeFromJSONRepository
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfObjectsTypeFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${#ALLOBJECTSTYPARRAY[@]} -ge 1 ] ; then
        # ALLOBJECTSTYPARRAY is not empty
        export ObjectsOfTypeToProcess=true
    else
        export ObjectsOfTypeToProcess=false
    fi
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  Final ObjectsOfTypeToProcess = '${ObjectsOfTypeToProcess} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  Final ObjectsOfTypeToProcess = '${ObjectsOfTypeToProcess} >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} '  Number of Object Types Array Elements = ['"${#ALLOBJECTSTYPARRAY[@]}"']' | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  Final Object Types Array = ' | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
        #echo | tee -a -i ${logfilepath}
        
        echo '['"${ALLOBJECTSTYPARRAY[@]}"']' | tee -a -i ${logfilepath}
        
        #echo | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  Final Object Types Array = ' >> ${logfilepath}
        echo '------------------------------------------------------------------------       ' >> ${logfilepath}
        #echo | tee -a -i ${logfilepath}
        
        echo '['"${ALLOBJECTSTYPARRAY[@]}"']' >> ${logfilepath}
        
        #echo | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' >> ${logfilepath}
    fi
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-13:01


# -------------------------------------------------------------------------------------------------
# DumpArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfObjectsType outputs the array of objects type objects.

DumpArrayOfObjectsType () {
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all objects found
        
        # print the elements in the array
        echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Dump '${APICLIobjectstype}' for generating '${APICLIcomplexobjectstype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        for i in "${ALLOBJECTSTYPARRAY[@]}"
        do
            echo `${dtzs}`${dtzsep} "${i}, ${i//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Done dumping '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29:02


# -------------------------------------------------------------------------------------------------
# CollectMembersInObjectsTypeWithMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-27:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectMembersInObjectsTypeWithMgmtDB outputs the number of objects type members in a group in the array of objects type objects 
# and collects them into the csv file using the Management DB via mgmt_cli calls

CollectMembersInObjectsTypeWithMgmtDB () {
    
    #
    # using bash variables in a jq expression
    #
    
    errorreturn=0
    
    #export CSVJQmemberparmsbase='.["name"], .["members"]['${COUNTER}']["name"]'
    export CSVJQmemberparmsbase='.["name"]'
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVJQmemberparmsbase=${CSVJQmemberparmsbase}', true, true'
        if ${APIobjectcansetifexists} ; then
            export CSVJQmemberparmsbase=${CSVJQmemberparmsbase}', true'
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    for i in "${ALLOBJECTSTYPARRAY[@]}"
    do
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        MEMBERS_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".members | length")
        
        export NUM_OBJECTSTYPE_MEMBERS=${MEMBERS_COUNT}
        
        if [ x"${NUM_OBJECTSTYPE_MEMBERS}" == x"" ] ; then
            # There are null objects, so skip
            
            #echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = NULL (0 zero)' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = NULL (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
            
        elif [[ ${NUM_OBJECTSTYPE_MEMBERS} -lt 1 ]] ; then
            # no objects of this type
            
            #echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members < 1 ['${NUM_OBJECTSTYPE_MEMBERS}'] (0 zero)' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members < 1 ['${NUM_OBJECTSTYPE_MEMBERS}'] (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        else
            # More than zero (1) interfaces, something to process
            echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = '"${NUM_OBJECTSTYPE_MEMBERS}" | tee -a -i ${logfilepath}
            
            export CSVJQmemberparms='"'${objectnametoevaluate}'", '${CSVJQmemberparmsbase}
            
            echo `${dtzs}`${dtzsep} 'CSVJQmemberparms : ' >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            echo ${CSVJQmemberparms} >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            
            # MODIFIED 2021-10-23
            # What is this?  Multiple jq operations to consolidate the operation into a single strike
            # 0.)  Output the object ${APICLIobjecttype} with name ${objectnametoevaluate} at details-level "full" for jq processing
            #      Action: ]# mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json
            # 1.)  Get the current objects members as a seperate list
            #      Action: ]# ${JQ} '.objects[] | select(.name == "'"${objectnametoevaluate}"'") | .members[]'
            # 2.)  Pipe that json list of members objects, which are not clean to a jq slurp action to make them usable as an array
            #      Action: ]# ${JQ} -s '.'
            # 3.)  Pipe the results from the jq slurp to make an array, to jq to parse for the ${CSVJQmemberparms} items into CSV format
            #      Action: ]# ${JQ} '.[] | [ '"${CSVJQmemberparms}"' ] | @csv' -r
            #
            
            mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.members[]' | ${JQ} -s '.' | ${JQ} '.[] | [ '"${CSVJQmemberparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
            
            if [ "${errorreturn}" != "0" ] ; then
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Error in JQ Operation in CollectMembersInObjectsTypeWithMgmtDB for object '${APICLIobjecttype}' with name '${objectnametoevaluate}' which may lead to failure to generate output!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                cat ${APICLICSVfiledata} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            fi
        fi
        
    done
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-02-27:01


# -------------------------------------------------------------------------------------------------
# CollectMembersInObjectsTypeWithJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-10-27:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectMembersInObjectsTypeWithJSONRepository outputs the number of objects type members in a group in the array of objects type objects 
# and collects them into the csv file using the Management DB via mgmt_cli calls

CollectMembersInObjectsTypeWithJSONRepository () {
    
    #
    # using bash variables in a jq expression
    #
    
    errorreturn=0
    
    #export CSVJQmemberparmsbase='.["name"], .["members"]['${COUNTER}']["name"]'
    export CSVJQmemberparmsbase='.["name"]'
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVJQmemberparmsbase=${CSVJQmemberparmsbase}', true, true'
        if ${APIobjectcansetifexists} ; then
            export CSVJQmemberparmsbase=${CSVJQmemberparmsbase}', true'
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    for i in "${ALLOBJECTSTYPARRAY[@]}"
    do
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        #MEMBERS_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".members | length")
        MEMBERS_COUNT=$(cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"${objectnametoevaluate}"'") | .members | length')
        
        export NUM_OBJECTSTYPE_MEMBERS=${MEMBERS_COUNT}
        
        if [ x"${NUM_OBJECTSTYPE_MEMBERS}" == x"" ] ; then
            # There are null objects, so skip
            
            #echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = NULL (0 zero)' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = NULL (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_OBJECTSTYPE_MEMBERS} -lt 1 ]] ; then
            # no objects of this type
            
            #echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members < 1 ['${NUM_OBJECTSTYPE_MEMBERS}'] (0 zero)' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members < 1 ['${NUM_OBJECTSTYPE_MEMBERS}'] (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        else
            # More than zero (1) interfaces, something to process
            echo `${dtzs}`${dtzsep} 'Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = '"${NUM_OBJECTSTYPE_MEMBERS}" | tee -a -i ${logfilepath}
            
            export CSVJQmemberparms='"'${objectnametoevaluate}'", '${CSVJQmemberparmsbase}
            
            echo `${dtzs}`${dtzsep} 'CSVJQmemberparms : ' >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            echo ${CSVJQmemberparms} >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            
            # MODIFIED 2021-10-23
            # What is this?  Multiple jq operations to consolidate the operation into a single strike
            # 0.)  Output the Repository file of ${APICLIobjecttype} for jq processing
            #      Action: ]# cat ${JSONRepoFile}
            # 1.)  Get the current objects members as a seperate list
            #      Action: ]# ${JQ} '.objects[] | select(.name == "'"${objectnametoevaluate}"'") | .members[]'
            # 2.)  Pipe that json list of members objects, which are not clean to a jq slurp action to make them usable as an array
            #      Action: ]# ${JQ} -s '.'
            # 3.)  Pipe the results from the jq slurp to make an array, to jq to parse for the ${CSVJQmemberparms} items into CSV format
            #      Action: ]# ${JQ} '.[] | [ '"${CSVJQmemberparms}"' ] | @csv' -r
            #
            cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"${objectnametoevaluate}"'") | .members[]' | ${JQ} -s '.' | ${JQ} '.[] | [ '"${CSVJQmemberparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
            
            if [ "${errorreturn}" != "0" ] ; then
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Error in JQ Operation in CollectMembersInObjectsTypeWithJSONRepository for group object '${objectnametoevaluate}' which may lead to failure to generate output!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                cat ${APICLICSVfiledata} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            fi
        fi
        
    done
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-10-27:01


# -------------------------------------------------------------------------------------------------
# CollectMembersInObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectMembersInObjectsType outputs the number of objects type members in a group in the array of objects type objects and collects them into the csv file.

CollectMembersInObjectsType () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Use array of '${APICLIobjectstype}' to generate objects type members CSV' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-07-12:01 -
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    # MODIFIED 2022-07-12:01 -
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    errorreturn=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        CollectMembersInObjectsTypeWithMgmtDB
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectMembersInObjectsTypeWithMgmtDB procedure' | tee -a -i ${logfilepath}
        fi
        
    else
        # Execute the JSON repository query instead
        
        CollectMembersInObjectsTypeWithJSONRepository
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectMembersInObjectsTypeWithJSONRepository procedure' | tee -a -i ${logfilepath}
        fi
        
    fi
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# GetObjectMembers proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-12:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetObjectMembers generate output of objects type members from existing objects type objects

GetObjectMembers () {
    
    errorreturn=0
    
    export ALLOBJECTSTYPARRAY=()
    export ObjectsOfTypeToProcess=false
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        #if ${APIobjectcansetifexists} ; then
            #export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
            #export CSVJQparms=${CSVJQparms}', true'
        #fi
    fi
    
    SetupExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SetupExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype}' -- RETURNING!!' | tee -a -i ${logfilepath}
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
        
        return ${errorreturn}
    fi
    
    GetArrayOfObjectsType
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in GetArrayOfObjectsType procedure' | tee -a -i ${logfilepath}
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype}' -- RETURNING!!' | tee -a -i ${logfilepath}
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
        return ${errorreturn}
    fi
    
    if ${ObjectsOfTypeToProcess} ; then
        # we have objects left to process after generating the array of ObjectsType
        echo `${dtzs}`${dtzsep} 'Processing returned '${#ALLOBJECTSTYPARRAY[@]}' objects of type '${APICLIobjectstype}', so processing this object' | tee -a -i ${logfilepath}
        
        DumpArrayOfObjectsType
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DumpArrayOfObjectsType procedure' | tee -a -i ${logfilepath}
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype}' -- RETURNING!!' | tee -a -i ${logfilepath}
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
        
        CollectMembersInObjectsType
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectMembersInObjectsType procedure' | tee -a -i ${logfilepath}
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype}' -- RETURNING!!' | tee -a -i ${logfilepath}
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
        
        FinalizeExportComplexObjectsToCSVviaJQ
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype}' -- RETURNING!!' | tee -a -i ${logfilepath}
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
        fi
    else
        # The array of ObjectsType is empty, nothing to process
        echo `${dtzs}`${dtzsep} 'No objects of type '${APICLIobjectstype}' were returned to process, skipping further operations on this object' | tee -a -i ${logfilepath}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
    fi
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-12:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GenericComplexObjectsMembersHandler proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 -  \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GenericComplexObjectsMembersHandler () {
    #
    # Generic Handler for Complex Object Types
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if ${ExportTypeIsStandard} ; then
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2023-03-04:01 -
        #
        
        DumpObjectDefinitionData
        
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2022-09-16:01 -
        # Account for whether the original object definition is for REFERENCE, NO IMPORT already
        
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${OnlySystemObjects} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}
        fi
        
        objectstotal_object=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_object="${objectstotal_object}"
        
        if [ ${number_object} -le 0 ] ; then
            # No groups found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate '${APICLIcomplexobjectstype}' members from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            GetObjectMembers
            errorreturn=$?
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Not "standard" Export Type :  '${TypeOfExport}' so do not handle complex objects '${APICLIcomplexobjectstype}' for '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in GenericComplexObjectsMembersHandler procedure' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        if ${ABORTONERROR} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            return ${errorreturn}
        fi
    else
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Specific Complex Objects :  These require extra plumbing
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex Objects :  These require extra plumbing' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Specific Complex OBJECT : host interfaces
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex OBJECT : host interfaces' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Specific Complex OBJECT : host interfaces Handling Procedures
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:01 -


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfHostInterfacesFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfHostInterfacesFromMgmtDB populates array of host objects for further processing from Management DB via mgmt_cli.

PopulateArrayOfHostInterfacesFromMgmtDB () {
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    errorreturn=0
    
    # MODIFIED 2023-03-04:01 - 
    # System Object selection operands
    # Current alternative if more options to exclude are needed
    
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "  ${APICLIobjectstype} - Populate Array of Host Interfaces from Management Database via mgmt_cli!" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "  ${APICLIobjectstype} - Populate up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currenthostoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MGMT_CLI_HOSTS_STRING is a string with multiple lines. Each line contains a name of a host.
    
    if [ x"${objectqueryselector}" != x"" ] ; then
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level standard -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    while read -r line; do
        # MODIFIED 2022-05-02 -
        if [ "${line}" == '' ]; then
            # ${line} value is nul, so skip adding to array
            echo -n '%' | tee -a -i ${logfilepath}
        else
            # ${line} value is NOT nul, so add to array
            
            ALLHOSTSARR+=("${line}")
            
            echo -n '.' | tee -a -i ${logfilepath}
            
            arraylength=${#ALLHOSTSARR[@]}
            arrayelement=$((arraylength-1))
            
            if ${APISCRIPTVERBOSE} ; then
                echo -n ' '"${line}"', ' | tee -a -i ${logfilepath}
                echo -n "$(eval echo ${line})"', ' >> ${logfilepath}
                echo -n "$arraylength"', ' >> ${logfilepath}
                echo -n "$arrayelement"', ' | tee -a -i ${logfilepath}
            fi
            
            INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${line})" details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".interfaces | length")
            
            NUM_HOST_INTERFACES=${INTERFACES_COUNT}
            
            if [ x"${NUM_HOST_INTERFACES}" == x"" ] ; then
                # There are null objects, so skip
                if ${APISCRIPTVERBOSE} ; then
                    echo -n 'N, ' | tee -a -i ${logfilepath}
                else
                    echo -n 'N' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            elif [[ ${NUM_HOST_INTERFACES} -lt 1 ]] ; then
                # no objects of this type
                if ${APISCRIPTVERBOSE} ; then
                    echo -n '0, ' | tee -a -i ${logfilepath}
                else
                    echo -n '0' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            elif [[ ${NUM_HOST_INTERFACES} -gt 0 ]] ; then
                # More than zero (1) interfaces, something to process
                if [ ${NUM_HOST_INTERFACES} -gt ${MAXHostInterfacesValues} ] ; then
                    export MAXHostInterfacesValues=${NUM_HOST_INTERFACES}
                fi
                
                if ${APISCRIPTVERBOSE} ; then
                    echo -n "${NUM_HOST_INTERFACES}"', ' | tee -a -i ${logfilepath}
                else
                    echo -n "${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
                fi
                HOSTSARR+=("${line}")
                let HostInterfacesCount=HostInterfacesCount+${NUM_HOST_INTERFACES}
                echo -n '!' | tee -a -i ${logfilepath}
            else
                # ?? Whatever..., so skip
                if ${APISCRIPTVERBOSE} ; then
                    echo -n '?, ' | tee -a -i ${logfilepath}
                else
                    echo -n '?' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            fi
            
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo | tee -a -i ${logfilepath}
            echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
    done <<< "${MGMT_CLI_HOSTS_STRING}"
    errorreturn=$?
    
    echo | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'HostInterfacesCount     = '${HostInterfacesCount} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'MAXHostInterfacesValues = '${MAXHostInterfacesValues} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'HostInterfacesCount     = '${HostInterfacesCount} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'MAXHostInterfacesValues = '${MAXHostInterfacesValues} >> ${logfilepath}
    fi
    
    export HostInterfacesCount=${HostInterfacesCount}
    
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfHostInterfacesFromMgmtDB procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfHostInterfacesFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfHostInterfacesFromJSONRepository populates array of host objects for further processing from JSON Repository.

PopulateArrayOfHostInterfacesFromJSONRepository () {
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    errorreturn=0
    
    # MODIFIED 2023-03-04:01 - 
    # System Object selection operands
    # Current alternative if more options to exclude are needed
    
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "  ${APICLIobjectstype} - Populate Array of Host Interfaces from JSON Repository!" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MGMT_CLI_HOSTS_STRING is a string with multiple lines. Each line contains a name of a host.
    
    if [ x"${objectqueryselector}" != x"" ] ; then
        JSON_REPO_HOSTS_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        JSON_REPO_HOSTS_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    while read -r line; do
        # MODIFIED 2022-05-02 -
        if [ "${line}" == '' ]; then
            # ${line} value is nul, so skip adding to array
            echo -n '%' | tee -a -i ${logfilepath}
        else
            # ${line} value is NOT nul, so add to array
            
            ALLHOSTSARR+=("${line}")
            
            echo -n '.' | tee -a -i ${logfilepath}
            
            arraylength=${#ALLHOSTSARR[@]}
            arrayelement=$((arraylength-1))
            
            if ${APISCRIPTVERBOSE} ; then
                echo -n ' '"${line}"', ' | tee -a -i ${logfilepath}
                echo -n "$(eval echo ${line})"', ' >> ${logfilepath}
                echo -n "$arraylength"', ' >> ${logfilepath}
                echo -n "$arrayelement"', ' | tee -a -i ${logfilepath}
            fi
            
            INTERFACES_COUNT=$(cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"$(eval echo ${line})"'") | .interfaces | length')
            
            NUM_HOST_INTERFACES=${INTERFACES_COUNT}
            
            if [ x"${NUM_HOST_INTERFACES}" == x"" ] ; then
                # There are null objects, so skip
                if ${APISCRIPTVERBOSE} ; then
                    echo -n 'N, ' | tee -a -i ${logfilepath}
                else
                    echo -n 'N' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            elif [[ ${NUM_HOST_INTERFACES} -lt 1 ]] ; then
                # no objects of this type
                if ${APISCRIPTVERBOSE} ; then
                    echo -n '0, ' | tee -a -i ${logfilepath}
                else
                    echo -n '0' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            elif [[ ${NUM_HOST_INTERFACES} -gt 0 ]] ; then
                # More than zero (1) interfaces, something to process
                if [ ${NUM_HOST_INTERFACES} -gt ${MAXHostInterfacesValues} ] ; then
                    export MAXHostInterfacesValues=${NUM_HOST_INTERFACES}
                fi
                
                if ${APISCRIPTVERBOSE} ; then
                    echo -n "${NUM_HOST_INTERFACES}"', ' | tee -a -i ${logfilepath}
                else
                    echo -n "${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
                fi
                HOSTSARR+=("${line}")
                let HostInterfacesCount=HostInterfacesCount+${NUM_HOST_INTERFACES}
                echo -n '!' | tee -a -i ${logfilepath}
            else
                # ?? Whatever..., so skip
                if ${APISCRIPTVERBOSE} ; then
                    echo -n '?, ' | tee -a -i ${logfilepath}
                else
                    echo -n '?' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            fi
            
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo | tee -a -i ${logfilepath}
            echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
        
    done <<< "${JSON_REPO_HOSTS_STRING}"
    errorreturn=$?
    
    echo | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'HostInterfacesCount     = '${HostInterfacesCount} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'MAXHostInterfacesValues = '${MAXHostInterfacesValues} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'HostInterfacesCount     = '${HostInterfacesCount} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'MAXHostInterfacesValues = '${MAXHostInterfacesValues} >> ${logfilepath}
    fi
    
    export HostInterfacesCount=${HostInterfacesCount}
    
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfHostInterfacesFromJSONRepository procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-13:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfHostInterfaces generates an array of host objects for further processing.

GetArrayOfHostInterfaces () {
    
    errorreturn=0
    
    HOSTSARR=()
    ALLHOSTSARR=()
    MAXHostInterfacesValues=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Generate array of hosts' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-09-13:01 -
    
    CheckAPIKeepAlive
    
    # MODIFIED 2022-09-13:01 -
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    ConfigureMgmtCLIOperationalParametersExport
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    export objectstoshow=${objectstotal}
    
    # MODIFIED 2022-07-12:01 -
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    # MODIFIED 2022-07-12:01 -
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    currenthostoffset=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        echo `${dtzs}`${dtzsep} "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
        
        objectslefttoshow=${objectstoshow}
        
        while [ ${objectslefttoshow} -ge 1 ] ; do
            # we have objects to process
            echo `${dtzs}`${dtzsep} "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currenthostoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
            
            PopulateArrayOfHostInterfacesFromMgmtDB
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfHostInterfacesFromMgmtDB procedure' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
            currenthostoffset=`expr ${currenthostoffset} + ${WorkAPIObjectLimit}`
            
            CheckAPIKeepAlive
            
        done
        
    else
        # Execute the JSON repository query instead
        
        echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APICLIobjecttype}' objects from the JSON repository file '${JSONRepoFile} | tee -a -i ${logfilepath}
        
        PopulateArrayOfHostInterfacesFromJSONRepository
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfHostInterfacesFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Final HostInterfacesCount = '${HostInterfacesCount} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Final Host Array = ' | tee -a -i ${logfilepath}
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    #echo | tee -a -i ${logfilepath}
    
    echo '['"${HOSTSARR[@]}"']' | tee -a -i ${logfilepath}
    
    #echo | tee -a -i ${logfilepath}
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-13:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DumpArrayOfHostsObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfHostsObjects outputs the array of host objects.

DumpArrayOfHostsObjects () {
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all hosts found
        
        # print the elements in the array
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} Dump All hosts | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #
        #for i in "${ALLHOSTSARR[@]}"
        #do
        #    echo `${dtzs}`${dtzsep} "$i, ${i//\'/}" | tee -a -i ${logfilepath}
        #done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} hosts with interfaces defined | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        for j in "${HOSTSARR[@]}"
        do
            echo `${dtzs}`${dtzsep} "$j, ${j//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} Done dumping hosts | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-22


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjectsFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-10-27:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectInterfacesInHostObjectsFromMgmtDB outputs the host interfaces in a host in the array of host objects and collects them into the csv file using the mgmg_cli calls to the Management DB.

CollectInterfacesInHostObjectsFromMgmtDB () {
    
    errorreturn=0
    
    #
    # using bash variables in a jq expression
    #
    
    #export CSVJQinterfaceparmsbase='.["name"], .["interfaces"]['${COUNTER}']["name"]'
    export CSVJQinterfaceparmsbase='.["name"]'
    export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', .["subnet4"], .["mask-length4"]'
    export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', .["subnet6"], .["mask-length6"]'
    export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', .["color"], .["comments"]'
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', true, true'
        if ${APIobjectcansetifexists} ; then
            export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', true'
        fi
    fi
    
    for i in "${HOSTSARR[@]}"
    do
        export hosttoevaluate=${i}
        export hostnametoevaluate=${i//\'/}
        
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} Host with interfaces "${hostnametoevaluate}" | tee -a -i ${logfilepath}
        
        INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${hostnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".interfaces | length")
        
        NUM_HOST_INTERFACES=${INTERFACES_COUNT}
        
        if [ x"${NUM_HOST_INTERFACES}" == x"" ] ; then
            # There are null objects, so skip
            
            echo `${dtzs}`${dtzsep} 'host '"${hostnametoevaluate}"' number of interfaces = NULL (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_HOST_INTERFACES} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep} 'host '"${hostnametoevaluate}"' number of interfaces = 0 (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_HOST_INTERFACES} -gt 0 ]] ; then
            # More than zero (0) interfaces, something to process
            echo `${dtzs}`${dtzsep} 'host '"${hostnametoevaluate}"' number of interfaces = '"${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
            
            export CSVJQinterfaceparms='"'${hostnametoevaluate}'", '${CSVJQinterfaceparmsbase}
            
            echo `${dtzs}`${dtzsep} 'CSVJQinterfaceparms : ' >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            echo ${CSVJQinterfaceparms} >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            
            # MODIFIED 2021-10-23
            # What is this?  Multiple jq operations to consolidate the operation into a single strike
            # 0.)  Generate the hosts data for the specific host for jq processing
            #      Action: ]# mgmt_cli show ${APICLIobjecttype} name "${hostnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json}
            # 1.)  Get the current hosts interfaces as a seperate list
            #      Action: ]# ${JQ} '.objects[] | select(.name == "'"${hostnametoevaluate}"'") | .interfaces[]'
            # 2.)  Pipe that json list of interface objects, which are not clean to a jq slurp action to make them usable as an array
            #      Action: ]# ${JQ} -s '.'
            # 3.)  Pipe the results from the jq slurp to make an array, to jq to parse for the ${CSVJQinterfaceparms} items into CSV format
            #      Action: ]# ${JQ} '.[] | [ '"${CSVJQinterfaceparms}"' ] | @csv' -r
            #
            mgmt_cli show ${APICLIobjecttype} name "${hostnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.interfaces[]' | ${JQ} -s '.' | ${JQ} '.[] | [ '"${CSVJQinterfaceparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectInterfacesInHostObjectsFromMgmtDB mgmt_cli execution reading host '${hostnametoevaluate}' interfaces' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (first 3 and last 10 lines) with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                head -n 3 ${APICLICSVfiledata} | tee -a -i ${logfilepath}
                echo '...' | tee -a -i ${logfilepath}
                tail ${APICLICSVfiledata} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            CheckAPIKeepAlive
            
        else
            # ?? Whatever..., so skip
            echo `${dtzs}`${dtzsep} 'host '"${hostnametoevaluate}"' number of interfaces = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-10-27:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjectsFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-10-27:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectInterfacesInHostObjectsFromJSONRepository outputs the host interfaces in a host in the array of host objects and collects them into the csv file using the JSON Repository.

CollectInterfacesInHostObjectsFromJSONRepository () {
    
    errorreturn=0
    
    #
    # using bash variables in a jq expression
    #
    
    #export CSVJQinterfaceparmsbase='.["name"], .["interfaces"]['${COUNTER}']["name"]'
    export CSVJQinterfaceparmsbase='.["name"]'
    export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', .["subnet4"], .["mask-length4"]'
    export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', .["subnet6"], .["mask-length6"]'
    export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', .["color"], .["comments"]'
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', true, true'
        if ${APIobjectcansetifexists} ; then
            export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', true'
        fi
    fi
    
    for i in "${HOSTSARR[@]}"
    do
        export hosttoevaluate=${i}
        export hostnametoevaluate=${i//\'/}
        
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} Host with interfaces "${hostnametoevaluate}" | tee -a -i ${logfilepath}
        
        #INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${i//\'/}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".interfaces | length")
        INTERFACES_COUNT=$(cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"${hostnametoevaluate}"'") | .interfaces | length')
        
        NUM_HOST_INTERFACES=${INTERFACES_COUNT}
        
        if [ x"${NUM_HOST_INTERFACES}" == x"" ] ; then
            # There are null objects, so skip
            
            echo `${dtzs}`${dtzsep} 'host '"${hostnametoevaluate}"' number of interfaces = NULL (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_HOST_INTERFACES} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep} 'host '"${hostnametoevaluate}"' number of interfaces =  0 (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_HOST_INTERFACES} -gt 0 ]] ; then
            # More than zero (0) interfaces, something to process
            echo `${dtzs}`${dtzsep} 'host '"${hostnametoevaluate}"' number of interfaces = '"${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
            
            export CSVJQinterfaceparms='"'${hostnametoevaluate}'", '${CSVJQinterfaceparmsbase}
            
            echo `${dtzs}`${dtzsep} 'CSVJQinterfaceparms : ' >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            echo ${CSVJQinterfaceparms} >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            
            # MODIFIED 2021-10-23
            # What is this?  Multiple jq operations to consolidate the operation into a single strike
            # 0.)  Output the Repository file of hosts for jq processing
            #      Action: ]# cat ${JSONRepoFile}
            # 1.)  Get the current hosts interfaces as a seperate list
            #      Action: ]# ${JQ} '.objects[] | select(.name == "'"${hostnametoevaluate}"'") | .interfaces[]'
            # 2.)  Pipe that json list of interface objects, which are not clean to a jq slurp action to make them usable as an array
            #      Action: ]# ${JQ} -s '.'
            # 3.)  Pipe the results from the jq slurp to make an array, to jq to parse for the ${CSVJQinterfaceparms} items into CSV format
            #      Action: ]# ${JQ} '.[] | [ '"${CSVJQinterfaceparms}"' ] | @csv' -r
            #
            cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"${hostnametoevaluate}"'") | .interfaces[]' | ${JQ} -s '.' | ${JQ} '.[] | [ '"${CSVJQinterfaceparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectInterfacesInHostObjectsFromJSONRepository JQ execution reading host '${hostnametoevaluate}' interfaces' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (first 3 and last 10 lines) with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                head -n 3 ${APICLICSVfiledata} | tee -a -i ${logfilepath}
                echo '...' | tee -a -i ${logfilepath}
                tail ${APICLICSVfiledata} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
        else
            # ?? Whatever..., so skip
            echo `${dtzs}`${dtzsep} 'host '"${hostnametoevaluate}"' number of interfaces = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-10-27:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectInterfacesInHostObjects outputs the host interfaces in a host in the array of host objects and collects them into the csv file.

CollectInterfacesInHostObjects () {
    
    errorreturn=0
    
    #
    # using bash variables in a jq expression
    #
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Use array of hosts to generate host interfaces CSV' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-07-12:01 -
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    # MODIFIED 2022-07-12:01 -
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        CollectInterfacesInHostObjectsFromMgmtDB
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectInterfacesInHostObjectsFromMgmtDB procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # Execute the JSON repository query instead
        
        CollectInterfacesInHostObjectsFromJSONRepository
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectInterfacesInHostObjectsFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    fi
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-22


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetHostInterfacesProcessor proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetHostInterfacesProcessor generate output of host's interfaces from existing hosts with interface objects

GetHostInterfacesProcessor () {
    
    errorreturn=0
    
    if ${ExportTypeIsStandard} ; then
        
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2023-03-04:01 -
        #
        
        DumpObjectDefinitionData
        
        # -------------------------------------------------------------------------------------------------
        
        export HostInterfacesCount=0
        
        # MODIFIED 2021-01-28 -
        
        if ${CSVADDEXPERRHANDLE} ; then
            export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
            export CSVJQparms=${CSVJQparms}', true, true'
            #
            # May need to add plumbing to handle the case that not all objects types might support set-if-exists
            # For now just keep it separate
            #
            if ${APIobjectcansetifexists} ; then
                export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
                export CSVJQparms=${CSVJQparms}', true'
            fi
        fi
        
        SetupExportComplexObjectsToCSVviaJQ
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SetupExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        GetArrayOfHostInterfaces
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in GetArrayOfHostInterfaces procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        if [ x"${HostInterfacesCount}" == x"" ] ; then
            # There are null objects, so skip
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '! No host interfaces found - NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        elif [[ ${HostInterfacesCount} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '! No host interfaces found - 0' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        elif [[ ${HostInterfacesCount} -gt 0 ]] ; then
            # We have host interfaces to process
            DumpArrayOfHostsObjects
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DumpArrayOfHostsObjects procedure' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            CollectInterfacesInHostObjects
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectInterfacesInHostObjects procedure' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            FinalizeExportComplexObjectsToCSVviaJQ
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
        else
            # No host interfaces
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '! No host interfaces found' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Not "standard" Export Type :  '${TypeOfExport}' so do not handle complex objects '${APICLIcomplexobjectstype}' for '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetHostInterfaces generate output of host's interfaces from existing hosts with interface objects using the processor

GetHostInterfaces () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    # MODIFIED 2022-09-16:01 -
    # Account for whether the original object definition is for REFERENCE, NO IMPORT already
    
    if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${OnlySystemObjects} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    else
        export APICLIexportnameaddon=${APICLIexportnameaddon}
    fi
    
    # MODIFIED 2022-05-02 -
    
    if ${ExportTypeIsStandard} ; then
        objectstotal_object=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_object="${objectstotal_object}"
        
        if [ ${number_object} -le 0 ] ; then
            # No ${APICLIobjectstype} found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate '${APICLIcomplexobjectstype}' members from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            GetHostInterfacesProcessor
            errorreturn=$?
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Not "standard" Export Type :  '${TypeOfExport}' so do not handle '${APICLIcomplexobjectstype}' for '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in GetHostInterfacesProcessor procedure' | tee -a -i ${logfilepath}
        
        if ${ABORTONERROR} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            return ${errorreturn}
        fi
    else
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-02-25:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Specific Complex OBJECT : host interfaces Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : hosts with host interfaces
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLIcomplexobjecttype=host-interface
export APICLIcomplexobjectstype=host-interfaces
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=true
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","interfaces.add.name"'
export CSVFileHeader=${CSVFileHeader}',"interfaces.add.subnet4","interfaces.add.mask-length4"'
export CSVFileHeader=${CSVFileHeader}',"interfaces.add.subnet6","interfaces.add.mask-length6"'
export CSVFileHeader=${CSVFileHeader}',"interfaces.add.color","interfaces.add.comments"'

export CSVJQparms='.["name"], .["interfaces"]['${COUNTER}']["name"]'
export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet4"], .["interfaces"]['${COUNTER}']["mask-length4"]'
export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet6"], .["interfaces"]['${COUNTER}']["mask-length6"]'
export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["color"], .["interfaces"]['${COUNTER}']["comments"]'


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if ${script_target_special_objects} ; then
    # not handling this object as part of special objects
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Not handling host interfaces in this special objects handling script, skipping!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    export number_hosts=
    
    objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    export number_hosts="${objectstotal_hosts}"
    
    if [ ${number_hosts} -le 0 ] ; then
        # No hosts found
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'No hosts to generate interfaces from!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        # hosts found
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Check hosts to generate interfaces!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        GetHostInterfaces
    fi
fi

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-02-25:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Specific Complex OBJECT : Advanced Handler - Object Specific Key arrays
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex OBJECT : Advanced Handler - Object Specific Keys with Value arrays' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Specific Complex OBJECT - Object Specific Keys with Value arrays Handling Procedures
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-24:01 -


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfSpecificObjectFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfSpecificObjectFromMgmtDB populates array of objects for further processing from Management DB via mgmt_cli.

PopulateArrayOfSpecificObjectFromMgmtDB () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfSpecificObjectFromMgmtDB procedure Starting' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Populate Array of '${APICLIobjecttype}' Names from Management Database via mgmt_cli!' | tee -a -i ${logfilepath}
    
    export objectslefttoshow=${objectstoshow}
    
    currenthostoffset=0
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        
        # -------------------------------------------------------------------------------------------------
        
        echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Populate up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' object Names starting with object '${currenthostoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        # MGMT_CLI_NAMES_STRING is a string with multiple lines. Each line contains a name of an object of type ${APICLIobjectstype}.
        
        if [ x"${objectqueryselector}" != x"" ] ; then
            MGMT_CLI_NAMES_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
        else
            MGMT_CLI_NAMES_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level standard -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[].name | @sh' -r`"
        fi
        
        # break the string into an array - each element of the array is a line in the original string
        # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
        
        echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        while read -r line; do
            # MODIFIED 2022-09-12 -
            if [ "${line}" == '' ]; then
                # ${line} value is nul, so skip adding to array
                echo -n '%' | tee -a -i ${logfilepath}
            else
                # ${line} value is NOT nul, so add to array
                
                ALLSPECIFICOBJECTSKEYFIELDARRAY+=("${line}")
                
                echo -n '.' | tee -a -i ${logfilepath}
                
                arraylength=${#ALLSPECIFICOBJECTSKEYFIELDARRAY[@]}
                arrayelement=$((arraylength-1))
                
                if ${APISCRIPTVERBOSE} ; then
                    # Verbose mode ON
                    # Output list of all hosts found
                    echo -n ' '"${line}"', ' | tee -a -i ${logfilepath}
                    echo -n "$(eval echo ${line})"', ' >> ${logfilepath}
                    echo -n "$arraylength"', ' >> ${logfilepath}
                    echo -n "$arrayelement"', ' | tee -a -i ${logfilepath}
                    #echo -n "$(eval echo ${ALLHOSTARR[${arrayelement}]})"', ' | tee -a -i ${logfilepath}
                fi
                
                SPECIFICKEYVALUES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${line})" details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'" | length' )
                
                NUM_SPECIFIC_KEY_VALUES=${SPECIFICKEYVALUES_COUNT}
                
                if [ x"${NUM_SPECIFIC_KEY_VALUES}" == x"" ] ; then
                    # There are null objects, so skip
                    if ${APISCRIPTVERBOSE} ; then
                        echo -n 'N, ' | tee -a -i ${logfilepath}
                    else
                        echo -n 'N' | tee -a -i ${logfilepath}
                    fi
                    echo -n '-' | tee -a -i ${logfilepath}
                elif [[ ${NUM_SPECIFIC_KEY_VALUES} -lt 1 ]] ; then
                    # no objects of this type
                    if ${APISCRIPTVERBOSE} ; then
                        echo -n '0, ' | tee -a -i ${logfilepath}
                    else
                        echo -n '0' | tee -a -i ${logfilepath}
                    fi
                    echo -n '-' | tee -a -i ${logfilepath}
                elif [[ ${NUM_SPECIFIC_KEY_VALUES} -gt 0 ]] ; then
                    # More than zero (1) interfaces, something to process
                    if [ ${NUM_SPECIFIC_KEY_VALUES} -gt ${MAXObjectsSpecificKeyValues} ] ; then
                        export MAXObjectsSpecificKeyValues=${NUM_SPECIFIC_KEY_VALUES}
                    fi
                    
                    if ${APISCRIPTVERBOSE} ; then
                        echo -n "${NUM_SPECIFIC_KEY_VALUES}"', ' | tee -a -i ${logfilepath}
                    else
                        echo -n "${NUM_SPECIFIC_KEY_VALUES}" | tee -a -i ${logfilepath}
                    fi
                    SPECIFICOBJECTSKEYFIELDARRAY+=("${line}")
                    let SpecificKeyValuesCount=SpecificKeyValuesCount+${NUM_SPECIFIC_KEY_VALUES}
                    echo -n '!' | tee -a -i ${logfilepath}
                else
                    # ?? Whatever..., so skip
                    if ${APISCRIPTVERBOSE} ; then
                        echo -n '?, ' | tee -a -i ${logfilepath}
                    else
                        echo -n '?' | tee -a -i ${logfilepath}
                    fi
                    echo -n '-' | tee -a -i ${logfilepath}
                fi
                
            fi
            
            if ${APISCRIPTVERBOSE} ; then
                echo | tee -a -i ${logfilepath}
                echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            fi
            
        done <<< "${MGMT_CLI_NAMES_STRING}"
        errorreturn=$?
        
        echo | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currenthostoffset=`expr ${currenthostoffset} + ${WorkAPIObjectLimit}`
        
        CheckAPIKeepAlive
        
    done
    
    # -------------------------------------------------------------------------------------------------
    
    echo | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  SpecificKeyValuesCount      = '${SpecificKeyValuesCount} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  MAXObjectsSpecificKeyValues = '${MAXObjectsSpecificKeyValues} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  SpecificKeyValuesCount      = '${SpecificKeyValuesCount} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '  MAXObjectsSpecificKeyValues = '${MAXObjectsSpecificKeyValues} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    export SpecificKeyValuesCount=${SpecificKeyValuesCount}
    
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfSpecificObjectFromMgmtDB procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfSpecificObjectFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfSpecificObjectFromJSONRepository populates array of objects for further processing from JSON Repository.

PopulateArrayOfSpecificObjectFromJSONRepository () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfSpecificObjectFromJSONRepository procedure Starting' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Populate Array of '${APICLIobjecttype}' Names from JSON Repository!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # JSON_REPO_NAMES_STRING is a string with multiple lines. Each line contains a name of a ${APICLIobjecttype}.
    
    if [ x"${objectqueryselector}" != x"" ] ; then
        JSON_REPO_NAMES_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        JSON_REPO_NAMES_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    while read -r line; do
        # MODIFIED 2022-09-12 -
        if [ "${line}" == '' ]; then
            # ${line} value is nul, so skip adding to array
            echo -n '%' | tee -a -i ${logfilepath}
        else
            # ${line} value is NOT nul, so add to array
            
            ALLSPECIFICOBJECTSKEYFIELDARRAY+=("${line}")
            
            echo -n '.' | tee -a -i ${logfilepath}
            
            arraylength=${#ALLSPECIFICOBJECTSKEYFIELDARRAY[@]}
            arrayelement=$((arraylength-1))
            
            if ${APISCRIPTVERBOSE} ; then
                # Verbose mode ON
                # Output list of all hosts found
                echo -n ' '"${line}"', ' | tee -a -i ${logfilepath}
                echo -n "$(eval echo ${line})"', ' >> ${logfilepath}
                echo -n "$arraylength"', ' >> ${logfilepath}
                echo -n "$arrayelement"', ' | tee -a -i ${logfilepath}
                #echo -n "$(eval echo ${ALLHOSTARR[${arrayelement}]})"', ' | tee -a -i ${logfilepath}
            fi
            
            SPECIFICKEYVALUES_COUNT=$(cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"$(eval echo ${line})"'") | ."'${APIobjectspecifickey}'" | length')
            
            NUM_SPECIFIC_KEY_VALUES=${SPECIFICKEYVALUES_COUNT}
            
            if [ x"${NUM_SPECIFIC_KEY_VALUES}" == x"" ] ; then
                # There are null objects, so skip
                if ${APISCRIPTVERBOSE} ; then
                    echo -n 'N, ' | tee -a -i ${logfilepath}
                else
                    echo -n 'N' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            elif [[ ${NUM_SPECIFIC_KEY_VALUES} -lt 1 ]] ; then
                # no objects of this type
                if ${APISCRIPTVERBOSE} ; then
                    echo -n '0, ' | tee -a -i ${logfilepath}
                else
                    echo -n '0' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            elif [[ ${NUM_SPECIFIC_KEY_VALUES} -gt 0 ]] ; then
                # More than zero (1) interfaces, something to process
                if [ ${NUM_SPECIFIC_KEY_VALUES} -gt ${MAXObjectsSpecificKeyValues} ] ; then
                    export MAXObjectsSpecificKeyValues=${NUM_SPECIFIC_KEY_VALUES}
                fi
                
                if ${APISCRIPTVERBOSE} ; then
                    echo -n "${NUM_SPECIFIC_KEY_VALUES}"', ' | tee -a -i ${logfilepath}
                else
                    echo -n "${NUM_SPECIFIC_KEY_VALUES}" | tee -a -i ${logfilepath}
                fi
                SPECIFICOBJECTSKEYFIELDARRAY+=("${line}")
                let SpecificKeyValuesCount=SpecificKeyValuesCount+${NUM_SPECIFIC_KEY_VALUES}
                echo -n '!' | tee -a -i ${logfilepath}
            else
                # ?? Whatever..., so skip
                if ${APISCRIPTVERBOSE} ; then
                    echo -n '?, ' | tee -a -i ${logfilepath}
                else
                    echo -n '?' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            fi
            
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo | tee -a -i ${logfilepath}
            echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
        
    done <<< "${JSON_REPO_NAMES_STRING}"
    errorreturn=$?
    
    echo | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  SpecificKeyValuesCount      = '${SpecificKeyValuesCount} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  MAXObjectsSpecificKeyValues = '${MAXObjectsSpecificKeyValues} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  SpecificKeyValuesCount      = '${SpecificKeyValuesCount} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '  MAXObjectsSpecificKeyValues = '${MAXObjectsSpecificKeyValues} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    export SpecificKeyValuesCount=${SpecificKeyValuesCount}
    
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfSpecificObjectFromJSONRepository procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetArrayOfSpecificKeyValues proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-07:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfSpecificKeyValues generates an array of ${APICLIobjectstype} objects for further processing.

GetArrayOfSpecificKeyValues () {
    
    # MODIFIED 2023-03-07:01 -
    
    errorreturn=0
    
    SPECIFICOBJECTSKEYFIELDARRAY=()
    ALLSPECIFICOBJECTSKEYFIELDARRAY=()
    MAXObjectsSpecificKeyValues=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'GetArrayOfSpecificKeyValues procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Generate array of ' ${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIKeepAlive procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    # -------------------------------------------------------------------------------------------------
    
    ConfigureMgmtCLIOperationalParametersExport
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0  details-level standard -s ${APICLIsessionfile} -f json  | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in mgmt_cli query for .total for '${APICLIobjectstype}' object [ '${objectstoshow}' ]' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    ConfigureJSONRepoFileNamesAndPaths
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in ConfigureJSONRepoFileNamesAndPaths procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckJSONRepoFileObjectTotal procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} ' - Objects to Show :  Simple [ '${objectstoshow}' ] ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' - JSON Repo Total of :  Simple Objects [ '${JSONRepoObjectsTotal}' ] ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DetermineIfDoMgmtCLIQuery procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        echo `${dtzs}`${dtzsep} 'Processing [ '${objectstoshow}' ] '${APICLIobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
        
        PopulateArrayOfSpecificObjectFromMgmtDB
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfSpecificObjectFromMgmtDB procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    else
        # Execute the JSON repository query instead
        
        echo `${dtzs}`${dtzsep} 'Processing [ '${objectstoshow}' ] '${APICLIobjecttype}' objects' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '   from the JSON repository file '${JSONRepoFile} | tee -a -i ${logfilepath}
        
        PopulateArrayOfSpecificObjectFromJSONRepository
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfSpecificObjectFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Final SpecificKeyValuesCount = '${SpecificKeyValuesCount} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Final Specific Object Key Values = ' | tee -a -i ${logfilepath}
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    #echo | tee -a -i ${logfilepath}
    
    echo '['"${SPECIFICOBJECTSKEYFIELDARRAY[@]}"']' | tee -a -i ${logfilepath}
    
    #echo | tee -a -i ${logfilepath}
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'GetArrayOfSpecificKeyValues procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DumpArrayOfSpecificObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfSpecificObjects outputs the array of objects.

DumpArrayOfSpecificObjects () {
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all hosts found
        
        # print the elements in the array
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} Dump All objects | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #
        #for i in "${ALLSPECIFICOBJECTSKEYFIELDARRAY[@]}"
        #do
        #    echo `${dtzs}`${dtzsep} "$i, ${i//\'/}" | tee -a -i ${logfilepath}
        #done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' with '${APIobjectspecifickey}' values defined' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        for j in "${SPECIFICOBJECTSKEYFIELDARRAY[@]}"
        do
            echo `${dtzs}`${dtzsep} "$j, ${j//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Done dumping '${APICLIobjecttype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectSpecificKeyValuesInObjectsFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:02 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectSpecificKeyValuesInObjectsFromMgmtDB outputs the specific key values in an object in the array of objects and collects them into the csv file using the mgmg_cli calls to the Management DB.

CollectSpecificKeyValuesInObjectsFromMgmtDB () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectSpecificKeyValuesInObjectsFromMgmtDB procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIKeepAlive procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    # -------------------------------------------------------------------------------------------------
    
    ConfigureMgmtCLIOperationalParametersExport
    
    # -------------------------------------------------------------------------------------------------
    
    export CSVJQspecifickeyvaluesparmsbase=${CSVJQparms}
    
    export CSVJQspecifickeyvalueserroraddon=
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVJQspecifickeyvalueserroraddon=', true, true'
        if ${APIobjectcansetifexists} ; then
            export CSVJQspecifickeyvalueserroraddon=${CSVJQspecifickeyvalueserroraddon}', true'
        fi
    fi
    
    export CSVJQspecifickeyvaluesparmsbase=${CSVJQparms}${CSVJQspecifickeyvalueserroraddon}
    
    for i in "${SPECIFICOBJECTSKEYFIELDARRAY[@]}"
    do
        
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} Host with interfaces "${objectnametoevaluate}" | tee -a -i ${logfilepath}
        
        SPECIFICKEYVALUES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'" | length')
        
        NUM_SPECIFIC_KEY_VALUES=${SPECIFICKEYVALUES_COUNT}
        
        if [ x"${NUM_SPECIFIC_KEY_VALUES}" == x"" ] ; then
            # There are null objects, so skip
            
            echo `${dtzs}`${dtzsep} 'object:  '${APICLIobjecttype}' '"${objectnametoevaluate}"' number of specific key values = NULL (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_SPECIFIC_KEY_VALUES} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep} 'object:  '${APICLIobjecttype}' '"${objectnametoevaluate}"' number of specific key values = 0 (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_SPECIFIC_KEY_VALUES} -gt 0 ]] ; then
            # More than zero (0) interfaces, something to process
            echo `${dtzs}`${dtzsep} 'object:  '${APICLIobjecttype}' '"${objectnametoevaluate}"' number of specific key values = '"${NUM_SPECIFIC_KEY_VALUES}" | tee -a -i ${logfilepath}
            
            #export CSVJQspecifickeyvaluesparms='"'${objectnametoevaluate}'", '${CSVJQspecifickeyvaluesparmsbase}
            
            #echo `${dtzs}`${dtzsep} 'CSVJQspecifickeyvaluesparms : ' >> ${logfilepath}
            #echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            #echo ${CSVJQspecifickeyvaluesparms} >> ${logfilepath}
            #echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            
            #mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'"[]' | ${JQ} -s '.' | ${JQ} '.[] | [ '"${CSVJQspecifickeyvaluesparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            
            for j in `seq 0 $(expr ${NUM_SPECIFIC_KEY_VALUES} - 1 )`
            do
                sequencenumberformatted=`printf "%03d" ${j}`
                
                GETSPECIFICKEYVALUE=$(mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'"['${j}']')
                
                export SPECIFICKEYVALUE=${GETSPECIFICKEYVALUE}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectSpecificKeyValuesInObjectsFromMgmtDB mgmt_cli execution reading '${APICLIobjecttype}' object '${objectnametoevaluate}' '"${APIobjectspecifickey}"' sequence number: '${j} | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                echo '"'${objectnametoevaluate}'",'${SPECIFICKEYVALUE}${CSVJQspecifickeyvalueserroraddon} >> ${APICLICSVfiledata}
                echo `${dtzs}`${dtzsep} 'Sequence Number [ '${sequencenumberformatted}' ] : "'${objectnametoevaluate}'",'${SPECIFICKEYVALUE}${CSVJQspecifickeyvalueserroraddon} | tee -a -i ${logfilepath}
            done
            
        else
            # ?? Whatever..., so skip
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '"${objectnametoevaluate}"' number of '"${APIobjectspecifickey}"' = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    echo `${dtzs}`${dtzsep} 'CollectSpecificKeyValuesInObjectsFromMgmtDB procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectSpecificKeyValuesInObjectsFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:02 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectSpecificKeyValuesInObjectsFromJSONRepository outputs the host interfaces in a host in the array of host objects and collects them into the csv file using the JSON Repository.

CollectSpecificKeyValuesInObjectsFromJSONRepository () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectSpecificKeyValuesInObjectsFromJSONRepository procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    export CSVJQspecifickeyvaluesparmsbase=${CSVJQparms}
    
    export CSVJQspecifickeyvalueserroraddon=
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVJQspecifickeyvalueserroraddon=', true, true'
        if ${APIobjectcansetifexists} ; then
            export CSVJQspecifickeyvalueserroraddon=${CSVJQspecifickeyvalueserroraddon}', true'
        fi
    fi
    
    export CSVJQspecifickeyvaluesparmsbase=${CSVJQparms}${CSVJQspecifickeyvalueserroraddon}
    
    for i in "${SPECIFICOBJECTSKEYFIELDARRAY[@]}"
    do
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} Host with interfaces "${objectnametoevaluate}" | tee -a -i ${logfilepath}
        
        #SPECIFICKEYVALUES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'" | length')
        SPECIFICKEYVALUES_COUNT=$(cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"${objectnametoevaluate}"'") | ."'${APIobjectspecifickey}'" | length')
        
        NUM_SPECIFIC_KEY_VALUES=${SPECIFICKEYVALUES_COUNT}
        
        if [ x"${NUM_SPECIFIC_KEY_VALUES}" == x"" ] ; then
            # There are null objects, so skip
            
            echo `${dtzs}`${dtzsep} 'object:  '${APICLIobjecttype}' '"${objectnametoevaluate}"' number of specific key values = NULL (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_SPECIFIC_KEY_VALUES} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep} 'object:  '${APICLIobjecttype}' '"${objectnametoevaluate}"' number of specific key values =  0 (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_SPECIFIC_KEY_VALUES} -gt 0 ]] ; then
            # More than zero (0) interfaces, something to process
            echo `${dtzs}`${dtzsep} 'object:  '${APICLIobjecttype}' '"${objectnametoevaluate}"' number of specific key values = '"${NUM_SPECIFIC_KEY_VALUES}" | tee -a -i ${logfilepath}
            
            for j in `seq 0 $(expr ${NUM_SPECIFIC_KEY_VALUES} - 1 )`
            do
                sequencenumberformatted=`printf "%03d" ${j}`
                
                GETSPECIFICKEYVALUE=$(cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"${objectnametoevaluate}"'") | ."'${APIobjectspecifickey}'"['${j}']')
                
                export SPECIFICKEYVALUE=${GETSPECIFICKEYVALUE}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectSpecificKeyValuesInObjectsFromJSONRepository JQ execution reading '${APICLIobjecttype}' object '${objectnametoevaluate}' "'"${APIobjectspecifickey}"'" sequence number: ['${j}']' | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                echo '"'${objectnametoevaluate}'",'${SPECIFICKEYVALUE}${CSVJQspecifickeyvalueserroraddon} >> ${APICLICSVfiledata}
                echo `${dtzs}`${dtzsep} 'Sequence Number [ '${sequencenumberformatted}' ] : "'${objectnametoevaluate}'",'${SPECIFICKEYVALUE}${CSVJQspecifickeyvalueserroraddon} | tee -a -i ${logfilepath}
            done
        else
            # ?? Whatever..., so skip
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '"${objectnametoevaluate}"' number of '"${APIobjectspecifickey}"' = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    echo `${dtzs}`${dtzsep} 'CollectSpecificKeyValuesInObjectsFromJSONRepository procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-14:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectSpecificKeyValuesInObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectSpecificKeyValuesInObjects outputs the host interfaces in a host in the array of host objects and collects them into the csv file.

CollectSpecificKeyValuesInObjects () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectSpecificKeyValuesInObjects procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Use array of '${APICLIobjecttype}' objects to generate '"${APIobjectspecifickey}"' CSV' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    #
    # ${domgmtcliquery} should still be valid from GetArrayOfGenericObjectsByClassWithSpecificKeyValues where we executed the elements to get the values
    # through the use of complex object and generic object specific JSON Repo File checks and related operations.
    #
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        CollectSpecificKeyValuesInObjectsFromMgmtDB
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectSpecificKeyValuesInObjectsFromMgmtDB procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # Execute the JSON repository query instead
        
        CollectSpecificKeyValuesInObjectsFromJSONRepository
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectSpecificKeyValuesInObjectsFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    fi
    
    echo `${dtzs}`${dtzsep} 'CollectSpecificKeyValuesInObjects procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-14:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetObjectSpecificKeyArrayValuesDetailsProcessor proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetObjectSpecificKeyArrayValuesDetailsProcessor generate output of objects specific key values from existing objects with specific key values objects

GetObjectSpecificKeyArrayValuesDetailsProcessor () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'GetObjectSpecificKeyArrayValuesDetailsProcessor procedure Starting...' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    # Assumes that ${ExportTypeIsStandard} true
    
    export SpecificKeyValuesCount=0
    
    # MODIFIED 2021-01-28 -
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        if ${APIobjectcansetifexists} ; then
            export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
            export CSVJQparms=${CSVJQparms}', true'
        fi
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    SetupExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SetupExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    GetArrayOfSpecificKeyValues
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in GetArrayOfSpecificKeyValues procedure' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    if [ x"${SpecificKeyValuesCount}" == x"" ] ; then
        # There are null objects, so skip
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! No application-sites found - NULL' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    elif [[ ${SpecificKeyValuesCount} -lt 1 ]] ; then
        # no objects of this type
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! No application-sitesfound - 0' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    elif [[ ${SpecificKeyValuesCount} -gt 0 ]] ; then
        # We have host interfaces to process
        
        # -------------------------------------------------------------------------------------------------
        
        DumpArrayOfSpecificObjects
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DumpArrayOfSpecificObjects procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
        CollectSpecificKeyValuesInObjects
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectSpecificKeyValuesInObjects procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
        FinalizeExportComplexObjectsToCSVviaJQ
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
    else
        # No host interfaces
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! No '${APICLIcomplexobjectstype}' found' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'GetObjectSpecificKeyArrayValuesDetailsProcessor procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetObjectSpecificKeyArrayValues proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetObjectSpecificKeyArrayValues generate output of host's interfaces from existing hosts with interface objects using the processor

GetObjectSpecificKeyArrayValues () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    # ADDED 2022-12-21 -
    if ${APIobjectexportisCPI} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' has Critical Performance Impact, APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        if ! ${ExportCritPerfImpactObjects} ; then
            echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
            
            return 0
        else
            echo `${dtzs}`${dtzsep} 'Critical Performance Impact (CPI) Override is active!  ExportCritPerfImpactObjects = '${ExportCritPerfImpactObjects} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does not have Critical Performance Impact(CPI), APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if ${ExportTypeIsStandard} ; then
        
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2023-03-04:01 -
        #
        
        DumpObjectDefinitionData
        
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2022-09-16:01 -
        # Account for whether the original object definition is for REFERENCE, NO IMPORT already
        
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${OnlySystemObjects} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}
        fi
        
        objectstotal_object=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_object="${objectstotal_object}"
        
        if [ ${number_object} -le 0 ] ; then
            # No ${APICLIobjectstype} found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate '${APICLIcomplexobjectstype}' members from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            GetObjectSpecificKeyArrayValuesDetailsProcessor
            errorreturn=$?
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Not "standard" Export Type :  '${TypeOfExport}' so do not handle '${APICLIcomplexobjectstype}' for '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error !{ '${errorreturn}' }! in GetObjectSpecificKeyArrayValuesDetailsProcessor procedure' | tee -a -i ${logfilepath}
        
        if ${ABORTONERROR} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            return ${errorreturn}
        fi
    else
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Specific Complex OBJECT - Object Specific Keys with Value arrays Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : application-sites
# |  - Reference Details, APIobjectdoX set to "false" to disable
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=application-sites
export APICLIcomplexobjectstype=application-sites
export APIobjectminversion=1.1
export APIobjectexportisCPI=true

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=false
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=false
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export AugmentExportedFields=false

if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export AugmentExportedFields=true
elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    export AugmentExportedFields=true
elif ${OnlySystemObjects} ; then
    export AugmentExportedFields=true
else
    export AugmentExportedFields=false
fi

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
if ! ${AugmentExportedFields} ; then
    export CSVFileHeader='"primary-category"'
    # The risk key is not imported
    #export CSVFileHeader=${CSVFileHeader}',"risk"'
else
    export CSVFileHeader='"application-id","primary-category"'
    # The risk key is not imported
    export CSVFileHeader=${CSVFileHeader}',"risk"'
fi
export CSVFileHeader=${CSVFileHeader}',"urls-defined-as-regular-expression"'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVFileHeader=${CSVFileHeader}',"user-defined"'
fi
export CSVFileHeader=${CSVFileHeader}',"url-list.0"'
# The next elements are more complex elements, but required for import add operation
if ${AugmentExportedFields} ; then
    export CSVFileHeader=${CSVFileHeader}',"url-list.1"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.2"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.3"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.4"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.5"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.6"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.7"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.8"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.9"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.10"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.11"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.12"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.13"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.14"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.15"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.16"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.17"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.18"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.19"'
fi
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
if ${AugmentExportedFields} ; then
    # The next elements are more complex elements, but NOT required for import add operation
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.1"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.2"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.3"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.4"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.5"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.6"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.7"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.8"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.9"'
fi
export CSVFileHeader=${CSVFileHeader}',"application-signature"'
export CSVFileHeader=${CSVFileHeader}',"description"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
if ! ${AugmentExportedFields} ; then
    export CSVJQparms='.["primary-category"]'
    # The risk key is not imported
    #export CSVJQparms=${CSVJQparms}', .["risk"]'
else
    export CSVJQparms='.["application-id"], .["primary-category"]'
    # The risk key is not imported
    export CSVJQparms=${CSVJQparms}', .["risk"]'
fi
export CSVJQparms=${CSVJQparms}', .["urls-defined-as-regular-expression"]'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVJQparms=${CSVJQparms}', .["user-defined"]'
fi
export CSVJQparms=${CSVJQparms}', .["url-list"][0]'
# The next elements are more complex elements, but required for import add operation
if ${AugmentExportedFields} ; then
    export CSVJQparms=${CSVJQparms}', .["url-list"][1]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][2]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][3]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][4]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][5]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][6]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][7]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][8]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][9]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][10]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][11]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][12]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][13]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][14]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][15]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][16]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][17]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][18]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][19]'
fi
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
if ${AugmentExportedFields} ; then
    # The next elements are more complex elements, but NOT required for import add operation
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][1]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][2]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][3]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][4]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][5]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][6]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][7]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][8]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][9]'
fi
export CSVJQparms=${CSVJQparms}', .["application-signature"]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : application-sites - url-list
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=application-site-element-url-list
export APICLIcomplexobjectstype=application-sites-elements-url-lists
export APIobjectminversion=1.1
export APIobjectexportisCPI=true

export APIobjectspecifickey='url-list'

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false


#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader=${CSVFileHeader}'"name","url-list.add"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}'.["name"], .["url-list"][${j}]'
export CSVJQparms=${CSVJQparms}'.["name"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-16:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        objectstotal_complex_objects=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_complex_objects="${objectstotal_complex_objects}"
        export number_of_objects=${number_complex_objects}
        
        if [ ${number_application_sites} -le 0 ] ; then
            # No hosts found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APICLIobjecttype}' to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            # hosts found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Check '${APICLIobjecttype}' with [ '${number_of_objects}' ] object to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            GetObjectSpecificKeyArrayValues
        fi
        
        ;;
    # a "name-only" export operation
    #'name-only' )
    # a "name-and-uid" export operation
    #'name-and-uid' )
    # a "uid-only" export operation
    #'uid-only' )
    # a "rename-to-new-nam" export operation
    #'rename-to-new-name' )
    # Anything unknown is handled as "standard"
    * )
        echo `${dtzs}`${dtzsep} 'Skipping '"'${APICLIobjectstype}" "${APICLIexportnameaddon}"'for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        ;;
esac

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-16:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : application-sites - application-signature
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype=application-site
#export APICLIobjectstype=application-sites
#export APICLIcomplexobjecttype=application-site-element-application-signature
#export APICLIcomplexobjectstype=application-sites-elements-application-signatures
#export APIobjectminversion=1.1
#export APIobjectexportisCPI=true

#export APIobjectspecifickey='application-signature'

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#export APIobjectjsonrepofileobject=${APICLIobjectstype}
#export APICLICSVobjecttype=${APICLIcomplexobjectstype}

#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

#export APIobjectdoexport=true
#export APIobjectdoexportJSON=false
#export APIobjectdoexportCSV=true
#export APIobjectdoimport=true
#export APIobjectdorename=false
#export APIobjectdoupdate=false
#export APIobjectdodelete=false

#export APIobjectusesdetailslevel=true
#export APIobjectcanignorewarning=true
#export APIobjectcanignoreerror=true
#export APIobjectcansetifexists=false
#export APIobjectderefgrpmem=false
#export APIobjecttypehasname=true
#export APIobjecttypehasuid=true
#export APIobjecttypehasdomain=true
#export APIobjecttypehastags=true
#export APIobjecttypehasmeta=true
#export APIobjecttypeimportname=true

#export APIobjectCSVFileHeaderAbsoluteBase=false
#export APIobjectCSVJQparmsAbsoluteBase=false

#export APIobjectCSVexportWIP=false

##
## APICLICSVsortparms can change due to the nature of the object
##
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}'"name","application-signature"'
##export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
##export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
##export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
#export CSVJQparms=${CSVJQparms}'.["name"], .["application-signature"]'
##export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
##export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
##export CSVJQparms=${CSVJQparms}', .["icon"]'

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-16:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#case "${TypeOfExport}" in
    ## a "Standard" export operation
    #'standard' )
        #objectstotal_complex_objects=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        #export number_complex_objects="${objectstotal_complex_objects}"
        #export number_of_objects=${number_complex_objects}
        
        #if [ ${number_application_sites} -le 0 ] ; then
            ## No hosts found
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} 'No '${APICLIobjecttype}' to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #else
            ## hosts found
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} 'Check '${APICLIobjecttype}' with [ '${number_of_objects}' ] object to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            #GetObjectSpecificKeyArrayValues
        #fi
        
        #;;
    ## a "name-only" export operation
    ##'name-only' )
    ## a "name-and-uid" export operation
    ##'name-and-uid' )
    ## a "uid-only" export operation
    ##'uid-only' )
    ## a "rename-to-new-nam" export operation
    ##'rename-to-new-name' )
    ## Anything unknown is handled as "standard"
    #* )
        #echo `${dtzs}`${dtzsep} 'Skipping '"'${APICLIobjectstype}" "${APICLIexportnameaddon}"'for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        #;;
#esac

#echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
#echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-16:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : application-sites - additional-categories
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=application-site-element-additional-category
export APICLIcomplexobjectstype=application-sites-elements-additional-categories
export APIobjectminversion=1.1
export APIobjectexportisCPI=true

export APIobjectspecifickey='additional-categories'

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader=${CSVFileHeader}'"name","additional-categories.add"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}'.["name"], .["additional-categories"][${j}]'
export CSVJQparms=${CSVJQparms}'.["name"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-16:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        objectstotal_complex_objects=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_complex_objects="${objectstotal_complex_objects}"
        export number_of_objects=${number_complex_objects}
        
        if [ ${number_application_sites} -le 0 ] ; then
            # No hosts found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APICLIobjecttype}' to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            # hosts found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Check '${APICLIobjecttype}' with [ '${number_of_objects}' ] object to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            GetObjectSpecificKeyArrayValues
        fi
        
        ;;
    # a "name-only" export operation
    #'name-only' )
    # a "name-and-uid" export operation
    #'name-and-uid' )
    # a "uid-only" export operation
    #'uid-only' )
    # a "rename-to-new-nam" export operation
    #'rename-to-new-name' )
    # Anything unknown is handled as "standard"
    * )
        echo `${dtzs}`${dtzsep} 'Skipping '"'${APICLIobjectstype}" "${APICLIexportnameaddon}"'for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        ;;
esac

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-16:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Specific Complex OBJECT : users authentications
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex OBJECT : users authentications' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}



# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Specific Complex OBJECT : users authentications Handling Procedures
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:01 -


# -------------------------------------------------------------------------------------------------
# ConfigureCriteriaBasedObjectQuerySelector
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-06:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ConfigureCriteriaBasedObjectQuerySelector () {
    #
    # Configure Query Selector for Criteria based exports
    #
    
    errorreturn=0
    
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'XX' "${XX}" >> ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------'  >>  ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Configure Criteria Based Object QuerySelector     : '  >>  ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------'  >>  ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} '-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -'  >>  ${logfilepath}
    
    # MODIFIED 2023-03-06:01 -
    
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} '-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -'  >>  ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Configure object criteria 01 selection query elements objecttypecriteriaselectorelement
    # -------------------------------------------------------------------------------------------------
    
    #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" == "'"${APICLIexportcriteria01value}"'"'
    # For the Boolean values of ${APICLIexportcriteria01value} we need to check that the text value is true or folse, to be specific
    if [ "${APICLIexportcriteria01value}" == "true" ] ; then 
        # The value of ${APICLIexportcriteria01value} is boolean true, so check if the value of ${APICLIexportcriteria01key} is true
        export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'"' 
    elif [ "${APICLIexportcriteria01value}" == "false" ] ; then 
        # The value of ${APICLIexportcriteria01value} is boolean false, so check if the value of ${APICLIexportcriteria01key} is not true
        export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" | not'
    else 
        # The value of ${APICLIexportcriteria01value} is a string, not boolean, so check if the value of ${APICLIexportcriteria01key} is the same
        export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" == "'"${APICLIexportcriteria01value}"'"'
    fi
    
    printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'APICLIexportcriteria01key' ${APICLIexportcriteria01key} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'APICLIexportcriteria01value' ${APICLIexportcriteria01value} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'objecttypecriteriaselectorelement' ${objecttypecriteriaselectorelement} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'objecttypeselectorelement' ${objecttypecriteriaselectorelement} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    # MODIFIED 2023-03-06:01 -
    #
    # THIS SECTION SHOULD NOT BE MODIFIED OR SIMPLIFIED TO ENSURE OPERATION AS EXPECT!
    #
    # -------------------------------------------------------------------------------------------------
    
    # We need to assemble a more complicated selection method for this
    #
    export userauthobjectselector='select( '
    
    printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" ' - userauthobjectselector' ${userauthobjectselector} >> ${logfilepath}
    
    if [ x"${objecttypeselectorelement}" != x"" ] ; then
        #export userauthobjectselector=${userauthobjectselector}'( '"${objecttypeselectorelement}"' ) and ( '
        export userauthobjectselector=${userauthobjectselector}'( '"${objecttypeselectorelement}"' ) and '
    fi
    
    printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" ' - userauthobjectselector' ${userauthobjectselector} >> ${logfilepath}
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        export userauthobjectselector=${userauthobjectselector}'( '"${systemobjectqueryselectorelement}"' ) and ( '"${objecttypecriteriaselectorelement}"' )'
    elif ${OnlySystemObjects} ; then
        # Ignore System Objects
        export userauthobjectselector=${userauthobjectselector}'( '"${systemobjectqueryselectorelement}"' ) and ( '"${objecttypecriteriaselectorelement}"' )'
    elif ${CreatorIsNotSystem} ; then
        # Ignore System Objects
        export userauthobjectselector=${userauthobjectselector}'( '"${systemobjectqueryselectorelement}"' ) and ( '"${objecttypecriteriaselectorelement}"' )'
    elif ${CreatorIsSystem} ; then
        # Ignore System Objects
        export userauthobjectselector=${userauthobjectselector}'( '"${systemobjectqueryselectorelement}"' ) and ( '"${objecttypecriteriaselectorelement}"' )'
    else
        # Don't Ignore System Objects
        export userauthobjectselector=${userauthobjectselector}'( '"${objecttypecriteriaselectorelement}"' )'
    fi
    printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" ' - userauthobjectselector' ${userauthobjectselector} >> ${logfilepath}
    
    #if [ x"${objecttypeselectorelement}" != x"" ] ; then
        #export userauthobjectselector=${userauthobjectselector}' )'
    #fi
    
    export userauthobjectselector=${userauthobjectselector}' )'
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'FINAL - userauthobjectselector' ${userauthobjectselector} >> ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------'  >>  ${logfilepath}
    echo `${dtzs}`${dtzsep} 'ConfigureCriteriaBasedObjectQuerySelector procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------'  >>  ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ExportObjectElementCriteriaBasedToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportObjectElementCriteriaBasedToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjectstype} item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectElementCriteriaBasedToCSVviaJQ () {
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} 'Start ExportObjectElementCriteriaBasedToCSVviaJQ ' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    # MODIFIED 2021-10-22 -
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        if ${APIobjectcansetifexists} ; then
            export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
            export CSVJQparms=${CSVJQparms}', true'
        fi
    fi
    
    SetupExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem found in procedure SetupExportComplexObjectsToCSVviaJQ! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # MODIFIED 2022-07-12:01 -
    
    export WorkingAPICLIdetaillvl='full'
    
    ConfigureMgmtCLIOperationalParametersExport
    
    # -------------------------------------------------------------------------------------------------
    # Configure object criteria 01 selection query ${userauthobjectselector} 
    # -------------------------------------------------------------------------------------------------
    
    export userauthobjectselector=
    
    ConfigureCriteriaBasedObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    # Start processing
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Populate up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentuseroffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Selection criteria '${userauthobjectselector} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-09-14:01 -
    
    CheckAPIKeepAlive
    
    # MODIFIED 2022-09-14:01 -
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    ConfigureMgmtCLIOperationalParametersExport
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    export objectstoshow=${objectstotal}
    
    # MODIFIED 2022-07-12:01 -
    
    export JSONRepoObjectsTotal=
    
    CheckJSONRepoFileObjectTotal 
    errorreturn=$?
    
    # MODIFIED 2022-07-12:01 -
    
    export domgmtcliquery=false
    
    DetermineIfDoMgmtCLIQuery
    errorreturn=$?
    
    export currentuseroffset=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        echo `${dtzs}`${dtzsep} "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
        
        export objectslefttoshow=${objectstoshow}
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Export ${APICLIobjectstype} to CSV File" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "  and dump to ${APICLICSVfile}" | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo `${dtzs}`${dtzsep} "  mgmt_cli parameters : ${MgmtCLI_Show_OpParms}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  CSVJQparms' - ${CSVJQparms} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} "  User Authentication Selector : "${userauthobjectselector} | tee -a -i ${logfilepath}
        fi
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        while [ ${objectslefttoshow} -ge 1 ] ; do
            # we have objects to process
            echo `${dtzs}`${dtzsep} "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentuseroffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
            
            #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentuseroffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            #errorreturn=$?
            
            #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentuseroffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${userauthobjectselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            #errorreturn=$?
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentuseroffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentuseroffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLICSVfiledatalast} >> ${logfilepath}
            fi
            
            mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentuseroffset} ${MgmtCLI_Show_OpParms} > ${APICLICSVfiledatalast}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLICSVfiledatalast}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                cat ${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            cat ${APICLICSVfiledatalast} | ${JQ} '.objects[] | '"${userauthobjectselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            
            export objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
            export currentuseroffset=`expr ${currentuseroffset} + ${WorkAPIObjectLimit}`
        done
        
    else
        # Execute the JSON repository query instead
        
        echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APICLIobjecttype}' objects from the JSON repository file '${JSONRepoFile} | tee -a -i ${logfilepath}
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Export ${APICLIobjectstype} to CSV File" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "  and dump to ${APICLICSVfile}" | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo `${dtzs}`${dtzsep} "  mgmt_cli parameters : ${MgmtCLI_Show_OpParms}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  CSVJQparms' - ${CSVJQparms} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} "  User Authentication Selector : "${userauthobjectselector} | tee -a -i ${logfilepath}
        fi
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${userauthobjectselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Problem during JSON Repository file query operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents (first 3 and last 10 lines) with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            head -n 3 ${APICLICSVfiledata} | tee -a -i ${logfilepath}
            echo '...' | tee -a -i ${logfilepath}
            tail ${APICLICSVfiledata} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem found in procedure FinalizeExportComplexObjectsToCSVviaJQ! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
        
        return ${errorreturn}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-02-25:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetObjectElementCriteriaBased proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetObjectElementCriteriaBased generate output of host's interfaces from existing hosts with interface objects

GetObjectElementCriteriaBased () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ${ExportTypeIsStandard} ; then
        
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2023-03-04:01 -
        #
        
        DumpObjectDefinitionData
        
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2022-09-16:01 -
        # Account for whether the original object definition is for REFERENCE, NO IMPORT already
        
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${OnlySystemObjects} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}
        fi
        
        ExportObjectElementCriteriaBasedToCSVviaJQ
        errorreturn=$?
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
        fi
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in ExportObjectElementCriteriaBasedToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} ' Contents of file '${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-   --  --  --  --  --  --  --  --  --   --  --  --  --  --  --  --  --  --   -' | tee -a -i ${logfilepath}
            cat ${APICLICSVfiledatalast} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-   --  --  --  --  --  --  --  --  --   --  --  --  --  --  --  --  --  --   -' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
        fi
        
        echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Not "standard" Export Type :  '${TypeOfExport}' so do not handle complex objects '${APICLIcomplexobjectstype}' for '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        if ${ABORTONERROR} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            return ${errorreturn}
        fi
    else
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Specific Complex OBJECT : users authentications Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more Specific Complex Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


# MODIFIED 2021-02-24 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Specific Complex Objects - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-24


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Complex Object via Generic-Objects Handlers
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

# MODIFIED 2023-01-06:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Complex Object via Generic-Objects Handlers - '${scriptactiondescriptor}' Starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-01-06:01


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Complex Object via Generic-Objects Handlers' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Complex Object via Generic-Objects Common Procedures and Handlers
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-07:01 -


# -------------------------------------------------------------------------------------------------
# CommonGenericObjectsHandlersInitialSetup01
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The CommonGenericObjectsHandlersInitialSetup01 is Common routine for Generic Objects Handlers for Initialization - 01.
#

CommonGenericObjectsHandlersInitialSetup01 () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CommonGenericObjectsHandlersInitialSetup01 procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIKeepAlive procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    # -------------------------------------------------------------------------------------------------
    
    ConfigureMgmtCLIOperationalParametersExport
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'CommonGenericObjectsHandlersInitialSetup01 procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01

# -------------------------------------------------------------------------------------------------

#CommonGenericObjectsHandlersInitialSetup01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery is Common routine for Generic Objects Handlers for .
#

CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    genericobjectstotal=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    export objectstoshowgenericobject=${genericobjectstotal}
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in mgmt_cli query for .total for '${APIGenObjectTypes}' '${APIGenObjectClassField}' '"${APIGenObjectClass}"' object [ '${objectstoshowgenericobject}' ]' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    ConfigureGenericObjectJSONRepoFileNamesAndPaths
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in ConfigureGenericObjectJSONRepoFileNamesAndPaths procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    export JSONRepoAPIGenObjectsTotal=
    
    CheckJSONRepoFileAPIGenericObjectTotal
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckJSONRepoFileAPIGenericObjectTotal procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    export domgmtcliquerygenericobject=false
    
    DetermineIfDoMgmtCLIQueryGenericObject
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DetermineIfDoMgmtCLIQuery procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01

# -------------------------------------------------------------------------------------------------

#CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery is Common routine for Generic Objects Handlers for .
#

CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery () {
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    #
    # There should be the same number of entries in the JSON Repository file for the ${APICLIcomplexobjectstype} as for the ${APIGenObjobjectstype} if we have good JSON data!
    #
    # So set the value of ${objectstoshowcomplexobject} to the same value as ${objectstoshowgenericobject} since we DO NOT want the potential full number of actual ${APICLIobjectstype},
    # which could be very different than the Generic Object collected subset.
    #
    # CheckJSONRepoFileComplexObjectTotal generates the number of ${JSONRepoComplexObjectsTotal} which is the value we need for ${objectstoshowcomplexobject}, 
    # but we are going to compare ${objectstoshowcomplexobject} to ${JSONRepoComplexObjectsTotal} next in DetermineIfDoMgmtCLIQueryComplexObject
    #
    
    export objectstoshowcomplexobject=${objectstoshowgenericobject}
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    ConfigureComplexObjectJSONRepoFileNamesAndPaths
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in ConfigureComplexObjectJSONRepoFileNamesAndPaths procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    export JSONRepoComplexObjectsTotal=
    
    CheckJSONRepoFileComplexObjectTotal
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckJSONRepoFileComplexObjectTotal procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} ' - Objects to Show :  Complex [ '${objectstoshowcomplexobject}' ] and Generic [ '${objectstoshowgenericobject}' ] ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' - JSON Repo Total of :  Complex Objects [ '${JSONRepoComplexObjectsTotal}' ] and Generic Objects [ '${JSONRepoAPIGenObjectsTotal}' ] ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    export domgmtcliquerycomplexobject=false
    
    DetermineIfDoMgmtCLIQueryComplexObject
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DetermineIfDoMgmtCLIQueryComplexObject procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01

# -------------------------------------------------------------------------------------------------

#CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-07:02 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery is Common routine for Generic Objects Handlers for .
#

CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery () {
    #
    # Expected configured key input values
    #
    # ${domgmtcliquerygenericobject}
    # ${domgmtcliquerycomplexobject}
    # ${objectstoshowgenericobject}
    # ${objectstoshowcomplexobject}
    #
    # Output values:
    #
    # ${domgmtcliquery}
    # ${genericobjectjsonrepoOK}
    # ${complexobjectjsonrepoOK}
    # ${errorreturn}
    #
    
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Need some critical error checking if this is to work!
    
    forcecrashandburn=false
    
    if [ -z ${domgmtcliquerygenericobject} ] ; then
        # Missing parameter domgmtcliquerygenericobject, which is not set, so document, crash and burn
        
        if ! ${forcecrashandburn} ; then echo `${dtzs}`${dtzsep} '!!!!  OPERATIONAL SCRIPT IMPLEMENTATION ERROR !!!!' | tee -a -i ${logfilepath} ; fi
        forcecrashandburn=true
        echo `${dtzs}`${dtzsep} '!!!!  VARIABLE domgmtcliquerygenericobject is NOT SET [ '${domgmtcliquerygenericobject}' ] !!!!' | tee -a -i ${logfilepath}
    fi
    
    if [ -z ${domgmtcliquerycomplexobject} ] ; then
        # Missing parameter domgmtcliquerycomplexobject, which is not set, so document, crash and burn
        
        if ! ${forcecrashandburn} ; then echo `${dtzs}`${dtzsep} '!!!!  OPERATIONAL SCRIPT IMPLEMENTATION ERROR !!!!' | tee -a -i ${logfilepath} ; fi
        forcecrashandburn=true
        echo `${dtzs}`${dtzsep} '!!!!  VARIABLE domgmtcliquerycomplexobject is NOT SET [ '${domgmtcliquerycomplexobject}' ] !!!!' | tee -a -i ${logfilepath}
    fi
    
    if [ -z ${objectstoshowgenericobject} ] ; then
        # Missing parameter objectstoshowgenericobject, which is not set, so document, crash and burn
        
        if ! ${forcecrashandburn} ; then echo `${dtzs}`${dtzsep} '!!!!  OPERATIONAL SCRIPT IMPLEMENTATION ERROR !!!!' | tee -a -i ${logfilepath} ; fi
        forcecrashandburn=true
        echo `${dtzs}`${dtzsep} '!!!!  VARIABLE objectstoshowgenericobject is NOT SET [ '${objectstoshowgenericobject}' ] !!!!' | tee -a -i ${logfilepath}
    fi
    
    if [ -z ${objectstoshowcomplexobject} ] ; then
        # Missing parameter objectstoshowcomplexobject, which is not set, so document, crash and burn
        
        if ! ${forcecrashandburn} ; then echo `${dtzs}`${dtzsep} '!!!!  OPERATIONAL SCRIPT IMPLEMENTATION ERROR !!!!' | tee -a -i ${logfilepath} ; fi
        forcecrashandburn=true
        echo `${dtzs}`${dtzsep} '!!!!  VARIABLE objectstoshowcomplexobject is NOT SET [ '${objectstoshowcomplexobject}' ] !!!!' | tee -a -i ${logfilepath}
    fi
    
    if ${forcecrashandburn} ; then 
        echo `${dtzs}`${dtzsep} '!!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!!  CRITICAL INFORMATION REQUIRED TO OPERATE IS MISSING IN SCRIPT, CONTACT DEVELOPER !!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!!  PROCEDURE:  CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery !!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!!  OPERATIONAL SCRIPT IMPLEMENTATION ERROR -- EXITING !!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        exit 212
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    # There is some more logic required to determine if we can do a JSON Repo File based operation given the need for using two files the generic object and the complex object files.
    
    export domgmtcliquery=false
    
    if ${domgmtcliquerycomplexobject} ; then
        export complexobjectjsonrepoOK=false
    else
        export complexobjectjsonrepoOK=true
    fi
    
    if ${domgmtcliquerygenericobject} ; then
        export genericobjectjsonrepoOK=false
    else
        export genericobjectjsonrepoOK=true
    fi
    
    if [[ ${complexobjectjsonrepoOK} && ${genericobjectjsonrepoOK} ]] ; then
        echo `${dtzs}`${dtzsep} ' - Complex Object and Generic Object Repository Files are OK and no issues with values!' >> ${logfilepath}
        if [ ${objectstoshowcomplexobject} -ne ${objectstoshowgenericobject} ] ; then
            echo `${dtzs}`${dtzsep} '  -- Count of Complex Objects [ '${objectstoshowcomplexobject}' ] and Generic Objects [ '${objectstoshowgenericobject}' ] IS equal so no problem with doing the JSON Repository operation!' >> ${logfilepath}
            export domgmtcliquery=true
        else
            echo `${dtzs}`${dtzsep} '  -- Count of Complex Objects [ '${objectstoshowcomplexobject}' ] and Generic Objects [ '${objectstoshowgenericobject}' ] IS NOT equal so a problem with doing the JSON Repository operation!' >> ${logfilepath}
            export domgmtcliquery=false
        fi
    else
        echo `${dtzs}`${dtzsep} ' - Complex Object or Generic Object Repository Files is NOT OK so a problem with doing the JSON Repository operation!' >> ${logfilepath}
        export domgmtcliquery=true
    fi
    
    echo `${dtzs}`${dtzsep} ' - Value of domgmtcliquery = [ '${domgmtcliquery}' ], Count of Complex Objects [ '${objectstoshowcomplexobject}' ] and Generic Objects [ '${objectstoshowgenericobject}' ] ' | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:02

# -------------------------------------------------------------------------------------------------

#CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Complex Object via Generic-Objects Common Procedures and Handlers
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Complex Object via Generic-Objects Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2023-01-06 -
# MODIFIED 2023-03-07:01 -


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfGenericObjectsByClassFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfGenericObjectsByClassFromMgmtDB generates an array of objects type objects for further processing.

PopulateArrayOfGenericObjectsByClassFromMgmtDB () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfGenericObjectsByClassFromMgmtDB procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-04:01 - 
    # System Object selection operands
    # Current alternative if more options to exclude are needed
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    
    #export APIGenObjectTypes=generic-objects
    #export APIGenObjectClassField=class-name
    #export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
    #export APIGenObjectField=uid
    
    export currentobjecttypesoffset=0
    export genericobjectslefttoshow=0
    
    export genericobjectslefttoshow=${objectstoshowgenericobject}
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}"' - Populate up to next '${WorkAPIObjectLimit}' [ "'${APIGenObjectField}'" ] fields starting with object '${currentobjecttypesoffset}' of '${genericobjectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '   --  Using Object Query Selector "'${objectqueryselector}'"' | tee -a -i ${logfilepath}
    
    while [ ${genericobjectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        
        echo `${dtzs}`${dtzsep} '   - Now processing up to next '${WorkAPIObjectLimit}' '${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}"' objects starting with object '${currentobjecttypesoffset}' of '${genericobjectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
        if [ x"${objectqueryselector}" != x"" ] ; then
            MGMT_CLI_GENERICOBJECTSFIELD_STRING="`mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level ${APIGenObjobjectkeydetailslevel} -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .'"${APIGenObjectField}"' | @sh' -r`"
        else
            MGMT_CLI_GENERICOBJECTSFIELD_STRING="`mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level ${APIGenObjobjectkeydetailslevel} -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | .'"${APIGenObjectField}"' | @sh' -r`"
        fi
        
        # break the string into an array - each element of the array is a line in the original string
        # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
        
        echo -n `${dtzs}`${dtzsep} '   --  Read Generic-Objects [ "'${APIGenObjectField}'" ] fields into array:  ' | tee -a -i ${logfilepath}
        
        while read -r line; do
            if [ "${line}" == '' ]; then
                # ${line} value is nul, so skip adding to array
                echo -n '%' | tee -a -i ${logfilepath}
            else
                # ${line} value is NOT nul, so add to array
                GENERICOBJECTSKEYFIELDARRAY+=("${line}")
                echo -n '.' | tee -a -i ${logfilepath}
            fi
        done <<< "${MGMT_CLI_GENERICOBJECTSFIELD_STRING}"
        errorreturn=$?
        
        echo | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
        export genericobjectslefttoshow=`expr ${genericobjectslefttoshow} - ${WorkAPIObjectLimit}`
        export currentobjecttypesoffset=`expr ${currentobjecttypesoffset} + ${WorkAPIObjectLimit}`
        
        CheckAPIKeepAlive
        
    done
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfGenericObjectsByClassFromMgmtDB procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfGenericObjectsByClassFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfGenericObjectsByClassFromJSONRepository generates an array of objects type objects from the JSON Repository file for further processing.

PopulateArrayOfGenericObjectsByClassFromJSONRepository () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfGenericObjectsByClassFromJSONRepository procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-04:01 - 
    # System Object selection operands
    # Current alternative if more options to exclude are needed
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    
    #export APIGenObjectTypes=generic-objects
    #export APIGenObjectClassField=class-name
    #export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
    #export APIGenObjectField=uid
    
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}"' - Populate up to this number ['${JSONRepoObjectsTotal}'] of [ "'${APIGenObjectField}'" ] fields' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '   --  Using Object Query Selector "'${objectqueryselector}'"' | tee -a -i ${logfilepath}
    
    if [ x"${objectqueryselector}" != x"" ] ; then
        JSON_REPO_GENERICOBJECTSFIELD_STRING="`cat ${JSONRepoAPIGenObjectFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .'"${APIGenObjectField}"' | @sh' -r`"
    else
        JSON_REPO_GENERICOBJECTSFIELD_STRING="`cat ${JSONRepoAPIGenObjectFile} | ${JQ} '.objects[] | .'"${APIGenObjectField}"' | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} '   --  Read Generic-Objects [ "'${APIGenObjectField}'" ] fields into array:  ' | tee -a -i ${logfilepath}
    
    while read -r line; do
        if [ "${line}" == '' ]; then
            # ${line} value is nul, so skip adding to array
            echo -n '%' | tee -a -i ${logfilepath}
        else
            # ${line} value is NOT nul, so add to array
            GENERICOBJECTSKEYFIELDARRAY+=("${line}")
            echo -n '.' | tee -a -i ${logfilepath}
        fi
    done <<< "${JSON_REPO_GENERICOBJECTSFIELD_STRING}"
    errorreturn=$?
    
    echo | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfGenericObjectsByClassFromJSONRepository procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DumpArrayOfGenericObjectsKeyFieldValues proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfGenericObjectsKeyFieldValues outputs the array of generic objects names.

DumpArrayOfGenericObjectsKeyFieldValues () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'DumpArrayOfGenericObjectsKeyFieldValues procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all objects found
        
        # print the elements in the array
        echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Dump '${APIGenObjobjecttype}' names for generating '${APICLIcomplexobjectstype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        for i in "${GENERICOBJECTSKEYFIELDARRAY[@]}"
        do
            echo `${dtzs}`${dtzsep} "${i}, ${i//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Done dumping '${APIGenObjobjecttype}' names for generating '${APICLIcomplexobjectstype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
    fi
    
    echo `${dtzs}`${dtzsep} 'DumpArrayOfGenericObjectsKeyFieldValues procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetArrayOfComplexObjectsFromGenericObjectsFieldByKey proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfComplexObjectsFromGenericObjectsFieldByKey generates an array of objects type objects for further processing.

GetArrayOfComplexObjectsFromGenericObjectsFieldByKey () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    errorreturn=0
    
    export GENERICOBJECTSKEYFIELDARRAY=()
    export ObjectsOfTypeToProcess=false
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'GetArrayOfComplexObjectsFromGenericObjectsFieldByKey procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Generate array of '${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" ${APIGenObjectField}' fields' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-07:02 -
    
    # Script simplification for common operations among Complex Objects via Generic Objects procedures
    
    #CommonGenericObjectsHandlersInitialSetup01
    #CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
    #CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
    #CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    CommonGenericObjectsHandlersInitialSetup01
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CommonGenericObjectsHandlersInitialSetup01 procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        echo `${dtzs}`${dtzsep} 'Processing [ '${objectstoshowgenericobject}' ] '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
        
        PopulateArrayOfGenericObjectsByClassFromMgmtDB
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfGenericObjectsByClassFromMgmtDB procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # Execute the JSON repository query instead
        
        echo `${dtzs}`${dtzsep} 'Processing [ '${JSONRepoAPIGenObjectsTotal}' : '${objectstoshowgenericobject}' ] '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" objects' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  - From the JSON repository file '${JSONRepoAPIGenObjectFile} | tee -a -i ${logfilepath}
        
        PopulateArrayOfGenericObjectsByClassFromJSONRepository
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfGenericObjectsByClassFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${#GENERICOBJECTSKEYFIELDARRAY[@]} -ge 1 ] ; then
        # GENERICOBJECTSKEYFIELDARRAY is not empty
        export ObjectsOfTypeToProcess=true
    else
        export ObjectsOfTypeToProcess=false
    fi
    
    echo `${dtzs}`${dtzsep} '  Final ObjectsOfTypeToProcess = [ '${ObjectsOfTypeToProcess}' ]' | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '  Number of Object Types Array Elements = [ '"${#GENERICOBJECTSKEYFIELDARRAY[@]}"' ]' | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  Final Object Types Array = ' | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
        #echo | tee -a -i ${logfilepath}
        
        echo '['"${GENERICOBJECTSKEYFIELDARRAY[@]}"']' | tee -a -i ${logfilepath}
        
        #echo | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  Final Object Types Array = ' >> ${logfilepath}
        echo '------------------------------------------------------------------------       ' >> ${logfilepath}
        #echo | tee -a -i ${logfilepath}
        
        echo '['"${GENERICOBJECTSKEYFIELDARRAY[@]}"']' >> ${logfilepath}
        
        #echo | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' >> ${logfilepath}
    fi
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'GetArrayOfComplexObjectsFromGenericObjectsFieldByKey procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB outputs the number of objects type members in a group in the array of objects type objects 
# and collects them into the csv file using the Management DB via mgmt_cli calls

CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'Processing '${APICLIcomplexobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Export '${APICLIcomplexobjectstype}' to CSV File' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  and dump to "'${APICLICSVfiledata}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo ${CSVJQparms} >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    for i in "${GENERICOBJECTSKEYFIELDARRAY[@]}"
    do
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        echo `${dtzs}`${dtzsep} 'Processing '${APICLIcomplexobjecttype}' object with "'${APIGenObjectField}'" "'${objectnametoevaluate}'" using mgmt_cli command' | tee -a -i ${logfilepath}
        
        echo `${dtzs}`${dtzsep} '  - Command Executed :  mgmt_cli show '${APICLIobjectstype}' '${APIGenObjectField}' "'${objectnametoevaluate}'" '${MgmtCLI_Show_OpParms}' \>> '${APICLICSVfiledatalast} >> ${logfilepath}
        
        # The objects in the array should already reflect any ${objectqueryselector} nuances
        # Build json file with objects array, single item, for easier jq to CSV next
        
        echo '{ "objects": [ ' > ${APICLICSVfiledatalast}
        
        mgmt_cli show ${APICLIobjecttype} ${APIGenObjectField} "${objectnametoevaluate}" ${MgmtCLI_Show_OpParms} >> ${APICLICSVfiledatalast}
        errorreturn=$?
        
        echo '], "from": 0, "to": 1, "total": 1 }' >> ${APICLICSVfiledatalast}
        
        if [ "${errorreturn}" != "0" ] ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error in mgmt_cli Operation in CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB for object '${APICLIobjecttype}' with name '${objectnametoevaluate}' which may lead to failure to generate output!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from "'${APICLICSVfiledatalast}'" : ' >> ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Result in "'${APICLICSVfiledatalast}'" : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
            echo >> ${logfilepath}
            cat ${APICLICSVfiledatalast} >> ${logfilepath}
            echo >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
        fi
        
        cat ${APICLICSVfiledatalast} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
        
        if [ "${errorreturn}" != "0" ] ; then
            echo `${dtzs}`${dtzsep} 'Error in JQ Operation in CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB for object '${APICLIobjecttype}' with name '${objectnametoevaluate}' which may lead to failure to generate output!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Result in "'${APICLICSVfiledatalast}'" : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
            echo >> ${logfilepath}
            cat ${APICLICSVfiledatalast} >> ${logfilepath}
            echo >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
        fi
        
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    done
    
    echo `${dtzs}`${dtzsep} 'CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectComplexObjectsFromGenericObjectsFieldWithJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectComplexObjectsFromGenericObjectsFieldWithJSONRepository outputs the number of objects type members in a group in the array of objects type objects 
# and collects them into the csv file using the Management DB via mgmt_cli calls

CollectComplexObjectsFromGenericObjectsFieldWithJSONRepository () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectComplexObjectsFromGenericObjectsFieldWithJSONRepository procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'Processing '${APICLIcomplexobjecttype}' objects ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  from the JSON repository file "'${JSONRepoComplexObjectFile}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Export '${APICLIcomplexobjectstype}' to CSV File' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  and dump to "'${APICLICSVfiledata}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export details level   :  '${APICLIdetaillvl} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Export Filename add-on :  '${APICLIexportnameaddon} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  mgmt_cli parameters    :  '${MgmtCLI_Show_OpParms} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  Object Query Selector  :  '${objectqueryselector} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo ${CSVJQparms} >> ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    for i in "${GENERICOBJECTSKEYFIELDARRAY[@]}"
    do
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        echo `${dtzs}`${dtzsep} 'Processing '${APICLIcomplexobjecttype}' object with "'${APIGenObjectField}'" "'${objectnametoevaluate}'" from the JSON repository file' | tee -a -i ${logfilepath}
        
        # The objects in the array should already reflect any ${objectqueryselector} nuances
        
        cat ${JSONRepoComplexObjectFile} | ${JQ} '.objects[] | select(.'"${APIGenObjectField}"' == "'"${objectnametoevaluate}"'") | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
        
        if [ "${errorreturn}" != "0" ] ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error in JQ Operation in CollectComplexObjectsFromGenericObjectsFieldWithJSONRepository for '${APICLIcomplexobjectstype}' object '${objectnametoevaluate}' which may lead to failure to generate output!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLICSVfiledata}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
            echo >> ${logfilepath}
            cat ${APICLICSVfiledatalast} >> ${logfilepath}
            echo >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
        fi
        
    done
    
    echo `${dtzs}`${dtzsep} 'CollectComplexObjectsFromGenericObjectsFieldWithJSONRepository procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED - 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectComplexObjectsViaGenericObjectsFieldArrayToCSV proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectComplexObjectsViaGenericObjectsFieldArrayToCSV outputs the number of objects type members in a group in the array of objects type objects and collects them into the csv file.

CollectComplexObjectsViaGenericObjectsFieldArrayToCSV () {
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectComplexObjectsViaGenericObjectsFieldArrayToCSV procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Use array of ["'${APIGenObjectField}'"] to generate '${APICLIcomplexobjecttype}' objects CSV' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    #
    # ${domgmtcliquery} should still be valid from GetArrayOfGenericObjectsByClassWithSpecificKeyValues where we executed the elements to get the values
    # through the use of complex object and generic object specific JSON Repo File checks and related operations.
    #
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectComplexObjectsFromGenericObjectsFieldWithMgmtDB procedure' | tee -a -i ${logfilepath}
        fi
        
    else
        # Execute the JSON repository query instead
        
        CollectComplexObjectsFromGenericObjectsFieldWithJSONRepository
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectComplexObjectsFromGenericObjectsFieldWithJSONRepository procedure' | tee -a -i ${logfilepath}
        fi
        
    fi
    
    echo `${dtzs}`${dtzsep} 'CollectComplexObjectsViaGenericObjectsFieldArrayToCSV procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ExportComplexObjectViaGenericObjectsArrayToCSV proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-06:02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# ExportComplexObjectViaGenericObjectsArrayToCSV generate output of objects type members from existing objects type objects

ExportComplexObjectViaGenericObjectsArrayToCSV () {
    
    export Workingfilename=
    export APICLIfileexport=
    export APICLIJSONfilelast=
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    DumpObjectDefinitionData
    
    # -------------------------------------------------------------------------------------------------
    
    export GENERICOBJECTSKEYFIELDARRAY=()
    export ObjectsOfTypeToProcess=false
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-02 -
    
    # Since this stipulates a standard object exported to CSV but using a Generic Object array to show ${APICLIobjectstype} we actually want the standard CSV and JQ parameters configured
    
    ConfigureExportCSVandJQParameters
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in ConfigureExportCSVandJQParameters procedure -- RETURNING!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' >> ${logfilepath}
        
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
        
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    SetupExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SetupExportComplexObjectsToCSVviaJQ procedure -- RETURNING!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' >> ${logfilepath}
        
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
        
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    GetArrayOfComplexObjectsFromGenericObjectsFieldByKey
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in GetArrayOfComplexObjectsFromGenericObjectsFieldByKey procedure -- RETURNING!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' | tee -a -i ${logfilepath}
        
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
        
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    if ${ObjectsOfTypeToProcess} ; then
        # we have objects left to process after generating the array of ObjectsType
        echo `${dtzs}`${dtzsep} 'Processing returned [ '${#GENERICOBJECTSKEYFIELDARRAY[@]}' ] objects of type "'${APICLIcomplexobjectstype}'", so processing this object' | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
        DumpArrayOfGenericObjectsKeyFieldValues
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DumpArrayOfGenericObjectsKeyFieldValues procedure -- RETURNING!!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' >> ${logfilepath}
            
            if ${APISCRIPTVERBOSE} ; then
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
        CollectComplexObjectsViaGenericObjectsFieldArrayToCSV
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectComplexObjectsViaGenericObjectsFieldArrayToCSV procedure -- RETURNING!!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' >> ${logfilepath}
            
            if ${APISCRIPTVERBOSE} ; then
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
        FinalizeExportComplexObjectsToCSVviaJQ
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' | tee -a -i ${logfilepath}
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' | tee -a -i ${logfilepath}
        fi
    else
        # The array of ObjectsType is empty, nothing to process
        echo `${dtzs}`${dtzsep} 'No objects of type '${APICLIobjectstype}' were returned to process, skipping further operations on this object' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    if ${APISCRIPTVERBOSE} ; then
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportComplexObjectViaGenericObjectsArrayToCSV procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ComplexObjectsCSVViaGenericObjectsHandler proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ComplexObjectsCSVViaGenericObjectsHandler () {
    #
    # Generic Handler for Complex Object Types
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    genericobjectstotal_object=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    export number_objects="${genericobjectstotal_object}"
    
    if [ ${number_objects} -le 0 ] ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object type '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' has NO [ '${number_objects}' ] objects to generate '${APICLIcomplexobjectstype}' objects from!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!...' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object type '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'"' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' has [ '${number_objects}' ] objects to generate '${APICLIcomplexobjectstype}' objects from!' | tee -a -i ${logfilepath}
        
        # MODIFIED 2022-09-16:01 -
        # Account for whether the original object definition is for REFERENCE, NO IMPORT already
        
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${OnlySystemObjects} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}
        fi
        
        ExportComplexObjectViaGenericObjectsArrayToCSV
        errorreturn=$?
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in ComplexObjectsCSVViaGenericObjectsHandler procedure' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        if ${ABORTONERROR} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            if ${APISCRIPTVERBOSE} ; then
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            exit ${errorreturn}
        else
            if ${APISCRIPTVERBOSE} ; then
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
    else
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Complex Object via Generic-Objects Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#if ${NoSystemObjects} ; then
    ## Ignore System Objects
    
#elif ${OnlySystemObjects} ; then
    ## Only System Objects
    
#elif ${CreatorIsNotSystem} ; then
    ## Only System Objects
    
#elif ${CreatorIsSystem} ; then
    ## Only System Objects
    
#else
    ## Don't Ignore System Objects
    
#fi


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites-from-generic-objects
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# |  - Reference Details and initial object
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export AugmentExportedFields=false

if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export AugmentExportedFields=true
elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    export AugmentExportedFields=true
elif ${OnlySystemObjects} ; then
    export AugmentExportedFields=true
else
    export AugmentExportedFields=false
fi

if ! ${AugmentExportedFields} ; then
    export APICLIexportnameaddon=
else
    export APICLIexportnameaddon=FOR_REFERENCE_ONLY
fi

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
if ! ${AugmentExportedFields} ; then
    export CSVFileHeader='"primary-category"'
    # The risk key is not imported
    #export CSVFileHeader=${CSVFileHeader}',"risk"'
else
    export CSVFileHeader='"application-id","primary-category"'
    # The risk key is not imported
    export CSVFileHeader=${CSVFileHeader}',"risk"'
fi
export CSVFileHeader=${CSVFileHeader}',"urls-defined-as-regular-expression"'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVFileHeader=${CSVFileHeader}',"user-defined"'
fi
export CSVFileHeader=${CSVFileHeader}',"url-list.0"'
# The next elements are more complex elements, but required for import add operation
if ${AugmentExportedFields} ; then
    export CSVFileHeader=${CSVFileHeader}',"url-list.1"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.2"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.3"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.4"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.5"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.6"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.7"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.8"'
    export CSVFileHeader=${CSVFileHeader}',"url-list.9"'
fi
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
if ${AugmentExportedFields} ; then
    # The next elements are more complex elements, but NOT required for import add operation
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.1"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.2"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.3"'
    export CSVFileHeader=${CSVFileHeader}',"additional-categories.4"'
fi
export CSVFileHeader=${CSVFileHeader}',"application-signature"'
export CSVFileHeader=${CSVFileHeader}',"description"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
if ! ${AugmentExportedFields} ; then
    export CSVJQparms='.["primary-category"]'
    # The risk key is not imported
    #export CSVJQparms=${CSVJQparms}', .["risk"]'
else
    export CSVJQparms='.["application-id"], .["primary-category"]'
    # The risk key is not imported
    export CSVJQparms=${CSVJQparms}', .["risk"]'
fi
export CSVJQparms=${CSVJQparms}', .["urls-defined-as-regular-expression"]'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVJQparms=${CSVJQparms}', .["user-defined"]'
fi
export CSVJQparms=${CSVJQparms}', .["url-list"][0]'
# The next elements are more complex elements, but required for import add operation
if ${AugmentExportedFields} ; then
    export CSVJQparms=${CSVJQparms}', .["url-list"][1]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][2]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][3]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][4]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][5]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][6]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][7]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][8]'
    export CSVJQparms=${CSVJQparms}', .["url-list"][9]'
fi
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
if ${AugmentExportedFields} ; then
    # The next elements are more complex elements, but NOT required for import add operation
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][1]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][2]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][3]'
    export CSVJQparms=${CSVJQparms}', .["additional-categories"][4]'
fi
export CSVJQparms=${CSVJQparms}', .["application-signature"]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_generic_objects=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_generic_objects="${objectstotal_generic_objects}"
export number_of_objects=${number_generic_objects}

if [ ${number_of_objects} -le 0 ] ; then
    # No hosts found
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'No '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    # hosts found
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Check '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" with [ '${number_of_objects}' ] objects to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    ComplexObjectsCSVViaGenericObjectsHandler
fi

#case "${TypeOfExport}" in
    ## a "Standard" export operation
    #'standard' )
        #objectstotal_generic_objects=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        #export number_generic_objects="${objectstotal_generic_objects}"
        #export number_of_objects=${number_generic_objects}
        
        #if [ ${number_of_objects} -le 0 ] ; then
            ## No hosts found
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} 'No '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #else
            ## hosts found
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} 'Check '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" with [ '${number_of_objects}' ] objects to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            #ComplexObjectsCSVViaGenericObjectsHandler
        #fi
        
        #;;
    ## a "name-only" export operation
    ##'name-only' )
    ## a "name-and-uid" export operation
    ##'name-and-uid' )
    ## a "uid-only" export operation
    ##'uid-only' )
    ## a "rename-to-new-nam" export operation
    ##'rename-to-new-name' )
    ## Anything unknown is handled as "standard"
    #* )
        #echo `${dtzs}`${dtzsep} 'Skipping '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" "'"${APICLIexportnameaddon}"'" for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        #;;
#esac

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-02:01


# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=_SINGLE_ALTERNATIVE_

export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
if ! ${AugmentExportedFields} ; then
    export CSVFileHeader='"primary-category"'
    # The risk key is not imported
    #export CSVFileHeader=${CSVFileHeader}',"risk"'
else
    export CSVFileHeader='"application-id","primary-category"'
    # The risk key is not imported
    export CSVFileHeader=${CSVFileHeader}',"risk"'
fi
export CSVFileHeader=${CSVFileHeader}',"urls-defined-as-regular-expression"'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVFileHeader=${CSVFileHeader}',"user-defined"'
fi
export CSVFileHeader=${CSVFileHeader}',"url-list.0"'
export CSVFileHeader=${CSVFileHeader}',"url-list.1"'
export CSVFileHeader=${CSVFileHeader}',"url-list.2"'
export CSVFileHeader=${CSVFileHeader}',"url-list.3"'
export CSVFileHeader=${CSVFileHeader}',"url-list.4"'
export CSVFileHeader=${CSVFileHeader}',"url-list.5"'
export CSVFileHeader=${CSVFileHeader}',"url-list.6"'
export CSVFileHeader=${CSVFileHeader}',"url-list.7"'
export CSVFileHeader=${CSVFileHeader}',"url-list.8"'
export CSVFileHeader=${CSVFileHeader}',"url-list.9"'
export CSVFileHeader=${CSVFileHeader}',"url-list.10"'
export CSVFileHeader=${CSVFileHeader}',"url-list.11"'
export CSVFileHeader=${CSVFileHeader}',"url-list.12"'
export CSVFileHeader=${CSVFileHeader}',"url-list.13"'
export CSVFileHeader=${CSVFileHeader}',"url-list.14"'
export CSVFileHeader=${CSVFileHeader}',"url-list.15"'
export CSVFileHeader=${CSVFileHeader}',"url-list.16"'
export CSVFileHeader=${CSVFileHeader}',"url-list.17"'
export CSVFileHeader=${CSVFileHeader}',"url-list.18"'
export CSVFileHeader=${CSVFileHeader}',"url-list.19"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.1"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.2"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.3"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.4"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.5"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.6"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.7"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.8"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.9"'
export CSVFileHeader=${CSVFileHeader}',"application-signature"'
export CSVFileHeader=${CSVFileHeader}',"description"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
if ! ${AugmentExportedFields} ; then
    export CSVJQparms='.["primary-category"]'
    # The risk key is not imported
    #export CSVJQparms=${CSVJQparms}', .["risk"]'
else
    export CSVJQparms='.["application-id"], .["primary-category"]'
    # The risk key is not imported
    export CSVJQparms=${CSVJQparms}', .["risk"]'
fi
export CSVJQparms=${CSVJQparms}', .["urls-defined-as-regular-expression"]'
if ${AugmentExportedFields} ; then
    # user-defined can't be imported so while shown, it adds no value for normal operations
    export CSVJQparms=${CSVJQparms}', .["user-defined"]'
fi
export CSVJQparms=${CSVJQparms}', .["url-list"][0]'
export CSVJQparms=${CSVJQparms}', .["url-list"][1]'
export CSVJQparms=${CSVJQparms}', .["url-list"][2]'
export CSVJQparms=${CSVJQparms}', .["url-list"][3]'
export CSVJQparms=${CSVJQparms}', .["url-list"][4]'
export CSVJQparms=${CSVJQparms}', .["url-list"][5]'
export CSVJQparms=${CSVJQparms}', .["url-list"][6]'
export CSVJQparms=${CSVJQparms}', .["url-list"][7]'
export CSVJQparms=${CSVJQparms}', .["url-list"][8]'
export CSVJQparms=${CSVJQparms}', .["url-list"][9]'
export CSVJQparms=${CSVJQparms}', .["url-list"][10]'
export CSVJQparms=${CSVJQparms}', .["url-list"][11]'
export CSVJQparms=${CSVJQparms}', .["url-list"][12]'
export CSVJQparms=${CSVJQparms}', .["url-list"][13]'
export CSVJQparms=${CSVJQparms}', .["url-list"][14]'
export CSVJQparms=${CSVJQparms}', .["url-list"][15]'
export CSVJQparms=${CSVJQparms}', .["url-list"][16]'
export CSVJQparms=${CSVJQparms}', .["url-list"][17]'
export CSVJQparms=${CSVJQparms}', .["url-list"][18]'
export CSVJQparms=${CSVJQparms}', .["url-list"][19]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][1]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][2]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][3]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][4]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][5]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][6]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][7]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][8]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][9]'
export CSVJQparms=${CSVJQparms}', .["application-signature"]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_generic_objects=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_generic_objects="${objectstotal_generic_objects}"
export number_of_objects=${number_generic_objects}

if [ ${number_of_objects} -le 0 ] ; then
    # No hosts found
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'No '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    # hosts found
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Check '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" with [ '${number_of_objects}' ] objects to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    ComplexObjectsCSVViaGenericObjectsHandler
fi

#case "${TypeOfExport}" in
    ## a "Standard" export operation
    #'standard' )
        #objectstotal_generic_objects=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        #export number_generic_objects="${objectstotal_generic_objects}"
        #export number_of_objects=${number_generic_objects}
        
        #if [ ${number_of_objects} -le 0 ] ; then
            ## No hosts found
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} 'No '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #else
            ## hosts found
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} 'Check '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" with [ '${number_of_objects}' ] objects to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            #ComplexObjectsCSVViaGenericObjectsHandler
        #fi
        
        #;;
    ## a "name-only" export operation
    ##'name-only' )
    ## a "name-and-uid" export operation
    ##'name-and-uid' )
    ## a "uid-only" export operation
    ##'uid-only' )
    ## a "rename-to-new-nam" export operation
    ##'rename-to-new-name' )
    ## Anything unknown is handled as "standard"
    #* )
        #echo `${dtzs}`${dtzsep} 'Skipping '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" "'"${APICLIexportnameaddon}"'" for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        #;;
#esac

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-02:01


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Complex Object via Generic-Objects Handlers - Object Specific Keys with Value arrays
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Complex Object via Generic-Objects Handlers - Object Specific Keys with Value arrays' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Complex Object via Generic-Objects - Object Specific Keys with Value arrays Handling Procedures Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2023-03-02 -
# MODIFIED 2023-03-02:01 -


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromMgmtDB populates array of objects for further processing from Management DB via mgmt_cli.

PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromMgmtDB () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromMgmtDB procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Populate Array of '${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}"' .'"${APIGenObjectField}"' fields from Management Database via mgmt_cli!' | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    genericobjectslefttoshow=${objectstoshowgenericobject}
    
    currentobjectoffset=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  - Results Key, last entry :  N = Null, 0 = Zero, -= Key Value Not Found, ! = Key Value Found, ? = Strange Data Value' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    while [ ${genericobjectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        
        # -------------------------------------------------------------------------------------------------
        
        echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Populate up to next '${WorkAPIObjectLimit}' .'"${APIGenObjectField}"' fields starting with object '${currentobjectoffset}' of '${genericobjectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '   --  Using Object Query Selector "'${objectqueryselector}'"' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        # MGMT_CLI_GENERIC_KEY_FIELD_STRING is a string with multiple lines. Each line contains a ${APIGenObjectField} for ${APICLIobjectstype} obtained via query of generic object with class.
        
        if [ x"${objectqueryselector}" != x"" ] ; then
            MGMT_CLI_GENERIC_KEY_FIELD_STRING="`mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit ${WorkAPIObjectLimit} offset ${currentobjectoffset} details-level ${APIGenObjobjectkeydetailslevel} -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .'"${APIGenObjectField}"' | @sh' -r`"
        else
            MGMT_CLI_GENERIC_KEY_FIELD_STRING="`mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit ${WorkAPIObjectLimit} offset ${currentobjectoffset} details-level ${APIGenObjobjectkeydetailslevel} -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | .'"${APIGenObjectField}"' | @sh' -r`"
        fi
        
        # break the string into an array - each element of the array is a line in the original string
        # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
        
        echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        while read -r line; do
            if [ "${line}" == '' ]; then
                # ${line} value is nul, so skip adding to array
                echo -n '%' | tee -a -i ${logfilepath}
            else
                # ${line} value is NOT nul, so add to array
                
                ALLGENERICOBJECTSKEYFIELDARRAY+=("${line}")
                
                echo -n '.' | tee -a -i ${logfilepath}
                
                arraylength=${#ALLGENERICOBJECTSKEYFIELDARRAY[@]}
                arrayelement=$((arraylength-1))
                
                if ${APISCRIPTVERBOSE} ; then
                    # Verbose mode ON
                    # Output list of all hosts found
                    echo -n ' '"${line}"', ' | tee -a -i ${logfilepath}
                    echo -n "$(eval echo ${line})"', ' >> ${logfilepath}
                    echo -n "$arraylength"', ' >> ${logfilepath}
                    echo -n "$arrayelement"', ' | tee -a -i ${logfilepath}
                    #echo -n "$(eval echo ${ALLGENERICOBJECTSKEYFIELDARRAY[${arrayelement}]})"', ' | tee -a -i ${logfilepath}
                fi
                
                SPECIFICKEYVALUES_COUNT=$(mgmt_cli show ${APICLIobjecttype} ${APIGenObjectField} "$(eval echo ${line})" details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'" | length' )
                
                NUM_SPECIFIC_KEY_VALUES=${SPECIFICKEYVALUES_COUNT}
                
                if [ x"${NUM_SPECIFIC_KEY_VALUES}" == x"" ] ; then
                    # There are null objects, so skip
                    if ${APISCRIPTVERBOSE} ; then
                        echo -n 'N, ' | tee -a -i ${logfilepath}
                    else
                        echo -n 'N' | tee -a -i ${logfilepath}
                    fi
                    echo -n '-' | tee -a -i ${logfilepath}
                elif [[ ${NUM_SPECIFIC_KEY_VALUES} -lt 1 ]] ; then
                    # no objects of this type
                    if ${APISCRIPTVERBOSE} ; then
                        echo -n '0, ' | tee -a -i ${logfilepath}
                    else
                        echo -n '0' | tee -a -i ${logfilepath}
                    fi
                    echo -n '-' | tee -a -i ${logfilepath}
                elif [[ ${NUM_SPECIFIC_KEY_VALUES} -gt 0 ]] ; then
                    # More than zero (1) interfaces, something to process
                    if [ ${NUM_SPECIFIC_KEY_VALUES} -gt ${MAXObjectsSpecificKeyValues} ] ; then
                        export MAXObjectsSpecificKeyValues=${NUM_SPECIFIC_KEY_VALUES}
                    fi
                    
                    if ${APISCRIPTVERBOSE} ; then
                        echo -n "${NUM_SPECIFIC_KEY_VALUES}"', ' | tee -a -i ${logfilepath}
                    else
                        echo -n "${NUM_SPECIFIC_KEY_VALUES}" | tee -a -i ${logfilepath}
                    fi
                    GENERICOBJECTSKEYFIELDARRAY+=("${line}")
                    let SpecificKeyValuesCount=SpecificKeyValuesCount+${NUM_SPECIFIC_KEY_VALUES}
                    echo -n '!' | tee -a -i ${logfilepath}
                else
                    # ?? Whatever..., so skip
                    if ${APISCRIPTVERBOSE} ; then
                        echo -n '?, ' | tee -a -i ${logfilepath}
                    else
                        echo -n '?' | tee -a -i ${logfilepath}
                    fi
                    echo -n '-' | tee -a -i ${logfilepath}
                fi
                
            fi
            
            if ${APISCRIPTVERBOSE} ; then
                # Verbose mode ON
                echo | tee -a -i ${logfilepath}
                echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            fi
            
        done <<< "${MGMT_CLI_GENERIC_KEY_FIELD_STRING}"
        errorreturn=$?
        
        echo | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
        genericobjectslefttoshow=`expr ${genericobjectslefttoshow} - ${WorkAPIObjectLimit}`
        currentobjectoffset=`expr ${currentobjectoffset} + ${WorkAPIObjectLimit}`
        
        CheckAPIKeepAlive
        
    done
    
    # -------------------------------------------------------------------------------------------------
    
    echo | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  SpecificKeyValuesCount      = '${SpecificKeyValuesCount} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  MAXObjectsSpecificKeyValues = '${MAXObjectsSpecificKeyValues} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  SpecificKeyValuesCount      = '${SpecificKeyValuesCount} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '  MAXObjectsSpecificKeyValues = '${MAXObjectsSpecificKeyValues} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    export SpecificKeyValuesCount=${SpecificKeyValuesCount}
    
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromMgmtDB procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromJSONRepository populates array of objects for further processing from JSON Repository.

PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromJSONRepository () {
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromJSONRepository procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Populate Array of '${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}"' .'"${APIGenObjectField}"' fields from JSON Repository!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '   --  Generic Object JSON Repository File "'${JSONRepoAPIGenObjectFile}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '   --  Complex Object JSON Repository File "'${JSONRepoComplexObjectFile}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '   --  Using Object Query Selector "'${objectqueryselector}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # JSON_REPO_GENERIC_KEY_FIELD_STRING is a string with multiple lines. Each line contains a ${APIGenObjectField} for ${APICLIobjectstype} collected into the JSON Repo File via query of generic object with class.
    
    if [ x"${objectqueryselector}" != x"" ] ; then
        JSON_REPO_GENERIC_KEY_FIELD_STRING="`cat ${JSONRepoAPIGenObjectFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .'"${APIGenObjectField}"' | @sh' -r`"
    else
        JSON_REPO_GENERIC_KEY_FIELD_STRING="`cat ${JSONRepoAPIGenObjectFile} | ${JQ} '.objects[] | .'"${APIGenObjectField}"' | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  - Results Key, last entry :  N = Null, 0 = Zero, -= Key Value Not Found, ! = Key Value Found, ? = Strange Data Value' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    while read -r line; do
        if [ "${line}" == '' ]; then
            # ${line} value is nul, so skip adding to array
            echo -n '%' | tee -a -i ${logfilepath}
        else
            # ${line} value is NOT nul, so add to array
            
            ALLGENERICOBJECTSKEYFIELDARRAY+=("${line}")
            
            echo -n '.' | tee -a -i ${logfilepath}
            
            arraylength=${#ALLGENERICOBJECTSKEYFIELDARRAY[@]}
            arrayelement=$((arraylength-1))
            
            if ${APISCRIPTVERBOSE} ; then
                # Verbose mode ON
                # Output list of all hosts found
                echo -n ' '"${line}"', ' | tee -a -i ${logfilepath}
                echo -n "$(eval echo ${line})"', ' >> ${logfilepath}
                echo -n "$arraylength"', ' >> ${logfilepath}
                echo -n "$arrayelement"', ' | tee -a -i ${logfilepath}
                #echo -n "$(eval echo ${ALLGENERICOBJECTSKEYFIELDARRAY[${arrayelement}]})"', ' | tee -a -i ${logfilepath}
            fi
            
            SPECIFICKEYVALUES_COUNT=$(cat ${JSONRepoComplexObjectFile} | ${JQ} '.objects[] | select(.'"${APIGenObjectField}"' == "'"$(eval echo ${line})"'") | ."'${APIobjectspecifickey}'" | length')
            
            NUM_SPECIFIC_KEY_VALUES=${SPECIFICKEYVALUES_COUNT}
            
            if [ x"${NUM_SPECIFIC_KEY_VALUES}" == x"" ] ; then
                # There are null objects, so skip
                if ${APISCRIPTVERBOSE} ; then
                    echo -n 'N, ' | tee -a -i ${logfilepath}
                else
                    echo -n 'N' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            elif [[ ${NUM_SPECIFIC_KEY_VALUES} -lt 1 ]] ; then
                # no objects of this type
                if ${APISCRIPTVERBOSE} ; then
                    echo -n '0, ' | tee -a -i ${logfilepath}
                else
                    echo -n '0' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            elif [[ ${NUM_SPECIFIC_KEY_VALUES} -gt 0 ]] ; then
                # More than zero (1) interfaces, something to process
                if [ ${NUM_SPECIFIC_KEY_VALUES} -gt ${MAXObjectsSpecificKeyValues} ] ; then
                    export MAXObjectsSpecificKeyValues=${NUM_SPECIFIC_KEY_VALUES}
                fi
                
                if ${APISCRIPTVERBOSE} ; then
                    echo -n "${NUM_SPECIFIC_KEY_VALUES}"', ' | tee -a -i ${logfilepath}
                else
                    echo -n "${NUM_SPECIFIC_KEY_VALUES}" | tee -a -i ${logfilepath}
                fi
                GENERICOBJECTSKEYFIELDARRAY+=("${line}")
                let SpecificKeyValuesCount=SpecificKeyValuesCount+${NUM_SPECIFIC_KEY_VALUES}
                echo -n '!' | tee -a -i ${logfilepath}
            else
                # ?? Whatever..., so skip
                if ${APISCRIPTVERBOSE} ; then
                    echo -n '?, ' | tee -a -i ${logfilepath}
                else
                    echo -n '?' | tee -a -i ${logfilepath}
                fi
                echo -n '-' | tee -a -i ${logfilepath}
            fi
            
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo | tee -a -i ${logfilepath}
            echo -n `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
        
    done <<< "${JSON_REPO_GENERIC_KEY_FIELD_STRING}"
    errorreturn=$?
    
    # -------------------------------------------------------------------------------------------------
    
    echo | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  SpecificKeyValuesCount      = '${SpecificKeyValuesCount} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  MAXObjectsSpecificKeyValues = '${MAXObjectsSpecificKeyValues} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  SpecificKeyValuesCount      = '${SpecificKeyValuesCount} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '  MAXObjectsSpecificKeyValues = '${MAXObjectsSpecificKeyValues} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    export SpecificKeyValuesCount=${SpecificKeyValuesCount}
    
    echo `${dtzs}`${dtzsep} 'PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromJSONRepository procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:02 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetArrayOfGenericObjectsByClassWithSpecificKeyValues proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfGenericObjectsByClassWithSpecificKeyValues generates an array of ${APICLIobjectstype} objects for further processing.

GetArrayOfGenericObjectsByClassWithSpecificKeyValues () {
    
    # MODIFIED 2023-03-14:01 -
    
    errorreturn=0
    
    GENERICOBJECTSKEYFIELDARRAY=()
    ALLGENERICOBJECTSKEYFIELDARRAY=()
    export MAXObjectsSpecificKeyValues=0
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'GetArrayOfGenericObjectsByClassWithSpecificKeyValues procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Generate array of '${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" ${APIGenObjectField}' fields' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-07:02 -
    
    # Script simplification for common operations among Complex Objects via Generic Objects procedures
    
    #CommonGenericObjectsHandlersInitialSetup01
    #CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
    #CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
    #CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    CommonGenericObjectsHandlersInitialSetup01
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CommonGenericObjectsHandlersInitialSetup01 procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CommonGenericObjectsSetupGenericObjectsTotalsPathsJSONRepoDoMgmtCLIQuery procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CommonGenericObjectsSetupComplexObjectsTotalsPathsJSONRepoDoMgmtCLIQuery procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CommonGenericObjectsDetermineGenericaAndComplexObjectsDoMgmtCLIQuery procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the objects because both required JSON files are not OK or available as needed
        
        echo `${dtzs}`${dtzsep} 'Processing [ '${objectstoshowgenericobject}' ] '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
        
        PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromMgmtDB
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromMgmtDB procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    else
        # Execute the JSON repository query because both required JSON objects should be OK
        
        echo `${dtzs}`${dtzsep} 'Processing '${objectstoshowgenericobject}' '${APICLIobjecttype}' objects from the JSON repository file '${JSONRepoAPIGenObjectFile} | tee -a -i ${logfilepath}
        
        PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromJSONRepository
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in PopulateArrayOfGenericObjectsByClassWithSpecificKeyValuesFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Final SpecificKeyValuesCount          = '${SpecificKeyValuesCount} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Final Generic Objedts Key Field Array = ' | tee -a -i ${logfilepath}
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    #echo | tee -a -i ${logfilepath}
    
    echo '['"${GENERICOBJECTSKEYFIELDARRAY[@]}"']' | tee -a -i ${logfilepath}
    
    #echo | tee -a -i ${logfilepath}
    echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} 'GetArrayOfGenericObjectsByClassWithSpecificKeyValues procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:03 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromMgmtDB outputs the specific key values in an object in the array of objects and collects them into the csv file using the mgmg_cli calls to the Management DB.

CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromMgmtDB () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromMgmtDB procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, document
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIKeepAlive procedure' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    # -------------------------------------------------------------------------------------------------
    
    ConfigureMgmtCLIOperationalParametersExport
    
    # -------------------------------------------------------------------------------------------------
    
    export CSVJQspecifickeyvaluesparmsbase=${CSVJQparms}
    
    export CSVJQspecifickeyvalueserroraddon=
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVJQspecifickeyvalueserroraddon=', true, true'
        if ${APIobjectcansetifexists} ; then
            export CSVJQspecifickeyvalueserroraddon=${CSVJQspecifickeyvalueserroraddon}', true'
        fi
    fi
    
    export CSVJQspecifickeyvaluesparmsbase=${CSVJQparms}${CSVJQspecifickeyvalueserroraddon}
    
    for i in "${GENERICOBJECTSKEYFIELDARRAY[@]}"
    do
        CheckAPIKeepAlive
        
        export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
        
        ConfigureMgmtCLIOperationalParametersExport
        
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} Host with interfaces "${objectnametoevaluate}" | tee -a -i ${logfilepath}
        
        #SPECIFICKEYVALUES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'" | length')
        SPECIFICKEYVALUES_COUNT=$(mgmt_cli show ${APICLIobjecttype} ${APIGenObjectField} "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'" | length')
        
        NUM_SPECIFIC_KEY_VALUES=${SPECIFICKEYVALUES_COUNT}
        
        if [ x"${NUM_SPECIFIC_KEY_VALUES}" == x"" ] ; then
            # There are null objects, so skip
            
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '${APIGenObjectField}' '"${objectnametoevaluate}"' number of specific key values = NULL (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_SPECIFIC_KEY_VALUES} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '${APIGenObjectField}' '"${objectnametoevaluate}"' number of specific key values = 0 (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_SPECIFIC_KEY_VALUES} -gt 0 ]] ; then
            # More than zero (0) interfaces, something to process
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '${APIGenObjectField}' '"${objectnametoevaluate}"' number of specific key values = '"${NUM_SPECIFIC_KEY_VALUES}" | tee -a -i ${logfilepath}
            
            # If there is an issue with adding the index [0] keys during import which may be exported with the basic object, then more plumbing is required here
            # like changing the sequence to start from [1] versus [0] as it is currently done
            
            for j in `seq 0 $(expr ${NUM_SPECIFIC_KEY_VALUES} - 1 )`
            do
                sequencenumberformatted=`printf "%05d" ${j}`
                
                GETSPECIFICKEYVALUE=$(mgmt_cli show ${APICLIobjecttype} ${APIGenObjectField} "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '."'${APIobjectspecifickey}'"['${j}']')
                
                export SPECIFICKEYVALUE=${GETSPECIFICKEYVALUE}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromMgmtDB mgmt_cli execution reading '${APICLIobjecttype}' object '${objectnametoevaluate}' '"${APIobjectspecifickey}"' sequence number: ['${j}']' | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                echo '"'${objectnametoevaluate}'",'${SPECIFICKEYVALUE}${CSVJQspecifickeyvalueserroraddon} >> ${APICLICSVfiledata}
                echo `${dtzs}`${dtzsep} 'Sequence Number [ '${sequencenumberformatted}' ] :  '${APIGenObjectField}' "'${objectnametoevaluate}'",'${SPECIFICKEYVALUE}${CSVJQspecifickeyvalueserroraddon} | tee -a -i ${logfilepath}
            done
            
        else
            # ?? Whatever..., so skip
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '${APIGenObjectField}' '"${objectnametoevaluate}"' number of '"${APIobjectspecifickey}"' = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    echo `${dtzs}`${dtzsep} 'CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromMgmtDB procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:03


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:03 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromJSONRepository outputs the host interfaces in a host in the array of host objects and collects them into the csv file using the JSON Repository.

CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromJSONRepository () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromJSONRepository procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    export CSVJQspecifickeyvaluesparmsbase=${CSVJQparms}
    
    export CSVJQspecifickeyvalueserroraddon=
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVJQspecifickeyvalueserroraddon=', true, true'
        if ${APIobjectcansetifexists} ; then
            export CSVJQspecifickeyvalueserroraddon=${CSVJQspecifickeyvalueserroraddon}', true'
        fi
    fi
    
    export CSVJQspecifickeyvaluesparmsbase=${CSVJQparms}${CSVJQspecifickeyvalueserroraddon}
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '  -- JSON Repo File = "'${JSONRepoComplexObjectFile}'"' >> ${logfilepath}
    
    for i in "${GENERICOBJECTSKEYFIELDARRAY[@]}"
    do
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} Host with interfaces "${objectnametoevaluate}" | tee -a -i ${logfilepath}
        
        #SPECIFICKEYVALUES_COUNT=$(cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"${objectnametoevaluate}"'") | ."'${APIobjectspecifickey}'" | length')
        #SPECIFICKEYVALUES_COUNT=$(cat ${JSONRepoComplexObjectFile} | ${JQ} '.objects[] | select(.'"${APIGenObjectField}"' == "'"$(eval echo ${line})"'") | ."'${APIobjectspecifickey}'" | length')
        SPECIFICKEYVALUES_COUNT=$(cat ${JSONRepoComplexObjectFile} | ${JQ} '.objects[] | select(."'${APIGenObjectField}'" == "'"${objectnametoevaluate}"'") | ."'${APIobjectspecifickey}'" | length')
        
        NUM_SPECIFIC_KEY_VALUES=${SPECIFICKEYVALUES_COUNT}
        
        if [ x"${NUM_SPECIFIC_KEY_VALUES}" == x"" ] ; then
            # There are null objects, so skip
            
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '${APIGenObjectField}' '"${objectnametoevaluate}"' number of specific key values = NULL (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_SPECIFIC_KEY_VALUES} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '${APIGenObjectField}' '"${objectnametoevaluate}"' number of specific key values =  0 (0 zero)' | tee -a -i ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_SPECIFIC_KEY_VALUES} -gt 0 ]] ; then
            # More than zero (0) interfaces, something to process
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '${APIGenObjectField}' '"${objectnametoevaluate}"' number of specific key values = '"${NUM_SPECIFIC_KEY_VALUES}" | tee -a -i ${logfilepath}
            
            for j in `seq 0 $(expr ${NUM_SPECIFIC_KEY_VALUES} - 1 )`
            do
                sequencenumberformatted=`printf "%03d" ${j}`
                
                GETSPECIFICKEYVALUE=$(cat ${JSONRepoComplexObjectFile} | ${JQ} '.objects[] | select(."'${APIGenObjectField}'" == "'"${objectnametoevaluate}"'") | ."'${APIobjectspecifickey}'"['${j}']')
                
                export SPECIFICKEYVALUE=${GETSPECIFICKEYVALUE}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromJSONRepository JQ execution reading '${APICLIcomplexobjectstype}' object '${objectnametoevaluate}' "'"${APIobjectspecifickey}"'" sequence number: ['${j}']' | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                echo '"'${objectnametoevaluate}'",'${SPECIFICKEYVALUE}${CSVJQspecifickeyvalueserroraddon} >> ${APICLICSVfiledata}
                echo `${dtzs}`${dtzsep} 'Sequence Number [ '${sequencenumberformatted}' ] : '${APIGenObjectField}' "'${objectnametoevaluate}'",'${SPECIFICKEYVALUE}${CSVJQspecifickeyvalueserroraddon} | tee -a -i ${logfilepath}
            done
        else
            # ?? Whatever..., so skip
            echo `${dtzs}`${dtzsep} ${APICLIobjecttype}' '${APIGenObjectField}' '"${objectnametoevaluate}"' number of '"${APIobjectspecifickey}"' = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    echo `${dtzs}`${dtzsep} 'CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromJSONRepository procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:03


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CollectGenericObjectsByClassWithSpecificKeyValuesInObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-14:03 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectGenericObjectsByClassWithSpecificKeyValuesInObjects outputs the ${APIobjectspecifickey} in a ${APICLIobjecttype} in the array of ${APICLIobjecttype} objects and collects them into the csv file.

CollectGenericObjectsByClassWithSpecificKeyValuesInObjects () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CollectGenericObjectsByClassWithSpecificKeyValuesInObjects procedure Starting...' >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Use Array of "'${APIGenObjectField}'" fields from '${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}"' objects to generate ."'${APIobjectspecifickey}'" CSV' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    #
    # ${domgmtcliquery} should still be valid from GetArrayOfGenericObjectsByClassWithSpecificKeyValues where we executed the elements to get the values
    # through the use of complex object and generic object specific JSON Repo File checks and related operations.
    #
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromMgmtDB
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromMgmtDB procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # Execute the JSON repository query instead
        
        CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromJSONRepository
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectGenericObjectsByClassWithSpecificKeyValuesInObjectsFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    fi
    
    echo `${dtzs}`${dtzsep} 'CollectGenericObjectsByClassWithSpecificKeyValuesInObjects procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-14:03


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetGenericObjectsByClassWithSpecificKeyArrayValuesDetailsProcessor proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-07:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetGenericObjectsByClassWithSpecificKeyArrayValuesDetailsProcessor generate output of objects specific key values from existing objects with specific key values objects

GetGenericObjectsByClassWithSpecificKeyArrayValuesDetailsProcessor () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'GetGenericObjectsByClassWithSpecificKeyArrayValuesDetailsProcessor procedure Starting...' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    export SpecificKeyValuesCount=0
    
    # MODIFIED 2021-01-28 -
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        if ${APIobjectcansetifexists} ; then
            export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
            export CSVJQparms=${CSVJQparms}', true'
        fi
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    SetupExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SetupExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    GetArrayOfGenericObjectsByClassWithSpecificKeyValues
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in GetArrayOfGenericObjectsByClassWithSpecificKeyValues procedure' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    if [ x"${SpecificKeyValuesCount}" == x"" ] ; then
        # There are null objects, so skip
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! No application-sites found - NULL' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    elif [[ ${SpecificKeyValuesCount} -lt 1 ]] ; then
        # no objects of this type
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! No application-sitesfound - 0' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    elif [[ ${SpecificKeyValuesCount} -gt 0 ]] ; then
        # We have host interfaces to process
        
        # -------------------------------------------------------------------------------------------------
        
        DumpArrayOfGenericObjectsKeyFieldValues
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DumpArrayOfGenericObjectsKeyFieldValues procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
        CollectGenericObjectsByClassWithSpecificKeyValuesInObjects
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CollectGenericObjectsByClassWithSpecificKeyValuesInObjects procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
        FinalizeExportComplexObjectsToCSVviaJQ
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
    else
        # No host interfaces
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! No '${APICLIcomplexobjectstype}' found' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'GetGenericObjectsByClassWithSpecificKeyArrayValuesDetailsProcessor procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetGenericObjectsByClassWithSpecificKeyArrayValues proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetGenericObjectsByClassWithSpecificKeyArrayValues generate output of host's interfaces from existing hosts with interface objects using the processor

GetGenericObjectsByClassWithSpecificKeyArrayValues () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportCSV} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support CSV EXPORT!  APIobjectdoexportCSV = '${APIobjectdoexportCSV} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    # ADDED 2022-12-21 -
    if ${APIobjectexportisCPI} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' has Critical Performance Impact, APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        if ! ${ExportCritPerfImpactObjects} ; then
            echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
            
            return 0
        else
            echo `${dtzs}`${dtzsep} 'Critical Performance Impact (CPI) Override is active!  ExportCritPerfImpactObjects = '${ExportCritPerfImpactObjects} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does not have Critical Performance Impact(CPI), APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    # MODIFIED 2022-05-02 -
    
    if ${ExportTypeIsStandard} ; then
        
        # -------------------------------------------------------------------------------------------------
        
        DumpObjectDefinitionData
        
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2023-03-05:01 -
        # Account for whether the original object definition is for REFERENCE, NO IMPORT already
        
        if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        elif ${OnlySystemObjects} ; then
            if [ x"${APICLIexportnameaddon}" == x"" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
                export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            else
                export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
            fi
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}
        fi
        
        objectstotal_object=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_object="${objectstotal_object}"
        
        if [ ${number_object} -le 0 ] ; then
            # No ${APICLIobjectstype} found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate '${APICLIcomplexobjectstype}' members from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            GetGenericObjectsByClassWithSpecificKeyArrayValuesDetailsProcessor
            errorreturn=$?
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Not "standard" Export Type :  '${TypeOfExport}' so do not handle '${APICLIcomplexobjectstype}' for '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in GetObjectSpecificKeyArrayValuesDetailsProcessor procedure' | tee -a -i ${logfilepath}
        
        if ${ABORTONERROR} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            return ${errorreturn}
        fi
    else
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-08:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Complex Object via Generic-Objects - Object Specific Keys with Value arrays Handling Procedures Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites-from-generic-objects
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# |  - Reference Details and initial object
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export AugmentExportedFields=false

if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export AugmentExportedFields=true
elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    export AugmentExportedFields=true
elif ${OnlySystemObjects} ; then
    export AugmentExportedFields=true
else
    export AugmentExportedFields=false
fi


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites - url-lists from generic object
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object-element-url-list
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects-elements-url-lists
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site-element-url-list
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites-elements-url-lists
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey='url-list'

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=custom-application-sites-from-generic-objects
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"name","url-list.add"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
# The actual "name" is added by the procedure that generates the dump of ${APIobjectspecifickey} items and ommited here!
export CSVJQparms='.["'${APIGenObjobjectkey}'"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        objectstotal_generic_objects=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_generic_objects="${objectstotal_generic_objects}"
        export number_of_objects=${number_generic_objects}
        
        if [ ${number_of_objects} -le 0 ] ; then
            # No hosts found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            # hosts found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Check '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" with [ '${number_of_objects}' ] objects to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            GetGenericObjectsByClassWithSpecificKeyArrayValues
        fi
        
        ;;
    # a "name-only" export operation
    #'name-only' )
    # a "name-and-uid" export operation
    #'name-and-uid' )
    # a "uid-only" export operation
    #'uid-only' )
    # a "rename-to-new-nam" export operation
    #'rename-to-new-name' )
    # Anything unknown is handled as "standard"
    * )
        echo `${dtzs}`${dtzsep} 'Skipping '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" "'"${APICLIexportnameaddon}"'" for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}

        ;;
esac

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-02:02


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites - application-signatures from generic object
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# |  - Review of this application-sites objects element for application-signature resulted in a removal of this object, because a singular entry
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype=application-site
#export APICLIobjectstype=application-sites
#export APICLIcomplexobjecttype=custom-application-site-from-generic-object-element-application-signature
#export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects-elements-application-signatures
#export APIobjectminversion=1.1
#export APIobjectexportisCPI=false

#export APIGenObjectTypes=generic-objects
#export APIGenObjectClassField=class-name
#export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
#export APIGenObjectClassShort="appfw.CpmiUserApplication"
#export APIGenObjectField=uid

#export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
#export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
#export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site-element-application-signature
#export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites-elements-application-signatures
#export APIGenObjobjectkey=name
#export APIGenObjobjectkeydetailslevel=standard

#export APIobjectspecifickey='application-signature'

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#export APIobjectjsonrepofileobject=custom-application-sites-from-generic-objects
#export APICLICSVobjecttype=${APICLIcomplexobjectstype}
#export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
#export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
#export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
#export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

#export APIobjectdoexport=true
#export APIobjectdoexportJSON=false
#export APIobjectdoexportCSV=true
#export APIobjectdoimport=true
#export APIobjectdorename=false
#export APIobjectdoupdate=false
#export APIobjectdodelete=false

#export APIobjectusesdetailslevel=true
#export APIobjectcanignorewarning=true
#export APIobjectcanignoreerror=true
#export APIobjectcansetifexists=false
#export APIobjectderefgrpmem=false
#export APIobjecttypehasname=true
#export APIobjecttypehasuid=true
#export APIobjecttypehasdomain=true
#export APIobjecttypehastags=true
#export APIobjecttypehasmeta=true
#export APIobjecttypeimportname=true

#export APIobjectCSVFileHeaderAbsoluteBase=false
#export APIobjectCSVJQparmsAbsoluteBase=false

#export APIobjectCSVexportWIP=false

##
## APICLICSVsortparms can change due to the nature of the object
##
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
#export CSVFileHeader='"name","application-signature"'
##export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
##export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
##export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
## The actual "name" is added by the procedure that generates the dump of ${APIobjectspecifickey} items and ommited here!
#export CSVJQparms='.["'${APIGenObjobjectkey}'"]'
#export CSVJQparms=${CSVJQparms}'.["name"], .["application-signature"]'
##export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
##export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
##export CSVJQparms=${CSVJQparms}', .["icon"]'

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#case "${TypeOfExport}" in
    ## a "Standard" export operation
    #'standard' )
        #objectstotal_generic_objects=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        #export number_generic_objects="${objectstotal_generic_objects}"
        #export number_of_objects=${number_generic_objects}
        
        #if [ ${number_of_objects} -le 0 ] ; then
            ## No hosts found
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} 'No '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #else
            ## hosts found
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} 'Check '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" with [ '${number_of_objects}' ] objects to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
            #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            #GetGenericObjectsByClassWithSpecificKeyArrayValues
        #fi
        
        #;;
    ## a "name-only" export operation
    ##'name-only' )
    ## a "name-and-uid" export operation
    ##'name-and-uid' )
    ## a "uid-only" export operation
    ##'uid-only' )
    ## a "rename-to-new-nam" export operation
    ##'rename-to-new-name' )
    ## Anything unknown is handled as "standard"
    #* )
        #echo `${dtzs}`${dtzsep} 'Skipping '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" "'"${APICLIexportnameaddon}"'" for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}

        #;;
#esac

#echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
#echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-02:02


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites - additional-categories from generic object
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object-element-additional-category
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects-elements-additional-categories
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site-element-additional-category
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites-elements-additional-categories
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey='additional-categories'

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=custom-application-sites-from-generic-objects
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"name","additional-categories.add"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
# The actual "name" is added by the procedure that generates the dump of ${APIobjectspecifickey} items and ommited here!
export CSVJQparms='.["'${APIGenObjobjectkey}'"]'
#export CSVJQparms=${CSVJQparms}'.["name"], .["additional-categories"][${j}]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        objectstotal_generic_objects=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_generic_objects="${objectstotal_generic_objects}"
        export number_of_objects=${number_generic_objects}
        
        if [ ${number_of_objects} -le 0 ] ; then
            # No hosts found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" to generate '${APIobjectspecifickey}' from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            # hosts found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Check '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" with [ '${number_of_objects}' ] objects to generate '${APIobjectspecifickey}'!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            
            GetGenericObjectsByClassWithSpecificKeyArrayValues
        fi
        
        ;;
    # a "name-only" export operation
    #'name-only' )
    # a "name-and-uid" export operation
    #'name-and-uid' )
    # a "uid-only" export operation
    #'uid-only' )
    # a "rename-to-new-nam" export operation
    #'rename-to-new-name' )
    # Anything unknown is handled as "standard"
    * )
        echo `${dtzs}`${dtzsep} 'Skipping '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" "'"${APICLIexportnameaddon}"'" for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}

        ;;
esac

echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-02:02


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more Complex Objects via Generic-Objects Array Handler objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Complex Objects via Generic-Objects Array Handler - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more Object via Generic-Objects Handlers objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Complex Object via Generic-Objects Handlers - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more complex objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


# MODIFIED 2021-02-24 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - complex objects handlers - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-24


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Finished with exporting
# -------------------------------------------------------------------------------------------------

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Dumps Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# =================================================================================================
# END:  Main operations - 
# =================================================================================================
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Publish, Cleanup, and Dump output
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Publish Changes
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-10-27 -
 
if ${UseR8XAPI} ; then
    . ${mgmt_cli_API_operations_handler} PUBLISH "$@"
fi

# -------------------------------------------------------------------------------------------------
# Logout from mgmt_cli, also cleanup session file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-10-27 -
 
if ${UseR8XAPI} ; then
    . ${mgmt_cli_API_operations_handler} LOGOUT "$@"
fi

# -------------------------------------------------------------------------------------------------
# Clean-up according to CLI Parms and special requirements
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if ${CLIparm_CLEANUPCSVWIP} ; then
    # Remove Work-In-Progress folder and files
    
    if [ x"${APICLICSVpathexportwip}" != x"" ] ; then
        if [ -r ${APICLICSVpathexportwip} ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Remove CSV Work-In-Progress folder and files' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '   CSV WIP Folder : "'${APICLICSVpathexportwip}'"' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                rm -v -r ${APICLICSVpathexportwip} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Remove CSV Work-In-Progress folder and files' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} '   CSV WIP Folder : "'${APICLICSVpathexportwip}'"' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
                rm -v -r ${APICLICSVpathexportwip} >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
            fi
        fi
    fi
    
    if [ x"${APICLIJSONpathexportwip}" != x"" ] ; then
        if [ -r ${APICLIJSONpathexportwip} ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Remove JSON Work-In-Progress folder and files' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '   JSON WIP Folder : "'${APICLIJSONpathexportwip}'"' | tee -a -i ${logfilepath}
                rm -v -r ${APICLIJSONpathexportwip} | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Remove JSON Work-In-Progress folder and files' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} '   JSON WIP Folder : "'${APICLIJSONpathexportwip}'"' >> ${logfilepath}
                rm -v -r ${APICLIJSONpathexportwip} >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
            fi
        fi
    fi
    
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# Clean-up and exit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} 'CLI Operations Completed' | tee -a -i ${logfilepath}

if ${APISCRIPTVERBOSE} ; then
    # Verbose mode ON
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    #echo `${dtzs}`${dtzsep} "Files in >${APICLIpathroot}<" | tee -a -i ${logfilepath}
    #ls -alh ${APICLIpathroot} | tee -a -i ${logfilepath}
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ x"${APICLIlogpathbase}" != x"" ] ; then
        if [ "${APICLIlogpathbase}" != "${APICLIpathbase}" ] ; then
            echo `${dtzs}`${dtzsep} 'Files in log path > '"${APICLIlogpathbase}"' <' | tee -a -i ${logfilepath}
            echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            ls -alhR ${APICLIlogpathbase} | tee -a -i ${logfilepath}
            echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'Files in output path > '"${APICLIpathbase}"' <' | tee -a -i ${logfilepath}
    echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    ls -alhR ${APICLIpathbase} | tee -a -i ${logfilepath}
    echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if ${UseJSONRepo} ; then
        echo `${dtzs}`${dtzsep} 'Files in JSON Repository > '"${JSONRepopathroot}"' <' | tee -a -i ${logfilepath}
        echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        ls -alhR ${JSONRepopathroot} | tee -a -i ${logfilepath}
        echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
else
    # Verbose mode OFF
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    #echo `${dtzs}`${dtzsep} "Files in >${APICLIpathroot}<" >> ${logfilepath}
    #ls -alh ${APICLIpathroot} >> ${logfilepath}
    #echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    if [ x"${APICLIlogpathbase}" != x"" ] ; then
        if [ "${APICLIlogpathbase}" != "${APICLIpathbase}" ] ; then
            echo `${dtzs}`${dtzsep} 'Files in log path > '"${APICLIlogpathbase}"'<' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------' >> ${logfilepath}
            ls -alhR ${APICLIlogpathbase} >> ${logfilepath}
            echo '-------------------------------------------------------------------------------' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'Files in output path > '"${APICLIpathbase}"'<' >> ${logfilepath}
    echo '-------------------------------------------------------------------------------' >> ${logfilepath}
    ls -alhR ${APICLIpathbase} >> ${logfilepath}
    echo '-------------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    if ${UseJSONRepo} ; then
        echo `${dtzs}`${dtzsep} 'Files in JSON Repository > '"${JSONRepopathroot}"'<' >> ${logfilepath}
        echo '-------------------------------------------------------------------------------' >> ${logfilepath}
        ls -alhR ${JSONRepopathroot} >> ${logfilepath}
        echo '-------------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
fi

if ${CLIparm_NOHUP} ; then
    # Cleanup Potential file indicating script is active for nohup mode
    if [ -r ${script2nohupactive} ] ; then
        rm ${script2nohupactive} >> ${logfilepath} 2>&1
    fi
fi

export dtgs_script_finish=`date -u +%F-%T-%Z`
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo
#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-23


# =================================================================================================
# END:  Publish, Cleanup, and Dump output
# =================================================================================================
# =================================================================================================


