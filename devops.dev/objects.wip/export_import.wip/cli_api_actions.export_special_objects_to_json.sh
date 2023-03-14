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
ScriptSubRevision=750
ScriptDate=2023-03-14
TemplateVersion=00.60.12
APISubscriptsLevel=010
APISubscriptsVersion=00.60.12
APISubscriptsRevision=100

#

export APIActionsScriptVersion=v${ScriptVersion}
export APIActionScriptTemplateVersion=v${TemplateVersion}

export APIActionsScriptVersionX=v${ScriptVersion//./x}
export APIActionScriptTemplateVersionX=v${TemplateVersion//./x}

ActionScriptName=cli_api_actions.export_special_objects_to_json
export APIActionScriptFileNameRoot=cli_api_actions.export_special_objects_to_json
export APIActionScriptShortName=actions.export_special_objects_to_json
export APIActionScriptnohupName=${APIActionScriptShortName}
export APIActionScriptDescription="Special Object Export to JSON action operations for API CLI Operations"

# =================================================================================================
# =================================================================================================
# START:  Export objects to json in set detail level from root script
# =================================================================================================


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Action Script Name:  '${ActionScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Action Script original call name :  '$0 | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Action Script initial parameters :  '"$@" | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


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


export actionstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log


# =================================================================================================
# START:  Local Proceedures
# =================================================================================================


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


# MODIFIED 2023-03-08:01 - 

# -------------------------------------------------------------------------------------------------
# mgmt_cli keep alive configuration parameters
# -------------------------------------------------------------------------------------------------

#
# mgmtclikeepalivelast       : Very First or Last time CheckAPIKeepAlive was checked, using ${SECONDS}
# mgmtclikeepalivenow        : Current time for check versus last, using ${SECONDS}
# mgmtclikeepaliveelapsed    : The calculated seconds between the current check and last time CheckAPIKeepAlive was checked
# mgmtclikeepaliveinterval   : Interval between executions of CheckAPIKeepAlive desired, with default at 60 seconds
#
# Need to add CLI configuration parameter for this value ${mgmtclikeepaliveinterval} in the future to tweak
#

export mgmtclikeepalivelast=${SECONDS}
export mgmtclikeepalivenow=
export mgmtclikeepaliveelapsed=
export mgmtclikeepaliveinterval=60


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Check API Keep Alive Status - CheckAPIKeepAlive
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Check API Keep Alive Status.
#
CheckAPIKeepAlive () {
    #
    # Check API Keep Alive Status and on error try a login attempt
    #
    
    errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-08:01 - 
    
    #export mgmtclikeepalivelast=${SECONDS}
    #export mgmtclikeepalivenow=
    #export mgmtclikeepaliveinterval=60
    #export mgmtclikeepaliveelapsed=
    
    export mgmtclikeepalivenow=${SECONDS}
    export mgmtclikeepaliveelapsed=$(( ${mgmtclikeepalivenow} - ${mgmtclikeepalivelast} ))
    
    echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  last = '${mgmtclikeepalivelast}' current = '${mgmtclikeepalivenow}' elapsed = '${mgmtclikeepaliveelapsed} >> ${logfilepath}
    
    if [[ ${mgmtclikeepaliveelapsed} -gt ${mgmtclikeepaliveinterval} ]] ; then
        # Last check for keep alive was longer ago than the ${mgmtclikeepaliveinterval} so do the check
        
        # -------------------------------------------------------------------------------------------------
        
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
        tempworklogfile=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.keepalivecheck.log
        
        if ${LoggedIntoMgmtCli} ; then
            #echo -n `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  ' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  Elapsed seoconds since last check = '${mgmtclikeepaliveelapsed}', which is greater than the interval = '${mgmtclikeepaliveinterval} >> ${tempworklogfile}
            echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${tempworklogfile}
            
            echo -n `${dtzs}`${dtzsep}' ' > ${tempworklogfile}
            if ${addversion2keepalive} ; then
                #mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
                mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${tempworklogfile} 2>&1
                export errorreturn=$?
            else
                #mgmt_cli keepalive -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
                mgmt_cli keepalive -s ${APICLIsessionfile} >> ${tempworklogfile} 2>&1
                export errorreturn=$?
            fi
            
            echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${tempworklogfile}
            
            cat ${tempworklogfile} >> ${logfilepath}
            
            echo `${dtzs}`${dtzsep}' Remove temporary log file:  "'${tempworklogfile}'"' >> ${logfilepath}
            echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
            rm -v ${tempworklogfile} >> ${logfilepath} 2>&1
            
            echo `${dtzs}`${dtzsep} 'Keep Alive Check errorreturn = [ '${errorreturn}' ]' | tee -a -i ${logfilepath}
            
            if [ ${errorreturn} != 0 ] ; then
                # Something went wrong, terminate
                echo `${dtzs}`${dtzsep} 'Problem during mgmt_cli keepalive operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
        
        # -------------------------------------------------------------------------------------------------
        
    else
        # Last check for keep alive was more recent than the ${mgmtclikeepaliveinterval} so skip this one
        echo `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  Elapsed seoconds since last check = '${mgmtclikeepaliveelapsed}', which is within the interval = '${mgmtclikeepaliveinterval} >> ${logfilepath}
    fi
    export mgmtclikeepalivelast=${SECONDS}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ - MODIFIED 2023-03-08:01

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


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Execution Common Initial File and Path Location Handlers
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CommonInitialFileAndPathLocationHandlerFirst
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-06:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The CommonInitialFileAndPathLocationHandlerFirst is EXPLAIN.
#

CommonInitialFileAndPathLocationHandlerFirst () {
    
    # ------------------------------------------------------------------------
    #
    # SANITY CHECK FOR ${templogfilepath} and associated log file or HARD EXIT
    #
    
    if [ x"${templogfilepath}" = x"" ] ; then
        # Missing temporary log file path value
        echo `${dtzs}`${dtzsep}
        echo `${dtzs}`${dtzsep} '!!!! ERROR - missing value for ${templogfilepath} ! - EXITING !!!!'
        exit 253
    fi
    if [ ! -r ${templogfilepath} ] ; then
        # Unable to write to temporary log file path
        echo `${dtzs}`${dtzsep}
        echo `${dtzs}`${dtzsep} '!!!! ERROR - Unable to write to temporary log file path : "'${templogfilepath}'" ! - EXITING !!!!'
        exit 252
    fi
    
    # ------------------------------------------------------------------------
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-07:01 -
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
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:02 -
    #
    
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
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
            fi
            
            export JSONRepopathbase=${JSONRepopathroot}/${domainnamenospace}
            
            echo `${dtzs}`${dtzsep} 'Handle adding domain name = ['"${domainnamenospace}"'] to JSON repository path for MDM operations' >> ${templogfilepath}
            echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
            
            if [ ! -r ${JSONRepopathbase} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>&1
            fi
        else
            # Domain name is empty so not adding
            export APICLIpathexport=${APICLICSVExportpathbase}
            
            echo `${dtzs}`${dtzsep} 'Handle empty domain name to path for MDM operations, so NO CHANGE' >> ${templogfilepath}
            echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
            
            if [ ! -r ${APICLIpathexport} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
            fi
            
            export JSONRepopathbase=${JSONRepopathroot}
            
            echo `${dtzs}`${dtzsep} 'Handle empty domain name to JSON repository path for MDM operations, so NO CHANGE' >> ${templogfilepath}
            echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
            
            if [ ! -r ${JSONRepopathbase} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>&1
            fi
        fi
    else
        # NOT adding domain name to path for MDM operations
        export APICLIpathexport=${APICLICSVExportpathbase}
        
        echo `${dtzs}`${dtzsep} 'NOT adding domain name = ['"${domainnamenospace}"'] to path for MDM operations' >> ${templogfilepath}
        echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
        
        if [ ! -r ${APICLIpathexport} ] ; then
            echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
            mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
        fi
        
        export JSONRepopathbase=${JSONRepopathroot}
        
        echo `${dtzs}`${dtzsep} 'NOT adding domain name = ['"${domainnamenospace}"'] to JSON repository path for MDM operations' >> ${templogfilepath}
        echo `${dtzs}`${dtzsep} 'JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
        
        if [ ! -r ${JSONRepopathbase} ] ; then
            echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
            mkdir -p -v ${JSONRepopathbase} >> ${templogfilepath} 2>&1
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'Final APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Final JSONRepopathbase = '${JSONRepopathbase} >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CommonInitialFileAndPathLocationHandlerLast
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-06:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The CommonInitialFileAndPathLocationHandlerLast is EXPLAIN.
#

CommonInitialFileAndPathLocationHandlerLast () {
    
    # ------------------------------------------------------------------------
    #
    # SANITY CHECK FOR ${templogfilepath} and associated log file or HARD EXIT
    #
    
    if [ x"${templogfilepath}" = x"" ] ; then
        # Missing temporary log file path value
        echo `${dtzs}`${dtzsep}
        echo `${dtzs}`${dtzsep} '!!!! ERROR - missing value for ${templogfilepath} ! - EXITING !!!!'
        exit 253
    fi
    if [ ! -r ${templogfilepath} ] ; then
        # Unable to write to temporary log file path
        echo `${dtzs}`${dtzsep}
        echo `${dtzs}`${dtzsep} '!!!! ERROR - Unable to write to temporary log file path : "'${templogfilepath}'" ! - EXITING !!!!'
        exit 252
    fi
    
    # ------------------------------------------------------------------------
    
    # ------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:02 -
    #
    
    if [ x"${primarytargetoutputformat}" = x"${FileExtJSON}" ] ; then
        # for JSON provide the detail level
        
        export APICLIpathexport=${APICLIpathexport}/${APICLIdetaillvl}
        
        if [ ! -r ${APICLIpathexport} ] ; then
            echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
            mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
        fi
        
        export APICLIJSONpathexportwip=
        if ${script_uses_wip_json} ; then
            # script uses work-in-progress (wip) folder for json
            
            export APICLIJSONpathexportwip=${APICLIpathexport}/wip
            
            if [ ! -r ${APICLIJSONpathexportwip} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${APICLIJSONpathexportwip} >> ${templogfilepath} 2>&1
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
    
    # MODIFIED 2023-03-06:02 -
    #
    
    if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
        # for CSV handle specifics, like wip
        
        export APICLICSVpathexportwip=
        if ${script_uses_wip} ; then
            # script uses work-in-progress (wip) folder for csv
            
            export APICLICSVpathexportwip=${APICLIpathexport}/wip
            
            if [ ! -r ${APICLICSVpathexportwip} ] ; then
                echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
                mkdir -p -v ${APICLICSVpathexportwip} >> ${templogfilepath} 2>&1
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
    
    # MODIFIED 2023-03-06:02 -
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
    
    # MODIFIED 2023-03-06:02 -
    #
    
    #printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'X' "${X}" >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} 'Working operations file and path variables' >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'primarytargetoutputformat' "${primarytargetoutputformat}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'APICLIpathexport' "${APICLIpathexport}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathroot' "${JSONRepopathroot}" >> ${templogfilepath}
    printf "`${dtzs}`${dtzsep}"'variable :  %-35s = %s\n' 'JSONRepopathbase' "${JSONRepopathbase}" >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------'  >>  ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${templogfilepath}
    
    # ------------------------------------------------------------------------
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END : Execution Common Initial File and Path Location Handlers
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# Start executing Main operations
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Configure working paths for export and dump
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-06:02 -
#

# ------------------------------------------------------------------------
# Set and clear temporary log file
# ------------------------------------------------------------------------

export templogfilepath=/var/tmp/templog_${ScriptName}.`date +%Y%m%d-%H%M%S%Z`.log
echo `${dtzs}`${dtzsep} > ${templogfilepath}

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------'  >>  ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Configure working paths for export and dump' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} >> ${templogfilepath}

# ------------------------------------------------------------------------

CommonInitialFileAndPathLocationHandlerFirst

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
# ------------------------------------------------------------------------
# START:  This section is specific to scripts that ARE action handlers
# ------------------------------------------------------------------------

# MODIFIED 2023-03-06:02 -
#

# primary operation is export to primarytargetoutputformat
export APICLIpathexport=${APICLIpathexport}/${primarytargetoutputformat}

echo `${dtzs}`${dtzsep} | tee -a -i ${templogfilepath}
echo `${dtzs}`${dtzsep} 'Export to '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}

if [ ! -r ${APICLIpathexport} ] ; then
    echo -n `${dtzs}`${dtzsep}' ' >> ${templogfilepath}
    mkdir -p -v ${APICLIpathexport} >> ${templogfilepath} 2>&1
fi

echo `${dtzs}`${dtzsep} >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'After Evaluation of script type' >> ${templogfilepath}
echo `${dtzs}`${dtzsep} 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}


# ------------------------------------------------------------------------
# END:  This section is specific to scripts that ARE action handlers
# ------------------------------------------------------------------------
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
# ------------------------------------------------------------------------

CommonInitialFileAndPathLocationHandlerLast

# ------------------------------------------------------------------------

# MODIFIED 2023-03-06:02 -
#

echo `${dtzs}`${dtzsep} 'Import temporary log file from "'${templogfilepath}'"' >> ${templogfilepath}

echo `${dtzs}`${dtzsep} >> ${logfilepath}

##echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
cat ${templogfilepath} >> ${logfilepath} 2>&1

echo -n `${dtzs}`${dtzsep}' ' >> ${logfilepath}
rm -v ${templogfilepath} >> ${logfilepath} 2>&1

echo `${dtzs}`${dtzsep} >> ${logfilepath}

# ------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Configure working paths for export and dump - Completed
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------



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
# SetupExportObjectsToJSONandRepository
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-03:01\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportObjectsToJSONandRepository is the setup actions for the script's json export repeated actions.
#

SetupExportObjectsToJSONandRepository () {
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIobjectstype}'  Number of Objects :  '${number_of_objects} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'X' "${X}" >> ${logfilepath}
    #
    
    ConfigureWorkAPIObjectLimit
    
    # Build the object type specific output file
    
    # MODIFIED 2023-03-03:01 -
    
    # Configure the JSON Repository File information
    
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
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoDetailname' "${JSONRepoDetailname}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    ConfigureJSONRepoFileNamesAndPaths
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-03:01


# -------------------------------------------------------------------------------------------------
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
        echo `${dtzs}`${dtzsep} 'Procedure ConfigureMgmtCLIOperationalParametersExport completed!  errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-06-12:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ClearObjectDefinitionData
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ClearObjectDefinitionData clear the data associated with objects to zero and start clean.
#

ClearObjectDefinitionData () {
    
    #
    # Maximum Object defined
    #
    
    # +-------------------------------------------------------------------------------------------------
    # | Complex Object : Specific Complex OBJECT : 
    # |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
    # |  - Reference Details and initial object
    # +-------------------------------------------------------------------------------------------------
    
    #export APICLIobjecttype=<object_type_singular>
    #export APICLIobjectstype=<object_type_plural>
    #export APICLIcomplexobjecttype=<complex_object_type_singular>
    #export APICLIcomplexobjectstype=<complex_object_type_plural>
    #export APIobjectminversion=<object_type_api_version>|example:  1.1
    #export APIobjectexportisCPI=false|true
    
    #export APIGenObjectTypes=<Generic-Object-Type>|example:  generic-objects
    #export APIGenObjectClassField=<Generic-Object-ClassField>|example:  class-name
    #export APIGenObjectClass=<Generic-Object-Class>|example:  "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
    #export APIGenObjectClassShort=<Generic-Object-Class-Short>|example:  "appfw.CpmiUserApplication"
    #export APIGenObjectField=<Generic-Object-Key-Field>|example:  uid
    
    #export APIGenObjobjecttype=<Generic-Object-Type>|example:  appfw_CpmiUserApplication_application-site
    #export APIGenObjobjectstype=<Generic-Objects-Type-plural>|example:  appfw_CpmiUserApplication_application-sites
    #export APIGenObjcomplexobjecttype=<Generic-Complex-Object-Type>|example:  appfw_CpmiUserApplication_application-site
    #export APIGenObjcomplexobjectstype=<Generic-Complex-Objects-Type-plural>|example:  appfw_CpmiUserApplication_application-sites
    #export APIGenObjobjectkey=name
    #export APIGenObjobjectkeydetailslevel=standard
    
    #export APIobjectspecifickey='url-list'
    
    #export APIobjectspecificselector00key=
    #export APIobjectspecificselector00value=
    #export APICLIexportnameaddon=
    
    #export APICLIexportcriteria01key=
    #export APICLIexportcriteria01value=
    
    #export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
    #export APICLICSVobjecttype=${APICLIobjectstype}
    #export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
    #export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
    #export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
    #export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}
    #
    #export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
    #export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
    
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
    #export APIobjectcansetifexists=false
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
    
    #export AugmentExportedFields=false
    
    #if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        #export AugmentExportedFields=true
    #elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
        #export AugmentExportedFields=true
    #elif ${OnlySystemObjects} ; then
        #export AugmentExportedFields=true
    #else
        #export AugmentExportedFields=false
    #fi
    
    #if ! ${AugmentExportedFields} ; then
        #export APICLIexportnameaddon=
    #else
        #export APICLIexportnameaddon=FOR_REFERENCE_ONLY
    #fi
    
    ##
    ## APICLICSVsortparms can change due to the nature of the object
    ##
    #export APICLICSVsortparms='-f -t , -k 1,1'
    
    #export CSVFileHeader=
    #if ! ${AugmentExportedFields} ; then
        #export CSVFileHeader='"primary-category"'
        ## The risk key is not imported
        ##export CSVFileHeader=${CSVFileHeader}',"risk"'
    #else
        #export CSVFileHeader='"application-id","primary-category"'
        ## The risk key is not imported
        ##export CSVFileHeader=${CSVFileHeader}',"risk"'
    #fi
    ##export CSVFileHeader=
    ##export CSVFileHeader='"key","key"'
    ##export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
    ##export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
    ##export CSVFileHeader=${CSVFileHeader}',"icon"'
    
    #export CSVJQparms=
    #if ! ${AugmentExportedFields} ; then
        #export CSVJQparms='.["primary-category"]'
        ## The risk key is not imported
        ##export CSVJQparms=${CSVJQparms}', .["risk"]'
    #else
        #export CSVJQparms='.["application-id"], .["primary-category"]'
        ## The risk key is not imported
        #export CSVJQparms=${CSVJQparms}', .["risk"]'
    #fi
    ##export CSVJQparms=
    ##export CSVJQparms='.["value"], .["value"]'
    ##export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
    ##export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
    ##export CSVJQparms=${CSVJQparms}', .["icon"]'
    
    # +-------------------------------------------------------------------------------------------------
    # +-------------------------------------------------------------------------------------------------
    
    export APICLIobjecttype=
    export APICLIobjectstype=
    export APICLIcomplexobjecttype=
    export APICLIcomplexobjectstype=
    export APIobjectminversion=
    export APIobjectexportisCPI=
    
    export APIGenObjectTypes=
    export APIGenObjectClassField=
    export APIGenObjectClass=
    export APIGenObjectClassShort=
    export APIGenObjectField=
    
    export APIGenObjobjecttype=
    export APIGenObjobjectstype=
    export APIGenObjcomplexobjecttype=
    export APIGenObjcomplexobjectstype=
    export APIGenObjjsonrepofileobject=
    export APIGenObjcomplexjsonrepofileobject=
    export APIGenObjCSVobjecttype=
    export APIGenObjcomplexCSVobjecttype=
    export APIGenObjobjectkey=
    export APIGenObjobjectkeydetailslevel=
    
    export APIobjectspecifickey=
    
    export APIobjectspecificselector00key=
    export APIobjectspecificselector00value=
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key=
    export APICLIexportcriteria01value=
    
    export APIobjectjsonrepofileobject=
    export APICLICSVobjecttype=
    export APIobjectrecommendedlimit=
    export APIobjectrecommendedlimitMDSM=
    
    export APIobjectdoexport=
    export APIobjectdoexportJSON=
    export APIobjectdoexportCSV=
    export APIobjectdoimport=
    export APIobjectdorename=
    export APIobjectdoupdate=
    export APIobjectdodelete=
    
    export APIobjectusesdetailslevel=
    export APIobjectcanignorewarning=
    export APIobjectcanignoreerror=
    export APIobjectcansetifexists=
    export APIobjectderefgrpmem=
    export APIobjecttypehasname=
    export APIobjecttypehasuid=
    export APIobjecttypehasdomain=
    export APIobjecttypehastags=
    export APIobjecttypehasmeta=
    export APIobjecttypeimportname=
    
    export APIobjectCSVFileHeaderAbsoluteBase=
    export APIobjectCSVJQparmsAbsoluteBase=
    
    export APIobjectCSVexportWIP=
    
    export AugmentExportedFields=
    
    export CSVFileHeader=
    export CSVJQparms=
    
    # +-------------------------------------------------------------------------------------------------
    # +-------------------------------------------------------------------------------------------------
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-08:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DumpObjectDefinitionData
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The DumpObjectDefinitionData dump the content of the current object definition data to terminal and/or log.
#

DumpObjectDefinitionData () {
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Object Definition Data details - show and log' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AAA' "${AAA}" | tee -a -i ${logfilepath}
        #
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjecttype' "${APICLIobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjectstype' "${APICLIobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjecttype' "${APICLIcomplexobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjectstype' "${APICLIcomplexobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectminversion' "${APIobjectminversion}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectexportisCPI' "${APIobjectexportisCPI}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectTypes' "${APIGenObjectTypes}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassField' "${APIGenObjectClassField}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClass' "${APIGenObjectClass}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassShort' "${APIGenObjectClassShort}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectField' "${APIGenObjectField}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjecttype' "${APIGenObjobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjecttype' "${APIGenObjcomplexobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjectstype' "${APIGenObjcomplexobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjjsonrepofileobject' "${APIGenObjjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexjsonrepofileobject' "${APIGenObjcomplexjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjCSVobjecttype' "${APIGenObjCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexCSVobjecttype' "${APIGenObjcomplexCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkey' "${APIGenObjobjectkey}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkeydetailslevel' "${APIGenObjobjectkeydetailslevel}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecifickey' "${APIobjectspecifickey}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00key' "${APIobjectspecificselector00key}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00value' "${APIobjectspecificselector00value}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportnameaddon' "${APICLIexportnameaddon}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01key' "${APICLIexportcriteria01key}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01value' "${APICLIexportcriteria01value}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVobjecttype' "${APICLICSVobjecttype}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimit' "${APIobjectrecommendedlimit}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimitMDSM' "${APIobjectrecommendedlimitMDSM}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexport' "${APIobjectdoexport}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportJSON' "${APIobjectdoexportJSON}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportCSV' "${APIobjectdoexportCSV}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoimport' "${APIobjectdoimport}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdorename' "${APIobjectdorename}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoupdate' "${APIobjectdoupdate}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdodelete' "${APIobjectdodelete}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectusesdetailslevel' "${APIobjectusesdetailslevel}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignorewarning' "${APIobjectcanignorewarning}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignoreerror' "${APIobjectcanignoreerror}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcansetifexists' "${APIobjectcansetifexists}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectderefgrpmem' "${APIobjectderefgrpmem}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasname' "${APIobjecttypehasname}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasuid' "${APIobjecttypehasuid}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasdomain' "${APIobjecttypehasdomain}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehastags' "${APIobjecttypehastags}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasmeta' "${APIobjecttypehasmeta}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypeimportname' "${APIobjecttypeimportname}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVFileHeaderAbsoluteBase' "${APIobjectCSVFileHeaderAbsoluteBase}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVJQparmsAbsoluteBase' "${APIobjectCSVJQparmsAbsoluteBase}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVexportWIP' "${APIobjectCSVexportWIP}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AugmentExportedFields' "${AugmentExportedFields}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVFileHeader' "${CSVFileHeader}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVJQparms' "${CSVJQparms}" >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
    else
        echo `${dtzs}`${dtzsep} 'Object Definition Data details - dump to log' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AAA' "${AAA}" >> ${logfilepath}
        #
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjecttype' "${APICLIobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjectstype' "${APICLIobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjecttype' "${APICLIcomplexobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjectstype' "${APICLIcomplexobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectminversion' "${APIobjectminversion}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectexportisCPI' "${APIobjectexportisCPI}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectTypes' "${APIGenObjectTypes}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassField' "${APIGenObjectClassField}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClass' "${APIGenObjectClass}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassShort' "${APIGenObjectClassShort}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectField' "${APIGenObjectField}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjecttype' "${APIGenObjobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjecttype' "${APIGenObjcomplexobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjectstype' "${APIGenObjcomplexobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjjsonrepofileobject' "${APIGenObjjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexjsonrepofileobject' "${APIGenObjcomplexjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjCSVobjecttype' "${APIGenObjCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexCSVobjecttype' "${APIGenObjcomplexCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkey' "${APIGenObjobjectkey}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkeydetailslevel' "${APIGenObjobjectkeydetailslevel}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecifickey' "${APIobjectspecifickey}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00key' "${APIobjectspecificselector00key}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00value' "${APIobjectspecificselector00value}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportnameaddon' "${APICLIexportnameaddon}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01key' "${APICLIexportcriteria01key}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01value' "${APICLIexportcriteria01value}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVobjecttype' "${APICLICSVobjecttype}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimit' "${APIobjectrecommendedlimit}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimitMDSM' "${APIobjectrecommendedlimitMDSM}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexport' "${APIobjectdoexport}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportJSON' "${APIobjectdoexportJSON}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportCSV' "${APIobjectdoexportCSV}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoimport' "${APIobjectdoimport}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdorename' "${APIobjectdorename}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoupdate' "${APIobjectdoupdate}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdodelete' "${APIobjectdodelete}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectusesdetailslevel' "${APIobjectusesdetailslevel}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignorewarning' "${APIobjectcanignorewarning}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignoreerror' "${APIobjectcanignoreerror}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcansetifexists' "${APIobjectcansetifexists}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectderefgrpmem' "${APIobjectderefgrpmem}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasname' "${APIobjecttypehasname}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasuid' "${APIobjecttypehasuid}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasdomain' "${APIobjecttypehasdomain}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehastags' "${APIobjecttypehastags}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasmeta' "${APIobjecttypehasmeta}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypeimportname' "${APIobjecttypeimportname}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVFileHeaderAbsoluteBase' "${APIobjectCSVFileHeaderAbsoluteBase}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVJQparmsAbsoluteBase' "${APIobjectCSVJQparmsAbsoluteBase}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVexportWIP' "${APIobjectCSVexportWIP}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AugmentExportedFields' "${AugmentExportedFields}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVFileHeader' "${CSVFileHeader}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVJQparms' "${CSVJQparms}" >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
    fi
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-08:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureWorkAPIObjectLimit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-03:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureWorkAPIObjectLimit handles the stanard configuration of the ${WorkAPIObjectLimit} value.
#

ConfigureWorkAPIObjectLimit () {
    
    # MODIFIED 2023-03-03:02 -
    
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
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimit' "${APIobjectrecommendedlimit}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimitMDSM' "${APIobjectrecommendedlimitMDSM}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'WorkAPIObjectLimit' "${WorkAPIObjectLimit}" >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-03:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureCSVFileNamesForExport
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureCSVFileNamesForExport Configures the CSV File name for Export operations.
#

ConfigureCSVFileNamesForExport () {
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APICLICSVobjecttype}" != x"" ] ; then
        export APICLICSVfilename=${APICLICSVobjecttype}
    elif [ x"${APICLIcomplexobjectstype}" != x"" ] ; then
        export APICLICSVfilename=${APICLIcomplexobjectstype}
    else
        export APICLICSVfilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLICSVfilename=${APICLICSVfilename}'_'${APICLIexportnameaddon}
    fi
    export APICLICSVfilename=${APICLICSVfilename}'_'${APICLIdetaillvl}'_csv'${APICLICSVfileexportsuffix}
    export APICLICSVfile=${APICLIpathexport}/${APICLICSVfilename}
    export APICLICSVfilewip=${APICLICSVpathexportwip}/${APICLICSVfilename}
    export APICLICSVfileheader=${APICLICSVfilewip}.${APICLICSVheaderfilesuffix}
    export APICLICSVfiledata=${APICLICSVfilewip}.data
    export APICLICSVfilesort=${APICLICSVfilewip}.sort
    export APICLICSVfiledatalast=${APICLICSVfilewip}.datalast
    export APICLICSVfileoriginal=${APICLICSVfilewip}.original
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVpathexportwip' "${APICLICSVpathexportwip}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportnameaddon' "${APICLIexportnameaddon}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIdetaillvl' "${APICLIdetaillvl}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfileexportsuffix' "${APICLICSVfileexportsuffix}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIpathexport' "${APICLIpathexport}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfilename' "${APICLICSVfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfile' "${APICLICSVfile}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVpathexportwip' "${APICLICSVpathexportwip}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfilewip' "${APICLICSVfilewip}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVheaderfilesuffix' "${APICLICSVheaderfilesuffix}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfileheader' "${APICLICSVfileheader}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfiledata' "${APICLICSVfiledata}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfilesort' "${APICLICSVfilesort}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfiledatalast' "${APICLICSVfiledatalast}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVfileoriginal' "${APICLICSVfileoriginal}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureJSONRepoFileNamesAndPaths
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureJSONRepoFileNamesAndPaths sets up the file name and paths to the JSON Repository.
#

ConfigureJSONRepoFileNamesAndPaths () {
    
    echo `${dtzs}`${dtzsep} 'Using the following details level for the JSON Repository = '${JSONRepoDetailname} >> ${logfilepath}
    
    # Configure the JSON Repository File information
    
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
    
    export JSONRepofilepost='_'${JSONRepoDetailname}'_'${JSONRepofilesuffix}
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APIobjectjsonrepofileobject}" != x"" ] ; then
        export JSONRepofilename=${APIobjectjsonrepofileobject}
    else
        export JSONRepofilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        # We need to check if we can actually use the ${APICLIexportnameaddon}
        if [ -r "${JSONRepopathworking}/${JSONRepofilepre}${JSONRepofilename}'_'${APICLIexportnameaddon}${JSONRepofilepost}" ] ; then
            # the JSON repository actually contains the file with the ${APICLIexportnameaddon}, so use it
            export JSONRepofilename=${JSONRepofilename}'_'${APICLIexportnameaddon}
        else
            # the JSON repository does not contain the file with the ${APICLIexportnameaddon}, so use the basic value
            export JSONRepofilename=${JSONRepofilename}
        fi
    fi
    
    export JSONRepoFile=${JSONRepopathworking}/${JSONRepofilepre}${JSONRepofilename}${JSONRepofilepost}
    
    export APICLIJSONfilelast=${APICLICSVpathexportwip}/${APICLICSVfilename}'_json_last'${APICLIJSONfileexportsuffix}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjectstype' "${APICLIobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoDetailname' "${JSONRepoDetailname}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepopathbase' "${JSONRepopathbase}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoDetailname' "${JSONRepoDetailname}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepopathworking' "${JSONRepopathworking}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepofilepre' "${JSONRepofilepre}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepofilename' "${JSONRepofilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepofilepost' "${JSONRepofilepost}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepopathworking' "${JSONRepopathworking}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoFile' "${JSONRepoFile}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIJSONfilelast' "${APICLIJSONfilelast}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureComplexObjectJSONRepoFileNamesAndPaths
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureComplexObjectJSONRepoFileNamesAndPaths sets up the file name and paths to the JSON Repository for a  Complex Object.
#

ConfigureComplexObjectJSONRepoFileNamesAndPaths () {
    
    # First configure the default plumbing for a JSON Repository File and Path
    
    ConfigureJSONRepoFileNamesAndPaths
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APIobjectjsonrepofileobject}" != x"" ] ; then
        export JSONRepoComplexObjectfilename=${APIobjectjsonrepofileobject}
    elif [ x"${APICLIcomplexobjectstype}" != x"" ] ; then
        export JSONRepoComplexObjectfilename=${APICLIcomplexobjectstype}
    else
        export JSONRepofilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        # We need to check if we can actually use the ${APICLIexportnameaddon}
        if [ -r "${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoComplexObjectfilename}'_'${APICLIexportnameaddon}${JSONRepofilepost}" ] ; then
            # the JSON repository actually contains the file with the ${APICLIexportnameaddon}, so use it
            export JSONRepoComplexObjectfilename=${JSONRepoComplexObjectfilename}'_'${APICLIexportnameaddon}
        else
            # the JSON repository does not contain the file with the ${APICLIexportnameaddon}, so use the basic value
            export JSONRepoComplexObjectfilename=${JSONRepoComplexObjectfilename}
        fi
    fi
    
    export JSONRepoComplexObjectFile=${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoComplexObjectfilename}${JSONRepofilepost}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjectstype' "${APICLIcomplexobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoComplexObjectfilename' "${JSONRepoComplexObjectfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoComplexObjectFile' "${JSONRepoComplexObjectFile}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureGenericObjectJSONRepoFileNamesAndPaths
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureGenericObjectJSONRepoFileNamesAndPaths sets up the file name and paths to the JSON Repository for a Generic API Object.
#

ConfigureGenericObjectJSONRepoFileNamesAndPaths () {
    
    # First configure the default plumbing for a JSON Repository File and Path
    
    ConfigureJSONRepoFileNamesAndPaths
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APIGenObjjsonrepofileobject}" != x"" ] ; then
        export JSONRepoAPIGenObjectfilename=${APIGenObjjsonrepofileobject}
    elif [ x"${APIGenObjobjectstype}" != x"" ] ; then
        export JSONRepoAPIGenObjectfilename=${APIGenObjobjectstype}
    else
        export JSONRepoAPIGenObjectfilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        # We need to check if we can actually use the ${APICLIexportnameaddon}
        if [ -r "${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoAPIGenObjectfilename}'_'${APICLIexportnameaddon}${JSONRepofilepost}" ] ; then
            # the JSON repository actually contains the file with the ${APICLIexportnameaddon}, so use it
            export JSONRepoAPIGenObjectfilename=${JSONRepoAPIGenObjectfilename}'_'${APICLIexportnameaddon}
        else
            # the JSON repository does not contain the file with the ${APICLIexportnameaddon}, so use the basic value
            export JSONRepoAPIGenObjectfilename=${JSONRepoAPIGenObjectfilename}
        fi
    fi
    
    export JSONRepoAPIGenObjectFile=${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoAPIGenObjectfilename}${JSONRepofilepost}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjjsonrepofileobject' "${APIGenObjjsonrepofileobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenObjectfilename' "${JSONRepoAPIGenObjectfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenObjectFile' "${JSONRepoAPIGenObjectFile}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureGenericComplexObjectJSONRepoFileNamesAndPaths
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ConfigureGenericComplexObjectJSONRepoFileNamesAndPaths sets up the file name and paths to the JSON Repository for a Generic API Complex Object.
#

ConfigureGenericComplexObjectJSONRepoFileNamesAndPaths () {
    
    # First configure the default plumbing for a JSON Repository File and Path
    
    ConfigureJSONRepoFileNamesAndPaths
    
    # MODIFIED 2023-03-04:01 -
    
    if [ x"${APIGenObjcomplexjsonrepofileobject}" != x"" ] ; then
        export JSONRepoAPIGenComplexObjectfilename=${APIGenObjcomplexjsonrepofileobject}
    elif [ x"${APIGenObjcomplexobjectstype}" != x"" ] ; then
        export JSONRepoAPIGenComplexObjectfilename=${APIGenObjcomplexobjectstype}
    elif [ x"${APIGenObjobjectstype}" != x"" ] ; then
        export JSONRepoAPIGenComplexObjectfilename=${APIGenObjobjectstype}
    else
        export JSONRepoAPIGenComplexObjectfilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        # We need to check if we can actually use the ${APICLIexportnameaddon}
        if [ -r "${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoAPIGenComplexObjectfilename}'_'${APICLIexportnameaddon}${JSONRepofilepost}" ] ; then
            # the JSON repository actually contains the file with the ${APICLIexportnameaddon}, so use it
            export JSONRepoAPIGenComplexObjectfilename=${JSONRepoAPIGenComplexObjectfilename}'_'${APICLIexportnameaddon}
        else
            # the JSON repository does not contain the file with the ${APICLIexportnameaddon}, so use the basic value
            export JSONRepoAPIGenComplexObjectfilename=${JSONRepoAPIGenComplexObjectfilename}
        fi
    fi
    
    export JSONRepoAPIGenComplexObjectFile=${JSONRepopathworking}/${JSONRepofilepre}${JSONRepoAPIGenComplexObjectfilename}${JSONRepofilepost}
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexjsonrepofileobject' "${APIGenObjcomplexjsonrepofileobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjectstype' "${APIGenObjcomplexobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenComplexObjectfilename' "${JSONRepoAPIGenComplexObjectfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenComplexObjectFile' "${JSONRepoAPIGenComplexObjectFile}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-04:01


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
    
    echo `${dtzs}`${dtzsep} '    Object Query Selector in []s is ['${objectqueryselector}']' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-06-18:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational repeated proceedure - CommonJSONRepositoryUpdateHander
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-24:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Handle placement of final object JSON file into standing current object repository
#

CommonJSONRepositoryUpdateHander () {
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
    
    echo `${dtzs}`${dtzsep} 'CommonJSONRepositoryUpdateHander procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-24:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational repeated proceedure - CommonSlurpJSONFilesIntoSingleFile
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-24:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Use JQ to Slurp JSON files into single JSON file from multiple files
#

CommonSlurpJSONFilesIntoSingleFile () {
    #
    # Use JQ to Slurp JSON files into single JSON file from multiple files
    #
    
    errorreturn=0
    
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
    echo `${dtzs}`${dtzsep} 'CommonSlurpJSONFilesIntoSingleFile procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-24:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Prepare operations to Slurp JSON files - PrepareToSlurpJSONFiles
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-24:02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Prepare operations to Slurp JSON files and call common Slurp handler.
#
PrepareToSlurpJSONFiles () {
    #
    # Prepare operations to Slurp JSON files and call common Slurp handler
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
    
    # MODIFIED 2023-02-24:01  -
    
    export Slurpstarfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
    fi
    
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
    
    if ${DoFileSlurp} ; then
        export Slurpstarfilename=${Slurpstarfilename}'_*_of_'${objectstotalformatted}
        export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
        
        echo `${dtzs}`${dtzsep} '  Multiple JSON files created, need to SLURP together the file!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp these files     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        
        # Slurp the collection of JSON files into a single JSON already
        
        # -------------------------------------------------------------------------------------------------
        
        CommonSlurpJSONFilesIntoSingleFile
        
        # -------------------------------------------------------------------------------------------------
        
    else
        # File is single JSON already
        if ${NoSystemObjects} ; then
            
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_NSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        elif ${OnlySystemObjects} ; then
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_OSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        else
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        fi
        
        # Slurp the single JSON files into a single JSON already
        
        if [ -s ${APICLIfileexport} ] ; then
            # exported json file is not zero length, so process for slurp
            # copy the broken json file as the slurpstar file to the slurp work area
            cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
            
            echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
            
            # -------------------------------------------------------------------------------------------------
            
            CommonSlurpJSONFilesIntoSingleFile
            
            # -------------------------------------------------------------------------------------------------
        else
            # exported json file is zero length, so process build manual file
            export SLURP_TOTAL=0
            
            echo '{ ' > ${Slurpstarfilefqpn}
            echo '  "objects": [],' >> ${Slurpstarfilefqpn}
            echo '  "from": 0,' >> ${Slurpstarfilefqpn}
            echo '  "to": '${SLURP_TOTAL}',' >> ${Slurpstarfilefqpn}
            echo '  "total": '${SLURP_TOTAL} >> ${Slurpstarfilefqpn}
            echo '}' >> ${Slurpstarfilefqpn}
            
            cp -fv ${Slurpstarfilefqpn} ${Finaljsonfileexport} >> ${logfilepath} 2>&1
        fi
        
    fi
    
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Procedure PrepareToSlurpJSONFiles completed!  errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-24:02

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DetermineIfDoMgmtCLIQuery
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# DetermineIfDoMgmtCLIQuery executes check if executing export using mgmt_cli command.
#

DetermineIfDoMgmtCLIQuery () {
    #
    # Expected configured key input values
    #
    # ${script_use_json_repo}
    # ${UseJSONRepo}
    # ${objectstoshow}
    # ${APICLIobjectstype}
    # ${JSONRepoObjectsTotal}
    # ${JSONRepoFile}
    #
    # Output values:
    #
    # ${domgmtcliquery}
    # ${errorreturn}
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    export domgmtcliquery=false
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQuery procedure Starting...' | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'objectstoshow' "${objectstoshow}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoObjectsTotal' "${JSONRepoObjectsTotal}" >> ${logfilepath}
    
    if ! ${script_use_json_repo} ; then
        # Script use of JSON Repository is denied
        echo `${dtzs}`${dtzsep} 'Script use of JSON Repository file "'${JSONRepoFile}'" is DENIED by script!' | tee -a -i ${logfilepath}
        export domgmtcliquery=true
    elif ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of JSON Repository file "'${JSONRepoFile}'" for operation.' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            CompareObjectsTotalEqual=false
        elif ${OnlySystemObjects} ; then
            CompareObjectsTotalEqual=false
        else
            CompareObjectsTotalEqual=true
        fi
        
        if ${CompareObjectsTotalEqual} ; then
            if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                export domgmtcliquery=false
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
                echo `${dtzs}`${dtzsep} 'Object count of '${APICLIobjectstype}' objects [ '${objectstoshow}' ] does not match count of [ '${JSONRepoObjectsTotal}' ] in JSON Repository file!' | tee -a -i ${logfilepath}
            fi
        else
            if [[ ${JSONRepoObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if [[ ${objectstoshow} -eq ${JSONRepoObjectsTotal} ]] ; then
                    # JSON Repository has the same number of objects as the management database
                    export domgmtcliquery=false
                else
                    # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                    export domgmtcliquery=true
                    echo `${dtzs}`${dtzsep} 'Object count of '${APICLIobjectstype}' objects [ '${objectstoshow}' ] does not match count of [ '${JSONRepoObjectsTotal}' ] in JSON Repository file!' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquery=true
            fi
        fi
    else
        # Use of JSON Repository Disabled
        echo `${dtzs}`${dtzsep} 'Script use of JSON Repository file "'${JSONRepoFile}'" is DENIED by operation!' | tee -a -i ${logfilepath}
        export domgmtcliquery=true
    fi
    
    if ${domgmtcliquery} ; then
        echo `${dtzs}`${dtzsep} 'NOT Using JSON Repository file "'${JSONRepoFile}'" for operation, shift to mgmt_cli query.' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Using JSON Repository for [ '${objectstoshow}' : '${JSONRepoObjectsTotal}' ] of '${APICLIobjectstype}' objects for operation' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' -- In file "'${JSONRepoFile}'"' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQuery result domgmtcliquery [ '${domgmtcliquery}' ], procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DetermineIfDoMgmtCLIQueryComplexObject
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# DetermineIfDoMgmtCLIQueryComplexObject executes check if executing export using mgmt_cli command.
#

DetermineIfDoMgmtCLIQueryComplexObject () {
    #
    # Expected configured key input values
    #
    # ${script_use_json_repo}
    # ${UseJSONRepo}
    # ${objectstoshowcomplexobject}
    # ${APICLIcomplexobjectstype}
    # ${JSONRepoComplexObjectsTotal}
    # ${JSONRepoComplexObjectFile}
    #
    # Output values:
    #
    # ${domgmtcliquerycomplexobject}
    # ${errorreturn}
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    export domgmtcliquerycomplexobject=false
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryComplexObject procedure Starting...' | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'objectstoshowcomplexobject' "${objectstoshowcomplexobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoComplexObjectsTotal' "${JSONRepoComplexObjectsTotal}" >> ${logfilepath}
    
    if ! ${script_use_json_repo} ; then
        # Script use of JSON Repository is denied
        echo `${dtzs}`${dtzsep} 'Script use of Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" is DENIED by script!' | tee -a -i ${logfilepath}
        export domgmtcliquerycomplexobject=true
    elif ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" for operation.' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            CompareObjectsTotalEqual=false
        elif ${OnlySystemObjects} ; then
            CompareObjectsTotalEqual=false
        else
            CompareObjectsTotalEqual=true
        fi
        
        if ${CompareObjectsTotalEqual} ; then
            if [[ ${objectstoshowcomplexobject} -eq ${JSONRepoComplexObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                export domgmtcliquerycomplexobject=false
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerycomplexobject=true
                echo `${dtzs}`${dtzsep} 'Object count of '${APICLIcomplexobjectstype}' objects [ '${objectstoshowcomplexobject}' ] does not match count of [ '${JSONRepoComplexObjectsTotal}' ] in Complex Object JSON Repository file!' | tee -a -i ${logfilepath}
            fi
        else
            if [[ ${JSONRepoComplexObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if [[ ${objectstoshowcomplexobject} -eq ${JSONRepoComplexObjectsTotal} ]] ; then
                    # JSON Repository has the same number of objects as the management database
                    export domgmtcliquerycomplexobject=false
                else
                    # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                    export domgmtcliquerycomplexobject=true
                    echo `${dtzs}`${dtzsep} 'Object count of '${APICLIcomplexobjectstype}' objects [ '${objectstoshowcomplexobject}' ] does not match count of [ '${JSONRepoComplexObjectsTotal}' ] in Complex Object JSON Repository file!' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerycomplexobject=true
            fi
        fi
    else
        # Use of JSON Repository Disabled
        echo `${dtzs}`${dtzsep} 'Script use of Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" is DENIED by operation!' | tee -a -i ${logfilepath}
        export domgmtcliquerycomplexobject=true
    fi
    
    if ${domgmtcliquerycomplexobject} ; then
        echo `${dtzs}`${dtzsep} 'NOT Using Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" for operation, shift to mgmt_cli query.' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Using JSON Repository for [ '${objectstoshowcomplexobject}' : '${JSONRepoComplexObjectsTotal}' ] of '${APICLIcomplexobjectstype}' objects for operation' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' -- In file "'${JSONRepoComplexObjectFile}'"' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryComplexObject result domgmtcliquerycomplexobject [ '${domgmtcliquerycomplexobject}' ], procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DetermineIfDoMgmtCLIQueryGenericObject
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# DetermineIfDoMgmtCLIQueryGenericObject executes check if executing export using mgmt_cli command.
#

DetermineIfDoMgmtCLIQueryGenericObject () {
    #
    # Expected configured key input values
    #
    # ${script_use_json_repo}
    # ${UseJSONRepo}
    # ${objectstoshowgenericobject}
    # ${APIGenObjobjectstype}
    # ${JSONRepoAPIGenObjectsTotal}
    # ${JSONRepoAPIGenObjectFile}
    #
    # Output values:
    #
    # ${domgmtcliquerygenericobject}
    # ${errorreturn}
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    export domgmtcliquerygenericobject=false
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryGenericObject procedure Starting...' | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'objectstoshowgenericobject' "${objectstoshowgenericobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenObjectsTotal' "${JSONRepoAPIGenObjectsTotal}" >> ${logfilepath}
    
    if ! ${script_use_json_repo} ; then
        # Script use of JSON Repository is denied
        echo `${dtzs}`${dtzsep} 'Script use of Generic Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" is DENIED by script!' | tee -a -i ${logfilepath}
        export domgmtcliquerygenericobject=true
    elif ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of Generic Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" for operation.' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            CompareObjectsTotalEqual=false
        elif ${OnlySystemObjects} ; then
            CompareObjectsTotalEqual=false
        else
            CompareObjectsTotalEqual=true
        fi
        
        if ${CompareObjectsTotalEqual} ; then
            if [[ ${objectstoshowgenericobject} -eq ${JSONRepoAPIGenObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                export domgmtcliquerygenericobject=false
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerygenericobject=true
                echo `${dtzs}`${dtzsep} 'Object count of '${APIGenObjobjectstype}' objects [ '${objectstoshowgenericobject}' ] does not match count of [ '${JSONRepoAPIGenObjectsTotal}' ] in Generic Object JSON Repository file!' | tee -a -i ${logfilepath}
            fi
        else
            if [[ ${JSONRepoAPIGenObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if [[ ${objectstoshowgenericobject} -eq ${JSONRepoAPIGenObjectsTotal} ]] ; then
                    # JSON Repository has the same number of objects as the management database
                    export domgmtcliquerygenericobject=false
                else
                    # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                    export domgmtcliquerygenericobject=true
                    echo `${dtzs}`${dtzsep} 'Object count of '${APIGenObjobjectstype}' objects [ '${objectstoshowgenericobject}' ] does not match count of [ '${JSONRepoAPIGenObjectsTotal}' ] in Generic Object JSON Repository file!' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerygenericobject=true
            fi
        fi
    else
        # Use of JSON Repository Disabled
        echo `${dtzs}`${dtzsep} 'Script use of Generic Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" is DENIED by operation!' | tee -a -i ${logfilepath}
        export domgmtcliquerygenericobject=true
    fi
    
    if ${domgmtcliquerygenericobject} ; then
        echo `${dtzs}`${dtzsep} 'NOT Using Generic Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" for operation, shift to mgmt_cli query.' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Using JSON Repository for [ '${objectstoshowgenericobject}' : '${JSONRepoAPIGenObjectsTotal}' ] of '${APIGenObjobjectstype}' objects for operation' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' -- In file "'${JSONRepoAPIGenObjectFile}'"' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryGenericObject result domgmtcliquerygenericobject [ '${domgmtcliquerygenericobject}' ], procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DetermineIfDoMgmtCLIQueryGenericComplexObject
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-07:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# DetermineIfDoMgmtCLIQueryGenericComplexObject executes check if executing export using mgmt_cli command.
#

DetermineIfDoMgmtCLIQueryGenericComplexObject () {
    #
    # Expected configured key input values
    #
    # ${script_use_json_repo}
    # ${UseJSONRepo}
    # ${objectstoshowgenericcomplexobject}
    # ${APIGenObjcomplexobjectstype}
    # ${JSONRepoAPIGenComplexObjectsTotal}
    # ${JSONRepoAPIGenComplexObjectFile}
    #
    # Output values:
    #
    # ${domgmtcliquerygenericcomplexobject}
    # ${errorreturn}
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    export domgmtcliquerygenericcomplexobject=false
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryGenericComplexObject procedure Starting...' | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'objectstoshowgenericcomplexobject' "${objectstoshowgenericcomplexobject}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'JSONRepoAPIGenComplexObjectsTotal' "${JSONRepoAPIGenComplexObjectsTotal}" >> ${logfilepath}
    
    if ! ${script_use_json_repo} ; then
        # Script use of JSON Repository is denied
        echo `${dtzs}`${dtzsep} 'Script use of Generic Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" is DENIED by script!' | tee -a -i ${logfilepath}
        export domgmtcliquerygenericcomplexobject=true
    elif ${UseJSONRepo} ; then
        # Use of JSON Repository Enabled
        echo `${dtzs}`${dtzsep} 'Check use of Generic Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" for operation.' | tee -a -i ${logfilepath}
        
        if ${NoSystemObjects} ; then
            CompareObjectsTotalEqual=false
        elif ${OnlySystemObjects} ; then
            CompareObjectsTotalEqual=false
        else
            CompareObjectsTotalEqual=true
        fi
        
        if ${CompareObjectsTotalEqual} ; then
            if [[ ${objectstoshowgenericcomplexobject} -eq ${JSONRepoAPIGenComplexObjectsTotal} ]] ; then
                # JSON Repository has the same number of objects as the management database
                export domgmtcliquerygenericcomplexobject=false
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerygenericcomplexobject=true
                echo `${dtzs}`${dtzsep} 'Object count of '${APIGenObjcomplexobjectstype}' objects [ '${objectstoshowgenericcomplexobject}' ] does not match count of [ '${JSONRepoAPIGenComplexObjectsTotal}' ] in Generic Object JSON Repository file!' | tee -a -i ${logfilepath}
            fi
        else
            if [[ ${JSONRepoAPIGenComplexObjectsTotal} -gt 0 ]] ; then
                # JSON Repository has content
                if [[ ${objectstoshowgenericcomplexobject} -eq ${JSONRepoAPIGenComplexObjectsTotal} ]] ; then
                    # JSON Repository has the same number of objects as the management database
                    export domgmtcliquerygenericcomplexobject=false
                else
                    # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                    export domgmtcliquerygenericcomplexobject=true
                    echo `${dtzs}`${dtzsep} 'Object count of '${APIGenObjcomplexobjectstype}' objects [ '${objectstoshowgenericcomplexobject}' ] does not match count of [ '${JSONRepoAPIGenComplexObjectsTotal}' ] in Generic Object JSON Repository file!' | tee -a -i ${logfilepath}
                fi
            else
                # JSON Repository has a differnt number of objects than the management database, so something definitely changed and we probably can't use the repository
                export domgmtcliquerygenericcomplexobject=true
            fi
        fi
    else
        # Use of JSON Repository Disabled
        echo `${dtzs}`${dtzsep} 'Script use of Generic Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" is DENIED by operation!' | tee -a -i ${logfilepath}
        export domgmtcliquerygenericcomplexobject=true
    fi
    
    if ${domgmtcliquerygenericcomplexobject} ; then
        echo `${dtzs}`${dtzsep} 'NOT Using Generic Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" for operation, shift to mgmt_cli query.' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Using JSON Repository for [ '${objectstoshowgenericcomplexobject}' : '${JSONRepoAPIGenComplexObjectsTotal}' ] of '${APIGenObjcomplexobjectstype}' objects for operation' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} ' -- In file "'${JSONRepoAPIGenComplexObjectFile}'"' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'DetermineIfDoMgmtCLIQueryGenericComplexObject result domgmtcliquerygenericcomplexobject [ '${domgmtcliquerygenericcomplexobject}' ], procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-07:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckJSONRepoFileObjectTotal
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# CheckJSONRepoFileObjectTotal executes a check of the total number of objects for that type using standard object JSON Repository File.
#

CheckJSONRepoFileObjectTotal () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileObjectTotal procedure Starting...' >> ${logfilepath}
    
    if [ -r ${JSONRepoFile} ] ; then
        # JSON Repository File for the target object exists, lets check for the number objects
        
        export JSONRepoObjectsTotal=0
        
        if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
            # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
            export checkJSONRepoTotal=1
        else
            export checkJSONRepoTotal=`cat ${JSONRepoFile} | ${JQ} ".total"`
        fi
        
        export JSONRepoObjectsTotal=${checkJSONRepoTotal}
        echo `${dtzs}`${dtzsep} 'JSONRepoObjectsTotal = [ '${JSONRepoObjectsTotal}' ]' >> ${logfilepath}
        
        if [ x"${JSONRepoObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            export JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoObjectsTotal}' ] (so zero)' | tee -a -i ${logfilepath}
            export JSONRepoObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # JSON Repository File for the target object DOES NOT exists
        echo `${dtzs}`${dtzsep} 'JSON Repository file "'${JSONRepoFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        export JSONRepoObjectsTotal=0
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepoObjectsTotal = [ '${JSONRepoObjectsTotal}' ]' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileObjectTotal procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckJSONRepoFileComplexObjectTotal
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# CheckJSONRepoFileComplexObjectTotal executes a check of the total number of objects for that type using Complex Object JSON Repository file.
#

CheckJSONRepoFileComplexObjectTotal () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileComplexObjectTotal procedure Starting...' >> ${logfilepath}
    
    if [ -r ${JSONRepoComplexObjectFile} ] ; then
        # Complex Object JSON Repository file for the target object exists, lets check for the number objects
        
        export JSONRepoComplexObjectsTotal=0
        
        if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
            # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
            export checkJSONRepoComplexObjectsTotal=1
        else
            export checkJSONRepoComplexObjectsTotal=`cat ${JSONRepoComplexObjectFile} | ${JQ} ".total"`
        fi
        
        export JSONRepoComplexObjectsTotal=${checkJSONRepoComplexObjectsTotal}
        echo `${dtzs}`${dtzsep} 'JSONRepoComplexObjectsTotal = [ '${JSONRepoComplexObjectsTotal}' ]' >> ${logfilepath}
        
        if [ x"${JSONRepoComplexObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            export JSONRepoComplexObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoComplexObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoComplexObjectsTotal}' ] (so zero)' | tee -a -i ${logfilepath}
            export JSONRepoComplexObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoComplexObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # Complex Object JSON Repository file for the target object DOES NOT exists
        export JSONRepoComplexObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoComplexObjectFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepoComplexObjectsTotal = [ '${JSONRepoComplexObjectsTotal}' ]' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileComplexObjectTotal procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckJSONRepoFileAPIGenericObjectTotal
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# CheckJSONRepoFileAPIGenericObjectTotal executes a check of the total number of objects for that type using API Generic Object JSON Repository file.
#

CheckJSONRepoFileAPIGenericObjectTotal () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileAPIGenericObjectTotal procedure Starting...' >> ${logfilepath}
    
    if [ -r ${JSONRepoAPIGenObjectFile} ] ; then
        # Complex Object JSON Repository file for the target object exists, lets check for the number objects
        
        export JSONRepoAPIGenObjectsTotal=0
        
        if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
            # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
            export checkJSONRepoAPIGenObjectsTotal=1
        else
            export checkJSONRepoAPIGenObjectsTotal=`cat ${JSONRepoAPIGenObjectFile} | ${JQ} ".total"`
        fi
        
        export JSONRepoAPIGenObjectsTotal=${checkJSONRepoAPIGenObjectsTotal}
        echo `${dtzs}`${dtzsep} 'JSONRepoAPIGenObjectsTotal = [ '${JSONRepoAPIGenObjectsTotal}' ]' >> ${logfilepath}
        
        if [ x"${JSONRepoAPIGenObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            export JSONRepoAPIGenObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoAPIGenObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoAPIGenObjectsTotal}' ] (so zero)' | tee -a -i ${logfilepath}
            export JSONRepoAPIGenObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoAPIGenObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # Complex Object JSON Repository file for the target object DOES NOT exists
        export JSONRepoAPIGenObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenObjectFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepoAPIGenObjectsTotal = [ '${JSONRepoAPIGenObjectsTotal}' ]' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileAPIGenericObjectTotal procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckJSONRepoFileAPIGenericComplexObjectTotal
# -------------------------------------------------------------------------------------------------


# MODIFIED 2023-03-06:01 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# CheckJSONRepoFileAPIGenericComplexObjectTotal executes a check of the total number of objects for that type using API Generic Complex Object JSON Repository file.
#

CheckJSONRepoFileAPIGenericComplexObjectTotal () {
    #
    
    export errorreturn=0
    
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2023-03-06:01 -
    
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileAPIGenericComplexObjectTotal procedure Starting...' >> ${logfilepath}
    
    if [ -r ${JSONRepoAPIGenComplexObjectFile} ] ; then
        # Complex Object JSON Repository file for the target object exists, lets check for the number objects
        
        export JSONRepoAPIGenComplexObjectsTotal=0
        
        if [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
            # Handle objects that are singularities, like the special objects - api-settings, policy-settings, global-properties, etc.
            export checkJSONRepoAPIGenComplexObjectsTotal=1
        else
            export checkJSONRepoAPIGenComplexObjectsTotal=`cat ${JSONRepoAPIGenComplexObjectFile} | ${JQ} ".total"`
        fi
        
        export JSONRepoAPIGenComplexObjectsTotal=${checkJSONRepoAPIGenComplexObjectsTotal}
        echo `${dtzs}`${dtzsep} 'JSONRepoAPIGenComplexObjectsTotal = [ '${JSONRepoAPIGenComplexObjectsTotal}' ]' >> ${logfilepath}
        
        if [ x"${JSONRepoAPIGenComplexObjectsTotal}" == x"" ] ; then
            # There are null objects, so skip
            export JSONRepoAPIGenComplexObjectsTotal=0
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" IS NOT readable, value returned was NULL' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
        elif [[ ${JSONRepoAPIGenComplexObjectsTotal} -lt 1 ]] ; then
            # no objects of this type
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" IS NOT readable, value returned was < 1 [ '${JSONRepoAPIGenComplexObjectsTotal}' ] (so zero)' | tee -a -i ${logfilepath}
            export JSONRepoAPIGenComplexObjectsTotal=0
            echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" exists,' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  and is readable, so usable for getting the total number of objects from it.' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  total of objects is [ '${JSONRepoAPIGenComplexObjectsTotal}' ]' | tee -a -i ${logfilepath}
        fi
    else
        # Complex Object JSON Repository file for the target object DOES NOT exists
        export JSONRepoAPIGenComplexObjectsTotal=0
        echo `${dtzs}`${dtzsep} 'Complex Object JSON Repository file "'${JSONRepoAPIGenComplexObjectFile}'" IS NOT readable, fail -r check' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  so setting total of objects to Zero [ '${JSONRepoAPIGenComplexObjectsTotal}' ].' | tee -a -i ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'JSONRepoAPIGenComplexObjectsTotal = [ '${JSONRepoAPIGenComplexObjectsTotal}' ]' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'CheckJSONRepoFileAPIGenericComplexObjectTotal procedure errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-06:01


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
            echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli JQ Query! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli JQ Query! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli JQ Query! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard : Problem during mgmt_cli JQ Query! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
    
    CommonJSONRepositoryUpdateHander
    
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
    
    echo `${dtzs}`${dtzsep} 'ExportObjectToJSONStandard procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
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

# MODIFIED 2023-03-04:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjecttype} details is exported to a json at the ${APICLIdetaillvl}.

ExportRAWObjectToJSON () {
    #
    # Export Objects to raw JSON
    #
    
    export Workingfilename=
    export APICLIfileexport=
    export APICLIJSONfilelast=
    
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
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'Start Processing '${APICLIobjecttype}':' | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    DumpObjectDefinitionData
    
    # -------------------------------------------------------------------------------------------------
    
    export objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    export objectstoshow=${objectstotal}
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    if [ ${objectstoshow} = null ] ; then
        echo `${dtzs}`${dtzsep} 'Found NO '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    elif [ ${objectstoshow} -le 0 ] ; then
        echo `${dtzs}`${dtzsep} 'Found [ '${objectstoshow}' ] '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    else
        
        echo `${dtzs}`${dtzsep} 'Found [ '${objectstoshow}' ] '${APICLIobjecttype}' objects.  Processing...' | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
        errorreturn=0
        
        SetupExportObjectsToJSONandRepository
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Problem found in procedure SetupExportObjectsToJSONandRepository! error returned = '${errorreturn} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
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
        
        # MODIFIED 2023-03-03:02 -
        
        if [ x"${APIobjectjsonrepofileobject}" != x"" ] ; then
            export APICLIfilename=${APIobjectjsonrepofileobject}
        else
            export APICLIfilename=${APICLIobjectstype}
        fi
        if [ x"${APICLIexportnameaddon}" != x"" ] ; then
            export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
        fi
        
        export Workingfilename=${APICLIfilename}
        export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
        export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}'_last'${APICLIJSONfileexportpost}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'Workingfilename' "${Workingfilename}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIfileexport' "${APICLIfileexport}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIJSONfilelast' "${APICLIJSONfilelast}" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        
        # This object does not have limits to check and probably does not have more than one object entry
        
        ExportObjectToJSONStandard
        
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-03-04:01


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
        
        echo `${dtzs}`${dtzsep} 'CheckAPIVersionAndExecuteOperation call to ExportObjectsToCSVviaJQ procedure returned :  !{ '${errorreturn}' }!' >> ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in CheckAPIVersionAndExecuteOperation procedure, but continueing' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #return ${errorreturn}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'CheckAPIVersionAndExecuteOperation procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
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


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Handle Simple Objects
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - simple objects - '${scriptactiondescriptor}' starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# MODIFIED 2022-09-15 - Harmonization Rework


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  Standard Simple objects
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype='<object_type_singular>'
#export APICLIobjectstype='<object_type_plural>'
#export APIobjectminversion='<object_type_api_version>'
#export APIobjectexportisCPI=false

#export APIobjectspecifickey=

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#export APIobjectjsonrepofileobject=${APICLIobjectstype}
#export APICLICSVobjecttype=${APICLIobjectstype}

#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

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

#CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Manage & Settings Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Manage & Settings Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Network Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Network Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Servers Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Servers Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Gateways & Clusters Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Gateways & Clusters' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Service & Applications Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Service & Applications' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Users Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Users' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Updatable Object Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Updatable Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Script Type Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script Type Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  SmartTasks
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=smart-task
export APICLIobjectstype=smart-tasks
export APIobjectminversion=1.6
export APIobjectexportisCPI=false

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

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

CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  Repository Scripts
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=repository-script
export APICLIobjectstype=repository-scripts
export APIobjectminversion=1.9
export APIobjectexportisCPI=false

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

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

CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Compliance Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Compliance Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Data Center Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Data Center Objectsö' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Azure Active Directory Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Azure Active Directory Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# VPN Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'VPN Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# HTTPS Inspection Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'HTTPS Inspection Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Multi-Domain Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Multi-Domain Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Provisioning LSM Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Provisioining LSM Objects' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '*------------------------------------------------------------------------------------------------*' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# No more Simple Objects
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


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


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Handle Special Objects and Properties
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


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
        echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
    
    CommonJSONRepositoryUpdateHander
    
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
    
    echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToJSONWithoutLimitsAndDetailLevel procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
                echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
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
    
    CommonJSONRepositoryUpdateHander
    
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
    
    echo `${dtzs}`${dtzsep} 'ExportSpecialObjectToJSONStandard procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
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

# MODIFIED 2023-03-04:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjecttype} details is exported to a json at the ${APICLIdetaillvl}.

SpecialExportRAWObjectToJSON () {
    #
    # Export Objects to raw JSON
    #
    
    export Workingfilename=
    export APICLIfileexport=
    export APICLIJSONfilelast=
    
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
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'Start Processing '${APICLIobjecttype}':' | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    DumpObjectDefinitionData
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    SetupExportObjectsToJSONandRepository
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo `${dtzs}`${dtzsep} 'Problem found in procedure SetupExportObjectsToJSONandRepository! error returned = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
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
    
    # MODIFIED 2023-03-03:02 -
    
    if [ x"${APIobjectjsonrepofileobject}" != x"" ] ; then
        export APICLIfilename=${APIobjectjsonrepofileobject}
    else
        export APICLIfilename=${APICLIobjectstype}
    fi
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
    fi
    
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
    
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'Workingfilename' "${Workingfilename}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIfileexport' "${APICLIfileexport}" >> ${logfilepath}
    printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIJSONfilelast' "${APICLIJSONfilelast}" >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    
    errorreturn=0
    
    if [ ${objectstoshow} = null ] ; then
        # This object was queried for number of elements and failed to find any, so skipping
        
        echo `${dtzs}`${dtzsep} 'Found NO '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
        
    elif [ ${objectstoshow} -le 0 ] ; then
        # This object was queried for number of elements and returned zero (0) or lesss objects, so skipping
        
        echo `${dtzs}`${dtzsep} 'Found [ '${objectstoshow}' ] '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
        
    elif [ ${APIobjectrecommendedlimit} -eq 0 ] ; then
        # This object does not have limits to check and probably does not have more than one object entry
        
        echo `${dtzs}`${dtzsep} 'Found [ '${objectstoshow}' ] '${APICLIobjecttype}' objects.  Processing...' | tee -a -i ${logfilepath}
        
        ExportSpecialObjectToJSONWithoutLimitsAndDetailLevel
        
    else
        # This object has limits to check and probably has more than one object entry
        
        echo `${dtzs}`${dtzsep} 'Found [ '${objectstoshow}' ] '${APICLIobjecttype}' objects.  Processing...' | tee -a -i ${logfilepath}
        
        ExportSpecialObjectToJSONStandard
        
    fi
    
    echo `${dtzs}`${dtzsep} 'SpecialExportRAWObjectToJSON procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-03-04:01

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
        
        echo `${dtzs}`${dtzsep} 'SpecialObjectsCheckAPIVersionAndExecuteOperation call to SpecialExportRAWObjectToJSON procedure returned :  !{ '${errorreturn}' }!' >> ${logfilepath}
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure' | tee -a -i ${logfilepath}
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
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SpecialObjectsCheckAPIVersionAndExecuteOperation procedure, but continueing' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            #return ${errorreturn}
        fi
    fi
    echo `${dtzs}`${dtzsep} 'SpecialObjectsCheckAPIVersionAndExecuteOperation procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
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


# +-------------------------------------------------------------------------------------------------
# | Special Object : Special Singular Objects - export object
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype='<object_type_singular>'
#export APICLIobjectstype='<object_type_plural>'
#export APIobjectminversion='<object_type_api_version>'
#export APIobjectexportisCPI=false|true
#export APIobjectjsonrepofileobject=${APICLIobjectstype}
#export APICLICSVobjecttype=${APICLIobjectstype}
#export APIobjectrecommendedlimit=0
#export APIobjectrecommendedlimitMDSM=0

#export APIobjectdoexport=true|false
#export APIobjectdoexportJSON=true|false
#export APIobjectdoexportCSV=true|false
#export APIobjectdoimport=true|false
#export APIobjectdorename=true|false
#export APIobjectdoupdate=true|false
#export APIobjectdodelete=true|false

#export APIobjectusesdetailslevel=true|false
#export APIobjectcanignorewarning=true|false
#export APIobjectcanignoreerror=true|false
#export APIobjectcansetifexists=false|true
#export APIobjectderefgrpmem=false|true
#export APIobjecttypehasname=true|false
#export APIobjecttypehasuid=true|false
#export APIobjecttypehasdomain=true|false
#export APIobjecttypehastags=true|false
#export APIobjecttypehasmeta=true|false
#export APIobjecttypeimportname=true|false

#export APIobjectCSVFileHeaderAbsoluteBase=false|true
#export APIobjectCSVJQparmsAbsoluteBase=false|true

#export APIobjectCSVexportWIP=false|true

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=


##SpecialObjectsCheckAPIVersionAndExecuteOperation

#case "${domaintarget}" in
    #'System Data' )
        ## We don't execute this action for the domain "System Data"
        #echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} 'For Objects Type : '${APICLIobjectstype}'  This will NOT work with Domain ["'${domaintarget}'"]' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
        #echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
        #;;
    ## Anything unknown is recorded for later
    #* )
        ## All other domains and no domain should work for this
        #case "${TypeOfExport}" in
            ## a "Standard" export operation
            #'standard' )
                #SpecialObjectsCheckAPIVersionAndExecuteOperation
                #;;
            ## a "name-only" export operation
            ##'name-only' )
            ## a "name-and-uid" export operation
            ##'name-and-uid' )
            ## a "uid-only" export operation
            ##'uid-only' )
            ## a "rename-to-new-nam" export operation
            ##'rename-to-new-name' )
            ## Anything unknown is handled as "standard"
            #* )
                #echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                #echo `${dtzs}`${dtzsep} 'Objects Type : '${APICLIobjectstype}'  DOES NOT support an Export of type ["'${TypeOfExport}'"]' | tee -a -i ${logfilepath}
                #echo `${dtzs}`${dtzsep} '!! skipping object '${APICLIobjectstype}'!!' | tee -a -i ${logfilepath}
                #echo `${dtzs}`${dtzsep} '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-' | tee -a -i ${logfilepath}
                #;;
        #esac
        #;;
#esac


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# No more Special Objects and Properties
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


# MODIFIED 2022-07-07 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Special objects and properties - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-07-07


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Simple Object via Generic-Objects Handler
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


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

# MODIFIED 2023-02-24:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# REDUNDANT - Replaced with CommonJSONRepositoryUpdateHander
#
#HandleJSONRepositoryUpdateGenericObjects () {
    #return ${errorreturn}
#}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-24:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Prepare operations to Slurp JSON files - PrepareToSlurpJSONFilesGenericObjects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-24:02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    # MODIFIED 2023-02-24:01 -
    
    export Slurpstarfilename=${APIGenObjobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
    fi
    
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
    
    if ${DoFileSlurp} ; then
        
        export Slurpstarfilename=${Slurpstarfilename}'_*_of_'${objectstotalformatted}
        export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
        
        echo `${dtzs}`${dtzsep} '  Multiple JSON files created, need to SLURP together the file!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp these files     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        
        # Slurp the collection of JSON files into a single JSON already
        
        # -------------------------------------------------------------------------------------------------
        
        CommonSlurpJSONFilesIntoSingleFile
        
        # -------------------------------------------------------------------------------------------------
        
    else
        # File is single JSON already
        # Handle placement of final object JSON file into standing current object repository next
        if ${NoSystemObjects} ; then
            
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_NSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        elif ${OnlySystemObjects} ; then
            
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_OSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        else
            
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        fi
        
        # Slurp the single JSON files into a single JSON already
        
        if [ -s ${APICLIfileexport} ] ; then
            # exported json file is not zero length, so process for slurp
            # copy the broken json file as the slurpstar file to the slurp work area
            cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
            
            echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
            
            # -------------------------------------------------------------------------------------------------
            
            CommonSlurpJSONFilesIntoSingleFile
            
            # -------------------------------------------------------------------------------------------------
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
        
    fi
    
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Procedure PrepareToSlurpJSONFilesGenericObjects completed!  errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-24:02

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - ExportObjectViaGenericObjectsToJSONStandard
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Export Objects with utilization of limits and details-level as a standard to JSON
#

ExportObjectViaGenericObjectsToJSONStandard () {
    #
    # Export Objects to raw JSON
    #
    # Expected configured key input values
    #
    # ${objectstoshow}
    #
    # Output values:
    #
    # ${errorreturn}
    #
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APIGenObjobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    objectstotalformatted=`printf "%05d" ${objectstoshow}`
    WorkAPIObjectLimitformatted=`printf "%05d" ${WorkAPIObjectLimit}`
    
    if [ ${objectstoshow} -gt ${WorkAPIObjectLimit} ] ; then
        export DoFileSlurp=true
        echo `${dtzs}`${dtzsep} '  JSON File Slurp required... [ '${objectstotalformatted}' > '${WorkAPIObjectLimitformatted}' ]' | tee -a -i ${logfilepath}
    else
        export DoFileSlurp=false
        echo `${dtzs}`${dtzsep} '  JSON File Slurp NOT required... [ '${objectstotalformatted}' <= '${WorkAPIObjectLimitformatted}' ]' | tee -a -i ${logfilepath}
    fi
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        
        nextoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        
        currentoffsetformatted=`printf "%05d" ${currentoffset}`
        nextoffsetformatted=`printf "%05d" ${nextoffset}`
        
        if [ ${objectstoshow} -gt ${WorkAPIObjectLimit} ] ; then
            # Export file for the next ${WorkAPIObjectLimit} objects
            export APICLIfilename=${APIGenObjobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
            fi
            
            export Workingfilename=${APICLIfilename}'_'${currentoffsetformatted}'-'${nextoffsetformatted}'_of_'${objectstotalformatted}
            
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
            echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard : Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLIJSONfilelast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLIJSONfilelast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # MODIFIED 2023-03-04:01
        #
        
        if [ x"${objectqueryselector}" != x"" ] ; then
            echo `${dtzs}`${dtzsep} '      Selected objects based on object type criteria, objectqueryselector = '${objectqueryselector} | tee -a -i ${logfilepath}
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
            errorreturn=$?
        else
            echo `${dtzs}`${dtzsep} '      All objects, including System Objects' | tee -a -i ${logfilepath}
            cat ${APICLIJSONfilelast} | ${JQ} '.objects[]' > ${APICLIfileexport}
            errorreturn=$?
        fi
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard : Problem during JQ Query of file "'${APICLIJSONfilelast}'"! error return = !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents (last 10 lines) with potential error from '${APICLIfileexport}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            tail ${APICLIfileexport} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        if ${DoFileSlurp} ; then
            if [ -s ${APICLIfileexport} ] ; then
                # exported json file is not zero length, so process for slurp
                echo `${dtzs}`${dtzsep} '      Dump to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                cp -fv ${APICLIfileexport} ${Slurpworkfileexport} >> ${logfilepath} 2>&1
            else
                # exported json file is zero length, so do not process file for slurp
                echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} >> ${logfilepath}
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
    
    CommonJSONRepositoryUpdateHander
    
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
    
    echo `${dtzs}`${dtzsep} 'ExportObjectViaGenericObjectsToJSONStandard procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportRAWObjectViaGenericObjectsToJSON
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-04:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APIGenObjobjecttype} details is exported to a json at the ${APICLIdetaillvl}.

ExportRAWObjectViaGenericObjectsToJSON () {
    #
    # Export Objects to raw JSON
    #
    
    export Workingfilename=
    export APICLIfileexport=
    export APICLIJSONfilelast=
    
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
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} 'Start Processing '${APIGenObjobjecttype}':' | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    DumpObjectDefinitionData
    
    # -------------------------------------------------------------------------------------------------
    
    objectstotal=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    export objectstoshow=${objectstotal}
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    if [ ${objectstoshow} = null ] ; then
        echo `${dtzs}`${dtzsep} 'Found NO '${APIGenObjobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    elif [ ${objectstoshow} -le 0 ] ; then
        echo `${dtzs}`${dtzsep} 'Found [ '${objectstoshow}' ] '${APIGenObjobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Found [ '${objectstoshow}' ] '${APIGenObjobjecttype}' objects.  Processing...' | tee -a -i ${logfilepath}
        
        # -------------------------------------------------------------------------------------------------
        
        errorreturn=0
        
        SetupExportObjectsToJSONandRepository
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'Problem found in procedure SetupExportObjectsToJSONandRepository! error returned = '${errorreturn} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
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
        
        # MODIFIED 2023-03-04:01 -
        
        if [ x"${APIGenObjjsonrepofileobject}" != x"" ] ; then
            export APICLIfilename=${APIGenObjjsonrepofileobject}
        else
            export APICLIfilename=${APIGenObjobjectstype}
        fi
        if [ x"${APICLIexportnameaddon}" != x"" ] ; then
            export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
        fi
        
        export Workingfilename=${APICLIfilename}
        export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
        export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}'_last'${APICLIJSONfileexportpost}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'Workingfilename' "${Workingfilename}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIfileexport' "${APICLIfileexport}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIJSONfilelast' "${APICLIJSONfilelast}" >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        
        errorreturn=0
        
        ExportObjectViaGenericObjectsToJSONStandard
        
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportRAWObjectViaGenericObjectsToJSON procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-03-04:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SimpleObjectsJSONViaGenericObjectsHandler proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SimpleObjectsJSONViaGenericObjectsHandler () {
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
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in SimpleObjectsJSONViaGenericObjectsHandler procedure' | tee -a -i ${logfilepath}
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-02:01


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


# +-------------------------------------------------------------------------------------------------
# | Specific Simple OBJECT : application-sites
# | Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# | Reference Details and initial object
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APICLICSVobjecttype=${APIGenObjcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

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

SimpleObjectsJSONViaGenericObjectsHandler


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# No more Simple Object via Generic-Objects Handler objects
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


# MODIFIED 2022-12-14:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Simple Object via Generic-Objects Handler - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-12-14:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Handle Complex Objects
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - complex objects - '${scriptactiondescriptor}' Starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Common Complex Object Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2017-11-09 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Common Complex Object Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Generic Complex Objects Type Handler
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Generic Complex Objects Type Handler' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2021-01-18 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Specific Complex Objects :  These require extra plumbing
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex Objects :  These require extra plumbing' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Specific Complex OBJECT : host interfaces
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex OBJECT : host interfaces' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Specific Complex OBJECT : host interfaces Handling Procedures
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:01 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Specific Complex OBJECT : host interfaces Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Specific Complex OBJECT : Advanced Handler - Object Specific Key arrays
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex OBJECT : Advanced Handler - Object Specific Keys with Value arrays' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Specific Complex OBJECT - Object Specific Keys with Value arrays Handling Procedures
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-24:01 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Specific Complex OBJECT - Object Specific Keys with Value arrays Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------



# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : application-sites
# |  - Reference Details, APIobjectdoX set to "false" to disable
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=application-sites
export APICLIcomplexobjectstype=application-sites
export APIobjectminversion=1.1
export APIobjectexportisCPI=true

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
export APICLICSVobjecttype=${APICLIobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=false
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=false
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


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : application-sites - url-list
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=application-site-element-url-list
export APICLIcomplexobjectstype=application-sites-elements-url-lists
export APIobjectminversion=1.1
export APIobjectexportisCPI=true

export APIobjectspecifickey='url-list'

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
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

#GetObjectSpecificKeyArrayValues


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : application-sites - application-signature
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype=application-site
#export APICLIobjectstype=application-sites
#export APICLIcomplexobjecttype=application-site-element-application-signature
#export APICLIcomplexobjectstype=application-sites-elements-application-signatures
#export APIobjectminversion=1.1
#export APIobjectexportisCPI=true

#export APIobjectspecifickey='application-signature'

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#export APIobjectjsonrepofileobject=${APICLIobjectstype}
#export APICLICSVobjecttype=${APICLIcomplexobjectstype}

#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

#export APIobjectdoexport=true
#export APIobjectdoexportJSON=false
#export APIobjectdoexportCSV=true
#export APIobjectdoimport=true
#export APIobjectdorename=false
#export APIobjectdoupdate=false
#export APIobjectdodelete=false

#export APIobjectusesdetailslevel=true
#export APIobjectcanignorewarning=true
#export APIobjectcanignoreerror=true
#export APIobjectcansetifexists=false
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

#GetObjectSpecificKeyArrayValues


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : application-sites - additional-categories
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=application-site-element-additional-category
export APICLIcomplexobjectstype=application-sites-elements-additional-categories
export APIobjectminversion=1.1
export APIobjectexportisCPI=true

export APIobjectspecifickey='additional-categories'

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
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

#GetObjectSpecificKeyArrayValues


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Specific Complex OBJECT : users authentications
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Specific Complex OBJECT : users authentications' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}



# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Specific Complex OBJECT : users authentications Handling Procedures
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-25:01 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Specific Complex OBJECT : users authentications Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!
# !------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more Specific Complex Objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


# MODIFIED 2021-02-24 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Specific Complex Objects - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-24


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# Complex Object via Generic-Objects Handlers
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Complex Objects via Generic-Objects Array Handler' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Complex Objects via Generic-Objects Array Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2023-02-23 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational repeated proceedure - HandleJSONRepositoryUpdateComplexObjectsViaGenericObjectsArray
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-24:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# REDUNDANT - Replaced with CommonJSONRepositoryUpdateHander
#
#HandleJSONRepositoryUpdateComplexObjectsViaGenericObjectsArray () {
    #return ${errorreturn}
#}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-24:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Prepare operations to Slurp JSON files - PrepareToSlurpJSONFilesComplexObjectsFromGenericObjectsArray
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-24:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Prepare operations to Slurp JSON files and call common Slurp handler.
#
PrepareToSlurpJSONFilesComplexObjectsFromGenericObjectsArray () {
    #
    # Prepare operations to Slurp JSON files and call common Slurp handler
    #
    
    errorreturn=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Procedure PrepareToSlurpJSONFilesComplexObjectsFromGenericObjectsArray Starting!' >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    export Slurpstarfilename=
    export Slurpstarfilefqpn=
    export Finaljsonfilename=
    export Finaljsonfileexport=
    
    export Finaljsonfilename=${APICLIcomplexobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Finaljsonfilename=${Finaljsonfilename}'_'${APICLIexportnameaddon}
    fi
    export Finaljsonfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Finaljsonfilename}${APICLIfileexportpost}
    
    # MODIFIED 2023-02-24:01 -
    
    export Slurpstarfilename=${APICLIcomplexobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpstarfilename=${Slurpstarfilename}'_'${APICLIexportnameaddon}
    fi
    
    export Slurpuglyfilename=${APICLIcomplexobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpuglyfilename=${Slurpuglyfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpuglyfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpuglyfilename}'.ugly.'${APICLIfileexportpost}
    
    export Slurpprettyfilename=${APICLIcomplexobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpprettyfilename=${Slurpprettyfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpprettyfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpprettyfilename}'.pretty.'${APICLIfileexportpost}
    
    export Slurpfinalfilename=${APICLIcomplexobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export Slurpfinalfilename=${Slurpfinalfilename}'_'${APICLIexportnameaddon}
    fi
    export Slurpfinalfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpfinalfilename}'.final.'${APICLIfileexportpost}
    
    if ${DoFileSlurp} ; then
        
        export Slurpstarfilename=${Slurpstarfilename}'_*_of_'${objectstotalformatted}
        export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
        
        echo `${dtzs}`${dtzsep} '  Multiple JSON files created, need to SLURP together the file!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp these files     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
        
        # Slurp the collection of JSON files into a single JSON already
        
        # -------------------------------------------------------------------------------------------------
        
        CommonSlurpJSONFilesIntoSingleFile
        
        # -------------------------------------------------------------------------------------------------
        
    else
        # File is single JSON already
        # Handle placement of final object JSON file into standing current object repository next
        if ${NoSystemObjects} ; then
            
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_NSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        elif ${OnlySystemObjects} ; then
            
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_OSO_of_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        else
            
            export Slurpstarfilename=${Slurpstarfilename}'_ALL_'${objectstotalformatted}
            export Slurpstarfilefqpn=${Slurpworkfolder}/${APICLIfileexportpre}${Slurpstarfilename}${APICLIfileexportpost}
            
        fi
        
        # Slurp the single JSON files into a single JSON already
        
        if [ -s ${APICLIfileexport} ] ; then
            # exported json file is not zero length, so process for slurp
            # copy the broken json file as the slurpstar file to the slurp work area
            cp -fv ${APICLIfileexport} ${Slurpstarfilefqpn} >> ${logfilepath} 2>&1
            
            echo `${dtzs}`${dtzsep} '  Single broken JSON file created, need to SLURP to fix the file!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Slurp this file     :  '${Slurpstarfilefqpn} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  Slurp into this file :  '${Finaljsonfileexport} | tee -a -i ${logfilepath}
            
            # -------------------------------------------------------------------------------------------------
            
            CommonSlurpJSONFilesIntoSingleFile
            
            # -------------------------------------------------------------------------------------------------
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
        
    fi
    
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Procedure PrepareToSlurpJSONFilesComplexObjectsFromGenericObjectsArray completed!  errorreturn :  !{ '${errorreturn}' }!' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-24:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# DumpArrayOfGenericObjectsKeyFieldValues proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-23:01 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfGenericObjectsKeyFieldValues outputs the array of generic objects names.

DumpArrayOfGenericObjectsKeyFieldValues () {
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all objects found
        
        # print the elements in the array
        echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Dump '${APIGenObjobjecttype}' names for generating '${APICLIcomplexobjectstype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        for i in "${GENERICOBJECTSKEYFIELDARRAY[@]}"
        do
            echo `${dtzs}`${dtzsep} "${i}, ${i//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Done dumping '${APIGenObjobjecttype}' names for generating '${APICLIcomplexobjectstype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-02-23:01

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - Populate_GENERICOBJECTSKEYFIELDARRAY
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Populate GENERICOBJECTSKEYFIELDARRAY
#

Populate_GENERICOBJECTSKEYFIELDARRAY () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    # MODIFIED 2023-02-23 -
    #
    
    # -------------------------------------------------------------------------------------------------
    
    if [ x"${objectqueryselector}" != x"" ] ; then
        # ${objectqueryselector} is not empty
        GENERIC_OBJECT_NAME_STRING="`cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}"' | .'"${APIGenObjobjectkey}"' | @sh' -r`"
    else
        # ${objectqueryselector} is empty
        GENERIC_OBJECT_NAME_STRING="`cat ${APICLIJSONfilelast} | ${JQ} '.objects[].'"${APIGenObjobjectkey}"' | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    echo -n `${dtzs}`${dtzsep} '    Read Generic Objects '"${APIGenObjobjectkey}"' into array:  ' | tee -a -i ${logfilepath}
    while read -r line; do
        if [ "${line}" == '' ]; then
            # ${line} value is nul, so skip adding to array
            echo -n '%' | tee -a -i ${logfilepath}
        else
            # ${line} value is NOT nul, so add to array
            GENERICOBJECTSKEYFIELDARRAY+=("${line}")
            echo -n '.' | tee -a -i ${logfilepath}
        fi
    done <<< "${GENERIC_OBJECT_NAME_STRING}"
    errorreturn=$?
    echo | tee -a -i ${logfilepath}
    
    # -------------------------------------------------------------------------------------------------
    
    if [ ${#GENERICOBJECTSKEYFIELDARRAY[@]} -ge 1 ] ; then
        # GENERICOBJECTSKEYFIELDARRAY is not empty
        export ObjectsOfTypeToProcess=true
    else
        export ObjectsOfTypeToProcess=false
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  Final ObjectsOfTypeToProcess = '${ObjectsOfTypeToProcess} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  Final ObjectsOfTypeToProcess = '${ObjectsOfTypeToProcess} >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} '  Number of Object Types Array Elements = ['"${#GENERICOBJECTSKEYFIELDARRAY[@]}"']' | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '  Final Object Types Array = ' | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
        #echo | tee -a -i ${logfilepath}
        
        echo '['"${GENERICOBJECTSKEYFIELDARRAY[@]}"']' | tee -a -i ${logfilepath}
        
        #echo | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} '  Final Object Types Array = ' >> ${logfilepath}
        echo '------------------------------------------------------------------------       ' >> ${logfilepath}
        #echo | tee -a -i ${logfilepath}
        
        echo '['"${GENERICOBJECTSKEYFIELDARRAY[@]}"']' >> ${logfilepath}
        
        #echo | tee -a -i ${logfilepath}
        echo '------------------------------------------------------------------------       ' >> ${logfilepath}
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-03-02:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - UseGENERICOBJECTSKEYFIELDARRAYtoShowTargetObject
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:01 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Use GENERICOBJECTSKEYFIELDARRAY to Show Target Object
#

UseGENERICOBJECTSKEYFIELDARRAYtoShowTargetObject () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    for i in "${GENERICOBJECTSKEYFIELDARRAY[@]}"
    do
        export objecttoevaluate=${i}
        export objectnametoevaluate=${i//\'/}
        
        #if ! ${firstobjectevaluated}  ; then
            #echo ',' >> ${APICLIfileexport}
        #fi
        
        echo `${dtzs}`${dtzsep} 'Processing '${APICLIobjecttype}' with '"${APIGenObjobjectkey}"' [ '${objectnametoevaluate}' ]' | tee -a -i ${logfilepath}
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjecttype}' '"${APIGenObjobjectkey}"' "'${objectnametoevaluate}'" '${MgmtCLI_Show_OpParms}' \>> '${APICLIfileexport} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjecttype}' '"${APIGenObjobjectkey}"' "'${objectnametoevaluate}'" '${MgmtCLI_Show_OpParms}' \>> '${APICLIfileexport} >> ${logfilepath}
        fi
        
        mgmt_cli show ${APICLIobjecttype} ${APIGenObjobjectkey} "${objectnametoevaluate}" ${MgmtCLI_Show_OpParms} >> ${APICLIfileexport}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Handle Error in operation
            echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in mgmt_cli call for ExportComplexObjectViaGenericObjectsArrayToJSONStandard procedure' | tee -a -i ${logfilepath}
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjobjecttype}' -- RETURNING!!' | tee -a -i ${logfilepath}
                if ! ${NOWAIT} ; then
                    read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                fi
            fi
            
            return ${errorreturn}
        fi
        
        #export firstobjectevaluated=false
    done
    
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-03-02:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Operational proceedure - ExportComplexObjectViaGenericObjectsArrayToJSONStandard
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-23:03 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Export Objects with utilization of limits and details-level as a standard to JSON
#

ExportComplexObjectViaGenericObjectsArrayToJSONStandard () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    #export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}' --conn-timeout '${APICLIconntimeout}
    
    ##export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    #export MgmtCLI_IgnoreErr_OpParms='--ignore-errors true'
    #if ${APIobjectcanignoreerror} ; then
        #export MgmtCLI_IgnoreErr_OpParms='ignore-errors true '${MgmtCLI_IgnoreErr_OpParms}
    #fi
    #if ${APIobjectcanignorewarning} ; then
        #export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true '${MgmtCLI_IgnoreErr_OpParms}
    #fi
    
    if ${APIobjectusesdetailslevel} ; then
        #export MgmtCLI_Show_OpParms='details-level "'${WorkingAPICLIdetaillvl}'" '${MgmtCLI_IgnoreErr_OpParms}' '${MgmtCLI_Base_OpParms}
        #export MgmtCLI_Show_OpParms='details-level "'${WorkingAPICLIdetaillvl}'" '${MgmtCLI_Base_OpParms}
        # Forcing to details-level standard for this operation
        export MgmtCLI_Show_OpParms_Standard='details-level "standard" '${MgmtCLI_Base_OpParms}
    else
        #export MgmtCLI_Show_OpParms=${MgmtCLI_IgnoreErr_OpParms}' '${MgmtCLI_Base_OpParms}
        export MgmtCLI_Show_OpParms_Standard=${MgmtCLI_Base_OpParms}
    fi
    
    if ${APIobjectderefgrpmem} ; then
        export MgmtCLI_Show_OpParms_Standard='dereference-group-members true '${MgmtCLI_Show_OpParms}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        #echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_Base_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_Base_OpParms} >> ${logfilepath}
        #echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectcanignoreerror' ' : ' >> ${logfilepath} ; echo ${APIobjectcanignoreerror} >> ${logfilepath}
        #echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectcanignorewarning' ' : ' >> ${logfilepath} ; echo ${APIobjectcanignorewarning} >> ${logfilepath}
        #echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_IgnoreErr_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_IgnoreErr_OpParms} >> ${logfilepath}
        #echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'WorkingAPICLIdetaillvl' ' : ' >> ${logfilepath} ; echo ${WorkingAPICLIdetaillvl} >> ${logfilepath}
        #echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'APIobjectusesdetailslevel' ' : ' >> ${logfilepath} ; echo ${APIobjectusesdetailslevel} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_Show_OpParms' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_Show_OpParms} >> ${logfilepath}
        echo -n `${dtzs}`${dtzsep} '    - ' >> ${logfilepath}; printf "%-40s %s" 'MgmtCLI_Show_OpParms_Standard' ' : ' >> ${logfilepath} ; echo ${MgmtCLI_Show_OpParms_Standard} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} '--------------------------------------------------------------------------' >> ${logfilepath}
    fi
    
    # Calling subroutine provides objectstotal and objectstoshow value
    #objectstotal=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    # MODIFIED 2023-02-23:01 -
    #export objectstoshow=${objectstotal}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Processing '${objectstoshow}' '${APIGenObjobjecttype}' objects in '${WorkAPIObjectLimit}' object chunks:' | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    if [ ${objectstoshow} -gt ${WorkAPIObjectLimit} ] ; then
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
    
    objectstotalformatted=`printf "%05d" ${objectstoshow}`
    
    #export firstobjectevaluated=true
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        
        nextoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
        
        #if [ ${currentoffset} -gt 0 ] ; then
        #    # Export file for the next ${WorkAPIObjectLimit} objects
        #    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APICLIcomplexobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
        #fi
        
        currentoffsetformatted=`printf "%05d" ${currentoffset}`
        nextoffsetformatted=`printf "%05d" ${nextoffset}`
        
        # 2017-11-20 Updating naming of files for multiple ${WorkAPIObjectLimit} chunks to clean-up name listing
        if [ ${objectstoshow} -gt ${WorkAPIObjectLimit} ] ; then
            # Export file for the next ${WorkAPIObjectLimit} objects
            export APICLIfilename=${APICLIcomplexobjectstype}
            if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
            fi
            
            #export APICLIfilename=${APICLIfilename}'_'${currentoffset}'-'${nextoffset}'_of_'${objectstoshow}
            export Workingfilename=${APICLIfilename}'_'${currentoffsetformatted}'-'${nextoffsetformatted}'_of_'${objectstotalformatted}
            
            #export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APICLIcomplexobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
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
        
        # -------------------------------------------------------------------------------------------------
        
        # Operational Steps
        # 1.  Export required object data for objecttype to working JSON file ${APICLIJSONfilelast}
        # 2.  Based on export type, so NoSystemsObjects, OnlySystemObjects, or all objects, execute dump of ${APICLIJSONfilelast} through jq using potential object selectors, to export file ${APICLIfileexport}
        # 3.  If needed, copy file for slurp operation to ${Slurpworkfileexport} 
        
        # MODIFIED 2023-02-23:01 -
        # MgmtCLI_Show_OpParms_Standard vs MgmtCLI_Show_OpParms
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms_Standard}' \> '${APICLIJSONfilelast} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APIGenObjectTypes}' '${APIGenObjectClassField}' "'"${APIGenObjectClass}"'" limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms_Standard}' \> '${APICLIJSONfilelast} >> ${logfilepath}
        fi
        
        mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms_Standard} > ${APICLIJSONfilelast}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo `${dtzs}`${dtzsep} 'ExportComplexObjectViaGenericObjectsArrayToJSONStandard : Problem during mgmt_cli operation! error return = { '${errorreturn}' }' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} '  File contents with potential error from '${APICLIJSONfilelast}' : ' >> ${logfilepath}
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo >> ${logfilepath}
            
            cat ${APICLIJSONfilelast} | tee -a -i ${logfilepath}
            
            echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
        export GENERICOBJECTSKEYFIELDARRAY=()
        export ObjectsOfTypeToProcess=false
        
        export workingkey=${APIGenObjobjectkey}
        
        Populate_GENERICOBJECTSKEYFIELDARRAY
        
        # -------------------------------------------------------------------------------------------------
        
        if ${ObjectsOfTypeToProcess} ; then
            # we have objects left to process after generating the array of ObjectsType
            echo `${dtzs}`${dtzsep} 'Processing returned '${#GENERICOBJECTSKEYFIELDARRAY[@]}' objects of type '${APIGenObjobjecttype}', so processing this object' | tee -a -i ${logfilepath}
            
            DumpArrayOfGenericObjectsKeyFieldValues
            errorreturn=$?
            
            if [ ${errorreturn} != 0 ] ; then
                # Handle Error in operation
                echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in DumpArrayOfGenericObjectsKeyFieldValues procedure' | tee -a -i ${logfilepath}
                
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'ERROR Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APIGenObjobjecttype}' -- RETURNING!!' | tee -a -i ${logfilepath}
                    if ! ${NOWAIT} ; then
                        read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
                    fi
                fi
                
                return ${errorreturn}
            fi
            
            UseGENERICOBJECTSKEYFIELDARRAYtoShowTargetObject
            
        else
            # The array of ObjectsType is empty, nothing to process
            echo `${dtzs}`${dtzsep} 'No objects of type '${APIGenObjobjecttype}' were returned to process' | tee -a -i ${logfilepath}
        fi
        
        # -------------------------------------------------------------------------------------------------
        
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
    
    # MODIFIED 2023-02-23:01 -
    
    PrepareToSlurpJSONFilesComplexObjectsFromGenericObjectsArray
    
    # Handle placement of final object JSON file into standing current object repository
    
    CommonJSONRepositoryUpdateHander
    
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
    
    echo `${dtzs}`${dtzsep} 'ExportComplexObjectViaGenericObjectsArrayToJSONStandard procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-23:03


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportComplexObjectViaGenericObjectsArrayToJSON
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-02-23:02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APIGenObjobjecttype} details is exported to a json at the ${APICLIdetaillvl}.

ExportComplexObjectViaGenericObjectsArrayToJSON () {
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
    echo `${dtzs}`${dtzsep} 'Generic Object Type:  '${APIGenObjobjecttype}'  Objects Type :  '${APICLIobjectstype}'  Complex Objects Type :  '${APICLIcomplexobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ "${APICLIdetaillvl}" == "standard" ] ; then
        # Need to check if we have object type selector values, since that won't work with details-level standard!
        if [ x"${APIobjectspecificselector00key}" != x"" ] ; then
            # OK, need to skip this because we can't process this with detials-level "standard"
            echo `${dtzs}`${dtzsep} 'Complex Objects Type :  '${APICLIcomplexobjectstype}' has defined object type selectors set, but details-level is "'${APICLIdetaillvl}'", so skipping to avoid fail!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
    fi
    
    # -------------------------------------------------------------------------------------------------
    
    CheckAPIKeepAlive
    
    # -------------------------------------------------------------------------------------------------
    
    objectstotal=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    # MODIFIED 2023-02-23:01 -
    export objectstoshow=${objectstotal}
    
    # -------------------------------------------------------------------------------------------------
    
    errorreturn=0
    
    if [ ${objectstoshow} = null ] ; then
        echo `${dtzs}`${dtzsep} 'Found NO [ null ] '${APICLIcomplexobjectstype}' Complex Objects.  No Complex Objects found!  Skipping!...' | tee -a -i ${logfilepath}
    elif [ ${objectstoshow} -le 0 ] ; then
        echo `${dtzs}`${dtzsep} 'Found [ '${objectstoshow}' ] '${APIGenObjobjecttype}' Complex Objects.  No Complex Objects found!  Skipping!...' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Start Processing [ '${objectstoshow}' ] Complex Objects Type :  '${APICLIcomplexobjectstype}' objects :' | tee -a -i ${logfilepath}
        
        # MODIFIED 2023-02-23 -
        
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
        
        # MODIFIED 2023-02-23 - 
        # Current alternative if more options to exclude are needed, now there is a procedure for that
        
        ConfigureObjectQuerySelector
        
        # -------------------------------------------------------------------------------------------------
        # Configure basic parameters
        # -------------------------------------------------------------------------------------------------
        
        # MODIFIED 2023-02-23:01 -
        
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
        
        export APICLIfilename=${APICLIcomplexobjectstype}
        if [ x"${APICLIexportnameaddon}" != x"" ] ; then
            export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
        fi
        
        export Workingfilename=${APICLIfilename}
        export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
        export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}'_last'${APICLIJSONfileexportpost}
        
        ExportComplexObjectViaGenericObjectsArrayToJSONStandard
        
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportComplexObjectViaGenericObjectsArrayToJSON procedure errorreturn :  !{ '${errorreturn}' }!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2023-02-23:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ComplexObjectsJSONViaGenericObjectsArrayHandler proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-02:02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ComplexObjectsJSONViaGenericObjectsArrayHandler () {
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
    
    # MODIFIED 2023-03-02:01 -
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
    
    #objectstotal_object=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    objectstotal_object=$(mgmt_cli show ${APIGenObjectTypes} ${APIGenObjectClassField} "${APIGenObjectClass}" limit 500 offset 0 details-level standard -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    export number_object="${objectstotal_object}"
    
    if [ ${number_object} -le 0 ] ; then
        # No groups found
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'No '${APICLIobjectstype}' to generate '${APICLIcomplexobjectstype}' members from!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        ExportComplexObjectViaGenericObjectsArrayToJSON
        errorreturn=$?
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} '  Done with Exporting Objects Type :  '${APICLIcomplexobjectstype}' from source Objects Type:  '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ ${errorreturn} != 0 ] ; then
        # Handle Error in operation
        echo `${dtzs}`${dtzsep} 'Error { '${errorreturn}' } in ComplexObjectsJSONViaGenericObjectsArrayHandler procedure' | tee -a -i ${logfilepath}
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
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2023-03-02:02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Complex Objects via Generic-Objects Array Handling Procedures
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


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites-from-generic-objects
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# |  - Reference Details and initial object
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

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

ComplexObjectsJSONViaGenericObjectsArrayHandler


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!

# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**
# Complex Object via Generic-Objects Handlers - Object Specific Keys with Value arrays
# **-------------------------------------------------------------------------------------------------**
# **-------------------------------------------------------------------------------------------------**


CheckAPIKeepAlive


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Complex Object via Generic-Objects Handlers - Object Specific Keys with Value arrays' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Complex Object via Generic-Objects - Object Specific Keys with Value arrays Handling Procedures Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2023-03-02 -
# MODIFIED 2023-03-02:01 -


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Complex Object via Generic-Objects - Object Specific Keys with Value arrays Handling Procedures Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites-from-generic-objects
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# |  - Reference Details and initial object
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey=

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

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


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites - url-lists from generic object
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object-element-url-list
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects-elements-url-lists
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site-element-url-list
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites-elements-url-lists
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey='url-list'

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=custom-application-sites-from-generic-objects
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
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

#GetGenericObjectsByClassWithSpecificKeyArrayValues


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites - application-signatures from generic object
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# |  - Review of this application-sites objects element for application-signature resulted in a removal of this object, because a singular entry
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype=application-site
#export APICLIobjectstype=application-sites
#export APICLIcomplexobjecttype=custom-application-site-from-generic-object-element-application-signature
#export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects-elements-application-signatures
#export APIobjectminversion=1.1
#export APIobjectexportisCPI=false

#export APIGenObjectTypes=generic-objects
#export APIGenObjectClassField=class-name
#export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
#export APIGenObjectClassShort="appfw.CpmiUserApplication"
#export APIGenObjectField=uid

#export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
#export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
#export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site-element-application-signature
#export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites-elements-application-signatures
#export APIGenObjobjectkey=name
#export APIGenObjobjectkeydetailslevel=standard

#export APIobjectspecifickey='application-signature'

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#export APIobjectjsonrepofileobject=custom-application-sites-from-generic-objects
#export APICLICSVobjecttype=${APICLIcomplexobjectstype}
#export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
#export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
#export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
#export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

#export APIobjectdoexport=true
#export APIobjectdoexportJSON=false
#export APIobjectdoexportCSV=true
#export APIobjectdoimport=true
#export APIobjectdorename=false
#export APIobjectdoupdate=false
#export APIobjectdodelete=false

#export APIobjectusesdetailslevel=true
#export APIobjectcanignorewarning=true
#export APIobjectcanignoreerror=true
#export APIobjectcansetifexists=false
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

#GetGenericObjectsByClassWithSpecificKeyArrayValues


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : custom application-sites - additional-categories from generic object
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# +-------------------------------------------------------------------------------------------------

ClearObjectDefinitionData

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLIcomplexobjecttype=custom-application-site-from-generic-object-element-additional-category
export APICLIcomplexobjectstype=custom-application-sites-from-generic-objects-elements-additional-categories
export APIobjectminversion=1.1
export APIobjectexportisCPI=false

export APIGenObjectTypes=generic-objects
export APIGenObjectClassField=class-name
export APIGenObjectClass="com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
export APIGenObjectClassShort="appfw.CpmiUserApplication"
export APIGenObjectField=uid

export APIGenObjobjecttype=appfw_CpmiUserApplication_application-site
export APIGenObjobjectstype=appfw_CpmiUserApplication_application-sites
export APIGenObjcomplexobjecttype=appfw_CpmiUserApplication_application-site-element-additional-category
export APIGenObjcomplexobjectstype=appfw_CpmiUserApplication_application-sites-elements-additional-categories
export APIGenObjobjectkey=name
export APIGenObjobjectkeydetailslevel=standard

export APIobjectspecifickey='additional-categories'

export APIobjectspecificselector00key=
export APIobjectspecificselector00value=
export APICLIexportnameaddon=

export APIobjectjsonrepofileobject=custom-application-sites-from-generic-objects
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

export APIobjectdoexport=true
export APIobjectdoexportJSON=false
export APIobjectdoexportCSV=true
export APIobjectdoimport=true
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

#GetGenericObjectsByClassWithSpecificKeyArrayValues


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more Complex Objects via Generic-Objects Array Handler objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Complex Objects via Generic-Objects Array Handler - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more Object via Generic-Objects Handlers objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - Complex Object via Generic-Objects Handlers - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!
# !-------------------------------------------------------------------------------------------------!


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more complex objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


# MODIFIED 2021-02-24 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - complex objects handlers - '${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-24


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*
# No more objects
# *------------------------------------------------------------------------------------------------*
# *------------------------------------------------------------------------------------------------*


# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${scriptactiondescriptor}' Completed!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# Action Script Completed
# =================================================================================================


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Action Script Completed :  '${ActionScriptName} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '===============================================================================' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}


return 0


# =================================================================================================
# END:  Export objects to json in set detail level from root script
# =================================================================================================
# =================================================================================================

