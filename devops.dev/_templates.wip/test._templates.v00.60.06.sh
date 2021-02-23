#!/bin/bash
#
# SCRIPT Base Template testing script for automated execution of standard tests
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
ScriptRevision=010
ScriptDate=2021-02-22
TemplateVersion=00.60.06
APISubscriptsLevel=006
APISubscriptsVersion=00.60.06
APISubscriptsRevision=010

#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=test._templates.v${ScriptVersion}
export APIScriptFileNameRoot=test._templates
export APIScriptShortName=test._templates
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="Base Template testing script for automated execution of standard tests"

# =================================================================================================
# =================================================================================================
# START script
# =================================================================================================
# =================================================================================================

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

# Wait time in seconds
export WAITTIME=15


# =================================================================================================
# END:  Setup Root Parameters
# =================================================================================================
# -------------------------------------------------------------------------------------------------

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START Configure Testing root parameters
# -------------------------------------------------------------------------------------------------

export Testinglogfileroot=.
export Testinglogfilefolder=dump/testing/${DATE}
export Testinglogfilename=Testing_log_${ScriptName}.`date +%Y%m%d-%H%M%S%Z`.log

# -------------------------------------------------------------------------------------------------
# Root script declarations
# -------------------------------------------------------------------------------------------------

export Script2TestPath=.

# Removing dependency on clish to avoid collissions when database is locked
#
#export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
#
export pythonpath=${MDS_FWDIR}/Python/bin/
export get_api_local_port=`${pythonpath}/python ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
export api_local_port=${get_api_local_port//\"/}
export currentapisslport=${api_local_port}

export TestSSLport=${currentapisslport}

# 2018-05-04 - script type - script testing 

export script_test_template="true"
export script_test_export_import="false"

export script_test_common="true"


# -------------------------------------------------------------------------------------------------
# END Configure Testing root parameters
# -------------------------------------------------------------------------------------------------
# =================================================================================================

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START common procedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SetupTestingLogFile - Setup log file for testing operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTestingLogFile () {
    #
    # SetupTestingLogFile - Setup log file for testing operation
    #
    
    export Testinglogfilebase=${Testinglogfileroot}/${Testinglogfilefolder}
    export Testinglogfile=${Testinglogfilebase}/${Testinglogfilename}
    
    if [ ! -r ${Testinglogfilebase} ] ; then
        mkdir -p -v ${Testinglogfilebase}
    fi
    
    touch ${Testinglogfile}
    
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${Testinglogfile}
    echo | tee -a -i ${Testinglogfile}
    echo 'Script:  '${ScriptName}'  Script Version: '${APIScriptVersion} | tee -a -i ${Testinglogfile}
    echo | tee -a -i ${Testinglogfile}
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# FinishUpTesting - handle testing finish up operations and close out log file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinishUpTesting () {
    #
    # handle testing finish up operations and close out log file
    #
    
    echo 'Testing Operations Completed' | tee -a -i ${Testinglogfile}
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo | tee -a -i ${Testinglogfile}
        #echo "Files in >${Testinglogfileroot}<" | tee -a -i ${Testinglogfile}
        #ls -alh ${Testinglogfileroot} | tee -a -i ${Testinglogfile}
        #echo | tee -a -i ${Testinglogfile}
        
        echo "Files in >${Testinglogfilebase}<" | tee -a -i ${Testinglogfile}
        ls -alhR ${Testinglogfilebase} | tee -a -i ${Testinglogfile}
        echo | tee -a -i ${Testinglogfile}
    fi
    
    echo | tee -a -i ${Testinglogfile}
    echo "Testing Results in directory ${Testinglogfilebase}" | tee -a -i ${Testinglogfile}
    echo "Log output in file ${Testinglogfile}" | tee -a -i ${Testinglogfile}
    echo | tee -a -i ${Testinglogfile}
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${Testinglogfile}
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


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
# DetermineGaiaVersionAndInstallType - Determine the version of Gaia and installation type
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

DetermineGaiaVersionAndInstallType () {
    #
    # DetermineGaiaVersionAndInstallType - Determine the version of Gaia and installation type
    #
    
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
        echo | tee -a -i ${Testinglogfile}
        echo ' Gaia version and installation type handler script file missing' | tee -a -i ${Testinglogfile}
        echo '  File not found : '${gaia_version_handler} | tee -a -i ${Testinglogfile}
        echo | tee -a -i ${Testinglogfile}
        echo 'Other parameter elements : ' | tee -a -i ${Testinglogfile}
        echo '  Configured Root path    : '${configured_handler_root} | tee -a -i ${Testinglogfile}
        echo '  Actual Script Root path : '${actual_handler_root} | tee -a -i ${Testinglogfile}
        echo '  Root of folder path : '${gaia_version_handler_root} | tee -a -i ${Testinglogfile}
        echo '  Folder in Root path : '${gaia_version_handler_folder} | tee -a -i ${Testinglogfile}
        echo '  Folder Root path    : '${gaia_version_handler_path} | tee -a -i ${Testinglogfile}
        echo '  Script Filename     : '${gaia_version_handler_file} | tee -a -i ${Testinglogfile}
        echo | tee -a -i ${Testinglogfile}
        echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${Testinglogfile}
        echo | tee -a -i ${Testinglogfile}
        echo "Log output in file ${Testinglogfile}" | tee -a -i ${Testinglogfile}
        echo | tee -a -i ${Testinglogfile}
    
        exit 251
    fi
    
    #
    # \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-09-21
    
    GetGaiaVersionAndInstallationType "$@"
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# END common procedures
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START testing procedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ResetExternalParameters - Reset Externally controllable parameters
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ResetExternalParameters () {
    #
    # Reset Externally controllable parameters
    #
    
    export APISCRIPTVERBOSE=
    export NOWAIT=
    export CLEANUPCSVWIP=
    export NODOMAINFOLDERS=
    export CSVADDEXPERRHANDLE=
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# HandleScriptTesting_CLIParms - repeated proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-03-2 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#


#
# Standard R8X API Scripts Command Line Parameters
#
# -? | --help
# -v | --verbose
# -P <web-ssl-port> | --port <web-ssl-port> | -P=<web-ssl-port> | --port=<web-ssl-port>
# -r | --root
# -u <admin_name> | --user <admin_name> | -u=<admin_name> | --user=<admin_name>
# -p <password> | --password <password> | -p=<password> | --password=<password>
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# -l <log_path> | --log-path <log_path> | -l=<log_path> | --log-path=<log_path>'
#
# -o <output_path> | --output <output_path> | -o=<output_path> | --output=<output_path> 
#
# -x <export_path> | --export-path <export_path> | -x=<export_path> | --export-path=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path>'
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path>'
#
# -c <csv_path> | --csv <csv_path> | -c=<csv_path> | --csv=<csv_path>'
#
# --NOWAIT
#
# --NSO | --no-system-objects
# --SO | --system-objects
#
# --CSVERR | --CSVADDEXPERRHANDLE
#
# --KEEPCSVWIP | --CLEANUPCSVWIP
# --NODOMAINFOLDERS
#

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleScriptTesting_CLIParms () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    
    ResetExternalParameters
    
    . $Script2TestFilepath -?
    . $Script2TestFilepath --help
    
    
    if [ ${Check4MDS} -eq 1 ] ; then
        # MDM Tests
        echo 'Multi-Domain Management stuff...' | tee -a -i ${Testinglogfile}
    
    elif [ ${Check4SMS} -eq 1 ] || [ $Check4EPM -eq 1 ] ; then
        # Just SMS Tests
        echo 'Security Management Server stuff...' | tee -a -i ${Testinglogfile}
        if [ $Check4EPM -eq 1 ] ; then
            # EPM (not just SMS) Tests
            echo 'Endpoint Security Management Server stuff...' | tee -a -i ${Testinglogfile}
        fi
        
        . $Script2TestFilepath --port ${TestSSLport} -r
        . $Script2TestFilepath --port ${TestSSLport} -v -r
        . $Script2TestFilepath --port ${TestSSLport} --verbose -r
        . $Script2TestFilepath --port ${TestSSLport} -v -u _apiadmin
        . $Script2TestFilepath --port ${TestSSLport} -v -u _apiadmin -p Cpwins1!
        
        ResetExternalParameters
        
        . $Script2TestFilepath --port ${TestSSLport} -v --NOWAIT -r
        . $Script2TestFilepath --port ${TestSSLport} -v --NOWAIT -u _apiadmin
        . $Script2TestFilepath --port ${TestSSLport} -v --NOWAIT -u _apiadmin -p Cpwins1!
        
        if [ x"$script_test_template" = x"true" ] ; then
            # testing templates, so work the full set of parameters
            
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -r --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -r --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE --SO
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -r --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE --NSO
            
            ResetExternalParameters
            
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -r -l ${Testinglogfilebase} -o ${Testinglogfilebase}/output -x ${Testinglogfilebase}/export -i /var/tmp/import.csv -k /var/tmp/delete.csv
            
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -r -l ${Testinglogfilebase} -c ${Testinglogfilebase}/example_csv.csv
            
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -u _apiadmin -p Cpwins1! --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -u _apiadmin -p Cpwins1! --CLEANUPCSVWIP --NODOMAINFOLDERS --CSVADDEXPERRHANDLE --SO
            
        fi
        
    elif [ ${Check4GW} -eq 1 ] ; then
        # GW Tests - when that has an API
        echo 'Gateway stuff...' | tee -a -i ${Testinglogfile}
        
    else
        # and what is this????
        echo 'and what is this????' | tee -a -i ${Testinglogfile}
        
    fi
    
    if [ ${Check4MDS} -eq 1 ] ; then
        # More MDM Tests
        echo 'More Multi-Domain Management stuff...' | tee -a -i ${Testinglogfile}
        
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "System Data" -r
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "System Data" -u _apiadmin
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "System Data" -u _apiadmin -p Cpwins1!
        
        # This is a forced failure test
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "GLOBAL" -r
        
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "Global" -r
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "Global" -u _apiadmin
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "Global" -u _apiadmin -p Cpwins1!
        
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "EXAMPLE-DEMO" -r
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "EXAMPLE-DEMO" -u _apiadmin
        . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "EXAMPLE-DEMO" -u _apiadmin -p Cpwins1!
        
        if [ x"$script_test_template" = x"true" ] ; then
            # testing templates, so work the full set of parameters
            
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "Global" -r -l ${Testinglogfilebase} -o ${Testinglogfilebase}/output -x ${Testinglogfilebase}/export -i /var/tmp/import.csv -k /var/tmp/delete.csv
            . $Script2TestFilepath -v --port ${TestSSLport} --NOWAIT -d "System Data" -r -l ${Testinglogfilebase} -o ${Testinglogfilebase}/output -x ${Testinglogfilebase}/export -i /var/tmp/import.csv -k /var/tmp/delete.csv
            
        fi
        
    fi
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END testing procedures
# -------------------------------------------------------------------------------------------------
# =================================================================================================

SetupTestingLogFile

echo | tee -a -i ${Testinglogfile}
echo 'Script:  '${ScriptName}'  Script Version: '${APIScriptVersion} | tee -a -i ${Testinglogfile}


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START testing
# -------------------------------------------------------------------------------------------------

DetermineGaiaVersionAndInstallType "$@"

export TestSSLport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
echo 'Current Gaia web ssl-port : '${TestSSLport} | tee -a -i ${Testinglogfile}


export Script2TestName=api_mgmt_cli_shell_template_with_cmd_line_parameters.template.v${ScriptVersion}.sh

export Script2TestFilepath=${Script2TestPath}/${Script2TestName}

HandleScriptTesting_CLIParms "$@"


export Script2TestName=api_mgmt_cli_shell_template_with_cmd_line_parameters_script.template.v${ScriptVersion}.sh

export Script2TestFilepath=${Script2TestPath}/${Script2TestName}

HandleScriptTesting_CLIParms "$@"

# -------------------------------------------------------------------------------------------------
# END testing
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# =================================================================================================
# END script
# =================================================================================================
# =================================================================================================

FinishUpTesting "$@"

# =================================================================================================
# =================================================================================================
# =================================================================================================
# =================================================================================================

