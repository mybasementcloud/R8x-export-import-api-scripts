#
# SCRIPTS Common operations
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



\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


# Configure basic information for formation of file path for command line parameter handler script
#
# cli_api_cmdlineparm_handler_root - root path to command line parameter handler script. Period (".") indicates root of script source folder
# cli_api_cmdlineparm_handler_folder - folder for under root path to command line parameter handler script
# cli_api_cmdlineparm_handler_file - filename, without path, for command line parameter handler script
#
export cli_api_cmdlineparm_handler_root=.
export cli_api_cmdlineparm_handler_folder=common
export cli_api_cmdlineparm_handler_file=cmd_line_parameters_handler.action.common.$CommonScriptsRevision.v$CommonScriptsVersion.sh


\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


# =================================================================================================
# =================================================================================================
# START:  Command Line Parameter Handling and Help
# =================================================================================================

# MODIFIED 2019-01-17 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-01-17


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


\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

