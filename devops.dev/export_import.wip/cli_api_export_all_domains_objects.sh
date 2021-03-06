#!/bin/bash
#
# SCRIPT Export objects from all domains, object export to JSON (standard and full details), and CSV file for API CLI Operations
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
ScriptVersion=00.60.06
ScriptRevision=020
ScriptDate=2021-02-23
TemplateVersion=00.60.06
APISubscriptsLevel=006
APISubscriptsVersion=00.60.06
APISubscriptsRevision=020

#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=cli_api_export_all_domains_objects
export APIScriptFileNameRoot=cli_api_export_all_domains_objects
export APIScriptShortName=export_all_domains_objects
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Export objects from all domains, object export to JSON (standard and full details), and CSV file for API CLI Operations"

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

export scriptspathroot=/var/log/__customer/upgrade_export/scripts

export rootscriptconfigfile=__root_script_config.sh

export logfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log


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


# ADDED 2021-02-21 -

# Configure whether this script operates against all domains by default, which affects -d CLI parameter handling for authentication
export OpsModeAllDomains=true


# 2018-05-02 - script type - export objects (all)

export script_use_publish="false"

export script_use_export="true"
export script_use_import="false"
export script_use_delete="false"
export script_use_csvfile="false"

export script_dump_csv="true"
export script_dump_json="true"
export script_dump_standard="true"
export script_dump_full="true"

export script_uses_wip="true"
export script_uses_wip_json="false"

# ADDED 2018-10-27 -
export UseR8XAPI=true
export UseJSONJQ=true

# ADDED 2020-02-07 -
export UseJSONJQ16=true

# MODIFIED 2019-01-17 -
# R80       version 1.0
# R80.10    version 1.1
# R80.20.M1 version 1.2
# R80.20 GA version 1.3
# R80.20.M2 version 1.4
# R80.30    version 1.5
# R80.40    version 1.6
# R80.40 JHF 78 version 1.6.1
# R81       version 1.7
#
# For common scripts minimum API version at 1.0 should suffice, otherwise get explicit
#
export MinAPIVersionRequired=1.1

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

# ADDED 2020-11-16 -
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
else
    # OK, didn't find the api subscripts where we expect to find them, so this is bad!
    echo | tee -a -i ${logfilepath}
    echo 'Missing critical api subscript files that are expected in the one of the following locations:' | tee -a -i ${logfilepath}
    echo ' PREFERRED Location :  '"${api_subscripts_default_root}/${api_subscripts_default_folder}/${api_subscripts_checkfile}" | tee -a -i ${logfilepath}
    echo ' ALTERNATE Location :  '"./${api_subscripts_default_folder}/${api_subscripts_checkfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Unable to continue without these api subscript files, so exiting!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Log File location : '"${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    exit 1
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -
# Configure basic information for formation of file path for basic script setup API Scripts handler script
#
# basic_script_setup_API_handler_root - root path to basic script setup API Scripts handler script. Period (".") indicates root of script source folder
# basic_script_setup_API_handler_folder - folder for under root path to basic script setup API Scripts handler script
# basic_script_setup_API_handler_file - filename, without path, for basic script setup API Scripts handler script
#

# MODIFIED 2020-11-16 -
export basic_script_setup_API_handler_root=..
export basic_script_setup_API_handler_folder=_api_subscripts
export basic_script_setup_API_handler_file=basic_script_setup_API_scripts.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -
# Configure basic information for formation of file path for command line parameter handler script
#
# cli_api_cmdlineparm_handler_root - root path to command line parameter handler script
# cli_api_cmdlineparm_handler_folder - folder for under root path to command line parameter handler script
# cli_api_cmdlineparm_handler_file - filename, without path, for command line parameter handler script
#

# MODIFIED 2020-09-09 -
export cli_api_cmdlineparm_handler_root=${api_subscripts_root}
export cli_api_cmdlineparm_handler_folder=${api_subscripts_default_folder}
export cli_api_cmdlineparm_handler_file=cmd_line_parameters_handler.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -
# Configure basic information for formation of file path for gaia version handler script
#
# gaia_version__handler_root - root path to gaia version handler script. Period (".") indicates root of script source folder
# gaia_version__handler_folder - folder for under root path to gaia version handler script
# gaia_version__handler_file - filename, without path, for gaia version handler script
#

# MODIFIED 2020-09-09 -
export gaia_version_handler_root=${api_subscripts_root}
export gaia_version_handler_folder=${api_subscripts_default_folder}
export gaia_version_handler_file=identify_gaia_and_installation.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -
# Configure basic information for formation of file path for Script Output Paths and Folders for API scripts handler script
#
# script_output_paths_API_handler_root - root path to Script Output Paths and Folders for API scripts handler script. Period (".") indicates root of script source folder
# script_output_paths_API_handler_folder - folder for under root path to Script Output Paths and Folders for API scripts handler script
# script_output_paths_API_handler_file - filename, without path, for Script Output Paths and Folders for API scripts handler script
#

# MODIFIED 2020-11-16 -
export script_output_paths_API_handler_root=..
export script_output_paths_API_handler_folder=_api_subscripts
export script_output_paths_API_handler_file=script_output_paths_and_folders_API_scripts.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -
# Configure basic information for formation of file path for basic script setup API Scripts handler script
#
# mgmt_cli_API_operations_handler_root - root path to basic script setup API Scripts handler script. Period (".") indicates root of script source folder
# mgmt_cli_API_operations_handler_folder - folder for under root path to basic script setup API Scripts handler script
# mgmt_cli_API_operations_handler_file - filename, without path, for basic script setup API Scripts handler script
#

# MODIFIED 2020-11-16 -
export mgmt_cli_API_operations_handler_root=..
export mgmt_cli_API_operations_handler_folder=_api_subscripts
export mgmt_cli_API_operations_handler_file=mgmt_cli_api_operations.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export FileExtJSON=json
export FileExtCSV=csv
export FileExtTXT=txt

export APICLIfileexportpre=dump_

export APICLIfileexportext=${FileExtJSON}
export APICLIfileexportsuffix=${DATE}'.'${APICLIfileexportext}

export APICLICSVfileexportext=${FileExtCSV}
export APICLICSVfileexportsuffix='.'${APICLICSVfileexportext}

export APICLIJSONfileexportext=${FileExtJSON}
export APICLIJSONfileexportsuffix='.'${APICLIJSONfileexportext}

export MinAPIObjectLimit=500
export MaxAPIObjectLimit=500
export WorkAPIObjectLimit=${MaxAPIObjectLimit}

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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04

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

# MODIFIED 2021-02-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetScriptSourceFolder () {
    #
    # repeated procedure description
    #
    
    echo >> ${logfilepath}
    
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "${SOURCE}" ]; do # resolve ${SOURCE} until the file is no longer a symlink
        TARGET="$(readlink "${SOURCE}")"
        if [[ ${TARGET} == /* ]]; then
            echo "SOURCE '${SOURCE}' is an absolute symlink to '${TARGET}'" >> ${logfilepath}
            SOURCE="${TARGET}"
        else
            DIR="$( dirname "${SOURCE}" )"
            echo "SOURCE '${SOURCE}' is a relative symlink to '${TARGET}' (relative to '${DIR}')" >> ${logfilepath}
            SOURCE="${DIR}/${TARGET}" # if ${SOURCE} was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        fi
    done
    
    echo "SOURCE is '${SOURCE}'" >> ${logfilepath}
    
    RDIR="$( dirname "${SOURCE}" )"
    DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
    if [ "${DIR}" != "${RDIR}" ]; then
        echo "DIR '${RDIR}' resolves to '${DIR}'" >> ${logfilepath}
    fi
    echo "DIR is '${DIR}'" >> ${logfilepath}
    
    export ScriptSourceFolder=${DIR}
    echo "ScriptSourceFolder is '${ScriptSourceFolder}'" >> ${logfilepath}
    
    echo >> ${logfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-02-09


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

# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

BasicScriptSetupAPIScripts () {
    #
    # BasicScriptSetupAPIScripts - Basic Script Setup for API Scripts Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Calling external Basic Script Setup for API Scripts Handler Script" | tee -a -i ${logfilepath}
        echo " - External Script : "${basic_script_setup_API_handler} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Calling Basic Script Setup for API Scripts Handler Script" >> ${logfilepath}
        echo " - External Script : "${basic_script_setup_API_handler} >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    . ${basic_script_setup_API_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo "Returned from external Basic Script Setup for API Scripts Handler Script" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo | tee -a -i ${logfilepath}
        echo "Continueing local execution" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo "Returned from external Basic Script Setup for API Scripts Handler Script" >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Continueing local execution" >> ${logfilepath}
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call Basic Script Setup for API Scripts Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -

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
    echo | tee -a -i ${logfilepath}
    echo 'Basic script setup API Scripts handler script file missing' | tee -a -i ${logfilepath}
    echo '  File not found : '${basic_script_setup_API_handler} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo '  Root of folder path : '${basic_script_setup_API_handler_root} | tee -a -i ${logfilepath}
    echo '  Folder in Root path : '${basic_script_setup_API_handler_folder} | tee -a -i ${logfilepath}
    echo '  Folder Root path    : '${basic_script_setup_API_handler_path} | tee -a -i ${logfilepath}
    echo '  Script Filename     : '${basic_script_setup_API_handler_file} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
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


# MODIFIED 2021-02-06 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# --session-timeout <session_time_out> 10-3600
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

export CLIparm_domain=
export CLIparm_sessionidfile=

export CLIparm_sessiontimeout=
export CLIparm_logpath=

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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-06
# MODIFIED 2021-02-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# --NSO | --no-system-objects
# --SO | --system-objects
#
# --NOSYS | --CREATORISNOTSYSTEM
#
# --CSVERR | --CSVADDEXPERRHANDLE
#
# --5-TAGS | --CSVEXPORT05TAGS
# --10-TAGS | --CSVEXPORT10TAGS
# --NO-TAGS | --CSVEXPORTNOTAGS
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

# MODIFIED 2018-06-24 -
#export CLIparm_NoSystemObjects=true
export NoSystemObjects=false
export CLIparm_NoSystemObjects=${NoSystemObjects}

# Ignore object where Creator is System  :  --NOSYS | --CREATORISNOTSYSTEM
#
#export CreatorIsNotSystem=false|true
export CreatorIsNotSystem=false
export CLIparm_CreatorIsNotSystem=${CreatorIsNotSystem}

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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-04


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

# MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumprawcliremains () {
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo | tee -a -i ${logfilepath}
        echo "Command line parameters remains : " | tee -a -i ${logfilepath}
        echo 'Number parms :  '"$#" | tee -a -i ${logfilepath}
        echo "remains raw : \> $@ \<" | tee -a -i ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e "${parmnum} \t ${k}" | tee -a -i ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo | tee -a -i ${logfilepath}
        
    else
        # Verbose mode OFF
        
        echo >> ${logfilepath}
        echo "Command line parameters remains : " >> ${logfilepath}
        echo 'Number parms :  '"$#" >> ${logfilepath}
        echo "remains raw : \> $@ \<" >> ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e "${parmnum} \t ${k}" >> ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo >> ${logfilepath}
        
    fi

}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30

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

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CommandLineParameterHandler () {
    #
    # CommandLineParameterHandler - Command Line Parameter Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Calling external Command Line Paramenter Handling Script" | tee -a -i ${logfilepath}
        echo " - External Script : "${cli_api_cmdlineparm_handler} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Calling external Command Line Paramenter Handling Script" >> ${logfilepath}
        echo " - External Script : "${cli_api_cmdlineparm_handler} >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    . ${cli_api_cmdlineparm_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo "Returned from external Command Line Paramenter Handling Script" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo | tee -a -i ${logfilepath}
        echo "Continueing local execution" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo "Returned from external Command Line Paramenter Handling Script" >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Continueing local execution" >> ${logfilepath}
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
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
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call command line parameter handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-03-3 -

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
    echo | tee -a -i ${logfilepath}
    echo 'Command Line Parameter handler script file missing' | tee -a -i ${logfilepath}
    echo '  File not found : '${cli_api_cmdlineparm_handler} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo '  Root of folder path : '${cli_api_cmdlineparm_handler_root} | tee -a -i ${logfilepath}
    echo '  Folder in Root path : '${cli_api_cmdlineparm_handler_folder} | tee -a -i ${logfilepath}
    echo '  Folder Root path    : '${cli_api_cmdlineparm_handler_path} | tee -a -i ${logfilepath}
    echo '  Script Filename     : '${cli_api_cmdlineparm_handler_file} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    exit 251
fi

# MODIFIED 2018-05-03-3 -

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
    echo 'Date Time Group   :  '${DATE} | tee -a -i ${logfilepath}
    echo 'Date Time Group S :  '${DATEDTGS} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
else
    echo 'Date Time Group   :  '${DATE} >> ${logfilepath}
    echo 'Date Time Group S :  '${DATEDTGS} >> ${logfilepath}
    echo >> ${logfilepath}
fi

# -------------------------------------------------------------------------------------------------
# GetGaiaVersionAndInstallationType - Gaia version and installation type Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetGaiaVersionAndInstallationType () {
    #
    # GetGaiaVersionAndInstallationType - Gaia version and installation type Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Calling external Gaia version and installation type Handling Script" | tee -a -i ${logfilepath}
        echo " - External Script : "${gaia_version_handler} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Calling external Gaia version and installation type Handling Script" >> ${logfilepath}
        echo " - External Script : "${gaia_version_handler} >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    . ${gaia_version_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo "Returned from external Gaia version and installation type Handling Script" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo | tee -a -i ${logfilepath}
        echo "Continueing local execution" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo "Returned from external Gaia version and installation type Handling Script" >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Continueing local execution" >> ${logfilepath}
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
    fi

}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call Gaia version and installation type Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    echo | tee -a -i ${logfilepath}
    echo ' Gaia version and installation type handler script file missing' | tee -a -i ${logfilepath}
    echo '  File not found : '${gaia_version_handler} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo '  Root of folder path : '${gaia_version_handler_root} | tee -a -i ${logfilepath}
    echo '  Folder in Root path : '${gaia_version_handler_folder} | tee -a -i ${logfilepath}
    echo '  Folder Root path    : '${gaia_version_handler_path} | tee -a -i ${logfilepath}
    echo '  Script Filename     : '${gaia_version_handler_file} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    exit 251
fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-09-21

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

# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ScriptOutputPathsforAPIScripts () {
    #
    # ScriptOutputPathsforAPIScripts - Script Output Paths and Folders for API scripts Handler calling routine
    #
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Calling external Script Output Paths and Folders for API scripts Handler Script" | tee -a -i ${logfilepath}
        echo " - External Script : "${script_output_paths_API_handler} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Calling Script Output Paths and Folders for API scripts Handler Script" >> ${logfilepath}
        echo " - External Script : "${script_output_paths_API_handler} >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    . ${script_output_paths_API_handler} "$@"
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo "Returned from external Script Output Paths and Folders for API scripts Handler Script" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo | tee -a -i ${logfilepath}
        echo "Continueing local execution" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo "Returned from external Script Output Paths and Folders for API scripts Handler Script" >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Continueing local execution" >> ${logfilepath}
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16

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
    echo | tee -a -i ${logfilepath}
    echo 'Script Output Paths and Folders for API scripts handler script file missing' | tee -a -i ${logfilepath}
    echo '  File not found : '${script_output_paths_API_handler} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo '  Root of folder path : '${script_output_paths_API_handler_root} | tee -a -i ${logfilepath}
    echo '  Folder in Root path : '${script_output_paths_API_handler_folder} | tee -a -i ${logfilepath}
    echo '  Folder Root path    : '${script_output_paths_API_handler_path} | tee -a -i ${logfilepath}
    echo '  Script Filename     : '${script_output_paths_API_handler_file} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
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
# CheckMgmtCLIAPIOperationsHandler - Management CLI API Operations Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckMgmtCLIAPIOperationsHandler () {
    #
    # CheckMgmtCLIAPIOperationsHandler - Management CLI API Operations Handler calling routine
    #
    
    errorresult=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Calling external Management CLI API Operations Handler Script" | tee -a -i ${logfilepath}
        echo " - External Script : "${mgmt_cli_API_operations_handler} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Calling external Management CLI API Operations Handler Script" >> ${logfilepath}
        echo " - External Script : "${mgmt_cli_API_operations_handler} >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    . ${mgmt_cli_API_operations_handler} CHECK "$@"
    errorresult=$?
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo "Returned from external Management CLI API Operations Handler Script" | tee -a -i ${logfilepath}
        echo 'Error Return Code = '${errorresult} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
        echo | tee -a -i ${logfilepath}
        echo "Continueing local execution" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo "Returned from external Management CLI API Operations Handler Script" >> ${logfilepath}
        echo 'Error Return Code = '${errorresult} >> ${logfilepath}
        echo >> ${logfilepath}
        echo "Continueing local execution" >> ${logfilepath}
        echo >> ${logfilepath}
        echo '--------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    return  ${errorresult}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call Basic Script Setup for API Scripts Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -

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
    echo | tee -a -i ${logfilepath}
    echo 'Basic script setup API Scripts handler script file missing' | tee -a -i ${logfilepath}
    echo '  File not found : '${mgmt_cli_API_operations_handler} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Other parameter elements : ' | tee -a -i ${logfilepath}
    echo '  Configured Root path    : '${configured_handler_root} | tee -a -i ${logfilepath}
    echo '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${logfilepath}
    echo '  Root of folder path : '${mgmt_cli_API_operations_handler_root} | tee -a -i ${logfilepath}
    echo '  Folder in Root path : '${mgmt_cli_API_operations_handler_folder} | tee -a -i ${logfilepath}
    echo '  Folder Root path    : '${mgmt_cli_API_operations_handler_path} | tee -a -i ${logfilepath}
    echo '  Script Filename     : '${mgmt_cli_API_operations_handler_file} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    exit 251
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -

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
    echo | tee -a -i ${logfilepath}
    echo "Terminating script..." | tee -a -i ${logfilepath}
    echo "Exitcode ${SUBEXITCODE}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    exit ${SUBEXITCODE}
else
    echo | tee -a -i ${logfilepath}
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


# =================================================================================================
# =================================================================================================
# START:  Main Dump Procedures
# =================================================================================================

# ADDED 2018-09-21 -

# -------------------------------------------------------------------------------------------------
# Start :  Check that Action Handler Scripts exist before executing
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckExportActionHandlerScripts () {

    #
    # Check that Action Handler Scripts exist before executing
    #
        
    # -------------------------------------------------------------------------------------------------
    # Check that Action Handler Scripts exist before executing
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    # Basic information for formation of file path for action handler scripts
    #
    # APIScriptActionFileRoot - root path to for action handler scripts
    # APIScriptActionFileFolder - folder under root path to for action handler scripts
    # APIScriptActionFilePath - path, for action handler scripts
    #
    if [ ! -z "${APIScriptActionFileFolder}" ]; then
        export APIScriptActionFilePath=${APIScriptActionFileRoot}/${APIScriptActionFileFolder}
    else
        export APIScriptActionFilePath=${APIScriptActionFileRoot}
    fi
    
    export APIScriptJSONActionFile=${APIScriptActionFilePath}/${APIScriptJSONActionFilename}
    export APIScriptCSVActionFile=${APIScriptActionFilePath}/${APIScriptCSVActionFilename}
    
    # Check that we can find the action handler scripts
    #
    if [ ! -r ${APIScriptJSONActionFile} ] ; then
        # no file found, that is a problem
        echo | tee -a -i ${logfilepath}
        echo 'JSON Action Handler script file missing' | tee -a -i ${logfilepath}
        echo '  File not found : '${APIScriptJSONActionFile} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo 'Other parameter elements : ' | tee -a -i ${logfilepath}
        echo '  Root of folder path : '${APIScriptActionFileRoot} | tee -a -i ${logfilepath}
        echo '  Folder in Root path : '${APIScriptActionFileFolder} | tee -a -i ${logfilepath}
        echo '  Folder Root path    : '${APIScriptActionFilePath} | tee -a -i ${logfilepath}
        echo '  Script Filename     : '${APIScriptJSONActionFilename} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        exit 251
    fi
    
    # Check that we can find the action handler scripts
    #
    if [ ! -r ${APIScriptCSVActionFile} ] ; then
        # no file found, that is a problem
        echo | tee -a -i ${logfilepath}
        echo 'CSV Action Handler script file missing' | tee -a -i ${logfilepath}
        echo '  File not found : '${APIScriptCSVActionFile} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo 'Other parameter elements : ' | tee -a -i ${logfilepath}
        echo '  Root of folder path : '${APIScriptActionFileRoot} | tee -a -i ${logfilepath}
        echo '  Folder in Root path : '${APIScriptActionFileFolder} | tee -a -i ${logfilepath}
        echo '  Folder Root path    : '${APIScriptActionFilePath} | tee -a -i ${logfilepath}
        echo '  Script Filename     : '${APIScriptCSVActionFilename} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        exit 251
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-09-21

# -------------------------------------------------------------------------------------------------
# End :  Check that Action Handler Scripts exist before executing
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# MainExportDumpOperations - Execute Main Dump operations - json Standard, json Full, CSV
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

MainExportDumpOperations () {
    #
    # Execute Main Dump operations - json Standard, json Full, CSV
    #
    
    # -------------------------------------------------------------------------------------------------
    # Start executing Main Dump operations - json Standard, json Full, CSV
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2020-11-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    if ${script_dump_json} ; then
        # Script supports json output for results
        
        export primarytargetoutputformat=${FileExtJSON}
        
        if ${CLIparm_formatjson} ; then
            # CLI parameters enabled or did not disable json output for results
            if ${script_dump_standard} ; then
                # Script supports json standard output for results
                export APICLIdetaillvl=standard
                if ${CLIparm_detailslevelstandard} ; then
                    # CLI parameters enabled or did not disable json standard output for results
                    
                    echo | tee -a -i ${logfilepath}
                    echo 'Now dumping details-level '${APICLIdetaillvl}' details to '${primarytargetoutputformat} | tee -a -i ${logfilepath}
                    echo 'Calling Action File : '${APIScriptJSONActionFile} | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                    
                    . ${APIScriptJSONActionFile} "$@"
                fi
            fi
            
            if ${script_dump_full} ; then
                # Script supports json full output for results
                export APICLIdetaillvl=full
                if ${CLIparm_detailslevelfull} ; then
                    # CLI parameters enabled or did not disable json full output for results
                    
                    echo | tee -a -i ${logfilepath}
                    echo 'Now dumping details-level '${APICLIdetaillvl}' details to '${primarytargetoutputformat} | tee -a -i ${logfilepath}
                    echo 'Calling Action File : '${APIScriptJSONActionFile} | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                    
                    . ${APIScriptJSONActionFile} "$@"
                fi
            fi
        fi
        
    fi
    
    if ${script_dump_csv} ; then
        # Script supports csv output for results
        
        export primarytargetoutputformat=${FileExtCSV}
        
        export APICLIdetaillvl=full
        
        if ${CLIparm_formatcsv} ; then
            # CLI parameters enabled or did not disable csv output for results
            echo | tee -a -i ${logfilepath}
            echo 'Now dumping details-level '${APICLIdetaillvl}' details to '${primarytargetoutputformat} | tee -a -i ${logfilepath}
            echo 'Calling Action File : '${APIScriptJSONActionFile} | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            
            . ${APIScriptCSVActionFile} "$@"
        fi
    fi
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-23
    
    echo
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Main Dump Procedures
# =================================================================================================
# =================================================================================================


# MODIFIED 2021-02-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if ${OpsModeAllDomains} ; then
    # Operations Mode All Domains implies MDSM operation requirement, so check that first
    if [ "${sys_type_MDS}" != "true" ]; then
        
        echo | tee -a -i ${logfilepath}
        echo '!!!! This script is expected to run on Multi-Domain Management !!!!' | tee -a -i ${logfilepath}
        echo 'Exiting...!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        exit 255
        
    fi
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-21


# =================================================================================================
# START:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================

# MODIFIED 2021-02-22 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if ${UseR8XAPI} ; then
    
    echo 'Setting up mgmt_cli login...' | tee -a -i ${logfilepath}
    
    . ${mgmt_cli_API_operations_handler} SETUPLOGIN "$@"
    
    echo | tee -a -i ${logfilepath}
    
    if [ "${CLIparm_domain}" == "System Data" ] ; then
        # A CLI Parameter for domains (-d) was passed - namely "System Data" a known domain
        echo 'A CLI Parameter for domains (-d) was passed - namely "System Data" a known domain.' | tee -a -i ${logfilepath}
        echo 'The requested domain : '${CLIparm_domain}' actually exists on the management host queried' | tee -a -i ${logfilepath}
    elif [ "${CLIparm_domain}" == "Global" ] ; then
        # A CLI Parameter for domains (-d) was passed - namely "Global" a known domain
        echo 'A CLI Parameter for domains (-d) was passed - namely "Global" a known domain.' | tee -a -i ${logfilepath}
        echo 'The requested domain : '${CLIparm_domain}' actually exists on the management host queried' | tee -a -i ${logfilepath}
    elif [ ! -z "${CLIparm_domain}" ] ; then
        # A CLI Parameter for domains (-d) was passed, so check if that domain exists and then add it as the last element to the domains array
        echo 'A CLI Parameter for domains (-d) was passed.' | tee -a -i ${logfilepath}
        echo 'Check if the requested domain : '${CLIparm_domain}' actually exists on the management host queried' | tee -a -i ${logfilepath}
        
        export MgmtCLI_Base_OpParms='-f json'
        export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
        export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}
        
        if [ ! -z "${CLIparm_mgmt}" ] ; then
        # working with remote management server
            Check4DomainByName=$(mgmt_cli --port ${APICLIwebsslport} -m ${CLIparm_mgmt} -d "System Data" show domains limit 500 offset 0 details-level standard -f json | ${JQ} '.objects[] | select(."name"=="'${CLIparm_domain}'") | ."name"' -r)
            echo 'You may be required to provide credentials for "System Data" domain logon!' | tee -a -i ${logfilepath}
        else
            Check4DomainByName=$(mgmt_cli -r true --port ${APICLIwebsslport} -d "System Data" show domains limit 500 offset 0 details-level standard -f json | ${JQ} '.objects[] | select(."name"=="'${CLIparm_domain}'") | ."name"' -r)
        fi
        CheckCliParmDomain=${Check4DomainByName}
        
        if [ x"${CheckCliParmDomain}" == x"" ] ; then
            # Houston, we have a problem... the CLIparm_domain check result was null for this MDSM MDS host
            echo | tee -a -i ${logfilepath}
            echo '!!!! The requested domain : '${CLIparm_domain}' was not found on this MDSM MDS host!!!!' | tee -a -i ${logfilepath}
            echo 'Exiting...!' | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            
            exit 250
        else
            # we are good to go, so add this domain to the array and stop processing other domains
            echo 'The requested domain : '${CLIparm_domain}' is found on this MDSM MDS host.' | tee -a -i ${logfilepath}
        fi
    else
        # no CLI Parameter for domains (-d) was passed
        echo 'No CLI Parameter for domains (-d) was passed.' | tee -a -i ${logfilepath}
    fi
    
    if ${OpsModeAllDomains} ; then
        # Handle x_All_Domains_y script, so logon to "System Data" domain
        echo | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            echo 'Operating in *_all_domains_* script so using "System Data" domain initially' | tee -a -i ${logfilepath}
        fi
        export domaintarget="System Data"
    elif [ ! -z "${CLIparm_domain}" ] ; then
        # Handle domain parameter for login string
        if ${APISCRIPTVERBOSE} ; then
            echo 'Command line parameter for domain set!  Using Domain = '${CLIparm_domain} | tee -a -i ${logfilepath}
        fi
        export domaintarget=${CLIparm_domain}
    else
        if ${APISCRIPTVERBOSE} ; then
            echo 'Command line parameter for domain NOT set!' | tee -a -i ${logfilepath}
        fi
        export domaintarget=
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo 'domaintarget = "'${domaintarget}'" ' | tee -a -i ${logfilepath}
    fi
    echo | tee -a -i ${logfilepath}
    
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
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-02-22

# =================================================================================================
# END:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations - Other Path Values
# -------------------------------------------------------------------------------------------------

if [ "${script_dump_csv}" = "true" ] ; then
    export APICLIdumppathcsv=${APICLICSVExportpathbase}/csv
fi

if [ x"${script_dump_json}" = x"true" ] ; then
    export APICLIdumppathjson=${APICLICSVExportpathbase}/json
fi

if [ x"${script_dump_full}" = x"true" ] ; then
    export APICLIdumppathjsonfull=${APICLIdumppathjson}/full
fi

if [ x"${script_dump_standard}" = x"true" ] ; then
    export APICLIdumppathjsonstandard=${APICLIdumppathjson}/standard
fi


# =================================================================================================
# START:  Export objects - json (standard and full), csv
# =================================================================================================


#export APICLIdetaillvl=standard

export APICLIdetaillvl=full

# ADDED 2018-05-04-2 -
# Only changes this parameter to force the specific state of CLIparm_NoSystemObjects
# since it is set using the command line parameters --SO (false) and --NSO (true)
#
#export CLIparm_NoSystemObjects=false

# ADDED 2018-04-25 -
export primarytargetoutputformat=${FileExtJSON}

# -------------------------------------------------------------------------------------------------
# Start executing Main operations
# -------------------------------------------------------------------------------------------------


CheckExportActionHandlerScripts


# =================================================================================================
# =================================================================================================
# START:  Main Domain Handling Procedures
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# GenerateArrayOfDomains - Generate Array with list of domains on MDS
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-02-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GenerateArrayOfDomains () {
    #
    # Generate Array with list of domains on MDS
    #
    
    echo | tee -a -i ${logfilepath}
    echo 'Generate Array with list of domains on MDS' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}
    export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}
    
    objectstotal=$(mgmt_cli show domains limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    GETDOMAINSBYNAME="`mgmt_cli show domains ${MgmtCLI_Base_OpParms} | jq '.objects[].name'`"
    
    DOMAINSARRAY=()
    
    echo 'Populate array of domains : ' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    line='"System Data"'
    DOMAINSARRAY+=("${line}")
    echo -n 'Domains :  '${line} | tee -a -i ${logfilepath}
    
    line='"Global"'
    DOMAINSARRAY+=("${line}")
    echo -n ', '${line} | tee -a -i ${logfilepath}
    
    arraylength=2
    
    export BuildDomainsArray=true
    
    # When in All Domains Mode, we need to check whether a domains -d parameter was passed with the CLI parameters
    if [ "${CLIparm_domain}" == "System Data" ] ; then
        # A CLI Parameter for domains (-d) was passed - namely "System Data" a known domain and already in the array
        
        line="${CLIparm_domain}"
        echo -n ', !! Redundant domain submitted: '${CLIparm_domain}' !!'
        
        export BuildDomainsArray=false
    elif [ "${CLIparm_domain}" == "Global" ] ; then
        # A CLI Parameter for domains (-d) was passed - namely "Global" a known domain and already in the array
        
        line="${CLIparm_domain}"
        echo -n ', !! Redundant domain submitted: '${CLIparm_domain}' !!'
        
        export BuildDomainsArray=false
    elif [ ! -z "${CLIparm_domain}" ] ; then
        # A CLI Parameter for domains (-d) was passed, so check if that domain exists and then add it as the last element to the domains array
        
        Check4DomainByName=$(mgmt_cli show domains limit 500 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} '.objects[] | select(."name"=="'${CLIparm_domain}'") | ."name"' -r)
        CheckCliParmDomain=${Check4DomainByName}
        
        if [ x"${CheckCliParmDomain}" == x"" ] ; then
            # Houston, we have a problem... the CLIparm_domain check result was null for this MDSM MDS host
            
            echo | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            echo '!!!! The requested domain : '${CLIparm_domain}' was not found on this MDSM MDS host!!!!' | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            
            . ${mgmt_cli_API_operations_handler} LOGOUT "$@"
            
            echo 'Exiting...!' | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            exit 250
            
        else
            # we are good to go, so add this domain to the array and stop processing other domains
            
            line="${CLIparm_domain}"
            DOMAINSARRAY+=("${line}")
            echo -n ', '${line}
            
            arraylength=${#DOMAINSARRAY[@]}
            
            export BuildDomainsArray=false
        fi
    else
        # no CLI Parameter for domains (-d) was passed
        export BuildDomainsArray=true
    fi
    
    if ${BuildDomainsArray} ; then
        # so we need to populate the domains arraay
        while read -r line; do
            
            if [ $arraylength -eq 0 ]; then
                echo -n 'Domains :  ' | tee -a -i ${logfilepath}
            else
                echo -n ', ' | tee -a -i ${logfilepath}
            fi
            
            DOMAINSARRAY+=("${line}")
            echo -n ${line} | tee -a -i ${logfilepath}
            
            #if [ "${line}" == 'something-to-omit' ]; then
            #    echo -n 'Not adding '${line}
            #else 
            #    DOMAINSARRAY+=("${line}")
            #    echo -n ${line}
            #fi
            
            arraylength=${#DOMAINSARRAY[@]}
            arrayelement=$((arraylength-1))
            
        done <<< "${GETDOMAINSBYNAME}"
        
    fi
    echo | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-02-21

# -------------------------------------------------------------------------------------------------
# DumpArrayOfDomains - repeated proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED YYYY-MM-DD -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

DumpArrayOfDomains () {
    #
    # repeated procedure description
    #
    
    echo 'Show list of domains in array' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    for j in "${DOMAINSARRAY[@]}"
    do
        echo "${j}" | tee -a -i ${logfilepath}
    done
    echo | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
            
        echo 'Raw dump of domains array : ' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo ${DOMAINSARRAY[@]} | tee -a -i ${logfilepath}
        #echo ${DOMAINSARRAY[*]} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED YYYY-MM-DD

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------



# =================================================================================================
# END:  Main Domain Handling Procedures
# =================================================================================================
# =================================================================================================


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#
# Generate list of domains in Array
#
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------


# MODIFIED 2021-02-21 -

DOMAINSARRAY=()

GenerateArrayOfDomains
echo | tee -a -i ${logfilepath}

DumpArrayOfDomains
echo | tee -a -i ${logfilepath}

if ! ${NOWAIT} ; then
    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
fi


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export LoggedIntoMgmtCli=false

for j in "${DOMAINSARRAY[@]}" ; do
    workdomain=${j}
    workdomain=${workdomain//\"}
    
    echo | tee -a -i ${logfilepath}
    echo 'Domain :  >'${workdomain}'< ' | tee -a -i ${logfilepath}
    
    if ${LoggedIntoMgmtCli} ; then
        # we logged in earlier, time to logout
        . ${mgmt_cli_API_operations_handler} LOGOUT "$@"
    fi
    
    echo | tee -a -i ${logfilepath}
    
    # we need to login to the specific domain for the API export, so let's set that up from scratch again
    . ${mgmt_cli_API_operations_handler} SETUPLOGIN "$@"
    
    export domaintarget=${workdomain}
    
    echo | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Start dump for '${domaintarget} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    export LoggedIntoMgmtCli=false
    
    # we need to login to the specific domain for the API export
    . ${mgmt_cli_API_operations_handler} LOGIN "$@"
    LOGINEXITCODE=$?
    
    if [ "${LOGINEXITCODE}" != "0" ] ; then
        # well that went sideways...
        exit ${LOGINEXITCODE}
    else
        export LoggedIntoMgmtCli=true
    fi
    
    echo | tee -a -i ${logfilepath}
    
    MainExportDumpOperations
    
    echo | tee -a -i ${logfilepath}
    echo 'Dump for '${domaintarget}' Completed!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    if ! ${NOWAIT} ; then
        read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
    fi
    
done

echo | tee -a -i ${logfilepath}
echo 'Dumps Completed!' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16



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

# MODIFIED 2021-02-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if ${CLIparm_CLEANUPCSVWIP} ; then
    # Remove Work-In-Progress folder and files
    
    if [ x"${APICLICSVpathexportwip}" != x"" ] ; then
        if [ -r ${APICLICSVpathexportwip} ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo 'Remove CSV Work-In-Progress folder and files' | tee -a -i ${logfilepath}
                echo '   CSV WIP Folder : "'${APICLICSVpathexportwip}'"' | tee -a -i ${logfilepath}
                echo | tee -a -i ${logfilepath}
                rm -v -r ${APICLICSVpathexportwip} | tee -a -i ${logfilepath}
                echo | tee -a -i ${logfilepath}
            else
                echo 'Remove CSV Work-In-Progress folder and files' >> ${logfilepath}
                echo '   CSV WIP Folder : "'${APICLICSVpathexportwip}'"' >> ${logfilepath}
                echo >> ${logfilepath}
                rm -v -r ${APICLICSVpathexportwip} >> ${logfilepath}
                echo >> ${logfilepath}
            fi
        fi
    fi
    
    if [ x"${APICLIJSONpathexportwip}" != x"" ] ; then
        if [ -r ${APICLIJSONpathexportwip} ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo 'Remove JSON Work-In-Progress folder and files' | tee -a -i ${logfilepath}
                echo '   JSON WIP Folder : "'${APICLIJSONpathexportwip}'"' | tee -a -i ${logfilepath}
                rm -v -r ${APICLIJSONpathexportwip} | tee -a -i ${logfilepath}
            else
                echo 'Remove JSON Work-In-Progress folder and files' >> ${logfilepath}
                echo '   JSON WIP Folder : "'${APICLIJSONpathexportwip}'"' >> ${logfilepath}
                rm -v -r ${APICLIJSONpathexportwip} >> ${logfilepath}
            fi
        fi
    fi
    
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-04


# -------------------------------------------------------------------------------------------------
# Clean-up and exit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-02-06 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo 'CLI Operations Completed' | tee -a -i ${logfilepath}

if ${APISCRIPTVERBOSE} ; then
    # Verbose mode ON
    
    echo | tee -a -i ${logfilepath}
    #echo "Files in >${APICLIpathroot}<" | tee -a -i ${logfilepath}
    #ls -alh ${APICLIpathroot} | tee -a -i ${logfilepath}
    #echo | tee -a -i ${logfilepath}
    
    if [ x"${APICLIlogpathbase}" != x"" ] ; then
        if [ "${APICLIlogpathbase}" != "${APICLIpathbase}" ] ; then
            echo 'Files in ${APICLIlogpathbase} >'"${APICLIlogpathbase}"'<' | tee -a -i ${logfilepath}
            ls -alhR ${APICLIlogpathbase} | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
        fi
    fi
    
    echo 'Files in ${APICLIpathbase} >'"${APICLIpathbase}"'<' | tee -a -i ${logfilepath}
    ls -alhR ${APICLIpathbase} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
else
    # Verbose mode OFF
    
    echo >> ${logfilepath}
    #echo "Files in >${APICLIpathroot}<" >> ${logfilepath}
    #ls -alh ${APICLIpathroot} >> ${logfilepath}
    #echo >> ${logfilepath}
    
    if [ x"${APICLIlogpathbase}" != x"" ] ; then
        if [ "${APICLIlogpathbase}" != "${APICLIpathbase}" ] ; then
            echo 'Files in ${APICLIlogpathbase} >'"${APICLIlogpathbase}"'<' >> ${logfilepath}
            ls -alhR ${APICLIlogpathbase} >> ${logfilepath}
            echo >> ${logfilepath}
        fi
    fi
    
    echo 'Files in ${APICLIpathbase} >'"${APICLIpathbase}"'<' >> ${logfilepath}
    ls -alhR ${APICLIpathbase} >> ${logfilepath}
    echo >> ${logfilepath}
fi

if ${CLIparm_NOHUP} ; then
    # Cleanup Potential file indicating script is active for nohup mode
    if [ -r ${script2nohupactive} ] ; then
        rm ${script2nohupactive} >> ${logfilepath} 2>&1
    fi
fi

echo | tee -a -i ${logfilepath}
echo 'Results in directory : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
echo 'Log output in file   : '"${logfilepath}" | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-06


# =================================================================================================
# END:  Publish, Cleanup, and Dump output
# =================================================================================================
# =================================================================================================


