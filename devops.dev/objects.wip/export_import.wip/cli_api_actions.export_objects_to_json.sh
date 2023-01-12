#!/bin/bash
#
# (C) 2016-2023 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
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
# SCRIPT Object dump to JSON action operations for API CLI Operations
#
#
ScriptVersion=00.60.12
ScriptRevision=100
ScriptSubRevision=275
ScriptDate=2023-01-10
TemplateVersion=00.60.12
APISubscriptsLevel=010
APISubscriptsVersion=00.60.12
APISubscriptsRevision=100

#

export APIActionsScriptVersion=v${ScriptVersion}
export APIActionScriptTemplateVersion=v${TemplateVersion}

export APIActionsScriptVersionX=v${ScriptVersion//./x}
export APIActionScriptTemplateVersionX=v${TemplateVersion//./x}

ActionScriptName=cli_api_actions.export_objects_to_json
export APIActionScriptFileNameRoot=cli_api_actions.export_objects_to_json
export APIActionScriptShortName=actions.export_objects_to_json
export APIActionScriptnohupName=${APIActionScriptShortName}
export APIActionScriptDescription="Object Export to JSON action operations for API CLI Operations"

# =================================================================================================
# =================================================================================================
# START:  Export objects to json in set detail level from root script
# =================================================================================================


if ${APISCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'ActionScriptName:  '${ActionScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'ActionScriptName:  '${ActionScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} >> ${logfilepath}
fi


# =================================================================================================
# Validate Actions Script version is correct for caller
# =================================================================================================


if [ x"${APIExpectedActionScriptsVersion}" = x"${APIActionsScriptVersion}" ] ; then
    # Script and Actions Script versions match, go ahead
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Verify Actions Scripts Version - OK' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Raw Script name        : '$0 | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Subscript version name : '${APIActionsScriptVersion}' '${ActionScriptName} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Calling Script version : '${APIScriptVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Verify Actions Scripts Version - Missmatch' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Expected Action Script version : '${APIExpectedActionScriptsVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Current  Action Script version : '${APIActionsScriptVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 250
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# START:  Local Proceedures
# =================================================================================================

export actionstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log

# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-17 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #
    
    if [ -z "$1" ]; then
        # No explicit name passed for action
        export actionstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log
    else
        # explicit name passed for action
        export actionstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'$1'_'${DATEDTGS}.log
    fi
    
    if [ -w ${actionstemplogfilepath} ] ; then
        rm ${actionstemplogfilepath} >> ${logfilepath} 2>&1
    fi
    
    touch ${actionstemplogfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-17

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-10 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleShowTempLogFile () {
    #
    # HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
    #
    
    if ${APISCRIPTVERBOSE} ; then
        # verbose mode so show the logged results and copy to normal log file
        cat ${actionstemplogfilepath} | tee -a -i ${logfilepath}
    else
        # NOT verbose mode so push logged results to normal log file
        cat ${actionstemplogfilepath} >> ${logfilepath}
    fi
    
    rm ${actionstemplogfilepath} >> ${logfilepath} 2>&1
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-10

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-10 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ForceShowTempLogFile () {
    #
    # ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
    #
    
    cat ${actionstemplogfilepath} | tee -a -i ${logfilepath}
    
    rm ${actionstemplogfilepath} >> ${logfilepath} 2>&1
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-10

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Check API Keep Alive Status - CheckAPIKeepAlive
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-11:02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Check API Keep Alive Status.
#
CheckAPIKeepAlive () {
    #
    # Check API Keep Alive Status and on error try a login attempt
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    tempworklogfile=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.keepalivecheck.log
    
    if ${LoggedIntoMgmtCli} ; then
        #echo -n `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  ' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check : ... ' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        
        if ${addversion2keepalive} ; then
            #mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
            mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} > ${tempworklogfile} 2>&1
            export errorreturn=$?
        else
            #mgmt_cli keepalive -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
            mgmt_cli keepalive -s ${APICLIsessionfile} > ${tempworklogfile} 2>&1
            export errorreturn=$?
        fi
        
        cat ${tempworklogfile} >> ${logfilepath}
        rm ${tempworklogfile} >> ${logfilepath} 2>&1
        
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Keep Alive Check errorreturn = [ '${errorreturn}' ]' | tee -a -i ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli keepalive operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Lets see if we can login again' | tee -a -i ${logfilepath}
            
            export LoggedIntoMgmtCli=false
            
            . ${mgmt_cli_API_operations_handler} LOGIN "$@"
            LOGINEXITCODE=$?
            
            if [ ${LOGINEXITCODE} != 0 ] ; then
                exit ${LOGINEXITCODE}
            else
                export LoggedIntoMgmtCli=true
                export errorreturn=0
            fi
        fi
    else
        # Uhhh what, this check should only happen if logged in
        echo `${dtzs}`${dtzsep} ' Executing mgmt_cli login instead of mgmt_cli keepalive check ?!?...  ' | tee -a -i ${logfilepath}
        
        export LoggedIntoMgmtCli=false
        
        . ${mgmt_cli_API_operations_handler} LOGIN "$@"
        LOGINEXITCODE=$?
        
        if [ ${LOGINEXITCODE} != 0 ] ; then
            exit ${LOGINEXITCODE}
        else
            export LoggedIntoMgmtCli=true
            export errorreturn=0
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'Keep Alive Check completed!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-06-11:02

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Local Proceedures
# =================================================================================================


# ADDED 2018-04-25 -
export primarytargetoutputformat=${FileExtJSON}

# MODIFIED 2022-03-10 -
#
export AbsoluteAPIMaxObjectLimit=500
export MinAPIObjectLimit=50
export MaxAPIObjectLimit=${AbsoluteAPIMaxObjectLimit}
export MaxAPIObjectLimitSlowObjects=100
export DefaultAPIObjectLimitMDSMXtraSlow=50
export DefaultAPIObjectLimitMDSMSlow=100
export DefaultAPIObjectLimitMDSMMedium=250
export DefaultAPIObjectLimitMDSMFast=500
export SlowObjectAPIObjectLimitMDSMXtraSlow=25
export SlowObjectAPIObjectLimitMDSMSlow=50
export SlowObjectAPIObjectLimitMDSMMedium=100
export SlowObjectAPIObjectLimitMDSMFast=200
#export RecommendedAPIObjectLimitMDSM=200
export RecommendedAPIObjectLimitMDSM=${DefaultAPIObjectLimitMDSMMedium}
export DefaultAPIObjectLimit=${MaxAPIObjectLimit}
export DefaultAPIObjectLimitMDSM=${RecommendedAPIObjectLimitMDSM}
export DefaultAPIObjectLimitMDSMSlowObjects=${SlowObjectAPIObjectLimitMDSMSlow}


# =================================================================================================
# Start executing Main operations
# =================================================================================================

# MODIFIED 2021-10-22 -
#

# ------------------------------------------------------------------------
# Set and clear temporary log file
# ------------------------------------------------------------------------

export templogfilepath=/var/tmp/templog_${ScriptName}.`date +%Y%m%d-%H%M%S%Z`.log
echo `${dtzs}`${dtzsep} > ${templogfilepath}

echo `${dtzs}`${dtzsep} 'Configure working paths for export and dump' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}

# ------------------------------------------------------------------------

# MODIFIED 2021-10-24 -
#

#printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'X' "${X}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'MinAPIObjectLimit' "${MinAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'MaxAPIObjectLimit' "${MaxAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'RecommendedAPIObjectLimitMDSM' "${RecommendedAPIObjectLimitMDSM}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'DefaultAPIObjectLimit' "${DefaultAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'DefaultAPIObjectLimitMDSM' "${DefaultAPIObjectLimitMDSM}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'domainnamenospace' "${domainnamenospace}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'CLIparm_NODOMAINFOLDERS' "${CLIparm_NODOMAINFOLDERS}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'primarytargetoutputformat' "${primarytargetoutputformat}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLICSVExportpathbase' "${APICLICSVExportpathbase}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIpathexport' "${APICLIpathexport}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathroot' "${JSONRepopathroot}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathbase' "${JSONRepopathbase}" >> ${templogfilepath}

# ------------------------------------------------------------------------

# MODIFIED 2022-05-02:02 -

echo `${dtzs}`${dtzsep} 'Handle adding domain name = ['"${domainnamenospace}"'] to path for MDM operations' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Current APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Current JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}

if ! ${CLIparm_NODOMAINFOLDERS} ; then
    # adding domain name to path for MDM operations
    if [ ! -z "${domainnamenospace}" ] ; then
        # Handle adding domain name to path for MDM operations
        export APICLIpathexport=${APICLICSVExportpathbase}/${domainnamenospace}
        
        echo `${dtzs}`${dtzsep} 'Handle adding domain name = ['"${domainnamenospace}"'] to path for MDM operations' >> ${templogfilepath}
        echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
        
        if [ ! -r ${APICLIpathexport} ] ; then
            mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
        fi
        
        export JSONRepopathbase=${JSONRepopathroot}/${domainnamenospace}
        
        echo `${dtzs}`${dtzsep} 'Handle adding domain name = ['"${domainnamenospace}"'] to JSON repository path for MDM operations' >> ${templogfilepath}
        echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
        
        if [ ! -r ${JSONRepopathbase} ] ; then
            mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>> ${templogfilepath}
        fi
    else
        # Domain name is empty so not adding
        export APICLIpathexport=${APICLICSVExportpathbase}
        
        echo `${dtzs}`${dtzsep} 'Handle empty domain name to path for MDM operations, so NO CHANGE' >> ${templogfilepath}
        echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
        
        if [ ! -r ${APICLIpathexport} ] ; then
            mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
        fi
        
        export JSONRepopathbase=${JSONRepopathroot}
        
        echo `${dtzs}`${dtzsep} 'Handle empty domain name to JSON repository path for MDM operations, so NO CHANGE' >> ${templogfilepath}
        echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
        
        if [ ! -r ${JSONRepopathbase} ] ; then
            mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>> ${templogfilepath}
        fi
    fi
else
    # NOT adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}
    
    echo `${dtzs}`${dtzsep} 'NOT adding domain name = ['"${domainnamenospace}"'] to path for MDM operations' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
    fi
    
    export JSONRepopathbase=${JSONRepopathroot}
    
    echo `${dtzs}`${dtzsep} 'NOT adding domain name = ['"${domainnamenospace}"'] to JSON repository path for MDM operations' >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
    
    if [ ! -r ${JSONRepopathbase} ] ; then
        mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>> ${templogfilepath}
    fi
fi

echo `${dtzs}`${dtzsep} 'Final APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Final JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------
# This section is specific to scripts that ARE action handlers
# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
#

# primary operation is export to primarytargetoutputformat
export APICLIpathexport=${APICLIpathexport}/${primarytargetoutputformat}

echo `${dtzs}`${dtzsep} | tee -a -i ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Export to '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}

if [ ! -r ${APICLIpathexport} ] ; then
    mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
fi

echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'After Evaluation of script type' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
#

if [ x"${primarytargetoutputformat}" = x"${FileExtJSON}" ] ; then
    # for JSON provide the detail level
    
    export APICLIpathexport=${APICLIpathexport}/${APICLIdetaillvl}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>> ${templogfilepath}
    fi
    
    export APICLIJSONpathexportwip=
    if ${script_uses_wip_json} ; then
        # script uses work-in-progress (wip) folder for json
        
        export APICLIJSONpathexportwip=${APICLIpathexport}/wip
        
        if [ ! -r ${APICLIJSONpathexportwip} ] ; then
            mkdir -p -v ${APICLIJSONpathexportwip} >> ${templogfilepath} 2>> ${templogfilepath}
        fi
    fi
else
    export APICLIJSONpathexportwip=
fi

echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'After handling json target' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'APICLIJSONpathexportwip = '${APICLIJSONpathexportwip} >> ${templogfilepath}

# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
#

if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
    # for CSV handle specifics, like wip
    
    export APICLICSVpathexportwip=
    if ${script_uses_wip} ; then
        # script uses work-in-progress (wip) folder for csv
        
        export APICLICSVpathexportwip=${APICLIpathexport}/wip
        
        if [ ! -r ${APICLICSVpathexportwip} ] ; then
            mkdir -p -v ${APICLICSVpathexportwip} >> ${templogfilepath} 2>> ${templogfilepath}
        fi
    fi
else
    export APICLICSVpathexportwip=
fi

echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'After handling csv target' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'APICLICSVpathexportwip = '${APICLICSVpathexportwip} >> ${templogfilepath}

# ------------------------------------------------------------------------

# MODIFIED 2021-10-25 -
#

export APICLIfileexportpost='_'${APICLIdetaillvl}'_'${APICLIfileexportsuffix}

export APICLICSVheaderfilesuffix=header

export APICLICSVfileexportpost='_'${APICLIdetaillvl}'_'${APICLICSVfileexportsuffix}

export APICLIJSONheaderfilesuffix=header
export APICLIJSONfooterfilesuffix=footer

export APICLIJSONfileexportpost='_'${APICLIdetaillvl}'_'${APICLIJSONfileexportsuffix}

# In export operations, we do not utilize the details level of other than "standard" export types, so either "full" or "standard"
export JSONRepoDetailname=${APICLIdetaillvl}
case ${APICLIdetaillvl} in
    'full' )
        export JSONRepoDetailname=${APICLIdetaillvl}
        ;;
    'standard' )
        export JSONRepoDetailname=${APICLIdetaillvl}
        ;;
    * )
        export JSONRepoDetailname='full'
        ;;
esac

export JSONRepofilepost='_'${JSONRepoDetailname}'_'${JSONRepofilesuffix}

#printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'X' "${X}" >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Setup other file and path variables' >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIfileexportpost' "${APICLIfileexportpost}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLICSVheaderfilesuffix' "${APICLICSVheaderfilesuffix}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLICSVfileexportpost' "${APICLICSVfileexportpostX}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIJSONheaderfilesuffix' "${APICLIJSONheaderfilesuffix}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIJSONfooterfilesuffix' "${APICLIJSONfooterfilesuffix}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIJSONfileexportpost' "${APICLIJSONfileexportpost}" >> ${templogfilepath}

# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
#

echo `${dtzs}`${dtzsep} >> ${templogfilepath}

cat ${templogfilepath} >> ${logfilepath} 2>&1
rm -v ${templogfilepath} >> ${logfilepath} 2>&1

# ------------------------------------------------------------------------

# MODIFIED 2021-10-24 -
#

#printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'X' "${X}" >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Working operations file and path variables' >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'MinAPIObjectLimit' "${MinAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'MaxAPIObjectLimit' "${MaxAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'RecommendedAPIObjectLimitMDSM' "${RecommendedAPIObjectLimitMDSM}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'DefaultAPIObjectLimit' "${DefaultAPIObjectLimit}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'DefaultAPIObjectLimitMDSM' "${DefaultAPIObjectLimitMDSM}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'primarytargetoutputformat' "${primarytargetoutputformat}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIpathexport' "${APICLIpathexport}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathroot' "${JSONRepopathroot}" >> ${templogfilepath}
printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathbase' "${JSONRepopathbase}" >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}

# ------------------------------------------------------------------------

# ------------------------------------------------------------------------

# MODIFIED 2021-10-22 -
#

echo `${dtzs}`${dtzsep} 'Dump "'${APICLIdetaillvl}'" details to path:  '${APICLIpathexport} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# MODIFIED 2021-10-22 -


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Main Operational repeated proceedures - Export Objects to JSON
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Configure mgmt_cli operational show parameters - ConfigureMgmtCLIOperationalParametersExport
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-12:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Configure mgmt_cli operational show parameters.
#
ConfigureMgmtCLIOperationalParametersExport () {
    #
    # Configure mgmt_cli operational show parameters
    #
    
    errorreturn=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Procedure ConfigureMgmtCLIOperationalParametersExport Starting!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}' --conn-timeout '${APICLIconntimeout}
    
    #export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    export MgmtCLI_IgnoreErr_OpParms='--ignore-errors true'
    if ${APIobjectcanignoreerror} ; then
        export MgmtCLI_IgnoreErr_OpParms='ignore-errors true '${MgmtCLI_IgnoreErr_OpParms}
    fi
    if ${APIobjectcanignorewarning} ; then
        export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true '${MgmtCLI_IgnoreErr_OpParms}
    fi
    
    if ${APIobjectusesdetailslevel} ; then
        #export MgmtCLI_Show_OpParms='details-level "'${WorkingAPICLIdetaillvl}'" '${MgmtCLI_IgnoreErr_OpParms}' '${MgmtCLI_Base_OpParms}
        export MgmtCLI_Show_OpParms='details-level "'${WorkingAPICLIdetaillvl}'" '${MgmtCLI_Base_OpParms}
    else
        #export MgmtCLI_Show_OpParms=${MgmtCLI_IgnoreErr_OpParms}' '${MgmtCLI_Base_OpParms}
        export MgmtCLI_Show_OpParms=${MgmtCLI_Base_OpParms}
    fi
    
    if ${APIobjectderefgrpmem} ; then
        export MgmtCLI_Show_OpParms='dereference-group-members true '${MgmtCLI_Show_OpParms}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_Base_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_Base_OpParms} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectcanignoreerror' ' : ' >> ${logfilepath} ; echo ${APIobjectcanignoreerror} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectcanignorewarning' ' : ' >> ${logfilepath} ; echo ${APIobjectcanignorewarning} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_IgnoreErr_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_IgnoreErr_OpParms} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'WorkingAPICLIdetaillvl' ' : ' >> ${logfilepath} ; echo ${WorkingAPICLIdetaillvl} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectusesdetailslevel' ' : ' >> ${logfilepath} ; echo ${APIobjectusesdetailslevel} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_Show_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_Show_OpParms} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Procedure ConfigureMgmtCLIOperationalParametersExport completed!  errorreturn = '${errorreturn} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-06-12:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureObjectQuerySelector - Configure Object Query Selector value objectqueryselector
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-18:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ConfigureObjectQuerySelector () {
    #
    
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} ' -- ConfigureObjectQuerySelector:' >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'XX' "${XX}" >> ${logfilepath}
    #echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'XX' ' : ' >> ${logfilepath} ; echo ${XX} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure specific object selection query elements
    # -------------------------------------------------------------------------------------------------
    
    # Reference Example for the new objecttype specific criteria from the criteria based exports in the complex objects
    
    #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" == "'"${APICLIexportcriteria01value}"'"'
    # For the Boolean values of ${APICLIexportcriteria01value} we need to check that the text value is true or folse, to be specific
    #if [ "${APICLIexportcriteria01value}" == "true" ] ; then 
        # The value of ${APICLIexportcriteria01value} is boolean true, so check if the value of ${APICLIexportcriteria01key} is true
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'"' 
    #elif [ "${APICLIexportcriteria01value}" == "false" ] ; then 
        # The value of ${APICLIexportcriteria01value} is boolean false, so check if the value of ${APICLIexportcriteria01key} is not true
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" | not'
    #else 
        # The value of ${APICLIexportcriteria01value} is a string, not boolean, so check if the value of ${APICLIexportcriteria01key} is the same
        #export objecttypecriteriaselectorelement='."'"${APICLIexportcriteria01key}"'" == "'"${APICLIexportcriteria01value}"'"'
    #fi
    
    #echo `${dtzs}`${dtzsep} '    - APICLIexportcriteria01value       :  '${APICLIexportcriteria01value} >> ${logfilepath}
    #echo `${dtzs}`${dtzsep} '    - APICLIexportcriteria01value       :  '${APICLIexportcriteria01value} >> ${logfilepath}
    #echo `${dtzs}`${dtzsep} '    - objecttypecriteriaselectorelement :  '${objecttypecriteriaselectorelement} >> ${logfilepath}
    
    # MODIFIED 2022-06-13 -
    
    export objecttypeselectorelement=
    
    if [ x"${APIobjectspecificselector00key}" == x"" ] ; then
        # The value of ${APIobjectspecificselector00key} is empty
        export objecttypeselectorelement=
    elif [ x"${APIobjectspecificselector00value}" == x"" ] ; then
        # The value of ${APIobjectspecificselector00value} is empty
        export objecttypeselectorelement=
    elif [ "${APIobjectspecificselector00value}" == "true" ] ; then 
        # The value of ${APIobjectspecificselector00value} is boolean true, so check if the value of ${APICLIexportcriteria01key} is true
        #export objecttypeselectorelement='."'"${APIobjectspecificselector00key}"'"' 
        export objecttypeselectorelement=${APIobjectspecificselector00key}
    elif [ "${APIobjectspecificselector00value}" == "false" ] ; then 
        # The value of ${APIobjectspecificselector00value} is boolean false, so check if the value of ${APICLIexportcriteria01key} is not true
        #export objecttypeselectorelement='."'"${APIobjectspecificselector00key}"'" | not'
        export objecttypeselectorelement=${APIobjectspecificselector00key}' | not'
    else 
        # The value of ${APIobjectspecificselector00key} is a string, not boolean or empty so we assume ${APIobjectspecificselector00value} is the target value
        if [ x"${APIobjectspecificselector00value}" != x"" ] ; then
            #export objecttypeselectorelement='."'"${APIobjectspecificselector00key}"'" == "'"${APIobjectspecificselector00value}"'"'
            export objecttypeselectorelement=${APIobjectspecificselector00key}' == "'"${APIobjectspecificselector00value}"'"'
        else
            echo `${dtzs}`${dtzsep} ' -- APIobjectspecificselector00key Passed EMPTY!' >> ${logfilepath}
            export objecttypeselectorelement=
        fi
    fi
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'APIobjectspecificselector00key' ${APIobjectspecificselector00key} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'APIobjectspecificselector00value' ${APIobjectspecificselector00value} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'objecttypeselectorelement' ${objecttypeselectorelement} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectspecificselector00key' ' : ' >> ${logfilepath} ; echo ${APIobjectspecificselector00key} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectspecificselector00value' ' : ' >> ${logfilepath} ; echo ${APIobjectspecificselector00value} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'objecttypeselectorelement' ' : ' >> ${logfilepath} ; echo ${objecttypeselectorelement} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure specific query elements for system object selection
    # -------------------------------------------------------------------------------------------------
    
    # Current alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    
    # selector for objects created by customer and not from Check Point
    
    export notsystemobjectselector='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not'
    
    # based on some interesting feedback, adding ability to dump only system objects, not created by customer
    
    export onlysystemobjectselector='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a)'
    
    # also handle the specifics around whether meta-info.creator is or is not "System"
    
    export notcreatorissystemselector='."meta-info"."creator" != "System"'
    
    export creatorissystemselector='."meta-info"."creator" = "System"'
    
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'systemobjectdomains' ${systemobjectdomains} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'notsystemobjectselector' ${notsystemobjectselector} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'onlysystemobjectselector' ${onlysystemobjectselector} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'notcreatorissystemselector' ${notcreatorissystemselector} >> ${logfilepath}
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'creatorissystemselector' ${creatorissystemselector} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'systemobjectdomains' ' : ' >> ${logfilepath} ; echo ${systemobjectdomains} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'notsystemobjectselector' ' : ' >> ${logfilepath} ; echo ${notsystemobjectselector} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'onlysystemobjectselector' ' : ' >> ${logfilepath} ; echo ${onlysystemobjectselector} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'notcreatorissystemselector' ' : ' >> ${logfilepath} ; echo ${notcreatorissystemselector} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'creatorissystemselector' ' : ' >> ${logfilepath} ; echo ${creatorissystemselector} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    printf "`${dtzs}`${dtzsep}    - %-40s  : %s\n" 'NoSystemObjects' ${NoSystemObjects} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s  : %s\n" 'OnlySystemObjects' ${OnlySystemObjects} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s  : %s\n" 'CreatorIsNotSystem' ${CreatorIsNotSystem} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}    - %-40s  : %s\n" 'CreatorIsSystem' ${CreatorIsSystem} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure Object Query Selector element value systemobjectqueryselectorelement
    # -------------------------------------------------------------------------------------------------
    
    export systemobjectqueryselectorelement=
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        if ${CreatorIsNotSystem} ; then
            # Ignore System Objects and no creator = System
            export systemobjectqueryselectorelement='( '"${notsystemobjectselector}"' ) and ( '"${notcreatorissystemselector}"' )'
        else
            # Ignore System Objects
            export systemobjectqueryselectorelement=${notsystemobjectselector}
        fi
    elif ${OnlySystemObjects} ; then
        # Select only System Objects
        if ${CreatorIsSystem} ; then
            # select only System Objects and creator = System
            export systemobjectqueryselectorelement='( '"${onlysystemobjectselector}"' ) and ( '"${creatorissystemselector}"' )'
        else
            # select only System Objects
            export systemobjectqueryselectorelement=${onlysystemobjectselector}
        fi
    else
        # Include System Objects
        if ${CreatorIsNotSystem} ; then
            # Include System Objects and no creator = System
            export systemobjectqueryselectorelement=${notcreatorissystemselector}
        elif ${CreatorIsSystem} ; then
            # Include System Objects and no creator = System
            export systemobjectqueryselectorelement=${creatorissystemselector}
        else
            # Include System Objects
            export systemobjectqueryselectorelement=
        fi
    fi
    
    #printf "`${dtzs}`${dtzsep}    - %-40s : %s\n" 'systemobjectqueryselectorelement' ${systemobjectqueryselectorelement} >> ${logfilepath}
    echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'systemobjectqueryselectorelement' ' : ' >> ${logfilepath} ; echo ${systemobjectqueryselectorelement} >> ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure Object Query Selector value objectqueryselector
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-06-18 -
    
    export objectqueryselector=
    
    if [ x"${objecttypeselectorelement}" != x"" ] ; then
        # ${objecttypeselectorelement} is not empty, so we have a starting selector
        export objectqueryselector='select( '
        if [ x"${systemobjectqueryselectorelement}" != x"" ] ; then
            # ${objecttypeselectorelement} is not empty, so we have a starting selector
            export objectqueryselector=${objectqueryselector}'( '"${objecttypeselectorelement}"' )'
            export objectqueryselector=${objectqueryselector}' and ( '"${systemobjectqueryselectorelement}"' )'
        else
            export objectqueryselector=${objectqueryselector}"${objecttypeselectorelement}"
        fi
        export objectqueryselector=${objectqueryselector}' )'
    else
        if [ x"${systemobjectqueryselectorelement}" != x"" ] ; then
            # ${objecttypeselectorelement} is not empty, so we have a starting selector
            export objectqueryselector='select( '
            export objectqueryselector=${objectqueryselector}"${systemobjectqueryselectorelement}"
            export objectqueryselector=${objectqueryselector}' )'
        fi
    fi
    
    echo `${dtzs}`${dtzsep} '    - Object Query Selector = ['${objectqueryselector}']' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-18:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational repeated proceedure - HandleJSONRepositoryUpdate
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-07-12:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Handle placement of final object JSON file into standing current object repository
#

HandleJSONRepositoryUpdate () {
    #
    # Handle placement of final object JSON file into standing current object repository
    #
    
    errorreturn=0
    
    export JSONRepopathworking=
    export JSONRepoFileexport=
    
    # In export operations, we do not utilize the details level of other than "standard" export types, so either "full" or "standard"
    export JSONRepoDetailname=${APICLIdetaillvl}
    case ${APICLIdetaillvl} in
        'full' )
            export JSONRepoDetailname=${APICLIdetaillvl}
            ;;
        'standard' )
            export JSONRepoDetailname=${APICLIdetaillvl}
            ;;
        * )
            export JSONRepoDetailname='full'
            ;;
    esac
    
    echo `${dtzs}`${dtzsep} 'Using the following details level for the JSON Repository = '${JSONRepoDetailname} >> ${logfilepath}
    
    if ${script_save_json_repo} ; then
        # check if we are updating the json object repository
        echo `${dtzs}`${dtzsep} 'Update JSON Repository File' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
                # In CSV export operations, we do not utilize the ${APICLIdetaillvl}.NoSystemObjects to ensure we harvest from the repository
                export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
            else
                export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}.NoSystemObjects
            fi
        elif ${OnlySystemObjects} ; then
            if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
                # In CSV export operations, we do not utilize the ${APICLIdetaillvl}.OnlySystemObjects to ensure we harvest from the repository
                export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
            else
                export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}.OnlySystemObjects
            fi
        else
            export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
        fi
        
        if [ ! -r ${JSONRepopathworking} ] ; then
            mkdir -p -v ${JSONRepopathworking} >> ${logfilepath} 2>&1
            chmod 775 ${JSONRepopathworking} >> ${logfilepath} 2>&1
        else
            chmod 775 ${JSONRepopathworking} >> ${logfilepath} 2>&1
        fi
        
        export JSONRepofilepost='_'${JSONRepoDetailname}'_'${JSONRepofilesuffix}
        
        export JSONRepoFileexport=${JSONRepopathworking}/${JSONRepofilepre}${Finaljsonfilename}${JSONRepofilepost}
        
        echo `${dtzs}`${dtzsep} 'Copy Final Export JSON file "'${Finaljsonfileexport}'"' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  to JSON Repository file "'${JSONRepoFileexport}'"' | tee -a -i ${logfilepath}
        cp -fv ${Finaljsonfileexport} ${JSONRepoFileexport} >> ${logfilepath} 2>&1
        
    fi
    
    echo `${dtzs}`${dtzsep} 'HandleJSONRepositoryUpdate procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-07-12:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SlurpJSONFilesIntoSingleFile :  Use JQ to Slurp JSON files into single JSON file from multiple files
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-10-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SlurpJSONFilesIntoSingleFile () {
    #
     
    export Slurpuglyfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpuglyfilename=${Slurpuglyfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpuglyfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpuglyfilename}'.ugly.'${APICLIfileexportpost}
    
    export Slurpprettyfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpprettyfilename=${Slurpprettyfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpprettyfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpprettyfilename}'.pretty.'${APICLIfileexportpost}
    
    export Slurpfinalfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpfinalfilename=${Slurpfinalfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpfinalfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpfinalfilename}'.final.'${APICLIfileexportpost}
    
    # Single Line entries
    #printf 'variable :  %-25s = %s\n' "x" ${x} >> ${logfilepath}
    #printf '%-35s$ : %s\n' "x" 'x' >> ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Execute SlurpJSONFilesIntoSingleFile for objects type '${APICLIobjectstype} | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        #printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpstarfilefqpn" ${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'variable :  Slurpstarfilefqpn         = '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Finaljsonfileexport" ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpworkfolder" ${Slurpworkfolder} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpuglyfilefqpn" ${Slurpuglyfilefqpn} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpuglyfilename" ${Slurpuglyfilename} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpprettyfilefqpn" ${Slurpprettyfilefqpn} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpprettyfilename" ${Slurpprettyfilename} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpfinalfilefqpn" ${Slurpfinalfilefqpn} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpfinalfilename" ${Slurpfinalfilename} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIexportnameaddon" ${APICLIexportnameaddon} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIpathexport" ${APICLIpathexport} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIfileexportpre" ${APICLIfileexportpre} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIfileexportpost" ${APICLIfileexportpost} | tee -a -i ${logfilepath}
    else
        #printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpstarfilefqpn" ${Slurpstarfilefqpn} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'variable :  Slurpstarfilefqpn        = '${Slurpstarfilefqpn} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Finaljsonfileexport" ${Finaljsonfileexport} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpworkfolder" ${Slurpworkfolder} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpuglyfilefqpn" ${Slurpuglyfilefqpn} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpuglyfilename" ${Slurpuglyfilename} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpprettyfilefqpn" ${Slurpprettyfilefqpn} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpprettyfilename" ${Slurpprettyfilename} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpfinalfilefqpn" ${Slurpfinalfilefqpn} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpfinalfilename" ${Slurpfinalfilename} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIexportnameaddon" ${APICLIexportnameaddon} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIpathexport" ${APICLIpathexport} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIfileexportpre" ${APICLIfileexportpre} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIfileexportpost" ${APICLIfileexportpost} >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo '----------------------------------------------------------------------' >> ${logfilepath}
    ls -alh ${Slurpstarfilefqpn} >> ${logfilepath}
    echo '----------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Use jq to slurp '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
    
    ${JQ} -s '.' ${Slurpstarfilefqpn} > ${Slurpuglyfilefqpn}
    #rm -rf test*.json
    
    SLURP_TOTAL=`cat ${Slurpuglyfilefqpn} | ${JQ} '.[].uid' | sort -u | wc -l`
    echo `${dtzs}`${dtzsep} 'Data output to '${Finaljsonfileexport}' with '${SLURP_TOTAL}' elements' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Total elements from first query is '${objectstotal}' elements' | tee -a -i ${logfilepath}
    
    # Make it pretty again
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Make it pretty' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo '{ ' > ${Slurpprettyfilefqpn}
    echo -n '  "objects": ' >> ${Slurpprettyfilefqpn}
    
    # need a way to read lines and dump them out
    
    #COUNTER=0
    
    #while read -r line; do
        #if [ ${COUNTER} -eq 0 ]; then
            ## Line 0 first line we don't want to add a return yet
            #echo -n 'Start:.'
        #else
            ## Lines 1+ are the data
            #echo >> ${Slurpprettyfilefqpn}
            ##if ${APISCRIPTVERBOSE} ; then
                ##echo -n '.'
            ##fi
        #fi
        
        ##Write the line, but not the carriage return
        #echo -n "${line}" >> ${Slurpprettyfilefqpn}
        #let COUNTER=COUNTER+1
    #done < ${Slurpuglyfilefqpn}
    
    #echo
    
    # This method is much faster and works too, since Slurpuglyfilefqpn is already an array with good formatting
    cat ${Slurpuglyfilefqpn} >> ${Slurpprettyfilefqpn}
    
    #Write the last comma after the original json file that is not pretty
    echo ',' >> ${Slurpprettyfilefqpn}
    echo '  "from": 0,' >> ${Slurpprettyfilefqpn}
    echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpprettyfilefqpn}
    echo '  "total": '${SLURP_TOTAL} >> ${Slurpprettyfilefqpn}
    echo '}' >> ${Slurpprettyfilefqpn}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        #head -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json; echo `${dtzs}`${dtzsep} '...'; tail -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
        head -n 10 ${Slurpprettyfilefqpn} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        tail -n 10 ${Slurpprettyfilefqpn} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        #head -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json; echo `${dtzs}`${dtzsep} '...'; tail -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
        head -n 10 ${Slurpprettyfilefqpn} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        #echo `${dtzs}`${dtzsep} >> ${logfilepath}
        #echo '----------------------------------------------------------------------' >> ${logfilepath}
        tail -n 10 ${Slurpprettyfilefqpn} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Now make it really pretty' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    ${JQ} -s '.[]' ${Slurpprettyfilefqpn} > ${Slurpfinalfilefqpn}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        head -n 10 ${Slurpfinalfilefqpn} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        tail -n 10 ${Slurpfinalfilefqpn} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        head -n 10 ${Slurpfinalfilefqpn} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        #echo `${dtzs}`${dtzsep} >> ${logfilepath}
        #echo '----------------------------------------------------------------------' >> ${logfilepath}
        tail -n 10 ${Slurpfinalfilefqpn} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} | >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'Copy Final slurped JSON file "'${Slurpfinalfilefqpn}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  to JSON Results file "'${Finaljsonfileexport}'"' | tee -a -i ${logfilepath}
    cp -fv ${Slurpfinalfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
    
    if ${APISCRIPTVERBOSE} ; then
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-21


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Prepare operations to Slurp JSON files - PrepareToSlurpJSONFiles
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-12:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Prepare operations to Slurp JSON files.
#
PrepareToSlurpJSONFiles () {
    #
    # Prepare operations to Slurp JSON files
    #
    
    errorreturn=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Procedure PrepareToSlurpJSONFiles Starting!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    export Slurpstarfilename=
    export Slurpstarfilefqpn=
    export Finaljsonfilename=
    export Finaljsonfileexport=
    
    export Finaljsonfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Finaljsonfilename=${Finaljsonfilename}'_'${APICLIexportnameaddon}
    fi
    export Finaljsonfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Finaljsonfilename}${APICLIfileexportpost}
    
    # MODIFIED  -
    
    if ${DoFileSlurp} ; then
        # Slurp the collection of JSON files into a single JSON already
        
        export Slurpstarfilename=${APICLIobjectstype}
        if [ x"${APICLIexportnameaddon}" != x"" ] ; then
            export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
        fi
        export Slurpstarfilename=${Slurpstarfilename}'_*_of_'${objectstotalformatted}
        export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
        
        echo `${dtzs}`${dtzsep} '  Multiple JSON files created, need to SLURP together the file!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp these files     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        
        #SlurpJSONFilesIntoSingleFile ${Slurpstarfilefqpn} ${Finaljsonfileexport}
        SlurpJSONFilesIntoSingleFile
        
        # Handle placement of final object JSON file into standing current object repository next
    else
        # File is single JSON already
        # Handle placement of final object JSON file into standing current object repository next
        if ${NoSystemObjects} ; then
            # When working with only non-System objects, the process generates a broken json file that needs to be fixed
            # fixing the broken json file is done via the Slurp process, but we only have a single file versus a collection;
            # however, we need to still set things up for operation
            
            # Slurp the single JSON files into a single JSON already
            
            export Slurpstarfilename=${APICLIobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
            fi
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_NSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                # copy the broken json file as the slurpstar file to the slurp work area
                cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
                
                echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
                
                #SlurpJSONFilesIntoSingleFile ${Slurpstarfilefqpn} ${Finaljsonfileexport}
                SlurpJSONFilesIntoSingleFile
            else
                # exported json file is zero length, so process build manual file
                export SLURP_TOTAL=0
                
                echo '{ ' > ${Slurpstarfilefqpn}
                echo '  "objects": [],' >> ${Slurpstarfilefqpn}
                echo '  "from": 0,' >> ${Slurpstarfilefqpn}
                echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpstarfilefqpn}
                echo '  "total": '${SLURP_TOTAL} >> ${Slurpstarfilefqpn}
                echo '}' >> ${Slurpstarfilefqpn}
                
                #cp -fv ${Slurpstarfilefqpn} ${APICLIfileexport} >> ${logfilepath} 2>&1
                cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
            fi
            
            # Handle placement of final object JSON file into standing current object repository next
        elif ${OnlySystemObjects} ; then
            # When working with only System objects, the process generates a broken json file that needs to be fixed
            # fixing the broken json file is done via the Slurp process, but we only have a single file versus a collection;
            # however, we need to still set things up for operation
            
            # Slurp the single JSON files into a single JSON already
            
            export Slurpstarfilename=${APICLIobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
            fi
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_OSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                # copy the broken json file as the slurpstar file to the slurp work area
                cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
                
                echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
                
                #SlurpJSONFilesIntoSingleFile ${Slurpstarfilefqpn} ${Finaljsonfileexport}
                SlurpJSONFilesIntoSingleFile
            else
                # exported json file is zero length, so process build manual file
                export SLURP_TOTAL=0
                
                echo '{ ' > ${Slurpstarfilefqpn}
                echo '  "objects": [],' >> ${Slurpstarfilefqpn}
                echo '  "from": 0,' >> ${Slurpstarfilefqpn}
                echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpstarfilefqpn}
                echo '  "total": '${SLURP_TOTAL} >> ${Slurpstarfilefqpn}
                echo '}' >> ${Slurpstarfilefqpn}
                
                #cp -fv ${Slurpstarfilefqpn} ${APICLIfileexport} >> ${logfilepath} 2>&1
                cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
            fi
            
            # Handle placement of final object JSON file into standing current object repository next
        else
            #echo `${dtzs}`${dtzsep} '  Only single JSON file created, no need to SLURP together the file!' | tee -a -i ${logfilepath}
            #if [ x"${APICLIfileexport}" != x"${Finaljsonfileexport}" ] ; then
            #    # Making sure we have the final output file in the correct name and at the correct path
            #    cp -fv ${APICLIfileexport} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
            #fi
            
            # Apparently a problem was introduced with the last update, the process generates a broken json file that needs to be fixed
            # fixing the broken json file is done via the Slurp process, but we only have a single file versus a collection;
            # however, we need to still set things up for operation
            
            # Slurp the single JSON files into a single JSON already
            
            export Slurpstarfilename=${APICLIobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
            fi
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                # copy the broken json file as the slurpstar file to the slurp work area
                cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
                
                echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
                
                #SlurpJSONFilesIntoSingleFile ${Slurpstarfilefqpn} ${Finaljsonfileexport}
                SlurpJSONFilesIntoSingleFile
            else
                # exported json file is zero length, so process build manual file
                export SLURP_TOTAL=0
                
                echo '{ ' > ${Slurpstarfilefqpn}
                echo '  "objects": [],' >> ${Slurpstarfilefqpn}
                echo '  "from": 0,' >> ${Slurpstarfilefqpn}
                echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpstarfilefqpn}
                echo '  "total": '${SLURP_TOTAL} >> ${Slurpstarfilefqpn}
                echo '}' >> ${Slurpstarfilefqpn}
                
                #cp -fv ${Slurpstarfilefqpn} ${APICLIfileexport} >> ${logfilepath} 2>&1
                cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
            fi
            
            # Handle placement of final object JSON file into standing current object repository next
        fi
    fi
    
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Procedure PrepareToSlurpJSONFiles completed!  errorreturn = '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-06-12:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - ExportObjectToJSONStandard
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-10-27:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Export Objects with utilization of limits and details-level as a standard to JSON
#

ExportObjectToJSONStandard () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APICLIobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    if [ ${objectstotal} -gt ${WorkAPIObjectLimit} ] ; then
        export DoFileSlurp=true
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  JSON File Slurp required...' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  JSON File Slurp required...' >> ${logfilepath}
        fi
    else
        export DoFileSlurp=false
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  JSON File Slurp NOT required...' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  JSON File Slurp NOT required...' >> ${logfilepath}
        fi
    fi
    
    objectstotalformatted=`printf "%05d" ${objectstotal}`
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        
        nextoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        
        #if [ ${currentoffset} -gt 0 ] ; then
        #    # Export file for the next ${WorkAPIObjectLimit} objects
        #    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APICLIobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
        #fi
        
        currentoffsetformatted=`printf "%05d" ${currentoffset}`
        nextoffsetformatted=`printf "%05d" ${nextoffset}`
        
        # 2017-11-20 Updating naming of files for multiple ${WorkAPIObjectLimit} chunks to clean-up name listing
        if [ ${objectstotal} -gt ${WorkAPIObjectLimit} ] ; then
            # Export file for the next ${WorkAPIObjectLimit} objects
            export APICLIfilename=${APICLIobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
            fi
            
            #export APICLIfilename=${APICLIfilename}'_'${currentoffset}'-'${nextoffset}'_of_'${objectstotal}
            export Workingfilename=${APICLIfilename}'_'${currentoffsetformatted}'-'${nextoffsetformatted}'_of_'${objectstotalformatted}
            
            #export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APICLIobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
            export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
            export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${APICLIfilename}'_00000-'${objectstotalformatted}'_last'${APICLIJSONfileexportpost}
            
            export Slurpworkfileexport=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
        fi
        
        echo `${dtzs}`${dtzsep} '  Now processing up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentoffset}' to '${nextoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} >> ${logfilepath}
        fi
        
        # Operational Steps
        # 1.  Export required object data for objecttype to working JSON file ${APICLIJSONfilelast}
        # 2.  Based on export type, so NoSystemsObjects, OnlySystemObjects, or all objects, execute dump of ${APICLIJSONfilelast} through jq using potential object selectors, to export file ${APICLIfileexport}
        # 3.  If needed, copy file for slurp operation to ${Slurpworkfileexport} 
        
        # MODIFIED  -
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}" >> ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '. | '"${notsystemobjectselector}" >> ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '. | '"${notsystemobjectselector}" > ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}" > ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} >> ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLIfileexport}
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} >> ${logfilepath}
        fi
        
        mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLIJSONfilelast}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLIJSONfilelast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLIJSONfilelast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # MODIFIED  -
        
        # MODIFIED 2022-06-17
        #
        
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      No System Objects.  Selector = '${objectqueryselector} | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        elif ${OnlySystemObjects} ; then
            # Select only System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      Only System Objects.  Selector = '${objectqueryselector} | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        elif [ x"${objectqueryselector}" != x"" ] ; then
            # Don't forget to handle cases where object types need selection criteria handled
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      Selected objects based on object type criteria' | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        else
            # Don't Ignore System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      All objects, including System Objects' | tee -a -i ${logfilepath}
            fi
            
            # Processing the file through jq stripping the objects creates a problem file
            cat ${APICLIJSONfilelast} | jq '.objects[]' > ${APICLIfileexport}
            #cat ${APICLIJSONfilelast} > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        fi
        
        if ${DoFileSlurp} ; then
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                echo `${dtzs}`${dtzsep} '      Dump to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                #cat ${APICLIfileexport} | jq '.objects[]' > ${Slurpworkfileexport}
                cp -fv ${APICLIfileexport} ${Slurpworkfileexport} >> ${logfilepath} 2>&1
            else
                # exported json file is zero length, so do not process file for slurp
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} >> ${logfilepath}
                fi
            fi
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        #currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        currentoffset=${nextoffset}
        
        # MODIFIED 2022-02-15 -
        
        CheckAPIKeepAlive
        
    done
    
    # MODIFIED 2022-07-12 -
    
    PrepareToSlurpJSONFiles
    
    # Handle placement of final object JSON file into standing current object repository
    
    HandleJSONRepositoryUpdate
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Head (5) and Tail (5) of the export file : '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        #tail ${APICLIfileexport} | tee -a -i ${logfilepath}
        head -n 5 ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo '...' | tee -a -i ${logfilepath}
        tail -n 5 ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Head (5) and Tail (5) of the export file : '${Finaljsonfileexport} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        #tail ${APICLIfileexport} >> ${logfilepath}
        head -n 5 ${Finaljsonfileexport} >> ${logfilepath}
        echo '...' >> ${logfilepath}
        tail -n 5 ${Finaljsonfileexport} >> ${logfilepath}
        echo >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >>  ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-10-27:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportRAWObjectToJSON
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjecttype} details is exported to a json at the ${APICLIdetaillvl}.

ExportRAWObjectToJSON () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 0
    fi
    
    if ! ${APIobjectdoexportJSON} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support JSON EXPORT!  APIobjectdoexportJSON = '${APIobjectdoexportJSON} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 0
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ "${APICLIdetaillvl}" == "standard" ] ; then
        # Need to check if we have object type selector values, since that won't work with details-level standard!
        if [ x"${APIobjectspecificselector00key}" != x"" ] ; then
            # OK, need to skip this because we can't process this with detials-level "standard"
            echo `${dtzs}`${dtzsep} 'Object type :  '${APICLIobjectstype}' has defined object type selectors set, but details-level is "'${APICLIdetaillvl}'", so skipping to avoid fail!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    # MODIFIED 2022-09-14 -
    
    if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        export WorkAPIObjectLimit=1
        echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit set to '${WorkAPIObjectLimit}' because this object is singular and special' | tee -a -i ${logfilepath}
    else
        export WorkAPIObjectLimit=${MaxAPIObjectLimit}
        if [ -z "${domainnamenospace}" ] ; then
            # an empty ${domainnamenospace} indicates that we are not working towards an MDSM
            export WorkAPIObjectLimit=${APIobjectrecommendedlimit}
        else
            # an empty ${domainnamenospace} indicates that we are working towards an MDSM
            export WorkAPIObjectLimit=${APIobjectrecommendedlimitMDSM}
        fi
        
        echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
        
        if ${OverrideMaxObjects} ; then
            echo `${dtzs}`${dtzsep} 'Override Maximum Objects with OverrideMaxObjectsNumber :  '${OverrideMaxObjectsNumber}' objects value' | tee -a -i ${logfilepath}
            export WorkAPIObjectLimit=${OverrideMaxObjectsNumber}
        fi
        
        echo `${dtzs}`${dtzsep} 'Final WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure object selection query selector
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-06-11 - 
    # Current alternative if more options to exclude are needed, now there is a procedure for that
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    # Configure basic parameters
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-07-12:01 -
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    ConfigureMgmtCLIOperationalParametersExport
    
    export DoFileSlurp=false
    
    export Slurpworkfolder=${APICLIpathexport}
    if ${script_uses_wip_json} ; then
        # script uses work-in-progress (wip) folder for json
        
        export Slurpworkfolder=${APICLIJSONpathexportwip}
        
        if [ ! -r ${APICLIJSONpathexportwip} ] ; then
            mkdir -p -v ${APICLIJSONpathexportwip} >> ${logfilepath} 2>&1
        fi
    fi
    
    export APICLIfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'Start Processing '${APICLIobjecttype}':' | tee -a -i ${logfilepath}
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    # -------------------------------------------------------------------------------------------------
    
    export Workingfilename=${APICLIfilename}
    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
    export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}'_last'${APICLIJSONfileexportpost}
    
    errorreturn=0
    
    if [ ${objectstoshow} = null ] ; then
        echo `${dtzs}`${dtzsep} 'Found NO '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    elif [ ${objectstoshow} -le 0 ] ; then
        echo `${dtzs}`${dtzsep} 'Found '${objectstoshow}' '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    else
        # This object does not have limits to check and probably does not have more than one object entry
        
        ExportObjectToJSONStandard
        
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-09-15:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckAPIVersionAndExecuteOperation :  Check the API Version running where we're logged in and if good execute operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckAPIVersionAndExecuteOperation () {
    #
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    # ADDED 2022-12-08 -
    if ${APIobjectexportisCPI} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' has Critical Performance Impact, APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        if ! ${ExportCritPerfImpactObjects} ; then
            echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
            
            return 0
        else
            echo `${dtzs}`${dtzsep} 'Critical Performance Impact (CPI) Override is active!  ExportCritPerfImpactObjects = '${ExportCritPerfImpactObjects} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does not have Critical Performance Impact(CPI), APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if ! ${APIobjectdoexportJSON} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support JSON EXPORT!  APIobjectdoexportJSON = '${APIobjectdoexportJSON} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    GetAPIVersion=$(mgmt_cli show api-versions -f json -s ${APICLIsessionfile} | ${JQ} '.["current-version"]' -r)
    export CheckAPIVersion=${GetAPIVersion}
    
    if [ ${CheckAPIVersion} = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=${CheckAPIVersion}
    fi
    
    export addversion2keepalive=false
    if [ $(expr ${CurrentAPIVersion} '<=' 1.5) ] ; then
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=true
    else
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=false
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'For Objects Type : '${APICLIobjectstype}' Required minimum API version = ( '${APIobjectminversion}' )' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Logged in management server API version = ( '${CurrentAPIVersion}' ) Check version = ( '${CheckAPIVersion}' )' | tee -a -i ${logfilepath}
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) -eq 1 ] ; then
        # API is sufficient version
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        ExportRAWObjectToJSON
        errorreturn=$?
        
        echo `${dtzs}`${dtzsep} 'CheckAPIVersionAndExecuteOperation call to ExportObjectsToCSVviaJQ procedure returned :  '${errorreturn} >> ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
    else
        # API is not of a sufficient version to operate on for this object
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Current API Version ( '${CurrentAPIVersion}' ) does not meet minimum API version expected requirement ( '${APIobjectminversion}' )' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! skipping object '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        if ${ABORTONERROR} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in CheckAPIVersionAndExecuteOperation procedure, but continueing' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'CheckAPIVersionAndExecuteOperation procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-15:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END : Main Operational repeated proceedures - Export Objects to raw JSON
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export scriptactiontext='Export'
export scriptformattext='JSON'
#export scriptformattext='CSV'
export scriptactiondescriptor='Export to JSON'

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - simple objects - '${scriptactiondescriptor}' starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# MODIFIED 2022-09-15:02 - Harmonization Rework


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Standard Simple objects
# -------------------------------------------------------------------------------------------------

#export APICLIobjecttype='<object_type_singular>'
#export APICLIobjectstype='<object_type_plural>'
#export APIobjectminversion='<object_type_api_version>'
#export APICLICSVobjecttype=${APICLIobjectstype}
#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

#export APIobjectexportisCPI=false

#export APIobjectdoexport=true
#export APIobjectdoexportJSON=true
#export APIobjectdoexportCSV=true
#export APIobjectdoimport=true
#export APIobjectdorename=true
#export APIobjectdoupdate=true
#export APIobjectdodelete=true

#export APIobjectusesdetailslevel=true
#export APIobjectcanignorewarning=true
#export APIobjectcanignoreerror=true
#export APIobjectcansetifexists=true
#export APIobjectderefgrpmem=false
#export APIobjecttypehasname=true
#export APIobjecttypehasuid=true
#export APIobjecttypehasdomain=true
#export APIobjecttypehastags=true
#export APIobjecttypehasmeta=true
#export APIobjecttypeimportname=true

#export APIobjectCSVFileHeaderAbsoluteBase=false
#export APIobjectCSVJQparmsAbsoluteBase=false

#export APIobjectCSVexportWIP=false

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Manage & Settings Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Manage & Settings Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# tag objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=tag
export APICLIobjectstype=tags
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# trusted-client objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=trusted-client
export APICLIobjectstype=trusted-clients
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Network Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Network Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# host objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# host objects - NO NAT Details
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=NO_NAT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=network
export APICLIobjectstype=networks
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# wildcard objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=wildcard
export APICLIobjectstype=wildcards
export APIobjectminversion=1.2
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group
export APICLIobjectstype=groups
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# group-with-exclusion objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group-with-exclusion
export APICLIobjectstype=groups-with-exclusion
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=address-range
export APICLIobjectstype=address-ranges
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# multicast-address-ranges objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=multicast-address-range
export APICLIobjectstype=multicast-address-ranges
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dns-domain
export APICLIobjectstype=dns-domains
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# security-zone objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dynamic-object objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# checkpoint-hosts objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=checkpoint-hosts
export APICLIobjectstype=checkpoint-hosts
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time
export APICLIobjectstype=times
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time-group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsv-profile objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=lsv-profile
export APICLIobjectstype=lsv-profiles
export APIobjectminversion=1.6
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# gsn-handover-group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=gsn-handover-group
export APICLIobjectstype=gsn-handover-groups
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-point-name objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=access-point-names
export APICLIobjectstype=access-point-names
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# network-feeds objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=network-feed
export APICLIobjectstype=network-feeds
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# interoperable-devices objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=interoperable-device
export APICLIobjectstype=interoperable-devices
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Servers
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Servers' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# tacacs-server objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -

export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APIobjectminversion=1.7
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."server-type"'
export APIobjectspecificselector00value="TACACS"
export APICLIexportnameaddon=TACACS_only

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -

export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APIobjectminversion=1.7
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."server-type"'
export APIobjectspecificselector00value="TACACS_PLUS_"
export APICLIexportnameaddon=TACACSplus_only

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APIobjectminversion=1.7
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=tacacs-group
export APICLIobjectstype=tacacs-groups
export APIobjectminversion=1.7
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# radius-server objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-12-08 -

export APICLIobjecttype=radius-server
export APICLIobjectstype=radius-servers
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# radius-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=radius-group
export APICLIobjectstype=radius-groups
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# opsec-application objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# smtp-servers objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=smtp-server
export APICLIobjectstype=smtp-servers
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."authentication"'
export APIobjectspecificselector00value=false
export APICLIexportnameaddon=no_authentication

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=smtp-server
export APICLIobjectstype=smtp-servers
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."authentication"'
export APIobjectspecificselector00value=true
export APICLIexportnameaddon=with_authentication

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=smtp-server
export APICLIobjectstype=smtp-servers
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=smtp-server
export APICLIobjectstype=smtp-servers
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=false
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        export APIobjectdoexportCSV=false
        ;;
    # a "name-only" export operation
    'name-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "name-and-uid" export operation
    'name-and-uid' )
        export APIobjectdoexportCSV=true
        ;;
    # a "uid-only" export operation
    'uid-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "rename-to-new-nam" export operation
    'rename-to-new-name' )
        export APIobjectdoexportCSV=true
        ;;
    # Anything unknown is handled as "standard"
    * )
        export APIobjectdoexportCSV=false
        ;;
esac

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Gateways & Clusters
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Gateways & Clusters' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# simple-gateway objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-cluster objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=simple-cluster
export APICLIobjectstype=simple-clusters
export APIobjectminversion=1.6
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsm-gateways objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=lsm-gateway
export APICLIobjectstype=lsm-gateways
export APIobjectminversion=1.8
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=lsm-gateway
export APICLIobjectstype=lsm-gateways
export APIobjectminversion=1.8
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsm-clusters objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=lsm-cluster
export APICLIobjectstype=lsm-clusters
export APIobjectminversion=1.8
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Service & Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Service & Applications' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# services-tcp objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -
#

export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."aggressive-aging"."use-default-timeout"'
export APIobjectspecificselector00value=true
export APICLIexportnameaddon=using_default_timout

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -
#

export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."aggressive-aging"."use-default-timeout"'
export APIobjectspecificselector00value=false
export APICLIexportnameaddon=not_using_default_timout

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15 -
#

export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15 -
#

export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=false
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        export APIobjectdoexportCSV=false
        ;;
    # a "name-only" export operation
    'name-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "name-and-uid" export operation
    'name-and-uid' )
        export APIobjectdoexportCSV=true
        ;;
    # a "uid-only" export operation
    'uid-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "rename-to-new-nam" export operation
    'rename-to-new-name' )
        export APIobjectdoexportCSV=true
        ;;
    # Anything unknown is handled as "standard"
    * )
        export APIobjectdoexportCSV=false
        ;;
esac

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -
#

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."aggressive-aging"."use-default-timeout"'
export APIobjectspecificselector00value=true
export APICLIexportnameaddon=using_default_timout

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -
#

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."aggressive-aging"."use-default-timeout"'
export APIobjectspecificselector00value=false
export APICLIexportnameaddon=not_using_default_timout

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15 -
#

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15 -
#

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=false
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        export APIobjectdoexportCSV=false
        ;;
    # a "name-only" export operation
    'name-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "name-and-uid" export operation
    'name-and-uid' )
        export APIobjectdoexportCSV=true
        ;;
    # a "uid-only" export operation
    'uid-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "rename-to-new-nam" export operation
    'rename-to-new-name' )
        export APIobjectdoexportCSV=true
        ;;
    # Anything unknown is handled as "standard"
    * )
        export APIobjectdoexportCSV=false
        ;;
esac

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -
#

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."aggressive-aging"."use-default-timeout"'
export APIobjectspecificselector00value=true
export APICLIexportnameaddon=using_default_timout

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -
#

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."aggressive-aging"."use-default-timeout"'
export APIobjectspecificselector00value=false
export APICLIexportnameaddon=not_using_default_timout

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15 -
#

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15 -
#

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=false
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        export APIobjectdoexportCSV=false
        ;;
    # a "name-only" export operation
    'name-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "name-and-uid" export operation
    'name-and-uid' )
        export APIobjectdoexportCSV=true
        ;;
    # a "uid-only" export operation
    'uid-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "rename-to-new-nam" export operation
    'rename-to-new-name' )
        export APIobjectdoexportCSV=true
        ;;
    # Anything unknown is handled as "standard"
    * )
        export APIobjectdoexportCSV=false
        ;;
esac

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -
#

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."aggressive-aging"."use-default-timeout"'
export APIobjectspecificselector00value=true
export APICLIexportnameaddon=using_default_timout

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-06-17 -
#

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key='."aggressive-aging"."use-default-timeout"'
export APIobjectspecificselector00value=false
export APICLIexportnameaddon=not_using_default_timout

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15 -
#

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15 -
#

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=false
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

case "${TypeOfExport}" in
    # a "Standard" export operation
    'standard' )
        export APIobjectdoexportCSV=false
        ;;
    # a "name-only" export operation
    'name-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "name-and-uid" export operation
    'name-and-uid' )
        export APIobjectdoexportCSV=true
        ;;
    # a "uid-only" export operation
    'uid-only' )
        export APIobjectdoexportCSV=true
        ;;
    # a "rename-to-new-nam" export operation
    'rename-to-new-name' )
        export APIobjectdoexportCSV=true
        ;;
    # Anything unknown is handled as "standard"
    * )
        export APIobjectdoexportCSV=false
        ;;
esac

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-gtp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-gtp
export APICLIobjectstype=services-gtp
export APIobjectminversion=1.7
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-citrix-tcp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-citrix-tcp
export APICLIobjectstype=services-citrix-tcp
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-compound-tcp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-compound-tcp
export APICLIobjectstype=services-compound-tcp
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export AugmentExportedFields=false

if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export AugmentExportedFields=true
elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    export AugmentExportedFields=true
elif ${OnlySystemObjects} ; then
    export AugmentExportedFields=true
else
    export AugmentExportedFields=false
fi

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=true

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Users
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Users' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# user objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user
export APICLIobjectstype=users
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation

# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user
export APICLIobjectstype=users
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# user-group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user-group
export APICLIobjectstype=user-groups
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# user-template objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-role objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# identity-tag objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=identity-tag
export APICLIobjectstype=identity-tags
export APIobjectminversion=1.6.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Updatable Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Updatable Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# updatable-objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=updatable-object
export APICLIobjectstype=updatable-objects
export APIobjectminversion=1.3
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=false

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# updatable-objects - Reference information
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=updatable-object
export APICLIobjectstype=updatable-objects
export APIobjectminversion=1.3
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=false

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# updatable-objects-repository-content - Reference information
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=updatable-objects-repository-content
export APICLIobjectstype=updatable-objects-repository-content
export APIobjectminversion=1.3
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=false
export APIobjectcanignoreerror=false
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=false
export APIobjecttypehasuid=false
export APIobjecttypehasdomain=false
export APIobjecttypehastags=false
export APIobjecttypehasmeta=false
export APIobjecttypeimportname=false

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=REFERENCE_NO_IMPORT

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=updatable-objects-repository-content
export APICLIobjectstype=updatable-objects-repository-content
export APIobjectminversion=1.3
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=false
export APIobjectdoimport=false
export APIobjectdorename=false
export APIobjectdoupdate=false
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=false
export APIobjectcanignoreerror=false
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=false
export APIobjecttypehasuid=false
export APIobjecttypehasdomain=false
export APIobjecttypehastags=false
export APIobjecttypehasmeta=false
export APIobjecttypeimportname=false

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Script Type Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script Type Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# SmartTasks
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=smart-task
export APICLIobjectstype=smart-tasks
export APIobjectminversion=1.6
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# Repository Scripts
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=repository-script
export APICLIobjectstype=repository-scripts
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Compliance
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Compliance Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Data Center Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Data Center Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Azure Active Directory Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Azure Active Directory Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# VPN Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'VPN Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# HTTPS Inspection Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'HTTPS Inspection Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Multi-Domain Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Multi-Domain Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Provisioning LSM Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Provisioining LSM Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# no more simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - simple objects - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle Special objects and properties
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# ADDED 2022-07-07 -

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

# MODIFIED 2022-07-07 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Special objects and properties - '${scriptactiondescriptor}' Starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-07-07


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Main Operational proceedures - Export Special Objects or Properties to JSON
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - ExportSpecialObjectToJSONWithoutLimitsAndDetailLevel
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-10-27:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Export Special Objects or Properties without utilization of limits and details-level
#

ExportSpecialObjectToJSONWithoutLimitsAndDetailLevel () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    # This object does not have limits to check and probably does not have more than one object entry
    echo `${dtzs}`${dtzsep} '  Now processing '${APICLIobjecttype}' special object/properties!' | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} >> ${logfilepath}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' '${MgmtCLI_Show_OpParms}' \> "'${APICLIJSONfilelast}'"' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' '${MgmtCLI_Show_OpParms}' \> "'${APICLIJSONfilelast}'"' >> ${logfilepath}
    fi
    
    mgmt_cli show ${APICLIobjectstype} ${MgmtCLI_Show_OpParms} > ${APICLIJSONfilelast}
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLIJSONfilelast}' : ' >> ${logfilepath}
        echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo >> ${logfilepath}
        
        cat ${APICLIJSONfilelast} | tee -a -i ${logfilepath}
        
        echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    cat ${APICLIJSONfilelast} > ${APICLIfileexport}
    
    export Slurpstarfilename=
    export Slurpstarfilefqpn=
    export Finaljsonfilename=
    export Finaljsonfileexport=
    
    export Finaljsonfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Finaljsonfilename=${Finaljsonfilename}'_'${APICLIexportnameaddon}
    fi
    export Finaljsonfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Finaljsonfilename}${APICLIfileexportpost}
    
    # MODIFIED  -
    
    # Slurp the single JSON files into a single JSON already
    
    export Slurpstarfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpstarfilename=${Slurpstarfilename}'_ALL'
    export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
    
    if [ -s ${APICLIfileexport} ] ; then
        # exported json file is not zero length, so process for slurp
        # copy the broken json file as the slurpstar file to the slurp work area
        cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
        
        #echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        
        ## SlurpJSONFilesIntoSingleFile ${Slurpstarfilefqpn} ${Finaljsonfileexport}
        #SlurpJSONFilesIntoSingleFile
        cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
    else
        # exported json file is zero length, so process build manual file
        export SLURP_TOTAL=0
        
        echo '{ ' > ${Slurpstarfilefqpn}
        #echo '  "objects": [],' >> ${Slurpstarfilefqpn}
        #echo '  "from": 0,' >> ${Slurpstarfilefqpn}
        #echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpstarfilefqpn}
        #echo '  "total": '${SLURP_TOTAL} >> ${Slurpstarfilefqpn}
        echo '}' >> ${Slurpstarfilefqpn}
        
        #cp -fv ${Slurpstarfilefqpn} ${APICLIfileexport} >> ${logfilepath} 2>&1
        cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
    fi
    
    # Handle placement of final object JSON file into standing current object repository next
    
    HandleJSONRepositoryUpdate
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Head (5) and Tail (5) of the export file : '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        #tail ${APICLIfileexport} | tee -a -i ${logfilepath}
        head -n 5 ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo '...' | tee -a -i ${logfilepath}
        tail -n 5 ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Head (5) and Tail (5) of the export file : '${Finaljsonfileexport} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        #tail ${APICLIfileexport} >> ${logfilepath}
        head -n 5 ${Finaljsonfileexport} >> ${logfilepath}
        echo '...' >> ${logfilepath}
        tail -n 5 ${Finaljsonfileexport} >> ${logfilepath}
        echo >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >>  ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToJSONWithoutLimitsAndDetailLevel procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-10-27:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - ExportSpecialObjectToJSONStandard
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-10-27:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Export Special Objects or Properties with utilization of limits and details-level as a standard
#

ExportSpecialObjectToJSONStandard () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APICLIobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    if [ ${objectstotal} -gt ${WorkAPIObjectLimit} ] ; then
        export DoFileSlurp=true
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  JSON File Slurp required...' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  JSON File Slurp required...' >> ${logfilepath}
        fi
    else
        export DoFileSlurp=false
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  JSON File Slurp NOT required...' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  JSON File Slurp NOT required...' >> ${logfilepath}
        fi
    fi
    
    objectstotalformatted=`printf "%05d" ${objectstotal}`
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        
        nextoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        
        #if [ ${currentoffset} -gt 0 ] ; then
        #    # Export file for the next ${WorkAPIObjectLimit} objects
        #    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APICLIobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
        #fi
        
        currentoffsetformatted=`printf "%05d" ${currentoffset}`
        nextoffsetformatted=`printf "%05d" ${nextoffset}`
        
        # 2017-11-20 Updating naming of files for multiple ${WorkAPIObjectLimit} chunks to clean-up name listing
        if [ ${objectstotal} -gt ${WorkAPIObjectLimit} ] ; then
            # Export file for the next ${WorkAPIObjectLimit} objects
            export APICLIfilename=${APICLIobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
            fi
            
            #export APICLIfilename=${APICLIfilename}'_'${currentoffset}'-'${nextoffset}'_of_'${objectstotal}
            export Workingfilename=${APICLIfilename}'_'${currentoffsetformatted}'-'${nextoffsetformatted}'_of_'${objectstotalformatted}
            
            #export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APICLIobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
            export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
            export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${APICLIfilename}'_00000-'${objectstotalformatted}'_last'${APICLIJSONfileexportpost}
            
            export Slurpworkfileexport=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
        fi
        
        echo `${dtzs}`${dtzsep} '  Now processing up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentoffset}' to '${nextoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} >> ${logfilepath}
        fi
        
        # Operational Steps
        # 1.  Export required object data for objecttype to working JSON file ${APICLIJSONfilelast}
        # 2.  Based on export type, so NoSystemsObjects, OnlySystemObjects, or all objects, execute dump of ${APICLIJSONfilelast} through jq using potential object selectors, to export file ${APICLIfileexport}
        # 3.  If needed, copy file for slurp operation to ${Slurpworkfileexport} 
        
        # MODIFIED  -
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}" >> ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '. | '"${notsystemobjectselector}" >> ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '. | '"${notsystemobjectselector}" > ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}" > ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} >> ${APICLIfileexport}
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLIfileexport}
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} >> ${logfilepath}
        fi
        
        mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLIJSONfilelast}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLIJSONfilelast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLIJSONfilelast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # MODIFIED 2022-06-17
        #
        
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      No System Objects.  Selector = '${objectqueryselector} | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        elif ${OnlySystemObjects} ; then
            # Select only System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      Only System Objects.  Selector = '${objectqueryselector} | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        elif [ x"${objectqueryselector}" != x"" ] ; then
            # Don't forget to handle cases where object types need selection criteria handled
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      Selected objects based on object type criteria' | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        else
            # Don't Ignore System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      All objects, including System Objects' | tee -a -i ${logfilepath}
            fi
            
            # Processing the file through jq stripping the objects creates a problem file
            cat ${APICLIJSONfilelast} | jq '.objects[]' > ${APICLIfileexport}
            #cat ${APICLIJSONfilelast} > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        fi
        
        if ${DoFileSlurp} ; then
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                echo `${dtzs}`${dtzsep} '      Dump to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                #cat ${APICLIfileexport} | jq '.objects[]' > ${Slurpworkfileexport}
                cp -fv ${APICLIfileexport} ${Slurpworkfileexport} >> ${logfilepath} 2>&1
            else
                # exported json file is zero length, so do not process file for slurp
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} >> ${logfilepath}
                fi
            fi
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        #currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        currentoffset=${nextoffset}
        
        # MODIFIED 2022-02-15 -
        
        CheckAPIKeepAlive
        
    done
    
    # MODIFIED 2022-07-12 -
    
    PrepareToSlurpJSONFiles
    
    # Handle placement of final object JSON file into standing current object repository
    
    HandleJSONRepositoryUpdate
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Head (5) and Tail (5) of the export file : '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        #tail ${APICLIfileexport} | tee -a -i ${logfilepath}
        head -n 5 ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo '...' | tee -a -i ${logfilepath}
        tail -n 5 ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Head (5) and Tail (5) of the export file : '${Finaljsonfileexport} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        #tail ${APICLIfileexport} >> ${logfilepath}
        head -n 5 ${Finaljsonfileexport} >> ${logfilepath}
        echo '...' >> ${logfilepath}
        tail -n 5 ${Finaljsonfileexport} >> ${logfilepath}
        echo >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >>  ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToJSONStandard procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-10-27:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - SpecialExportRAWObjectToJSON
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjecttype} details is exported to a json at the ${APICLIdetaillvl}.

SpecialExportRAWObjectToJSON () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportJSON} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support JSON EXPORT!  APIobjectdoexportJSON = '${APIobjectdoexportJSON} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ "${APICLIdetaillvl}" == "standard" ] ; then
        # Need to check if we have object type selector values, since that won't work with details-level standard!
        if [ x"${APIobjectspecificselector00key}" != x"" ] ; then
            # OK, need to skip this because we can't process this with detials-level "standard"
            echo `${dtzs}`${dtzsep} 'Object type :  '${APICLIobjectstype}' has defined object type selectors set, but details-level is "'${APICLIdetaillvl}'", so skipping to avoid fail!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    # MODIFIED 2022-09-14 -
    
    if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        export WorkAPIObjectLimit=1
        echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit set to '${WorkAPIObjectLimit}' because this object is singular and special' | tee -a -i ${logfilepath}
    else
        export WorkAPIObjectLimit=${MaxAPIObjectLimit}
        if [ -z "${domainnamenospace}" ] ; then
            # an empty ${domainnamenospace} indicates that we are not working towards an MDSM
            export WorkAPIObjectLimit=${APIobjectrecommendedlimit}
        else
            # an empty ${domainnamenospace} indicates that we are working towards an MDSM
            export WorkAPIObjectLimit=${APIobjectrecommendedlimitMDSM}
        fi
        
        echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
        
        if ${OverrideMaxObjects} ; then
            echo `${dtzs}`${dtzsep} 'Override Maximum Objects with OverrideMaxObjectsNumber :  '${OverrideMaxObjectsNumber}' objects value' | tee -a -i ${logfilepath}
            export WorkAPIObjectLimit=${OverrideMaxObjectsNumber}
        fi
        
        echo `${dtzs}`${dtzsep} 'Final WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure object selection query selector
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-06-11 - 
    # Current alternative if more options to exclude are needed, now there is a procedure for that
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    # Configure basic parameters
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-07-12:01 -
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    ConfigureMgmtCLIOperationalParametersExport
    
    export DoFileSlurp=false
    
    export Slurpworkfolder=${APICLIpathexport}
    if ${script_uses_wip_json} ; then
        # script uses work-in-progress (wip) folder for json
        
        export Slurpworkfolder=${APICLIJSONpathexportwip}
        
        if [ ! -r ${APICLIJSONpathexportwip} ] ; then
            mkdir -p -v ${APICLIJSONpathexportwip} >> ${logfilepath} 2>&1
        fi
    fi
    
    export APICLIfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'Start Processing '${APICLIobjecttype}':' | tee -a -i ${logfilepath}
    
    if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        objectstotal=1
    else
        # This object has limits to check, so handle as such
        objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    fi
    
    objectstoshow=${objectstotal}
    
    # -------------------------------------------------------------------------------------------------
    
    export Workingfilename=${APICLIfilename}
    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
    export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}'_last'${APICLIJSONfileexportpost}
    
    errorreturn=0
    
    if [ ${objectstoshow} = null ] ; then
        # This object was queried for number of elements and failed to find any, so skipping
        
        echo `${dtzs}`${dtzsep} 'Found NO '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
        
    elif [ ${objectstoshow} -le 0 ] ; then
        # This object was queried for number of elements and returned zero (0) or lesss objects, so skipping
        
        echo `${dtzs}`${dtzsep} 'Found '${objectstoshow}' '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
        
    elif [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        
        ExportSpecialObjectToJSONWithoutLimitsAndDetailLevel
        
    else
        # This object has limits to check and probably has more than one object entry
        
        ExportSpecialObjectToJSONStandard
        
    fi
    
    echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-09-15:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SpecialObjectsCheckAPIVersionAndExecuteOperation :  Check the API Version running where we're logged in and if good execute operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-09-15:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SpecialObjectsCheckAPIVersionAndExecuteOperation () {
    #
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    # ADDED 2022-12-08 -
    if ${APIobjectexportisCPI} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' has Critical Performance Impact, APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        if ! ${ExportCritPerfImpactObjects} ; then
            echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
            
            return 0
        else
            echo `${dtzs}`${dtzsep} 'Critical Performance Impact (CPI) Override is active!  ExportCritPerfImpactObjects = '${ExportCritPerfImpactObjects} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does not have Critical Performance Impact(CPI), APIobjectexportisCPI = '${APIobjectexportisCPI} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if ! ${APIobjectdoexportJSON} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIobjecttype}' does NOT support JSON EXPORT!  APIobjectdoexportJSON = '${APIobjectdoexportJSON} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    GetAPIVersion=$(mgmt_cli show api-versions -f json -s ${APICLIsessionfile} | ${JQ} '.["current-version"]' -r)
    export CheckAPIVersion=${GetAPIVersion}
    
    if [ ${CheckAPIVersion} = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=${CheckAPIVersion}
    fi
    
    export addversion2keepalive=false
    if [ $(expr ${CurrentAPIVersion} '<=' 1.5) ] ; then
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=true
    else
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=false
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'For Objects Type : '${APICLIobjectstype}' Required minimum API version = ( '${APIobjectminversion}' )' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Logged in management server API version = ( '${CurrentAPIVersion}' ) Check version = ( '${CheckAPIVersion}' )' | tee -a -i ${logfilepath}
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) -eq 1 ] ; then
        # API is sufficient version
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        SpecialExportRAWObjectToJSON
        errorreturn=$?
        
        echo `${dtzs}`${dtzsep} 'SpecialObjectsCheckAPIVersionAndExecuteOperation call to SpecialExportRAWObjectToJSON procedure returned :  '${errorreturn} >> ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
    else
        # API is not of a sufficient version to operate on for this object
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Current API Version ( '${CurrentAPIVersion}' ) does not meet minimum API version expected requirement ( '${APIobjectminversion}' )' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '! skipping object '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        if ${ABORTONERROR} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            exit ${errorreturn}
        else
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure, but continueing' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #return ${errorreturn}
        fi
    fi
    echo `${dtzs}`${dtzsep} 'SpecialObjectsCheckAPIVersionAndExecuteOperation procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-09-15:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END : Main Operational repeated proceedures - Export Special Objects to raw JSON
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# global-properties - export object
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-01-06 -

export APICLIobjecttype=global-properties
export APICLIobjectstype=global-properties
export APIobjectminversion=1.9
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=0
export APIobjectrecommendedlimitMDSM=0

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=true
export APIobjectdodelete=false

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=false
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=false

export APIobjectCSVFileHeaderAbsoluteBase=true
export APIobjectCSVJQparmsAbsoluteBase=true

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=


#SpecialObjectsCheckAPIVersionAndExecuteOperation

case "${domaintarget}" in
    'System Data' )
        # We don't execute this action for the domain "System Data"
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'For Objects Type : '${APICLIobjectstype}'  This will NOT work with Domain ["'${domaintarget}'"]' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        ;;
    # Anything unknown is recorded for later
    * )
        # All other domains and no domain should work for this
        case "${TypeOfExport}" in
            # a "Standard" export operation
            'standard' )
                export number_of_objects=1
                
                case "${primarytargetoutputformat}" in
                    'json' )
                        export APICLIexportnameaddon=
                        SpecialObjectsCheckAPIVersionAndExecuteOperation
                        ;;
                    'csv' )
                        #
                        # Handle the break-out for CSV operations, since this object has multiple files
                        #
                        
                        export APICLIexportnameaddon=01_firewall_nat
                        SpecialObjectsCheckAPIVersionAndExecuteOperation
                        
                        export APICLIexportnameaddon=02_vnp_remote_access
                        SpecialObjectsCheckAPIVersionAndExecuteOperation
                        
                        export APICLIexportnameaddon=03_authentication_userdirectory_users
                        SpecialObjectsCheckAPIVersionAndExecuteOperation
                        
                        export APICLIexportnameaddon=04_qos_carrier
                        SpecialObjectsCheckAPIVersionAndExecuteOperation
                        
                        export APICLIexportnameaddon=05_stateful_inspection_non_unique_ips
                        SpecialObjectsCheckAPIVersionAndExecuteOperation
                        
                        export APICLIexportnameaddon=06_log_and_alert_all_other
                        SpecialObjectsCheckAPIVersionAndExecuteOperation
                        ;;
                    * )
                        export APICLIexportnameaddon=
                        SpecialObjectsCheckAPIVersionAndExecuteOperation
                        ;;
                esac
                ;;
            # a "name-only" export operation
            #'name-only' )
            # a "name-and-uid" export operation
            #'name-and-uid' )
            # a "uid-only" export operation
            #'uid-only' )
            # a "rename-to-new-nam" export operation
            #'rename-to-new-name' )
            # Anything unknown is handled as "standard"
            * )
                echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Objects Type : '${APICLIobjectstype}'  DOES NOT support an Export of type ["'${TypeOfExport}'"]' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                ;;
        esac
        ;;
esac


# -------------------------------------------------------------------------------------------------
# policy-settings - export object
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-01-05 -

export APICLIobjecttype=policy-settings
export APICLIobjectstype=policy-settings
export APIobjectminversion=1.8
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=0
export APIobjectrecommendedlimitMDSM=0

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=true
export APIobjectdodelete=false

export APIobjectusesdetailslevel=false
export APIobjectcanignorewarning=false
export APIobjectcanignoreerror=false
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=false
export APIobjecttypehasuid=false
export APIobjecttypehasdomain=false
export APIobjecttypehastags=false
export APIobjecttypehasmeta=false
export APIobjecttypeimportname=false

export APIobjectCSVFileHeaderAbsoluteBase=true
export APIobjectCSVJQparmsAbsoluteBase=true

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=


#SpecialObjectsCheckAPIVersionAndExecuteOperation

case "${domaintarget}" in
    'System Data' )
        # We don't execute this action for the domain "System Data"
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'For Objects Type : '${APICLIobjectstype}'  This will NOT work with Domain ["'${domaintarget}'"]' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        ;;
    # Anything unknown is recorded for later
    * )
        # All other domains and no domain should work for this
        case "${TypeOfExport}" in
            # a "Standard" export operation
            'standard' )
                export number_of_objects=1
                SpecialObjectsCheckAPIVersionAndExecuteOperation
                ;;
            # a "name-only" export operation
            #'name-only' )
            # a "name-and-uid" export operation
            #'name-and-uid' )
            # a "uid-only" export operation
            #'uid-only' )
            # a "rename-to-new-nam" export operation
            #'rename-to-new-name' )
            # Anything unknown is handled as "standard"
            * )
                echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Objects Type : '${APICLIobjectstype}'  DOES NOT support an Export of type ["'${TypeOfExport}'"]' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                ;;
        esac
        ;;
esac


# -------------------------------------------------------------------------------------------------
# api-settings - export object
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-01-05 -

export APICLIobjecttype=api-settings
export APICLIobjectstype=api-settings
export APIobjectminversion=1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=0
export APIobjectrecommendedlimitMDSM=0

export APIobjectexportisCPI=false

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=false
export APIobjectdoupdate=true
export APIobjectdodelete=false

export APIobjectusesdetailslevel=false
export APIobjectcanignorewarning=false
export APIobjectcanignoreerror=false
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=false
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=false

export APIobjectCSVFileHeaderAbsoluteBase=true
export APIobjectCSVJQparmsAbsoluteBase=true

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

case "${domaintarget}" in
    'System Data' )
        case "${TypeOfExport}" in
            # a "Standard" export operation
            'standard' )
                export number_of_objects=1
                SpecialObjectsCheckAPIVersionAndExecuteOperation
                ;;
            # a "name-only" export operation
            #'name-only' )
            # a "name-and-uid" export operation
            #'name-and-uid' )
            # a "uid-only" export operation
            #'uid-only' )
            # a "rename-to-new-nam" export operation
            #'rename-to-new-name' )
            # Anything unknown is handled as "standard"
            * )
                echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Objects Type : '${APICLIobjectstype}'  DOES NOT support an Export of type ["'${TypeOfExport}'"]' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                ;;
        esac
        ;;
    # Anything unknown or other is not handled
    * )
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Current target domain ["'${domaintarget}'"] IS NOT handled for properties ='${APICLIobjecttype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        ;;
esac


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more Special objects and properties
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-07-07 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Special objects and properties - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-07-07


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Simple Object via Generic-Objects Handler
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Simple Object via Generic-Objects Handler' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Simple Object via Generic-Objects Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2022-12-14 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational repeated proceedure - HandleJSONRepositoryUpdateGenericObjects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-12-14:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Handle placement of final object JSON file into standing current object repository
#

HandleJSONRepositoryUpdateGenericObjects () {
    #
    # Handle placement of final object JSON file into standing current object repository
    #
    
    errorreturn=0
    
    export JSONRepopathworking=
    export JSONRepoFileexport=
    
    # In export operations, we do not utilize the details level of other than "standard" export types, so either "full" or "standard"
    export JSONRepoDetailname=${APICLIdetaillvl}
    case ${APICLIdetaillvl} in
        'full' )
            export JSONRepoDetailname=${APICLIdetaillvl}
            ;;
        'standard' )
            export JSONRepoDetailname=${APICLIdetaillvl}
            ;;
        * )
            export JSONRepoDetailname='full'
            ;;
    esac
    
    echo `${dtzs}`${dtzsep} 'Using the following details level for the JSON Repository = '${JSONRepoDetailname} >> ${logfilepath}
    
    if ${script_save_json_repo} ; then
        # check if we are updating the json object repository
        echo `${dtzs}`${dtzsep} 'Update JSON Repository File' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
                # In CSV export operations, we do not utilize the ${APICLIdetaillvl}.NoSystemObjects to ensure we harvest from the repository
                export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
            else
                export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}.NoSystemObjects
            fi
        elif ${OnlySystemObjects} ; then
            if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
                # In CSV export operations, we do not utilize the ${APICLIdetaillvl}.OnlySystemObjects to ensure we harvest from the repository
                export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
            else
                export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}.OnlySystemObjects
            fi
        else
            export JSONRepopathworking=${JSONRepopathbase}/${JSONRepoDetailname}
        fi
        
        if [ ! -r ${JSONRepopathworking} ] ; then
            mkdir -p -v ${JSONRepopathworking} >> ${logfilepath} 2>&1
            chmod 775 ${JSONRepopathworking} >> ${logfilepath} 2>&1
        else
            chmod 775 ${JSONRepopathworking} >> ${logfilepath} 2>&1
        fi
        
        export JSONRepofilepost='_'${JSONRepoDetailname}'_'${JSONRepofilesuffix}
        
        export JSONRepoFileexport=${JSONRepopathworking}/${JSONRepofilepre}${Finaljsonfilename}${JSONRepofilepost}
        
        echo `${dtzs}`${dtzsep} 'Copy Final Export JSON file "'${Finaljsonfileexport}'"' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  to JSON Repository file "'${JSONRepoFileexport}'"' | tee -a -i ${logfilepath}
        cp -fv ${Finaljsonfileexport} ${JSONRepoFileexport} >> ${logfilepath} 2>&1
        
    fi
    
    echo `${dtzs}`${dtzsep} 'HandleJSONRepositoryUpdateGenericObjects procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-12-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SlurpJSONFilesIntoSingleFileGenericObjects :  Use JQ to Slurp JSON files into single JSON file from multiple files
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-12-14:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SlurpJSONFilesIntoSingleFileGenericObjects () {
    #
     
    export Slurpuglyfilename=${APIGenObjobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpuglyfilename=${Slurpuglyfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpuglyfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpuglyfilename}'.ugly.'${APICLIfileexportpost}
    
    export Slurpprettyfilename=${APIGenObjobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpprettyfilename=${Slurpprettyfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpprettyfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpprettyfilename}'.pretty.'${APICLIfileexportpost}
    
    export Slurpfinalfilename=${APIGenObjobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpfinalfilename=${Slurpfinalfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpfinalfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpfinalfilename}'.final.'${APICLIfileexportpost}
    
    # Single Line entries
    #printf 'variable :  %-25s = %s\n' "x" ${x} >> ${logfilepath}
    #printf '%-35s$ : %s\n' "x" 'x' >> ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Execute SlurpJSONFilesIntoSingleFileGenericObjects for objects type '${APIGenObjobjectstype} | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        #printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpstarfilefqpn" ${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'variable :  Slurpstarfilefqpn         = '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Finaljsonfileexport" ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpworkfolder" ${Slurpworkfolder} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpuglyfilefqpn" ${Slurpuglyfilefqpn} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpuglyfilename" ${Slurpuglyfilename} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpprettyfilefqpn" ${Slurpprettyfilefqpn} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpprettyfilename" ${Slurpprettyfilename} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpfinalfilefqpn" ${Slurpfinalfilefqpn} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpfinalfilename" ${Slurpfinalfilename} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIexportnameaddon" ${APICLIexportnameaddon} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIpathexport" ${APICLIpathexport} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIfileexportpre" ${APICLIfileexportpre} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIfileexportpost" ${APICLIfileexportpost} | tee -a -i ${logfilepath}
    else
        #printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpstarfilefqpn" ${Slurpstarfilefqpn} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'variable :  Slurpstarfilefqpn        = '${Slurpstarfilefqpn} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Finaljsonfileexport" ${Finaljsonfileexport} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpworkfolder" ${Slurpworkfolder} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpuglyfilefqpn" ${Slurpuglyfilefqpn} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpuglyfilename" ${Slurpuglyfilename} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpprettyfilefqpn" ${Slurpprettyfilefqpn} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpprettyfilename" ${Slurpprettyfilename} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpfinalfilefqpn" ${Slurpfinalfilefqpn} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Slurpfinalfilename" ${Slurpfinalfilename} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIexportnameaddon" ${APICLIexportnameaddon} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIpathexport" ${APICLIpathexport} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIfileexportpre" ${APICLIfileexportpre} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIfileexportpost" ${APICLIfileexportpost} >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo '----------------------------------------------------------------------' >> ${logfilepath}
    ls -alh ${Slurpstarfilefqpn} >> ${logfilepath}
    echo '----------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Use jq to slurp '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
    
    ${JQ} -s '.' ${Slurpstarfilefqpn} > ${Slurpuglyfilefqpn}
    #rm -rf test*.json
    
    SLURP_TOTAL=`cat ${Slurpuglyfilefqpn} | ${JQ} '.[].uid' | sort -u | wc -l`
    echo `${dtzs}`${dtzsep} 'Data output to '${Finaljsonfileexport}' with '${SLURP_TOTAL}' elements' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Total elements from first query is '${objectstotal}' elements' | tee -a -i ${logfilepath}
    
    # Make it pretty again
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Make it pretty' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    echo '{ ' > ${Slurpprettyfilefqpn}
    echo -n '  "objects": ' >> ${Slurpprettyfilefqpn}
    
    # need a way to read lines and dump them out
    
    #COUNTER=0
    
    #while read -r line; do
        #if [ ${COUNTER} -eq 0 ]; then
            ## Line 0 first line we don't want to add a return yet
            #echo -n 'Start:.'
        #else
            ## Lines 1+ are the data
            #echo >> ${Slurpprettyfilefqpn}
            ##if ${APISCRIPTVERBOSE} ; then
                ##echo -n '.'
            ##fi
        #fi
        
        ##Write the line, but not the carriage return
        #echo -n "${line}" >> ${Slurpprettyfilefqpn}
        #let COUNTER=COUNTER+1
    #done < ${Slurpuglyfilefqpn}
    
    #echo
    
    # This method is much faster and works too, since Slurpuglyfilefqpn is already an array with good formatting
    cat ${Slurpuglyfilefqpn} >> ${Slurpprettyfilefqpn}
    
    #Write the last comma after the original json file that is not pretty
    echo ',' >> ${Slurpprettyfilefqpn}
    echo '  "from": 0,' >> ${Slurpprettyfilefqpn}
    echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpprettyfilefqpn}
    echo '  "total": '${SLURP_TOTAL} >> ${Slurpprettyfilefqpn}
    echo '}' >> ${Slurpprettyfilefqpn}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        #head -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json; echo `${dtzs}`${dtzsep} '...'; tail -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
        head -n 10 ${Slurpprettyfilefqpn} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        tail -n 10 ${Slurpprettyfilefqpn} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        #head -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json; echo `${dtzs}`${dtzsep} '...'; tail -n 10 total.${OBJECTSTYPE}.${DETAILSSET}.pretty.json
        head -n 10 ${Slurpprettyfilefqpn} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        #echo `${dtzs}`${dtzsep} >> ${logfilepath}
        #echo '----------------------------------------------------------------------' >> ${logfilepath}
        tail -n 10 ${Slurpprettyfilefqpn} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Now make it really pretty' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    ${JQ} -s '.[]' ${Slurpprettyfilefqpn} > ${Slurpfinalfilefqpn}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        head -n 10 ${Slurpfinalfilefqpn} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        tail -n 10 ${Slurpfinalfilefqpn} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        head -n 10 ${Slurpfinalfilefqpn} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        #echo `${dtzs}`${dtzsep} >> ${logfilepath}
        #echo '----------------------------------------------------------------------' >> ${logfilepath}
        tail -n 10 ${Slurpfinalfilefqpn} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} | >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'Copy Final slurped JSON file "'${Slurpfinalfilefqpn}'"' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '  to JSON Results file "'${Finaljsonfileexport}'"' | tee -a -i ${logfilepath}
    cp -fv ${Slurpfinalfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
    
    if ${APISCRIPTVERBOSE} ; then
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-12-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Prepare operations to Slurp JSON files - PrepareToSlurpJSONFilesGenericObjects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-12-14:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Prepare operations to Slurp JSON files.
#
PrepareToSlurpJSONFilesGenericObjects () {
    #
    # Prepare operations to Slurp JSON files
    #
    
    errorreturn=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Procedure PrepareToSlurpJSONFilesGenericObjects Starting!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    export Slurpstarfilename=
    export Slurpstarfilefqpn=
    export Finaljsonfilename=
    export Finaljsonfileexport=
    
    export Finaljsonfilename=${APIGenObjobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Finaljsonfilename=${Finaljsonfilename}'_'${APICLIexportnameaddon}
    fi
    export Finaljsonfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Finaljsonfilename}${APICLIfileexportpost}
    
    # MODIFIED  -
    
    if ${DoFileSlurp} ; then
        # Slurp the collection of JSON files into a single JSON already
        
        export Slurpstarfilename=${APIGenObjobjectstype}
        if [ x"${APICLIexportnameaddon}" != x"" ] ; then
            export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
        fi
        export Slurpstarfilename=${Slurpstarfilename}'_*_of_'${objectstotalformatted}
        export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
        
        echo `${dtzs}`${dtzsep} '  Multiple JSON files created, need to SLURP together the file!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp these files     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        
        #SlurpJSONFilesIntoSingleFileGenericObjects ${Slurpstarfilefqpn} ${Finaljsonfileexport}
        SlurpJSONFilesIntoSingleFileGenericObjects
        
        # Handle placement of final object JSON file into standing current object repository next
    else
        # File is single JSON already
        # Handle placement of final object JSON file into standing current object repository next
        if ${NoSystemObjects} ; then
            # When working with only non-System objects, the process generates a broken json file that needs to be fixed
            # fixing the broken json file is done via the Slurp process, but we only have a single file versus a collection;
            # however, we need to still set things up for operation
            
            # Slurp the single JSON files into a single JSON already
            
            export Slurpstarfilename=${APIGenObjobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
            fi
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_NSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                # copy the broken json file as the slurpstar file to the slurp work area
                cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
                
                echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
                
                #SlurpJSONFilesIntoSingleFileGenericObjects ${Slurpstarfilefqpn} ${Finaljsonfileexport}
                SlurpJSONFilesIntoSingleFileGenericObjects
            else
                # exported json file is zero length, so process build manual file
                export SLURP_TOTAL=0
                
                echo '{ ' > ${Slurpstarfilefqpn}
                echo '  "objects": [],' >> ${Slurpstarfilefqpn}
                echo '  "from": 0,' >> ${Slurpstarfilefqpn}
                echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpstarfilefqpn}
                echo '  "total": '${SLURP_TOTAL} >> ${Slurpstarfilefqpn}
                echo '}' >> ${Slurpstarfilefqpn}
                
                #cp -fv ${Slurpstarfilefqpn} ${APICLIfileexport} >> ${logfilepath} 2>&1
                cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
            fi
            
            # Handle placement of final object JSON file into standing current object repository next
        elif ${OnlySystemObjects} ; then
            # When working with only System objects, the process generates a broken json file that needs to be fixed
            # fixing the broken json file is done via the Slurp process, but we only have a single file versus a collection;
            # however, we need to still set things up for operation
            
            # Slurp the single JSON files into a single JSON already
            
            export Slurpstarfilename=${APIGenObjobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
            fi
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_OSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                # copy the broken json file as the slurpstar file to the slurp work area
                cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
                
                echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
                
                #SlurpJSONFilesIntoSingleFileGenericObjects ${Slurpstarfilefqpn} ${Finaljsonfileexport}
                SlurpJSONFilesIntoSingleFileGenericObjects
            else
                # exported json file is zero length, so process build manual file
                export SLURP_TOTAL=0
                
                echo '{ ' > ${Slurpstarfilefqpn}
                echo '  "objects": [],' >> ${Slurpstarfilefqpn}
                echo '  "from": 0,' >> ${Slurpstarfilefqpn}
                echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpstarfilefqpn}
                echo '  "total": '${SLURP_TOTAL} >> ${Slurpstarfilefqpn}
                echo '}' >> ${Slurpstarfilefqpn}
                
                #cp -fv ${Slurpstarfilefqpn} ${APICLIfileexport} >> ${logfilepath} 2>&1
                cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
            fi
            
            # Handle placement of final object JSON file into standing current object repository next
        else
            #echo `${dtzs}`${dtzsep} '  Only single JSON file created, no need to SLURP together the file!' | tee -a -i ${logfilepath}
            #if [ x"${APICLIfileexport}" != x"${Finaljsonfileexport}" ] ; then
            #    # Making sure we have the final output file in the correct name and at the correct path
            #    cp -fv ${APICLIfileexport} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
            #fi
            
            # Apparently a problem was introduced with the last update, the process generates a broken json file that needs to be fixed
            # fixing the broken json file is done via the Slurp process, but we only have a single file versus a collection;
            # however, we need to still set things up for operation
            
            # Slurp the single JSON files into a single JSON already
            
            export Slurpstarfilename=${APIGenObjobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
            fi
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                # copy the broken json file as the slurpstar file to the slurp work area
                cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
                
                echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
                
                #SlurpJSONFilesIntoSingleFileGenericObjects ${Slurpstarfilefqpn} ${Finaljsonfileexport}
                SlurpJSONFilesIntoSingleFileGenericObjects
            else
                # exported json file is zero length, so process build manual file
                export SLURP_TOTAL=0
                
                echo '{ ' > ${Slurpstarfilefqpn}
                echo '  "objects": [],' >> ${Slurpstarfilefqpn}
                echo '  "from": 0,' >> ${Slurpstarfilefqpn}
                echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpstarfilefqpn}
                echo '  "total": '${SLURP_TOTAL} >> ${Slurpstarfilefqpn}
                echo '}' >> ${Slurpstarfilefqpn}
                
                #cp -fv ${Slurpstarfilefqpn} ${APICLIfileexport} >> ${logfilepath} 2>&1
                cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
            fi
            
            # Handle placement of final object JSON file into standing current object repository next
        fi
    fi
    
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Procedure PrepareToSlurpJSONFilesGenericObjects completed!  errorreturn = '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-12-14:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - ExportObjectViaGenericObjectsToJSONStandard
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-12-14:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Export Objects with utilization of limits and details-level as a standard to JSON
#

ExportObjectViaGenericObjectsToJSONStandard () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APIGenObjobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    if [ ${objectstotal} -gt ${WorkAPIObjectLimit} ] ; then
        export DoFileSlurp=true
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  JSON File Slurp required...' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  JSON File Slurp required...' >> ${logfilepath}
        fi
    else
        export DoFileSlurp=false
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  JSON File Slurp NOT required...' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  JSON File Slurp NOT required...' >> ${logfilepath}
        fi
    fi
    
    objectstotalformatted=`printf "%05d" ${objectstotal}`
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        
        nextoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        
        #if [ ${currentoffset} -gt 0 ] ; then
        #    # Export file for the next ${WorkAPIObjectLimit} objects
        #    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APIGenObjobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
        #fi
        
        currentoffsetformatted=`printf "%05d" ${currentoffset}`
        nextoffsetformatted=`printf "%05d" ${nextoffset}`
        
        # 2017-11-20 Updating naming of files for multiple ${WorkAPIObjectLimit} chunks to clean-up name listing
        if [ ${objectstotal} -gt ${WorkAPIObjectLimit} ] ; then
            # Export file for the next ${WorkAPIObjectLimit} objects
            export APICLIfilename=${APIGenObjobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
            fi
            
            #export APICLIfilename=${APICLIfilename}'_'${currentoffset}'-'${nextoffset}'_of_'${objectstotal}
            export Workingfilename=${APICLIfilename}'_'${currentoffsetformatted}'-'${nextoffsetformatted}'_of_'${objectstotalformatted}
            
            #export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APIGenObjobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
            export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
            export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${APICLIfilename}'_00000-'${objectstotalformatted}'_last'${APICLIJSONfileexportpost}
            
            export Slurpworkfileexport=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
        fi
        
        echo `${dtzs}`${dtzsep} '  Now processing up to next '${WorkAPIObjectLimit}' '${APIGenObjobjecttype}' objects starting with object '${currentoffset}' to '${nextoffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '    Dump to '${APICLIfileexport} >> ${logfilepath}
        fi
        
        # Operational Steps
        # 1.  Export required object data for objecttype to working JSON file ${APICLIJSONfilelast}
        # 2.  Based on export type, so NoSystemsObjects, OnlySystemObjects, or all objects, execute dump of ${APICLIJSONfilelast} through jq using potential object selectors, to export file ${APICLIfileexport}
        # 3.  If needed, copy file for slurp operation to ${Slurpworkfileexport} 
        
        # MODIFIED  -
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} >> ${logfilepath}
        fi
        
        mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLIJSONfilelast}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard : Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLIJSONfilelast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLIJSONfilelast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # MODIFIED 2022-06-17
        #
        
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      No System Objects.  Selector = '${objectqueryselector} | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        elif ${OnlySystemObjects} ; then
            # Select only System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      Only System Objects.  Selector = '${objectqueryselector} | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        elif [ x"${objectqueryselector}" != x"" ] ; then
            # Don't forget to handle cases where object types need selection criteria handled
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      Selected objects based on object type criteria' | tee -a -i ${logfilepath}
            fi
            
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        else
            # Don't Ignore System Objects
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} '      All objects, including System Objects' | tee -a -i ${logfilepath}
            fi
            
            # Processing the file through jq stripping the objects creates a problem file
            cat ${APICLIJSONfilelast} | jq '.objects[]' > ${APICLIfileexport}
            #cat ${APICLIJSONfilelast} > ${APICLIfileexport}
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                echo >> ${logfilepath}
                
                tail ${APICLIfileexport} | tee -a -i ${logfilepath}
                
                echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
                return ${errorreturn}
            fi
        fi
        
        if ${DoFileSlurp} ; then
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                echo `${dtzs}`${dtzsep} '      Dump to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                #cat ${APICLIfileexport} | jq '.objects[]' > ${Slurpworkfileexport}
                cp -fv ${APICLIfileexport} ${Slurpworkfileexport} >> ${logfilepath} 2>&1
            else
                # exported json file is zero length, so do not process file for slurp
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} >> ${logfilepath}
                fi
            fi
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        #currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        currentoffset=${nextoffset}
        
        # MODIFIED 2022-02-15 -
        
        CheckAPIKeepAlive
        
    done
    
    # MODIFIED 2022-12-14:01 -
    
    PrepareToSlurpJSONFilesGenericObjects
    
    # Handle placement of final object JSON file into standing current object repository
    
    HandleJSONRepositoryUpdateGenericObjects
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Head (5) and Tail (5) of the export file : '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        #tail ${APICLIfileexport} | tee -a -i ${logfilepath}
        head -n 5 ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo '...' | tee -a -i ${logfilepath}
        tail -n 5 ${Finaljsonfileexport} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Head (5) and Tail (5) of the export file : '${Finaljsonfileexport} >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        #tail ${APICLIfileexport} >> ${logfilepath}
        head -n 5 ${Finaljsonfileexport} >> ${logfilepath}
        echo '...' >> ${logfilepath}
        tail -n 5 ${Finaljsonfileexport} >> ${logfilepath}
        echo >> ${logfilepath}
        echo '----------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >>  ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-12-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportRAWObjectViaGenericObjectsToJSON
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-12-14:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APIGenObjobjecttype} details is exported to a json at the ${APICLIdetaillvl}.

ExportRAWObjectViaGenericObjectsToJSON () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APIGenObjobjecttype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 0
    fi
    
    if ! ${APIobjectdoexportJSON} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APIGenObjobjecttype}' does NOT support JSON EXPORT!  APIobjectdoexportJSON = '${APIobjectdoexportJSON} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 0
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ "${APICLIdetaillvl}" == "standard" ] ; then
        # Need to check if we have object type selector values, since that won't work with details-level standard!
        if [ x"${APIobjectspecificselector00key}" != x"" ] ; then
            # OK, need to skip this because we can't process this with detials-level "standard"
            echo `${dtzs}`${dtzsep} 'Object type :  '${APICLIobjectstype}' has defined object type selectors set, but details-level is "'${APICLIdetaillvl}'", so skipping to avoid fail!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    # MODIFIED 2022-09-14 -
    
    if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        export WorkAPIObjectLimit=1
        echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit set to '${WorkAPIObjectLimit}' because this object is singular and special' | tee -a -i ${logfilepath}
    else
        export WorkAPIObjectLimit=${MaxAPIObjectLimit}
        if [ -z "${domainnamenospace}" ] ; then
            # an empty ${domainnamenospace} indicates that we are not working towards an MDSM
            export WorkAPIObjectLimit=${APIobjectrecommendedlimit}
        else
            # an empty ${domainnamenospace} indicates that we are working towards an MDSM
            export WorkAPIObjectLimit=${APIobjectrecommendedlimitMDSM}
        fi
        
        echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
        
        if ${OverrideMaxObjects} ; then
            echo `${dtzs}`${dtzsep} 'Override Maximum Objects with OverrideMaxObjectsNumber :  '${OverrideMaxObjectsNumber}' objects value' | tee -a -i ${logfilepath}
            export WorkAPIObjectLimit=${OverrideMaxObjectsNumber}
        fi
        
        echo `${dtzs}`${dtzsep} 'Final WorkAPIObjectLimit :  '${WorkAPIObjectLimit}' objects (SMS = '${APIobjectrecommendedlimit}', MDSM = '${APIobjectrecommendedlimitMDSM}')' | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # Configure object selection query selector
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-06-11 - 
    # Current alternative if more options to exclude are needed, now there is a procedure for that
    
    ConfigureObjectQuerySelector
    
    # -------------------------------------------------------------------------------------------------
    # Configure basic parameters
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2022-12-14:01 -
    
    export WorkingAPICLIdetaillvl=${APICLIdetaillvl}
    
    ConfigureMgmtCLIOperationalParametersExport
    
    export DoFileSlurp=false
    
    export Slurpworkfolder=${APICLIpathexport}
    if ${script_uses_wip_json} ; then
        # script uses work-in-progress (wip) folder for json
        
        export Slurpworkfolder=${APICLIJSONpathexportwip}
        
        if [ ! -r ${APICLIJSONpathexportwip} ] ; then
            mkdir -p -v ${APICLIJSONpathexportwip} >> ${logfilepath} 2>&1
        fi
    fi
    
    export APICLIfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'Start Processing '${APIGenObjobjecttype}':' | tee -a -i ${logfilepath}
    
    objectstotal=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    # -------------------------------------------------------------------------------------------------
    
    export Workingfilename=${APICLIfilename}
    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
    export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}'_last'${APICLIJSONfileexportpost}
    
    errorreturn=0
    
    if [ ${objectstoshow} = null ] ; then
        echo `${dtzs}`${dtzsep} 'Found NO '${APIGenObjobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    elif [ ${objectstoshow} -le 0 ] ; then
        echo `${dtzs}`${dtzsep} 'Found '${objectstoshow}' '${APIGenObjobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    else
        # This object does not have limits to check and probably does not have more than one object entry
        
        ExportObjectViaGenericObjectsToJSONStandard
        
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportRAWObjectViaGenericObjectsToJSON procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-12-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ComplexObjectsJSONViaGenericObjectsHandler proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-12-14:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ComplexObjectsJSONViaGenericObjectsHandler () {
    #
    # Generic Handler for Complex Object Types
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    if ! ${APIobjectdoexport} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support EXPORT!  APIobjectdoexport = '${APIobjectdoexport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    if ! ${APIobjectdoexportJSON} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Object '${APICLIcomplexobjectstype}' does NOT support JSON EXPORT!  APIobjectdoexportJSON = '${APIobjectdoexportJSON} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Skipping!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        
        return 0
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-09-16:01 -
    # Account for whether the original object definition is for REFERENCE, NO IMPORT already
    
    if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    elif ${OnlySystemObjects} ; then
        if [ x"${APICLIexportnameaddon}" == x"" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        elif [ "${APICLIexportnameaddon}" == "REFERENCE_NO_IMPORT" ] ; then
            export APICLIexportnameaddon='FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        else
            export APICLIexportnameaddon=${APICLIexportnameaddon}'_FOR_REFERENCE_ONLY_DO_NOT_IMPORT'
        fi
    else
        export APICLIexportnameaddon=${APICLIexportnameaddon}
    fi
    
    if ${ExportTypeIsStandard} ; then
        #objectstotal_object=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        objectstotal_object=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
        export number_object="${objectstotal_object}"
        
        if [ ${number_object} -le 0 ] ; then
            # No groups found
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate '${APICLIcomplexobjectstype}' members from!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            ExportRAWObjectViaGenericObjectsToJSON
            errorreturn=$?
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        fi
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Not "standard" Export Type :  '${TypeOfExport}' so do not handle complex objects '${APICLIcomplexobjectstype}' for '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error '${errorreturn}' in ComplexObjectsJSONViaGenericObjectsHandler procedure' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        if ${ABORTONERROR} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to EXIT script due to error ${errorreturn}.  Automatic EXIT after ${WAITTIME} seconds : " anykey
            echo
            
            if ${CLIparm_NOHUP} ; then
                # Cleanup Potential file indicating script is active for nohup mode
                if [ -r ${script2nohupactive} ] ; then
                    rm ${script2nohupactive} >> ${logfilepath} 2>&1
                fi
            fi
            
            export dtgs_script_finish=`date -u +%F-%T-%Z`
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Error Return Result     : '"${errorreturn}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Results in directory    : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'JSON objects Repository : '"${JSONRepopathroot}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Log output in file      : '"${logfilepath}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution START  :'"${dtgs_script_start}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Script execution FINISH :'"${dtgs_script_finish}" | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo
            
            if ${APISCRIPTVERBOSE} ; then
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            exit ${errorreturn}
        else
            if ${APISCRIPTVERBOSE} ; then
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
    else
        if ${APISCRIPTVERBOSE} ; then
            if ! ${NOWAIT} ; then
                read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            fi
        fi
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-12-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Simple Object via Generic-Objects Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#if ${NoSystemObjects} ; then
    ## Ignore System Objects
    
#elif ${OnlySystemObjects} ; then
    ## Only System Objects
    
#elif ${CreatorIsNotSystem} ; then
    ## Only System Objects
    
#elif ${CreatorIsSystem} ; then
    ## Only System Objects
    
#else
    ## Don't Ignore System Objects
    
#fi


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Specific Simple OBJECT : application-sites
# Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# Reference Details and initial object
# -------------------------------------------------------------------------------------------------

export AugmentExportedFields=false

if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export AugmentExportedFields=true
elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    export AugmentExportedFields=true
elif ${OnlySystemObjects} ; then
    export AugmentExportedFields=true
else
    export AugmentExportedFields=false
fi

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjCSVobjecttype=${APIGenObjobjecttype}

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APIobjectminversion=1.1
export APICLICSVobjecttype=${APICLIobjectstype}
export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectexportisCPI=true

export APIobjectdoexport=true
export APIobjectdoexportJSON=true
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
export APIobjectdorename=true
export APIobjectdoupdate=true
export APIobjectdodelete=true

export APIobjectusesdetailslevel=true
export APIobjectcanignorewarning=true
export APIobjectcanignoreerror=true
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APIobjecttypehasname=true
export APIobjecttypehasuid=true
export APIobjecttypehasdomain=true
export APIobjecttypehastags=true
export APIobjecttypehasmeta=true
export APIobjecttypeimportname=true

export APIobjectCSVFileHeaderAbsoluteBase=false
export APIobjectCSVJQparmsAbsoluteBase=false

export APIobjectCSVexportWIP=false

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

ComplexObjectsJSONViaGenericObjectsHandler


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more Simple Object via Generic-Objects Handler objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2022-12-14:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Simple Object via Generic-Objects Handler - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-12-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Complex objects - '${scriptactiondescriptor}' Starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#
# Currently JSON export does not require complex object handling
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' Currently JSON export does not require complex object handling!' | tee -a -i ${logfilepath}
#


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - complex objects - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

return 0


# =================================================================================================
# END:  Export objects to json in set detail level from root script
# =================================================================================================
# =================================================================================================

