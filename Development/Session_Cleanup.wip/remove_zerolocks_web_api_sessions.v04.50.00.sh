#!/bin/bash
#
# SCRIPT Base Template for API CLI Operations with command line parameters script utilization
#
# (C) 2016-2020 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
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
ScriptVersion=04.50.00
ScriptRevision=055
ScriptDate=2020-09-10
TemplateVersion=00.50.00
CommonScriptsVersion=00.50.00
CommonScriptsRevision=006


#

export APIScriptVersion=v${ScriptVersion//./x}
export APIScriptTemplateVersion=v${TemplateVersion//./x}
export APIExpectedCommonScriptsVersion=v${CommonScriptsVersion//./x}
ScriptName=remove_zerolocks_web_api_sessions.v$ScriptVersion

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

export APICLIlogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_'$DATEDTGS.log

# Configure basic information for formation of file path for command line parameter handler script
#
# cli_api_cmdlineparm_handler_root - root path to command line parameter handler script. Period (".") indicates root of script source folder
# cli_api_cmdlineparm_handler_folder - folder for under root path to command line parameter handler script
# cli_api_cmdlineparm_handler_file - filename, without path, for command line parameter handler script
#
export cli_api_cmdlineparm_handler_root=.
export cli_api_cmdlineparm_handler_folder=common
export cli_api_cmdlineparm_handler_file=cmd_line_parameters_handler.action.common.$CommonScriptsRevision.v$CommonScriptsVersion.sh

# ADDED 2018-09-21 -
# Configure basic information for formation of file path for gaia version handler script
#
# cli_api_cmdlineparm_handler_root - root path to gaia version handler script. Period (".") indicates root of script source folder
# cli_api_cmdlineparm_handler_folder - folder for under root path to gaia version handler script
# cli_api_cmdlineparm_handler_file - filename, without path, for gaia version handler script
#
export gaia_version_handler_root=.
export gaia_version_handler_folder=common
export gaia_version_handler_file=identify_gaia_and_installation.action.common.$CommonScriptsRevision.v$CommonScriptsVersion.sh


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
#export OutputSubfolderScriptName=false
#export OutputSubfolderScriptShortName=false

export notthispath=/home/
export startpathroot=.

export localdotpath=`echo $PWD`
export currentlocalpath=$localdotpath
export workingpath=$currentlocalpath

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export scriptspathroot=/var/log/__customer/upgrade_export/scripts

export rootscriptconfigfile=__root_script_config.sh


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


# 2018-11-20 - script type - Session Reporting and Clean-up

export script_use_publish="true"

export script_use_export="false"
export script_use_import="false"
export script_use_delete="false"
export script_use_csvfile="false"

export script_dump_csv="false"
export script_dump_json="false"
export script_dump_standard="false"
export script_dump_full="false"

export script_uses_wip="false"
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
#
# For common scripts minimum API version at 1.0 should suffice, otherwise get explicit
#
export MinAPIVersionRequired=1.0

# If the API version needs to be enforced in commands set this to true
# NOTE not currently used!
#
export ForceAPIVersionToMinimum=false

# Wait time in seconds
export WAITTIME=15


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Setup Root Parameters
# =================================================================================================
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------

echo | tee -a -i $APICLIlogfilepath
echo $0 | tee -a -i $APICLIlogfilepath
echo 'Script:  '$ScriptName'  Script Version: '$ScriptVersion'  Revision: '$ScriptRevision | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Start of procedures block
# -------------------------------------------------------------------------------------------------

export APICLItemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log

# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #

    export APICLItemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log

    rm $APICLItemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath

    touch $APICLItemplogfilepath

    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleShowTempLogFile () {
    #
    # HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
    #

    if [ "$APISCRIPTVERBOSE" = "true" ] ; then
        # verbose mode so show the logged results and copy to normal log file
        cat $APICLItemplogfilepath | tee -a -i $APICLIlogfilepath
    else
        # NOT verbose mode so push logged results to normal log file
        cat $APICLItemplogfilepath >> $APICLIlogfilepath
    fi
    
    rm $APICLItemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ForceShowTempLogFile () {
    #
    # ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
    #

    cat $APICLItemplogfilepath | tee -a -i $APICLIlogfilepath
    
    rm $APICLItemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath

    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckStatusOfAPI - repeated proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# repeated procedure description
#

CheckStatusOfAPI () {
    #
    
    # -------------------------------------------------------------------------------------------------
    # Check that the API is actually running and up so we don't run into wierd problems
    # -------------------------------------------------------------------------------------------------
    
    echo | tee -a -i $APICLIlogfilepath
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
    echo 'Check API Operational Status before starting' | tee -a -i $APICLIlogfilepath
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    export tempapichecklog=/var/log/tmp/apistatuscheck.$DATEDTGS.log
    
    export pythonpath=$MDS_FWDIR/Python/bin/
    export get_api_local_port=`$pythonpath/python $MDS_FWDIR/scripts/api_get_port.py -f json | $JQ '. | .external_port'`
    export api_local_port=${get_api_local_port//\"/}
    export currentapisslport=$api_local_port
    
    echo 'First make sure we do not have any issues:' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    mgmt_cli -r true show version --port $currentapisslport >> $tempapichecklog
    errorresult=$?
    
    echo | tee -a -i $APICLIlogfilepath
    
    # Now dump the output from the temporary log file to the working log file, so we don't loose the results of the check, we can tee this to share
    cat $tempapichecklog | tee -a -i $APICLIlogfilepath
    
    echo | tee -a -i $APICLIlogfilepath
    
    if [ $errorresult -ne 0 ] ; then
        #api operation NOT OK, so anything that is not a 0 result is a fail!
        echo "API is not operating as expected so API calls will probably fail!" | tee -a -i $APICLIlogfilepath
        echo 'Still executing api status for additional details' | tee -a -i $APICLIlogfilepath
    else
        #api operations status OK
        echo "API is operating as expected so api status should work as expected!" | tee -a -i $APICLIlogfilepath
    fi
    
    # Remove the previous temporary log file, so we start clean for api status
    rm -fv $tempapichecklog >> $APICLIlogfilepath
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Next check api status:' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    # Execute the API check with api status to a temporary log file, since tee throws off the results of error checking
    api status >> $tempapichecklog
    errorresult=$?
    
    # Now dump the output from the temporary log file to the working log file, so we don't loose the results of the check, we can tee this to share
    cat $tempapichecklog | tee -a -i $APICLIlogfilepath
    
    # clean-up the temporary log file
    rm $tempapichecklog >> $APICLIlogfilepath
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'API status check result ( 0 = OK ) : '$errorresult | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    if [ $errorresult -ne 0 ] ; then
        #api operations status NOT OK, so anything that is not a 0 result is a fail!
        echo "API is not operating as expected so API calls will probably fail!" | tee -a -i $APICLIlogfilepath
        echo 'Critical Error '$errorresult'- Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return $errorresult
        #exit 1
        #Exit!
    else
        #api operations status OK
        echo "API is operating as expected so API calls should work!" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo "Current Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    return $errorresult
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#CheckStatusOfAPI
#errorresult=$?
#if [ $errorresult -ne 0 ] ; then
    #api operations status NOT OK, so anything that is not a 0 result is a fail!
    #Do something based on it not being ready or working!
    
    #exit 1
#else
    #api operations status OK
    #Do something based on it being ready and working!
    
#fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-02

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetScriptSourceFolder - Get the actual source folder for the running script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-11-20 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetScriptSourceFolder () {
    #
    # repeated procedure description
    #

    echo >> $APICLIlogfilepath

    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        TARGET="$(readlink "$SOURCE")"
        if [[ $TARGET == /* ]]; then
            echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'" >> $APICLIlogfilepath
            SOURCE="$TARGET"
        else
            DIR="$( dirname "$SOURCE" )"
            echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')" >> $APICLIlogfilepath
            SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        fi
    done

    echo "SOURCE is '$SOURCE'" >> $APICLIlogfilepath

    RDIR="$( dirname "$SOURCE" )"
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    if [ "$DIR" != "$RDIR" ]; then
        echo "DIR '$RDIR' resolves to '$DIR'" >> $APICLIlogfilepath
    fi
    echo "DIR is '$DIR'" >> $APICLIlogfilepath
    
    export ScriptSourceFolder=$DIR

    echo >> $APICLIlogfilepath
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-11-20


# -------------------------------------------------------------------------------------------------
# ConfigureJQLocation - Configure the value of JQ based on installation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-02-07 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# ConfigureJQLocation - Configure the value of JQ based on installation
#

# MODIFIED 2020-02-07 -
ConfigureJQLocation () {
    #
    # Configure JQ variable value for JSON parsing
    #
    # variable JQ points to where jq is installed
    #
    # Apparently MDM, MDS, and Domains don't agree on who sets CPDIR, so better to check!
    
    #export JQ=${CPDIR}/jq/jq
    
    
    # =============================================================================
    # JSON Query JQ and version specific JQ16 values
    # =============================================================================
    
    export JQNotFound=true
    export UseJSONJQ=false
    
    # JQ points to where the default jq is installed, probably version 1.4
    if [ -r ${CPDIR}/jq/jq ] ; then
        export JQ=${CPDIR}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    elif [ -r ${CPDIR_PATH}/jq/jq ] ; then
        export JQ=${CPDIR_PATH}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    elif [ -r ${MDS_CPDIR}/jq/jq ] ; then
        export JQ=${MDS_CPDIR}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    else
        export JQ=
        export JQNotFound=true
        export UseJSONJQ=false
    fi
    
    # JQ16 points to where jq 1.6 is installed, which is not generally part of Gaia, even R80.40EA (2020-01-20)
    export JQ16NotFound=true
    export UseJSONJQ16=false
    
    # As of template version v04.21.00 we also added jq version 1.6 to the mix and it lives in the customer path root /tools/JQ folder by default
    export JQ16PATH=$customerpathroot/_tools/JQ
    export JQ16FILE=jq-linux64
    export JQ16FQFN=$JQ16PATH$JQ16FILE
    
    if [ -r $JQ16FQFN ] ; then
        # OK we have the easy-button alternative
        export JQ16=$JQ16FQFN
        export JQ16NotFound=false
        export UseJSONJQ16=true
    elif [ -r "./_tools/JQ/$JQ16FILE" ] ; then
        # OK we have the local folder alternative
        export JQ16=./_tools/JQ/$JQ16FILE
        export JQ16NotFound=false
        export UseJSONJQ16=true
    elif [ -r "../_tools/JQ/$JQ16FILE" ] ; then
        # OK we have the parent folder alternative
        export JQ16=../_tools/JQ/$JQ16FILE
        export JQ16NotFound=false
        export UseJSONJQ16=true
    else
        # nope, not part of the package, so clear the values
        export JQ16=
        export JQ16NotFound=true
        export UseJSONJQ16=false
    fi
    
    if $JQNotFound ; then
        echo "Missing jq, not found in ${CPDIR}/jq/jq, ${CPDIR_PATH}/jq/jq, or ${MDS_CPDIR}/jq/jq" | tee -a -i $APICLIlogfilepath
        echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        exit 1
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-02-07

# -------------------------------------------------------------------------------------------------
# GaiaWebSSLPortCheck - Check local Gaia Web SSL Port configuration for local operations
# -------------------------------------------------------------------------------------------------


# MODIFIED 2019-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GaiaWebSSLPortCheck - Check local Gaia Web SSL Port configuration for local operations
#

GaiaWebSSLPortCheck () {

    # Removing dependency on clish to avoid collissions when database is locked
    #
    #export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
    #
    export pythonpath=$MDS_FWDIR/Python/bin/
    export get_api_local_port=`$pythonpath/python $MDS_FWDIR/scripts/api_get_port.py -f json | $JQ '. | .external_port'`
    export api_local_port=${get_api_local_port//\"/}
    export currentapisslport=$api_local_port
    
    if [ "$APISCRIPTVERBOSE" = "true" ] ; then
        echo 'Current Gaia web ssl-port : '$currentapisslport | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    else
        echo 'Current Gaia web ssl-port : '$currentapisslport >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-01-18


# -------------------------------------------------------------------------------------------------
# ScriptAPIVersionCheck - Check version of the script to ensure it is able to operate at minimum expected
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# ScriptAPIVersionCheck - Check version of the script to ensure it is able to operate at minimum 
# expected to correctly execute.
#

ScriptAPIVersionCheck () {

    SetupTempLogFile

    GetAPIVersion=$(mgmt_cli show api-versions -r true -f json --port $currentapisslport | $JQ '.["current-version"]' -r)
    export CheckAPIVersion=$GetAPIVersion

    if [ $CheckAPIVersion = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=$CheckAPIVersion
    fi
    
    echo 'API version = '$CurrentAPIVersion >> $APICLItemplogfilepath
    
    if [ $(expr $MinAPIVersionRequired '<=' $CurrentAPIVersion) ] ; then
        # API is sufficient version
        echo >> $APICLItemplogfilepath
    
        HandleShowTempLogFile
    
    else
        # API is not of a sufficient version to operate
        echo >> $APICLItemplogfilepath
        echo 'Current API Version ('$CurrentAPIVersion') does not meet minimum API version expected requirement ('$MinAPIVersionRequired')' >> $APICLItemplogfilepath
        echo >> $APICLItemplogfilepath
        echo '! termination execution !' >> $APICLItemplogfilepath
        echo >> $APICLItemplogfilepath
    
        ForceShowTempLogFile
    
        exit 250
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# CheckAPIScriptVerboseOutput - Check if verbose output is configured externally
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CheckAPIScriptVerboseOutput - Check if verbose output is configured externally via shell level 
# parameter setting, if it is, the check it for correct and valid values; otherwise, if set, then
# reset to false because wrong.
#

CheckAPIScriptVerboseOutput () {

    if [ -z $APISCRIPTVERBOSE ] ; then
        # Verbose mode not set from shell level
        echo "!! Verbose mode not set from shell level" >> $APICLIlogfilepath
        export APISCRIPTVERBOSE=false
        echo >> $APICLIlogfilepath
    elif [ x"`echo "$APISCRIPTVERBOSE" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
        # Verbose mode set OFF from shell level
        echo "!! Verbose mode set OFF from shell level" >> $APICLIlogfilepath
        export APISCRIPTVERBOSE=false
        echo >> $APICLIlogfilepath
    elif [ x"`echo "$APISCRIPTVERBOSE" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
        # Verbose mode set ON from shell level
        echo "!! Verbose mode set ON from shell level" >> $APICLIlogfilepath
        export APISCRIPTVERBOSE=true
        echo >> $APICLIlogfilepath
        echo 'Script :  '$0 >> $APICLIlogfilepath
        echo 'Verbose mode enabled' >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    elif [ "$APISCRIPTVERBOSE" = "true" ] ; then
        # Verbose mode set ON
        export APISCRIPTVERBOSE=true
        echo >> $APICLIlogfilepath
        echo 'Script :  '$0 >> $APICLIlogfilepath
        echo 'Verbose mode enabled' >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    elif [ "$APISCRIPTVERBOSE" = "true" ] ; then
        # Verbose mode set ON
        export APISCRIPTVERBOSE=true
        echo >> $APICLIlogfilepath
        echo 'Script :  '$0 >> $APICLIlogfilepath
        echo 'Verbose mode enabled' >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    elif [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode set ON
        export APISCRIPTVERBOSE=true
        echo >> $APICLIlogfilepath
        echo 'Script :  '$0 >> $APICLIlogfilepath
        echo 'Verbose mode enabled' >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    else
        # Verbose mode set to wrong value from shell level
        echo "!! Verbose mode set to wrong value from shell level >"$APISCRIPTVERBOSE"<" >> $APICLIlogfilepath
        echo "!! Settting Verbose mode OFF, pending command line parameter checking!" >> $APICLIlogfilepath
        export APISCRIPTVERBOSE=false
        echo >> $APICLIlogfilepath
    fi
    
    export APISCRIPTVERBOSECHECK=true

    echo >> $APICLIlogfilepath
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-09

# -------------------------------------------------------------------------------------------------
# End of procedures block
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# We need the Script's actual source folder to find subscripts
#
GetScriptSourceFolder


# We want to leave some externally set variables as they were
#
#export APISCRIPTVERBOSE=false

export APISCRIPTVERBOSECHECK=false

CheckAPIScriptVerboseOutput

# variable JQ points to where jq is installed
export JQ=${CPDIR_PATH}/jq/jq

ConfigureJQLocation

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-02


# -------------------------------------------------------------------------------------------------
# END Initial Script Setup
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Command Line Parameter Handling and Help
# =================================================================================================

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# --api-key "<api_key_value>" | --api-key="<api_key_value>" 
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# --session-timeout <session_time_out> 10-3600
# -l <log_path> | --log-path <log_path> | -l=<log_path> | --log-path=<log_path>'
#
# -o <output_path> | --output <output_path> | -o=<output_path> | --output=<output_path> 
#
# --NOWAIT
#
# -x <export_path> | --export <export_path> | -x=<export_path> | --export=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path>'
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path>'
#
# -c <csv_path> | --csv <csv_path> | -c=<csv_path> | --csv=<csv_path>'
#
# --NSO | --no-system-objects
# --SO | --system-objects
#
# --CLEANUPWIP
# --NODOMAINFOLDERS
# --CSVEXPORTADDIGNOREERR
#

export SHOWHELP=false
# MODIFIED 2018-09-21 -
#export CLIparm_websslport=443
export CLIparm_websslport=
export CLIparm_rootuser=false
export CLIparm_user=
export CLIparm_password=
export CLIparm_user=
export CLIparm_domain=
export CLIparm_sessionidfile=
export CLIparm_sessiontimeout=
export CLIparm_logpath=

export CLIparm_outputpath=

export CLIparm_NOWAIT=

export CLIparm_exportpath=
export CLIparm_importpath=
export CLIparm_deletepath=

export CLIparm_csvpath=

# MODIFIED 2018-06-24 -
#export CLIparm_NoSystemObjects=true
export CLIparm_NoSystemObjects=false

export CLIparm_CLEANUPWIP=
export CLIparm_NODOMAINFOLDERS=
export CLIparm_CSVEXPORTADDIGNOREERR=

# ADDED 2020-08-19 -
export CLIparm_api_key=
export CLIparm_use_api_key=false

# --NOWAIT
#
if [ -z "$NOWAIT" ]; then
    # NOWAIT mode not set from shell level
    export CLIparm_NOWAIT=false
elif [ x"`echo "$NOWAIT" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NOWAIT mode set OFF from shell level
    export CLIparm_NOWAIT=false
elif [ x"`echo "$NOWAIT" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NOWAIT mode set ON from shell level
    export CLIparm_NOWAIT=true
else
    # NOWAIT mode set to wrong value from shell level
    export CLIparm_NOWAIT=false
fi

# --CLEANUPWIP
#
if [ -z "$CLEANUPWIP" ]; then
    # CLEANUPWIP mode not set from shell level
    export CLIparm_CLEANUPWIP=false
elif [ x"`echo "$CLEANUPWIP" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CLEANUPWIP mode set OFF from shell level
    export CLIparm_CLEANUPWIP=false
elif [ x"`echo "$CLEANUPWIP" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CLEANUPWIP mode set ON from shell level
    export CLIparm_CLEANUPWIP=true
else
    # CLEANUPWIP mode set to wrong value from shell level
    export CLIparm_CLEANUPWIP=false
fi

# --NODOMAINFOLDERS
#
if [ -z "$NODOMAINFOLDERS" ]; then
    # NODOMAINFOLDERS mode not set from shell level
    export CLIparm_NODOMAINFOLDERS=false
elif [ x"`echo "$NODOMAINFOLDERS" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NODOMAINFOLDERS mode set OFF from shell level
    export CLIparm_NODOMAINFOLDERS=false
elif [ x"`echo "$NODOMAINFOLDERS" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NODOMAINFOLDERS mode set ON from shell level
    export CLIparm_NODOMAINFOLDERS=true
else
    # NODOMAINFOLDERS mode set to wrong value from shell level
    export CLIparm_NODOMAINFOLDERS=false
fi

# --CSVEXPORTADDIGNOREERR
#
if [ -z "$CSVEXPORTADDIGNOREERR" ]; then
    # CSVEXPORTADDIGNOREERR mode not set from shell level
    export CLIparm_CSVEXPORTADDIGNOREERR=false
elif [ x"`echo "$CSVEXPORTADDIGNOREERR" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CSVEXPORTADDIGNOREERR mode set OFF from shell level
    export CLIparm_CSVEXPORTADDIGNOREERR=false
elif [ x"`echo "$CSVEXPORTADDIGNOREERR" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CSVEXPORTADDIGNOREERR mode set ON from shell level
    export CLIparm_CSVEXPORTADDIGNOREERR=true
else
    # CLEANUPWIP mode set to wrong value from shell level
    export CLIparm_CSVEXPORTADDIGNOREERR=false
fi

export REMAINS=

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START:  Local Help display proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-09-21

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
    
    if [ "$APISCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $APICLIlogfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo "Calling external Command Line Paramenter Handling Script" | tee -a -i $APICLIlogfilepath
        echo " - External Script : "$cli_api_cmdlineparm_handler | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    else
        echo >> $APICLIlogfilepath
        echo '--------------------------------------------------------------------------' >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
        echo "Calling external Command Line Paramenter Handling Script" >> $APICLIlogfilepath
        echo " - External Script : "$cli_api_cmdlineparm_handler >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    fi
    
    
    . $cli_api_cmdlineparm_handler "$@"
    
    if [ "$APISCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $APICLIlogfilepath
        echo "Returned from external Command Line Paramenter Handling Script" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath

        if [ "$NOWAIT" != "true" ] ; then
            echo
            read -t $WAITTIME -n 1 -p "Any key to continue.  Automatic continue after $WAITTIME seconds : " anykey
        fi

        echo | tee -a -i $APICLIlogfilepath
        echo "Continueing local execution" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    else
        echo >> $APICLIlogfilepath
        echo "Returned from external Command Line Paramenter Handling Script" >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
        echo "Continueing local execution" >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
        echo '--------------------------------------------------------------------------' >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    fi

}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call command line parameter handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-03-3 -

export configured_handler_root=$cli_api_cmdlineparm_handler_root
export actual_handler_root=$configured_handler_root

if [ "$configured_handler_root" == "." ] ; then
    if [ $ScriptSourceFolder != $localdotpath ] ; then
        # Script is not running from it's source folder, might be linked, so since we expect the handler folder
        # to be relative to the script source folder, use the identified script source folder instead
        export actual_handler_root=$ScriptSourceFolder
    else
        # Script is running from it's source folder
        export actual_handler_root=$configured_handler_root
    fi
else
    # handler root path is not period (.), so stipulating fully qualified path
    export actual_handler_root=$configured_handler_root
fi

export cli_api_cmdlineparm_handler_path=$actual_handler_root/$cli_api_cmdlineparm_handler_folder
export cli_api_cmdlineparm_handler=$cli_api_cmdlineparm_handler_path/$cli_api_cmdlineparm_handler_file

# Check that we can finde the command line parameter handler file
#
if [ ! -r $cli_api_cmdlineparm_handler ] ; then
    # no file found, that is a problem
    echo | tee -a -i $APICLIlogfilepath
    echo 'Command Line Parameter handler script file missing' | tee -a -i $APICLIlogfilepath
    echo '  File not found : '$cli_api_cmdlineparm_handler | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Other parameter elements : ' | tee -a -i $APICLIlogfilepath
    echo '  Configured Root path    : '$configured_handler_root | tee -a -i $APICLIlogfilepath
    echo '  Actual Script Root path : '$actual_handler_root | tee -a -i $APICLIlogfilepath
    echo '  Root of folder path : '$cli_api_cmdlineparm_handler_root | tee -a -i $APICLIlogfilepath
    echo '  Folder in Root path : '$cli_api_cmdlineparm_handler_folder | tee -a -i $APICLIlogfilepath
    echo '  Folder Root path    : '$cli_api_cmdlineparm_handler_path | tee -a -i $APICLIlogfilepath
    echo '  Script Filename     : '$cli_api_cmdlineparm_handler_file | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 251
fi

# MODIFIED 2018-05-03-3 -

CommandLineParameterHandler "$@"


# -------------------------------------------------------------------------------------------------
# Local Handle request for help and return
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Was help requested, if so show local content and return
#
if [ x"$SHOWHELP" = x"true" ] ; then
    # Show Local Help
    doshowlocalhelp
    exit 255 
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-09-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Command Line Parameter Handling and Help
# =================================================================================================
# =================================================================================================


# MODIFIED 2020-09-02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckStatusOfAPI
errorresult=$?
if [ $errorresult -ne 0 ] ; then
    #api operations status NOT OK, so anything that is not a 0 result is a fail!
    #Do something based on it not being ready or working!
    
    echo "API Error!" | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Log output in file   : '"$APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    
    exit 1
else
    #api operations status OK
    #Do something based on it being ready and working!
    
    echo "API OK, proceeding!" >> $APICLIlogfilepath
fi

GaiaWebSSLPortCheck

export CheckAPIVersion=

ScriptAPIVersionCheck

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-02


# =================================================================================================
# =================================================================================================
# START:  Setup Standard Parameters
# =================================================================================================

if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
    echo 'Date Time Group   :  '$DATE | tee -a -i $APICLIlogfilepath
    echo 'Date Time Group S :  '$DATEDTGS | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
else
    echo 'Date Time Group   :  '$DATE >> $APICLIlogfilepath
    echo 'Date Time Group S :  '$DATEDTGS >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
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
    
    if [ "$APISCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $APICLIlogfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo "Calling external Gaia version and installation type Handling Script" | tee -a -i $APICLIlogfilepath
        echo " - External Script : "$gaia_version_handler | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    else
        echo >> $APICLIlogfilepath
        echo '--------------------------------------------------------------------------' >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
        echo "Calling external Gaia version and installation type Handling Script" >> $APICLIlogfilepath
        echo " - External Script : "$gaia_version_handler >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    fi
    
    . $gaia_version_handler "$@"
    
    if [ "$APISCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $APICLIlogfilepath
        echo "Returned from external Gaia version and installation type Handling Script" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath

        if [ "$NOWAIT" != "true" ] ; then
            echo
            read -t $WAITTIME -n 1 -p "Any key to continue.  Automatic continue after $WAITTIME seconds : " anykey
        fi

        echo | tee -a -i $APICLIlogfilepath
        echo "Continueing local execution" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    else
        echo >> $APICLIlogfilepath
        echo "Returned from external Gaia version and installation type Handling Script" >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
        echo "Continueing local execution" >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
        echo '--------------------------------------------------------------------------' >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
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

export configured_handler_root=$gaia_version_handler_root
export actual_handler_root=$configured_handler_root

if [ "$configured_handler_root" == "." ] ; then
    if [ $ScriptSourceFolder != $localdotpath ] ; then
        # Script is not running from it's source folder, might be linked, so since we expect the handler folder
        # to be relative to the script source folder, use the identified script source folder instead
        export actual_handler_root=$ScriptSourceFolder
    else
        # Script is running from it's source folder
        export actual_handler_root=$configured_handler_root
    fi
else
    # handler root path is not period (.), so stipulating fully qualified path
    export actual_handler_root=$configured_handler_root
fi

export gaia_version_handler_path=$actual_handler_root/$gaia_version_handler_folder
export gaia_version_handler=$gaia_version_handler_path/$gaia_version_handler_file

# Check that we can finde the command line parameter handler file
#
if [ ! -r $gaia_version_handler ] ; then
    # no file found, that is a problem
    echo | tee -a -i $APICLIlogfilepath
    echo ' Gaia version and installation type handler script file missing' | tee -a -i $APICLIlogfilepath
    echo '  File not found : '$gaia_version_handler | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Other parameter elements : ' | tee -a -i $APICLIlogfilepath
    echo '  Configured Root path    : '$configured_handler_root | tee -a -i $APICLIlogfilepath
    echo '  Actual Script Root path : '$actual_handler_root | tee -a -i $APICLIlogfilepath
    echo '  Root of folder path : '$gaia_version_handler_root | tee -a -i $APICLIlogfilepath
    echo '  Folder in Root path : '$gaia_version_handler_folder | tee -a -i $APICLIlogfilepath
    echo '  Folder Root path    : '$gaia_version_handler_path | tee -a -i $APICLIlogfilepath
    echo '  Script Filename     : '$gaia_version_handler_file | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 251
fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-09-21

GetGaiaVersionAndInstallationType "$@"


# =================================================================================================
# END:  Setup Standard Parameters
# =================================================================================================
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Setup Login Parameters and Mgmt_CLI handler procedures
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLIPublish - publish changes if needed
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# HandleMgmtCLIPublish - publish changes if needed
#

HandleMgmtCLIPublish () {
    #
    # HandleMgmtCLIPublish - publish changes if needed
    #
    
    # APICLIsessionerrorfile is created at login
    #export APICLIsessionerrorfile=id.`date +%Y%m%d-%H%M%S%Z`.err
    echo > $APICLIsessionerrorfile
    echo 'mgmt_cli publish operation' > $APICLIsessionerrorfile
    echo > $APICLIsessionerrorfile
    
    if [ x"$script_use_publish" = x"true" ] ; then
        echo | tee -a -i $APICLIlogfilepath
        echo 'Publish changes!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        mgmt_cli publish -s $APICLIsessionfile >> $APICLIlogfilepath 2>> $APICLIsessionerrorfile
        EXITCODE=$?
        cat $APICLIsessionerrorfile >> $APICLIlogfilepath
        
        echo | tee -a -i $APICLIlogfilepath
    else
        echo | tee -a -i $APICLIlogfilepath
        echo 'Nothing to Publish!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        EXITCODE=0
    fi
    
    return $EXITCODE
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-09

# -------------------------------------------------------------------------------------------------
# HandleMgmtCLILogout - Logout from mgmt_cli, also cleanup session file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Logout from mgmt_cli, also cleanup session file
#

HandleMgmtCLILogout () {
    #
    # HandleMgmtCLILogout - Logout from mgmt_cli, also cleanup session file
    #
    
    # APICLIsessionerrorfile is created at login
    #export APICLIsessionerrorfile=id.`date +%Y%m%d-%H%M%S%Z`.err
    echo > $APICLIsessionerrorfile
    echo 'mgmt_cli logout operation' > $APICLIsessionerrorfile
    echo > $APICLIsessionerrorfile
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Logout of mgmt_cli!  Then remove session file : '$APICLIsessionfile | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    mgmt_cli logout -s $APICLIsessionfile >> $APICLIlogfilepath 2>> $APICLIsessionerrorfile
    EXITCODE=$?
    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
    
    rm $APICLIsessionfile | tee -a -i $APICLIlogfilepath
    rm $APICLIsessionerrorfile | tee -a -i $APICLIlogfilepath
    
    return $EXITCODE
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-09

# -------------------------------------------------------------------------------------------------
# HandleMgmtCLILogin - Login to the API via mgmt_cli login
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Login to the API via mgmt_cli login
#

HandleMgmtCLILogin () {
    #
    # Login to the API via mgmt_cli login
    #
    
    export loginstring=
    export loginparmstring=
    
    # MODIFIED 2018-05-04 -
    export APICLIsessionerrorfile=id.`date +%Y%m%d-%H%M%S%Z`.err
    echo 'API CLI Session Error File : '$APICLIsessionerrorfile > $APICLIsessionerrorfile
    echo >> $APICLIsessionerrorfile
    echo 'mgmt_cli login operation' >> $APICLIsessionerrorfile
    echo >> $APICLIsessionerrorfile
    
    # MODIFIED 2018-05-03 -
    if [ ! -z "$CLIparm_sessionidfile" ] ; then
        # CLIparm_sessionidfile value is set so use it
        export APICLIsessionfile=$CLIparm_sessionidfile
    else
        # Updated to make session id file unique in case of multiple admins running script from same folder
        export APICLIsessionfile=id.`date +%Y%m%d-%H%M%S%Z`.txt
    fi
    
    # MODIFIED 2018-05-03 -
    export domainnamenospace=
    if [ ! -z "$domaintarget" ] ; then
        # Handle domain name that might include space if the value is set
        #export domainnamenospace="$(echo -e "${domaintarget}" | tr -d '[:space:]')"
        #export domainnamenospace=$(echo -e ${domaintarget} | tr -d '[:space:]')
        export domainnamenospace=$(echo -e ${domaintarget} | tr ' ' '_')
    else
        export domainnamenospace=
    fi
    
    if [ ! -z "$domainnamenospace" ] ; then
        # Handle domain name that might include space
        if [ ! -z "$CLIparm_sessionidfile" ] ; then
            # adjust if CLIparm_sessionidfile was set, since that might be a complete path, append the path to it 
            export APICLIsessionfile=$APICLIsessionfile.$domainnamenospace
        else
            # assume the session file is set to a local file and prefix the domain to it
            export APICLIsessionfile=$domainnamenospace.$APICLIsessionfile
        fi
    fi
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        echo | tee -a -i $APICLIlogfilepath
        echo 'APICLIwebsslport  :  '$APICLIwebsslport | tee -a -i $APICLIlogfilepath
        echo 'APISessionTimeout :  '$APISessionTimeout | tee -a -i $APICLIlogfilepath
        echo 'Domain Target     :  '$domaintarget | tee -a -i $APICLIlogfilepath
        echo 'Domain no space   :  '$domainnamenospace | tee -a -i $APICLIlogfilepath
        echo 'APICLIsessionfile :  '$APICLIsessionfile | tee -a -i $APICLIlogfilepath
    else
        echo >> $APICLIlogfilepath
        echo 'APICLIwebsslport  :  '$APICLIwebsslport >> $APICLIlogfilepath
        echo 'APISessionTimeout :  '$APISessionTimeout >> $APICLIlogfilepath
        echo 'Domain Target     :  '$domaintarget >> $APICLIlogfilepath
        echo 'Domain no space   :  '$domainnamenospace >> $APICLIlogfilepath
        echo 'APICLIsessionfile :  '$APICLIsessionfile >> $APICLIlogfilepath
    fi
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'mgmt_cli Login!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    if [ x"$CLIparm_rootuser" = x"true" ] ; then
        # Handle if ROOT User -r true parameter
        
        echo 'Login to mgmt_cli as root user -r true and save to session file :  '$APICLIsessionfile | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
        # Handle management server parameter error if combined with ROOT User
        if [ x"$CLIparm_mgmt" != x"" ] ; then
            echo | tee -a -i $APICLIlogfilepath
            echo 'mgmt_cli parameter error!!!!' | tee -a -i $APICLIlogfilepath
            echo 'ROOT User (-r true) parameter can not be combined with -m <Management_Server>!!!' | tee -a -i $APICLIlogfilepath
            echo | tee -a -i $APICLIlogfilepath
            return 254
        fi
        
        export loginparmstring=' -r true'
        
        if [ x"$domaintarget" != x"" ] ; then
            # Handle domain parameter for login string
            export loginparmstring=$loginparmstring" domain \"$domaintarget\""
            
            #
            # Testing - Dump login string built from parameters
            #
            if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                echo 'Execute login with loginparmstring '\"$loginparmstring\"' As Root with Domain '\"$domaintarget\" | tee -a -i $APICLIlogfilepath
                echo | tee -a -i $APICLIlogfilepath
            else
                echo 'Execute login with loginparmstring '\"$loginparmstring\"' As Root with Domain '\"$domaintarget\" >> $APICLIlogfilepath
                echo >> $APICLIlogfilepath
            fi
            
            mgmt_cli login -r true domain "$domaintarget" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
            EXITCODE=$?
            cat $APICLIsessionerrorfile >> $APICLIlogfilepath
        else
            #
            # Testing - Dump login string built from parameters
            #
            if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                echo 'Execute login with loginparmstring '\"$loginparmstring\"' As Root' | tee -a -i $APICLIlogfilepath
                echo | tee -a -i $APICLIlogfilepath
            else
                echo 'Execute login with loginparmstring '\"$loginparmstring\"' As Root' >> $APICLIlogfilepath
                echo >> $APICLIlogfilepath
            fi
            
            mgmt_cli login -r true session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
            EXITCODE=$?
            cat $APICLIsessionerrorfile >> $APICLIlogfilepath
        fi
    elif [ x"$CLIparm_api_key" != x"" ] ; then
        # Handle if --api-key parameter set
        
        echo 'Login to mgmt_cli with API key '\"$CLIparm_api_key\"' and save to session file :  '$APICLIsessionfile | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
        if [ x"$domaintarget" != x"" ] ; then
            # Handle domain parameter for login string
            export loginparmstring=$loginparmstring" domain \"$domaintarget\""
            
            # Handle management server parameter for mgmt_cli parms
            if [ x"$CLIparm_mgmt" != x"" ] ; then
                export mgmttarget="-m \"$CLIparm_mgmt\""
                
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    echo 'Execute login using API key' | tee -a -i $APICLIlogfilepath
                    echo 'Execute operations with mgmttarget '\"$mgmttarget\"' to Domain '\"$domaintarget\" | tee -a -i $APICLIlogfilepath
                    echo | tee -a -i $APICLIlogfilepath
                else
                    echo 'Execute login using API key' >> $APICLIlogfilepath
                    echo 'Execute operations with mgmttarget '\"$mgmttarget\"' to Domain '\"$domaintarget\" >> $APICLIlogfilepath
                    echo >> $APICLIlogfilepath
                fi
                
                mgmt_cli login api-key "$CLIparm_api_key" domain "$domaintarget" -m "$CLIparm_mgmt" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                EXITCODE=$?
                cat $APICLIsessionerrorfile >> $APICLIlogfilepath
            else
                
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    echo 'Execute login using API key to Domain '\"$domaintarget\" | tee -a -i $APICLIlogfilepath
                    echo | tee -a -i $APICLIlogfilepath
                else
                    echo 'Execute login using API key to Domain '\"$domaintarget\" >> $APICLIlogfilepath
                    echo >> $APICLIlogfilepath
                fi
                
                mgmt_cli login api-key "$CLIparm_api_key" domain "$domaintarget" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                EXITCODE=$?
                cat $APICLIsessionerrorfile >> $APICLIlogfilepath
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"$CLIparm_mgmt" != x"" ] ; then
                export mgmttarget="-m \"$CLIparm_mgmt\""
                
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    echo 'Execute login using API key' | tee -a -i $APICLIlogfilepath
                    echo 'Execute operations with mgmttarget '\"$mgmttarget\" | tee -a -i $APICLIlogfilepath
                    echo | tee -a -i $APICLIlogfilepath
                else
                    echo 'Execute login using API key' >> $APICLIlogfilepath
                    echo 'Execute operations with mgmttarget '\"$mgmttarget\" >> $APICLIlogfilepath
                    echo >> $APICLIlogfilepath
                fi
                
                mgmt_cli login api-key "$CLIparm_api_key" -m "$CLIparm_mgmt" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                EXITCODE=$?
                cat $APICLIsessionerrorfile >> $APICLIlogfilepath
            else
                
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    echo 'Execute login using API key' | tee -a -i $APICLIlogfilepath
                    echo | tee -a -i $APICLIlogfilepath
                else
                    echo 'Execute login using API key' >> $APICLIlogfilepath
                    echo >> $APICLIlogfilepath
                fi
                
                mgmt_cli login api-key "$CLIparm_api_key" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                EXITCODE=$?
                cat $APICLIsessionerrorfile >> $APICLIlogfilepath
            fi
        fi
        
    else
        # Handle User
        
        echo 'Login to mgmt_cli as '$APICLIadmin' and save to session file :  '$APICLIsessionfile | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
        if [ x"$APICLIadmin" != x"" ] ; then
            export loginparmstring=$loginparmstring" user $APICLIadmin"
        else
            echo | tee -a -i $APICLIlogfilepath
            echo 'mgmt_cli parameter error!!!!' | tee -a -i $APICLIlogfilepath
            echo 'Admin User variable not set!!!' | tee -a -i $APICLIlogfilepath
            echo | tee -a -i $APICLIlogfilepath
            return 254
        fi
        
        if [ x"$CLIparm_password" != x"" ] ; then
            # Handle password parameter
            export loginparmstring=$loginparmstring" password \"$CLIparm_password\""
            
            if [ x"$domaintarget" != x"" ] ; then
                # Handle domain parameter for login string
                export loginparmstring=$loginparmstring" domain \"$domaintarget\""
                
                # Handle management server parameter for mgmt_cli parms
                if [ x"$CLIparm_mgmt" != x"" ] ; then
                    export mgmttarget="-m \"$CLIparm_mgmt\""
                    
                    #
                    # Testing - Dump login string built from parameters
                    #
                    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Password and Domain and Management' | tee -a -i $APICLIlogfilepath
                        echo 'Execute operations with mgmttarget '\"$mgmttarget\"' to Domain '\"$domaintarget\" | tee -a -i $APICLIlogfilepath
                        echo | tee -a -i $APICLIlogfilepath
                    else
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Password and Domain and Management' >> $APICLIlogfilepath
                        echo 'Execute operations with mgmttarget '\"$mgmttarget\"' to Domain '\"$domaintarget\" >> $APICLIlogfilepath
                        echo >> $APICLIlogfilepath
                    fi
                    
                    mgmt_cli login user $APICLIadmin password "$CLIparm_password" domain "$domaintarget" -m "$CLIparm_mgmt" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                    EXITCODE=$?
                    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
                else
                    #
                    # Testing - Dump login string built from parameters
                    #
                    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Password and Domain '\"$domaintarget\" | tee -a -i $APICLIlogfilepath
                        echo | tee -a -i $APICLIlogfilepath
                    else
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Password and Domain '\"$domaintarget\" >> $APICLIlogfilepath
                        echo >> $APICLIlogfilepath
                    fi
                    
                    mgmt_cli login user $APICLIadmin password "$CLIparm_password" domain "$domaintarget" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                    EXITCODE=$?
                    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
                fi
            else
                # Handle management server parameter for mgmt_cli parms
                if [ x"$CLIparm_mgmt" != x"" ] ; then
                    export mgmttarget='-m \"$CLIparm_mgmt\"'
                    
                    #
                    # Testing - Dump login string built from parameters
                    #
                    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Password and Management' | tee -a -i $APICLIlogfilepath
                        echo 'Execute operations with mgmttarget '\"$mgmttarget\" | tee -a -i $APICLIlogfilepath
                        echo | tee -a -i $APICLIlogfilepath
                    else
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Password and Management' >> $APICLIlogfilepath
                        echo 'Execute operations with mgmttarget '\"$mgmttarget\" >> $APICLIlogfilepath
                        echo >> $APICLIlogfilepath
                    fi
                    
                    mgmt_cli login user $APICLIadmin password "$CLIparm_password" -m "$CLIparm_mgmt" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                    EXITCODE=$?
                    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
                else
                    #
                    # Testing - Dump login string built from parameters
                    #
                    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Password' | tee -a -i $APICLIlogfilepath
                        echo | tee -a -i $APICLIlogfilepath
                    else
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Password' >> $APICLIlogfilepath
                        echo >> $APICLIlogfilepath
                    fi
                    
                    mgmt_cli login user $APICLIadmin password "$CLIparm_password" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                    EXITCODE=$?
                    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
                fi
            fi
        else
            # Handle NO password parameter
            
            if [ x"$domaintarget" != x"" ] ; then
                # Handle domain parameter for login string
                export loginparmstring=$loginparmstring" domain \"$domaintarget\""
                
                # Handle management server parameter for mgmt_cli parms
                if [ x"$CLIparm_mgmt" != x"" ] ; then
                    export mgmttarget="-m \"$CLIparm_mgmt\""
                    
                    #
                    # Testing - Dump login string built from parameters
                    #
                    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Domain and Management' | tee -a -i $APICLIlogfilepath
                        echo 'Execute operations with mgmttarget '\"$mgmttarget\"' to Domain '\"$domaintarget\" | tee -a -i $APICLIlogfilepath
                        echo | tee -a -i $APICLIlogfilepath
                    else
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Domain and Management' >> $APICLIlogfilepath
                        echo 'Execute operations with mgmttarget '\"$mgmttarget\"' to Domain '\"$domaintarget\" >> $APICLIlogfilepath
                        echo >> $APICLIlogfilepath
                    fi
                    
                    mgmt_cli login user $APICLIadmin domain "$domaintarget" -m "$CLIparm_mgmt" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                    EXITCODE=$?
                    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
                else
                    #
                    # Testing - Dump login string built from parameters
                    #
                    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Domain '\"$domaintarget\" | tee -a -i $APICLIlogfilepath
                        echo | tee -a -i $APICLIlogfilepath
                    else
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Domain '\"$domaintarget\" >> $APICLIlogfilepath
                        echo >> $APICLIlogfilepath
                    fi
                    
                    mgmt_cli login user $APICLIadmin domain "$domaintarget" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                    EXITCODE=$?
                    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
                fi
            else
                # Handle management server parameter for mgmt_cli parms
                if [ x"$CLIparm_mgmt" != x"" ] ; then
                    export mgmttarget='-m \"$CLIparm_mgmt\"'
                    
                    #
                    # Testing - Dump login string built from parameters
                    #
                    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Management' | tee -a -i $APICLIlogfilepath
                        echo 'Execute operations with mgmttarget '\"$mgmttarget\" | tee -a -i $APICLIlogfilepath
                        echo | tee -a -i $APICLIlogfilepath
                    else
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User with Management' >> $APICLIlogfilepath
                        echo 'Execute operations with mgmttarget '\"$mgmttarget\" >> $APICLIlogfilepath
                        echo >> $APICLIlogfilepath
                    fi
                    
                    mgmt_cli login user $APICLIadmin -m "$CLIparm_mgmt" session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                    EXITCODE=$?
                    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
                else
                    #
                    # Testing - Dump login string built from parameters
                    #
                    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User' | tee -a -i $APICLIlogfilepath
                        echo | tee -a -i $APICLIlogfilepath
                    else
                        echo 'Execute login with loginparmstring '\"$loginparmstring\"' As User' >> $APICLIlogfilepath
                        echo >> $APICLIlogfilepath
                    fi
                    
                    mgmt_cli login user $APICLIadmin session-timeout $APISessionTimeout --port $APICLIwebsslport -f json > $APICLIsessionfile 2>> $APICLIsessionerrorfile
                    EXITCODE=$?
                    cat $APICLIsessionerrorfile >> $APICLIlogfilepath
                fi
            fi
        fi
    fi
    
    if [ "$EXITCODE" != "0" ] ; then
        
        echo | tee -a -i $APICLIlogfilepath
        echo 'mgmt_cli login error!  EXITCODE = '$EXITCODE | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        cat $APICLIsessionfile | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return 255
        
    else
        
        echo "mgmt_cli login success!" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        cat $APICLIsessionfile | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-09

# -------------------------------------------------------------------------------------------------
# SetupLogin2MgmtCLI - Setup Login to Management CLI
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupLogin2MgmtCLI () {
    #
    # setup the mgmt_cli login fundamentals
    #
    
    #export APICLIwebsslport=$currentapisslport
    
    if [ ! -z "$CLIparm_mgmt" ] ; then
        # working with remote management server
        if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            echo 'Working with remote management server' | tee -a -i $APICLIlogfilepath
        fi
        
        # MODIFIED 2020-09-09 -
        # Stipulate that if running on the actual management host, use it's web ssl-port value
        # unless we're running with the management server setting CLIparm_mgmt, then use the
        # passed parameter from the CLI or default to 443
        #
        if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            echo | tee -a -i $APICLIlogfilepath
            echo 'Initial $APICLIwebsslport   = '$APICLIwebsslport | tee -a -i $APICLIlogfilepath
            echo 'Current $CLIparm_websslport = '$CLIparm_websslport | tee -a -i $APICLIlogfilepath
        fi
        
        if [ ! -z "$CLIparm_websslport" ] ; then
            if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                echo 'Working with web ssl-port from CLI parms' | tee -a -i $APICLIlogfilepath
            fi
            export APICLIwebsslport=$CLIparm_websslport
        else
            # Default back to expected SSL port, since we won't know what the remote management server configuration for web ssl-port is.
            # This may change once Gaia API is readily available and can be checked.
            if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                echo 'Remote management cannot currently be queried for web ssl-port, so defaulting to 443' | tee -a -i $APICLIlogfilepath
            fi
            export APICLIwebsslport=443
        fi
    else
        # not working with remote management server
        if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            echo 'Not working with remote management server' | tee -a -i $APICLIlogfilepath
        fi
        
        # MODIFIED 2020-09-09 -
        # Stipulate that if running on the actual management host, use it's web ssl-port value
        # unless we're running with the management server setting CLIparm_mgmt, then use the
        # passed parameter from the CLI or default to 443
        #
        if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            echo | tee -a -i $APICLIlogfilepath
            echo 'Initial $APICLIwebsslport   = '$APICLIwebsslport | tee -a -i $APICLIlogfilepath
            echo 'Current $CLIparm_websslport = '$CLIparm_websslport | tee -a -i $APICLIlogfilepath
            echo 'Current $currentapisslport  = '$currentapisslport | tee -a -i $APICLIlogfilepath
        fi
        
        if [ ! -z "$CLIparm_websslport" ] ; then
            if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                echo 'Working with web ssl-port from CLI parms' | tee -a -i $APICLIlogfilepath
            fi
            export APICLIwebsslport=$CLIparm_websslport
        else
            if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                echo 'Working with web ssl-port harvested from Gaia' | tee -a -i $APICLIlogfilepath
            fi
            export APICLIwebsslport=$currentapisslport
        fi
    fi
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        echo 'Final $APICLIwebsslport     = '$APICLIwebsslport | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi
    # ADDED 2020-09-09 -
    # Handle login session-timeout parameter
    #
    
    export APISessionTimeout=600
    
    MinAPISessionTimeout=10
    MaxAPISessionTimeout=3600
    DefaultAPISessionTimeout=600
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        echo | tee -a -i $APICLIlogfilepath
        echo 'Initial $APISessionTimeout      = '$APISessionTimeout | tee -a -i $APICLIlogfilepath
        echo 'Current $CLIparm_sessiontimeout = '$CLIparm_sessiontimeout | tee -a -i $APICLIlogfilepath
    fi
    
    if [ ! -z $CLIparm_sessiontimeout ]; then
        # CLI Parameter for session-timeout was passed
        if [ $CLIparm_sessiontimeout -lt $MinAPISessionTimeout ] ||  [ $CLIparm_sessiontimeout -gt $MaxAPISessionTimeout ]; then
            # parameter is outside of range for MinAPISessionTimeout to MaxAPISessionTimeout
            echo 'Value of $CLIparm_sessiontimeout ('$CLIparm_sessiontimeout') is out side of allowed range!' | tee -a -i $APICLIlogfilepath
            echo 'Allowed session-timeout value range is '$MinAPISessionTimeout' to '$MaxAPISessionTimeout | tee -a -i $APICLIlogfilepath
            export APISessionTimeout=$DefaultAPISessionTimeout
        else
            # parameter is within range for MinAPISessionTimeout to MaxAPISessionTimeout
            export APISessionTimeout=$CLIparm_sessiontimeout
        fi
    else
        # CLI Parameter for session-timeout not set
        export APISessionTimeout=$DefaultAPISessionTimeout
    fi
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        echo | tee -a -i $APICLIlogfilepath
        echo 'Final $APISessionTimeout       = '$APISessionTimeout | tee -a -i $APICLIlogfilepath
    fi
    
    # MODIFIED 2018-05-03 -
    
    # ================================================================================================
    # NOTE:  APICLIadmin value must be set to operate this script, removing this varaiable will lead
    #        to logon failure with mgmt_cli logon.  Root User (-r) parameter is handled differently,
    #        so DO NOT REMOVE OR CLEAR this variable.  Adjust the export APICLIadmin= line to reflect
    #        the default administrator name for the environment
    #
    #        The value for APICLIadmin now is set by the value of DefaultMgmtAdmin found at the top 
    #        of the script in the 'Root script declarations' section.
    #
    # ================================================================================================
    if [ ! -z "$CLIparm_user" ] ; then
        export APICLIadmin=$CLIparm_user
    elif [ ! -z "$DefaultMgmtAdmin" ] ; then
        export APICLIadmin=$DefaultMgmtAdmin
    else
        #export APICLIadmin=administrator
        #export APICLIadmin=admin
        export APICLIadmin=$DefaultMgmtAdmin
    fi
    
    # Clear variables that need to be set later
    
    export mgmttarget=
    export domaintarget=
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-09

# -------------------------------------------------------------------------------------------------
# Login2MgmtCLI - Process Login to Management CLI
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

Login2MgmtCLI () {
    #
    # Execute the mgmt_cli login and address results
    #
    
    HandleMgmtCLILogin
    SUBEXITCODE=$?
    
    if [ "$SUBEXITCODE" != "0" ] ; then
    
        echo | tee -a -i $APICLIlogfilepath
        echo "Terminating script..." | tee -a -i $APICLIlogfilepath
        echo "Exitcode $SUBEXITCODE" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return $SUBEXITCODE
        
    else
        echo | tee -a -i $APICLIlogfilepath
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-09

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# =================================================================================================
# END:  Setup Login Parameters and Mgmt_CLI handler procedures
# =================================================================================================
# =================================================================================================

# =================================================================================================
# =================================================================================================
# START:  Setup CLI Parameter based values
# =================================================================================================

# =================================================================================================
# START:  Common Procedures
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# localrootscriptconfiguration - Local Root Script Configuration setup
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-17 -
localrootscriptconfiguration () {
    #
    # Local Root Script Configuration setup
    #

    # WAITTIME in seconds for read -t commands
    
    export customerpathroot=/var/log/__customer
    export customerworkpathroot=$customerpathroot/upgrade_export
    export outputpathroot=$customerworkpathroot
    export dumppathroot=$customerworkpathroot/dump
    export changelogpathroot=$customerworkpathroot/Change_Log
    
    export customerapipathroot=/var/log/__customer/cli_api_ops
    export customerapiwippathroot=/var/log/__customer/cli_api_ops.wip

    echo
    return 0
}


# -------------------------------------------------------------------------------------------------
# HandleRootScriptConfiguration - Root Script Configuration
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-29 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleRootScriptConfiguration () {
    #
    # Root Script Configuration
    #
    
    # -------------------------------------------------------------------------------------------------
    # START: Root Script Configuration
    # -------------------------------------------------------------------------------------------------
    
    if [ -r "$scriptspathroot/$rootscriptconfigfile" ] ; then
        # Found the Root Script Configuration File in the folder for scripts
        # So let's call that script to configure what we need
    
        . $scriptspathroot/$rootscriptconfigfile "$@"
        errorreturn=$?
    elif [ -r "../$rootscriptconfigfile" ] ; then
        # Found the Root Script Configuration File in the folder above the executiong script
        # So let's call that script to configure what we need
    
        . ../$rootscriptconfigfile "$@"
        errorreturn=$?
    elif [ -r "$rootscriptconfigfile" ] ; then
        # Found the Root Script Configuration File in the folder with the executiong script
        # So let's call that script to configure what we need
    
        . $rootscriptconfigfile "$@"
        errorreturn=$?
    else
        # Did not the Root Script Configuration File
        # So let's call local configuration
    
        localrootscriptconfiguration "$@"
        errorreturn=$?
    fi
    
    # -------------------------------------------------------------------------------------------------
    # END:  Root Script Configuration
    # -------------------------------------------------------------------------------------------------
    
    return $errorreturn
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-09-29


# -------------------------------------------------------------------------------------------------
# HandleLaunchInHomeFolder - Handle if folder where this was launched is the $HOME Folder
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-22 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleLaunchInHomeFolder () {
    #
    # Handle if folder where this was launched is the $HOME Folder
    #
    
    export expandedpath=$(cd $startpathroot ; pwd)
    export startpathroot=$expandedpath
    export checkthispath=`echo "${expandedpath}" | grep -i "$notthispath"`
    export isitthispath=`test -z $checkthispath; echo $?`
    
    if [ $isitthispath -eq 1 ] ; then
        #Oh, Oh, we're in the home directory executing, not good!!!
        #Configure outputpathroot for $alternatepathroot folder since we can't run in /home/
        echo 'In home directory folder : '$startpathroot >> $APICLIlogfilepath
        export outputpathroot=$alternatepathroot
    else
        #OK use the current folder and create working sub-folder
        echo 'NOT in home directory folder : '$startpathroot >> $APICLIlogfilepath
        # let's not change the configuration provided
        #export outputpathroot=$startpathroot
    fi
    
    if [ ! -r $outputpathroot ] ; then
        #not where we're expecting to be, since $outputpathroot is missing here
        #maybe this hasn't been run here yet.
        #OK, so make the expected folder and set permissions we need
        mkdir $outputpathroot >> $APICLIlogfilepath
        chmod 775 $outputpathroot >> $APICLIlogfilepath
    else
        #set permissions we need
        chmod 775 $outputpathroot >> $APICLIlogfilepath
    fi
    
    #Now that outputroot is not in /home/ let's work on where we are working from
    
    export expandedpath=$(cd $outputpathroot ; pwd)
    export outputpathroot=${expandedpath}
    export dumppathroot=$outputpathroot/dump
    export changelogpathroot=$outputpathroot/Change_Log
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-09-22


# -------------------------------------------------------------------------------------------------
# ShowFinalOutputAndLogPaths - repeated proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-29D -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ShowFinalOutputAndLogPaths () {
    #
    # repeated procedure description
    #

    #----------------------------------------------------------------------------------------
    # Output and Log file and folder Information
    #----------------------------------------------------------------------------------------
    
    if [ x"$SCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        
        echo "Controls : " | tee -a -i $APICLIlogfilepath
        echo ' $OutputRelLocalPath        : '"$OutputRelLocalPath" | tee -a -i $APICLIlogfilepath
        echo ' $IgnoreInHome              : '"$IgnoreInHome" | tee -a -i $APICLIlogfilepath
        echo ' $OutputToRoot              : '"$OutputToRoot" | tee -a -i $APICLIlogfilepath
        echo ' $OutputToDump              : '"$OutputToDump" | tee -a -i $APICLIlogfilepath
        echo ' $OutputToChangeLog         : '"$OutputToChangeLog" | tee -a -i $APICLIlogfilepath
        echo ' $OutputToOther             : '"$OutputToOther" | tee -a -i $APICLIlogfilepath
        echo ' $OtherOutputFolder         : '"$OtherOutputFolder" | tee -a -i $APICLIlogfilepath
        echo ' OutputDATESubfolder        : '"$OutputDATESubfolder" | tee -a -i $APICLIlogfilepath
        echo ' $OutputDTGSSubfolder       : '"$OutputDTGSSubfolder" | tee -a -i $APICLIlogfilepath
        #echo ' $OutputSubfolderScriptName      : '"$OutputSubfolderScriptName" | tee -a -i $APICLIlogfilepath
        #echo ' $OutputSubfolderScriptShortName : '"$OutputSubfolderScriptShortName" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
        echo "Output and Log file, folder locations: " | tee -a -i $APICLIlogfilepath
        echo ' $APICLIpathroot            : '"$APICLIpathroot" | tee -a -i $APICLIlogfilepath
        echo ' $APICLIpathbase            : '"$APICLIpathbase" | tee -a -i $APICLIlogfilepath
        echo ' $APICLIlogfilepath         : '"$APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
        echo ' $customerpathroot          : '"$customerpathroot" | tee -a -i $APICLIlogfilepath
        echo ' $customerworkpathroot      : '"$customerworkpathroot" | tee -a -i $APICLIlogfilepath
        echo ' $dumppathroot              : '"$dumppathroot" | tee -a -i $APICLIlogfilepath
        echo ' $changelogpathroot         : '"$changelogpathroot" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
        read -t $WAITTIME -n 1 -p "Any key to continue : " anykey
        echo
        
    else
        # Verbose mode OFF
        
        echo "Output and Log file, folder locations: " | tee -a -i $APICLIlogfilepath
        echo ' $APICLIpathbase       : '"$APICLIpathbase" | tee -a -i $APICLIlogfilepath
        echo ' $APICLIlogfilepath    : '"$APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-09-29


# -------------------------------------------------------------------------------------------------
# ConfigureRootPath - Configure root and base path
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-11-20 -

ConfigureRootPath () {

    # -------------------------------------------------------------------------------------------------
    # Root Script Configuration
    # -------------------------------------------------------------------------------------------------
    
    HandleRootScriptConfiguration "$@"
    
    
    #----------------------------------------------------------------------------------------
    # Setup root folder and path values
    #----------------------------------------------------------------------------------------
    
    export alternatepathroot=$customerworkpathroot
    
    if ! $IgnoreInHome ; then
        HandleLaunchInHomeFolder "$@"
    fi
    

    # ---------------------------------------------------------
    # Create the base path and directory structure for output
    # ---------------------------------------------------------
    
    if [ x"$CLIparm_outputpath" != x"" ] ; then
        if $OutputRelLocalPath ; then
            export APICLIpathroot=$CLIparm_outputpath
        else
            # need to expand this other path to ensure things work
            export expandedpath=$(cd $CLIparm_outputpath ; pwd)
            export APICLIpathroot=$expandedpath
        fi
        echo 'Set root output CLI parameter : $APICLIpathroot = '"$APICLIpathroot" >> $APICLIlogfilepath
    else
        # CLI parameter for outputpath not set

        if $OutputToRoot ; then
            # output to outputpathroot
            if $OutputRelLocalPath ; then
                export APICLIpathroot=.
            else
                export APICLIpathroot=$outputpathroot
            fi
        
            echo 'Set root output to Root : $APICLIpathroot = '"$APICLIpathroot" >> $APICLIlogfilepath

        elif $OutputToDump ; then
            # output to dump folder
            if $OutputRelLocalPath ; then
                export APICLIpathroot=./dump
            else
                export APICLIpathroot=$dumppathroot
            fi

            echo 'Set root output to Dump : $APICLIpathroot = '"$APICLIpathroot" >> $APICLIlogfilepath

        elif $OutputToChangeLog ; then
            # output to Change Log
            if $OutputRelLocalPath ; then
                export APICLIpathroot=./Change_Log
            else
                export APICLIpathroot=$changelogpathroot
            fi

            echo 'Set root output to Change Log : $APICLIpathroot = '"$APICLIpathroot" >> $APICLIlogfilepath

        elif $OutputToOther ; then
            # output to other folder that should be set in $OtherOutputFolder
            if $OutputRelLocalPath ; then
                export APICLIpathroot=./OtherOutputFolder
            else
                # need to expand this other path to ensure things work
                export expandedpath=$(cd $OtherOutputFolder ; pwd)
                export APICLIpathroot=$expandedpath
            fi
        
            echo 'Set root output to Other : $APICLIpathroot = '"$APICLIpathroot" >> $APICLIlogfilepath

        else
            # Huh, what... this should have been set, well the use dump
            # output to dumppathroot
            if $OutputRelLocalPath ; then
                export APICLIpathroot=./dump
            else
                export APICLIpathroot=$dumppathroot
            fi

            echo 'Set root output to default Dump : $APICLIpathroot = '"$APICLIpathroot" >> $APICLIlogfilepath

        fi
        
    fi
    
    echo '$APICLIpathroot = '$APICLIpathroot >> $APICLIlogfilepath

    if [ ! -r $APICLIpathroot ] ; then
        mkdir -p -v $APICLIpathroot | tee -a -i $APICLIlogfilepath
        chmod 775 $APICLIpathroot | tee -a -i $APICLIlogfilepath
    else
        chmod 775 $APICLIpathroot | tee -a -i $APICLIlogfilepath
    fi
        
    if $OutputDTGSSubfolder ; then
        # Use subfolder based on date-time group
        # this shifts the base output folder down a level
        export APICLIpathbase=$APICLIpathroot/$DATEDTGS
    elif $OutputDATESubfolder ; then
        export APICLIpathbase=$APICLIpathroot/$DATE
    else
        export APICLIpathbase=$APICLIpathroot
    fi
        
    echo '$APICLIpathbase = '$APICLIpathbase >> $APICLIlogfilepath

    if [ ! -r $APICLIpathbase ] ; then
        mkdir $APICLIpathbase | tee -a -i $APICLIlogfilepath
        chmod 775 $APICLIpathbase | tee -a -i $APICLIlogfilepath
    else
        chmod 775 $APICLIpathbase | tee -a -i $APICLIlogfilepath
    fi

    # In the future we may add this naming extension
    #if $OutputSubfolderScriptName ; then
    #    # Add script name to the Subfolder name
    #    export APICLIpathbase="$APICLIpathbase.$BASHScriptName"
    #elif $OutputSubfolderScriptShortName ; then
    #    # Add short script name to the Subfolder name
    #    export APICLIpathbase="$APICLIpathbase.$BASHScriptShortName"
    #fi
    #
    #echo '$APICLIpathbase = '$APICLIpathbase >> $APICLIlogfilepath
    #
    #if [ ! -r $APICLIpathbase ] ; then
    #    mkdir $APICLIpathbase | tee -a -i $APICLIlogfilepath
    #    chmod 775 $APICLIpathbase | tee -a -i $APICLIlogfilepath
    #else
    #    chmod 775 $APICLIpathbase | tee -a -i $APICLIlogfilepath
    #fi
}


# -------------------------------------------------------------------------------------------------
# ConfigureLogPath - Configure log file path and handle temporary log file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-11-20 -

ConfigureLogPath () {

    # ---------------------------------------------------------
    # Create the base path and directory structure for logging
    #----------------------------------------------------------------------------------------
    
    # Setup the log file fully qualified path based on final locations
    #
    if [ -z "$CLIparm_logpath" ]; then
        # CLI parameter for logfile not set
        export APICLIlogfilepathfinal=$APICLIpathbase/$ScriptName'_'$APIScriptVersion'_'$DATEDTGS.log
    else
        # CLI parameter for logfile set
        #export APICLIlogfilepathfinal=$CLIparm_logpath
    
        # need to expand this other path to ensure things work
        export expandedpath=$(cd $CLIparm_logpath ; pwd)
        export APICLIlogfilepathfinal=$expandedpath/$ScriptName'_'$APIScriptVersion'_'$DATEDTGS.log
    fi
    
    # if we've been logging, move the temporary log to the final path
    #
    if [ -r $APICLIlogfilepath ]; then
        mv $APICLIlogfilepath $APICLIlogfilepathfinal >> $APICLIlogfilepath
    fi
    
    # And then set the logfilepath value to the final one
    #
    export APICLIlogfilepath=$APICLIlogfilepathfinal
    
    #----------------------------------------------------------------------------------------
    # Done setting log paths
    #----------------------------------------------------------------------------------------
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# ConfigureCommonCLIParameterValues - Configure Common CLI Parameter Values
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-11-20 -

ConfigureCommonCLIParameterValues () {

    #
    # Configure Common CLI Parameter Values
    #
    
    ConfigureRootPath

    ConfigureLogPath
    
    # ADDED 2018-11-20 -
    ShowFinalOutputAndLogPaths

    return 0
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# END:  Common Procedures
# =================================================================================================

# =================================================================================================
# START:  Specific Procedures
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-03 -

# -------------------------------------------------------------------------------------------------
# ConfigureOtherCLIParameterPaths - Configure other path and folder values based on CLI parameters
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ConfigureOtherCLIParameterPaths () {

    # ---------------------------------------------------------
    # Setup other paths we may need - but these should not create folders (yet)
    # Configure other path and folder values based on CLI parameters
    # ---------------------------------------------------------
    
    export APICLICSVExportpathbase=
#    if [ x"$script_use_export" = x"true" ] ; then
#        if [ x"$CLIparm_exportpath" != x"" ] ; then
#            export APICLICSVExportpathbase=$CLIparm_exportpath
#        else
#            export APICLICSVExportpathbase=$APICLIpathbase
#        fi
#    fi

    # Since we use the $APICLICSVExportpathbase as a base folder for output results, 
    # we need this for all operations.  
    # FUTURE UDPATE : migrate the common dump location to a new standard variable
    #
    if [ x"$CLIparm_exportpath" != x"" ] ; then
        export APICLICSVExportpathbase=$CLIparm_exportpath
    else
        export APICLICSVExportpathbase=$APICLIpathbase
    fi
    
    export APICLICSVImportpathbase=
    if [ x"$script_use_import" = x"true" ] ; then
        if [ x"$CLIparm_importpath" != x"" ] ; then
            export APICLICSVImportpathbase=$CLIparm_importpath
        else
            export APICLICSVImportpathbase=./import.csv
        fi
    fi
    
    export APICLICSVDeletepathbase=
    if [ x"$script_use_delete" = x"true" ] ; then
        if [ x"$CLIparm_deletepath" != x"" ] ; then
            export APICLICSVDeletepathbase=$CLIparm_deletepath
        else
            export APICLICSVDeletepathbase=./delete.csv
        fi
    fi
    
    export APICLICSVcsvpath=
    if [ x"$script_use_csvfile" = x"true" ] ; then
        if [ x"$CLIparm_csvpath" != x"" ] ; then
            export APICLICSVcsvpath=$CLIparm_csvpath
        else
            export APICLICSVcsvpath=./domains.csv
        fi
    fi
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-10-27

# -------------------------------------------------------------------------------------------------
# ConfigureOtherCLIParameterValues - Configure other values based on CLI parameters
# -------------------------------------------------------------------------------------------------

ConfigureOtherCLIParameterValues () {

    # ---------------------------------------------------------
    # Setup other variables based on CLI parameters
    # ---------------------------------------------------------
    
#    export NoSystemObjects=false
    export NoSystemObjects=true
    
    export NoSystemObjectsValue=`echo "$CLIparm_NoSystemObjects" | tr '[:upper:]' '[:lower:]'`
    
#    if [ x"$NoSystemObjectsValue" = x"true" ] ; then
#        export NoSystemObjects=true
#    else
#        export NoSystemObjects=false
#    fi
    
    if [ x"$NoSystemObjectsValue" = x"false" ] ; then
        export NoSystemObjects=false
    else
        export NoSystemObjects=true
    fi
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# ConfigureSpecificCLIParameterValues - Configure Specific CLI Parameter Values
# -------------------------------------------------------------------------------------------------

ConfigureSpecificCLIParameterValues () {

    #
    # Configure Specific CLI Parameter Values
    #
    
    ConfigureOtherCLIParameterPaths

    ConfigureOtherCLIParameterValues

    return 0
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# END:  Specific Procedures
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations - CLI
# -------------------------------------------------------------------------------------------------

ConfigureCommonCLIParameterValues

ConfigureSpecificCLIParameterValues
    
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

# MODIFIED 2018-10-27 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if $UseR8XAPI ; then

    SetupLogin2MgmtCLI
    
    if [ ! -z "$CLIparm_domain" ] ; then
        # Handle domain parameter for login string
        if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            echo 'Command line parameter for domain set!  Domain = '$CLIparm_domain | tee -a -i $APICLIlogfilepath
        fi
        export domaintarget=$CLIparm_domain
    else
        if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            echo 'Command line parameter for domain NOT set!' | tee -a -i $APICLIlogfilepath
        fi
        export domaintarget=
    fi
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        echo "domaintarget = '$domaintarget' " | tee -a -i $APICLIlogfilepath
    fi
    
    Login2MgmtCLI
    LOGINEXITCODE=$?
    
    export LoggedIntoMgmtCli=false
    
    if [ "$LOGINEXITCODE" != "0" ] ; then
        exit $LOGINEXITCODE
    else
        export LoggedIntoMgmtCli=true
    fi

fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-10-27


# =================================================================================================
# END:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations - Other Path Values
# -------------------------------------------------------------------------------------------------

if [ "$script_dump_csv" = "true" ] ; then
    export APICLIdumppathcsv=$APICLICSVExportpathbase/csv
fi

if [ x"$script_dump_json" = x"true" ] ; then
    export APICLIdumppathjson=$APICLICSVExportpathbase/json
fi

if [ x"$script_dump_full" = x"true" ] ; then
    export APICLIdumppathjsonfull=$APICLIdumppathjson/full
fi

if [ x"$script_dump_standard" = x"true" ] ; then
    export APICLIdumppathjsonstandard=$APICLIdumppathjson/standard
fi


# =================================================================================================
# START:  Main operations
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Start executing Main operations
# -------------------------------------------------------------------------------------------------


export deletefile=$APICLIpathbase/sessions_to_delete_uid.$DATEDTGS.csv
export dumpfile=$APICLIpathbase/delete_session.$DATEDTGS.json


echo | tee -a -i $APICLIlogfilepath
echo 'Before session delete' | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

echo '.uid, .locks, .changes, .expired-session, username' >> $dumpfile
#mgmt_cli -s $APICLIsessionfile show sessions details-level full --format json | jq -r '.objects[] | (.uid + ", " + (.locks|tostring) + ", " + (.changes|tostring) + ", " + (."expired-session"|tostring) + ", " + ."user-name")' >> $dumpfile
mgmt_cli -s $APICLIsessionfile show sessions details-level full --format json | jq -r '.objects[] | select((."user-name"=="WEB_API")) | (.uid + ", " + (.locks|tostring) + ", " + (.changes|tostring) + ", " + (."expired-session"|tostring) + ", " + ."user-name")' >> $dumpfile
echo >> $dumpfile

cat $dumpfile | tee -a -i $APICLIlogfilepath

echo 'uid' > $deletefile

mgmt_cli -s $APICLIsessionfile show sessions limit 500 details-level full --format json | jq -r '.objects[] | select((.locks==0) and (.changes==0) and (."expired-session"==true) and (."user-name"=="WEB_API")) | [ .uid ] | @csv' >> $deletefile

mgmt_cli -s $APICLIsessionfile discard --batch $deletefile > $dumpfile

cat $dumpfile | tee -a -i $APICLIlogfilepath

echo | tee -a -i $APICLIlogfilepath
echo 'After session delete' | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

echo '.uid, .locks, .changes, .expired-session, username' > $dumpfile
#mgmt_cli -s $APICLIsessionfile show sessions details-level full --format json | jq -r '.objects[] | (.uid + ", " + (.locks|tostring) + ", " + (.changes|tostring) + ", " + (."expired-session"|tostring) + ", " + ."user-name")' >> $dumpfile
mgmt_cli -s $APICLIsessionfile show sessions details-level full --format json | jq -r '.objects[] | select((."user-name"=="WEB_API")) | (.uid + ", " + (.locks|tostring) + ", " + (.changes|tostring) + ", " + (."expired-session"|tostring) + ", " + ."user-name")' >> $dumpfile
echo >> $dumpfile

cat $dumpfile | tee -a -i $APICLIlogfilepath

echo | tee -a -i $APICLIlogfilepath


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
 
if $UseR8XAPI ; then
    HandleMgmtCLIPublish
fi

# -------------------------------------------------------------------------------------------------
# Logout from mgmt_cli, also cleanup session file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-10-27 -
 
if $UseR8XAPI ; then
    HandleMgmtCLILogout
fi

# -------------------------------------------------------------------------------------------------
# Clean-up and exit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo 'CLI Operations Completed' | tee -a -i $APICLIlogfilepath

if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
    # Verbose mode ON

    echo | tee -a -i $APICLIlogfilepath
    #echo "Files in >$apiclipathroot<" | tee -a -i $APICLIlogfilepath
    #ls -alh $apiclipathroot | tee -a -i $APICLIlogfilepath
    #echo | tee -a -i $APICLIlogfilepath

    if [ "$APICLIlogpathbase" != "$APICLIpathbase" ] ; then
        echo "Files in >$APICLIlogpathbase<" | tee -a -i $APICLIlogfilepath
        ls -alhR $APICLIpathbase | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi
    
    echo "Files in >$APICLIpathbase<" | tee -a -i $APICLIlogfilepath
    ls -alhR $APICLIpathbase | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
else
    # Verbose mode OFF

    echo >> $APICLIlogfilepath
    #echo "Files in >$apiclipathroot<" >> $APICLIlogfilepath
    #ls -alh $apiclipathroot >> $APICLIlogfilepath
    #echo >> $APICLIlogfilepath

    if [ "$APICLIlogpathbase" != "$APICLIpathbase" ] ; then
        echo "Files in >$APICLIlogpathbase<" >> $APICLIlogfilepath
        ls -alhR $APICLIpathbase >> $APICLIlogfilepath
        echo >> $APICLIlogfilepath
    fi
    
    echo "Files in >$APICLIpathbase<" >> $APICLIlogfilepath
    ls -alhR $APICLIpathbase >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
fi

echo | tee -a -i $APICLIlogfilepath
echo 'Results in directory : '"$APICLIpathbase" | tee -a -i $APICLIlogfilepath
echo 'Log output in file   : '"$APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-01-18


# =================================================================================================
# END:  Publish, Cleanup, and Dump output
# =================================================================================================
# =================================================================================================


