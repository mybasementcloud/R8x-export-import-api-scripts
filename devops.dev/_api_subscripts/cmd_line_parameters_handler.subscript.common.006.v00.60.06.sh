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
ScriptVersion=00.60.06
ScriptRevision=020
ScriptDate=2021-02-23
TemplateVersion=00.60.06
APISubscriptsLevel=006
APISubscriptsVersion=00.60.06
APISubscriptsRevision=020

#

export APISubscriptsScriptVersion=v${ScriptVersion}
export APISubscriptsScriptTemplateVersion=v${TemplateVersion}

export APISubscriptsScriptVersionX=v${ScriptVersion//./x}
export APISubscriptsScriptTemplateVersionX=v${TemplateVersion//./x}

APISubScriptName=cmd_line_parameters_handler.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}
export APISubScriptFileNameRoot=cmd_line_parameters_handler.subscript.common
export APISubScriptShortName=cmd_line_parameters_handler
export APISubScriptnohupName=${APISubScriptShortName}
export APISubScriptDescription="Subscript for CLI Operations for command line parameters handling"


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
    
    echo 'CLI Parameters :' >> ${subscriptstemplogfilepath}
    echo >> ${subscriptstemplogfilepath}
    
    echo >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'SHOWHELP' "${SHOWHELP}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'SCRIPTVERBOSE' "${SCRIPTVERBOSE}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'APISCRIPTVERBOSE' "${APISCRIPTVERBOSE}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'NOWAIT' "${NOWAIT}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOWAIT' "${CLIparm_NOWAIT}" >> ${subscriptstemplogfilepath}
    
    # ADDED 2021-02-06 -
    echo  >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOHUP' "${CLIparm_NOHUP}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOHUPScriptName' "${CLIparm_NOHUPScriptName}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOHUPDTG' "${CLIparm_NOHUPDTG}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NOHUPPATH' "${CLIparm_NOHUPPATH}" >> ${subscriptstemplogfilepath}
    
    #printf "%-40s = %s\n" 'X' "${X}" >> ${subscriptstemplogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_rootuser' "${CLIparm_rootuser}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_user' "${CLIparm_user}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_password' "${CLIparm_password}" >> ${subscriptstemplogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_api_key' "${CLIparm_api_key}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_use_api_key' "${CLIparm_use_api_key}" >> ${subscriptstemplogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_websslport' "${CLIparm_websslport}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_mgmt' "${CLIparm_mgmt}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_domain' "${CLIparm_domain}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_sessionidfile' "${CLIparm_sessionidfile}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_sessiontimeout' "${CLIparm_sessiontimeout}" >> ${subscriptstemplogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_logpath' "${CLIparm_logpath}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_outputpath' "${CLIparm_outputpath}" >> ${subscriptstemplogfilepath}
    
    echo >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NoSystemObjects' "${CLIparm_NoSystemObjects}" >> ${subscriptstemplogfilepath}
    
    # ADDED 2021-02-03 -
    echo >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CreatorIsNotSystem' "${CLIparm_CreatorIsNotSystem}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CreatorIsNotSystem' "${CreatorIsNotSystem}" >> ${subscriptstemplogfilepath}
    
    echo  >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CSVADDEXPERRHANDLE' "${CSVADDEXPERRHANDLE}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVADDEXPERRHANDLE' "${CLIparm_CSVADDEXPERRHANDLE}" >> ${subscriptstemplogfilepath}
    
    # ADDED 2021-02-03 -
    echo >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_TypeOfExport' "${CLIparm_TypeOfExport}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'TypeOfExport' "${TypeOfExport}" >> ${subscriptstemplogfilepath}
    
    echo >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_format' "${CLIparm_format}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_formatall' "${CLIparm_formatall}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_formatcsv' "${CLIparm_formatcsv}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_formatjson' "${CLIparm_formatjson}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_detailslevel' "${CLIparm_detailslevel}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_detailslevelall' "${CLIparm_detailslevelall}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_detailslevelfull' "${CLIparm_detailslevelfull}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_detailslevelstandard' "${CLIparm_detailslevelstandard}" >> ${subscriptstemplogfilepath}
    
    echo >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_UseDevOpsResults' "${CLIparm_UseDevOpsResults}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_resultspath' "${CLIparm_resultspath}" >> ${subscriptstemplogfilepath}
    
    # ADDED 2021-01-16 -
    
    echo  >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CSVEXPORT05TAGS' "${CSVEXPORT05TAGS}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORT05TAGS' "${CLIparm_CSVEXPORT05TAGS}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CSVEXPORT10TAGS' "${CSVEXPORT10TAGS}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORT10TAGS' "${CLIparm_CSVEXPORT10TAGS}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CSVEXPORTNOTAGS' "${CSVEXPORTNOTAGS}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORTNOTAGS' "${CLIparm_CSVEXPORTNOTAGS}" >> ${subscriptstemplogfilepath}
    
    echo  >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'KEEPCSVWIP' "${KEEPCSVWIP}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_KEEPCSVWIP' "${CLIparm_KEEPCSVWIP}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLEANUPCSVWIP' "${CLEANUPCSVWIP}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CLEANUPCSVWIP' "${CLIparm_CLEANUPCSVWIP}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'NODOMAINFOLDERS' "${NODOMAINFOLDERS}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_NODOMAINFOLDERS' "${CLIparm_NODOMAINFOLDERS}" >> ${subscriptstemplogfilepath}
    
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORTDATADOMAIN' "${CLIparm_CSVEXPORTDATADOMAIN}" >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'CLIparm_CSVEXPORTDATACREATOR' "${CLIparm_CSVEXPORTDATACREATOR}" >> ${subscriptstemplogfilepath}
    
    if ${script_use_export} ; then
        printf "%-40s = %s\n" 'CLIparm_exportpath' "${CLIparm_exportpath}" >> ${subscriptstemplogfilepath}
    fi
    if ${script_use_import} ; then
        printf "%-40s = %s\n" 'CLIparm_importpath' "${CLIparm_importpath}" >> ${subscriptstemplogfilepath}
    fi
    if ${script_use_delete} ; then
        printf "%-40s = %s\n" 'CLIparm_deletepath' "${CLIparm_deletepath}" >> ${subscriptstemplogfilepath}
    fi
    if ${script_use_csvfile} ; then
        printf "%-40s = %s\n" 'CLIparm_csvpath' "${CLIparm_csvpath}" >> ${subscriptstemplogfilepath}
    fi
    
    echo >> ${subscriptstemplogfilepath}
    printf "%-40s = %s\n" 'remains' "${REMAINS}" >> ${subscriptstemplogfilepath}
    
#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-06
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


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


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
    echo -n $0' [-?][-v][--NOWAIT]'
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
    
    # Finish the line started above!
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


