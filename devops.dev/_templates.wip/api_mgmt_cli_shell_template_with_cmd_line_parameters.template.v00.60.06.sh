#!/bin/bash
#
# SCRIPT Base Template for API CLI Operations with command line parameters
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

ScriptName=api_mgmt_cli_shell_template_with_cmd_line_parameters.template.v${ScriptVersion}
export APIScriptFileNameRoot=api_mgmt_cli_shell_template_with_cmd_line_parameters.template
export APIScriptShortName=api_mgmt_cli_shell_template_with_cmd_line_parameters
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Base Template for API CLI Operations with command line parameters"

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
export OpsModeAllDomains=false


# 2018-05-02 - script type - template - test it all

export script_use_publish="true"

export script_use_export="true"
export script_use_import="true"
export script_use_delete="true"
export script_use_csvfile="true"

export script_dump_csv="true"
export script_dump_json="true"
export script_dump_standard="true"
export script_dump_full="true"

export script_uses_wip="true"
export script_uses_wip_json="true"

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


export MinAPIObjectLimit=500
export MaxAPIObjectLimit=500
export WorkAPIObjectLimit=${MaxAPIObjectLimit}


# =================================================================================================
# END:  Setup Root Parameters
# =================================================================================================
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# START:  Local Variables
# =================================================================================================


export templogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log


# =================================================================================================
# START:  Local Proceedures
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Start of procedures block
# -------------------------------------------------------------------------------------------------


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


# =================================================================================================
# END:  Local Proceedures
# =================================================================================================


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

# MODIFIED 2021-02-03 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumpcliparmparselocalresults () {
    
    #
    # Testing - Dump acquired local values
    #
    #
    
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #printf "%-40s = %s\n" 'X' "${X}" >> ${templogfilepath}
    #
    
    echo >> ${templogfilepath}
    echo '--------------------------------------------------------------------------' >> ${templogfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' >> ${templogfilepath}
    echo >> ${templogfilepath}
    echo 'Local CLI Parameters :' >> ${templogfilepath}
    echo >> ${templogfilepath}
    
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #printf "%-40s = %s\n" 'X' "${X}" >> ${templogfilepath}
    #
    #printf "%-40s = %s\n" 'CLIparm_local1' "${CLIparm_local1}" >> ${templogfilepath}
    #printf "%-40s = %s\n" 'CLIparm_local2' "${CLIparm_local2}" >> ${templogfilepath}
    
    
    echo  >> ${templogfilepath}
    echo 'LOCALREMAINS            = '${LOCALREMAINS} >> ${templogfilepath}
    
    echo >> ${templogfilepath}
    echo 'Local CLI parms - number :  '"$#"' parms :  >'"$@"'<' >> ${templogfilepath}
    for i ; do echo - $i >> ${templogfilepath} ; done
    echo >> ${templogfilepath}
    
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ' >> ${templogfilepath}
    echo '--------------------------------------------------------------------------' >> ${templogfilepath}
    echo >> ${templogfilepath}
}


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-03


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


# MODIFIED 2021-02-06 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumpcliparmparseresults () {
    #
    #
    # Testing - Dump aquired values
    #
    
    SetupTempLogFile
    
    #printf "%-40s = %s\n" 'X' "${X}" >> ${templogfilepath}
    #
    
    echo 'CLI Parameters :' >> ${templogfilepath}
    echo >> ${templogfilepath}
    
    echo >> ${templogfilepath}
    printf "%-40s = %s\n" 'SHOWHELP' "${SHOWHELP}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'SCRIPTVERBOSE' "${SCRIPTVERBOSE}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'APISCRIPTVERBOSE' "${APISCRIPTVERBOSE}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'NOWAIT' "${NOWAIT}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOWAIT' "${CLIparm_NOWAIT}" >> ${templogfilepath}
    
    # ADDED 2021-02-06 -
    echo  >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOHUP' "${CLIparm_NOHUP}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOHUPScriptName' "${CLIparm_NOHUPScriptName}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOHUPDTG' "${CLIparm_NOHUPDTG}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOHUPPATH' "${CLIparm_NOHUPPATH}" >> ${templogfilepath}
    
    #printf "%-40s = %s\n" 'X' "${X}" >> ${templogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_rootuser' "${CLIparm_rootuser}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_user' "${CLIparm_user}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_password' "${CLIparm_password}" >> ${templogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_api_key' "${CLIparm_api_key}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_use_api_key' "${CLIparm_use_api_key}" >> ${templogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_websslport' "${CLIparm_websslport}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_mgmt' "${CLIparm_mgmt}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_domain' "${CLIparm_domain}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_sessionidfile' "${CLIparm_sessionidfile}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_sessiontimeout' "${CLIparm_sessiontimeout}" >> ${templogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_logpath' "${CLIparm_logpath}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_outputpath' "${CLIparm_outputpath}" >> ${templogfilepath}
    
    echo >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NoSystemObjects' "${CLIparm_NoSystemObjects}" >> ${templogfilepath}
    
    # ADDED 2021-02-03 -
    echo >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CreatorIsNotSystem' "${CLIparm_CreatorIsNotSystem}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CreatorIsNotSystem' "${CreatorIsNotSystem}" >> ${templogfilepath}
    
    echo  >> ${templogfilepath}
    printf "%-40s = %s\n" 'CSVADDEXPERRHANDLE' "${CSVADDEXPERRHANDLE}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVADDEXPERRHANDLE' "${CLIparm_CSVADDEXPERRHANDLE}" >> ${templogfilepath}
    
    # ADDED 2021-02-03 -
    echo >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_TypeOfExport' "${CLIparm_TypeOfExport}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'TypeOfExport' "${TypeOfExport}" >> ${templogfilepath}
    
    echo >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_format' "${CLIparm_format}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_formatall' "${CLIparm_formatall}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_formatcsv' "${CLIparm_formatcsv}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_formatjson' "${CLIparm_formatjson}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_detailslevel' "${CLIparm_detailslevel}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_detailslevelall' "${CLIparm_detailslevelall}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_detailslevelfull' "${CLIparm_detailslevelfull}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_detailslevelstandard' "${CLIparm_detailslevelstandard}" >> ${templogfilepath}
    
    echo >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_UseDevOpsResults' "${CLIparm_UseDevOpsResults}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_resultspath' "${CLIparm_resultspath}" >> ${templogfilepath}
    
    # ADDED 2021-01-16 -
    
    echo  >> ${templogfilepath}
    printf "%-40s = %s\n" 'CSVEXPORT05TAGS' "${CSVEXPORT05TAGS}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORT05TAGS' "${CLIparm_CSVEXPORT05TAGS}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CSVEXPORT10TAGS' "${CSVEXPORT10TAGS}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORT10TAGS' "${CLIparm_CSVEXPORT10TAGS}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CSVEXPORTNOTAGS' "${CSVEXPORTNOTAGS}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORTNOTAGS' "${CLIparm_CSVEXPORTNOTAGS}" >> ${templogfilepath}
    
    echo  >> ${templogfilepath}
    printf "%-40s = %s\n" 'KEEPCSVWIP' "${KEEPCSVWIP}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_KEEPCSVWIP' "${CLIparm_KEEPCSVWIP}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLEANUPCSVWIP' "${CLEANUPCSVWIP}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CLEANUPCSVWIP' "${CLIparm_CLEANUPCSVWIP}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'NODOMAINFOLDERS' "${NODOMAINFOLDERS}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NODOMAINFOLDERS' "${CLIparm_NODOMAINFOLDERS}" >> ${templogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORTDATADOMAIN' "${CLIparm_CSVEXPORTDATADOMAIN}" >> ${templogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORTDATACREATOR' "${CLIparm_CSVEXPORTDATACREATOR}" >> ${templogfilepath}
    
    if ${script_use_export} ; then
        printf "%-40s = %s\n" 'CLIparm_exportpath' "${CLIparm_exportpath}" >> ${templogfilepath}
    fi
    if ${script_use_import} ; then
        printf "%-40s = %s\n" 'CLIparm_importpath' "${CLIparm_importpath}" >> ${templogfilepath}
    fi
    if ${script_use_delete} ; then
        printf "%-40s = %s\n" 'CLIparm_deletepath' "${CLIparm_deletepath}" >> ${templogfilepath}
    fi
    if ${script_use_csvfile} ; then
        printf "%-40s = %s\n" 'CLIparm_csvpath' "${CLIparm_csvpath}" >> ${templogfilepath}
    fi
    
    echo >> ${templogfilepath}
    printf "%-40s = %s\n" 'remains' "${REMAINS}" >> ${templogfilepath}
    
#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-06
# MODIFIED 2021-02-03 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#
    # Improved local CLI parameter dump handler
    
    if ${localCLIparms}; then
        dumpcliparmparselocalresults ${REMAINS}
    fi
    
#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-03
# MODIFIED 2021-02-03 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#
    
    HandleShowTempLogFile
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-03


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


# MODIFIED 2021-02-03 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Show help information

doshowhelp () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    #
    # MODIFIED 2021-02-06 -
    
    echo
    echo -n $0' [-?][-v]'
    echo -n '|[-r]|[[-u <admin_name>]|[-p <password>]]|[--api-key <api_key_value>]'
    echo -n '|[-P <web ssl port>]'
    echo -n '|[-m <server_IP>]'
    echo -n '|[-d <domain>]'
    echo -n '|[-s <session_file_filepath>]|[--session-timeout <session_time_out>]'
    
    echo -n '|[-l <log_path>]'
    echo -n '|[-o <output_path>]'
    
    echo -n '|[-t <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name">]'
    
    echo -n '|[-f <all|csv|json>]|[--details <all|full|standard>]'
    
    echo -n '|[--RESULTS]|[--RESULTSPATH <results_path>]'
    
    echo -n '|[--SO|--NSO]'
    echo -n '|[--NOSYS]'
    
    echo -n '|[--CSVERR']
    
    echo -n '|[--5-TAGS|--10-TAGS|--NO-TAGS]'
    
    echo -n '|[--CSVEXPORTDATADOMAIN|--CSVEXPORTDATACREATOR|--CSVALL]'
    
    echo -n '|[--CLEANUPCSVWIP]'
    echo -n '|[--NODOMAINFOLDERS]'
    
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
    
    echo -n '|[--NOHUP]'
    echo -n '|[--NOHUP-Script <NOHUP_SCRIPT_NAME>]'
    echo -n '|[--NOHUP-DTG <NOHUP_SCRIPT_DATE_TIME_GROUP>]'
    echo -n '|[--NOHUP-PATH <NOHUP_SCRIPT_EXECUTION_PATH>]'
    echo
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    #
    # MODIFIED 2021-02-06 -
    #
    echo
    echo ' Script Version:  '${ScriptVersion}'  Date:  '${ScriptDate}
    echo
    echo ' Standard Command Line Parameters: '
    echo
    echo '  Show Help                  -? | --help'
    echo '  Verbose mode               -v | --verbose'
    echo
    echo '  No waiting in verbose mode --NOWAIT'
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
    echo
    
    echo '  Set session file path      -s <session_file_filepath> |'
    echo '                             --session-file <session_file_filepath> |'
    echo '                             -s=<session_file_filepath> |'
    echo '                             --session-file=<session_file_filepath>'
    echo
    
    echo '  Set session timeout value  --session-timeout <session_time_out> |'
    echo '                             --session-timeout=<session_time_out>'
    echo
    echo '      Default = 600 seconds, allowed range of values 10 - 3600 seconds'
    echo
    
    echo '  Set log file path          -l <log_path> | --log-path <log_path> |'
    echo '                             -l=<log_path> | --log-path=<log_path>'
    echo '  Set output file path       -o <output_path> | --output <output_path> |'
    echo '                             -o=<output_path> | --output=<output_path>'
    echo
    
    echo '  session_file_filepath = fully qualified file path for session file'
    echo '  log_path = fully qualified folder path for log files'
    echo '  output_path = fully qualified folder path for output files'
    echo
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    echo ' Extended Command Line Parameters: '
    echo
    echo '  Type of Object Export     -t <export_type> |-t <export_type> |'
    echo '                            --type-of-export <export_type>|'
    echo '                            --type-of-export=<export_type>'
    echo
    echo '  Supported <export_type> values for export to CSV :'
    echo '    <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name">'
    echo '    "standard"           :  Standard Export of all supported object key values'
    echo '    "name-only"          :  Export of just the name key value for object'
    echo '    "name-and-uid"       :  Export of name and uid key value for object'
    echo '    "uid-only"           :  Export of just the uid key value of objects'
    echo '    "rename-to-new-name" :  Export of name key value for object rename'
    echo
    echo '    For an export for a delete operation via CSV, use "name-only"'
    echo
    
    echo '  Format for export          -f <all|csv|json> | --format <all|csv|json> |'
    echo '                             -f=<all|csv|json> | --format=<all|csv|json>'
    
    echo '  Details level for json     --details <all|full|standard> |'
    echo '                             --DETAILSLEVEL <all|full|standard> |'
    echo '                             --details=<all|full|standard> |'
    echo '                             --DETAILSLEVEL=<all|full|standard>  |'
    
    echo '  Use devops results path    --RESULTS | --DEVOPSRESULTS'
    echo '  Set results output path    --RESULTSPATH <results_path> |'
    echo '                             --RESULTSPATH=<results_path> |'
    echo '                             --DEVOPSRESULTSPATH <results_path> |'
    echo '                             --DEVOPSRESULTSPATH=<results_path> |'
    echo
    echo '  results_path = fully qualified folder path for devops results folder'
    echo
    
    echo '  Export System Objects      --SO | --system-objects  {default mode}'
    echo '  NO System Objects Export   --NSO | --no-system-objects'
    echo
    echo '  Ignore object where Creator is "System", active with --NSO'
    echo '                             --NOSYS | --CREATORISNOTSYSTEM'
    echo
    
    echo '  CSV export add err handler --CSVERR | --CSVADDEXPERRHANDLE'
    echo
    
    echo '  Export 5 Tags for object   --5-TAGS | --CSVEXPORT05TAGS'
    echo '  Export 10 Tags for object  --10-TAGS | --CSVEXPORT10TAGS'
    echo '  Export NO Tags for object  --NO-TAGS | --CSVEXPORTNOTAGS'
    echo
    
    echo '  Export Data Domain info    --CSVEXPORTDATADOMAIN  (*)'
    echo '  Export Data Creator info   --CSVEXPORTDATACREATOR  (*)'
    echo '  Export Data Domain and Data Creator info'
    echo '                             --CSVALL|--CSVEXPORTDATAALL  (*)'
    echo
    echo '  (*)  use of these will generate FOR_REFERENCE_ONLY CSV export !'
    echo
    
    echo '  Keep CSV WIP folders       --KEEPCSVWIP'
    echo '  Remove CSV WIP folders     --CLEANUPCSVWIP   !! Default Action'
    echo '  No domain name in folders  --NODOMAINFOLDERS'
    echo
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    if ${script_use_export} ; then
        echo '  Set export file path       -x <export_path> | --export-path <export_path> |'
        echo '                             -x=<export_path> | --export-path=<export_path>'
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
    
    echo '  Operating in nohup mode    --NOHUP'
    echo '  nohup script as called     --NOHUP-Script <NOHUP_SCRIPT_NAME> | --NOHUP-Script=<NOHUP_SCRIPT_NAME>'
    echo '  nohup date-time-group      --NOHUP-DTG <NOHUP_SCRIPT_DATE_TIME_GROUP> | --NOHUP-DTG=<NOHUP_SCRIPT_DATE_TIME_GROUP>'
    echo '  nohup execute path         --NOHUP-PATH <NOHUP_SCRIPT_EXECUTION_PATH> | --NOHUP-PATH=<NOHUP_SCRIPT_EXECUTION_PATH>'
    echo
    echo '  NOHUP_SCRIPT_EXECUTION_PATH = fully qualified folder path for where do_script_nohup was executed'
    echo
    
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
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
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
    echo ' ]# '${ScriptName}' --api-key "@#ohtobeanapikey%" --SO --format=all --details=full --CSVALL'
    echo
    echo ' Example of call from nohup initiator script, do_script_nohup from bash 4 Check Point scripts'
    echo
    echo ' ]# '${ScriptName}' --api-key "@#ohtobeanapikey%" --SO --format=all --details=full --NOHUP --NOHUP-DTG 2027-11-11-2323CST --NOHUP-PATH "/var/log/__customer/scripts"'
    
    #                  1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #        01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    if ${script_use_export} ; then
        echo
        echo ' Example: Export:'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export"'
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --type-of-export "names-only" -x "/var/tmp/script_dump/export4delete"'
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --5-TAGS --CSVADDEXPERRHANDL --CLEANUPCSVWIP'
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --10-TAGS --CSVADDEXPERRHANDL'
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --CREATORISNOTSYSTEM --10-TAGS --CSVADDEXPERRHANDL'
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --10-TAGS --CSVERR --CSVALL'
    fi
    
    if ${script_use_import} ; then
        echo
        echo ' Example: Import | Set Update | Rename To New Name:'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -i "/var/tmp/import"'
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS -i "/var/tmp/import"'
    fi
    
    if ${script_use_delete} ; then
        echo
        echo ' Example: Delete:'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export" -k "/var/tmp/delete"'
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS -x "/var/tmp/script_dump/export4delete" -k "/var/tmp/delete"'
    fi
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    return 1
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-03


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


# MODIFIED 2021-02-03 - 
#

ProcessCommandLineParametersAndSetValues () {
    
    # MODIFIED 2021-02-06 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
                -u | --user )
                    CLIparm_user="$2"
                    shift
                    ;;
                -p | --password )
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
                -P | --port )
                    CLIparm_websslport="$2"
                    shift
                    ;;
                -m | --management )
                    CLIparm_mgmt="$2"
                    shift
                    ;;
                -d | --domain )
                    CLIparm_domain="$2"
                    CLIparm_domain=${CLIparm_domain//\"}
                    shift
                    ;;
                -s | --session-file )
                    CLIparm_sessionidfile="$2"
                    shift
                    ;;
                --session-timeout )
                    CLIparm_sessiontimeout=$2
                    CLIparm_sessiontimeout=${CLIparm_sessiontimeout//\"}
                    #shift
                    ;;
                -l | --log-path )
                    CLIparm_logpath="$2"
                    shift
                    ;;
                -o | --output )
                    CLIparm_outputpath="$2"
                    shift
                    ;;
                --NOHUP )
                    CLIparm_NOHUP=true
                    ;;
                # Handle --flag=value opts like this
                # and --flag value opts like this
                --NOHUP-Script=* )
                    CLIparm_NOHUPScriptName="${OPT#*=}"
                    #shift
                    ;;
                --NOHUP-Script )
                    CLIparm_NOHUPScriptName="$2"
                    shift
                    ;;
                --NOHUP-DTG=* )
                    CLIparm_NOHUPDTG="${OPT#*=}"
                    #shift
                    ;;
                --NOHUP-DTG )
                    CLIparm_NOHUPDTG="$2"
                    shift
                    ;;
                --NOHUP-PATH=* )
                    CLIparm_NOHUPPATH="${OPT#*=}"
                    #shift
                    ;;
                --NOHUP-PATH )
                    CLIparm_NOHUPPATH="$2"
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
                    CLIparm_CreatorIsNotSystem=true
                    ;;
                --NOSYS | --CREATORISNOTSYSTEM )
                    CLIparm_CreatorIsNotSystem=true
                    ;;
                --CSVERR | --CSVADDEXPERRHANDLE )
                    CLIparm_CSVADDEXPERRHANDLE=true
                    ;;
                # ADDED 2020-09-30 -
                --CSVEXPORTDATADOMAIN )
                    CLIparm_CSVEXPORTDATADOMAIN=true
                    ;;
                --CSVEXPORTDATACREATOR )
                    CLIparm_CSVEXPORTDATACREATOR=true
                    ;;
                --CSVALL | --CSVEXPORTDATAALL )
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
                --KEEPCSVWIP )
                    CLIparm_KEEPCSVWIP=true
                    CLIparm_CLEANUPCSVWIP=
                    ;;
                --CLEANUPCSVWIP )
                    CLIparm_CLEANUPCSVWIP=true
                    CLIparm_KEEPCSVWIP=
                    ;;
                --NODOMAINFOLDERS )
                    CLIparm_NODOMAINFOLDERS=true
                    ;;
                # Handle --flag=value opts like this
                # and --flag value opts like this
                -t=* | --type-of-export=* )
                    CLIparm_TypeOfExport="${OPT#*=}"
                    #shift
                    ;;
                -t | --type-of-export )
                    CLIparm_TypeOfExport="$2"
                    shift
                    ;;
                -f=* | --format=* )
                    CLIparm_format="${OPT#*=}"
                    #shift
                    ;;
                -f | --format )
                    CLIparm_format="$2"
                    shift
                    ;;
                --details=* | --DETAILSLEVEL=* )
                    CLIparm_detailslevel="${OPT#*=}"
                    #shift
                    ;;
                --details | --DETAILSLEVEL )
                    CLIparm_detailslevel="$2"
                    shift
                    ;;
                --RESULTSPATH=* | --DEVOPSRESULTSPATH=* )
                    CLIparm_resultspath="${OPT#*=}"
                    #shift
                    ;;
                --RESULTSPATH* | --DEVOPSRESULTSPATH )
                    CLIparm_resultspath="$2"
                    shift
                    ;;
                -x=* | --export-path=* )
                    CLIparm_exportpath="${OPT#*=}"
                    #shift
                    ;;
                -x | --export-path )
                    CLIparm_exportpath="$2"
                    shift
                    ;;
                -i=* | --import-path=* )
                    CLIparm_importpath="${OPT#*=}"
                    #shift
                    ;;
                -i | --import-path )
                    CLIparm_importpath="$2"
                    shift
                    ;;
                -k=* | --delete-path=* )
                    CLIparm_deletepath="${OPT#*=}"
                    #shift
                    ;;
                -k | --delete-path )
                    CLIparm_deletepath="$2"
                    shift
                    ;;
                -c=* | --csv=* )
                    CLIparm_csvpath="${OPT#*=}"
                    #shift
                    ;;
                -c | --csv )
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
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-06
    # MODIFIED 2021-02-06 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    export SHOWHELP=${SHOWHELP}
    
    export NOWAIT=${NOWAIT}
    export CLIparm_NOWAIT=${CLIparm_NOWAIT}
    
    export CLIparm_rootuser=${CLIparm_rootuser}
    export CLIparm_user=${CLIparm_user}
    export CLIparm_password=${CLIparm_password}
    
    # ADDED 2020-08-19 -
    export CLIparm_api_key=${CLIparm_api_key}
    export CLIparm_use_api_key=${CLIparm_use_api_key}
    
    export CLIparm_websslport=${CLIparm_websslport}
    export CLIparm_mgmt=${CLIparm_mgmt}
    export CLIparm_domain=${CLIparm_domain}
    
    export CLIparm_sessionidfile=${CLIparm_sessionidfile}
    export CLIparm_sessiontimeout=${CLIparm_sessiontimeout}
    
    export CLIparm_logpath=${CLIparm_logpath}
    export CLIparm_outputpath=${CLIparm_outputpath}
    
    # ADDED 2021-02-06 - MODIFIED 2021-02-13 - 
    export CLIparm_NOHUP=${CLIparm_NOHUP}
    export CLIparm_NOHUPScriptName=${CLIparm_NOHUPScriptName}
    export CLIparm_NOHUPDTG=${CLIparm_NOHUPDTG}
    export CLIparm_NOHUPPATH=${CLIparm_NOHUPPATH}
    
    # MODIFIED 2021-02-04 -
    export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
    #export TypeOfExport=${CLIparm_TypeOfExport}
    #export ExportTypeIsStandard=true
    
    case "${CLIparm_TypeOfExport}" in
        # a "Standard" export operation
        'standard' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=true
            ;;
        # a "name-only" export operation
        'name-only' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            ;;
        # a "name-and-uid" export operation
        'name-and-uid' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            ;;
        # a "uid-only" export operation
        'uid-only' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            ;;
        # a "rename-to-new-nam" export operation
        'rename-to-new-name' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            ;;
        # Anything unknown is handled as "standard"
        * )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=true
            # Wait what?  Not an expected format
            echo 'INVALID EXPORT-TYPE PROVIDED IN CLI PARAMETERS!  EXPORT-TYPE = '${CLIparm_TypeOfExport} | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            SHOWHELP=true
            ;;
    esac
    
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
    
    export CLIparm_NoSystemObjects=${CLIparm_NoSystemObjects}
    # ADDED 2021-02-03 -
    export CLIparm_CreatorIsNotSystem=${CLIparm_CreatorIsNotSystem}
    export CreatorIsNotSystem=${CLIparm_CreatorIsNotSystem}
    
    # ADDED 2018-05-03-2 -
    export CLIparm_CSVADDEXPERRHANDLE=${CLIparm_CSVADDEXPERRHANDLE}
    export CSVADDEXPERRHANDLE=${CLIparm_CSVADDEXPERRHANDLE}
    
    # ADDED 2021-01-16 -
    export CLIparm_CSVEXPORT05TAGS=${CLIparm_CSVEXPORT05TAGS}
    export CLIparm_CSVEXPORT10TAGS=${CLIparm_CSVEXPORT10TAGS}
    export CLIparm_CSVEXPORTNOTAGS=${CLIparm_CSVEXPORTNOTAGS}
    export CSVEXPORT05TAGS=${CLIparm_CSVEXPORT05TAGS}
    export CSVEXPORT10TAGS=${CLIparm_CSVEXPORT10TAGS}
    export CSVEXPORTNOTAGS=${CLIparm_CSVEXPORTNOTAGS}
    
    # ADDED 2018-05-03-2 -
    export CLIparm_CSVEXPORTDATADOMAIN=${CLIparm_CSVEXPORTDATADOMAIN}
    export CLIparm_CSVEXPORTDATACREATOR=${CLIparm_CSVEXPORTDATADOMAIN}
    
    # ADDED 2018-05-03-2 -
    export CLIparm_KEEPCSVWIP=${CLIparm_KEEPCSVWIP}
    export CLIparm_CLEANUPCSVWIP=${CLIparm_CLEANUPCSVWIP}
    
    if [ x"${CLIparm_KEEPCSVWIP}" == x"" ] ; then
        # CLIparm_KEEPCSVWIP was unset so check what we configured for CLEANUPCSVWIP
        if ${CLIparm_CLEANUPCSVWIP} ; then
            # CLIparm_CLEANUPCSVWIP mode set ON
            export KEEPCSVWIP=false
            export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
            export CLEANUPCSVWIP=true
            export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
        else
            # CLIparm_CLEANUPCSVWIP mode set OFF
            export KEEPCSVWIP=true
            export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
            export CLEANUPCSVWIP=false
            export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
        fi
    elif [ x"${CLIparm_CLEANUPCSVWIP}" == x"" ] ; then
        # CLEANUPCSVWIP was unset true, so override everything
        if ${CLIparm_KEEPCSVWIP} ; then
            # CLIparm_KEEPCSVWIP mode set ON
            export KEEPCSVWIP=true
            export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
            export CLEANUPCSVWIP=false
            export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
        else
            # CLIparm_KEEPCSVWIP mode set OFF
            export KEEPCSVWIP=false
            export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
            export CLEANUPCSVWIP=true
            export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
        fi
    else
        # Check if KEEPCSVWIP was set to determine override
        if ${CLIparm_KEEPCSVWIP} ; then
            # CLIparm_KEEPCSVWIP mode set ON
            export KEEPCSVWIP=true
            export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
            export CLEANUPCSVWIP=false
            export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
        else
            # CLIparm_KEEPCSVWIP mode set OFF
            export KEEPCSVWIP=false
            export CLIparm_KEEPCSVWIP=${KEEPCSVWIP}
            export CLEANUPCSVWIP=true
            export CLIparm_CLEANUPCSVWIP=${CLEANUPCSVWIP}
        fi
    fi
    
    export CLIparm_NODOMAINFOLDERS=${CLIparm_NODOMAINFOLDERS}
    
    export CLIparm_exportpath=${CLIparm_exportpath}
    export CLIparm_importpath=${CLIparm_importpath}
    export CLIparm_deletepath=${CLIparm_deletepath}
    
    export CLIparm_csvpath=${CLIparm_csvpath}
    export REMAINS=${REMAINS}
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-06
    
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
# START:  Main operations
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Start executing Main operations
# -------------------------------------------------------------------------------------------------

#
# shell meat
#


# meat START

echo Do something...
echo

#export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}
#export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
#
#export MgmtCLI_Show_OpParms='details-level "'${APICLIdetaillvl}'" '${MgmtCLI_Base_OpParms}
#
#if [ $(expr ${CurrentAPIVersion} '>=' 1.1 ) ] ; then
#    export MgmtCLI_Add_OpParms="set-if-exists true ${MgmtCLI_IgnoreErr_OpParms} ${MgmtCLI_Base_OpParms}"
#else
#    export MgmtCLI_Add_OpParms="${MgmtCLI_IgnoreErr_OpParms} ${MgmtCLI_Base_OpParms}"
#fi
#
#export MgmtCLI_Set_OpParms="${MgmtCLI_IgnoreErr_OpParms} ${MgmtCLI_Base_OpParms}"
#
#export MgmtCLI_Delete_OpParms='details-level "'${APICLIdetaillvl}'" '${MgmtCLI_IgnoreErr_OpParms}' '${MgmtCLI_Base_OpParms}
#
#mgmt_cli delete ${APICLIobjecttype} --batch ${APICLIDeleteCSVfile} $MgmtCLI_Delete_OpParms > ${OutputPath}
#mgmt_cli show ${APICLIobjecttype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
#mgmt_cli add ${APICLIobjecttype} --batch ${APICLIImportCSVfile} $MgmtCLI_Add_OpParms > ${OutputPath}
#mgmt_cli set ${APICLIobjecttype} --batch ${APICLIImportCSVfile} ignore-warnings true ignore-errors true --ignore-errors true -f json -s ${APICLIsessionfile} > ${OutputPath}


#
# Examples
#
#mgmt_cli show hosts details-level standard -f json -s ${APICLIsessionfile} > dump/${DATE}/hosts_dump_standard_$DATE.txt
#mgmt_cli show hosts details-level full -f json -s ${APICLIsessionfile} > dump/${DATE}/hosts_dump_full_$DATE.txt
#mgmt_cli add host --batch "${APICLICSVImportpathbase}" ignore-warnings true ignore-errors true details-level full --ignore-errors true -f json -s ${APICLIsessionfile} > dump/${DATE}/hosts_dump_full_$DATE.txt
#mgmt_cli set network --batch "${APICLICSVImportpathbase}" ignore-warnings true ignore-errors true details-level full --ignore-errors true -f json -s ${APICLIsessionfile} > dump/${DATE}/hosts_dump_full_$DATE.txt
#

# meat END


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


