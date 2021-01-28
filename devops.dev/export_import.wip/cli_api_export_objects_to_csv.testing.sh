#!/bin/bash
#
# SCRIPT Object export to CSV file for API CLI Operations - testing - selective enabled objects
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

export notthispath=/home/
export startpathroot=.

export localdotpath=`echo ${PWD}`
export currentlocalpath=${localdotpath}
export workingpath=$currentlocalpath

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


# 2018-05-02 - script type - export objects (specific to CSV)

export script_use_publish="false"

export script_use_export="true"
export script_use_import="false"
export script_use_delete="false"
export script_use_csvfile="false"

export script_dump_csv="true"
export script_dump_json="false"
export script_dump_standard="false"
export script_dump_full="false"

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
export api_subscripts_checkfile=api_subscripts_version.${APISubscriptsRevision}.v${APISubscriptsVersion}.version

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
export basic_script_setup_API_handler_file=basic_script_setup_API_scripts.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

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
export cli_api_cmdlineparm_handler_file=cmd_line_parameters_handler.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

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
export gaia_version_handler_file=identify_gaia_and_installation.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

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
export script_output_paths_API_handler_file=script_output_paths_and_folders_API_scripts.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

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
export mgmt_cli_API_operations_handler_file=mgmt_cli_api_operations.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

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

# Moved to mgmt_cli_api_operations.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh script
#
#CheckStatusOfAPI

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ REMOVED 2020-11-16
# -------------------------------------------------------------------------------------------------
# GetScriptSourceFolder - Get the actual source folder for the running script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-30 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    echo >> ${logfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-30


# REMOVED 2020-11-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Moved to basic_script_setup_API_scripts.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh script
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


# MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30
# MODIFIED 2021-01-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Specific Scripts Command Line Parameters
#
# -f <format[all|csv|json]> | --format <format[all|csv|json]> | -f=<format[all|csv|json]> | --format=<format[all|csv|json]> 
#
# --details <level[all|full|standard]> | --DETAILSLEVEL <level[all|full|standard]> | --details=<level[all|full|standard]> | --DETAILSLEVEL=<level[all|full|standard]> 
#
# --DEVOPSRESULTS | --RESULTS
# --DEVOPSRESULTSPATH <results_path> | --RESULTSPATH <results_path> | --DEVOPSRESULTSPATH=<results_path> | --RESULTSPATH=<results_path> 
#
# -x <export_path> | --export <export_path> | -x=<export_path> | --export=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path> 
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path> 
#
# --NSO | --no-system-objects
# --SO | --system-objects
#
# --5-TAGS | --CSVEXPORT05TAGS
# --10-TAGS | --CSVEXPORT10TAGS
# --NO-TAGS | --CSVEXPORTNOTAGS
#
# --CLEANUPWIP
# --NODOMAINFOLDERS
# --CSVADDEXPERRHANDLE
#
# --CSVEXPORTDATADOMAIN
# --CSVEXPORTDATACREATOR
# --CSVEXPORTDATAALL
#

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

export CLIparm_UseDevOpsResults=false
export UseDevOpsResults=false
export CLIparm_resultspath=

export CLIparm_exportpath=
export CLIparm_importpath=
export CLIparm_deletepath=

# ADDED 2021-01-16 -
# Define number tags to export to CSV :  5, 10, none

export CSVEXPORT05TAGS=true
export CSVEXPORT10TAGS=false
export CSVEXPORTNOTAGS=false
export CLIparm_CSVEXPORT05TAGS=${CSVEXPORT05TAGS}
export CLIparm_CSVEXPORT10TAGS=${CSVEXPORT10TAGS}
export CLIparm_CSVEXPORTNOTAGS=${CSVEXPORTNOTAGS}

# MODIFIED 2018-06-24 -
#export CLIparm_NoSystemObjects=true
export CLIparm_NoSystemObjects=false

export CLIparm_CLEANUPWIP=
export CLIparm_NODOMAINFOLDERS=
export CLIparm_CSVADDEXPERRHANDLE=

# --CLEANUPWIP
#
if [ -z "${CLEANUPWIP}" ]; then
    # CLEANUPWIP mode not set from shell level
    export CLIparm_CLEANUPWIP=false
    export CLEANUPWIP=false
elif [ x"`echo "${CLEANUPWIP}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CLEANUPWIP mode set OFF from shell level
    export CLIparm_CLEANUPWIP=false
    export CLEANUPWIP=false
elif [ x"`echo "${CLEANUPWIP}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CLEANUPWIP mode set ON from shell level
    export CLIparm_CLEANUPWIP=true
    export CLEANUPWIP=true
else
    # CLEANUPWIP mode set to wrong value from shell level
    export CLIparm_CLEANUPWIP=false
    export CLEANUPWIP=false
fi

# --NODOMAINFOLDERS
#
if [ -z "${NODOMAINFOLDERS}" ]; then
    # NODOMAINFOLDERS mode not set from shell level
    export CLIparm_NODOMAINFOLDERS=false
    export NODOMAINFOLDERS=false
elif [ x"`echo "${NODOMAINFOLDERS}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NODOMAINFOLDERS mode set OFF from shell level
    export CLIparm_NODOMAINFOLDERS=false
    export NODOMAINFOLDERS=false
elif [ x"`echo "${NODOMAINFOLDERS}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NODOMAINFOLDERS mode set ON from shell level
    export CLIparm_NODOMAINFOLDERS=true
    export NODOMAINFOLDERS=true
else
    # NODOMAINFOLDERS mode set to wrong value from shell level
    export CLIparm_NODOMAINFOLDERS=false
    export NODOMAINFOLDERS=false
fi

# --CSVADDEXPERRHANDLE
#
if [ -z "${CSVADDEXPERRHANDLE}" ]; then
    # CSVADDEXPERRHANDLE mode not set from shell level
    export CLIparm_CSVADDEXPERRHANDLE=false
    export CSVADDEXPERRHANDLE=false
elif [ x"`echo "${CSVADDEXPERRHANDLE}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CSVADDEXPERRHANDLE mode set OFF from shell level
    export CLIparm_CSVADDEXPERRHANDLE=false
    export CSVADDEXPERRHANDLE=false
elif [ x"`echo "${CSVADDEXPERRHANDLE}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CSVADDEXPERRHANDLE mode set ON from shell level
    export CLIparm_CSVADDEXPERRHANDLE=true
    export CSVADDEXPERRHANDLE=true
else
    # CLEANUPWIP mode set to wrong value from shell level
    export CLIparm_CSVADDEXPERRHANDLE=false
    export CSVADDEXPERRHANDLE=false
fi

# ADDED 2020-09-30 -
# --CSVEXPORTDATADOMAIN :  Export Data Domain information to CSV
# --CSVEXPORTDATACREATOR :  Export Data Creator and other MetaData to CSV
# --CSVEXPORTDATAALL :  Export Data Domain and Data Creator and other MetaData to CSV

export CLIparm_CSVEXPORTDATADOMAIN=false
export CLIparm_CSVEXPORTDATACREATOR=false

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-16


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

# MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
                #LOCALREMAINS="${LOCALREMAINS} \"${OPT}\""
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
                    #LOCALREMAINS="${LOCALREMAINS} \"${OPT}\""
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

}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30

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


# Moved to mgmt_cli_api_operations.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh script
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

# Moved to script_output_paths_and_folders_API_scripts.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh script
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
# START:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================

# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if ${UseR8XAPI} ; then
    
    . ${mgmt_cli_API_operations_handler} SETUPLOGIN "$@"
    
    if [ ! -z "${CLIparm_domain}" ] ; then
        # Handle domain parameter for login string
        if ${APISCRIPTVERBOSE} ; then
            echo 'Command line parameter for domain set!  Domain = '${CLIparm_domain} | tee -a -i ${logfilepath}
        fi
        export domaintarget=${CLIparm_domain}
    else
        if ${APISCRIPTVERBOSE} ; then
            echo 'Command line parameter for domain NOT set!' | tee -a -i ${logfilepath}
        fi
        export domaintarget=
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo "domaintarget = '${domaintarget}' " | tee -a -i ${logfilepath}
    fi
    
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
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


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

# MODIFIED 2018-05-04-3 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# ------------------------------------------------------------------------
# Set and clear temporary log file
# ------------------------------------------------------------------------

export templogfilepath=/var/tmp/templog_${ScriptName}.`date +%Y%m%d-%H%M%S%Z`.log
echo > ${templogfilepath}

echo 'Configure working paths for export and dump' >> ${templogfilepath}
echo >> ${templogfilepath}

echo 'domainnamenospace = '${domainnamenospace} >> ${templogfilepath}
echo 'CLIparm_NODOMAINFOLDERS = '${CLIparm_NODOMAINFOLDERS} >> ${templogfilepath}
echo 'primarytargetoutputformat = '${primarytargetoutputformat} >> ${templogfilepath}
echo 'APICLICSVExportpathbase = '${APICLICSVExportpathbase} >> ${templogfilepath}
echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo 'WorkAPIObjectLimit = '${WorkAPIObjectLimit} >> ${templogfilepath}

# ------------------------------------------------------------------------

if [ ! -z "${domainnamenospace}" ] && [ "${CLIparm_NODOMAINFOLDERS}" != "true" ] ; then
    # Handle adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}/${domainnamenospace}
    
    echo 'Handle adding domain name to path for MDM operations' >> ${templogfilepath}
    echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
    fi
else
    # NOT adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}
    
    echo 'NOT adding domain name to path for MDM operations' >> ${templogfilepath}
    echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
    fi
fi

# ------------------------------------------------------------------------

if ${script_use_delete} ; then
    # primary operation is delete
    
    export APICLIpathexport=${APICLIpathexport}/delete
    
    echo | tee -a -i ${templogfilepath}
    echo 'Delete using '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}
    
elif ${script_use_import} ; then
    # primary operation is import
    
    export APICLIpathexport=${APICLIpathexport}/import
    
    echo | tee -a -i ${templogfilepath}
    echo 'Import using '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}
    
elif ${script_use_export} ; then
    # primary operation is export
    
    # primary operation is export to primarytargetoutputformat
    export APICLIpathexport=${APICLIpathexport}/${primarytargetoutputformat}
    
    echo | tee -a -i ${templogfilepath}
    echo 'Export to '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}
    
else
    # primary operation is something else
    
    export APICLIpathexport=${APICLIpathbase}
    
fi

if [ ! -r ${APICLIpathexport} ] ; then
    mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
fi

echo >> ${templogfilepath}
echo 'After Evaluation of script type' >> ${templogfilepath}
echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}

# ------------------------------------------------------------------------

if [ x"${primarytargetoutputformat}" = x"${FileExtJSON}" ] ; then
    # for JSON provide the detail level
    
    export APICLIpathexport=${APICLIpathexport}/${APICLIdetaillvl}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
    fi
    
    export APICLIJSONpathexportwip=
    if [ x"$script_uses_wip_json" = x"true" ] ; then
        # script uses work-in-progress (wip) folder for json
        
        export APICLIJSONpathexportwip=${APICLIpathexport}/wip
        
        if [ ! -r ${APICLIJSONpathexportwip} ] ; then
            mkdir -p -v ${APICLIJSONpathexportwip} >> ${templogfilepath}
        fi
    fi
else
    export APICLIJSONpathexportwip=
fi

echo >> ${templogfilepath}
echo 'After handling json target' >> ${templogfilepath}
echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo 'APICLIJSONpathexportwip = '${APICLIJSONpathexportwip} >> ${templogfilepath}

# ------------------------------------------------------------------------

if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
    # for CSV handle specifics, like wip
    
    export APICLICSVpathexportwip=
    if [ x"$script_uses_wip" = x"true" ] ; then
        # script uses work-in-progress (wip) folder for csv
        
        export APICLICSVpathexportwip=${APICLIpathexport}/wip
        
        if [ ! -r ${APICLICSVpathexportwip} ] ; then
            mkdir -p -v ${APICLICSVpathexportwip} >> ${templogfilepath}
        fi
    fi
else
    export APICLICSVpathexportwip=
fi

echo >> ${templogfilepath}
echo 'After handling csv target' >> ${templogfilepath}
echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo 'APICLICSVpathexportwip = '${APICLICSVpathexportwip} >> ${templogfilepath}

# ------------------------------------------------------------------------

export APICLIfileexportpost='_'${APICLIdetaillvl}'_'${APICLIfileexportsuffix}

export APICLICSVheaderfilesuffix=header

export APICLICSVfileexportpost='_'${APICLIdetaillvl}'_'${APICLICSVfileexportsuffix}

export APICLIJSONheaderfilesuffix=header
export APICLIJSONfooterfilesuffix=footer

export APICLIJSONfileexportpost='_'${APICLIdetaillvl}'_'${APICLIJSONfileexportsuffix}

echo >> ${templogfilepath}
echo 'Setup other file and path variables' >> ${templogfilepath}
echo 'APICLIfileexportpost = '${APICLIfileexportpost} >> ${templogfilepath}
echo 'APICLICSVheaderfilesuffix = '${APICLICSVheaderfilesuffix} >> ${templogfilepath}
echo 'APICLICSVfileexportpost = '${APICLICSVfileexportpost} >> ${templogfilepath}
echo 'APICLIJSONheaderfilesuffix = '${APICLIJSONheaderfilesuffix} >> ${templogfilepath}
echo 'APICLIJSONfooterfilesuffix = '${APICLIJSONfooterfilesuffix} >> ${templogfilepath}
echo 'APICLIJSONfileexportpost = '${APICLIJSONfileexportpost} >> ${templogfilepath}

# ------------------------------------------------------------------------

echo >> ${templogfilepath}

cat ${templogfilepath} >> ${logfilepath}
rm -v ${templogfilepath} >> ${logfilepath}

# ------------------------------------------------------------------------

echo 'Dump "'${APICLIdetaillvl}'" details to path:  '${APICLIpathexport} | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04-3


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Main Operational repeated proceedures - Export Objects to raw JSON
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportObjectsToCSVviaJQ () {
    
    echo | tee -a -i ${logfilepath}
    
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
    export APICLICSVfileoriginal=${APICLICSVfilewip}.original
    
    
    if [ ! -r ${APICLICSVpathexportwip} ] ; then
        mkdir -p -v ${APICLICSVpathexportwip} | tee -a -i ${logfilepath}
    fi
    
    if [ -r ${APICLICSVfile} ] ; then
        rm ${APICLICSVfile} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileheader} ] ; then
        rm ${APICLICSVfileheader} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfiledata} ] ; then
        rm ${APICLICSVfiledata} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfilesort} ] ; then
        rm ${APICLICSVfilesort} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileoriginal} ] ; then
        rm ${APICLICSVfileoriginal} >> ${logfilepath}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo "Creat ${APICLIobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    #
    # Troubleshooting output
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
        echo 'CSVFileHeader' - ${CSVFileHeader} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    echo ${CSVFileHeader} > ${APICLICSVfileheader} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# The FinalizeExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeExportObjectsToCSVviaJQ () {
    #
    # The FinalizeExportObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
    #
    
    if [ ! -r "${APICLICSVfileheader}" ] ; then
        # Uh, Oh, something went wrong, no header file
        echo | tee -a -i ${logfilepath}
        echo '!!!! Error header file missing : '${APICLICSVfileheader} | tee -a -i ${logfilepath}
        echo 'Terminating!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 254
        
    elif [ ! -r "${APICLICSVfiledata}" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo | tee -a -i ${logfilepath}
        echo '!!!! Error data file missing : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo 'Terminating!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 253
        
    elif [ ! -s "${APICLICSVfiledata}" ] ; then
        # data file is empty, nothing was found
        echo | tee -a -i ${logfilepath}
        echo '!! data file is empty : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo 'Skipping CSV creation!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 0
        
    fi
    
    echo | tee -a -i ${logfilepath}
    echo "Sort data and build CSV export file" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfileoriginal}
    cat ${APICLICSVfiledata} >> ${APICLICSVfileoriginal}
    
    sort ${APICLICSVsortparms} ${APICLICSVfiledata} > ${APICLICSVfilesort}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfile}
    cat ${APICLICSVfilesort} >> ${APICLICSVfile}
    
    echo | tee -a -i ${logfilepath}
    echo "Done creating ${APICLIobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    head ${APICLICSVfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportObjectsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjectstype} item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectsToCSVviaJQ () {
    #
    
    if [[ ${number_of_objects} -lt 1 ]] ; then
        # no objects of this type
        
        echo "No objects of type ${APICLIobjecttype} to process, skipping..." | tee -a -i ${logfilepath}
        
        return 0
       
    else
        # we have objects to handle
        echo "Processing ${number_of_objects} ${APICLIobjecttype} objects..." | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    fi
    
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
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
        export CSVJQparms=${CSVJQparms}', true'
    fi
    
    SetupExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure SetupExportObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    export MgmtCLI_Base_OpParms="-f json -s ${APICLIsessionfile}"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"full\" ${MgmtCLI_Base_OpParms}"
    
    # MODIFIED 2018-07-20 - CLEANED UP 2020-10-05
    
    # This should work, but might need more tweeks if other data types use more values
    #export notsystemobjectselector='select(."domain"."name" | contains ("Check Point Data", "APPI Data", "IPS Data") | not)'
    #export notsystemobjectselector='select(any(."domain"."name"; in("Check Point Data", "APPI Data", "IPS Data")) | not)'
    #export notsystemobjectselector='select((."domain"."name" != "Check Point Data") and (."domain"."name" != "APPI Data") and (."domain"."name" != "IPS Data"))'
    #
    # Current alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    echo | tee -a -i ${logfilepath}
    echo "Export ${APICLIobjectstype} to CSV File" | tee -a -i ${logfilepath}
    echo "  and dump to ${APICLICSVfile}" | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo "  mgmt_cli parameters : ${MgmtCLI_Show_OpParms}" | tee -a -i ${logfilepath}
        echo '  CSVJQparms' - ${CSVJQparms} | tee -a -i ${logfilepath}
        echo "  System Object Selector : "${notsystemobjectselector} | tee -a -i ${logfilepath}
    fi
    echo | tee -a -i ${logfilepath}
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        #errorreturn=$?
        
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
        else   
            # Don't Ignore System Objects
            mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
        fi
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo 'Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
    done
    
    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure FinalizeExportObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo
        echo "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# GetNumberOfObjectsviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-10-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
        echo | tee -a -i ${logfilepath}
        echo 'Get objectstotal of object type '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    fi
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem during mgmt_cli objectstotal operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    export number_of_objects=${objectstotal}
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-10-05


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckAPIVersionAndExecuteOperation :  Check the API Version running where we're logged in and if good execute operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckAPIVersionAndExecuteOperation () {
    #
    # Check the API Version running where we're logged in and if good execute operation
    #
    
    GetAPIVersion=$(mgmt_cli show api-versions -f json -s ${APICLIsessionfile} | ${JQ} '.["current-version"]' -r)
    export CheckAPIVersion=${GetAPIVersion}
    
    if [ ${CheckAPIVersion} = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=${CheckAPIVersion}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo 'Required minimum API version for object : '${APICLIobjectstype}' is API version = '${APIobjectminversion} | tee -a -i ${logfilepath}
    echo 'Logged in management server API version = '${CurrentAPIVersion}' Check version : "'${CheckAPIVersion}'"' | tee -a -i ${logfilepath}
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) ] ; then
        # API is sufficient version
        echo | tee -a -i ${logfilepath}
        
        ExportObjectsToCSVviaJQ
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo 'Error '${errorreturn}' in ExportObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
        fi
        
    else
        # API is not of a sufficient version to operate on for this object
        echo | tee -a -i ${logfilepath}
        echo 'Current API Version ('${CurrentAPIVersion}') does not meet minimum API version expected requirement ('${APIobjectminversion}')' | tee -a -i ${logfilepath}
        echo '! skipping object '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END : Main Operational repeated proceedures - Export Objects to CSV
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo ${APICLIdetaillvl}' CSV Export - simple objects - Export to CSV starting!'
echo

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Network Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Network Objects' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# host objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_hosts="${objectstotal_hosts}"
export number_of_objects=${number_hosts}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# host objects - NO NAT Details
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_hosts="${objectstotal_hosts}"
export number_of_objects=${number_hosts}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_networks=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_networks="$objectstotal_networks"
export number_of_objects=${number_networks}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# wildcard objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.2
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

objectstotal_wildcards=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_wildcards="${objectstotal_wildcards}"
export number_of_objects=${number_wildcards}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_groups="${objectstotal_groups}"
export number_of_objects=${number_groups}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_groupswithexclusion=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_groupswithexclusion="${objectstotal_groupswithexclusion}"
export number_of_objects=${number_groupswithexclusion}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_addressranges=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_addressranges="${objectstotal_addressranges}"
export number_of_objects=${number_addressranges}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# multicast-address-range objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_multicastaddressranges=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_multicastaddressranges="${objectstotal_multicastaddressranges}"
export number_of_objects=${number_multicastaddressranges}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_dnsdomains=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_dnsdomains="${objectstotal_dnsdomains}"
export number_of_objects=${number_dnsdomains}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# security-zone objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_securityzones=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_securityzones="${objectstotal_securityzones}"
export number_of_objects=${number_securityzones}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dynamic-object objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_dynamicobjects=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_dynamicobjects="${objectstotal_dynamicobjects}"
export number_of_objects=${number_dynamicobjects}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tag objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=tag
export APICLIobjectstype=tags
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_tags=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tags="${objectstotal_tags}"
export number_of_objects=${number_tags}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-gateway objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_simplegateways=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_simplegateways="${objectstotal_simplegateways}"
export number_of_objects=${number_simplegateways}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-cluster objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6
export APICLIobjecttype=simple-cluster
export APICLIobjectstype=simple-clusters
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_simpleclusters=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_simpleclusters="${objectstotal_simpleclusters}"
export number_of_objects=${number_simpleclusters}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# checkpoint-host objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=checkpoint-hosts
export APICLIobjectstype=checkpoint-hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_checkpointhosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_checkpointhosts="${objectstotal_checkpointhosts}"
export number_of_objects=${number_checkpointhosts}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_times=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_times="${objectstotal_times}"
export number_of_objects=${number_times}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time_group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_time_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_time_groups="${objectstotal_time_groups}"
export number_of_objects=${number_time_groups}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-role objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_access_roles=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_access_roles="${objectstotal_access_roles}"
export number_of_objects=${number_access_roles}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# opsec-application objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_opsec_applications=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_opsec_applications="${objectstotal_opsec_applications}"
export number_of_objects=${number_opsec_applications}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# trusted-client objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=trusted-client
export APICLIobjectstype=trusted-clients
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_trustedclients=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_trustedclients="${objectstotal_trustedclients}"
export number_of_objects=${number_trustedclients}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsv-profile objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6
export APICLIobjecttype=lsv-profile
export APICLIobjectstype=lsv-profiles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_lsvprofiles=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_lsvprofiles="${objectstotal_lsvprofiles}"
export number_of_objects=${number_number_lsvprofiles}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# gsn-handover-group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=gsn-handover-group
export APICLIobjectstype=gsn-handover-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_gsnhandovergroups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_gsnhandovergroups="${objectstotal_gsnhandovergroups}"
export number_of_objects=${number_gsnhandovergroups}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-point-name objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=access-point-names
export APICLIobjectstype=access-point-names
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_accesspointnames=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_accesspointnames="${objectstotal_accesspointnames}"
export number_of_objects=${number_accesspointnames}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-server objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"encryption","priority","server-type","server.name","service","secret-key"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["encryption"], .["priority"], .["server-type"], .["server"]["name"], .["service"], ""'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_tacacsservers=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tacacsservers="${objectstotal_tacacsservers}"
export number_of_objects=${number_tacacsservers}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
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

objectstotal_tacacsgroups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tacacsgroups="${objectstotal_tacacsgroups}"
export number_of_objects=${number_tacacsgroups}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Service & Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Service & Applications' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# services-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'

export CSVJQparms=
export CSVJQparms='.["port"], .["protocol"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-by-protocol-signature"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'

objectstotal_services_tcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_tcp="${objectstotal_services_tcp}"
export number_of_objects=${number_services_tcp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'

export CSVJQparms=
export CSVJQparms='.["port"], .["protocol"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["accept-replies"], .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-by-protocol-signature"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'

objectstotal_services_udp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_udp="${objectstotal_services_udp}"
export number_of_objects=${number_services_udp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["icmp-code"], .["icmp-type"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_icmp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_icmp="${objectstotal_services_icmp}"
export number_of_objects=${number_services_icmp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["icmp-code"], .["icmp-type"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_icmp6=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_icmp6="${objectstotal_services_icmp6}"
export number_of_objects=${number_services_icmp6}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'

export CSVJQparms=
export CSVJQparms='.["port"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-for-any"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'

objectstotal_services_sctp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_sctp="${objectstotal_services_sctp}"
export number_of_objects=${number_services_sctp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'

export CSVJQparms=
export CSVJQparms='.["port"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["accept-replies"], .["ip-protocol"], .["action"], .["match"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'

objectstotal_services_other=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_other="${objectstotal_services_other}"
export number_of_objects=${number_services_other}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["interface-uuid"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_dce_rpc=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_dce_rpc="${objectstotal_services_dce_rpc}"
export number_of_objects=${number_services_dce_rpc}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["program-number"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_rpc=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_rpc="${objectstotal_services_rpc}"
export number_of_objects=${number_services_rpc}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-gtp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=service-gtp
export APICLIobjectstype=services-gtp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"version","allow-usage-of-static-ip","cs-fallback-and-srvcc","radio-access-technology"'
export CSVFileHeader=${CSVFileHeader}',"restoration-and-recovery","reverse-service","trace-management"'
export CSVFileHeader=${CSVFileHeader}',"access-point-name.enable","access-point-name.apn","apply-access-policy-on-user-traffic.enable","apply-access-policy-on-user-traffic.add-imsi-field-to-log"'
export CSVFileHeader=${CSVFileHeader}',"imsi-prefix.enable","imsi-prefix.prefix","interface-profile.profile","interface-profile.custom-message-types"'
export CSVFileHeader=${CSVFileHeader}',"ldap-group.enable","ldap-group.group","ldap-group.according-to"'
export CSVFileHeader=${CSVFileHeader}',"ms-isdn.enable","ms-isdn.ms-isdn","selection-mode.enable","selection-mode.mode"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.utran","radio-access-technology.geran","radio-access-technology.wlan","radio-access-technology.gan"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.hspa-evolution","radio-access-technology.eutran","radio-access-technology.virtual","radio-access-technology.nb-iot"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.other-types-range.enable","radio-access-technology.other-types-range.types"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["version"], .["allow-usage-of-static-ip"], .["cs-fallback-and-srvcc"], .["radio-access-technology"]'
export CSVJQparms=${CSVJQparms}', .["restoration-and-recovery"], .["reverse-service"], .["trace-management"]'
export CSVJQparms=${CSVJQparms}', .["access-point-name"]["enable"], .["access-point-name"]["apn"], .["apply-access-policy-on-user-traffic"]["enable"], .["apply-access-policy-on-user-traffic"]["add-imsi-field-to-log"]'
export CSVJQparms=${CSVJQparms}', .["imsi-prefix"]["enable"], .["imsi-prefix"]["prefix"], .["interface-profile"]["profile"], .["interface-profile"]["custom-message-types"]'
export CSVJQparms=${CSVJQparms}', .["ldap-group"]["enable"], .["ldap-group"]["group"], .["ldap-group"]["according-to"]'
export CSVJQparms=${CSVJQparms}', .["ms-isdn"]["enable"], .["ms-isdn"]["ms-isdn"], .["selection-mode"]["enable"], .["selection-mode"]["mode"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["utran"], .["radio-access-technology"]["geran"], .["radio-access-technology"]["wlan"], .["radio-access-technology"]["gan"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["hspa-evolution"], .["radio-access-technology"]["eutran"], .["radio-access-technology"]["virtual"], .["radio-access-technology"]["nb-iot"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["other-types-range"]["enable"], .["radio-access-technology"]["other-types-range"]["types"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescitrixtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescitrixtcp="${objectstotal_servicescitrixtcp}"
export number_of_objects=${number_servicescitrixtcp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-citrix-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["application"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescitrixtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescitrixtcp="${objectstotal_servicescitrixtcp}"
export number_of_objects=${number_servicescitrixtcp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-compound-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
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
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["compound-service"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescompoundtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescompoundtcp="${objectstotal_servicescompoundtcp}"
export number_of_objects=${number_servicescompoundtcp}

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_service_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_service_groups="${objectstotal_service_groups}"
export number_of_objects=${number_service_groups}

#CheckAPIVersionAndExecuteOperation


#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-08-28
# MODIFIED 2021-01-19 - 3 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"primary-category","urls-defined-as-regular-expression"'
# user-defined can't be imported so while shown, it adds no value for normal operations
if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export CSVFileHeader=${CSVFileHeader}',"user-defined","risk"'
fi
# The next elements are more complex elements, but required for import add operation
export CSVFileHeader=${CSVFileHeader}',"url-list.0","application-signature.0"'
# The next elements are more complex elements, but NOT required for import add operation
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
export CSVFileHeader=${CSVFileHeader}',"description'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["primary-category"], .["urls-defined-as-regular-expression"]'
# user-defined can't be imported so while shown, it adds no value for normal operations
if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export CSVJQparms=${CSVJQparms}', .["user-defined"], .["risk"]'
fi
# The next elements are more complex elements, but required for import add operation
export CSVJQparms=${CSVJQparms}', .["url-list"][0], .["application-signature"][0]'
# The next elements are more complex elements, but NOT required for import add operation
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_application_sites=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_sites="${objectstotal_application_sites}"
export number_of_objects=${number_application_sites}

#CheckAPIVersionAndExecuteOperation


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-19 - 3
# MODIFIED 2021-01-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

objectstotal_application_site_categories=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
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

export APIobjectminversion=1.1
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

objectstotal_application_site_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_site_groups="${objectstotal_application_site_groups}"
export number_of_objects=${number_application_site_groups}

#CheckAPIVersionAndExecuteOperation


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-19
# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Users
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Users' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# -------------------------------------------------------------------------------------------------
# user objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectminversion=1.6.1
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
#export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server.name","tacacs-server.name"'
export CSVFileHeader=${CSVFileHeader}',"expiration-date"'
export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["template"], .["e-mail"], .["phone-number"]'
#export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
export CSVJQparms=${CSVJQparms}', .["expiration-date"]["iso-8601"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_users=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_users="${objectstotal_users}"
export number_of_objects=${number_users}

CheckAPIVersionAndExecuteOperation

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
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

objectstotal_user_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_user_groups="${objectstotal_user_groups}"
export number_of_objects=${number_user_groups}

CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-template objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"authentication-method","radius-server.name","tacacs-server.name"'
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

objectstotal_user_templates=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_user_templates="${objectstotal_user_templates}"
export number_of_objects=${number_user_templates}

CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# identity-tag objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
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

objectstotal_identity_tags=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_identity_tags="${objectstotal_identity_tags}"
export number_of_objects=${number_identity_tags}

#CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# no more simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle complex objects
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

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportComplexObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportComplexObjectsToCSVviaJQ () {
    
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
    export APICLICSVfileoriginal=${APICLICSVfilewip}.original
    
    
    if [ ! -r ${APICLICSVpathexportwip} ] ; then
        mkdir -p -v ${APICLICSVpathexportwip} | tee -a -i ${logfilepath}
    fi
    
    if [ -r ${APICLICSVfile} ] ; then
        rm ${APICLICSVfile} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileheader} ] ; then
        rm ${APICLICSVfileheader} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfiledata} ] ; then
        rm ${APICLICSVfiledata} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfilesort} ] ; then
        rm ${APICLICSVfilesort} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileoriginal} ] ; then
        rm ${APICLICSVfileoriginal} >> ${logfilepath}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo "Create ${APICLIcomplexobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    #
    # Troubleshooting output
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
        echo 'CSVFileHeader' - ${CSVFileHeader} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    echo ${CSVFileHeader} > ${APICLICSVfileheader} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# FinalizeExportComplexObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeExportComplexObjectsToCSVviaJQ () {
    #
    # The FinalizeExportComplexObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
    #
    
    if [ ! -r "${APICLICSVfileheader}" ] ; then
        # Uh, Oh, something went wrong, no header file
        echo | tee -a -i ${logfilepath}
        echo '!!!! Error header file missing : '${APICLICSVfileheader} | tee -a -i ${logfilepath}
        echo 'Terminating!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 254
        
    elif [ ! -r "${APICLICSVfiledata}" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo | tee -a -i ${logfilepath}
        echo '!!!! Error data file missing : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo 'Terminating!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 253
        
    elif [ ! -s "${APICLICSVfiledata}" ] ; then
        # data file is empty, nothing was found
        echo | tee -a -i ${logfilepath}
        echo '!! data file is empty : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo 'Skipping CSV creation!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 0
        
    fi
    
    echo | tee -a -i ${logfilepath}
    echo "Sort data and build CSV export file" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfileoriginal}
    cat ${APICLICSVfiledata} >> ${APICLICSVfileoriginal}
    
    sort ${APICLICSVsortparms} ${APICLICSVfiledata} > ${APICLICSVfilesort}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfile}
    cat ${APICLICSVfilesort} >> ${APICLICSVfile}
    
    echo | tee -a -i ${logfilepath}
    echo "Done creating ${APICLIcomplexobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    head ${APICLICSVfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    
    echo | tee -a -i ${logfilepath}
    return 0
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


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


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Generic Complex Objects Type Handler' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2021-01-18 -


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfObjectsType generates an array of objects type objects for further processing.

PopulateArrayOfObjectsType () {
    
    # MODIFIED 2018-07-20 -
    
    # System Object selection operands
    # Future alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    
    echo "  ${APICLIobjectstype} - Populate up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentobjecttypesoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} '.objects[] | '"${notsystemobjectselector}"' | .name | @sh' -r`"
    else   
        # Don't Ignore System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level "standard" -s ${APICLIsessionfile} -f json | ${JQ} ".objects[].name | @sh" -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    while read -r line; do
        ALLOBJECTSTYPARRAY+=("${line}")
        echo -n '.'
    done <<< "${MGMT_CLI_OBJECTSTYPE_STRING}"
    echo
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# GetArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfObjectsType generates an array of objects type objects for further processing.

GetArrayOfObjectsType () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    echo | tee -a -i ${logfilepath}
    echo 'Generate array of '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    ALLOBJECTSTYPARRAY=()
    
    export MgmtCLI_Base_OpParms="-f json -s ${APICLIsessionfile}"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"${APICLIdetaillvl}\" ${MgmtCLI_Base_OpParms}"
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    
    currentobjecttypesoffset=0
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentobjecttypesoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
        
        PopulateArrayOfObjectsType
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentobjecttypesoffset=`expr ${currentobjecttypesoffset} + ${WorkAPIObjectLimit}`
    done
    
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# DumpArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfObjectsType outputs the array of objects type objects.

DumpArrayOfObjectsType () {
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all objects found
        
        # print the elements in the array
        echo | tee -a -i ${logfilepath}
        echo 'Dump '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        for i in "${ALLOBJECTSTYPARRAY[@]}"
        do
            echo "$i, ${i//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo | tee -a -i ${logfilepath}
        echo 'Done dumping '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# CollectMembersInObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectMembersInObjectsType outputs the number of objects type members in a group in the array of objects type objects and collects them into the csv file.

CollectMembersInObjectsType () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo | tee -a -i ${logfilepath}
    echo 'Use array of '${APICLIobjectstype}' to generate objects type members CSV' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    for i in "${ALLOBJECTSTYPARRAY[@]}"
    do
        echo | tee -a -i ${logfilepath}
        
        MEMBERS_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${i//\'/}" -s ${APICLIsessionfile} -f json | ${JQ} ".members | length")
        
        NUM_OBJECTSTYPE_MEMBERS=${MEMBERS_COUNT}
        
        if [ ${NUM_OBJECTSTYPE_MEMBERS} -gt 0 ]; then
            # More than zero (0) interfaces, something to process
            echo Group "${i//\'/}"' number of members = '"${NUM_OBJECTSTYPE_MEMBERS}" | tee -a -i ${logfilepath}
            
            COUNTER=0
            
            while [ ${COUNTER} -lt ${NUM_OBJECTSTYPE_MEMBERS} ]; do
                
                MEMBER_NAME=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} ".members[${COUNTER}].name")
                
                if ${APISCRIPTVERBOSE} ; then
                    # Verbose mode ON
                    echo -n '.'
                fi
                
                # Build the output line
                echo -n ${i//\'/},${MEMBER_NAME} >> ${APICLICSVfiledata}
                
                if ${CSVADDEXPERRHANDLE} ; then
                    echo -n 'e'
                    
                    #export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
                    #export CSVJQparms=${CSVJQparms}', true, true'
                    #
                    echo -n ', true, true' >> ${APICLICSVfiledata}
                    
                    # May need to add plumbing to handle the case that not all objects types might support set-if-exists
                    # For now just keep it separate
                    #
                    #export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
                    #export CSVJQparms=${CSVJQparms}', true'
                    
                    #echo -n ', true' >> ${APICLICSVfiledata}
                fi
                
                echo >> ${APICLICSVfiledata}
                
                let COUNTER=COUNTER+1
                
            done
            
        else
            echo Group "${i//\'/}"' number of members = NONE (0 zero)'
        fi
        
    done
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# GetObjectMembers proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetObjectMembers generate output of objects type members from existing objects type objects

GetObjectMembers () {
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        #export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
        #export CSVJQparms=${CSVJQparms}', true'
    fi
    
    SetupExportComplexObjectsToCSVviaJQ
    
    GetArrayOfObjectsType
    
    DumpArrayOfObjectsType
    
    CollectMembersInObjectsType
    
    errorreturn=0
    
    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Error '${errorreturn}' in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
    fi
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GenericComplexObjectsMembersHandler proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GenericComplexObjectsMembersHandler () {
    #
    # Generic Handler for Complex Object Types
    
    errorreturn=0
    
    objectstotal_object=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    export number_object="${objectstotal_object}"
    
    if [ ${number_object} -le 0 ] ; then
        # No groups found
        echo | tee -a -i ${logfilepath}
        echo 'No '${APICLIobjectstype}' to generate members from!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        GetObjectMembers
        errorreturn=$?
    fi
    
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
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

export APIobjectminversion=1.1
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

export APIobjectminversion=1.7
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

export APIobjectminversion=1.1
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

export APIobjectminversion=1.1
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

export APIobjectminversion=1.6.1
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


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Specific Complex Objects :  These require extra plumbing' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : host interfaces
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Specific Complex OBJECT : host interfaces' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# MODIFIED 2021-01-27 -

# -------------------------------------------------------------------------------------------------
# PopulateArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfHostInterfaces populates array of host objects for further processing.

PopulateArrayOfHostInterfaces () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    # MODIFIED 2018-07-20 -
    
    # System Object selection operands
    # Future alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    
    echo | tee -a -i ${logfilepath}
    echo "  ${APICLIobjectstype} - Populate up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currenthostoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    # MGMT_CLI_HOSTS_STRING is a string with multiple lines. Each line contains a name of a host.
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} '.objects[] | '"${notsystemobjectselector}"' | .name | @sh' -r`"
    else
        # Don't Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level "standard" -s ${APICLIsessionfile} -f json | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
    fi
    
    while read -r line; do
        
        ALLHOSTSARR+=("${line}")
        
        echo -n '.' | tee -a -i ${logfilepath}
        
        arraylength=${#ALLHOSTSARR[@]}
        arrayelement=$((arraylength-1))
        
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            # Output list of all hosts found
            echo -n ' '"${line}"', ' | tee -a -i ${logfilepath}
            echo -n "$(eval echo ${line})"', ' | tee -a -i ${logfilepath}
            echo -n "$arraylength"', ' | tee -a -i ${logfilepath}
            echo -n "$arrayelement"', ' | tee -a -i ${logfilepath}
            #echo -n "$(eval echo ${ALLHOSTARR[${arrayelement}]})"', ' | tee -a -i ${logfilepath}
        fi
        
        #INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${ALLHOSTARR[${arrayelement}]})" details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} ".interfaces | length")
        INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${line})" details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} ".interfaces | length")
        
        NUM_HOST_INTERFACES=${INTERFACES_COUNT}
        
        if ${APISCRIPTVERBOSE} ; then
            echo -n "${NUM_HOST_INTERFACES}"', ' | tee -a -i ${logfilepath}
        else
            echo -n "${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
        fi
        
        if [ ${NUM_HOST_INTERFACES} -gt 0 ]; then
            HOSTSARR+=("${line}")
            let HostInterfacesCount=HostInterfacesCount+${NUM_HOST_INTERFACES}
            echo -n '!' | tee -a -i ${logfilepath}
        else
            echo -n '-' | tee -a -i ${logfilepath}
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo | tee -a -i ${logfilepath}
        fi
        
    done <<< "${MGMT_CLI_HOSTS_STRING}"
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
        echo 'HostInterfacesCount = '${HostInterfacesCount} | tee -a -i ${logfilepath}
    fi
    
    export HostInterfacesCount=${HostInterfacesCount}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# GetArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfHostInterfaces generates an array of host objects for further processing.

GetArrayOfHostInterfaces () {
    
    echo | tee -a -i ${logfilepath}
    echo 'Generate array of hosts' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    HOSTSARR=()
    ALLHOSTSARR=()
    
    export MgmtCLI_Base_OpParms="-f json -s ${APICLIsessionfile}"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"${APICLIdetaillvl}\" ${MgmtCLI_Base_OpParms}"
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    
    currenthostoffset=0
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currenthostoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
        
        PopulateArrayOfHostInterfaces
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currenthostoffset=`expr ${currenthostoffset} + ${WorkAPIObjectLimit}`
    done
    
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    echo 'Final HostInterfacesCount = '${HostInterfacesCount} | tee -a -i ${logfilepath}
    echo 'Final Host Array = '\>"${HOSTSARR[@]}"\< | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# DumpArrayOfHostsObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfHostsObjects outputs the array of host objects.

DumpArrayOfHostsObjects () {
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all hosts found
        
        # print the elements in the array
        #echo | tee -a -i ${logfilepath}
        #echo Dump All hosts | tee -a -i ${logfilepath}
        #echo | tee -a -i ${logfilepath}
        #
        #for i in "${ALLHOSTSARR[@]}"
        #do
        #    echo "$i, ${i//\'/}" | tee -a -i ${logfilepath}
        #done
        
        echo | tee -a -i ${logfilepath}
        echo hosts with interfaces defined | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        for j in "${HOSTSARR[@]}"
        do
            echo "$j, ${j//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo | tee -a -i ${logfilepath}
        echo Done dumping hosts | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectInterfacesInHostObjects outputs the host interfaces in a host in the array of host objects and collects them into the csv file.

CollectInterfacesInHostObjects () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo | tee -a -i ${logfilepath}
    echo 'Use array of hosts to generate host interfaces CSV' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    for i in "${HOSTSARR[@]}"
    do
        echo | tee -a -i ${logfilepath}
        echo Host with interfaces "${i//\'/}" | tee -a -i ${logfilepath}
        
        INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${i//\'/}" -s ${APICLIsessionfile} -f json | ${JQ} ".interfaces | length")
        
        NUM_HOST_INTERFACES=${INTERFACES_COUNT}
        
        if [ ${NUM_HOST_INTERFACES} -gt 0 ]; then
            # More than zero (0) interfaces, something to process
            echo host "${i//\'/}"' number of interfaces = '"${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
            
            COUNTER=0
            if ${APISCRIPTVERBOSE} ; then
                # Verbose mode ON
                echo ${CSVFileHeader} | tee -a -i ${logfilepath}
            fi
            
            while [ ${COUNTER} -lt ${NUM_HOST_INTERFACES} ]; do
                
                #echo -n '.' | tee -a -i ${logfilepath}
                
                #export CSVJQparms='.["name"], .["interfaces"]['${COUNTER}']["name"]'
                #export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet4"], .["interfaces"]['${COUNTER}']["mask-length4"], .["interfaces"]['${COUNTER}']["subnet-mask"]'
                #export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet4"], .["interfaces"]['${COUNTER}']["mask-length4"],
                #export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet6"], .["interfaces"]['${COUNTER}']["mask-length6"]'
                #export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["color"], .["interfaces"]['${COUNTER}']["comments"]'
                
                INTERFACE_NAME=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["name"]')
                INTERFACE_subnet4=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["subnet4"]')
                INTERFACE_masklength4=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["mask-length4"]')
                INTERFACE_subnetmask=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["subnet-mask"]')
                INTERFACE_subnet6=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["subnet6"]')
                INTERFACE_masklength6=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["mask-length6"]')
                INTERFACE_COLOR=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["color"]')
                INTERFACE_COMMENT=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["comments"]')
                
                export CSVoutputline="${i//\'/}","$INTERFACE_NAME"
                #export CSVoutputline=${CSVoutputline},"${INTERFACE_subnet4}","${INTERFACE_masklength4}","$INTERFACE_subnetmask"
                export CSVoutputline=${CSVoutputline},"${INTERFACE_subnet4}","${INTERFACE_masklength4}"
                export CSVoutputline=${CSVoutputline},"${INTERFACE_subnet6}","${INTERFACE_masklength6}"
                export CSVoutputline=${CSVoutputline},"${INTERFACE_COLOR}","${INTERFACE_COMMENT}"
                
                if ${CSVADDEXPERRHANDLE} ; then
                    #export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
                    #export CSVJQparms=${CSVJQparms}', true, true'
                    #
                    
                    export CSVoutputline=${CSVoutputline}', true, true'
                    
                    # May need to add plumbing to handle the case that not all objects types might support set-if-exists
                    # For now just keep it separate
                    #
                    #export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
                    #export CSVJQparms=${CSVJQparms}', true'
                    
                    export CSVoutputline=${CSVoutputline}', true'
                fi
                
                if ${APISCRIPTVERBOSE} ; then
                    # Verbose mode ON
                    echo ${CSVoutputline} | tee -a -i ${logfilepath}
                fi
                
                echo ${CSVoutputline} >> ${APICLICSVfiledata} | tee -a -i ${logfilepath}
                
                let COUNTER=COUNTER+1
                
            done
        else
            echo host "${i//\'/}"' number of interfaces = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# GetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetHostInterfaces generate output of host's interfaces from existing hosts with interface objects

GetHostInterfaces () {
    
    export HostInterfacesCount=0
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
        export CSVJQparms=${CSVJQparms}', true'
    fi
    
    SetupExportComplexObjectsToCSVviaJQ
    
    GetArrayOfHostInterfaces
    
    if [ ${HostInterfacesCount} -gt 0 ]; then
        # We have host interfaces to process
        DumpArrayOfHostsObjects
        
        CollectInterfacesInHostObjects
        
        FinalizeExportComplexObjectsToCSVviaJQ
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            return ${errorreturn}
        fi
        
    else
        # No host interfaces
        echo | tee -a -i ${logfilepath}
        echo '! No host interfaces found' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    fi
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : host interfaces
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.1
export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLIcomplexobjecttype=host-interface
export APICLIcomplexobjectstype=host-interfaces
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

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

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_hosts="${objectstotal_hosts}"

if [ ${number_hosts} -le 0 ] ; then
    # No hosts found
    echo | tee -a -i ${logfilepath}
    echo 'No hosts to generate interfaces from!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
else
    # hosts found
    echo | tee -a -i ${logfilepath}
    echo 'Check hosts to generate interfaces!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    GetHostInterfaces
fi

echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : users authentications
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Specific Complex OBJECT : users authentications' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# ExportUserAuthenticationsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportUserAuthenticationsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjectstype} item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportUserAuthenticationsToCSVviaJQ () {
    #
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
        export CSVJQparms=${CSVJQparms}', true'
    fi
    
    SetupExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure SetupExportComplexObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    export MgmtCLI_Base_OpParms="-f json -s ${APICLIsessionfile}"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"full\" ${MgmtCLI_Base_OpParms}"
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    export userauthtypeselectorelement='."'"${APICLIexportkeycheck}"'" == "'"${APICLIexportkeyvalue}"'"'
    
    # MODIFIED 2018-07-20 -
    
    # System Object selection operands
    # Future alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselectorelement='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not'
    
    # We need to assemble a more complicated selection method for this
    #
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        export userauthobjectselector='select(('"${notsystemobjectselectorelement}"') and ('"${userauthtypeselectorelement}"'))'
    else
        # Don't Ignore System Objects
        export userauthobjectselector='select('"${userauthtypeselectorelement}"')'
    fi
    
    echo | tee -a -i ${logfilepath}
    echo '  '${APICLIobjectstype}' - Populate up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentuseroffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
    echo '  '${APICLIobjectstype}' - Selection criteria '${userauthobjectselector} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentuseroffset=0
    
    echo | tee -a -i ${logfilepath}
    echo "Export ${APICLIobjectstype} to CSV File" | tee -a -i ${logfilepath}
    echo "  and dump to ${APICLICSVfile}" | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo "  mgmt_cli parameters : ${MgmtCLI_Show_OpParms}" | tee -a -i ${logfilepath}
        echo '  CSVJQparms' - ${CSVJQparms} | tee -a -i ${logfilepath}
        echo "  User Authentication Selector : "${userauthobjectselector} | tee -a -i ${logfilepath}
    fi
    echo | tee -a -i ${logfilepath}
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentuseroffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentuseroffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        #errorreturn=$?
        
        mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentuseroffset} details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} '.objects[] | '"${userauthobjectselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo 'Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentuseroffset=`expr ${currentuseroffset} + ${WorkAPIObjectLimit}`
    done
    
    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure FinalizeExportComplexObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
        return ${errorreturn}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo
        echo "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# GetUserAuthentications proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetUserAuthentications generate output of host's interfaces from existing hosts with interface objects

GetUserAuthentications () {
    
    errorreturn=0
    
    ExportUserAuthenticationsToCSVviaJQ
    
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Error '${errorreturn}' in ExportUserAuthenticationsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
    fi
    
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications :  passwords
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users

#
# APICLICSVsortparms can change due to the nature of the object
#
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
#export CSVFileHeader='"template","e-mail","phone-number"'
#export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server.name","tacacs-server.name"'
#export CSVFileHeader=${CSVFileHeader}',"expiration-date"'
#export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
#export CSVJQparms='.["template"], .["e-mail"], .["phone-number"]'
#export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
#export CSVJQparms=${CSVJQparms}', .["expiration-date"]["iso-8601"]'
#export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_users=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_users="${objectstotal_users}"

if [ ${number_users} -le 0 ] ; then
    # No Users found
    echo | tee -a -i ${logfilepath}
    echo 'No '${APICLIobjectstype}' to generate authentications from!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
else
    # Users found
    
    # User export with credential information is not working properly when done as a complete object.
    # Handling the export of explicit per user authentication method and inforamtion later in specific complex objects, one export for each authentication-method
    # NOTE:  It is not possible to export users Check Point Password value
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-checkpointpassword'
    export APICLIcomplexobjectstype='users-with-auth-checkpointpassword'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='check point password'
    
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
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-ospassword'
    export APICLIcomplexobjectstype='users-with-auth-ospassword'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='os password'
    
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
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-securid'
    export APICLIcomplexobjectstype='users-with-auth-securid'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='securid'
    
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
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-radius'
    export APICLIcomplexobjectstype='users-with-auth-radius'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='radius'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    #export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server.name","tacacs-server.name"'
    #export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"radius-server"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', .["radius-server"]["name"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-tacacs'
    export APICLIcomplexobjectstype='users-with-auth-tacacs'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='tacacs'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    
    #export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server.name","tacacs-server.name"'
    #export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
    
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"tacacs-server.name"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', .["tacacs-server"]["name"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-undefined'
    export APICLIcomplexobjectstype='users-with-auth-undefined'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='undefined'
    
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
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'No more complex objects' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo ${APICLIdetaillvl}' CSV dump - Completed!' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

echo | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Finished with exporting
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo 'Dumps Completed!' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


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

# MODIFIED 2020-11-17 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if [ x"${CLIparm_CLEANUPWIP}" = x"true" ] ; then
    # Remove Work-In-Progress folder and files
    
    if [ -r ${APICLICSVpathexportwip} ] ; then
        if ${APISCRIPTVERBOSE} ; then
            echo 'Remove CSV Work-In-Progress folder and files' | tee -a -i ${logfilepath}
            echo '   CSV WIP Folder : '${APICLICSVpathexportwip} | tee -a -i ${logfilepath}
        else
            echo 'Remove CSV Work-In-Progress folder and files' >> ${logfilepath}
            echo '   CSV WIP Folder : '${APICLICSVpathexportwip} >> ${logfilepath}
        fi
        rm -v -r ${APICLICSVpathexportwip} | tee -a -i ${logfilepath}
    fi
    
    if [ -r ${APICLIJSONpathexportwip} ] ; then
        if ${APISCRIPTVERBOSE} ; then
            echo 'Remove JSON Work-In-Progress folder and files' | tee -a -i ${logfilepath}
            echo '   JSON WIP Folder : '${APICLIJSONpathexportwip} | tee -a -i ${logfilepath}
        else
            echo 'Remove JSON Work-In-Progress folder and files' >> ${logfilepath}
            echo '   JSON WIP Folder : '${APICLIJSONpathexportwip} >> ${logfilepath}
        fi
        rm -v -r ${APICLIJSONpathexportwip} | tee -a -i ${logfilepath}
    fi

fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-17


# -------------------------------------------------------------------------------------------------
# Clean-up and exit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo 'CLI Operations Completed' | tee -a -i ${logfilepath}

if ${APISCRIPTVERBOSE} ; then
    # Verbose mode ON
    
    echo | tee -a -i ${logfilepath}
    #echo "Files in >${APICLIpathroot}<" | tee -a -i ${logfilepath}
    #ls -alh ${APICLIpathroot} | tee -a -i ${logfilepath}
    #echo | tee -a -i ${logfilepath}
    
    if [ "${APICLIlogpathbase}" != "${APICLIpathbase}" ] ; then
        echo 'Files in >'"${APICLIlogpathbase}"'<' | tee -a -i ${logfilepath}
        ls -alhR ${APICLIpathbase} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    fi
    
    echo 'Files in >'"${APICLIpathbase}"'<' | tee -a -i ${logfilepath}
    ls -alhR ${APICLIpathbase} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
else
    # Verbose mode OFF
    
    echo >> ${logfilepath}
    #echo "Files in >${APICLIpathroot}<" >> ${logfilepath}
    #ls -alh ${APICLIpathroot} >> ${logfilepath}
    #echo >> ${logfilepath}
    
    if [ "${APICLIlogpathbase}" != "${APICLIpathbase}" ] ; then
        echo 'Files in >'"${APICLIlogpathbase}"'<' >> ${logfilepath}
        ls -alhR ${APICLIpathbase} >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    echo 'Files in >'"${APICLIpathbase}"'<' >> ${logfilepath}
    ls -alhR ${APICLIpathbase} >> ${logfilepath}
    echo >> ${logfilepath}
fi

echo | tee -a -i ${logfilepath}
echo 'Results in directory : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
echo 'Log output in file   : '"${logfilepath}" | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-01-18


# =================================================================================================
# END:  Publish, Cleanup, and Dump output
# =================================================================================================
# =================================================================================================

