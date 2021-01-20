#!/bin/bash
#
# SCRIPT subscript for CLI Operations for command line parameters handling
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
ScriptVersion=00.60.01
ScriptRevision=020
ScriptDate=2021-01-19
TemplateVersion=00.60.01
APISubscriptsVersion=00.60.01
APISubscriptsRevision=006

#

export APISubscriptsScriptVersion=v${ScriptVersion}
export APISubscriptsScriptTemplateVersion=v${TemplateVersion}

export APISubscriptsScriptVersionX=v${ScriptVersion//./x}
export APISubscriptsScriptTemplateVersionX=v${TemplateVersion//./x}

APISubScriptName=cmd_line_parameters_handler.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}
export APISubScriptFileNameRoot=cmd_line_parameters_handler.subscript.common
export APISubScriptShortName=cmd_line_parameters_handler
export APISubScriptnohupName=${APISubScriptShortName}
export APISubScriptDescription="subscript for CLI Operations for command line parameters handling"


# =================================================================================================
# =================================================================================================
# START subscript:  handle command line parameters
# =================================================================================================


if ${SCRIPTVERBOSE} ; then
    echo | tee -a -i ${logfilepath}
    echo 'APISubScriptName:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} | tee -a -i ${logfilepath}
else
    echo >> ${logfilepath}
    echo 'APISubScriptName:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} >> ${logfilepath}
fi


# =================================================================================================
# Validate Common Subscripts  Script version is correct for caller
# =================================================================================================


# MODIFIED 2020-11-17 -

if [ x"${APIExpectedAPISubscriptsVersion}" = x"${APISubscriptsScriptVersion}" ] ; then
    # Script and Common Subscripts Script versions match, go ahead
    echo >> ${logfilepath}
    echo 'Verify Common Subscripts Scripts Version - OK' >> ${logfilepath}
    echo >> ${logfilepath}
else
    # Script and Subscripts Script versions don't match, ALL STOP!
    echo | tee -a -i ${logfilepath}
    echo 'Raw Script name        : '$0 | tee -a -i ${logfilepath}
    echo 'Subscript version name : '${APISubscriptsScriptVersion}' '${APISubScriptName} | tee -a -i ${logfilepath}
    echo 'Calling Script version : '${APIScriptVersion} | tee -a -i ${logfilepath}
    echo 'Verify Common Subscripts Scripts Version - Missmatch' | tee -a -i ${logfilepath}
    echo 'Expected Common Subscripts Script version : '${APIExpectedAPISubscriptsVersion} | tee -a -i ${logfilepath}
    echo 'Current  Common Subscripts Script version : '${APISubscriptsScriptVersion} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    exit 250
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# START:  Local Variables
# =================================================================================================


export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log


# =================================================================================================
# START Procedures:  Local Proceedures - 
# =================================================================================================


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
        export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log
    else
        # explicit name passed for action
        export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'$1'_'${DATEDTGS}.log
    fi
    
    if [ -w ${subscriptstemplogfilepath} ] ; then
        rm ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
    fi
    
    touch ${subscriptstemplogfilepath}
    
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
        cat ${subscriptstemplogfilepath} | tee -a -i ${logfilepath}
    else
        # NOT verbose mode so push logged results to normal log file
        cat ${subscriptstemplogfilepath} >> ${logfilepath}
    fi
    
    rm ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
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
    
    cat ${subscriptstemplogfilepath} | tee -a -i ${logfilepath}
    
    rm ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckAPIScriptVerboseOutput - Check if verbose output is configured externally
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CheckAPIScriptVerboseOutput - Check if verbose output is configured externally via shell level 
# parameter setting, if it is, the check it for correct and valid values; otherwise, if set, then
# reset to false because wrong.
#

CheckAPIScriptVerboseOutput () {

    if [ -z ${SCRIPTVERBOSE} ] ; then
        # Verbose mode not set from shell level
        echo "!! Verbose mode not set from shell level" >> ${logfilepath}
        export APISCRIPTVERBOSE=false
        echo >> ${logfilepath}
    elif [ x"`echo "${SCRIPTVERBOSE}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
        # Verbose mode set OFF from shell level
        echo "!! Verbose mode set OFF from shell level" >> ${logfilepath}
        export APISCRIPTVERBOSE=false
        echo >> ${logfilepath}
    elif [ x"`echo "${SCRIPTVERBOSE}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
        # Verbose mode set ON from shell level
        echo "!! Verbose mode set ON from shell level" >> ${logfilepath}
        export APISCRIPTVERBOSE=true
        echo >> ${logfilepath}
        echo 'Script :  '$0 >> ${logfilepath}
        echo 'Verbose mode enabled' >> ${logfilepath}
        echo >> ${logfilepath}
    elif [ "${SCRIPTVERBOSE}" = "true" ] ; then
        # Verbose mode set ON
        export APISCRIPTVERBOSE=true
        echo >> ${logfilepath}
        echo 'Script :  '$0 >> ${logfilepath}
        echo 'Verbose mode enabled' >> ${logfilepath}
        echo >> ${logfilepath}
    elif [ "${SCRIPTVERBOSE}" = "true" ] ; then
        # Verbose mode set ON
        export APISCRIPTVERBOSE=true
        echo >> ${logfilepath}
        echo 'Script :  '$0 >> ${logfilepath}
        echo 'Verbose mode enabled' >> ${logfilepath}
        echo >> ${logfilepath}
    elif [ x"${SCRIPTVERBOSE}" = x"true" ] ; then
        # Verbose mode set ON
        export APISCRIPTVERBOSE=true
        echo >> ${logfilepath}
        echo 'Script :  '$0 >> ${logfilepath}
        echo 'Verbose mode enabled' >> ${logfilepath}
        echo >> ${logfilepath}
    else
        # Verbose mode set to wrong value from shell level
        echo "!! Verbose mode set to wrong value from shell level >"${SCRIPTVERBOSE}"<" >> ${logfilepath}
        echo "!! Settting Verbose mode OFF, pending command line parameter checking!" >> ${logfilepath}
        export APISCRIPTVERBOSE=false
        export SCRIPTVERBOSE=false
        echo >> ${logfilepath}
    fi
    
    export APISCRIPTVERBOSECHECK=true
    
    echo >> ${logfilepath}
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END Procedures:  Local Proceedures
# =================================================================================================


# MODIFIED 2019-01-18 -
# Command Line Parameter Handling Action Script should only do this if we didn't do it in the calling script

if ${APISCRIPTVERBOSECHECK} ; then
    # Already checked status of ${APISCRIPTVERBOSE}
    echo "Status of verbose output at start of command line handler: ${APISCRIPTVERBOSE}" >> ${templogfilepath}
else
    # Need to check status of ${APISCRIPTVERBOSE}
    
    CheckAPIScriptVerboseOutput
    
    echo "Status of verbose output at start of command line handler: ${APISCRIPTVERBOSE}" >> ${templogfilepath}
fi


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START Procedures :  command line parameter processing proceedures
# -------------------------------------------------------------------------------------------------


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


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# START:  Common Help display proceedure
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


# -------------------------------------------------------------------------------------------------
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
# END Procedure:  Process command line parameters for enabling verbose output
# -------------------------------------------------------------------------------------------------

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


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
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END Procedures :  command line parameter processing proceedures
# -------------------------------------------------------------------------------------------------
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


#echo 'Process Command Line Parameter Verbose Enabled' >> ${templogfilepath}
ProcessCommandLIneParameterVerboseEnable "$@"

#echo 'Process Command Line Parameters and Set Values' >> ${templogfilepath}
ProcessCommandLineParametersAndSetValues "$@"

dumpcliparmparseresults "$@"


# -------------------------------------------------------------------------------------------------
# Handle request for help (common) and exit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Was help requested, if so show it and return
#
if ${SHOWHELP} ; then
    # Show Help
    doshowhelp "$@"
    echo
    
    # don't want a log file for showing help
    #rm ${logfilepath}
    
    # this is done now, so exit hard
    exit 255 
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-19

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Command Line Parameter Handling and Help
# =================================================================================================


if ${APISCRIPTVERBOSE} ; then
    echo | tee -a -i ${logfilepath}
    echo 'API Subscript Completed :  '${APISubScriptName} | tee -a -i ${logfilepath}
else
    echo >> ${logfilepath}
    echo 'API Subscript Completed :  '${APISubScriptName} >> ${logfilepath}
fi


return 0


# =================================================================================================
# END subscript:  handle command line parameters
# =================================================================================================
# =================================================================================================


