#!/bin/bash
#
# SCRIPT Template for CLI Operations for command line parameters handling
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
ScriptVersion=00.40.00
ScriptRevision=000
ScriptDate=2020-02-07
TemplateVersion=00.40.00
CommonScriptsVersion=00.40.00
CommonScriptsRevision=006

#

export APICommonActionsScriptVersion=v${ScriptVersion//./x}
export APICommonActionScriptTemplateVersion=v${TemplateVersion//./x}
ActionScriptName=cmd_line_parameters_handler.action.common.$CommonScriptsRevision.v$ScriptVersion

# =================================================================================================
# Validate Common Actions Script version is correct for caller
# =================================================================================================


if [ x"$APIExpectedCommonScriptsVersion" = x"$APICommonActionsScriptVersion" ] ; then
    # Script and Common Actions Script versions match, go ahead
    echo >> $APICLIlogfilepath
    echo 'Verify Common Actions Scripts Version - OK' >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Common Actions Scripts Version - Missmatch' | tee -a -i $APICLIlogfilepath
    echo 'Expected Common Script version : '$APIExpectedCommonScriptsVersion | tee -a -i $APICLIlogfilepath
    echo 'Current  Common Script version : '$APICommonActionsScriptVersion | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 250
fi


# =================================================================================================
# =================================================================================================
# START action script:  handle command line parameters
# =================================================================================================


if [ "$APISCRIPTVERBOSE" = "true" ] ; then
    echo | tee -a -i $APICLIlogfilepath
    echo 'ActionScriptName:  '$ActionScriptName'  Script Version: '$ScriptVersion'  Revision:  '$ScriptRevision | tee -a -i $APICLIlogfilepath
else
    echo >> $APICLIlogfilepath
    echo 'ActionScriptName:  '$ActionScriptName'  Script Version: '$ScriptVersion'  Revision:  '$ScriptRevision >> $APICLIlogfilepath
fi


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# START:  Local Variables
# =================================================================================================


export APICLIActionstemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log


# =================================================================================================
# START:  Local Proceedures
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #

    export APICLIActionstemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log

    rm $APICLIActionstemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath

    touch $APICLIActionstemplogfilepath

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
        cat $APICLIActionstemplogfilepath | tee -a -i $APICLIlogfilepath
    else
        # NOT verbose mode so push logged results to normal log file
        cat $APICLIActionstemplogfilepath >> $APICLIlogfilepath
    fi
    
    rm $APICLIActionstemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath
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

    cat $APICLIActionstemplogfilepath | tee -a -i $APICLIlogfilepath
    
    rm $APICLIActionstemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath

    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckAPIScriptVerboseOutput - Check if verbose output is configured externally
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18-01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18-01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Local Proceedures
# =================================================================================================


# MODIFIED 2019-01-18 -
# Command Line Parameter Handling Action Script should only do this if we didn't do it in the calling script

if [ x"$APISCRIPTVERBOSECHECK" = x"true" ] ; then
    # Already checked status of $APISCRIPTVERBOSE
    echo "Status of verbose output at start of command line handler: $APISCRIPTVERBOSE" >> $APICLItemplogfilepath
else
    # Need to check status of $APISCRIPTVERBOSE

    CheckAPIScriptVerboseOutput

    echo "Status of verbose output at start of command line handler: $APISCRIPTVERBOSE" >> $APICLItemplogfilepath
fi


# =================================================================================================
# =================================================================================================
# START:  Command Line Parameter Handling and Help
# =================================================================================================

# MODIFIED 2019-05-31 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
export CLIparm_mgmt=
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-05-31


# -------------------------------------------------------------------------------------------------
# dumpcliparmparseresults
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-05-31 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumpcliparmparseresults () {
    #
	#
	# Testing - Dump aquired values
	#

    workoutputfile=/var/tmp/workoutputfile.1.$DATEDTGS.txt
    echo > $workoutputfile

    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #                                    1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #                          01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo 'CLI Parameters :' >> $workoutputfile
    echo >> $workoutputfile

    if $UseR8XAPI ; then
        
        echo 'CLIparm_rootuser        = '$CLIparm_rootuser >> $workoutputfile
        echo 'CLIparm_user            = '$CLIparm_user >> $workoutputfile
        echo 'CLIparm_password        = '$CLIparm_password >> $workoutputfile
        
        echo 'CLIparm_websslport      = '$CLIparm_websslport >> $workoutputfile
        echo 'CLIparm_mgmt            = '$CLIparm_mgmt >> $workoutputfile
        echo 'CLIparm_domain          = '$CLIparm_domain >> $workoutputfile
        echo 'CLIparm_sessionidfile   = '$CLIparm_sessionidfile >> $workoutputfile
        echo 'CLIparm_sessiontimeout  = '$CLIparm_sessiontimeout >> $workoutputfile
        
    fi

    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo 'CLIparm_logpath         = '$CLIparm_logpath >> $workoutputfile
    echo 'CLIparm_outputpath      = '$CLIparm_outputpath >> $workoutputfile
    
    echo >> $workoutputfile
    echo 'SHOWHELP                ='$SHOWHELP >> $workoutputfile
    echo 'APISCRIPTVERBOSE        ='$APISCRIPTVERBOSE >> $workoutputfile
    echo 'NOWAIT                  ='$NOWAIT >> $workoutputfile
    echo 'CLIparm_NOWAIT          ='$CLIparm_NOWAIT >> $workoutputfile

    echo >> $workoutputfile
    if [ x"$script_use_export" = x"true" ] ; then
        echo 'CLIparm_exportpath      ='$CLIparm_exportpath >> $workoutputfile
    fi
    if [ x"$script_use_import" = x"true" ] ; then
        echo 'CLIparm_importpath      ='$CLIparm_importpath >> $workoutputfile
    fi
    if [ x"$script_use_delete" = x"true" ] ; then
        echo 'CLIparm_deletepath      ='$CLIparm_deletepath >> $workoutputfile
    fi
    if [ x"$script_use_csvfile" = x"true" ] ; then
        echo 'CLIparm_csvpath         ='$CLIparm_csvpath >> $workoutputfile
    fi
    
    echo 'CLIparm_NoSystemObjects ='$CLIparm_NoSystemObjects >> $workoutputfile
	
    echo  >> $workoutputfile
    echo 'CLEANUPWIP              ='$CLEANUPWIP >> $workoutputfile
    echo 'NODOMAINFOLDERS         ='$NODOMAINFOLDERS >> $workoutputfile
    echo 'CSVEXPORTADDIGNOREERR   ='$CSVEXPORTADDIGNOREERR >> $workoutputfile

    if $UseR8XAPI ; then
        echo 'CLIparm_CLEANUPWIP      ='$CLIparm_CLEANUPWIP >> $workoutputfile
        echo 'CLIparm_NODOMAINFOLDERS ='$CLIparm_NODOMAINFOLDERS >> $workoutputfile
        echo 'C_CSVEXPORTADDIGNOREERR ='$CLIparm_CSVEXPORTADDIGNOREERR >> $workoutputfile
    fi

    echo >> $workoutputfile
    echo 'remains                 ='$REMAINS >> $workoutputfile
    
	if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
	    # Verbose mode ON
	    
	    echo | tee -a -i $APICLIlogfilepath
	    cat $workoutputfile | tee -a -i $APICLIlogfilepath
	    echo | tee -a -i $APICLIlogfilepath
        echo "Number parms $#" | tee -a -i $APICLIlogfilepath
        echo "parms raw : \> $@ \<" | tee -a -i $APICLIlogfilepath

        parmnum=0
        for k ; do
            echo -e "$parmnum \t ${k}" | tee -a -i $APICLIlogfilepath
            parmnum=`expr $parmnum + 1`
        done

        echo | tee -a -i $APICLIlogfilepath
    else
	    # Verbose mode ON
	    
	    echo >> $APICLIlogfilepath
	    cat $workoutputfile >> $APICLIlogfilepath
	    echo >> $APICLIlogfilepath
        echo "Number parms $#" >> $APICLIlogfilepath
        echo "parms raw : \> $@ \<" >> $APICLIlogfilepath

        parmnum=0
        for k ; do
            echo -e "$parmnum \t ${k}" >> $APICLIlogfilepath
            parmnum=`expr $parmnum + 1`
        done

        echo >> $APICLIlogfilepath
	fi

}


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-05-31


# -------------------------------------------------------------------------------------------------
# dumprawcliparms
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-05-31 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumprawcliparms () {
    #
	if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
	    # Verbose mode ON
	    
        echo | tee -a -i $APICLIlogfilepath
        echo "Command line parameters before : " | tee -a -i $APICLIlogfilepath
        echo "Number parms $#" | tee -a -i $APICLIlogfilepath
        echo "parms raw : \> $@ \<" | tee -a -i $APICLIlogfilepath

        parmnum=0
        for k ; do
            echo -e "$parmnum \t ${k}" | tee -a -i $APICLIlogfilepath
            parmnum=`expr $parmnum + 1`
        done

        echo | tee -a -i $APICLIlogfilepath

    else
	    # Verbose mode ON
	    
        echo >> $APICLIlogfilepath
        echo "Command line parameters before : " >> $APICLIlogfilepath
        echo "Number parms $#" >> $APICLIlogfilepath
        echo "parms raw : \> $@ \<" >> $APICLIlogfilepath

        parmnum=0
        for k ; do
            echo -e "$parmnum \t ${k}" >> $APICLIlogfilepath
            parmnum=`expr $parmnum + 1`
        done

        echo >> $APICLIlogfilepath

	fi

}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-05-31


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START:  Common Help display proceedure
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Help display proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-05-31 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    if $UseR8XAPI ; then
        echo -n '|[-r]|[-u <admin_name>]|[-p <password>]]|[-P <web ssl port>]'
        echo -n '|[-m <server_IP>]'
        echo -n '|[-d <domain>]'
        echo -n '|[-s <session_file_filepath>]|[--session-timeout <session_time_out>]'
    fi
    echo -n '|[-l <log_path>]'
    echo -n '|[-o <output_path>]'

    if [ x"$script_use_export" = x"true" ] ; then
        echo -n '|[-x <export_path>]'
    fi
    if [ x"$script_use_import" = x"true" ] ; then
        echo -n '|[-i <import_path>]'
    fi
    if [ x"$script_use_delete" = x"true" ] ; then
        echo -n '|[-k <delete_path>]'
    fi
    if [ x"$script_use_csvfile" = x"true" ] ; then
        echo -n '|[-c <csv_path>]'
    fi
    echo -n '|[--SO|--NSO]'

    echo

    echo
    echo ' Script Version:  '$ScriptVersion'  Date:  '$ScriptDate
    echo
    echo ' Standard Command Line Parameters: '
    echo
    echo '  Show Help                  -? | --help'
    echo '  Verbose mode               -v | --verbose'
    echo

    if $UseR8XAPI ; then

        echo '  Authenticate as root       -r | --root'
        echo '  Set Console User Name      -u <admin_name> | --user <admin_name> |'
        echo '                             -u=<admin_name> | --user=<admin_name>'
        echo '  Set Console User password  -p <password> | --password <password> |'
        echo '                             -p=<password> | --password=<password>'
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

    fi

    echo '  Set log file path          -l <log_path> | --log-path <log_path> |'
    echo '                             -l=<log_path> | --log-path=<log_path>'
    echo '  Set output file path       -o <output_path> | --output <output_path> |'
    echo '                             -o=<output_path> | --output=<output_path>'
    echo
    echo '  No waiting in verbose mode --NOWAIT'
    echo

    if [ x"$script_use_export" = x"true" ] ; then
        echo '  Set export file path       -x <export_path> | --export <export_path> |'
        echo '                             -x=<export_path> | --export=<export_path>'
    fi
    if [ x"$script_use_import" = x"true" ] ; then
        echo '  Set import file path       -i <import_path> | --import-path <import_path> |'
        echo '                             -i=<import_path> | --import-path=<import_path>'
    fi
    if [ x"$script_use_delete" = x"true" ] ; then
        echo '  Set delete file path       -k <delete_path> | --delete-path <delete_path> |'
        echo '                             -k=<delete_path> | --delete-path=<delete_path>'
    fi
    if [ x"$script_use_csvfile" = x"true" ] ; then
        echo '  Set csv file path          -c <csv_path> | --csv <csv_path |'
        echo '                             -c=<csv_path> | --csv=<csv_path>'
    fi
    if $UseR8XAPI ; then
        echo
        echo '  NO System Objects Export   --NSO | --no-system-objects  {default mode}'
        echo '  Export System Objects      --SO | --system-objects'
        echo '  Remove WIP folders after   --CLEANUPWIP'
        echo '  No domain name in folders  --NODOMAINFOLDERS'
        echo '  CSV export add err handler --CSVEXPORTADDIGNOREERR'
        echo
    fi

    if $UseR8XAPI ; then
        echo '  session_file_filepath = fully qualified file path for session file'
    fi
    echo '  log_path = fully qualified folder path for log files'
    echo '  output_path = fully qualified folder path for output files'

    if [ x"$script_use_export" = x"true" ] ; then
        echo '  export_path = fully qualified folder path for export file'
    fi
    if [ x"$script_use_import" = x"true" ] ; then
        echo '  import_path = fully qualified folder path for import files'
    fi
    if [ x"$script_use_delete" = x"true" ] ; then
        echo '  delete_path = fully qualified folder path for delete files'
    fi
    if [ x"$script_use_csvfile" = x"true" ] ; then
        echo '  csv_path = fully qualified file path for csv file'
    fi

    if $UseR8XAPI ; then
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
    fi
    echo

    echo ' Example: General :'
    echo
    if $UseR8XAPI ; then
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump"'
        echo
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -d Global --SO -s "/var/tmp/id.txt"'
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -d "System Data" --NSO -s "/var/tmp/id.txt"'
        echo
    
    
        if [ x"$script_use_export" = x"true" ] ; then
            echo ' Example: Export:'
            echo
            echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export"'
            echo
        fi
    
        if [ x"$script_use_import" = x"true" ] ; then
            echo ' Example: Import:'
            echo
            echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -i "/var/tmp/import"'
            echo
        fi
        
        if [ x"$script_use_delete" = x"true" ] ; then
            echo ' Example: Delete:'
            echo
            echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export" -k "/var/tmp/delete"'
            echo
        fi
    else
        echo ' ]# '$ScriptName' -l "/var/tmp/script_dump"'
        echo
    
        if [ x"$script_use_export" = x"true" ] ; then
            echo ' Example: Export:'
            echo
            echo ' ]# '$ScriptName' -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export"'
            echo
        fi
    
        if [ x"$script_use_import" = x"true" ] ; then
            echo ' Example: Import:'
            echo
            echo ' ]# '$ScriptName' -l "/var/tmp/script_dump" -i "/var/tmp/import"'
            echo
        fi
        
        if [ x"$script_use_delete" = x"true" ] ; then
            echo ' Example: Delete:'
            echo
            echo ' ]# '$ScriptName' -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export" -k "/var/tmp/delete"'
            echo
        fi
    fi
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo
    return 1
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-05-31


# -------------------------------------------------------------------------------------------------
# END:  Common Help display proceedure
# -------------------------------------------------------------------------------------------------
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Process command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-05-31 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

rawcliparmdump=false
if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
    # Verbose mode ON
    dumprawcliparms "$@"
    rawcliparmdump=true
fi

while [ -n "$1" ]; do
    # Copy so we can modify it (can't modify $1)
    OPT="$1"

    # testing
    #echo 'OPT = '$OPT
    #

    # Detect argument termination
    if [ x"$OPT" = x"--" ]; then
        # testing
        # echo "Argument termination"
        #
        
        shift
        for OPT ; do
            # MODIFIED 2019-03-08
            #REMAINS="$REMAINS \"$OPT\""
            REMAINS="$REMAINS $OPT"
        done
        break
    fi

    # Parse current opt
    while [ x"$OPT" != x"-" ] ; do
        case "$OPT" in
            # Help and Standard Operations
            '-?' | --help )
                SHOWHELP=true
                ;;
            '-v' | --verbose )
                export APISCRIPTVERBOSE=true
                if ! $rawcliparmdump; then
                    dumprawcliparms "$@"
                    rawcliparmdump=true
                fi
                ;;
            --NOWAIT )
                CLIparm_NOWAIT=true
                export NOWAIT=true
                ;;
            # Handle immediate opts like this
            -r | --root )
                CLIparm_rootuser=true
                ;;
#           -f | --force )
#               FORCE=true
#               ;;
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
            --CSVEXPORTADDIGNOREERR )
                CLIparm_CSVEXPORTADDIGNOREERR=true
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
            -x=* | --export=* )
                CLIparm_exportpath="${OPT#*=}"
                #shift
                ;;
            -o=* | --output=* )
                CLIparm_outputpath="${OPT#*=}"
                #shift
                ;;
            -i=* | --import-path=* )
                CLIparm_importpath="${OPT#*=}"
                #shift
                ;;
            -k=* | --delete-path=* )
                CLIparm_deletepath="${OPT#*=}"
                #shift
                ;;
            -c=* | --csv=* )
                CLIparm_csvpath="${OPT#*=}"
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
            -x* | --export )
                CLIparm_exportpath="$2"
                shift
                ;;
            -i* | --import-path )
                CLIparm_importpath="$2"
                shift
                ;;
            -k* | --delete-path )
                CLIparm_deletepath="$2"
                shift
                ;;
            -c* | --csv )
                CLIparm_csvpath="$2"
                shift
                ;;
            # Anything unknown is recorded for later
            * )
                # MODIFIED 2019-05-31
                #REMAINS="$REMAINS \"$OPT\""
                REMAINS="$REMAINS $OPT"
                break
                ;;
        esac
        # Check for multiple short options
        # NOTICE: be sure to update this pattern to match valid options
        # Remove any characters matching "-", and then the values between []'s
        #NEXTOPT="${OPT#-[upmdsor?]}" # try removing single short opt
        NEXTOPT="${OPT#-[vrf?]}" # try removing single short opt
        if [ x"$OPT" != x"$NEXTOPT" ] ; then
            OPT="-$NEXTOPT"  # multiple short opts, keep going
        else
            break  # long form, exit inner loop
        fi
    done
    # Done with that param. move to next
    shift
done
# Set the non-parameters back into the positional parameters ($1 $2 ..)
eval set -- $REMAINS

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-05-31

# MODIFIED 2019-05-31 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export SHOWHELP=$SHOWHELP
export CLIparm_websslport=$CLIparm_websslport
export CLIparm_rootuser=$CLIparm_rootuser
export CLIparm_user=$CLIparm_user
export CLIparm_password=$CLIparm_password
export CLIparm_mgmt=$CLIparm_mgmt
export CLIparm_domain=$CLIparm_domain
export CLIparm_sessionidfile=$CLIparm_sessionidfile
export CLIparm_sessiontimeout=$CLIparm_sessiontimeout
export CLIparm_logpath=$CLIparm_logpath

export CLIparm_outputpath=$CLIparm_outputpath

export NOWAIT=`echo "$CLIparm_NOWAIT" | tr '[:upper:]' '[:lower:]'`
export CLIparm_NOWAIT=$CLIparm_NOWAIT

export CLIparm_exportpath=$CLIparm_exportpath
export CLIparm_importpath=$CLIparm_importpath
export CLIparm_deletepath=$CLIparm_deletepath

export CLIparm_csvpath=$CLIparm_csvpath

export CLIparm_NoSystemObjects=`echo "$CLIparm_NoSystemObjects" | tr '[:upper:]' '[:lower:]'`

# ADDED 2018-05-03-2 -
export CLIparm_CLEANUPWIP=`echo "$CLIparm_CLEANUPWIP" | tr '[:upper:]' '[:lower:]'`
export CLIparm_NODOMAINFOLDERS=`echo "$CLIparm_NODOMAINFOLDERS" | tr '[:upper:]' '[:lower:]'`
export CLIparm_CSVEXPORTADDIGNOREERR=`echo "$CLIparm_CSVEXPORTADDIGNOREERR" | tr '[:upper:]' '[:lower:]'`

export REMAINS=$REMAINS

dumpcliparmparseresults "$@"

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-05-31

# -------------------------------------------------------------------------------------------------
# Handle request for help (common) and exit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Was help requested, if so show it and return
#
if [ x"$SHOWHELP" = x"true" ] ; then
    # Show Help
    doshowhelp "$@"
    return 255 
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# =================================================================================================
# END:  Command Line Parameter Handling and Help
# =================================================================================================
# =================================================================================================


# =================================================================================================
# END:  
# =================================================================================================
# =================================================================================================


