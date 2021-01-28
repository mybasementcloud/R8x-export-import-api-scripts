#!/bin/bash
#
# SCRIPT Subpend CSV Error Handling to CSV files
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

ScriptName=api_subpend_csv_error_handling_to_csv_files
export APIScriptFileNameRoot=api_subpend_csv_error_handling_to_csv_files
export APIScriptShortName=api_subpend_csv_error_handling
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Subpend CSV Error Handling to CSV files"

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


# 2018-05-02 - script type - template - test it all

export script_use_publish="false"

export script_use_export="false"
export script_use_import="true"
export script_use_delete="false"
export script_use_csvfile="false"

export script_dump_csv="false"
export script_dump_json="false"
export script_dump_standard="false"
export script_dump_full="false"

export script_uses_wip="false"
export script_uses_wip_json="false"

# ADDED 2018-10-27 -
export UseR8XAPI=false
export UseJSONJQ=false


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
    localworkoutputfile=/var/tmp/localworkoutputfile.2.${DATEDTGS}.txt
    echo > $localworkoutputfile
    
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo 'Local CLI Parameters :' >> $localworkoutputfile
    echo >> $localworkoutputfile
    
    #echo 'CLIparm_local1          = '${CLIparm_local1} >> $localworkoutputfile
    #echo 'CLIparm_local2          = '$CLIparm_local2 >> $localworkoutputfile
    
    #                  1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #       01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo  >> $localworkoutputfile
    echo 'LOCALREMAINS            = '${LOCALREMAINS} >> $localworkoutputfile
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo | tee -a -i ${logfilepath}
        cat $localworkoutputfile | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        for i ; do echo - $i | tee -a -i ${logfilepath} ; done
        echo | tee -a -i ${logfilepath}
        echo 'CLI parms - number :  '"$#"' parms :  >'"$@"'<' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        #if ! ${NOWAIT} ; then
            #read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            #echo
        #fi
        
        #echo | tee -a -i ${logfilepath}
        echo "End of local execution" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    else
        # Verbose mode OFF
        
        echo >> ${logfilepath}
        cat $localworkoutputfile >> ${logfilepath}
        echo >> ${logfilepath}
        for i ; do echo - $i >> ${logfilepath} ; done
        echo >> ${logfilepath}
        echo 'CLI parms - number :  '"$#"' parms :  >'"$@"'<' >> ${logfilepath}
        echo >> ${logfilepath}
        
    fi
    
    rm $localworkoutputfile
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


# -------------------------------------------------------------------------------------------------
# dumpcliparmparseresults
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-12-17 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumpcliparmparseresults () {
    #
    #
    # Testing - Dump aquired values
    #
    
    workoutputfile=/var/tmp/workoutputfile.1.${DATEDTGS}.txt
    echo > ${workoutputfile}
    
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    #printf "%-40s = %s\n" 'X' "${X}" >> ${workoutputfile}
    #
    
    echo 'CLI Parameters :' >> ${workoutputfile}
    echo >> ${workoutputfile}
    
    if ${UseR8XAPI} ; then
        
        #
        # Screen width template for sizing, default width of 80 characters assumed
        #
        #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
        #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
        #printf "%-40s = %s\n" 'X' "${X}" >> ${workoutputfile}
        
        printf "%-40s = %s\n" 'CLIparm_rootuser' "${CLIparm_rootuser}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_user' "${CLIparm_user}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_password' "${CLIparm_password}" >> ${workoutputfile}
        
        printf "%-40s = %s\n" 'CLIparm_api_key' "${CLIparm_api_key}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_use_api_key' "${CLIparm_use_api_key}" >> ${workoutputfile}
        
        printf "%-40s = %s\n" 'CLIparm_websslport' "${CLIparm_websslport}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_mgmt' "${CLIparm_mgmt}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_domain' "${CLIparm_domain}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_sessionidfile' "${CLIparm_sessionidfile}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_sessiontimeout' "${CLIparm_sessiontimeout}" >> ${workoutputfile}
        
    fi
    
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    printf "%-40s = %s\n" 'CLIparm_logpath' "${CLIparm_logpath}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_outputpath' "${CLIparm_outputpath}" >> ${workoutputfile}
    
    echo >> ${workoutputfile}
    printf "%-40s = %s\n" 'SHOWHELP' "${SHOWHELP}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'SCRIPTVERBOSE' "${SCRIPTVERBOSE}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'APISCRIPTVERBOSE' "${APISCRIPTVERBOSE}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'NOWAIT' "${NOWAIT}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_NOWAIT' "${CLIparm_NOWAIT}" >> ${workoutputfile}
    
    echo >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_format' "${CLIparm_format}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_formatall' "${CLIparm_formatall}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_formatcsv' "${CLIparm_formatcsv}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_formatjson' "${CLIparm_formatjson}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_detailslevel' "${CLIparm_detailslevel}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_detailslevelall' "${CLIparm_detailslevelall}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_detailslevelfull' "${CLIparm_detailslevelfull}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_detailslevelstandard' "${CLIparm_detailslevelstandard}" >> ${workoutputfile}
    
    echo >> ${workoutputfile}
    
    printf "%-40s = %s\n" 'CLIparm_UseDevOpsResults' "${CLIparm_UseDevOpsResults}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_resultspath' "${CLIparm_resultspath}" >> ${workoutputfile}
    
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #                  1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #       01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    if ${script_use_export} ; then
        printf "%-40s = %s\n" 'CLIparm_exportpath' "${CLIparm_exportpath}" >> ${workoutputfile}
    fi
    if ${script_use_import} ; then
        printf "%-40s = %s\n" 'CLIparm_importpath' "${CLIparm_importpath}" >> ${workoutputfile}
    fi
    if ${script_use_delete} ; then
        printf "%-40s = %s\n" 'CLIparm_deletepath' "${CLIparm_deletepath}" >> ${workoutputfile}
    fi
    if ${script_use_csvfile} ; then
        printf "%-40s = %s\n" 'CLIparm_csvpath' "${CLIparm_csvpath}" >> ${workoutputfile}
    fi
    
    printf "%-40s = %s\n" 'CLIparm_NoSystemObjects' "${CLIparm_NoSystemObjects}" >> ${workoutputfile}
    
    # ADDED 2021-01-16 -
    
    echo  >> ${workoutputfile}
    printf "%-40s = %s\n" 'CSVEXPORT05TAGS' "${CSVEXPORT05TAGS}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CSVEXPORT10TAGS' "${CSVEXPORT10TAGS}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CSVEXPORTNOTAGS' "${CSVEXPORTNOTAGS}" >> ${workoutputfile}
    if ${UseR8XAPI} ; then
        printf "%-40s = %s\n" 'CLIparm_CSVEXPORT05TAGS' "${CLIparm_CSVEXPORT05TAGS}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_CSVEXPORT10TAGS' "${CLIparm_CSVEXPORT10TAGS}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_CSVEXPORTNOTAGS' "${CLIparm_CSVEXPORTNOTAGS}" >> ${workoutputfile}
    fi
    
    echo  >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLEANUPWIP' "${CLEANUPWIP}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'NODOMAINFOLDERS' "${NODOMAINFOLDERS}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CSVADDEXPERRHANDLE' "${CSVADDEXPERRHANDLE}" >> ${workoutputfile}
    if ${UseR8XAPI} ; then
        printf "%-40s = %s\n" 'CLIparm_CLEANUPWIP' "${CLIparm_CLEANUPWIP}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_NODOMAINFOLDERS' "${CLIparm_NODOMAINFOLDERS}" >> ${workoutputfile}
        printf "%-40s = %s\n" 'CLIparm_CSVADDEXPERRHANDLE' "${CLIparm_CSVADDEXPERRHANDLE}" >> ${workoutputfile}
    fi
    
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORTDATADOMAIN' "${CLIparm_CSVEXPORTDATADOMAIN}" >> ${workoutputfile}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORTDATACREATOR' "${CLIparm_CSVEXPORTDATACREATOR}" >> ${workoutputfile}
    
    echo >> ${workoutputfile}
    printf "%-40s = %s\n" 'remains' "${REMAINS}" >> ${workoutputfile}
    
    if ${localCLIparms}; then
        dumpcliparmparselocalresults ${REMAINS}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo | tee -a -i ${logfilepath}
        cat ${workoutputfile} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo 'Number parms :  '"$#" | tee -a -i ${logfilepath}
        echo 'Raw parms    : > '"$@"' <' | tee -a -i ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e "${parmnum} \t ${k}" | tee -a -i ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo | tee -a -i ${logfilepath}
    else
        # Verbose mode ON
        
        echo >> ${logfilepath}
        cat ${workoutputfile} >> ${logfilepath}
        echo >> ${logfilepath}
        echo 'Number parms :  '"$#" >> ${logfilepath}
        echo 'Raw parms    : > '"$@"' <' >> ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e "${parmnum} \t ${k}" >> ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo >> ${logfilepath}
    fi

}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-12-17


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------




# -------------------------------------------------------------------------------------------------
# dumprawcliparms
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumprawcliparms () {
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo | tee -a -i ${logfilepath}
        echo "Command line parameters before : " | tee -a -i ${logfilepath}
        echo 'Number parms :  '"$#" | tee -a -i ${logfilepath}
        echo 'Raw parms    : > '"$@"' <' | tee -a -i ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e "${parmnum} \t ${k}" | tee -a -i ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo | tee -a -i ${logfilepath}
        
    else
        # Verbose mode OFF
        
        echo >> ${logfilepath}
        echo "Command line parameters before : " >> ${logfilepath}
        echo 'Number parms :  '"$#" >> ${logfilepath}
        echo 'Raw parms    : > '"$@"' <' >> ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e "${parmnum} \t ${k}" >> ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo >> ${logfilepath}
        
    fi
    
    return 0
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-02


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START:  Local Help display proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-10 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Show local help information.  Add script specific information here to show when help requested

doshowlocalhelp () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo
    echo 'Local Help Information : '
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    return 1
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-10

# -------------------------------------------------------------------------------------------------
# END:  Local Help display proceedure
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START:  Common Help display proceedure
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Help display proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Show help information

doshowhelp () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo
    echo -n $0' [-?][-v]'
    echo -n '|[-r]|[[-u <admin_name>]|[-p <password>]]|[--api-key <api_key_value>]'
    echo -n '|[-P <web ssl port>]'
    echo -n '|[-m <server_IP>]'
    echo -n '|[-d <domain>]'
    echo -n '|[-s <session_file_filepath>]|[--session-timeout <session_time_out>]'
    
    echo -n '|[-l <log_path>]'
    echo -n '|[-o <output_path>]'
    
    echo -n '|[-f <all|csv|json>]|[--details <all|full|standard>]'
    
    echo -n '|[--RESULTS]|[--RESULTSPATH <results_path>]'
    
    if ${script_use_export} ; then
        echo -n '|[-x <export_path>]'
    fi
    if ${script_use_import} ; then
        echo -n '|[-i <import_path>]'
    fi
    if ${script_use_delete} ; then
        echo -n '|[-k <delete_path>]'
    fi
    if ${script_use_csvfile} ; then
        echo -n '|[-c <csv_path>]'
    fi
    echo -n '|[--SO|--NSO]'
    
    echo
    
    echo
    echo ' Script Version:  '${ScriptVersion}'  Date:  '${ScriptDate}
    echo
    echo ' Standard Command Line Parameters: '
    echo
    echo '  Show Help                  -? | --help'
    echo '  Verbose mode               -v | --verbose'
    echo
    
    echo '  Authenticate as root       -r | --root'
    echo '  Set Console User Name      -u <admin_name> | --user <admin_name> |'
    echo '                             -u=<admin_name> | --user=<admin_name>'
    echo '  Set Console User password  -p <password> | --password <password> |'
    echo '                             -p=<password> | --password=<password>'
    echo '  Set Console User API Key    --api-key <api_key_value> | '
    echo '                              --api-key=<api_key_value>'
    echo
    echo '  Set [web ssl] Port         -P <web-ssl-port> | --port <web-ssl-port> |'
    echo '                             -P=<web-ssl-port> | --port=<web-ssl-port>'
    echo '  Set Management Server IP   -m <server_IP> | --management <server_IP> |'
    echo '                             -m=<server_IP> | --management=<server_IP>'
    echo '  Set Management Domain      -d <domain> | --domain <domain> |'
    echo '                             -d=<domain> | --domain=<domain>'
    echo '  Set session file path      -s <session_file_filepath> |'
    echo '                             --session-file <session_file_filepath> |'
    echo '                             -s=<session_file_filepath> |'
    echo '                             --session-file=<session_file_filepath>'
    echo '  Set session timeout value  --session-timeout <session_time_out> |'
    echo '                             --session-timeout=<session_time_out>'
    echo '      Default = 600 seconds, allowed range of values 10 - 3600 seconds'
    echo
    
    
    echo '  Set log file path          -l <log_path> | --log-path <log_path> |'
    echo '                             -l=<log_path> | --log-path=<log_path>'
    echo '  Set output file path       -o <output_path> | --output <output_path> |'
    echo '                             -o=<output_path> | --output=<output_path>'
    echo
    echo '  No waiting in verbose mode --NOWAIT'
    echo
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo '  Format for export          -f <all|csv|json> | --format <all|csv|json> |'
    echo '                             -f=<all|csv|json> | --format=<all|csv|json>'
    
    echo '  Details level for json     --details <all|full|standard> |'
    echo '                             --DETAILSLEVEL <all|full|standard> |'
    echo '                             --details=<all|full|standard> |'
    echo '                             --DETAILSLEVEL=<all|full|standard>  |'
    
    echo '  Use devops results path    --DEVOPSRESULTS | --RESULTS'
    echo '  Set results output path    --DEVOPSRESULTSPATH <results_path> |'
    echo '                             --RESULTSPATH <results_path> |'
    echo '                             --DEVOPSRESULTSPATH=<results_path> |'
    echo '                             --RESULTSPATH=<results_path> |'
    
    if ${script_use_export} ; then
        echo '  Set export file path       -x <export_path> | --export <export_path> |'
        echo '                             -x=<export_path> | --export=<export_path>'
    fi
    if ${script_use_import} ; then
        echo '  Set import file path       -i <import_path> | --import-path <import_path> |'
        echo '                             -i=<import_path> | --import-path=<import_path>'
    fi
    if ${script_use_delete} ; then
        echo '  Set delete file path       -k <delete_path> | --delete-path <delete_path> |'
        echo '                             -k=<delete_path> | --delete-path=<delete_path>'
    fi
    if ${script_use_csvfile} ; then
        echo '  Set csv file path          -c <csv_path> | --csv <csv_path |'
        echo '                             -c=<csv_path> | --csv=<csv_path>'
    fi
    echo
    echo '  NO System Objects Export   --NSO | --no-system-objects  {default mode}'
    echo '  Export System Objects      --SO | --system-objects'
    echo
    echo '  Export 5 Tags for object   --5-TAGS | --CSVEXPORT05TAGS'
    echo '  Export 10 Tags for object  --10-TAGS | --CSVEXPORT10TAGS'
    echo '  Export NO Tags for object  --NO-TAGS | --CSVEXPORTNOTAGS'
    echo
    echo '  Remove WIP folders after   --CLEANUPWIP'
    echo '  No domain name in folders  --NODOMAINFOLDERS'
    echo '  CSV export add err handler --CSVADDEXPERRHANDLE'
    echo
    echo '  Export Data Domain info    --CSVEXPORTDATADOMAIN'
    echo '  Export Data Creator info   --CSVEXPORTDATACREATOR'
    echo '  Export Data Domain and Data Creator info'
    echo '                             --CSVEXPORTDATAALL'
    echo
    
    echo '  session_file_filepath = fully qualified file path for session file'
    
    echo '  log_path = fully qualified folder path for log files'
    echo '  output_path = fully qualified folder path for output files'
    echo '  results_path = fully qualified folder path for devops results folder'
    
    if ${script_use_export} ; then
        echo '  export_path = fully qualified folder path for export files'
    fi
    if ${script_use_import} ; then
        echo '  import_path = fully qualified folder path for import files'
    fi
    if ${script_use_delete} ; then
        echo '  delete_path = fully qualified folder path for delete files'
    fi
    if ${script_use_csvfile} ; then
        echo '  csv_path = fully qualified file path for csv file'
    fi
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo
    echo ' NOTE:  Only use Management Server IP (-m) parameter if operating from a '
    echo '        different host than the management host itself.'
    echo
    echo ' NOTE:  Use the Domain Name (text) with the Domain (-d) parameter when'
    echo '        Operating in Multi Domain Management environment.'
    echo '        Use the "Global" domain for the global domain objects.'
    echo '          Quotes NOT required!'
    echo '        Use the "System Data" domain for system domain objects.'
    echo '          Quotes REQUIRED!'
    echo
    echo ' NOTE:  System Objects are NOT exported in CSV or Full JSON dump mode!'
    echo '        Control of System Objects with --SO and --NSO only works with CSV or'
    echo '        Full JSON dump.  Standard JSON dump does not support selection of the'
    echo '        System Objects during operation, so all System Objects are collected'
    echo
    
    echo ' Example: General :'
    echo
    echo ' ]# '${ScriptName}' -v --NOWAIT -P 4434 -m 192.168.1.1 -d "System Data" -s "/var/tmp/id.txt" --RESULTS --NSO'
    echo
    echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump"'
    echo ' ]# '${ScriptName}' -u fooAdmin -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump"'
    echo
    echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -d Global --SO -s "/var/tmp/id.txt"'
    echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -d "System Data" --NSO -s "/var/tmp/id.txt"'
    echo
    echo ' ]# '${ScriptName}' --api-key "@#ohtobeanapikey%" -P 4434 --NSO --format json --details all'
    echo
    echo ' ]# '${ScriptName}' --api-key "@#ohtobeanapikey%" --SO --format=all --details=full'
    
    
    if ${script_use_export} ; then
        echo ' Example: Export:'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export"'
        echo
    fi
    
    if ${script_use_import} ; then
        echo ' Example: Import:'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -i "/var/tmp/import"'
        echo
    fi
    
    if ${script_use_delete} ; then
        echo ' Example: Delete:'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export" -k "/var/tmp/delete"'
        echo
    fi
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    return 1
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-23


# -------------------------------------------------------------------------------------------------
# END:  Common Help display proceedure
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START:  command line parameter processing proceedures
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# Process command line parameters for enabling verbose output
# -------------------------------------------------------------------------------------------------

ProcessCommandLIneParameterVerboseEnable () {
    
    while [ -n "$1" ]; do
        # Copy so we can modify it (can't modify $1)
        OPT="$1"
        
        #echo OPT = ${OPT}
        
        # Parse current opt
        while [ x"${OPT}" != x"-" ] ; do
            case "${OPT}" in
                # Help and Standard Operations
                '-v' | --verbose )
                    export APISCRIPTVERBOSE=true
                    ;;
                # Anything else is ignored
                * )
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
    
    
    return 0
}

# -------------------------------------------------------------------------------------------------
# Procedure Call:  Process command line parameters for enabling verbose output
# -------------------------------------------------------------------------------------------------

#ProcessCommandLIneParameterVerboseEnable $@

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-02

# -------------------------------------------------------------------------------------------------
# Process command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-19 
#

ProcessCommandLineParametersAndSetValues () {
    
    # MODIFIED 2021-01-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    #rawcliparmdump=false
    #if ${APISCRIPTVERBOSE} ; then
        #Verbose mode ON
        #dumprawcliparms "$@"
        #rawcliparmdump=true
    #fi
    
    while [ -n "$1" ]; do
        # Copy so we can modify it (can't modify $1)
        OPT="$1"
        
        # testing
        #echo 'OPT = '${OPT}
        #
        
        # Detect argument termination
        if [ x"${OPT}" = x"--" ]; then
            # testing
            # echo "Argument termination"
            #
            
            shift
            for OPT ; do
                # MODIFIED 2019-03-08
                #REMAINS="${REMAINS} \"${OPT}\""
                REMAINS="${REMAINS} ${OPT}"
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
                # Handle immediate opts like this
                '-v' | --verbose )
                    export APISCRIPTVERBOSE=true
                    #if ! ${rawcliparmdump}; then
                        #dumprawcliparms "$@"
                        #rawcliparmdump=true
                    #fi
                    ;;
                -r | --root )
                    CLIparm_rootuser=true
                    ;;
                #-F | --force | --FORCE )
                    #FORCE=true
                    #;;
                --NOWAIT )
                    CLIparm_NOWAIT=true
                    export NOWAIT=true
                    ;;
                # Handle --flag=value opts like this
                -u=* | --user=* )
                    CLIparm_user="${OPT#*=}"
                    #shift
                    ;;
                -p=* | --password=* )
                    CLIparm_password="${OPT#*=}"
                    #shift
                    ;;
                --api-key=* )
                    CLIparm_api_key="${OPT#*=}"
                    # For internal storage, remove the quotes surrounding the api-key, 
                    # will add back on utilization
                    CLIparm_api_key=${CLIparm_api_key//\"}
                    CLIparm_use_api_key=true
                    #shift
                    ;;
                -P=* | --port=* )
                    CLIparm_websslport="${OPT#*=}"
                    #shift
                    ;;
                -m=* | --management=* )
                    CLIparm_mgmt="${OPT#*=}"
                    #shift
                    ;;
                -d=* | --domain=* )
                    CLIparm_domain="${OPT#*=}"
                    CLIparm_domain=${CLIparm_domain//\"}
                    #shift
                    ;;
                -s=* | --session-file=* )
                    CLIparm_sessionidfile="${OPT#*=}"
                    #shift
                    ;;
                --session-timeout=* )
                    CLIparm_sessiontimeout="${OPT#*=}"
                    CLIparm_sessiontimeout=${CLIparm_sessiontimeout//\"}
                    #shift
                    ;;
                -l=* | --log-path=* )
                    CLIparm_logpath="${OPT#*=}"
                    #shift
                    ;;
                -o=* | --output=* )
                    CLIparm_outputpath="${OPT#*=}"
                    #shift
                    ;;
                # and --flag value opts like this
                -u* | --user )
                    CLIparm_user="$2"
                    shift
                    ;;
                -p* | --password )
                    CLIparm_password="$2"
                    shift
                    ;;
                --api-key )
                    CLIparm_api_key="$2"
                    # For internal storage, remove the quotes surrounding the api-key, 
                    # will add back on utilization
                    CLIparm_api_key=${CLIparm_api_key//\"}
                    CLIparm_use_api_key=true
                    shift
                    ;;
                -P* | --port )
                    CLIparm_websslport="$2"
                    shift
                    ;;
                -m* | --management )
                    CLIparm_mgmt="$2"
                    shift
                    ;;
                -d* | --domain )
                    CLIparm_domain="$2"
                    CLIparm_domain=${CLIparm_domain//\"}
                    shift
                    ;;
                -s* | --session-file )
                    CLIparm_sessionidfile="$2"
                    shift
                    ;;
                --session-timeout )
                    CLIparm_sessiontimeout=$2
                    CLIparm_sessiontimeout=${CLIparm_sessiontimeout//\"}
                    #shift
                    ;;
                -l* | --log-path )
                    CLIparm_logpath="$2"
                    shift
                    ;;
                -o* | --output )
                    CLIparm_outputpath="$2"
                    shift
                    ;;
                # 
                # This section is specific to this script focus
                # 
                --DEVOPSRESULTS | --RESULTS )
                    CLIparm_UseDevOpsResults=true
                    ;;
                --SO | --system-objects )
                    CLIparm_NoSystemObjects=false
                    ;;
                --NSO | --no-system-objects )
                    CLIparm_NoSystemObjects=true
                    ;;
                --CLEANUPWIP )
                    CLIparm_CLEANUPWIP=true
                    ;;
                --NODOMAINFOLDERS )
                    CLIparm_NODOMAINFOLDERS=true
                    ;;
                --CSVADDEXPERRHANDLE )
                    CLIparm_CSVADDEXPERRHANDLE=true
                    ;;
                # ADDED 2020-09-30 -
                --CSVEXPORTDATADOMAIN )
                    CLIparm_CSVEXPORTDATADOMAIN=true
                    ;;
                --CSVEXPORTDATACREATOR )
                    CLIparm_CSVEXPORTDATACREATOR=true
                    ;;
                --CSVEXPORTDATAALL )
                    CLIparm_CSVEXPORTDATADOMAIN=true
                    CLIparm_CSVEXPORTDATACREATOR=true
                    ;;
                # ADDED 2021-01-16 -
                --5-TAGS | --CSVEXPORT05TAGS )
                    CLIparm_CSVEXPORT05TAGS=true
                    CLIparm_CSVEXPORT10TAGS=false
                    CLIparm_CSVEXPORTNOTAGS=false
                    ;;
                --10-TAGS | --CSVEXPORT10TAGS )
                    CLIparm_CSVEXPORT05TAGS=true
                    CLIparm_CSVEXPORT10TAGS=true
                    CLIparm_CSVEXPORTNOTAGS=false
                    ;;
                --NO-TAGS | --CSVEXPORTNOTAGS )
                    CLIparm_CSVEXPORT05TAGS=false
                    CLIparm_CSVEXPORT10TAGS=false
                    CLIparm_CSVEXPORTNOTAGS=true
                    ;;
                # Handle --flag=value opts like this
                # and --flag value opts like this
                -f=* | --format=* )
                    CLIparm_format="${OPT#*=}"
                    #shift
                    ;;
                -f* | --format* )
                    CLIparm_format="$2"
                    shift
                    ;;
                --details=* | --DETAILSLEVEL=* )
                    CLIparm_detailslevel="${OPT#*=}"
                    #shift
                    ;;
                --details* | --DETAILSLEVEL* )
                    CLIparm_detailslevel="$2"
                    shift
                    ;;
                --RESULTSPATH=* | --DEVOPSRESULTSPATH=* )
                    CLIparm_resultspath="${OPT#*=}"
                    #shift
                    ;;
                --RESULTSPATH* | --DEVOPSRESULTSPATH* )
                    CLIparm_resultspath="$2"
                    shift
                    ;;
                -x=* | --export=* )
                    CLIparm_exportpath="${OPT#*=}"
                    #shift
                    ;;
                -x* | --export )
                    CLIparm_exportpath="$2"
                    shift
                    ;;
                -i=* | --import-path=* )
                    CLIparm_importpath="${OPT#*=}"
                    #shift
                    ;;
                -i* | --import-path )
                    CLIparm_importpath="$2"
                    shift
                    ;;
                -k=* | --delete-path=* )
                    CLIparm_deletepath="${OPT#*=}"
                    #shift
                    ;;
                -k* | --delete-path )
                    CLIparm_deletepath="$2"
                    shift
                    ;;
                -c=* | --csv=* )
                    CLIparm_csvpath="${OPT#*=}"
                    #shift
                    ;;
                -c* | --csv )
                    CLIparm_csvpath="$2"
                    shift
                    ;;
                # Anything unknown is recorded for later
                * )
                    # MODIFIED 2019-03-08
                    #REMAINS="${REMAINS} \"${OPT}\""
                    REMAINS="${REMAINS} ${OPT}"
                    break
                    ;;
            esac
            # Check for multiple short options
            # NOTICE: be sure to update this pattern to match valid options
            # Remove any characters matching "-", and then the values between []'s
            #NEXTOPT="${OPT#-[upmdsor?]}" # try removing single short opt
            NEXTOPT="${OPT#-[vrF?]}" # try removing single short opt
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
    eval set -- ${REMAINS}
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-16
    # MODIFIED 2021-01-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    export SHOWHELP=${SHOWHELP}
    export CLIparm_websslport=${CLIparm_websslport}
    export CLIparm_rootuser=${CLIparm_rootuser}
    export CLIparm_user=${CLIparm_user}
    export CLIparm_password=${CLIparm_password}
    export CLIparm_mgmt=${CLIparm_mgmt}
    export CLIparm_domain=${CLIparm_domain}
    export CLIparm_sessionidfile=${CLIparm_sessionidfile}
    export CLIparm_sessiontimeout=${CLIparm_sessiontimeout}
    export CLIparm_logpath=${CLIparm_logpath}
    
    # ADDED 2020-08-19 -
    export CLIparm_api_key=${CLIparm_api_key}
    export CLIparm_use_api_key=${CLIparm_use_api_key}
    
    export CLIparm_outputpath=${CLIparm_outputpath}
    
    export NOWAIT=${NOWAIT}
    export CLIparm_NOWAIT=${CLIparm_NOWAIT}
    
    # ADDED 2020-11-23 -
    export CLIparm_format=${CLIparm_format}
    export CLIparm_formatall=false
    export CLIparm_formatcsv=false
    export CLIparm_formatjson=false
    case "${CLIparm_format}" in
        all | ALL )
            export CLIparm_formatall=true
            export CLIparm_formatcsv=true
            export CLIparm_formatjson=true
            ;;
        csv | CSV )
            export CLIparm_formatcsv=true
            ;;
        json | JSON )
            export CLIparm_formatjson=true
            ;;
        * )
            # Wait what?  Not an expected format
            echo 'INVALID FORMAT PROVIDED IN CLI PARAMETERS!  FORMAT = '${CLIparm_format} | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            SHOWHELP=true
            ;;
    esac
    
    # ADDED 2020-11-23 -
    if [ -z ${CLIparm_detailslevel} ] ; then
        # If 
        export CLIparm_detailslevel=all
    else
        export CLIparm_detailslevel=${CLIparm_detailslevel}
    fi
    export CLIparm_detailslevelall=true
    export CLIparm_detailslevelfull=true
    export CLIparm_detailslevelstandard=true
    case "${CLIparm_detailslevel}" in
        all | ALL )
            export CLIparm_detailslevelall=true
            export CLIparm_detailslevelfull=true
            export CLIparm_detailslevelstandard=true
            ;;
        full | FULL )
            export CLIparm_detailslevelall=false
            export CLIparm_detailslevelfull=true
            export CLIparm_detailslevelstandard=false
            ;;
        standard | STANDARD )
            export CLIparm_detailslevelall=false
            export CLIparm_detailslevelfull=false
            export CLIparm_detailslevelstandard=true
            ;;
        * )
            # Wait what?  Not an expected details level
            echo 'INVALID DETAILS LEVEL PROVIDED IN CLI PARAMETERS!  DETAILS LEVEL = '${CLIparm_detailslevel} | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            SHOWHELP=true
            ;;
    esac
    
    # ADDED 2020-11-23 -
    export CLIparm_UseDevOpsResults=${CLIparm_UseDevOpsResults}
    export UseDevOpsResults=${CLIparm_UseDevOpsResults}
    export CLIparm_resultspath=${CLIparm_resultspath}
    
    export CLIparm_exportpath=${CLIparm_exportpath}
    export CLIparm_importpath=${CLIparm_importpath}
    export CLIparm_deletepath=${CLIparm_deletepath}
    
    export CLIparm_csvpath=${CLIparm_csvpath}
    
    export CLIparm_NoSystemObjects=${CLIparm_NoSystemObjects}
    
    # ADDED 2021-01-16 -
    export CLIparm_CSVEXPORT05TAGS=${CLIparm_CSVEXPORT05TAGS}
    export CLIparm_CSVEXPORT10TAGS=${CLIparm_CSVEXPORT10TAGS}
    export CLIparm_CSVEXPORTNOTAGS=${CLIparm_CSVEXPORTNOTAGS}
    export CSVEXPORT05TAGS=${CLIparm_CSVEXPORT05TAGS}
    export CSVEXPORT10TAGS=${CLIparm_CSVEXPORT10TAGS}
    export CSVEXPORTNOTAGS=${CLIparm_CSVEXPORTNOTAGS}
    
    # ADDED 2018-05-03-2 -
    export CLIparm_CLEANUPWIP=${CLIparm_CLEANUPWIP}
    export CLIparm_NODOMAINFOLDERS=${CLIparm_NODOMAINFOLDERS}
    export CLIparm_CSVADDEXPERRHANDLE=${CLIparm_CSVADDEXPERRHANDLE}
    export CSVADDEXPERRHANDLE=${CLIparm_CSVADDEXPERRHANDLE}
    
    export CLIparm_CSVEXPORTDATADOMAIN=${CLIparm_CSVEXPORTDATADOMAIN}
    export CLIparm_CSVEXPORTDATACREATOR=${CLIparm_CSVEXPORTDATADOMAIN}
    
    export REMAINS=${REMAINS}
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-16
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# Procedure Call:  Process command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------

#ProcessCommandLineParametersAndSetValues $@

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END:  command line parameter processing proceedures
# -------------------------------------------------------------------------------------------------
# =================================================================================================

#echo 'Process Command Line Parameter Verbose Enabled' | tee -a -i ${templogfilepath}
echo 'Process Command Line Parameter Verbose Enabled' >> ${templogfilepath}
echo >> ${templogfilepath}
ProcessCommandLIneParameterVerboseEnable "$@"

#echo 'Process Command Line Parameters and Set Values' | tee -a -i ${templogfilepath}
echo 'Process Command Line Parameters and Set Values' >> ${templogfilepath}
echo >> ${templogfilepath}
ProcessCommandLineParametersAndSetValues "$@"

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
        
        #dumpcliparmparselocalresults ${REMAINS}
    fi
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30


#echo 'Dump Command Line Parameter Parsing Results' | tee -a -i ${templogfilepath}
echo 'Dump Command Line Parameter Parsing Results' >> ${templogfilepath}
echo >> ${templogfilepath}
dumpcliparmparseresults "$@"


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-02

# -------------------------------------------------------------------------------------------------
# Handle request for help (common and local) and exit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-05-31 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Was help requested, if so show it and exit
#
if ${SHOWHELP} ; then
    # Show Help
    doshowhelp "$@"
    if ${localCLIparms}; then
        doshowlocalhelp
    fi
    return 255 
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-05-31

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
# START:  API Subpend CSV Error Handling
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

echo "domainnamenospace = '${domainnamenospace}' " >> ${templogfilepath}
echo "CLIparm_NODOMAINFOLDERS = '${CLIparm_NODOMAINFOLDERS}' " >> ${templogfilepath}
echo "primarytargetoutputformat = '${primarytargetoutputformat}' " >> ${templogfilepath}
echo "APICLICSVExportpathbase = '${APICLICSVExportpathbase}' " >> ${templogfilepath}
echo "APICLIpathexport = '${APICLIpathexport}' " >> ${templogfilepath}

# ------------------------------------------------------------------------

if [ ! -z "${domainnamenospace}" ] && [ "${CLIparm_NODOMAINFOLDERS}" != "true" ] ; then
    # Handle adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}/${domainnamenospace}
    
    echo 'Handle adding domain name to path for MDM operations' >> ${templogfilepath}
    echo "APICLIpathexport = '${APICLIpathexport}' " >> ${templogfilepath}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
    fi
else
    # NOT adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}
    
    echo 'NOT adding domain name to path for MDM operations' >> ${templogfilepath}
    echo "APICLIpathexport = '${APICLIpathexport}' " >> ${templogfilepath}
    
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
echo "APICLIpathexport = '${APICLIpathexport}' " >> ${templogfilepath}
echo " = '$' " >> ${templogfilepath}

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
echo "APICLIpathexport = '${APICLIpathexport}' " >> ${templogfilepath}
echo "APICLIJSONpathexportwip = '${APICLIJSONpathexportwip}' " >> ${templogfilepath}

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
echo "APICLIpathexport = '${APICLIpathexport}' " >> ${templogfilepath}
echo "APICLICSVpathexportwip = '${APICLICSVpathexportwip}' " >> ${templogfilepath}

# ------------------------------------------------------------------------

export APICLIfileexportpost='_'${APICLIdetaillvl}'_'${APICLIfileexportsuffix}

export APICLICSVheaderfilesuffix=header

export APICLICSVfileexportpost='_'${APICLIdetaillvl}'_'${APICLICSVfileexportsuffix}

export APICLIJSONheaderfilesuffix=header
export APICLIJSONfooterfilesuffix=footer

export APICLIJSONfileexportpost='_'${APICLIdetaillvl}'_'${APICLIJSONfileexportsuffix}

echo >> ${templogfilepath}
echo 'Setup other file and path variables' >> ${templogfilepath}
echo "APICLIfileexportpost = '${APICLIfileexportpost}' " >> ${templogfilepath}
echo "APICLICSVheaderfilesuffix = '${APICLICSVheaderfilesuffix}' " >> ${templogfilepath}
echo "APICLICSVfileexportpost = '${APICLICSVfileexportpost}' " >> ${templogfilepath}
echo "APICLIJSONheaderfilesuffix = '${APICLIJSONheaderfilesuffix}' " >> ${templogfilepath}
echo "APICLIJSONfooterfilesuffix = '${APICLIJSONfooterfilesuffix}' " >> ${templogfilepath}
echo "APICLIJSONfileexportpost = '${APICLIJSONfileexportpost}' " >> ${templogfilepath}

# ------------------------------------------------------------------------

echo >> ${templogfilepath}

cat ${templogfilepath} >> ${logfilepath}
rm -v ${templogfilepath} >> ${logfilepath}

# ------------------------------------------------------------------------

echo 'Dump "'${APICLIdetaillvl}'" details to path:  '${APICLIpathexport} | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04-3


# -------------------------------------------------------------------------------------------------
# GenerateRefactoredCSV - Refactor CSV file to include API CSV Error Handling
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-10-27 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GenerateRefactoredCSV () {
    #
    # Refactor CSV file to include API CSV Error Handling
    #
    
    FILELINEARR=()
    
    #read -r -a ${FILELINEARR} -u ${fileimport}
    
    echo | tee -a -i ${logfilepath}
    echo 'Collect File into array :  '"${fileimport}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    while read -r line; do
        FILELINEARR+=("${line}")
        echo -n '.' | tee -a -i ${logfilepath}
    done < ${fileimport}
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    echo 'Dump file array and refactor lines :' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    COUNTER=0
    
    for i in "${FILELINEARR[@]}"; do
        echo "${COUNTER} >>$i<<" | tee -a -i ${logfilepath}
        if [ ${COUNTER} -eq 0 ]; then
            # Line 0 is the header
            echo "$i"',"ignore-warnings","ignore-errors","set-if-exists"' > ${filerefactor}
        else
            # Lines 1+ are the data
            echo "$i"',true,true,true' >> ${filerefactor}
        fi
        let COUNTER=COUNTER+1
    done
    
    echo | tee -a -i ${logfilepath}
    
    echo "Refactored file:" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    cat ${filerefactor} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    echo 'Done!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    echo 'Input File      :  '${fileimport} | tee -a -i ${logfilepath}
    echo 'Refactored File :  '${filerefactor} | tee -a -i ${logfilepath}
    # echo 'Operations log  :  '${fileresults} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-10-27

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - RefactorObjectsCSV
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Operational repeated proceedure - Import Simple Objects
# -------------------------------------------------------------------------------------------------

# The Operational repeated proceedure - Import Simple Objects is the meat of the script's simple
# objects releated repeated actions.
#
# For this script the ${APICLIobjecttype} items are deleted.

RefactorObjectsCSV () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    export APICLIfilename=${APICLICSVobjecttype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
    fi
    export APICLIfilename=${APICLIfilename}'_'${APICLIdetaillvl}'_csv'${APICLICSVfileexportsuffix}
    
    export APICLIImportCSVfile=${APICLICSVImportpathbase}/${APICLIfilename}
    
    export OutputPath=${APICLIpathexport}/${APICLIfilename}
    
    if [ ! -r ${APICLIImportCSVfile} ] ; then
        # no CSV file for this type of object
        echo | tee -a -i ${logfilepath}
        echo 'CSV file for object '${APICLIobjecttype}' missing : '${APICLIImportCSVfile} | tee -a -i ${logfilepath}
        echo 'Skipping!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 0
    fi
    
    export fileimport=${APICLIImportCSVfile}
    export filerefactor=${OutputPath}
    
    echo | tee -a -i ${logfilepath}
    echo "Refactor ${APICLIobjecttype} CSV File " | tee -a -i ${logfilepath}
    echo "  Original File  :  ${APICLIImportCSVfile}" | tee -a -i ${logfilepath}
    echo "  Refactore File :  ${OutputPath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    GenerateRefactoredCSV
    
    echo | tee -a -i ${logfilepath}
    tail ${OutputPath} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    echo "Done Refactoring ${APICLIobjecttype} CSV File : ${APICLIImportCSVfile}" | tee -a -i ${logfilepath}
    
    if ! ${NOWAIT} ; then
        read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
    fi
    
    echo | tee -a -i ${logfilepath}
    return 0
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo ${APICLIdetaillvl}' Refactor simple elements CSV files starting!'
echo

# -------------------------------------------------------------------------------------------------
# host objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLICSVobjecttype=hosts
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=network
export APICLIobjectstype=networks
export APICLICSVobjecttype=networks
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLICSVobjecttype=groups
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# group-with-exclusion objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group-with-exclusion
export APICLIobjectstype=groups-with-exclusion
export APICLICSVobjecttype=groups-with-exclusion
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=address-range
export APICLIobjectstype=address-ranges
export APICLICSVobjecttype=address-ranges
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dns-domain
export APICLIobjectstype=dns-domains
export APICLICSVobjecttype=dns-domains
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# security-zone objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones
export APICLICSVobjecttype=security-zones
export APICLIexportnameaddon=

RefactorObjectsCSV


# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# dynamic-objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects
export APICLICSVobjecttype=dynamic-objects
export APICLIexportnameaddon=

RefactorObjectsCSV


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27

# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Services and Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo 'Services and Applications'
echo
echo >> ${logfilepath}
echo 'Services and Applications' >> ${logfilepath}
echo >> ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27

# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLICSVobjecttype=application-sites
export APICLIexportnameaddon=

RefactorObjectsCSV

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27


# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories
export APICLICSVobjecttype=application-site-categories
export APICLIexportnameaddon=

RefactorObjectsCSV

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27


# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APICLICSVobjecttype=application-site-groups
export APICLIexportnameaddon=

RefactorObjectsCSV

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Identifying Data
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo 'Identifying Data'
echo

# -------------------------------------------------------------------------------------------------
# tags
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=tag
export APICLIobjectstype=tags
export APICLICSVobjecttype=tags
export APICLIexportnameaddon=

RefactorObjectsCSV


# ADDED 2017-07-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Future objects to export to CSV
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# simple-gateways
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways
export APICLICSVobjecttype=simple-gateways
export APICLIexportnameaddon=

#RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# times
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time
export APICLIobjectstype=times
export APICLICSVobjecttype=times
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# time_groups
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLICSVobjecttype=time-groups
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# access-roles
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles
export APICLICSVobjecttype=access-roles
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# opsec-applications
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications
export APICLICSVobjecttype=opsec-applications
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# trusted-client objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=trusted-client
export APICLIobjectstype=trusted-clients
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsv-profile objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6
export APICLIobjecttype=lsv-profile
export APICLIobjectstype=lsv-profiles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# gsn-handover-group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=gsn-handover-group
export APICLIobjectstype=gsn-handover-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-point-name objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=access-point-names
export APICLIobjectstype=access-point-names
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-server objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=tacacs-group
export APICLIobjectstype=tacacs-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Services and Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#echo
#echo 'Services and Applications'
#echo
#echo >> ${logfilepath}
#echo 'Services and Applications' >> ${logfilepath}
#echo >> ${logfilepath}

# -------------------------------------------------------------------------------------------------
# services-tcp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp
export APICLICSVobjecttype=services-tcp
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APICLICSVobjecttype=services-udp
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp
export APICLICSVobjecttype=services-icmp
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6
export APICLICSVobjecttype=services-icmp6
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APICLICSVobjecttype=services-sctp
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APICLICSVobjecttype=services-other
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc
export APICLICSVobjecttype=services-dce-rpc
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc
export APICLICSVobjecttype=services-rpc
export APICLIexportnameaddon=

RefactorObjectsCSV


# -------------------------------------------------------------------------------------------------
# services-gtp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=service-gtp
export APICLIobjectstype=services-gtp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APICLICSVobjecttype=service-groups
export APICLIexportnameaddon=

RefactorObjectsCSV


#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-08-28


# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Users
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo 'Users'
echo
echo >> ${logfilepath}
echo 'Users' >> ${logfilepath}
echo >> ${logfilepath}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# users
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=users
export APICLIobjectstype=users
export APICLICSVobjecttype=users
export APICLIexportnameaddon=

RefactorObjectsCSV

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-groups
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user-groups
export APICLIobjectstype=user-groups
export APICLICSVobjecttype=user-groups
export APICLIexportnameaddon=

RefactorObjectsCSV

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-templates
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user-templates
export APICLIobjectstype=user-templates
export APICLICSVobjecttype=user-templates
export APICLIexportnameaddon=

RefactorObjectsCSV

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# identity-tags
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=identity-tags
export APICLIobjectstype=identity-tags
export APICLICSVobjecttype=identity-tags
export APICLIexportnameaddon=

RefactorObjectsCSV

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19


# -------------------------------------------------------------------------------------------------
# no more simple objects
# -------------------------------------------------------------------------------------------------

echo
echo ${APICLIdetaillvl}' Refactor simple elements CSV files - Complete!'
echo

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo ${APICLIdetaillvl}' - Refactor complex elements CSV files Starting!'
echo

# -------------------------------------------------------------------------------------------------
# Operational repeated proceedure - Configure Complex Objects
# -------------------------------------------------------------------------------------------------

# The Operational repeated proceedure - Configure Complex Objects is the meat of the script's
# complex objects releated repeated actions.
#
# For this script the ${APICLIobjecttype} items are deleted.

ConfigureComplexObjects () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
        
    export APICLIfilename=${APICLIcomplexobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
    fi
    export APICLIfilename=${APICLIfilename}'_'${APICLIdetaillvl}'_csv'${APICLICSVfileexportsuffix}

m     export APICLIImportCSVfile=${APICLICSVImportpathbase}/${APICLIfilename}

    export OutputPath=${APICLIpathexport}/${APICLIfilename}
    
    if [ ! -r ${APICLIImportCSVfile} ] ; then
        # no CSV file for this type of object
        echo | tee -a -i ${logfilepath}
        echo 'CSV file for object '${APICLIobjecttype}' missing : '${APICLIImportCSVfile} | tee -a -i ${logfilepath}
        echo 'Skipping!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 0
    fi

    export fileimport=${APICLIImportCSVfile}
    export filerefactor=${OutputPath}

    echo | tee -a -i ${logfilepath}
    echo "Refactor ${APICLIobjecttype} CSV File " | tee -a -i ${logfilepath}
    echo "  Original File  :  ${APICLIImportCSVfile}" | tee -a -i ${logfilepath}
    echo "  Refactore File :  ${OutputPath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    GenerateRefactoredCSV

    echo | tee -a -i ${logfilepath}
    tail ${OutputPath} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}

    echo | tee -a -i ${logfilepath}
    echo "Done Refactoring ${APICLIobjecttype} CSV File : ${APICLIImportCSVfile}" | tee -a -i ${logfilepath}

    if ! ${NOWAIT} ; then
        read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
    fi

    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo
    return 0
}

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

ConfigureComplexObjects


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

ConfigureComplexObjects


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

ConfigureComplexObjects


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

ConfigureComplexObjects


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

ConfigureComplexObjects

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

ConfigureComplexObjects


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : host interfaces
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLIcomplexobjecttype=host-interface
export APICLIcomplexobjectstype=host-interfaces
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

ConfigureComplexObjects


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications :  passwords
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLIcomplexobjecttype=user-with-auth-checkpointpassword
export APICLIcomplexobjectstype=users-with-auth-checkpointpassword
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications :  passwords
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLIcomplexobjecttype=user-with-auth-ospassword
export APICLIcomplexobjectstype=users-with-auth-ospassword
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications :  passwords
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLIcomplexobjecttype=user-with-auth-securid
export APICLIcomplexobjectstype=users-with-auth-securid
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications :  passwords
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLIcomplexobjecttype=user-with-auth-radius
export APICLIcomplexobjectstype=users-with-auth-radius
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications :  passwords
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLIcomplexobjecttype=user-with-auth-tacacs
export APICLIcomplexobjectstype=users-with-auth-tacacs
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications :  passwords
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLIcomplexobjecttype=user-with-auth-undefined
export APICLIcomplexobjectstype=users-with-auth-undefined
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=


# -------------------------------------------------------------------------------------------------
# no more complex objects
# -------------------------------------------------------------------------------------------------


echo
echo ${APICLIdetaillvl}' Refactor complex elements CSV files - Completed!'
echo


# -------------------------------------------------------------------------------------------------
# no objects
# -------------------------------------------------------------------------------------------------

echo
echo 'Refactoring Completed!'
echo


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


