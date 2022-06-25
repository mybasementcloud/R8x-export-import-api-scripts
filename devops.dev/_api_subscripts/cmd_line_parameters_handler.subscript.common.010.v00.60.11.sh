#!/bin/bash
#
# (C) 2016-2022 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
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
# -#- Start Making Changes Here -#- 
#
# SCRIPT subscript for CLI Operations for command line parameters handling
#
#
ScriptVersion=00.60.11
ScriptRevision=000
ScriptSubRevision=030
ScriptDate=2022-06-24
TemplateVersion=00.60.11
APISubscriptsLevel=010
APISubscriptsVersion=00.60.11
APISubscriptsRevision=000

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
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'APISubScriptName:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'APISubScriptName:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} >> ${logfilepath}
fi


# =================================================================================================
# Validate Common Subscripts  Script version is correct for caller
# =================================================================================================


# MODIFIED 2021-10-21 -

if [ x"${APIExpectedAPISubscriptsVersion}" = x"${APISubscriptsScriptVersion}" ] ; then
    # Script and Common Subscripts Script versions match, go ahead
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Verify Common Subscripts Scripts Version - OK' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
else
    # Script and Subscripts Script versions don't match, ALL STOP!
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Raw Script name        : '$0 | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Subscript version name : '${APISubscriptsScriptVersion}' '${APISubScriptName} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Calling Script version : '${APIScriptVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Verify Common Subscripts Scripts Version - Missmatch' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Expected Common Subscripts Script version : '${APIExpectedAPISubscriptsVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Current  Common Subscripts Script version : '${APISubscriptsScriptVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 250
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# Single Line entries
#printf 'variable :  %-25s = %s\n' "x" ${x} >> ${logfilepath}
#printf "%-35s$ : %s\n" "x" 'x' >> ${logfilepath}
# Two Line entries
#printf "%s\n" "x" >> ${logfilepath}
#printf "%-35s :: %s\n" " " 'x' >> ${logfilepath}


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

# MODIFIED 2022-04-22 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CheckAPIScriptVerboseOutput - Check if verbose output is configured externally via shell level 
# parameter setting, if it is, the check it for correct and valid values; otherwise, if set, then
# reset to false because wrong.
#

CheckAPIScriptVerboseOutput () {
    
    if [ -z ${SCRIPTVERBOSE} ] ; then
        # Verbose mode not set from shell level
        echo `${dtzs}`${dtzsep} "!! Verbose mode not set from shell level" >> ${logfilepath}
        export SCRIPTVERBOSE=false
        export APISCRIPTVERBOSE=false
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    elif [ x"`echo "${SCRIPTVERBOSE}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
        # Verbose mode set OFF from shell level
        echo `${dtzs}`${dtzsep} "!! Verbose mode set OFF from shell level" >> ${logfilepath}
        export SCRIPTVERBOSE=false
        export APISCRIPTVERBOSE=false
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    elif [ x"`echo "${SCRIPTVERBOSE}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
        # Verbose mode set ON from shell level
        echo `${dtzs}`${dtzsep} "!! Verbose mode set ON from shell level" >> ${logfilepath}
        export SCRIPTVERBOSE=true
        export APISCRIPTVERBOSE=true
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Script :  '$0 >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Verbose mode enabled' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    elif ${SCRIPTVERBOSE} ; then
        # Verbose mode set ON
        export APISCRIPTVERBOSE=true
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Script :  '$0 >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Verbose mode enabled' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    else
        # Verbose mode set to wrong value from shell level
        echo `${dtzs}`${dtzsep} "!! Verbose mode set to wrong value from shell level >"${SCRIPTVERBOSE}"<" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "!! Settting Verbose mode OFF, pending command line parameter checking!" >> ${logfilepath}
        export SCRIPTVERBOSE=false
        export APISCRIPTVERBOSE=false
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    export APISCRIPTVERBOSECHECK=true
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-04-22


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END Procedures:  Local Proceedures
# =================================================================================================


# MODIFIED 2019-01-18 -
# Command Line Parameter Handling Action Script should only do this if we didn't do it in the calling script

if ${APISCRIPTVERBOSECHECK} ; then
    # Already checked status of ${APISCRIPTVERBOSE}
    echo `${dtzs}`${dtzsep} "Status of verbose output at start of command line handler: ${APISCRIPTVERBOSE}" >> ${templogfilepath}
else
    # Need to check status of ${APISCRIPTVERBOSE}
    
    CheckAPIScriptVerboseOutput
    
    echo `${dtzs}`${dtzsep} "Status of verbose output at start of command line handler: ${APISCRIPTVERBOSE}" >> ${templogfilepath}
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


# MODIFIED 2021-11-09 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumpcliparmparseresults () {
    #
    #
    # Testing - Dump aquired values
    #
    
    SetupTempLogFile
    
    dumpcliparmslogfilepath=${subscriptstemplogfilepath}
    
    # MODIFIED 2022-03-10 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'X' "${X}" >> ${dumpcliparmslogfilepath}
    #
    
    echo `${dtzs}`${dtzsep} 'CLI Parameters :' >> ${dumpcliparmslogfilepath}
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'SHOWHELP' "${SHOWHELP}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'SCRIPTVERBOSE' "${SCRIPTVERBOSE}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APISCRIPTVERBOSE' "${APISCRIPTVERBOSE}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'NOWAIT' "${NOWAIT}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_NOWAIT' "${CLIparm_NOWAIT}" >> ${dumpcliparmslogfilepath}
    
    # ADDED 2021-02-06 -
    echo `${dtzs}`${dtzsep}  >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_NOHUP' "${CLIparm_NOHUP}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_NOHUPScriptName' "${CLIparm_NOHUPScriptName}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_NOHUPDTG' "${CLIparm_NOHUPDTG}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_NOHUPPATH' "${CLIparm_NOHUPPATH}" >> ${dumpcliparmslogfilepath}
    
    #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'X' "${X}" >> ${dumpcliparmslogfilepath}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_rootuser' "${CLIparm_rootuser}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_user' "${CLIparm_user}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_password' "${CLIparm_password}" >> ${dumpcliparmslogfilepath}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_api_key' "${CLIparm_api_key}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_use_api_key' "${CLIparm_use_api_key}" >> ${dumpcliparmslogfilepath}
    
    # ADDED 2021-11-09 -
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_MaaS' "${CLIparm_MaaS}" >> ${dumpcliparmslogfilepath}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_api_context' "${CLIparm_api_context}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_use_api_context' "${CLIparm_use_api_context}" >> ${dumpcliparmslogfilepath}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_websslport' "${CLIparm_websslport}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_mgmt' "${CLIparm_mgmt}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_domain' "${CLIparm_domain}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_sessionidfile' "${CLIparm_sessionidfile}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_sessiontimeout' "${CLIparm_sessiontimeout}" >> ${dumpcliparmslogfilepath}
    
    # ADDED 2022-03-10 -
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIconntimeout' "${APICLIconntimeout}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_connectiontimeout' "${CLIparm_connectiontimeout}" >> ${dumpcliparmslogfilepath}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_logpath' "${CLIparm_logpath}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_outputpath' "${CLIparm_outputpath}" >> ${dumpcliparmslogfilepath}
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-03-10
    # MODIFIED 2022-06-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    # ADDED 2021-02-03 -
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_TypeOfExport' "${CLIparm_TypeOfExport}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'TypeOfExport' "${TypeOfExport}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'ExportTypeIsStandard' "${ExportTypeIsStandard}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'ExportTypeIsName4Delete' "${ExportTypeIsName4Delete}" >> ${dumpcliparmslogfilepath}
    
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_NoSystemObjects' "${CLIparm_NoSystemObjects}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_OnlySystemObjects' "${CLIparm_OnlySystemObjects}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'NoSystemObjects' "${NoSystemObjects}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'OnlySystemObjects' "${OnlySystemObjects}" >> ${dumpcliparmslogfilepath}
    
    # ADDED 2021-02-03 -
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CreatorIsNotSystem' "${CLIparm_CreatorIsNotSystem}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CreatorIsSystemm' "${CLIparm_CreatorIsSystemm}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CreatorIsNotSystem' "${CreatorIsNotSystem}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CreatorIsSystem' "${CreatorIsSystem}" >> ${dumpcliparmslogfilepath}
    
    echo `${dtzs}`${dtzsep}  >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVADDEXPERRHANDLE' "${CSVADDEXPERRHANDLE}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CSVADDEXPERRHANDLE' "${CLIparm_CSVADDEXPERRHANDLE}" >> ${dumpcliparmslogfilepath}
    
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_format' "${CLIparm_format}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_formatall' "${CLIparm_formatall}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_formatcsv' "${CLIparm_formatcsv}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_formatjson' "${CLIparm_formatjson}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_detailslevel' "${CLIparm_detailslevel}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_detailslevelall' "${CLIparm_detailslevelall}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_detailslevelfull' "${CLIparm_detailslevelfull}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_detailslevelstandard' "${CLIparm_detailslevelstandard}" >> ${dumpcliparmslogfilepath}
    
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_UseDevOpsResults' "${CLIparm_UseDevOpsResults}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_resultspath' "${CLIparm_resultspath}" >> ${dumpcliparmslogfilepath}
    
    # ADDED 2022-02-15 -
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_UseJSONRepo' "${CLIparm_UseJSONRepo}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_SaveJSONRepo' "${CLIparm_SaveJSONRepo}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_ForceJSONRepoRebuild' "${CLIparm_ForceJSONRepoRebuild}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_jsonrepopath' "${CLIparm_jsonrepopath}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'UseJSONRepo' "${UseJSONRepo}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'SaveJSONRepo' "${SaveJSONRepo}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'RebuildJSONRepo' "${RebuildJSONRepo}" >> ${dumpcliparmslogfilepath}
    
    # ADDED 2021-01-16 -
    
    echo `${dtzs}`${dtzsep}  >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CSVEXPORT05TAGS' "${CLIparm_CSVEXPORT05TAGS}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CSVEXPORT10TAGS' "${CLIparm_CSVEXPORT10TAGS}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CSVEXPORTNOTAGS' "${CLIparm_CSVEXPORTNOTAGS}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVEXPORT05TAGS' "${CSVEXPORT05TAGS}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVEXPORT10TAGS' "${CSVEXPORT10TAGS}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVEXPORTNOTAGS' "${CSVEXPORTNOTAGS}" >> ${dumpcliparmslogfilepath}
    
    # ADDED 2021-11-09 -
    
    echo `${dtzs}`${dtzsep}  >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_OVERRIDEMAXOBJECTS' "${CLIparm_OVERRIDEMAXOBJECTS}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_MAXOBJECTS' "${CLIparm_MAXOBJECTS}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'OverrideMaxObjects' "${OverrideMaxObjects}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'OverrideMaxObjectsNumber' "${OverrideMaxObjectsNumber}" >> ${dumpcliparmslogfilepath}
    
    echo `${dtzs}`${dtzsep}  >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'KEEPCSVWIP' "${KEEPCSVWIP}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_KEEPCSVWIP' "${CLIparm_KEEPCSVWIP}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLEANUPCSVWIP' "${CLEANUPCSVWIP}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CLEANUPCSVWIP' "${CLIparm_CLEANUPCSVWIP}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'NODOMAINFOLDERS' "${NODOMAINFOLDERS}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_NODOMAINFOLDERS' "${CLIparm_NODOMAINFOLDERS}" >> ${dumpcliparmslogfilepath}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CSVEXPORTDATADOMAIN' "${CLIparm_CSVEXPORTDATADOMAIN}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_CSVEXPORTDATACREATOR' "${CLIparm_CSVEXPORTDATACREATOR}" >> ${dumpcliparmslogfilepath}
    
    # MODIFIED 2022-04-22 -
    #if ${script_use_export} ; then
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_exportpath' "${CLIparm_exportpath}" >> ${dumpcliparmslogfilepath}
    #fi
    #if ${script_use_import} ; then
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_importpath' "${CLIparm_importpath}" >> ${dumpcliparmslogfilepath}
    #fi
    #if ${script_use_delete} ; then
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_deletepath' "${CLIparm_deletepath}" >> ${dumpcliparmslogfilepath}
    #fi
    #if ${script_use_csvfile} ; then
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_csvpath' "${CLIparm_csvpath}" >> ${dumpcliparmslogfilepath}
    #fi
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_exportpath' "${CLIparm_exportpath}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_importpath' "${CLIparm_importpath}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_deletepath' "${CLIparm_deletepath}" >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CLIparm_csvpath' "${CLIparm_csvpath}" >> ${dumpcliparmslogfilepath}
    
    echo `${dtzs}`${dtzsep} >> ${dumpcliparmslogfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'remains' "${REMAINS}" >> ${dumpcliparmslogfilepath}
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-18
    # MODIFIED 2021-11-09 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    HandleShowTempLogFile
    
    dumpcliparmslogfilepath=
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Number parms :  '"$#" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Raw parms    : > '"$@"' <' | tee -a -i ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e `${dtzs}`${dtzsep}"${parmnum} \t ${k}" | tee -a -i ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        # Verbose mode ON
        
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Number parms :  '"$#" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Raw parms    : > '"$@"' <' >> ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e `${dtzs}`${dtzsep}"${parmnum} \t ${k}" >> ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-11-09
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-11-09


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
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Command line parameters before : " | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Number parms :  '"$#" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Raw parms    : > '"$@"' <' | tee -a -i ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e `${dtzs}`${dtzsep}"${parmnum} \t ${k}" | tee -a -i ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
    else
        # Verbose mode OFF
        
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} "Command line parameters before : " >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Number parms :  '"$#" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Raw parms    : > '"$@"' <' >> ${logfilepath}
        
        parmnum=0
        for k ; do
            echo -e `${dtzs}`${dtzsep}"${parmnum} \t ${k}" >> ${logfilepath}
            parmnum=`expr ${parmnum} + 1`
        done
        
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        
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


# MODIFIED 2021-11-09 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Show help information

doshowhelp () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    #
    # MODIFIED 2022-04-22 -
    
    echo
    echo -n $0' [-?][-v]'
    echo -n '|[-r]|[[-u <admin_name>]|[-p <password>]]|[--api-key <api_key_value>]'
    echo -n '|[--MaaS]|[--context <web_api|gaia_api|{MaaSGUID}/web_api>]'
    echo -n '|[-P <web ssl port>]'
    echo -n '|[-m <server_IP>]'
    echo -n '|[-d <domain>]'
    echo -n '|[-s <session_file_filepath>]|[--session-timeout <session_time_out>]'
    echo -n '|[--conn-timeout <connection_time_out>]'
    
    echo -n '|[-l <log_path>]'
    echo -n '|[-o <output_path>]'
    
    if ${script_use_export} ; then
        echo -n '|[-t <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name">]'
        
        echo -n '|[-f <all|csv|json>]|[--details <all|full|standard>]'
    fi
    
    echo -n '|[--RESULTS]|[--RESULTSPATH <results_path>]'
    
    if ${script_use_export} ; then
        echo -n '|[--SO|--NSO|--OSO|--all-objects]'
        echo -n '|[--CREATORISNOTSYSTEM|--NOSYS|--CREATORISSYSTEM]'
        
        echo -n '|[--CSVERR']
        
        echo -n '|[--5-TAGS|--10-TAGS|--NO-TAGS]'
        
        echo -n '|[--OVERRIDEMAXOBJECTS]|[--MAXOBJECTS <maximum_objects_10-500>]'
        
        echo -n '|[--CSVEXPORTDATADOMAIN|--CSVEXPORTDATACREATOR|--CSVALL]'
        
        echo -n '|[--CLEANUPCSVWIP]'
        echo -n '|[--NODOMAINFOLDERS]'
    fi
    
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
    # MODIFIED 2021-11-09 -
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
    echo '  Set MaaS, Smart-1 Cloud op  --MaaS | --maas | --MAAS'
    echo '  Set Console User API Key    --api-key <api_key_value> | '
    echo '                              --api-key=<api_key_value>'
    echo '  (!!)  Required if --MaaS is used'
    echo '  Set API Context             --context <api_context> | --context=<api_context>'
    echo '    Supported <api_context> values for API context :'
    echo '      <web_api|gaia_api|{MaaSGUID}/web_api>'
    echo '      web_api             :  DEFAULT R8X Management API'
    echo '      gaia_api"           :  Gaia API'
    echo '      {MaaSGUID}/web_api  :  MaaS (Smart-1 Cloud) Management API'
    echo '  (!!)  Required if --MaaS is used'
    
    echo
    echo '  Set [web ssl] Port         -P <web-ssl-port> | --port <web-ssl-port> |'
    echo '                             -P=<web-ssl-port> | --port=<web-ssl-port>'
    echo '  Set Management Server IP   -m <server_IP> | --management <server_IP> |'
    echo '                             -m=<server_IP> | --management=<server_IP>'
    echo '  (!!)  Required if --MaaS is used'
    echo '  Set Management Domain      -d <domain> | --domain <domain> |'
    echo '                             -d=<domain> | --domain=<domain>'
    echo '  (!!)  Required if --MaaS is used'
    echo
    
    echo '  Set session file path      -s <session_file_filepath> |'
    echo '                             --session-file <session_file_filepath> |'
    echo '                             -s=<session_file_filepath> |'
    echo '                             --session-file=<session_file_filepath>'
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
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo '  Set session timeout value  --session-timeout <session_time_out> |'
    echo '                             --session-timeout=<session_time_out>'
    echo
    echo '      Default = 600 seconds, allowed range of values 10 - 3600 seconds'
    echo
    
    echo '  Connection timeout value   --conn-timeout <connection_time_out> | --CTO <connection_time_out> |'
    echo '                             --conn-timeout=<connection_time_out> | --CTO=<connection_time_out> |'
    echo
    echo '      Default = 180 seconds, allowed range of values 10 - 3600 seconds'
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
    if ${script_use_export} ; then
        echo '  Type of Object Export     -t <export_type> |-t <export_type> |'
        echo '                            --type-of-export <export_type>|'
        echo '                            --type-of-export=<export_type>'
        echo '    Supported <export_type> values for export to CSV :'
        echo '      <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name">'
        echo '      "standard"           :  Standard Export of all supported object key values'
        echo '      "name-only"          :  Export of just the name key value for object'
        echo '      "name-and-uid"       :  Export of name and uid key value for object'
        echo '      "uid-only"           :  Export of just the uid key value of objects'
        echo '      "rename-to-new-name" :  Export of name key value for object rename'
        echo
        echo '    For an export for a delete operation via CSV, use "name-only"'
        echo
        
        echo '  Format for export          -f <all|csv|json> | --format <all|csv|json> |'
        echo '                             -f=<all|csv|json> | --format=<all|csv|json>'
        
        echo '  Details level for json     --details <all|full|standard> |'
        echo '                             --DETAILSLEVEL <all|full|standard> |'
        echo '                             --details=<all|full|standard> |'
        echo '                             --DETAILSLEVEL=<all|full|standard>  |'
    fi
    
    echo '  Use devops results path    --RESULTS | --DEVOPSRESULTS'
    echo '  Set results output path    --RESULTSPATH <results_path> |'
    echo '                             --RESULTSPATH=<results_path> |'
    echo '                             --DEVOPSRESULTSPATH <results_path> |'
    echo '                             --DEVOPSRESULTSPATH=<results_path> |'
    
    echo '  Use JSON repository(*)     --JSONREPO'
    echo '  DO NOT Use JSON repository --NOJSONREPO'
    if ${script_use_export} ; then
        echo '  Save to JSON repository(*) --SAVEJSONREPO'
        echo '  DO NOT Save to JSON repo   --NOSAVEJSONREPO'
        echo '  Force Rebuild of JSON repo --FORCEJSONREPOREBUILD'
    fi
    echo '  Set JSON repository path   --JSONREPOPATH <json_repository_path> |'
    echo '                             --JSONREPOPATH=<json_repository_path> |'
    echo
    echo '  results_path = fully qualified folder path for devops results folder'
    echo '  json_repository_path = fully qualified folder path to json repository folder'
    echo
    
    if ${script_use_export} ; then
        echo '  Export System Objects      --SO | --system-objects  {default mode}'
        echo '  NO System Objects Export   --NSO | --no-system-objects'
        echo '  ONLY System Objects Export --OSO | --only-system-objects'
        echo '  All Objects (*2)           --all-objects'
        echo
        echo '  Ignore object where Creator is "System"'
        echo '                             --CREATORISNOTSYSTEM | --NOSYS'
        echo '  Select object where Creator is "System"'
        echo '                             --CREATORISSYSTEM'
        echo
        
        echo '  CSV export add err handler --CSVERR | --CSVADDEXPERRHANDLE'
        echo
        
        echo '  Export 5 Tags for object   --5-TAGS | --CSVEXPORT05TAGS'
        echo '  Export 10 Tags for object  --10-TAGS | --CSVEXPORT10TAGS'
        echo '  Export NO Tags for object  --NO-TAGS | --CSVEXPORTNOTAGS'
        echo
        
        echo '  Override Maximum Objects default value to absolute limit of 500'
        echo '                             --OVERRIDEMAXOBJECTS'
        echo '  Set Maximum Objects Value  --MAXOBJECTS <maximum_objects_10-500> |'
        echo '                             --MAXOBJECTS=<maximum_objects_10-500>'
        echo '    The absolute maximum number of objects or values that the API handles is 500'
        echo '    The value for maximum objects that can be entered shall be between 10 and 500,'
        echo '    values greater than 500 or lower than 10 are ignored!'
        echo '    --MAXOBJECTS requires use of --OVERRIDEMAXOBJECTS'
        echo '    Using --OVERRIDEMAXOBJECTS with out --MAXOBJECTS <X> results in max objects of 500'
        echo
        
        echo '  Export Data Domain info    --CSVEXPORTDATADOMAIN  (*)'
        echo '  Export Data Creator info   --CSVEXPORTDATACREATOR  (*)'
        echo '  Export Data Domain and Data Creator info'
        echo '                             --CSVALL|--CSVEXPORTDATAALL  (*)'
        echo
        echo '  (*)   use of these will generate FOR_REFERENCE_ONLY CSV export !'
        echo '  (*2)  overrides whether Creater is or is not System'
        echo
        
        echo '  Keep CSV WIP folders       --KEEPCSVWIP'
        echo '  Remove CSV WIP folders     --CLEANUPCSVWIP   !! Default Action'
        echo '  No domain name in folders  --NODOMAINFOLDERS'
        echo
    fi
    
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
    echo ' NOTE:  System Objects are NOT exported in CSV or Full details JSON dump mode!'
    echo '        Control of System Objects with --SO and --NSO only works with CSV or'
    echo '        Full JSON dump.  Standard JSON dump does not support selection of the'
    echo '        System Objects during operation, so all System Objects are collected'
    echo
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo ' Examples: General :'
    echo
    echo ' Verbose output, No waiting, Management server 192.168.1.1 on Web SSL port 4434 to domain "System Data"'
    echo '   with session file "/var/tmp/id.txt" and dump results to default RESULTS location.'
    echo
    echo '   ]# '${ScriptName}' -v --NOWAIT -P 4434 -m 192.168.1.1 -d "System Data" -s "/var/tmp/id.txt" --RESULTS'
    echo
    echo ' Autenticate with username and password to Management server 192.168.1.1 on Web SSL port 4434'
    echo '   to domain fooville with session file "/var/tmp/id.txt" and log to "/var/tmp/script_dump" folder.'
    echo
    echo '   ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump"'
    echo
    echo ' Autenticate with username to Management server 192.168.1.1 on Web SSL port 4434 to domain fooville'
    echo '   with session file "/var/tmp/id.txt" and log to "/var/tmp/script_dump" folder.'
    echo
    echo '   ]# '${ScriptName}' -u fooAdmin -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump"'
    echo
    echo ' Example of call from nohup initiator script, do_script_nohup from bash 4 Check Point scripts'
    echo
    echo '   ]# '${ScriptName}' --api-key "@#ohtobeanapikey%" --NOHUP --NOHUP-DTG 2027-11-11-2323CST --NOHUP-PATH "/var/log/__customer/scripts"'
    echo
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo ' Example: MaaS (Smart-1 Cloud) Authentication - Use tenant specific -m, -d, --context, and --api-key values :'
    echo
    echo '   ]# '${ScriptName}' --MaaS -m XYZQ-889977xx.maas.checkpoint.com -d D889977xx --context 12345678-abcd-ef98-7654-321012345678/web_api --api-key "@#ohtobeanapikey%"'
    
    #                  1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #        01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    if ${script_use_export} ; then
        echo
        echo ' Example: Export:'
        echo
        echo ' ]# '${ScriptName}' -v --NOWAIT -P 4434 -m 192.168.1.1 -d "System Data" -s "/var/tmp/id.txt" --RESULTS --NSO --OVERRIDEMAXOBJECTS --MAXOBJECTS 250'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -d Global --SO -s "/var/tmp/id.txt"'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -d "System Data" --NSO -s "/var/tmp/id.txt"'
        echo
        echo ' ]# '${ScriptName}' --api-key "@#ohtobeanapikey%" -P 4434 --NSO --format json --details all'
        echo
        echo ' ]# '${ScriptName}' --api-key "@#ohtobeanapikey%" --SO --format=all --details=full --CSVALL --OVERRIDEMAXOBJECTS'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export"'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --type-of-export "names-only" -x "/var/tmp/script_dump/export4delete"'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --5-TAGS --CSVADDEXPERRHANDL --CLEANUPCSVWIP'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --10-TAGS --CSVADDEXPERRHANDL'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --CTO 600 --CREATORISNOTSYSTEM --10-TAGS --CSVADDEXPERRHANDL --OVERRIDEMAXOBJECTS --MAXOBJECTS 250'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --10-TAGS --CSVERR --CSVALL'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --10-TAGS --CSVERR'
        echo
        echo ' Example of export for delete via CSV operation'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS --NSO --NO-TAGS --CSVERR -t "name-for-delete"'
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS -t "name-for-delete"'
        echo
        echo ' Example of call from nohup initiator script, do_script_nohup from bash 4 Check Point scripts'
        echo
        echo ' ]# '${ScriptName}' --api-key "@#ohtobeanapikey%" --SO --format=all --details=full --NOHUP --NOHUP-DTG 2027-11-11-2323CST --NOHUP-PATH "/var/log/__customer/scripts"'
    fi
    
    if ${script_use_import} ; then
        echo
        echo ' Example: Import | Set Update | Rename To New Name:'
        echo
        echo ' ]# '${ScriptName}' -u fooAdmin -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -i "/var/tmp/import"'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS -i "/var/tmp/import"'
    fi
    
    if ${script_use_delete} ; then
        echo
        echo ' Example: Delete:'
        echo
        echo ' ]# '${ScriptName}' -v -r --NOWAIT --RESULTS -k "/var/tmp/delete"'
        echo
        echo ' ]# '${ScriptName}' -v -r --RESULTS -k "/var/log/__customer/devops.mydata/delete_csv.2022-06-18"'
        echo
        echo ' - Example Delete operation with results directed to location indicated by "-x <file_path>":'
        echo ' ]# '${ScriptName}' -u fooAdmin -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -k "/var/tmp/delete" -x "/var/tmp/script_dump/export"'
    fi
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    return 1
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-19


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
        
        #echo `${dtzs}`${dtzsep} OPT = ${OPT}
        
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


# MODIFIED 2021-10-19 - 
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
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-06
    # MODIFIED 2022-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    while [ -n "$1" ]; do
        # Copy so we can modify it (can't modify $1)
        OPT="$1"
        
        # testing
        #echo `${dtzs}`${dtzsep} 'OPT = '${OPT}
        #
        
        # Detect argument termination
        if [ x"${OPT}" = x"--" ]; then
            # testing
            # echo `${dtzs}`${dtzsep} "Argument termination"
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
                    CLIparm_api_key=${CLIparm_api_key//\'}
                    CLIparm_use_api_key=true
                    #shift
                    ;;
                --context=* )
                    CLIparm_api_context="${OPT#*=}"
                    # For internal storage, remove the quotes surrounding the api context value, 
                    # will add back on utilization
                    CLIparm_api_context=${CLIparm_api_context//\"}
                    CLIparm_api_context=${CLIparm_api_context//\'}
                    CLIparm_use_api_context=true
                    shift
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
                    CLIparm_domain=${CLIparm_domain//\'}
                    #shift
                    ;;
                -s=* | --session-file=* )
                    CLIparm_sessionidfile="${OPT#*=}"
                    #shift
                    ;;
                --session-timeout=* )
                    CLIparm_sessiontimeout="${OPT#*=}"
                    CLIparm_sessiontimeout=${CLIparm_sessiontimeout//\"}
                    CLIparm_sessiontimeout=${CLIparm_sessiontimeout//\'}
                    #shift
                    ;;
                --conn-timeout=* | --CTO=* )
                    CLIparm_connectiontimeout="${OPT#*=}"
                    CLIparm_connectiontimeout=${CLIparm_connectiontimeout//\"}
                    CLIparm_connectiontimeout=${CLIparm_connectiontimeout//\'}
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
                    CLIparm_api_key=${CLIparm_api_key//\'}
                    CLIparm_use_api_key=true
                    shift
                    ;;
                --context )
                    CLIparm_api_context="$2"
                    # For internal storage, remove the quotes surrounding the api context value, 
                    # will add back on utilization
                    CLIparm_api_context=${CLIparm_api_context//\"}
                    CLIparm_api_context=${CLIparm_api_context//\'}
                    CLIparm_use_api_context=true
                    shift
                    ;;
                # ADDED 2021-11-09 -
                --MaaS | --maas | --MAAS )
                    CLIparm_MaaS=true
                    ;;
                --context )
                    CLIparm_api_context="$2"
                    # For internal storage, remove the quotes surrounding the api context value, 
                    # will add back on utilization
                    CLIparm_api_context=${CLIparm_api_key//\"}
                    CLIparm_api_context=${CLIparm_api_key//\'}
                    CLIparm_use_api_context=true
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
                    CLIparm_domain=${CLIparm_domain//\'}
                    shift
                    ;;
                -s | --session-file )
                    CLIparm_sessionidfile="$2"
                    shift
                    ;;
                --session-timeout )
                    CLIparm_sessiontimeout="$2"
                    CLIparm_sessiontimeout=${CLIparm_sessiontimeout//\"}
                    CLIparm_sessiontimeout=${CLIparm_sessiontimeout//\'}
                    shift
                    ;;
                --conn-timeout | --CTO )
                    CLIparm_connectiontimeout="$2"
                    CLIparm_connectiontimeout=${CLIparm_connectiontimeout//\"}
                    CLIparm_connectiontimeout=${CLIparm_connectiontimeout//\'}
                    shift
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
                --JSONREPO )
                    CLIparm_UseJSONRepo=true
                    UseJSONRepo=true
                    ;;
                --NOJSONREPO )
                    CLIparm_UseJSONRepo=false
                    UseJSONRepo=false
                    ;;
                --SAVEJSONREPO )
                    CLIparm_SaveJSONRepo=true
                    SaveJSONRepo=true
                    ;;
                --NOSAVEJSONREPO )
                    CLIparm_SaveJSONRepo=false
                    SaveJSONRepo=false
                    ;;
                --FORCEJSONREPOREBUILD )
                    CLIparm_ForceJSONRepoRebuild=true
                    RebuildJSONRepo=true
                    ;;
                --all-objects )
                    CLIparm_NoSystemObjects=false
                    CLIparm_OnlySystemObjects=false
                    CLIparm_CreatorIsNotSystem=false
                    CLIparm_CreatorIsSystemm=false
                    ;;
                --SO | --system-objects )
                    CLIparm_NoSystemObjects=false
                    CLIparm_OnlySystemObjects=false
                    ;;
                --NSO | --no-system-objects )
                    CLIparm_NoSystemObjects=true
                    CLIparm_OnlySystemObjects=false
                    #CLIparm_CreatorIsNotSystem=true
                    ;;
                --OSO | --only-system-objects )
                    CLIparm_OnlySystemObjects=true
                    CLIparm_NoSystemObjects=false
                    #CLIparm_CreatorIsSystemm=true
                    ;;
                --CREATORISNOTSYSTEM | --NOSYS )
                    CLIparm_CreatorIsNotSystem=true
                    CLIparm_CreatorIsSystemm=false
                    ;;
                --CREATORISSYSTEM )
                    CLIparm_CreatorIsSystemm=true
                    CLIparm_CreatorIsNotSystem=false
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
                # ADDED 2021-11-09 -
                --OVERRIDEMAXOBJECTS )
                    CLIparm_OVERRIDEMAXOBJECTS=true
                    ;;
                # ADDED 2021-11-09 -
                --MAXOBJECTS=* )
                    CLIparm_MAXOBJECTS="${OPT#*=}"
                    CLIparm_MAXOBJECTS=${CLIparm_MAXOBJECTS//\"}
                    CLIparm_MAXOBJECTS=${CLIparm_MAXOBJECTS//\'}
                    #shift
                    ;;
                --MAXOBJECTS )
                    CLIparm_MAXOBJECTS="$2"
                    CLIparm_MAXOBJECTS=${CLIparm_MAXOBJECTS//\"}
                    CLIparm_MAXOBJECTS=${CLIparm_MAXOBJECTS//\'}
                    shift
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
                    CLIparm_TypeOfExport=${CLIparm_TypeOfExport//\"}
                    CLIparm_TypeOfExport=${CLIparm_TypeOfExport//\'}
                    #shift
                    ;;
                -t | --type-of-export )
                    CLIparm_TypeOfExport="$2"
                    CLIparm_TypeOfExport=${CLIparm_TypeOfExport//\"}
                    CLIparm_TypeOfExport=${CLIparm_TypeOfExport//\'}
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
                --JSONREPOPATH=* )
                    CLIparm_jsonrepopath="${OPT#*=}"
                    #shift
                    ;;
                --JSONREPOPATH* )
                    CLIparm_jsonrepopath="$2"
                    shift
                    ;;
                -x=* | --export-path=* )
                    CLIparm_exportpath="${OPT#*=}"
                    CLIparm_exportpath=${CLIparm_exportpath//\"}
                    CLIparm_exportpath=${CLIparm_exportpath//\'}
                    #shift
                    ;;
                -x | --export-path )
                    CLIparm_exportpath="$2"
                    CLIparm_exportpath=${CLIparm_exportpath//\"}
                    CLIparm_exportpath=${CLIparm_exportpath//\'}
                    shift
                    ;;
                -i=* | --import-path=* )
                    CLIparm_importpath="${OPT#*=}"
                    CLIparm_importpath=${CLIparm_importpath//\"}
                    CLIparm_importpath=${CLIparm_importpath//\'}
                    #shift
                    ;;
                -i | --import-path )
                    CLIparm_importpath="$2"
                    CLIparm_importpath=${CLIparm_importpath//\"}
                    CLIparm_importpath=${CLIparm_importpath//\'}
                    shift
                    ;;
                -k=* | --delete-path=* )
                    CLIparm_deletepath="${OPT#*=}"
                    CLIparm_deletepath=${CLIparm_deletepath//\"}
                    CLIparm_deletepath=${CLIparm_deletepath//\'}
                    #shift
                    ;;
                -k | --delete-path )
                    CLIparm_deletepath="$2"
                    CLIparm_deletepath=${CLIparm_deletepath//\"}
                    CLIparm_deletepath=${CLIparm_deletepath//\'}
                    shift
                    ;;
                -c=* | --csv=* )
                    CLIparm_csvpath="${OPT#*=}"
                    CLIparm_csvpath=${CLIparm_csvpath//\"}
                    CLIparm_csvpath=${CLIparm_csvpath//\'}
                    #shift
                    ;;
                -c | --csv )
                    CLIparm_csvpath="$2"
                    CLIparm_csvpath=${CLIparm_csvpath//\"}
                    CLIparm_csvpath=${CLIparm_csvpath//\'}
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
            #NEXTOPT="${OPT#-[vrF?]}" # try removing single short opt
            NEXTOPT="${OPT#-[vr?]}" # try removing single short opt
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
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-05-04
    # MODIFIED 2022-03-10 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    # ADDED 2021-11-09 -
    export CLIparm_MaaS=${CLIparm_MaaS}
    export AuthenticationMaaS=${CLIparm_MaaS}
    
    # ADDED 2021-10-19 -
    export CLIparm_api_context=${CLIparm_api_context}
    export CLIparm_use_api_context=${CLIparm_use_api_context}
    
    export CLIparm_websslport=${CLIparm_websslport}
    export CLIparm_mgmt=${CLIparm_mgmt}
    export CLIparm_domain=${CLIparm_domain}
    
    export CLIparm_sessionidfile=${CLIparm_sessionidfile}
    export CLIparm_sessiontimeout=${CLIparm_sessiontimeout}
    
    # ADDED 2022-03-10 -
    export CLIparm_connectiontimeout=${CLIparm_connectiontimeout}
    export APICLIconntimeout=${CLIparm_connectiontimeout}
    
    export CLIparm_logpath=${CLIparm_logpath}
    export CLIparm_outputpath=${CLIparm_outputpath}
    
    # ADDED 2021-02-06 - MODIFIED 2021-02-13 - 
    export CLIparm_NOHUP=${CLIparm_NOHUP}
    export CLIparm_NOHUPScriptName=${CLIparm_NOHUPScriptName}
    export CLIparm_NOHUPDTG=${CLIparm_NOHUPDTG}
    export CLIparm_NOHUPPATH=${CLIparm_NOHUPPATH}
    
    if ${CLIparm_MaaS} ; then
        # MaaS (Smart-1 Cloud) authentication is requested, now to check the dependencies in CLI parameters
        export AuthenticationMaaS=true
        
        if [ x"${CLIparm_mgmt}" = x"" ] ; then
            # Missing the management server value, required for MaaS authentication
            echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the management server address to be set, and it is empty!!' | tee -a -i ${logfilepath}
            export AuthenticationMaaS=false
        else
            echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the management server address to be set = '${CLIparm_mgmt} >> ${logfilepath}
        fi
        
        if [ x"${CLIparm_domain}" = x"" ] ; then
            # Missing the domain value, required for MaaS authentication
            echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the domain to be set, and it is empty!!' | tee -a -i ${logfilepath}
            export AuthenticationMaaS=false
        else
            echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the domain to be set = '${CLIparm_domain} >> ${logfilepath}
        fi
        
        if ${CLIparm_use_api_context} ; then
            # OK Context is enabled, do we have a context value
            if [ x"${CLIparm_api_context}" = x"" ] ; then
                # Context value is not set, which is a disqualifier
                echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the API Context value to be set, and it is empty!' | tee -a -i ${logfilepath}
                export AuthenticationMaaS=false
            else
                echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the API Context value to be set = '${CLIparm_api_context} >> ${logfilepath}
            fi
        else
            # Wait what?  MaaS requires the api context
            echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the API Context be set!' | tee -a -i ${logfilepath}
            export AuthenticationMaaS=false
        fi
        
        if ${CLIparm_use_api_key} ; then
            # OK API Key is enabled, do we have a key value
            if [ x"${CLIparm_api_key}" = x"" ] ; then
                # Context value is not set, which is a disqualifier
                echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the API Key value to be set, and it is empty!' | tee -a -i ${logfilepath}
                export AuthenticationMaaS=false
            else
                echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the API Key value to be set = '${CLIparm_api_key} >> ${logfilepath}
            fi
        else
            # Wait what?  MaaS requires the API Key
            echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication requires the API Key be set!' | tee -a -i ${logfilepath}
            export AuthenticationMaaS=false
        fi
        
        if ! ${AuthenticationMaaS} ; then
            echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication not possible, check CLI parameters passed!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep}  | tee -a -i ${logfilepath}
            SHOWHELP=true
        else
            echo `${dtzs}`${dtzsep} 'MaaS (Smart-1 Cloud) authentication possible, all required CLI parameters passed!' >> ${logfilepath}
        fi
    else
        export AuthenticationMaaS=false
    fi
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-03-10
    # MODIFIED 2022-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    # MODIFIED 2022-06-18 -
    export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
    export CLIparm_TypeOfExport=${CLIparm_TypeOfExport//\"}
    export CLIparm_TypeOfExport=${CLIparm_TypeOfExport//\'}
    #export TypeOfExport=${CLIparm_TypeOfExport}
    #export ExportTypeIsStandard=true
    
    case "${CLIparm_TypeOfExport}" in
        # a "Standard" export operation
        'standard' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=true
            export ExportTypeIsName4Delete=false
            ;;
        # a "name-only" export operation
        'name-only' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            export ExportTypeIsName4Delete=false
            ;;
        # a "name-and-uid" export operation
        'name-and-uid' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            export ExportTypeIsName4Delete=false
            ;;
        # a "uid-only" export operation
        'uid-only' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            export ExportTypeIsName4Delete=false
            ;;
        # a "rename-to-new-name" export operation
        'rename-to-new-name' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            export ExportTypeIsName4Delete=false
            ;;
        # a "name-for-delete" export operation
        'name-for-delete' )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=false
            export ExportTypeIsName4Delete=true
            ;;
        # Anything unknown is handled as "standard"
        * )
            export CLIparm_TypeOfExport=${CLIparm_TypeOfExport}
            export TypeOfExport=${CLIparm_TypeOfExport}
            export ExportTypeIsStandard=true
            # Wait what?  Not an expected format
            echo `${dtzs}`${dtzsep} 'INVALID EXPORT-TYPE PROVIDED IN CLI PARAMETERS!  EXPORT-TYPE = '${CLIparm_TypeOfExport} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            SHOWHELP=true
            ;;
    esac
    
    # ADDED 2022-03-10 -
    export CLIparm_format=${CLIparm_format}
    export CLIparm_format=${CLIparm_format//\"}
    export CLIparm_format=${CLIparm_format//\'}
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
            echo `${dtzs}`${dtzsep} 'INVALID FORMAT PROVIDED IN CLI PARAMETERS!  FORMAT = '${CLIparm_format} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            SHOWHELP=true
            ;;
    esac
    
    # ADDED 2022-03-11 -
    if [ -z ${CLIparm_detailslevel} ] ; then
        # If 
        export CLIparm_detailslevel=all
    else
        export CLIparm_detailslevel=${CLIparm_detailslevel}
    fi
    export CLIparm_detailslevel=${CLIparm_detailslevel//\"}
    export CLIparm_detailslevel=${CLIparm_detailslevel//\'}
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
            echo `${dtzs}`${dtzsep} 'INVALID DETAILS LEVEL PROVIDED IN CLI PARAMETERS!  DETAILS LEVEL = '${CLIparm_detailslevel} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            SHOWHELP=true
            ;;
    esac
    
    # ADDED 2020-11-23 -
    export CLIparm_UseDevOpsResults=${CLIparm_UseDevOpsResults}
    export UseDevOpsResults=${CLIparm_UseDevOpsResults}
    export CLIparm_resultspath=${CLIparm_resultspath}
    
    # MODIFIED 2022-02-15 -
    export CLIparm_UseJSONRepo=${CLIparm_UseJSONRepo}
    export UseJSONRepo=${CLIparm_UseJSONRepo}
    export CLIparm_SaveJSONRepo=${CLIparm_SaveJSONRepo}
    export SaveJSONRepo=${CLIparm_SaveJSONRepo}
    export CLIparm_ForceJSONRepoRebuild=${CLIparm_ForceJSONRepoRebuild}
    export RebuildJSONRepo=${CLIparm_SaveJSONRepo}
    export CLIparm_jsonrepopath=${CLIparm_jsonrepopath}
    
    # MODIFIED 2022-04-22 -
    export CLIparm_NoSystemObjects=${CLIparm_NoSystemObjects}
    export NoSystemObjects=${CLIparm_NoSystemObjects}
    
    export CLIparm_OnlySystemObjects=${CLIparm_OnlySystemObjects}
    export OnlySystemObjects=${CLIparm_OnlySystemObjects}
    
    export CLIparm_CreatorIsNotSystem=${CLIparm_CreatorIsNotSystem}
    export CreatorIsNotSystem=${CLIparm_CreatorIsNotSystem}
    
    export CLIparm_CreatorIsSystemm=${CLIparm_CreatorIsSystemm}
    export CreatorIsSystem=${CLIparm_CreatorIsSystemm}
    
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
    
    # ADDED 2021-11-09 -
    export CLIparm_OVERRIDEMAXOBJECTS=${CLIparm_OVERRIDEMAXOBJECTS}
    export CLIparm_MAXOBJECTS=${CLIparm_MAXOBJECTS}
    export OverrideMaxObjects=${CLIparm_OVERRIDEMAXOBJECTS}
    export OverrideMaxObjectsNumber=${CLIparm_MAXOBJECTS}
    
    if ${CLIparm_OVERRIDEMAXOBJECTS} ; then
        # Override Max Objects requested
        if [ x"${CLIparm_MAXOBJECTS}" = x"" ] ; then
            # OVERRIDEMAXOBJECTS requested, but no value for MAXOBJECTS set, so use API limit
            export OverrideMaxObjects=true
            export OverrideMaxObjectsNumber=${MaxMaxObjectsLimit}
        else
            if [ ${CLIparm_MAXOBJECTS} -lt ${MinMaxObjectsLimit} ] ; then
                export OverrideMaxObjects=false
                export OverrideMaxObjectsNumber=
                echo `${dtzs}`${dtzsep} 'INVALID MAXOBJECT VALUE PROVIDED IN CLI PARAMETERS, VALUE BELOW MINIMUM LIMIT OF '${MinMaxObjectsLimit}' !' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  MAXOBJECT VALUE = '${CLIparm_MAXOBJECTS} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                SHOWHELP=true
            elif [ ${CLIparm_MAXOBJECTS} -gt ${MaxMaxObjectsLimit} ] ; then
                export OverrideMaxObjects=false
                export OverrideMaxObjectsNumber=
                echo `${dtzs}`${dtzsep} 'INVALID MAXOBJECT VALUE PROVIDED IN CLI PARAMETERS, VALUE ABOVE MAXIUM LIMIT OF '${MaxMaxObjectsLimit}' !' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  MAXOBJECT VALUE = '${CLIparm_MAXOBJECTS} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                SHOWHELP=true
            else
                echo `${dtzs}`${dtzsep} 'MAXOBJECT VALUE PROVIDED IN CLI PARAMETERS OK !' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} '  MAXOBJECT VALUE = '${CLIparm_MAXOBJECTS} >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
                export OverrideMaxObjects=true
                export OverrideMaxObjectsNumber=${CLIparm_MAXOBJECTS}
            fi
        fi
    else
        # Override Max Objects NOT requested
        export OverrideMaxObjects=false
        export OverrideMaxObjectsNumber=
    fi
    
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
    
    # MODIFIED 2022-05-04 -
    
    export CLIparm_exportpath=${CLIparm_exportpath}
    export CLIparm_exportpath=${CLIparm_exportpath//\"}
    export CLIparm_exportpath=${CLIparm_exportpath//\'}
    
    export CLIparm_importpath=${CLIparm_importpath}
    export CLIparm_importpath=${CLIparm_importpath//\"}
    export CLIparm_importpath=${CLIparm_importpath//\'}
    
    export CLIparm_deletepath=${CLIparm_deletepath}
    export CLIparm_deletepath=${CLIparm_deletepath//\"}
    export CLIparm_deletepath=${CLIparm_deletepath//\'}
    
    export CLIparm_csvpath=${CLIparm_csvpath}
    export CLIparm_csvpath=${CLIparm_csvpath//\"}
    export CLIparm_csvpath=${CLIparm_csvpath//\'}
    
    # MODIFIED 2022-06-18 -
    
    if ${ExportTypeIsName4Delete} ; then 
        # When export is for delete, configure these to ensure we only get what we need
        echo `${dtzs}`${dtzsep} 'Exporting for Delete, overriding some settigns!  EXPORT-TYPE = '${CLIparm_TypeOfExport} >> ${logfilepath}
        export CLIparm_formatall=true
        export CLIparm_formatcsv=true
        export CLIparm_formatjson=true
        export CLIparm_detailslevelall=false
        export CLIparm_detailslevelfull=true
        export CLIparm_detailslevelstandard=false
        export CLIparm_NoSystemObjects=true
        export NoSystemObjects=true
        export CLIparm_OnlySystemObjects=false
        export OnlySystemObjects=false
        export CLIparm_CreatorIsNotSystem=false
        export CreatorIsNotSystem=false
        export CLIparm_CreatorIsSystemm=false
        export CreatorIsSystem=false
        export CLIparm_CSVADDEXPERRHANDLE=true
        export CSVADDEXPERRHANDLE=true
        export CLIparm_CSVEXPORT05TAGS=false
        export CLIparm_CSVEXPORT10TAGS=false
        export CLIparm_CSVEXPORTNOTAGS=true
        export CSVEXPORT05TAGS=false
        export CSVEXPORT10TAGS=false
        export CSVEXPORTNOTAGS=true
        export CLIparm_CSVEXPORTDATADOMAIN=false
        export CLIparm_CSVEXPORTDATACREATOR=false
    else
        # When export is not for delete not changes
        echo `${dtzs}`${dtzsep} 'NOT Exporting for Delete, keeping configured settigns!  EXPORT-TYPE = '${CLIparm_TypeOfExport} >> ${logfilepath}
    fi
    
    export REMAINS=${REMAINS}
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-18
    
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


# MODIFIED 2022-03-10 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# --MaaS | --maas | --MAAS
# --context <web_api|gaia_api|{MaaSGUID}/web_api> | --context=<web_api|gaia_api|{MaaSGUID}/web_api> 
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# --session-timeout <session_time_out[ 10-3600]
# --conn-timeout <connection_time_out, [180,180-3600]> | --CTO <connection_time_out> | --conn-timeout=<connection_time_out, [180,180-3600]> | --CTO=<connection_time_out>
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
# ADDED 2021-11-09 -
export CLIparm_MaaS=false
# ADDED 2021-10-19 -
export CLIparm_api_context=
export CLIparm_use_api_context=false

export CLIparm_domain=
export CLIparm_sessionidfile=

export CLIparm_sessiontimeout=
export CLIparm_logpath=

export CLIparm_connectiontimeout=${APICLIconntimeout}

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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-03-10
# MODIFIED 2022-06-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Specific Scripts Command Line Parameters
#
# --type-of-export <export_type> | --type-of-export=<export_type>
#  Supported <export_type> values for export to CSV :  <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"|"name-for-delete">
#    "standard" {DEFAULT} :  Standard Export of all supported object key values
#    "name-only"          :  Export of just the name key value for object
#    "name-and-uid"       :  Export of name and uid key value for object
#    "uid-only"           :  Export of just the uid key value of objects
#    "rename-to-new-name" :  Export of name key value for object rename
#    "name-for-delete"    :  Export of name key value for object delete also sets other settings needed for clean delete control CSV
#    For an export for a delete operation via CSV, use "name-only"
#
# -f <format[all|csv|json]> | --format <format[all|csv|json]> | -f=<format[all|csv|json]> | --format=<format[all|csv|json]> 
#
# --details <level[all|full|standard]> | --DETAILSLEVEL <level[all|full|standard]> | --details=<level[all|full|standard]> | --DETAILSLEVEL=<level[all|full|standard]> 
#
# --DEVOPSRESULTS | --RESULTS
# --DEVOPSRESULTSPATH <results_path> | --RESULTSPATH <results_path> | --DEVOPSRESULTSPATH=<results_path> | --RESULTSPATH=<results_path> 
#
# --JSONREPO
# --NOJSONREPO
# --SAVEJSONREPO
# --NOSAVEJSONREPO
# --FORCEJSONREPOREBUILD
# --JSONREPOPATH <json_repository_path> | --JSONREPOPATH=<json_repository_path> 
#
# --SO | --system-objects | --all-objects
# --NSO | --no-system-objects
# --OSO | --only-system-objects
#
#  --CREATORISNOTSYSTEM | --NOSYS
#  --CREATORISSYSTEM
#
# --CSVERR | --CSVADDEXPERRHANDLE
#
# --5-TAGS | --CSVEXPORT05TAGS
# --10-TAGS | --CSVEXPORT10TAGS
# --NO-TAGS | --CSVEXPORTNOTAGS
#
# --OVERRIDEMAXOBJECTS
# --MAXOBJECTS <maximum_objects_10-500> | --MAXOBJECTS=<maximum_objects_10-500>
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
#export TypeOfExport="standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name|"name-for-delete""
export TypeOfExport="standard"
export CLIparm_TypeOfExport=${TypeOfExport}
export ExportTypeIsStandard=true
export ExportTypeIsName4Delete=false

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

# MODIFIED 2022-02-15 -
# Determine utilization of json repository folder in devops.results subfolder or defined folder

# UseJSONRepo      TRUE      --JSONREPO
# UseJSONRepo      FALSE     --NOJSONREPO
# SaveJSONRepo     TRUE      --SAVEJSONREPO
# SaveJSONRepo     FALSE     --NOSAVEJSONREPO
# RebuildJSONRepo  TRUE      --FORCEJSONREPOREBUILD
# RebuildJSONRepo  FALSE     <default>

export UseJSONRepo=${script_use_json_repo}
export CLIparm_UseJSONRepo=${UseJSONRepo}
export SaveJSONRepo=${script_save_json_repo}
export CLIparm_SaveJSONRepo=${SaveJSONRepo}
export CLIparm_ForceJSONRepoRebuild=false
export RebuildJSONRepo=${CLIparm_ForceJSONRepoRebuild}
export CLIparm_jsonrepopath=

# MODIFIED 2022-04-22 -
# --SO | --system-objects | --all-objects
#export CLIparm_NoSystemObjects=false
#export CLIparm_OnlySystemObjects=false
# --NSO | --no-system-objects
#export CLIparm_NoSystemObjects=true
#export CLIparm_OnlySystemObjects=false
# --OSO | --only-system-objects
#export CLIparm_NoSystemObjects=false
#export CLIparm_OnlySystemObjects=true

export NoSystemObjects=false
export CLIparm_NoSystemObjects=${NoSystemObjects}
export OnlySystemObjects=false
export CLIparm_OnlySystemObjects=${OnlySystemObjects}

# MODIFIED 2022-04-22 -
# Ignore object where Creator is System  :  --CREATORISNOTSYSTEM | --NOSYS
#
#export CreatorIsNotSystem=false|true
export CreatorIsNotSystem=false
export CLIparm_CreatorIsNotSystem=${CreatorIsNotSystem}

# MODIFIED 2022-04-22 -
# Select object where Creator is System  :  --CREATORISSYSTEM
#
#export CLIparm_CreatorIsSystemm=false|true
export CreatorIsSystem=false
export CLIparm_CreatorIsSystemm=${CreatorIsSystem}

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

# ADDED 2021-11-09 - MODIFIED 2021-11-10
# --OVERRIDEMAXOBJECTS
# --MAXOBJECTS <maximum_objects_10-500> | --MAXOBJECTS=<maximum_objects_10-500>

export CLIparm_OVERRIDEMAXOBJECTS=false
export CLIparm_MAXOBJECTS=
export OverrideMaxObjects=${CLIparm_OVERRIDEMAXOBJECTS}
export OverrideMaxObjectsNumber=${CLIparm_MAXOBJECTS}
export MinMaxObjectsLimit=10
export MaxMaxObjectsLimit=${AbsoluteAPIMaxObjectLimit}

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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-18


# -------------------------------------------------------------------------------------------------
# END Define command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#echo `${dtzs}`${dtzsep} 'Process Command Line Parameter Verbose Enabled' >> ${templogfilepath}
ProcessCommandLIneParameterVerboseEnable "$@"

#echo `${dtzs}`${dtzsep} 'Process Command Line Parameters and Set Values' >> ${templogfilepath}
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
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'API Subscript Completed :  '${APISubScriptName} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'API Subscript Completed :  '${APISubScriptName} >> ${logfilepath}
fi


return 0


# =================================================================================================
# END subscript:  handle command line parameters
# =================================================================================================
# =================================================================================================


