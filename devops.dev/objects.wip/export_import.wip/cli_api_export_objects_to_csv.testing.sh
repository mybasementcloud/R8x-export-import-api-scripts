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
#
# -#- Start Making Changes Here -#- 
#
# SCRIPT Object export to CSV file for API CLI Operations - testing - selective enabled objects
#
#
ScriptVersion=00.60.09
ScriptRevision=000
ScriptSubRevision=025
ScriptDate=2022-04-29
TemplateVersion=00.60.09
APISubscriptsLevel=010
APISubscriptsVersion=00.60.09
APISubscriptsRevision=000

#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=cli_api_export_objects_to_csv.testing
export APIScriptFileNameRoot=cli_api_export_objects_to_csv.testing
export APIScriptShortName=export_objects_to_csv.testing
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Object export to CSV file for API CLI Operations - testing - selective enabled objects"

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
# Root script declarations
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

export script_main_operation='export'

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

# MODIFIED 2021-11-09 -
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

# ADDED 2021-11-09 - MODIFIED 2021-11-09 -
#
# Presumptive folder structure for R8X API Management CLI (mgmt_cli) Template based scripts
#
# <script_home_folder> is the folder containing the script set, generally /var/log/__customer/devops|devops.dev|devops.dev.test
# [.wip] named folders are for development operations
#
# ...<script_home_folder>/_api_subscripts                       ## _api_subscripts folder for all scripts
# ...<script_home_folder>/_templates[.wip]                      ## _templates[.wip] folder for all scripts
# ...<script_home_folder>/tools                                 ## tools folder for all scripts with additional tools not assumed on system
# ...<script_home_folder>/objects[.wip]                         ## objects[.wip] folder for objects operations focused scripts
# ...<script_home_folder>/objects[.wip]/csv_tools[.wip]         ## csv_tools[.wip] folder for objects operations for csv handling focused scripts
# ...<script_home_folder>/objects[.wip]/export_import[.wip]     ## export_import[.wip] folder for objects operations export, import, set, rename, and delete focused scripts
# ...<script_home_folder>/Policy_and_Layers[.wip]               ## Policy_and_Layers[.wip] folder for policy and layers operations focused scripts
# ...<script_home_folder>/Session_Cleanup[.wip]                 ## Session_Cleanup[.wip] folder for Session Cleanup operation focused scripts
# ...<script_home_folder>/tools.MDSM[.wip]                      ## tools.MDSM[.wip] folder for Tools focused on MDSM operations scripts
#
#
# api_subscripts_default_root is defined with the assumption that scripts are running in a subfolder of the <script_home_folder> folder


# MODIFIED 2021-11-09 -
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
elif [ -r "./${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, didn't find the api subscripts in the default root, instead found them in the working folder
    export api_subscripts_root=.
elif [ -r "../../${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, didn't find the api subscripts in the default root, or in the working folder, but they were two (2) levels up
    export api_subscripts_root=../..
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

# Configure basic information for formation of file path for action handler scripts
#
# APIScriptActionFileRoot - root path to for action handler scripts
# APIScriptActionFileFolder - folder under root path to for action handler scripts
# APIScriptActionFilePath - path, for action handler scripts
#
export APIScriptActionFileRoot=.
export APIScriptActionFileFolder=

export APIScriptActionFilePrefix=cli_api_actions

export APIScriptJSONActionFilename=${APIScriptActionFilePrefix}.'export_objects_to_json'.sh
#export APIScriptJSONActionFilename=${APIScriptActionFilePrefix}'_actions_'${APIScriptVersion}.sh

export APIScriptCSVActionFilename=${APIScriptActionFilePrefix}.'export_objects_to_csv'.sh
#export APIScriptCSVActionFilename=${APIScriptActionFilePrefix}'_actions_to_csv_'${APIScriptVersion}.sh

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


# MODIFIED 2020-11-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    rm ${templogfilepath} >> ${logfilepath} 2>&1
    
    touch ${templogfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    rm ${templogfilepath} >> ${logfilepath} 2>&1
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ForceShowTempLogFile () {
    #
    # ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
    #
    
    cat ${templogfilepath} | tee -a -i ${logfilepath}
    
    rm ${templogfilepath} >> ${logfilepath} 2>&1
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# REMOVED 2020-11-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Moved to mgmt_cli_api_operations.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh script
#
#CheckStatusOfAPI

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ REMOVED 2020-11-16


# -------------------------------------------------------------------------------------------------
# GetScriptSourceFolder - Get the actual source folder for the running script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetScriptSourceFolder () {
    #
    # repeated procedure description
    #
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
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
    
    echo `${dtzs}`${dtzsep} "SOURCE is '${SOURCE}'" >> ${logfilepath}
    
    RDIR="$( dirname "${SOURCE}" )"
    DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
    if [ "${DIR}" != "${RDIR}" ]; then
        echo `${dtzs}`${dtzsep} "DIR '${RDIR}' resolves to '${DIR}'" >> ${logfilepath}
    fi
    echo `${dtzs}`${dtzsep} "DIR is '${DIR}'" >> ${logfilepath}
    
    export ScriptSourceFolder=${DIR}
    echo `${dtzs}`${dtzsep} "ScriptSourceFolder is '${ScriptSourceFolder}'" >> ${logfilepath}
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-21


# REMOVED 2020-11-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Moved to basic_script_setup_API_scripts.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh script
#
#ConfigureJQLocation
#GaiaWebSSLPortCheck
#ScriptAPIVersionCheck
#CheckAPIScriptVerboseOutput

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ REMOVED 2020-11-16


# -------------------------------------------------------------------------------------------------
# End of procedures block
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# We need the Script's actual source folder to find subscripts
#
GetScriptSourceFolder


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-16


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
# MODIFIED 2021-11-09 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Specific Scripts Command Line Parameters
#
# --type-of-export <export_type> | --type-of-export=<export_type>
#  Supported <export_type> values for export to CSV :  <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name">
#    "standard" {DEFAULT} :  Standard Export of all supported object key values
#    "name-only"          :  Export of just the name key value for object
#    "name-and-uid"       :  Export of name and uid key value for object
#    "uid-only"           :  Export of just the uid key value of objects
#    "rename-to-new-name" :  Export of name key value for object rename
#    For an export for a delete operation via CSV, use "name-only"
#
# -f <format[all|csv|json]> | --format <format[all|csv|json]> | -f=<format[all|csv|json]> | --format=<format[all|csv|json]> 
#
# --details <level[all|full|standard]> | --DETAILSLEVEL <level[all|full|standard]> | --details=<level[all|full|standard]> | --DETAILSLEVEL=<level[all|full|standard]> 
#
# --DEVOPSRESULTS | --RESULTS
# --DEVOPSRESULTSPATH <results_path> | --RESULTSPATH <results_path> | --DEVOPSRESULTSPATH=<results_path> | --RESULTSPATH=<results_path> 
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
#export TypeOfExport="standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"
export TypeOfExport="standard"
export CLIparm_TypeOfExport=${TypeOfExport}
export ExportTypeIsStandard=true

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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-11-09


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
# Check API Keep Alive Status - CheckAPIKeepAlive
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Check API Keep Alive Status.
#
CheckAPIKeepAlive () {
    #
    # Check API Keep Alive Status and on error try a login attempt
    #
    
    errorreturn=0
    
    if ${LoggedIntoMgmtCli} ; then
        echo -n `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  ' | tee -a -i ${logfilepath}
        if ${addversion2keepalive} ; then
            mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${logfilepath} 2>> ${logfilepath}
            export errorreturn=$?
        else
            mgmt_cli keepalive -s ${APICLIsessionfile} >> ${logfilepath} 2>> ${logfilepath}
            export errorreturn=$?
        fi
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli keepalive operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
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
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-04-29

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
# Start executing Main operations
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Configure working paths for export and dump
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
#

# ------------------------------------------------------------------------
# Set and clear temporary log file
# ------------------------------------------------------------------------

export templogfilepath=/var/tmp/templog_${ScriptName}.`date +%Y%m%d-%H%M%S%Z`.log
echo `${dtzs}`${dtzsep} > ${templogfilepath}

echo `${dtzs}`${dtzsep} 'Configure working paths for export and dump' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}

# ------------------------------------------------------------------------

# MODIFIED 2021-10-24 -
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

# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -

if [ ! -z "${domainnamenospace}" ] && [ ! ${CLIparm_NODOMAINFOLDERS} ] ; then
    # Handle adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}/${domainnamenospace}
    
    echo `${dtzs}`${dtzsep} 'Handle adding domain name to path for MDM operations' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
    fi
    
    export JSONRepopathbase=${JSONRepopathroot}/${domainnamenospace}
    
    echo `${dtzs}`${dtzsep} 'Handle adding domain name to JSON repository path for MDM operations' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
    
    if [ ! -r ${JSONRepopathbase} ] ; then
        mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>> ${templogfilepath}
    fi
else
    # NOT adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}
    
    echo `${dtzs}`${dtzsep} 'NOT adding domain name to path for MDM operations' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
    fi
    
    export JSONRepopathbase=${JSONRepopathroot}
    
    echo `${dtzs}`${dtzsep} 'NOT adding domain name to JSON repository path for MDM operations' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
    
    if [ ! -r ${JSONRepopathbase} ] ; then
        mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>> ${templogfilepath}
    fi
fi

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------
# This section is specific to scripts that are NOT action handlers
# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
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
    mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
fi

echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'After Evaluation of script type' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
#

if [ x"${primarytargetoutputformat}" = x"${FileExtJSON}" ] ; then
    # for JSON provide the detail level
    
    export APICLIpathexport=${APICLIpathexport}/${APICLIdetaillvl}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
    fi
    
    export APICLIJSONpathexportwip=
    if ${script_uses_wip_json} ; then
        # script uses work-in-progress (wip) folder for json
        
        export APICLIJSONpathexportwip=${APICLIpathexport}/wip
        
        if [ ! -r ${APICLIJSONpathexportwip} ] ; then
            mkdir -p -v ${APICLIJSONpathexportwip} >> ${templogfilepath} 2>> ${templogfilepath}
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

# MODIFIED 2021-10-22 -
#

if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
    # for CSV handle specifics, like wip
    
    export APICLICSVpathexportwip=
    if ${script_uses_wip} ; then
        # script uses work-in-progress (wip) folder for csv
        
        export APICLICSVpathexportwip=${APICLIpathexport}/wip
        
        if [ ! -r ${APICLICSVpathexportwip} ] ; then
            mkdir -p -v ${APICLICSVpathexportwip} >> ${templogfilepath} 2>> ${templogfilepath}
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

# MODIFIED 2021-10-25 -
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

# MODIFIED 2021-10-22 -
#

echo `${dtzs}`${dtzsep} >> ${templogfilepath}

cat ${templogfilepath} >> ${logfilepath} 2>> ${logfilepath}
rm -v ${templogfilepath} >> ${logfilepath} 2>> ${logfilepath}

# ------------------------------------------------------------------------

# MODIFIED 2021-10-24 -
#

#printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'X' "${X}" >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Working operations file and path variables' >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'MinAPIObjectLimit' "${MinAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'MaxAPIObjectLimit' "${MaxAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'RecommendedAPIObjectLimitMDSM' "${RecommendedAPIObjectLimitMDSM}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'DefaultAPIObjectLimit' "${DefaultAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'DefaultAPIObjectLimitMDSM' "${DefaultAPIObjectLimitMDSM}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'primarytargetoutputformat' "${primarytargetoutputformat}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIpathexport' "${APICLIpathexport}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathroot' "${JSONRepopathroot}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathbase' "${JSONRepopathbase}" >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
#

echo `${dtzs}`${dtzsep} 'Dump "'${APICLIdetaillvl}'" details to path:  '${APICLIpathexport} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# MODIFIED 2021-10-22 -


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Main Operational repeated proceedures - Export Objects to raw JSON
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureObjectQuerySelector - Configure Object Query Selector value objectqueryselector
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ConfigureObjectQuerySelector () {
    #
    
    # -------------------------------------------------------------------------------------------------
    # Configure Object Query Selector value objectqueryselector
    # -------------------------------------------------------------------------------------------------
    
    export objectqueryselector=
    
    # Current alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    
    # selector for objects created by customer and not from Check Point
    
    export notsystemobjectselector='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not'
    
    # based on some interesting feedback, adding ability to dump only system objects, not created by customer
    
    export onlysystemobjectselector='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a)'
    
    # also handle the specifics around whether meta-info.creator is or is not "System"
    
    export notcreatorissystemselector='."meta-info"."creator" != "System"'
    
    export creatorissystemselector='."meta-info"."creator" = "System"'
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        if ${CreatorIsNotSystem} ; then
            # Ignore System Objects and no creator = System
            export objectqueryselector='select( ('${notsystemobjectselector}') and ('${notcreatorissystemselector}') )'
        else
            # Ignore System Objects
            export objectqueryselector='select('${notsystemobjectselector}')'
        fi
    elif ${OnlySystemObjects} ; then
        # Select only System Objects
        if ${CreatorIsSystem} ; then
            # select only System Objects and creator = System
            export objectqueryselector='select( ('${onlysystemobjectselector}') and ('${creatorissystemselector}') )'
        else
            # select only System Objects
            export objectqueryselector='select('${onlysystemobjectselector}')'
        fi
    else
        # Include System Objects
        if ${CreatorIsNotSystem} ; then
            # Include System Objects and no creator = System
            export objectqueryselector='select( '${notcreatorissystemselector}')'
        elif ${CreatorIsSystem} ; then
            # Include System Objects and no creator = System
            export objectqueryselector='select( '${creatorissystemselector}')'
        else
            # Include System Objects
            export objectqueryselector=
        fi
    fi
    
    echo `${dtzs}`${dtzsep} ' -- ConfigureObjectQuerySelector:' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '    - NoSystemObjects='${NoSystemObjects}' OnlySystemObjects='${OnlySystemObjects}' CreatorIsNotSystem='${CreatorIsNotSystem}' CreatorIsSystem='${CreatorIsSystem} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '    - Object Query Selector = ['${objectqueryselector}']' >> ${logfilepath}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-24 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportObjectsToCSVviaJQ () {
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2021-11-09 -
    
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
    
    # Build the object type specific output file
    
    export APICLICSVfilename=${APICLIobjectstype}
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
    
    echo `${dtzs}`${dtzsep} 'Using the following details level for the JSON Repository = '${JSONRepoDetailname} >> ${logfilepath}
    
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
    
    export JSONRepofilename=${APICLIobjectstype}
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
    
    if [ ! -r ${APICLICSVpathexportwip} ] ; then
        mkdir -p -v ${APICLICSVpathexportwip} >> ${logfilepath} 2>> ${logfilepath}
    fi
    
    if [ -r ${APICLICSVfile} ] ; then
        rm ${APICLICSVfile} >> ${logfilepath} 2>> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileheader} ] ; then
        rm ${APICLICSVfileheader} >> ${logfilepath} 2>> ${logfilepath}
    fi
    if [ -r ${APICLICSVfiledata} ] ; then
        rm ${APICLICSVfiledata} >> ${logfilepath} 2>> ${logfilepath}
    fi
    if [ -r ${APICLICSVfilesort} ] ; then
        rm ${APICLICSVfilesort} >> ${logfilepath} 2>> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileoriginal} ] ; then
        rm ${APICLICSVfileoriginal} >> ${logfilepath} 2>> ${logfilepath}
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-24


# -------------------------------------------------------------------------------------------------
# The FinalizeExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
        
    elif [ ! -r "${APICLICSVfiledata}" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!! Error data file missing : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Terminating!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 253
        
    elif [ ! -s "${APICLICSVfiledata}" ] ; then
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# StandardExportCSVandJQParameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The StandardExportCSVandJQParameters handles standard configuration of the CSV and JQ export parameters.
#

StandardExportCSVandJQParameters () {
    #
    
    errorreturn=0
    
    # MODIFIED 2021-01-18 -
    #
    # The standard output for each CSV is name, color, comments block, by default.  This
    # object data exists for all objects, plus the UID.  In the future there may be  more
    # CLI Parameter controls provided to just dump the name, name & UID, or just UID 
    # instead of the full dump of values.  These are useful for things like delete operations
    #
    
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
    
    # MODIFIED 2021-01-16 -
    # Let's only do this one time for each object and put this at the end of the collected data
    
    if ${CSVEXPORT05TAGS} ; then
        export CSVFileHeader=${CSVFileHeader}',"tags.0","tags.1","tags.2","tags.3","tags.4"'
        export CSVJQparms=${CSVJQparms}', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"]'
    fi
    
    if ${CSVEXPORT10TAGS} ; then
        export CSVFileHeader=${CSVFileHeader}',"tags.5","tags.6","tags.7","tags.8","tags.9"'
        export CSVJQparms=${CSVJQparms}', .["tags"][5]["name"], .["tags"][6]["name"], .["tags"][7]["name"], .["tags"][8]["name"], .["tags"][9]["name"]'
    fi
    
    if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        export CSVFileHeader=${CSVFileHeader}',"uid","domain.name","domain.domain-type"'
        export CSVJQparms=${CSVJQparms}', .["uid"], .["domain"]["name"], .["domain"]["domain-type"]'
    fi
    
    if ${CLIparm_CSVEXPORTDATACREATOR} ; then
        export CSVFileHeader=${CSVFileHeader}',"meta-info.creator","meta-info.creation-time.iso-8601","meta-info.last-modifier","meta-info.last-modify-time.iso-8601"'
        export CSVJQparms=${CSVJQparms}', .["meta-info"]["creator"], .["meta-info"]["creation-time"]["iso-8601"], .["meta-info"]["last-modifier"], .["meta-info"]["last-modify-time"]["iso-8601"]'
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SpecialExportCSVandJQParameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-02-15 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SpecialExportCSVandJQParameters handles Special configuration of the CSV and JQ export parameters.
#

SpecialExportCSVandJQParameters () {
    #
    
    errorreturn=0
    
    # MODIFIED 2022-02-15 -
    # Let's only do this one time for each object and put this at the end of the collected data
    
    if ${CSVEXPORT05TAGS} ; then
        export CSVFileHeader=${CSVFileHeader}',"tags.0","tags.1","tags.2","tags.3","tags.4"'
        export CSVJQparms=${CSVJQparms}', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"]'
    fi
    
    if ${CSVEXPORT10TAGS} ; then
        export CSVFileHeader=${CSVFileHeader}',"tags.5","tags.6","tags.7","tags.8","tags.9"'
        export CSVJQparms=${CSVJQparms}', .["tags"][5]["name"], .["tags"][6]["name"], .["tags"][7]["name"], .["tags"][8]["name"], .["tags"][9]["name"]'
    fi
    
    if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        case "${TypeOfExport}" in
            'name-only' )
                export CSVFileHeader=${CSVFileHeader}',"uid"'
                export CSVJQparms=${CSVJQparms}', .["uid"]'
                ;;
            # a "name-and-uid" export operation
        esac
        
        export CSVFileHeader=${CSVFileHeader}',"domain.name","domain.domain-type"'
        export CSVJQparms=${CSVJQparms}', .["domain"]["name"], .["domain"]["domain-type"]'
    fi
    
    if ${CLIparm_CSVEXPORTDATACREATOR} ; then
        export CSVFileHeader=${CSVFileHeader}',"meta-info.creator","meta-info.creation-time.iso-8601","meta-info.last-modifier","meta-info.last-modify-time.iso-8601"'
        export CSVJQparms=${CSVJQparms}', .["meta-info"]["creator"], .["meta-info"]["creation-time"]["iso-8601"], .["meta-info"]["last-modifier"], .["meta-info"]["last-modify-time"]["iso-8601"]'
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-02-15


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureExportCSVandJQParameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-02-14 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    # MODIFIED 2022-02-14 -
    
    case "${TypeOfExport}" in
        # a "Standard" export operation
        'standard' )
            #export APICLIexportnameaddon=
            #export APICLIexportnameaddon=${APICLIexportnameaddon}
            StandardExportCSVandJQParameters
            ;;
        # a "name-only" export operation
        'name-only' )
            export CSVFileHeader='"name"'
            export CSVJQparms='.["name"]'
            #export APICLIexportnameaddon=
            #export APICLIexportnameaddon='name-only'
            export APICLIdetaillvl=name
            SpecialExportCSVandJQParameters
            ;;
        # a "name-and-uid" export operation
        'name-and-uid' )
            export CSVFileHeader='"name","uid"'
            export CSVJQparms='.["name"], .["uid"]'
            #export APICLIexportnameaddon=
            #export APICLIexportnameaddon='name-and-uid'
            export APICLIdetaillvl=name_and_uid
            SpecialExportCSVandJQParameters
            ;;
        # a "uid-only" export operation
        'uid-only' )
            export CSVFileHeader='"uid"'
            export CSVJQparms='.["uid"]'
            #export APICLIexportnameaddon=
            #export APICLIexportnameaddon='uid-only'
            export APICLIdetaillvl=uid
            SpecialExportCSVandJQParameters
            ;;
        # a "rename-to-new-nam" export operation
        'rename-to-new-name' )
            export CSVFileHeader='"name","new-name"'
            export CSVJQparms='.["name"], .["name"]'
            #export APICLIexportnameaddon=
            #export APICLIexportnameaddon='rename-to-new-name'
            export APICLIdetaillvl=rename
            # rename-to-new-name is a specific operation and we don't support the other extensions like taks and complete meta information
            #
            #SpecialExportCSVandJQParameters
            ;;
        # Anything unknown is handled as "standard"
        * )
            StandardExportCSVandJQParameters
            ;;
    esac
    
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
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-02-14


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-03-11 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportObjectsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjectstype} item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectsToCSVviaJQ () {
    #
    
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
    
    export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}' --conn-timeout '${APICLIconntimeout}
    
    export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    
    export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}
    #export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}' '${MgmtCLI_IgnoreErr_OpParms}
    
    if ${APIobjectderefgrpmem} ; then
        export MgmtCLI_Show_OpParms='dereference-group-members true '${MgmtCLI_Show_OpParms}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    objectstoshow=${objectstotal}
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    if [ -r ${JSONRepoFile} ] ; then
        # JSON Repository File for the target object exists, lets check for the number objects
        checkJSONRepoTotal=`cat ${JSONRepoFile} | ${JQ} ".total"`
        JSONRepoObjectsTotal=${checkJSONRepoTotal}
        if [ x"${JSONRepoObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was -lt 1 (so zero)' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # JSON Repository File for the target object DOES NOT exists
        JSONRepoObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    export domgmtcliquery=false
    
    # MODIFIED 2022-04-29 -
    if ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        elif ${OnlySystemObjects} ; then
            # Only System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        else
            # Include System Objects
            if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        fi
    else
        # Use of JSON Repository Enabled
        export domgmtcliquery=false
        echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
    fi
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APICLIobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Export '${APICLIobjectstype}' to CSV File' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  and dump to '${APICLICSVfile} | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} '  mgmt_cli parameters   :  '${MgmtCLI_Show_OpParms} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Object Query Selector :  '${objectqueryselector} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
            echo ${CSVJQparms} >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
        fi
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
                echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ : Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ : Problem during mgmt_cli JQ Parsing operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
            currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
            
            # MODIFIED 2022-03-10 -
            
            CheckAPIKeepAlive
            
        done
        
    else
        # Execute the JSON repository query instead
        
        echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APICLIobjecttype}' objects from the JSON repository file '${JSONRepoFile} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Export '${APICLIobjectstype}' to CSV File' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  and dump to '${APICLICSVfile} | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} '  mgmt_cli parameters   :  '${MgmtCLI_Show_OpParms} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Object Query Selector :  '${objectqueryselector} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  CSVJQparms :  ' >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
            echo ${CSVJQparms} >> ${logfilepath}
            echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' >> ${logfilepath}
        fi
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
            echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ : Problem during JSON Repository file query operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    errorreturn=0
    
    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ : Problem found in procedure FinalizeExportObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportObjectsToCSVviaJQ procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-03-11


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
        echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli objectstotal operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
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

# MODIFIED 2022-03-11 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckAPIVersionAndExecuteOperation () {
    #
    # Check the API Version running where we're logged in and if good execute operation
    #
    
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
    echo `${dtzs}`${dtzsep} 'Required minimum API version for object : '${APICLIobjectstype}' is API version = '${APIobjectminversion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Logged in management server API version = '${CurrentAPIVersion}' Check version : "'${CheckAPIVersion}'"' | tee -a -i ${logfilepath}
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) ] ; then
        # API is sufficient version
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        ExportObjectsToCSVviaJQ
        errorreturn=$?
        
        echo `${dtzs}`${dtzsep} 'CheckAPIVersionAndExecuteOperation call to ExportObjectsToCSVviaJQ procedure returned :  '${errorreturn} >> ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in ExportObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
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
        echo `${dtzs}`${dtzsep} 'Current API Version ('${CurrentAPIVersion}') does not meet minimum API version expected requirement ('${APIobjectminversion}')' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! skipping object '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        if ${ABORTONERROR} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CheckAPIVersionAndExecuteOperation procedure, but continueing' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'CheckAPIVersionAndExecuteOperation procedure returns :  '${errorreturn} >> ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-03-11


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
export scriptactiondescriptor='Export to CSV for testing'

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - simple objects - '${scriptactiondescriptor}' starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Network Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Network Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# host objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address","ipv6-address"'
export CSVFileHeader=${CSVFileHeader}',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.ipv4-address","nat-settings.ipv6-address","nat-settings.method"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address"], .["ipv6-address"]'
export CSVJQparms=${CSVJQparms}', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"]'
export CSVJQparms=${CSVJQparms}', .["nat-settings"]["ipv4-address"], .["nat-settings"]["ipv6-address"], .["nat-settings"]["method"]'

objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_hosts="${objectstotal_hosts}"
export number_of_objects=${number_hosts}

if [ x"${number_of_objects}" != x"" ] ; then
    # There are NOT null objects, so process
    
    CheckAPIVersionAndExecuteOperation
    
else
    # There are null objects, so skip
    echo `${dtzs}`${dtzsep} 'Attempt to determine number of objects of type '${APICLIobjectstype}' resulted in NULL response!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Skipping!...' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
fi


# -------------------------------------------------------------------------------------------------
# host objects - NO NAT Details
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=NO_NAT

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address","ipv6-address"'
#export CSVFileHeader=${CSVFileHeader}',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.ipv4-address","nat-settings.ipv6-address","nat-settings.method"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address"], .["ipv6-address"]'
#export CSVJQparms=${CSVJQparms}', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"]'
#export CSVJQparms=${CSVJQparms}', .["nat-settings"]["ipv4-address"], .["nat-settings"]["ipv6-address"], .["nat-settings"]["method"]'

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_hosts="${objectstotal_hosts}"
        export number_of_objects=${number_hosts}
        
        if [ x"${number_of_objects}" != x"" ] ; then
            # There are NOT null objects, so process
            
            CheckAPIVersionAndExecuteOperation
            
        else
            # There are null objects, so skip
            echo `${dtzs}`${dtzsep} 'Attempt to determine number of objects of type '${APICLIobjectstype}' resulted in NULL response!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Skipping!...' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
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


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=network
export APICLIobjectstype=networks
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"broadcast","subnet4","mask-length4","subnet6","mask-length6"'
export CSVFileHeader=${CSVFileHeader}',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.method"'

export CSVJQparms=
export CSVJQparms='.["broadcast"], .["subnet4"], .["mask-length4"], .["subnet6"], .["mask-length6"]'
export CSVJQparms=${CSVJQparms}', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"], .["nat-settings"]["method"]'

objectstotal_networks=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_networks="$objectstotal_networks"
export number_of_objects=${number_networks}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# wildcard objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.2
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=wildcard
export APICLIobjectstype=wildcards
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address","ipv4-mask-wildcard","ipv6-address","ipv6-mask-wildcard"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address"], .["ipv4-mask-wildcard"], .["ipv6-address"], .["ipv6-mask-wildcard"]'

objectstotal_wildcards=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_wildcards="${objectstotal_wildcards}"
export number_of_objects=${number_wildcards}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader='"name","color","comments"'

export CSVJQparms=
#export CSVJQparms='.["name"], .["color"], .["comments"]'

objectstotal_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_groups="${objectstotal_groups}"
export number_of_objects=${number_groups}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=group-with-exclusion
export APICLIobjectstype=groups-with-exclusion
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"include","except"'

export CSVJQparms=
export CSVJQparms='.["include"]["name"], .["except"]["name"]'

objectstotal_groupswithexclusion=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_groupswithexclusion="${objectstotal_groupswithexclusion}"
export number_of_objects=${number_groupswithexclusion}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=address-range
export APICLIobjectstype=address-ranges
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address-first","ipv4-address-last"'
export CSVFileHeader=${CSVFileHeader}',"ipv6-address-first","ipv6-address-last"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address-first"], .["ipv4-address-last"]'
export CSVJQparms=${CSVJQparms}', .["ipv6-address-first"], .["ipv6-address-last"]'

objectstotal_addressranges=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_addressranges="${objectstotal_addressranges}"
export number_of_objects=${number_addressranges}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# multicast-address-range objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=multicast-address-range
export APICLIobjectstype=multicast-address-ranges
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address-first","ipv4-address-last"'
export CSVFileHeader=${CSVFileHeader}',"ipv6-address-first","ipv6-address-last"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address-first"], .["ipv4-address-last"]'
export CSVJQparms=${CSVJQparms}', .["ipv6-address-first"], .["ipv6-address-last"]'

objectstotal_multicastaddressranges=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_multicastaddressranges="${objectstotal_multicastaddressranges}"
export number_of_objects=${number_multicastaddressranges}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=dns-domain
export APICLIobjectstype=dns-domains
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"is-sub-domain"'

export CSVJQparms=
export CSVJQparms='.["is-sub-domain"]'

objectstotal_dnsdomains=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_dnsdomains="${objectstotal_dnsdomains}"
export number_of_objects=${number_dnsdomains}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# security-zone objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_securityzones=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_securityzones="${objectstotal_securityzones}"
export number_of_objects=${number_securityzones}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dynamic-object objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_dynamicobjects=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_dynamicobjects="${objectstotal_dynamicobjects}"
export number_of_objects=${number_dynamicobjects}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tag objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=tag
export APICLIobjectstype=tags
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_tags=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tags="${objectstotal_tags}"
export number_of_objects=${number_tags}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-gateway objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_simplegateways=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_simplegateways="${objectstotal_simplegateways}"
export number_of_objects=${number_simplegateways}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-cluster objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=simple-cluster
export APICLIobjectstype=simple-clusters
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_simpleclusters=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_simpleclusters="${objectstotal_simpleclusters}"
export number_of_objects=${number_simpleclusters}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# checkpoint-host objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=checkpoint-hosts
export APICLIobjectstype=checkpoint-hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_checkpointhosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_checkpointhosts="${objectstotal_checkpointhosts}"
export number_of_objects=${number_checkpointhosts}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=time
export APICLIobjectstype=times
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"start.date","start.time","start.iso-8601","start.posix","start-now"'
export CSVFileHeader=${CSVFileHeader}',"end.date","end.time","end.iso-8601","end.posix","end-never"'
export CSVFileHeader=${CSVFileHeader}',"recurrence.pattern"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["start"]["date"], .["start"]["time"], .["start"]["iso-8601"], .["start"]["posix"], .["start-now"]'
export CSVJQparms=${CSVJQparms}', .["end"]["date"], .["end"]["time"], .["end"]["iso-8601"], .["end"]["posix"], .["end-never"]'
export CSVJQparms=${CSVJQparms}', .["recurrence"]["pattern"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_times=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_times="${objectstotal_times}"
export number_of_objects=${number_times}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time_group objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_time_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_time_groups="${objectstotal_time_groups}"
export number_of_objects=${number_time_groups}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-role objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_access_roles=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_access_roles="${objectstotal_access_roles}"
export number_of_objects=${number_access_roles}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# opsec-application objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"type"'
export CSVFileHeader=${CSVFileHeader}',"cpmi.enabled","cpmi.administrator-profile","cpmi.use-administrator-credentials"'
export CSVFileHeader=${CSVFileHeader}',"lea.enabled","lea.access-permissions","lea.administrator-profile"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms='.["name"], .["color"], .["comments"]'

export CSVJQparms=${CSVJQparms}', .["type"]'
export CSVJQparms=${CSVJQparms}', .["cpmi"]["enabled"], .["cpmi"]["administrator-profile"], .["cpmi"]["use-administrator-credentials"]'
export CSVJQparms=${CSVJQparms}', .["lea"]["enabled"], .["lea"]["access-permissions"], .["lea"]["administrator-profile"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_opsec_applications=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_opsec_applications="${objectstotal_opsec_applications}"
export number_of_objects=${number_opsec_applications}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# trusted-client objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=trusted-client
export APICLIobjectstype=trusted-clients
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_trustedclients=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_trustedclients="${objectstotal_trustedclients}"
export number_of_objects=${number_trustedclients}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsv-profile objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=lsv-profile
export APICLIobjectstype=lsv-profiles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_lsvprofiles=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_lsvprofiles="${objectstotal_lsvprofiles}"
export number_of_objects=${number_number_lsvprofiles}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# gsn-handover-group objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=gsn-handover-group
export APICLIobjectstype=gsn-handover-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_gsnhandovergroups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_gsnhandovergroups="${objectstotal_gsnhandovergroups}"
export number_of_objects=${number_gsnhandovergroups}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-point-name objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=access-point-names
export APICLIobjectstype=access-point-names
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_accesspointnames=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_accesspointnames="${objectstotal_accesspointnames}"
export number_of_objects=${number_accesspointnames}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-server objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-29 -

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.7
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"server-type"'
export CSVFileHeader=${CSVFileHeader}',"server"'
export CSVFileHeader=${CSVFileHeader}',"service"'
export CSVFileHeader=${CSVFileHeader}',"priority"'
export CSVFileHeader=${CSVFileHeader}',"encryption"'
export CSVFileHeader=${CSVFileHeader}',"secret-key"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["server-type"]'
export CSVJQparms=${CSVJQparms}', .["server"]["name"]'
export CSVJQparms=${CSVJQparms}', .["service"]["name"]'
export CSVJQparms=${CSVJQparms}', .["priority"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]'
export CSVJQparms=${CSVJQparms}', ""'
#export CSVJQparms=${CSVJQparms}', "Y0urP4$$w04dH3r3"'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_tacacsservers=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tacacsservers="${objectstotal_tacacsservers}"
export number_of_objects=${number_tacacsservers}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.7
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=tacacs-group
export APICLIobjectstype=tacacs-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=

export CSVJQparms=

objectstotal_tacacsgroups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tacacsgroups="${objectstotal_tacacsgroups}"
export number_of_objects=${number_tacacsgroups}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsm-gateways objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.8
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=lsm-gateway
export APICLIobjectstype=lsm-gateways
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"security-profile"'
export CSVFileHeader=${CSVFileHeader}',"sic.ip-address"'
export CSVFileHeader=${CSVFileHeader}',"provisioning-state","provisioning-settings.provisioning-profile"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'

export CSVJQparms=
export CSVJQparms='.["security-profile"]'
export CSVJQparms=${CSVJQparms}', .["ip-address"]'
export CSVJQparms=${CSVJQparms}', .["provisioning-state"], .["provisioning-settings"]["provisioning-profile"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'

objectstotal_lsmgateways=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_lsmgateways="${objectstotal_lsmgateways}"
export number_of_objects=${number_lsmgateways}

CheckAPIVersionAndExecuteOperation


export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.8
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=lsm-gateway
export APICLIobjectstype=lsm-gateways
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=DO_NOT_IMPORT

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"security-profile"'
export CSVFileHeader=${CSVFileHeader}',"ip-address","sic-name","sic-state"'
export CSVFileHeader=${CSVFileHeader}',"version","os-name"'
export CSVFileHeader=${CSVFileHeader}',"provisioning-state","provisioning-settings.provisioning-profile"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'

export CSVJQparms=
export CSVJQparms='.["security-profile"]'
export CSVJQparms=${CSVJQparms}', .["ip-address"], .["sic-name"], .["sic-state"]'
export CSVJQparms=${CSVJQparms}', .["version"], .["os-name"]'
export CSVJQparms=${CSVJQparms}', .["provisioning-state"], .["provisioning-settings"]["provisioning-profile"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'

objectstotal_lsmgateways2=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_lsmgateways2="${objectstotal_lsmgateways2}"
export number_of_objects=${number_lsmgateways2}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsm-clusters objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.8
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=lsm-cluster
export APICLIobjectstype=lsm-clusters
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=

export CSVJQparms=

objectstotal_lsmclusters=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_lsmclusters="${objectstotal_lsmclusters}"
export number_of_objects=${number_lsmclusters}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Service & Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Service & Applications' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# services-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"port","protocol","source-port"'
export CSVFileHeader=${CSVFileHeader}',"aggressive-aging.enable","aggressive-aging.default-timeout","aggressive-aging.timeout","aggressive-aging.use-default-timeout"'
export CSVFileHeader=${CSVFileHeader}',"keep-connections-open-after-policy-installation","match-by-protocol-signature","match-for-any","override-default-settings"'
export CSVFileHeader=${CSVFileHeader}',"session-timeout","use-default-session-timeout","sync-connections-on-cluster"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'

export CSVJQparms=
export CSVJQparms='.["port"], .["protocol"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-by-protocol-signature"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'

objectstotal_services_tcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_tcp="${objectstotal_services_tcp}"
export number_of_objects=${number_services_tcp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"port","protocol","source-port"'
export CSVFileHeader=${CSVFileHeader}',"accept-replies","aggressive-aging.enable","aggressive-aging.default-timeout","aggressive-aging.timeout","aggressive-aging.use-default-timeout"'
export CSVFileHeader=${CSVFileHeader}',"keep-connections-open-after-policy-installation","match-by-protocol-signature","match-for-any","override-default-settings"'
export CSVFileHeader=${CSVFileHeader}',"session-timeout","use-default-session-timeout","sync-connections-on-cluster"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'

export CSVJQparms=
export CSVJQparms='.["port"], .["protocol"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["accept-replies"], .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-by-protocol-signature"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'

objectstotal_services_udp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_udp="${objectstotal_services_udp}"
export number_of_objects=${number_services_udp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"icmp-code","icmp-type","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["icmp-code"], .["icmp-type"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_icmp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_icmp="${objectstotal_services_icmp}"
export number_of_objects=${number_services_icmp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"icmp-code","icmp-type","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["icmp-code"], .["icmp-type"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_icmp6=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_icmp6="${objectstotal_services_icmp6}"
export number_of_objects=${number_services_icmp6}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"port","source-port"'
export CSVFileHeader=${CSVFileHeader}',"aggressive-aging.enable","aggressive-aging.default-timeout","aggressive-aging.timeout","aggressive-aging.use-default-timeout"'
export CSVFileHeader=${CSVFileHeader}',"keep-connections-open-after-policy-installation","match-for-any"'
export CSVFileHeader=${CSVFileHeader}',"session-timeout","use-default-session-timeout","sync-connections-on-cluster"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'

export CSVJQparms=
export CSVJQparms='.["port"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-for-any"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'

objectstotal_services_sctp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_sctp="${objectstotal_services_sctp}"
export number_of_objects=${number_services_sctp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"port","source-port"'
export CSVFileHeader=${CSVFileHeader}',"accept-replies","ip-protocol","action","match"'
export CSVFileHeader=${CSVFileHeader}',"aggressive-aging.enable","aggressive-aging.default-timeout","aggressive-aging.timeout","aggressive-aging.use-default-timeout"'
export CSVFileHeader=${CSVFileHeader}',"keep-connections-open-after-policy-installation","match-for-any","override-default-settings"'
export CSVFileHeader=${CSVFileHeader}',"session-timeout","use-default-session-timeout","sync-connections-on-cluster"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'

export CSVJQparms=
export CSVJQparms='.["port"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["accept-replies"], .["ip-protocol"], .["action"], .["match"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'

objectstotal_services_other=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_other="${objectstotal_services_other}"
export number_of_objects=${number_services_other}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"interface-uuid","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["interface-uuid"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_dce_rpc=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_dce_rpc="${objectstotal_services_dce_rpc}"
export number_of_objects=${number_services_dce_rpc}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"program-number","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["program-number"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_rpc=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_rpc="${objectstotal_services_rpc}"
export number_of_objects=${number_services_rpc}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-gtp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.7
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-gtp
export APICLIobjectstype=services-gtp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"version"'

export CSVFileHeader=${CSVFileHeader}',"allow-usage-of-static-ip"'
export CSVFileHeader=${CSVFileHeader}',"cs-fallback-and-srvcc"'

export CSVFileHeader=${CSVFileHeader}',"restoration-and-recovery"'
export CSVFileHeader=${CSVFileHeader}',"reverse-service"'
export CSVFileHeader=${CSVFileHeader}',"trace-management"'

export CSVFileHeader=${CSVFileHeader}',"access-point-name.enable"'
export CSVFileHeader=${CSVFileHeader}',"access-point-name.apn"'

export CSVFileHeader=${CSVFileHeader}',"apply-access-policy-on-user-traffic.enable"'
export CSVFileHeader=${CSVFileHeader}',"apply-access-policy-on-user-traffic.add-imsi-field-to-log"'

export CSVFileHeader=${CSVFileHeader}',"imsi-prefix.enable"'
export CSVFileHeader=${CSVFileHeader}',"imsi-prefix.prefix"'

export CSVFileHeader=${CSVFileHeader}',"interface-profile.profile"'
export CSVFileHeader=${CSVFileHeader}',"interface-profile.custom-message-types"'

export CSVFileHeader=${CSVFileHeader}',"ldap-group.enable"'
export CSVFileHeader=${CSVFileHeader}',"ldap-group.group"'
export CSVFileHeader=${CSVFileHeader}',"ldap-group.according-to"'

export CSVFileHeader=${CSVFileHeader}',"ms-isdn.enable"'
export CSVFileHeader=${CSVFileHeader}',"ms-isdn.ms-isdn"'
export CSVFileHeader=${CSVFileHeader}',"selection-mode.enable"'
export CSVFileHeader=${CSVFileHeader}',"selection-mode.mode"'

export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.utran"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.geran"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.wlan"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.gan"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.hspa-evolution"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.eutran"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.virtual"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.nb-iot"'

export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.other-types-range.enable"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.other-types-range.types"'

#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["version"]'

export CSVJQparms=${CSVJQparms}', .["allow-usage-of-static-ip"]'
export CSVJQparms=${CSVJQparms}', .["cs-fallback-and-srvcc"]'

export CSVJQparms=${CSVJQparms}', .["restoration-and-recovery"]'
export CSVJQparms=${CSVJQparms}', .["reverse-service"]'
export CSVJQparms=${CSVJQparms}', .["trace-management"]'

export CSVJQparms=${CSVJQparms}', .["access-point-name"]["enable"]'
export CSVJQparms=${CSVJQparms}', .["access-point-name"]["apn"]["name"]'

export CSVJQparms=${CSVJQparms}', .["apply-access-policy-on-user-traffic"]["enable"]'
export CSVJQparms=${CSVJQparms}', .["apply-access-policy-on-user-traffic"]["add-imsi-field-to-log"]'

export CSVJQparms=${CSVJQparms}', .["imsi-prefix"]["enable"]'
export CSVJQparms=${CSVJQparms}', .["imsi-prefix"]["prefix"]'

export CSVJQparms=${CSVJQparms}', .["interface-profile"]["profile"]["name"]'
export CSVJQparms=${CSVJQparms}', .["interface-profile"]["custom-message-types"]'

export CSVJQparms=${CSVJQparms}', .["ldap-group"]["enable"]'
export CSVJQparms=${CSVJQparms}', .["ldap-group"]["group"]["name"]'
export CSVJQparms=${CSVJQparms}', .["ldap-group"]["according-to"]'

export CSVJQparms=${CSVJQparms}', .["ms-isdn"]["enable"]'
export CSVJQparms=${CSVJQparms}', .["ms-isdn"]["ms-isdn"]'
export CSVJQparms=${CSVJQparms}', .["selection-mode"]["enable"]'
export CSVJQparms=${CSVJQparms}', .["selection-mode"]["mode"]'

export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["utran"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["geran"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["wlan"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["gan"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["hspa-evolution"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["eutran"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["virtual"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["nb-iot"]'

export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["other-types-range"]["enable"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["other-types-range"]["types"]'

#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescitrixtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescitrixtcp="${objectstotal_servicescitrixtcp}"
export number_of_objects=${number_servicescitrixtcp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-citrix-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-citrix-tcp
export APICLIobjectstype=services-citrix-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"application"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["application"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescitrixtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescitrixtcp="${objectstotal_servicescitrixtcp}"
export number_of_objects=${number_servicescitrixtcp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-compound-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-compound-tcp
export APICLIobjectstype=services-compound-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"compound-service","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["compound-service"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescompoundtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescompoundtcp="${objectstotal_servicescompoundtcp}"
export number_of_objects=${number_servicescompoundtcp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=

export CSVJQparms=

objectstotal_service_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_service_groups="${objectstotal_service_groups}"
export number_of_objects=${number_service_groups}

#CheckAPIVersionAndExecuteOperation


#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-08-28

# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-22 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"primary-category"'
# The risk key is not imported
#export CSVFileHeader=${CSVFileHeader}',"risk"'
export CSVFileHeader=${CSVFileHeader}',"urls-defined-as-regular-expression"'
# The next elements are more complex elements, but required for import add operation
export CSVFileHeader=${CSVFileHeader}',"url-list.0"'
export CSVFileHeader=${CSVFileHeader}',"application-signature.0"'
# The next elements are more complex elements, but NOT required for import add operation
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
export CSVFileHeader=${CSVFileHeader}',"description"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["primary-category"]'
# The risk key is not imported
#export CSVJQparms=${CSVJQparms}', .["risk"]'
export CSVJQparms=${CSVJQparms}', .["urls-defined-as-regular-expression"]'
# The next elements are more complex elements, but required for import add operation
export CSVJQparms=${CSVJQparms}', .["url-list"][0]'
export CSVJQparms=${CSVJQparms}', .["application-signature"][0]'
# The next elements are more complex elements, but NOT required for import add operation
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_application_sites=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_sites="${objectstotal_application_sites}"
export number_of_objects=${number_application_sites}

CheckAPIVersionAndExecuteOperation


export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=REFERENCE_ONLY

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"application-id","primary-category"'
# The risk key is not imported
export CSVFileHeader=${CSVFileHeader}',"risk"'
export CSVFileHeader=${CSVFileHeader}',"urls-defined-as-regular-expression"'
# user-defined can't be imported so while shown, it adds no value for normal operations
export CSVFileHeader=${CSVFileHeader}',"user-defined"'
# The next elements are more complex elements, but required for import add operation
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
export CSVFileHeader=${CSVFileHeader}',"application-signature.0"'
export CSVFileHeader=${CSVFileHeader}',"application-signature.1"'
export CSVFileHeader=${CSVFileHeader}',"application-signature.2"'
export CSVFileHeader=${CSVFileHeader}',"application-signature.3"'
export CSVFileHeader=${CSVFileHeader}',"application-signature.4"'
# The next elements are more complex elements, but NOT required for import add operation
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.1"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.2"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.3"'
export CSVFileHeader=${CSVFileHeader}',"additional-categories.4"'
export CSVFileHeader=${CSVFileHeader}',"description"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["application-id"], .["primary-category"]'
# The risk key is not imported
export CSVJQparms=${CSVJQparms}', .["risk"]'
export CSVJQparms=${CSVJQparms}', .["urls-defined-as-regular-expression"]'
# user-defined can't be imported so while shown, it adds no value for normal operations
export CSVJQparms=${CSVJQparms}', .["user-defined"]'
# The next elements are more complex elements, but required for import add operation
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
export CSVJQparms=${CSVJQparms}', .["application-signature"][0]'
export CSVJQparms=${CSVJQparms}', .["application-signature"][1]'
export CSVJQparms=${CSVJQparms}', .["application-signature"][2]'
export CSVJQparms=${CSVJQparms}', .["application-signature"][3]'
export CSVJQparms=${CSVJQparms}', .["application-signature"][4]'
# The next elements are more complex elements, but NOT required for import add operation
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][1]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][2]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][3]'
export CSVJQparms=${CSVJQparms}', .["additional-categories"][4]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        objectstotal_application_sites=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_application_sites="${objectstotal_application_sites}"
        export number_of_objects=${number_application_sites}
        
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
        echo `${dtzs}`${dtzsep} 'Skipping '"'${APICLIobjectstype}" "${APICLIexportnameaddon}"'for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        ;;
esac


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-22 - 
# MODIFIED 2021-01-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
# user-defined can't be imported so while shown, it adds no value for normal operations
if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export CSVFileHeader='"user-defined"'
fi

export CSVJQparms=
# user-defined can't be imported so while shown, it adds no value for normal operations
if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export CSVJQparms='.["user-defined"]'
fi

objectstotal_application_site_categories=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_site_categories="${objectstotal_application_site_categories}"
export number_of_objects=${number_application_site_categories}

#CheckAPIVersionAndExecuteOperation


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-19
# MODIFIED 2021-01-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=

export CSVJQparms=

objectstotal_application_site_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_site_groups="${objectstotal_application_site_groups}"
export number_of_objects=${number_application_site_groups}

#CheckAPIVersionAndExecuteOperation


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-19

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Users
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# ADDED 2021-01-31 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Users' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2021-01-31

# -------------------------------------------------------------------------------------------------
# user objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-28\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

# User export with credential information is not working properly when done this way, so not exporting authentication method here.
# Handling the export of explicit per user authentication method and inforamtion later in specific complex objects, one export for each authentication-method
# NOTE:  It is not possible to export users Check Point Password value

export CSVFileHeader=
export CSVFileHeader='"template","e-mail","phone-number"'
#export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server","tacacs-server"'
#export CSVFileHeader=${CSVFileHeader}',"expiration-date"'
export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["template"], .["e-mail"], .["phone-number"]'
#export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
#export CSVJQparms=${CSVJQparms}', .["expiration-date"]["iso-8601"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_users=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_users="${objectstotal_users}"
export number_of_objects=${number_users}

CheckAPIVersionAndExecuteOperation

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-28
# MODIFIED 2021-06-01\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=REFERENCE_ONLY

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

# User export with credential information is not working properly when done this way, so not exporting authentication method here.
# Handling the export of explicit per user authentication method and inforamtion later in specific complex objects, one export for each authentication-method
# NOTE:  It is not possible to export users Check Point Password value

export CSVFileHeader=
export CSVFileHeader='"template","e-mail","phone-number"'
export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server","tacacs-server"'
export CSVFileHeader=${CSVFileHeader}',"expiration-date"'
export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["template"], .["e-mail"], .["phone-number"]'
export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
export CSVJQparms=${CSVJQparms}', .["expiration-date"]["iso-8601"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        objectstotal_application_sites=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_application_sites="${objectstotal_application_sites}"
        export number_of_objects=${number_application_sites}
        
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
        echo `${dtzs}`${dtzsep} 'Skipping '"'${APICLIobjectstype}" "${APICLIexportnameaddon}"'for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        ;;
esac

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-06-01


# -------------------------------------------------------------------------------------------------
# user-group objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-28\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=user-group
export APICLIobjectstype=user-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"email"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["email"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_user_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_user_groups="${objectstotal_user_groups}"
export number_of_objects=${number_user_groups}

CheckAPIVersionAndExecuteOperation

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-28

# -------------------------------------------------------------------------------------------------
# user-template objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-28\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"authentication-method","radius-server","tacacs-server"'
#export CSVFileHeader=${CSVFileHeader}',"expiration-by-global-properties","expiration-date"'
export CSVFileHeader=${CSVFileHeader}',"expiration-by-global-properties"'
export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
#export CSVJQparms=${CSVJQparms}', .["expiration-by-global-properties"], .["expiration-date"]["iso-8601"]'
export CSVJQparms=${CSVJQparms}', .["expiration-by-global-properties"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_user_templates=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_user_templates="${objectstotal_user_templates}"
export number_of_objects=${number_user_templates}

CheckAPIVersionAndExecuteOperation

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-28
# MODIFIED 2021-06-01\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=REFERENCE_ONLY

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"authentication-method","radius-server","tacacs-server"'
export CSVFileHeader=${CSVFileHeader}',"expiration-by-global-properties","expiration-date"'
export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
export CSVJQparms=${CSVJQparms}', .["expiration-by-global-properties"], .["expiration-date"]["iso-8601"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        objectstotal_user_templates=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_user_templates="${objectstotal_user_templates}"
        export number_of_objects=${number_user_templates}
        
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
        echo `${dtzs}`${dtzsep} 'Skipping '"'${APICLIobjectstype}" "${APICLIexportnameaddon}"'for export type '${TypeOfExport}'!...' | tee -a -i ${logfilepath}
        ;;
esac

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-06-01

# -------------------------------------------------------------------------------------------------
# identity-tag objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-28\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=identity-tag
export APICLIobjectstype=identity-tags
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"external-identifier"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["external-identifier"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_identity_tags=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_identity_tags="${objectstotal_identity_tags}"
export number_of_objects=${number_identity_tags}

CheckAPIVersionAndExecuteOperation

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-28


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# no more simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - simple objects - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - complex objects - '${scriptactiondescriptor}' Starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


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

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportComplexObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportComplexObjectsToCSVviaJQ () {
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2021-11-09 -
    
    export WorkAPIObjectLimit=${MaxAPIObjectLimit}
    if [ -z "${domainnamenospace}" ] ; then
        # an empty ${domainnamenospace} indicates that we are not working towards an MDSM
        export WorkAPIObjectLimit=${APIobjectrecommendedlimit}
    else
        # an empty ${domainnamenospace} indicates that we are working towards an MDSM
        export WorkAPIObjectLimit=${APIobjectrecommendedlimitMDSM}
    fi
    
    echo `${dtzs}`${dtzsep} ' - WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' >> ${logfilepath}
    
    if ${OverrideMaxObjects} ; then
        echo `${dtzs}`${dtzsep} ' - Override Maximum Objects ['${WorkAPIObjectLimit}'] with OverrideMaxObjectsNumber :  '${OverrideMaxObjectsNumber}' objects value' | tee -a -i ${logfilepath}
        export WorkAPIObjectLimit=${OverrideMaxObjectsNumber}
    fi
    
    echo `${dtzs}`${dtzsep} ' - Final WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
    
    export APICLICSVfilename=${APICLIcomplexobjectstype}
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
    
    echo `${dtzs}`${dtzsep} 'Using the following details level for the JSON Repository = '${JSONRepoDetailname} >> ${logfilepath}
    
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
    
    export JSONRepofilename=${APICLIobjectstype}
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
    
    if [ ! -r ${APICLICSVpathexportwip} ] ; then
        mkdir -p -v ${APICLICSVpathexportwip} >> ${logfilepath} 2>> ${logfilepath}
    fi
    
    if [ -r ${APICLICSVfile} ] ; then
        rm ${APICLICSVfile} >> ${logfilepath} 2>> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileheader} ] ; then
        rm ${APICLICSVfileheader} >> ${logfilepath} 2>> ${logfilepath}
    fi
    if [ -r ${APICLICSVfiledata} ] ; then
        rm ${APICLICSVfiledata} >> ${logfilepath} 2>> ${logfilepath}
    fi
    if [ -r ${APICLICSVfilesort} ] ; then
        rm ${APICLICSVfilesort} >> ${logfilepath} 2>> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileoriginal} ] ; then
        rm ${APICLICSVfileoriginal} >> ${logfilepath} 2>> ${logfilepath}
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# FinalizeExportComplexObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-22 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
        
    elif [ ! -r "${APICLICSVfiledata}" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!!!! Error data file missing : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Terminating!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 253
        
    elif [ ! -s "${APICLICSVfiledata}" ] ; then
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-22


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Common Complex Object Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Generic Complex Objects Type Handler
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


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

# MODIFIED 2022-04-29:04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfObjectsTypeFromMgmtDB generates an array of objects type objects for further processing.

PopulateArrayOfObjectsTypeFromMgmtDB () {
    
    errorreturn=0
    
    # MODIFIED 2022-04-22 -
    
    # System Object selection operands
    # MODIFIED 2022-04-22 - 
    # Current alternative if more options to exclude are needed
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} '  '${APICLIobjectstype}' - Populate up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentobjecttypesoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIobjectstype}'   Using Object Query Selector "'${objectqueryselector}'"' | tee -a -i ${logfilepath}
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${OnlySystemObjects} ; then
        # Only System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${CreatorIsNotSystem} ; then
        # Only System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${CreatorIsSystem} ; then
        # Only System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        # Don't Ignore System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level standard -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} '    Read Objects into array:  ' | tee -a -i ${logfilepath}
    while read -r line; do
        ALLOBJECTSTYPARRAY+=("${line}")
        echo -n '.' | tee -a -i ${logfilepath}
    done <<< "${MGMT_CLI_OBJECTSTYPE_STRING}"
    errorreturn=$?
    echo | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29:04


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfObjectsTypeFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# ADDED 2022-04-29:04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfObjectsTypeFromJSONRepository generates an array of objects type objects from the JSON Repository file for further processing.

PopulateArrayOfObjectsTypeFromJSONRepository () {
    
    errorreturn=0
    
    # MODIFIED 2022-04-22 -
    
    # System Object selection operands
    # MODIFIED 2022-04-22 - 
    # Current alternative if more options to exclude are needed
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} '  '${APICLIobjectstype}' - Populate up to this number ['${JSONRepoObjectsTotal}'] of '${APICLIobjecttype}' objects' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIobjectstype}'   Using Object Query Selector "'${objectqueryselector}'"' | tee -a -i ${logfilepath}
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        JSON_REPO_OBJECTSTYPE_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${OnlySystemObjects} ; then
        # Ignore System Objects
        JSON_REPO_OBJECTSTYPE_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${CreatorIsNotSystem} ; then
        # Ignore System Objects
        JSON_REPO_OBJECTSTYPE_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${CreatorIsSystem} ; then
        # Ignore System Objects
        JSON_REPO_OBJECTSTYPE_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        # Don't Ignore System Objects
        JSON_REPO_OBJECTSTYPE_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} '    Read Objects into array:  ' | tee -a -i ${logfilepath}
    while read -r line; do
        ALLOBJECTSTYPARRAY+=("${line}")
        echo -n '.' | tee -a -i ${logfilepath}
    done <<< "${JSON_REPO_OBJECTSTYPE_STRING}"
    errorreturn=$?
    echo | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29:04


# -------------------------------------------------------------------------------------------------
# GetArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfObjectsType generates an array of objects type objects for further processing.

GetArrayOfObjectsType () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Generate array of '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    export ALLOBJECTSTYPARRAY=()
    export ObjectsOfTypeToProcess=false
    
    export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}' --conn-timeout '${APICLIconntimeout}
    export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    
    export MgmtCLI_Show_OpParms='details-level "'${APICLIdetaillvl}'" '${MgmtCLI_Base_OpParms}
    
    if ${APIobjectderefgrpmem} ; then
        export MgmtCLI_Show_OpParms='dereference-group-members true '${MgmtCLI_Show_OpParms}
    fi
    
    CheckAPIKeepAlive
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    export objectstoshow=${objectstotal}
    
    if [ -r ${JSONRepoFile} ] ; then
        # JSON Repository File for the target object exists, lets check for the number objects
        checkJSONRepoTotal=`cat ${JSONRepoFile} | ${JQ} ".total"`
        JSONRepoObjectsTotal=${checkJSONRepoTotal}
        if [ x"${JSONRepoObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was -lt 1 (so zero)' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # JSON Repository File for the target object DOES NOT exists
        JSONRepoObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    export domgmtcliquery=false
    
    # MODIFIED 2022-04-29 -
    if ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        elif ${OnlySystemObjects} ; then
            # Only System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        else
            # Include System Objects
            if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        fi
    else
        # Use of JSON Repository Enabled
        export domgmtcliquery=false
        echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
    fi
    
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
                echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in PopulateArrayOfObjectsTypeFromMgmtDB procedure' | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in PopulateArrayOfObjectsTypeFromJSONRepository procedure' | tee -a -i ${logfilepath}
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


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

# MODIFIED 2022-04-29:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
            
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = NULL (0 zero)' >> ${logfilepath}
            
            #return 0
            
        elif [[ ${NUM_OBJECTSTYPE_MEMBERS} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members < 1 ['${NUM_OBJECTSTYPE_MEMBERS}'] (0 zero)' >> ${logfilepath}
            
            #return 0
           
        else
            # More than zero (1) interfaces, something to process
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = '"${NUM_OBJECTSTYPE_MEMBERS}" | tee -a -i ${logfilepath}
            
            export CSVJQmemberparms='"'${objectnametoevaluate}'", '${CSVJQmemberparmsbase}
            
            echo `${dtzs}`${dtzsep} 'CSVJQmemberparms : ' >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            echo ${CSVJQmemberparms} >> ${logfilepath}
            echo '------------------------------------------------------------------------       ' | >> ${logfilepath}
            
            # MODIFIED 2021-10-23
            # What is this?  Multiple jq operations to consolidate the operation into a single strike
            # 0.)  Output the Repository file of ${APICLIobjecttype} for jq processing
            #      Action: ]# mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json
            # 1.)  Get the current objects members as a seperate list
            #      Action: ]# ${JQ} '.objects[] | select(.name == "'"${objectnametoevaluate}"'") | .members[]'
            # 2.)  Pipe that json list of members objects, which are not clean to a jq slurp action to make them usable as an array
            #      Action: ]# ${JQ} -s '.'
            # 3.)  Pipe the results from the jq slurp to make an array, to jq to parse for the ${CSVJQmemberparms} items into CSV format
            #      Action: ]# ${JQ} '.[] | [ '"${CSVJQmemberparms}"' ] | @csv' -r
            #
            
            mgmt_cli show ${APICLIobjecttype} name "${objectnametoevaluate}" -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.members[]' | ${JQ} -s '.' | ${JQ} '.[] | [ '"${CSVJQmemberparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
            
            if [ "${errorreturn}" != "0" ] ; then
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Error in JQ Operation in CollectMembersInObjectsTypeWithMgmtDB for object '${APICLIobjecttype}' with name '${objectnametoevaluate}' which may lead to failure to generate output!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            fi
        fi
        
    done
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29:02


# -------------------------------------------------------------------------------------------------
# CollectMembersInObjectsTypeWithJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
            
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = NULL (0 zero)' >> ${logfilepath}
            
            #return 0
           
        elif [[ ${NUM_OBJECTSTYPE_MEMBERS} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members < 1 ['${NUM_OBJECTSTYPE_MEMBERS}'] (0 zero)' >> ${logfilepath}
            
            #return 0
           
        else
            # More than zero (1) interfaces, something to process
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = '"${NUM_OBJECTSTYPE_MEMBERS}" | tee -a -i ${logfilepath}
            
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
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            fi
        fi
        
    done
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29:02


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
    
    if [ -r ${JSONRepoFile} ] ; then
        # JSON Repository File for the target object exists, lets check for the number objects
        checkJSONRepoTotal=`cat ${JSONRepoFile} | ${JQ} ".total"`
        export JSONRepoObjectsTotal=${checkJSONRepoTotal}
        if [ x"${JSONRepoObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was -lt 1 (so zero)' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # JSON Repository File for the target object DOES NOT exists
        JSONRepoObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    export domgmtcliquery=false
    
    # MODIFIED 2022-04-29 -
    if ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        elif ${OnlySystemObjects} ; then
            # Only System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        else
            # Include System Objects
            if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        fi
    else
        # Use of JSON Repository Enabled
        export domgmtcliquery=false
        echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
    fi
    
    errorreturn=0
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        CollectMembersInObjectsTypeWithMgmtDB
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CollectMembersInObjectsTypeWithMgmtDB procedure' | tee -a -i ${logfilepath}
        fi
        
    else
        # Execute the JSON repository query instead
        
        CollectMembersInObjectsTypeWithJSONRepository
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CollectMembersInObjectsTypeWithJSONRepository procedure' | tee -a -i ${logfilepath}
        fi
        
    fi
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# GetObjectMembers proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetObjectMembers generate output of objects type members from existing objects type objects

GetObjectMembers () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    
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
        echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in SetupExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    GetArrayOfObjectsType
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in GetArrayOfObjectsType procedure' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    if ${ObjectsOfTypeToProcess} ; then
        # we have objects left to process after generating the array of ObjectsType
        echo `${dtzs}`${dtzsep} 'Processing returned '${#ALLOBJECTSTYPARRAY[@]}' objects of type '${APICLIobjectstype}', so processing this object' | tee -a -i ${logfilepath}
        
        DumpArrayOfObjectsType
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in DumpArrayOfObjectsType procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        CollectMembersInObjectsType
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CollectMembersInObjectsType procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        FinalizeExportComplexObjectsToCSVviaJQ
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    else
        # The array of ObjectsType is empty, nothing to process
        echo `${dtzs}`${dtzsep} 'No objects of type '${APICLIobjectstype}' were returned to process, skipping further operations on this object' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GenericComplexObjectsMembersHandler proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GenericComplexObjectsMembersHandler () {
    #
    # Generic Handler for Complex Object Types
    
    errorreturn=0
    
    if ${ExportTypeIsStandard} ; then
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
            echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
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
        echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in GenericComplexObjectsMembersHandler procedure' | tee -a -i ${logfilepath}
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
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLIcomplexobjecttype=group-member
export APICLIcomplexobjectstype=group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

#GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Time Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLIcomplexobjecttype=time-group-member
export APICLIcomplexobjectstype=time-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

#export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : TACACS Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.7
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=tacacs-group
export APICLIobjectstype=tacacs-groups
export APICLIcomplexobjecttype=tacacs-group-member
export APICLIcomplexobjectstype=tacacs-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Service Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APICLIcomplexobjecttype=service-group-member
export APICLIcomplexobjectstype=service-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

#GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Application Site Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APICLIcomplexobjecttype=application-site-group-member
export APICLIcomplexobjectstype=application-site-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

#GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : user-group members
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 -

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=user-group
export APICLIobjectstype=user-groups
export APICLIcomplexobjecttype=user-group-member
export APICLIcomplexobjectstype=user-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Specific Complex Objects :  These require extra plumbing
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex Objects :  These require extra plumbing' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : host interfaces
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex OBJECT : host interfaces' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# MODIFIED 2021-01-27 -

# -------------------------------------------------------------------------------------------------
# PopulateArrayOfHostInterfacesFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-02-15 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfHostInterfacesFromMgmtDB populates array of host objects for further processing from Management DB via mgmt_cli.

PopulateArrayOfHostInterfacesFromMgmtDB () {
    
    errorreturn=0
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    # MODIFIED 2022-04-22 -
    
    # System Object selection operands
    # MODIFIED 2022-04-22 - 
    # Current alternative if more options to exclude are needed
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "  ${APICLIobjectstype} - Populate up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currenthostoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MGMT_CLI_HOSTS_STRING is a string with multiple lines. Each line contains a name of a host.
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${OnlySystemObjects} ; then
        # Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${CreatorIsNotSystem} ; then
        # Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${CreatorIsSystem} ; then
        # Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        # Don't Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level standard -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    while read -r line; do
        
        ALLHOSTSARR+=("${line}")
        
        echo -n `${dtzs}`${dtzsep} '.' | tee -a -i ${logfilepath}
        
        arraylength=${#ALLHOSTSARR[@]}
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
        
        #INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${ALLHOSTARR[${arrayelement}]})" details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".interfaces | length")
        INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${line})" details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".interfaces | length")
        
        NUM_HOST_INTERFACES=${INTERFACES_COUNT}
        
        if [ x"${NUM_HOST_INTERFACES}" == x"" ] ; then
            # There are null objects, so skip
            if ${APISCRIPTVERBOSE} ; then
                echo -n '0, ' | tee -a -i ${logfilepath}
            else
                echo -n '0' | tee -a -i ${logfilepath}
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
                echo -n '0, ' | tee -a -i ${logfilepath}
            else
                echo -n '0' | tee -a -i ${logfilepath}
            fi
            echo -n '-' | tee -a -i ${logfilepath}
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo | tee -a -i ${logfilepath}
        fi
        
    done <<< "${MGMT_CLI_HOSTS_STRING}"
    errorreturn=$?
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'HostInterfacesCount = '${HostInterfacesCount} | tee -a -i ${logfilepath}
    fi
    
    export HostInterfacesCount=${HostInterfacesCount}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-02-15


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfHostInterfacesFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-02-15 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfHostInterfacesFromJSONRepository populates array of host objects for further processing from JSON Repository.

PopulateArrayOfHostInterfacesFromJSONRepository () {
    
    errorreturn=0
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    # MODIFIED 2022-04-22 -
    
    # System Object selection operands
    # MODIFIED 2022-04-22 - 
    # Current alternative if more options to exclude are needed
    ConfigureObjectQuerySelector
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "  ${APICLIobjectstype} - Populate up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currenthostoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MGMT_CLI_HOSTS_STRING is a string with multiple lines. Each line contains a name of a host.
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        JSON_REPO_HOSTS_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${OnlySystemObjects} ; then
        # Ignore System Objects
        JSON_REPO_HOSTS_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${CreatorIsNotSystem} ; then
        # Ignore System Objects
        JSON_REPO_HOSTS_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    elif ${CreatorIsSystem} ; then
        # Ignore System Objects
        JSON_REPO_HOSTS_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .name | @sh' -r`"
    else
        # Don't Ignore System Objects
        JSON_REPO_HOSTS_STRING="`cat ${JSONRepoFile} | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    while read -r line; do
        
        ALLHOSTSARR+=("${line}")
        
        echo -n `${dtzs}`${dtzsep} '.' | tee -a -i ${logfilepath}
        
        arraylength=${#ALLHOSTSARR[@]}
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
        
        #INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${ALLHOSTARR[${arrayelement}]})" details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".interfaces | length")
        #INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${line})" details-level full -s ${APICLIsessionfile} --conn-timeout ${APICLIconntimeout} -f json | ${JQ} ".interfaces | length")
        INTERFACES_COUNT=$(cat ${JSONRepoFile} | ${JQ} '.objects[] | select(.name == "'"$(eval echo ${line})"'") | .interfaces | length')
        
        NUM_HOST_INTERFACES=${INTERFACES_COUNT}
        
        if [ x"${NUM_HOST_INTERFACES}" == x"" ] ; then
            # There are null objects, so skip
            if ${APISCRIPTVERBOSE} ; then
                echo -n '0, ' | tee -a -i ${logfilepath}
            else
                echo -n '0' | tee -a -i ${logfilepath}
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
                echo -n '0, ' | tee -a -i ${logfilepath}
            else
                echo -n '0' | tee -a -i ${logfilepath}
            fi
            echo -n '-' | tee -a -i ${logfilepath}
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo | tee -a -i ${logfilepath}
        fi
        
    done <<< "${JSON_REPO_HOSTS_STRING}"
    errorreturn=$?
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'HostInterfacesCount = '${HostInterfacesCount} | tee -a -i ${logfilepath}
    fi
    
    export HostInterfacesCount=${HostInterfacesCount}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-02-15


# -------------------------------------------------------------------------------------------------
# GetArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-02-15 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfHostInterfaces generates an array of host objects for further processing.

GetArrayOfHostInterfaces () {
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Generate array of hosts' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    HOSTSARR=()
    ALLHOSTSARR=()
    
    export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}' --conn-timeout '${APICLIconntimeout}
    export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    
    export MgmtCLI_Show_OpParms='details-level "'${APICLIdetaillvl}'" '${MgmtCLI_Base_OpParms}
    
    if ${APIobjectderefgrpmem} ; then
        export MgmtCLI_Show_OpParms='dereference-group-members true '${MgmtCLI_Show_OpParms}
    fi
    
    CheckAPIKeepAlive
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    if [ -r ${JSONRepoFile} ] ; then
        # JSON Repository File for the target object exists, lets check for the number objects
        checkJSONRepoTotal=`cat ${JSONRepoFile} | ${JQ} ".total"`
        JSONRepoObjectsTotal=${checkJSONRepoTotal}
        if [ x"${JSONRepoObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was -lt 1 (so zero)' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # JSON Repository File for the target object DOES NOT exists
        JSONRepoObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    export domgmtcliquery=false
    
    # MODIFIED 2022-04-29 -
    if ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        elif ${OnlySystemObjects} ; then
            # Only System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        else
            # Include System Objects
            if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        fi
    else
        # Use of JSON Repository Enabled
        export domgmtcliquery=false
        echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
    fi
    
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
                echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in PopulateArrayOfHostInterfacesFromMgmtDB procedure' | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in PopulateArrayOfHostInterfacesFromJSONRepository procedure' | tee -a -i ${logfilepath}
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-02-15


# -------------------------------------------------------------------------------------------------
# DumpArrayOfHostsObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-22 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# CollectInterfacesInHostObjectsFromMgmtDB proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', .["subnet-mask"]'
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
            
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = NULL (0 zero)'
            
            #return 0
           
        elif [[ ${NUM_HOST_INTERFACES} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = 0 (0 zero)'
            
            #return 0
           
        elif [[ ${NUM_HOST_INTERFACES} -gt 0 ]] ; then
            # More than zero (0) interfaces, something to process
            echo `${dtzs}`${dtzsep} host "${hostnametoevaluate}"' number of interfaces = '"${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
            
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
                echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CollectInterfacesInHostObjectsFromMgmtDB mgmt_cli execution reading host '${hostnametoevaluate}' interfaces' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            CheckAPIKeepAlive
            
        else
            # ?? Whatever..., so skip
            echo `${dtzs}`${dtzsep}' host '"${hostnametoevaluate}"' number of interfaces = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjectsFromJSONRepository proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    export CSVJQinterfaceparmsbase=${CSVJQinterfaceparmsbase}', .["subnet-mask"]'
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
            
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = NULL (0 zero)'
            
            #return 0
           
        elif [[ ${NUM_HOST_INTERFACES} -lt 1 ]] ; then
            # no objects of this type
            
            echo `${dtzs}`${dtzsep}' Object '"${APICLIobjecttype}"' with name '"${objectnametoevaluate}"' number of members = 0 (0 zero)'
            
            #return 0
           
        elif [[ ${NUM_HOST_INTERFACES} -gt 0 ]] ; then
            # More than zero (0) interfaces, something to process
            echo `${dtzs}`${dtzsep} host "${hostnametoevaluate}"' number of interfaces = '"${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
            
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
                echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CollectInterfacesInHostObjectsFromJSONRepository JQ execution reading host '${hostnametoevaluate}' interfaces' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
        else
            # ?? Whatever..., so skip
            echo `${dtzs}`${dtzsep}' host '"${hostnametoevaluate}"' number of interfaces = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-22 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    if [ -r ${JSONRepoFile} ] ; then
        # JSON Repository File for the target object exists, lets check for the number objects
        checkJSONRepoTotal=`cat ${JSONRepoFile} | ${JQ} ".total"`
        JSONRepoObjectsTotal=${checkJSONRepoTotal}
        if [ x"${JSONRepoObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was -lt 1 (so zero)' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # JSON Repository File for the target object DOES NOT exists
        JSONRepoObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    export domgmtcliquery=false
    
    # MODIFIED 2022-04-29 -
    if ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        elif ${OnlySystemObjects} ; then
            # Only System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        else
            # Include System Objects
            if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        fi
    else
        # Use of JSON Repository Enabled
        export domgmtcliquery=false
        echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if ${domgmtcliquery} ; then
        # Execute the mgmt_cli query of the management host database
        
        CollectInterfacesInHostObjectsFromMgmtDB
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CollectInterfacesInHostObjectsFromMgmtDB procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    else
        # Execute the JSON repository query instead
        
        CollectInterfacesInHostObjectsFromJSONRepository
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CollectInterfacesInHostObjectsFromJSONRepository procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
    fi
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-22


# -------------------------------------------------------------------------------------------------
# GetHostInterfacesProcessor proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-03-10 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetHostInterfacesProcessor generate output of host's interfaces from existing hosts with interface objects

GetHostInterfacesProcessor () {
    
    errorreturn=0
    
    if ${ExportTypeIsStandard} ; then
        
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
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in SetupExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        GetArrayOfHostInterfaces
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in SetupExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in DumpArrayOfHostsObjects procedure' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            CollectInterfacesInHostObjects
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CollectInterfacesInHostObjects procedure' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
            
            FinalizeExportComplexObjectsToCSVviaJQ
            errorreturn=$?
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-03-10


# -------------------------------------------------------------------------------------------------
# GetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetHostInterfaces generate output of host's interfaces from existing hosts with interface objects using the processor

GetHostInterfaces () {
    
    errorreturn=0
    
    GetHostInterfacesProcessor
    errorreturn=$?
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in GetHostInterfacesProcessor procedure' | tee -a -i ${logfilepath}
        
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
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


## -------------------------------------------------------------------------------------------------
## Specific Complex OBJECT : host interfaces
## -------------------------------------------------------------------------------------------------

## MODIFIED 2021-01-27 - 

#export APIobjectrecommendedlimit=${WorkAPIObjectLimit}
#export APIobjectminversion=1.1
#export APIobjectcansetifexists=true
#export APICLIobjecttype=host
#export APICLIobjectstype=hosts
#export APICLIcomplexobjecttype=host-interface
#export APICLIcomplexobjectstype=host-interfaces
#export APICLICSVobjecttype=${APICLIcomplexobjectstype}
#export APICLIexportnameaddon=

##
## APICLICSVsortparms can change due to the nature of the object
##
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader='"name","interfaces.add.name"'
#export CSVFileHeader=${CSVFileHeader}',"interfaces.add.subnet4","interfaces.add.mask-length4"'
#export CSVFileHeader=${CSVFileHeader}',"interfaces.add.subnet6","interfaces.add.mask-length6"'
#export CSVFileHeader=${CSVFileHeader}',"interfaces.add.color","interfaces.add.comments"'

#export CSVJQparms='.["name"], .["interfaces"]['${COUNTER}']["name"]'
#export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet4"], .["interfaces"]['${COUNTER}']["mask-length4"]'
#export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet6"], .["interfaces"]['${COUNTER}']["mask-length6"]'
#export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["color"], .["interfaces"]['${COUNTER}']["comments"]'


## -------------------------------------------------------------------------------------------------
## -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
#export number_hosts="${objectstotal_hosts}"

#if [ ${number_hosts} -le 0 ] ; then
    ## No hosts found
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    #echo `${dtzs}`${dtzsep} 'No hosts to generate interfaces from!' | tee -a -i ${logfilepath}
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
#else
    ## hosts found
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    #echo `${dtzs}`${dtzsep} 'Check hosts to generate interfaces!' | tee -a -i ${logfilepath}
    #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    #GetHostInterfaces
#fi

#echo `${dtzs}`${dtzsep} '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
#echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : users authentications
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex OBJECT : users authentications' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# ExportObjectElementCriteriaBasedToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportObjectElementCriteriaBasedToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjectstype} item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectElementCriteriaBasedToCSVviaJQ () {
    #
    
    errorreturn=0
    
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
        echo `${dtzs}`${dtzsep} 'Problem found in procedure SetupExportComplexObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}' --conn-timeout '${APICLIconntimeout}
    
    export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    
    export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}
    
    if ${APIobjectderefgrpmem} ; then
        export MgmtCLI_Show_OpParms='dereference-group-members true '${MgmtCLI_Show_OpParms}
    fi
    
    # Back to what worked.
    # MODIFIED 2022-04-29 -
    
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
    
    # !! FAIL !!
    # MODIFIED 2022-04-22 -
    
    #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" == "'"${APICLIexportcriteria01value}"'"'
    #if ${APICLIexportcriteria01value} ; then 
        # The value of ${APICLIexportcriteria01value} is boolean true, so check if the value of ${APICLIexportcriteria01key} is true
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'"' 
    #elif ! ${APICLIexportcriteria01value} ; then 
        # The value of ${APICLIexportcriteria01value} is boolean false, so check if the value of ${APICLIexportcriteria01key} is not true
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" | not'
    #else 
        # The value of ${APICLIexportcriteria01value} is a string, not boolean, so check if the value of ${APICLIexportcriteria01key} is the same
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" == "'"${APICLIexportcriteria01value}"'"'
    #fi
    
    # MODIFIED 2022-04-22 -
    
    # System Object selection operands
    # MODIFIED 2022-04-22 - 
    # Current alternative if more options to exclude are needed
    ConfigureObjectQuerySelector
    
    # We need to assemble a more complicated selection method for this
    #
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        export userauthobjectselector='select(('"${objectqueryselector}"') and ('"${objecttypecriteriaselectorelement}"'))'
    elif ${OnlySystemObjects} ; then
        # Ignore System Objects
        export userauthobjectselector='select(('"${objectqueryselector}"') and ('"${objecttypecriteriaselectorelement}"'))'
    elif ${CreatorIsNotSystem} ; then
        # Ignore System Objects
        export userauthobjectselector='select(('"${objectqueryselector}"') and ('"${objecttypecriteriaselectorelement}"'))'
    elif ${CreatorIsSystem} ; then
        # Ignore System Objects
        export userauthobjectselector='select(('"${objectqueryselector}"') and ('"${objecttypecriteriaselectorelement}"'))'
    else
        # Don't Ignore System Objects
        export userauthobjectselector='select('"${objecttypecriteriaselectorelement}"')'
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Populate up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentuseroffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  '${APICLIcomplexobjectstype}' - Selection criteria '${userauthobjectselector} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    CheckAPIKeepAlive
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    export objectstoshow=${objectstotal}
    
    if [ -r ${JSONRepoFile} ] ; then
        # JSON Repository File for the target object exists, lets check for the number objects
        checkJSONRepoTotal=`cat ${JSONRepoFile} | ${JQ} ".total"`
        export JSONRepoObjectsTotal=${checkJSONRepoTotal}
        if [ x"${JSONRepoObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            export JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was NULL' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoObjectsTotal}' ] (so zero)' >> ${logfilepath}
            export JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # JSON Repository File for the target object DOES NOT exists
        export JSONRepoObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    export domgmtcliquery=false
    
    # MODIFIED 2022-04-29 -
    if ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        elif ${OnlySystemObjects} ; then
            # Only System Objects
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        else
            # Include System Objects
            if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                if ${script_use_json_repo} ; then
                    # Use of JSON Repository is indicated
                    export domgmtcliquery=false
                    echo `${dtzs}`${dtzsep} 'Using JSON Repository for ['${JSONRepoObjectsTotal}'] of '${APICLIobjectstype}' objects file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                else
                    # Use of JSON Repository is denied
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, 
                # so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
            fi
        fi
    else
        # Use of JSON Repository Enabled
        export domgmtcliquery=false
        echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
    fi
    
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
                echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'Problem during JSON Repository file query operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem found in procedure FinalizeExportComplexObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# GetObjectElementCriteriaBased proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetObjectElementCriteriaBased generate output of host's interfaces from existing hosts with interface objects

GetObjectElementCriteriaBased () {
    
    errorreturn=0
    
    if ${ExportTypeIsStandard} ; then
        
        ExportObjectElementCriteriaBasedToCSVviaJQ
        errorreturn=$?
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
        fi
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in ExportObjectElementCriteriaBasedToCSVviaJQ procedure' | tee -a -i ${logfilepath}
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
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-22 - 

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user
export APICLIobjectstype=users

#
# APICLICSVsortparms can change due to the nature of the object
#
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
#export CSVFileHeader='"template","e-mail","phone-number"'
#export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server","tacacs-server"'
#export CSVFileHeader=${CSVFileHeader}',"expiration-date"'
#export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
#export CSVJQparms='.["template"], .["e-mail"], .["phone-number"]'
#export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
#export CSVJQparms=${CSVJQparms}', .["expiration-date"]["iso-8601"]'
#export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# MODIFIED 2021-10-22 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_users=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_users="${objectstotal_users}"

if [ ${number_users} -le 0 ] ; then
    # No Users found
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate authentications from!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    # Users found
    
    # User export with credential information is not working properly when done as a complete object.
    # Handling the export of explicit per user authentication method and inforamtion later in specific complex objects, one export for each authentication-method
    # NOTE:  It is not possible to export users Check Point Password value
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  check point passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-checkpointpassword'
    export APICLIcomplexobjectstype='users-with-auth-checkpointpassword'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='check point password'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    # NOTE:  It is not possible to export users Check Point Password value
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"password"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', "Pr0v1d3Us3rPa$$W0rdH3r3!"'
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  os passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-ospassword'
    export APICLIcomplexobjectstype='users-with-auth-ospassword'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='os password'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  securid
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-securid'
    export APICLIcomplexobjectstype='users-with-auth-securid'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='securid'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  radius
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-radius'
    export APICLIcomplexobjectstype='users-with-auth-radius'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='radius'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    #export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server","tacacs-server"'
    #export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"radius-server"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', .["radius-server"]["name"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  tacacs
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-tacacs'
    export APICLIcomplexobjectstype='users-with-auth-tacacs'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='tacacs'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    
    #export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server","tacacs-server"'
    #export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
    
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"tacacs-server"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', .["tacacs-server"]["name"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  undefined
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-undefined'
    export APICLIcomplexobjectstype='users-with-auth-undefined'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='undefined'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-22


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user-template user authentications
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-22 - 

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates

#
# APICLICSVsortparms can change due to the nature of the object
#
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
#export CSVFileHeader='"authentication-method","radius-server","tacacs-server"'
#export CSVFileHeader=${CSVFileHeader}',"expiration-by-global-properties","expiration-date"'
#export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
#export CSVJQparms='.["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
#export CSVJQparms=${CSVJQparms}', .["expiration-by-global-properties"], .["expiration-date"]["iso-8601"]'
#export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# MODIFIED 2021-10-22 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_user_templates=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_user_templates="${objectstotal_user_templates}"

if [ ${number_user_templates} -le 0 ] ; then
    # No Users found
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate authentications from!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    # Users found
    
    # User export with credential information is not working properly when done as a complete object.
    # Handling the export of explicit per user authentication method and inforamtion later in specific complex objects, one export for each authentication-method
    # NOTE:  It is not possible to export users Check Point Password value
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user-template user authentications :  check point passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-29 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user-template
    export APICLIobjectstype=user-templates
    export APICLIcomplexobjecttype='user-template-with-auth-checkpointpassword'
    export APICLIcomplexobjectstype='user-templates-with-auth-checkpointpassword'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='check point password'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    # NOTE:  It is not possible to export users Check Point Password value
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"password"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', "Pr0v1d3Us3rPa$$W0rdH3r3!"'
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user-template user authentications :  os passwor
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user-template
    export APICLIobjectstype=user-templates
    export APICLIcomplexobjecttype='user-template-with-auth-ospassword'
    export APICLIcomplexobjectstype='user-templates-with-auth-ospassword'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='os password'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user-template user authentications :  securid
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user-template
    export APICLIobjectstype=user-templates
    export APICLIcomplexobjecttype='user-template-with-auth-securid'
    export APICLIcomplexobjectstype='user-templates-with-auth-securid'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='securid'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user-template user authentications :  radius
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user-template
    export APICLIobjectstype=user-templates
    export APICLIcomplexobjecttype='user-template-with-auth-radius'
    export APICLIcomplexobjectstype='user-templates-with-auth-radius'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='radius'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    #export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server","tacacs-server"'
    #export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"radius-server"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', .["radius-server"]["name"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user-template user authentications :  tacacs
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user-template
    export APICLIobjectstype=user-templates
    export APICLIcomplexobjecttype='user-template-with-auth-tacacs'
    export APICLIcomplexobjectstype='user-templates-with-auth-tacacs'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='tacacs'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    
    #export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server","tacacs-server"'
    #export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
    
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"tacacs-server"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', .["tacacs-server"]["name"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user-template user authentications :  undefined
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user-template
    export APICLIobjectstype=user-templates
    export APICLIcomplexobjecttype='user-template-with-auth-undefined'
    export APICLIcomplexobjectstype='user-templates-with-auth-undefined'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='authentication-method'
    export APICLIexportcriteria01value='undefined'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetObjectElementCriteriaBased
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-22


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user-template user expiration
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-22 - 

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates

#
# APICLICSVsortparms can change due to the nature of the object
#
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
#export CSVFileHeader='"authentication-method","radius-server","tacacs-server"'
#export CSVFileHeader=${CSVFileHeader}',"expiration-by-global-properties","expiration-date"'
#export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
#export CSVJQparms='.["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
#export CSVJQparms=${CSVJQparms}', .["expiration-by-global-properties"], .["expiration-date"]["iso-8601"]'
#export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# MODIFIED 2021-10-22 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_user_templates=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_user_templates="${objectstotal_user_templates}"

if [ ${number_user_templates} -le 0 ] ; then
    # No Users found
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate authentications from!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    # Users found
    
    # User export with credential information is not working properly when done as a complete object.
    # Handling the export of explicit per user authentication method and inforamtion later in specific complex objects, one export for each authentication-method
    # NOTE:  It is not possible to export users Check Point Password value
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user-template user expiration :  non-global expiration
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-10-22 - 
    
    export APIobjectminversion=1.6.1
    export APIobjectcansetifexists=false
    export APIobjectderefgrpmem=false
    export APICLIobjecttype=user-template
    export APICLIobjectstype=user-templates
    export APICLIcomplexobjecttype='user-template-with-non-global-expiration'
    export APICLIcomplexobjectstype='user-templates-with-non-global-expiration'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key='expiration-by-global-properties'
    export APICLIexportcriteria01value=false
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    # NOTE:  It is not possible to export users Check Point Password value
    
    export CSVFileHeader='"name","expiration-by-global-properties", "expiration-date"'
    #export CSVFileHeader=${CSVFileHeader}',"value"'
    
    export CSVJQparms='.["name"], .["expiration-by-global-properties"], .["expiration-date"]["iso-8601"]'
    #export CSVJQparms=${CSVJQparms}', "key"'
    
    GetObjectElementCriteriaBased
    
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-22


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - complex objects - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


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


