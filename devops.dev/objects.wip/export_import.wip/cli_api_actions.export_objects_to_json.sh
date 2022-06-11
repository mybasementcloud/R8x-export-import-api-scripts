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
# SCRIPT Object dump to JSON action operations for API CLI Operations
#
#
ScriptVersion=00.60.09
ScriptRevision=010
ScriptSubRevision=030
ScriptDate=2022-05-05
TemplateVersion=00.60.09
APISubscriptsLevel=010
APISubscriptsVersion=00.60.09
APISubscriptsRevision=005

#

export APIActionsScriptVersion=v${ScriptVersion}
export APIActionScriptTemplateVersion=v${TemplateVersion}

export APIActionsScriptVersionX=v${ScriptVersion//./x}
export APIActionScriptTemplateVersionX=v${TemplateVersion//./x}

ActionScriptName=cli_api_export_objects_actions
export APIActionScriptFileNameRoot=cli_api_export_objects_actions
export APIActionScriptShortName=export_objects_actions
export APIActionScriptnohupName=${APIActionScriptShortName}
export APIActionScriptDescription="Object dump to JSON action operations for API CLI Operations"

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

# MODIFIED 2022-04-29 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Check API Keep Alive Status.
#
CheckAPIKeepAlive () {
    #
    # Check API Keep Alive Status and on error try a login attempt
    #
    
    errorreturn=0
    
    if ${LoggedIntoMgmtCli} ; then
        echo -n `${dtzs}`${dtzsep} ' mgmt_cli keepalive check :  ' | tee -a -i ${logfilepath}
        if ${addversion2keepalive} ; then
            mgmt_cli keepalive --version ${CurrentAPIVersion} -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
            export errorreturn=$?
        else
            mgmt_cli keepalive -s ${APICLIsessionfile} >> ${logfilepath} 2>&1
            export errorreturn=$?
        fi
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
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
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-04-29

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureObjectQuerySelector - Configure Object Query Selector value objectqueryselector
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-04-29 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ConfigureObjectQuerySelector () {
    #
    
    # -------------------------------------------------------------------------------------------------
    # Configure Object Query Selector value objectqueryselector
    # -------------------------------------------------------------------------------------------------
    
    export objectqueryselector=
    
    # Current alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    
    # selector for objects created by customer and not from Check Point
    
    export notsystemobjectselector='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not'
    
    # based on some interesting feedback, adding ability to dump only system objects, not created by customer
    
    export onlysystemobjectselector='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a)'
    
    # also handle the specifics around whether meta-info.creator is or is not "System"
    
    export notcreatorissystemselector='."meta-info"."creator" != "System"'
    
    export creatorissystemselector='."meta-info"."creator" = "System"'
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        if ${CreatorIsNotSystem} ; then
            # Ignore System Objects and no creator = System
            export objectqueryselector='select( ('${notsystemobjectselector}') and ('${notcreatorissystemselector}') )'
        else
            # Ignore System Objects
            export objectqueryselector='select('${notsystemobjectselector}')'
        fi
    elif ${OnlySystemObjects} ; then
        # Select only System Objects
        if ${CreatorIsSystem} ; then
            # select only System Objects and creator = System
            export objectqueryselector='select( ('${onlysystemobjectselector}') and ('${creatorissystemselector}') )'
        else
            # select only System Objects
            export objectqueryselector='select('${onlysystemobjectselector}')'
        fi
    else
        # Include System Objects
        if ${CreatorIsNotSystem} ; then
            # Include System Objects and no creator = System
            export objectqueryselector='select( '${notcreatorissystemselector}')'
        elif ${CreatorIsSystem} ; then
            # Include System Objects and no creator = System
            export objectqueryselector='select( '${creatorissystemselector}')'
        else
            # Include System Objects
            export objectqueryselector=
        fi
    fi
    
    echo `${dtzs}`${dtzsep} ' -- ConfigureObjectQuerySelector:' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '    - NoSystemObjects='${NoSystemObjects}' OnlySystemObjects='${OnlySystemObjects}' CreatorIsNotSystem='${CreatorIsNotSystem}' CreatorIsSystem='${CreatorIsSystem} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '    - Object Query Selector = ['${objectqueryselector}']' >> ${logfilepath}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-04-29

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
# Main Operational repeated proceedure - ExportRAWObjectToJSON
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-03-11 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjecttype} details is exported to a json at the ${APICLIdetaillvl}.

ExportRAWObjectToJSON () {
    #
    # Export Objects to raw JSON
    #
    
    errorreturn=0
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Objects Type :  '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2021-11-09 -
    
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
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # MODIFIED 2022-04-22 -
    
    # System Object selection operands
    # This one won't work because upgrades set all objects to creator = System
    # export notsystemobjectselector='select(."meta-info"."creator" != "System")'
    #export notsystemobjectselector='select(."meta-info"."creator" | contains ("System") | not)'
    #
    # This should work if assumptions aren't wrong
    #export notsystemobjectselector='select(."domain"."name" != "Check Point Data")'
    
    #
    # This should work, but might need more tweeks if other data types use more values
    #export notsystemobjectselector='select(."domain"."name" | contains ("Check Point Data", "APPI Data", "IPS Data") | not)'
    #export notsystemobjectselector='select(any(."domain"."name"; in("Check Point Data", "APPI Data", "IPS Data")) | not)'
    #export notsystemobjectselector='select((."domain"."name" != "Check Point Data") and (."domain"."name" != "APPI Data") and (."domain"."name" != "IPS Data"))'
    
    #
    # Future alternative if more options to exclude are needed
    #export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    #export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    #export notsystemobjectselector='select(.objects[]."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    #export notsystemobjectselector='.objects[] | select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    #export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    
    # MODIFIED 2022-04-22 - 
    # Current alternative if more options to exclude are needed
    ConfigureObjectQuerySelector
    
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
    
    export Workingfilename=${APICLIfilename}
    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Workingfilename}${APICLIfileexportpost}
    export APICLIJSONfilelast=${Slurpworkfolder}/${APICLIfileexportpre}${Workingfilename}'_last'${APICLIJSONfileexportpost}
    
    export MgmtCLI_Base_OpParms='-f json -s '${APICLIsessionfile}' --conn-timeout '${APICLIconntimeout}
    
    export MgmtCLI_IgnoreErr_OpParms='ignore-warnings true ignore-errors true --ignore-errors true'
    
    export MgmtCLI_Show_OpParms='details-level "'${APICLIdetaillvl}'" '${MgmtCLI_Base_OpParms}
    
    if ${APIobjectderefgrpmem} ; then
        export MgmtCLI_Show_OpParms='dereference-group-members true '${MgmtCLI_Show_OpParms}
    fi
    
    CheckAPIKeepAlive
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level standard ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    errorreturn=0
    
    if [ ${objectstoshow} = null ] ; then
        echo `${dtzs}`${dtzsep} 'Found NO '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    elif [ ${objectstoshow} -le 0 ] ; then
        echo `${dtzs}`${dtzsep} 'Found '${objectstoshow}' '${APICLIobjecttype}' objects.  No objects found!  Skipping!...' | tee -a -i ${logfilepath}
    else
        
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
        
        while [ ${objectslefttoshow} -ge 1 ] ; do
            # we have objects to process
            
            nextoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
            
            #if [ ${currentoffset} -gt 0 ] ; then
            #    # Export file for the next ${WorkAPIObjectLimit} objects
            #    export APICLIfileexport=${APICLIpathexport}/${APICLIfileexportpre}${APICLIobjectstype}'_'${currentoffset}'_'${APICLIfileexportpost}
            #fi
            
            # 2017-11-20 Updating naming of files for multiple ${WorkAPIObjectLimit} chunks to clean-up name listing
            if [ ${objectstotal} -gt ${WorkAPIObjectLimit} ] ; then
                # Export file for the next ${WorkAPIObjectLimit} objects
                export APICLIfilename=${APICLIobjectstype}
                if [ x"${APICLIexportnameaddon}" != x"" ] ; then
                    export APICLIfilename=${APICLIfilename}'_'${APICLIexportnameaddon}
                fi
                
                #export APICLIfilename=${APICLIfilename}'_'${currentoffset}'-'${nextoffset}'_of_'${objectstotal}
                
                currentoffsetformatted=`printf "%05d" ${currentoffset}`
                nextoffsetformatted=`printf "%05d" ${nextoffset}`
                objectstotalformatted=`printf "%05d" ${objectstotal}`
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
            
            # MODIFIED 2022-04-22 -
            
            if ${NoSystemObjects} ; then
                # Ignore System Objects
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} '      No System Objects.  Selector = '${objectqueryselector} | tee -a -i ${logfilepath}
                fi
                #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}" >> ${APICLIfileexport}
                #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '. | '"${notsystemobjectselector}" >> ${APICLIfileexport}
                #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '. | '"${notsystemobjectselector}" > ${APICLIfileexport}
                #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}" > ${APICLIfileexport}
                
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} >> ${logfilepath}
                fi
                
                mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLIJSONfilelast}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON : Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                if ${DoFileSlurp} ; then
                    #echo `${dtzs}`${dtzsep} '      Dump to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                    #GETDATA=`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | jq '.'`
                    #DATA=`echo ${GETDATA} | jq '.objects[] | '"${notsystemobjectselector}"`
                    
                    #echo ${DATA} >> ${Slurpworkfileexport}
                    
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
                
            elif ${OnlySystemObjects} ; then
                # Select only System Objects
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} '      Only System Objects.  Selector = '${objectqueryselector} | tee -a -i ${logfilepath}
                fi
                
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} '  Command Executed :  mgmt_cli show '${APICLIobjectstype}' limit '${WorkAPIObjectLimit}' offset '${currentoffset}' '${MgmtCLI_Show_OpParms}' \> '${APICLIJSONfilelast} >> ${logfilepath}
                fi
                
                mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} > ${APICLIJSONfilelast}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON : Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                cat ${APICLIJSONfilelast} | ${JQ} '.objects[] | '"${objectqueryselector}" > ${APICLIfileexport}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                if ${DoFileSlurp} ; then
                    #echo `${dtzs}`${dtzsep} '      Dump to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                    #GETDATA=`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | jq '.'`
                    #DATA=`echo ${GETDATA} | jq '.objects[] | '"${notsystemobjectselector}"`
                    
                    #echo ${DATA} >> ${Slurpworkfileexport}
                    
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
                
            else
                # Don't Ignore System Objects
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} '      All objects, including System Objects' | tee -a -i ${logfilepath}
                fi
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
                    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON : Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                cat ${APICLIJSONfilelast} > ${APICLIfileexport}
                errorreturn=$?
                
                if [ ${errorreturn} != 0 ] ; then
                    # Something went wrong, terminate
                    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON : Problem during mgmt_cli JQ Query! error return = '${errorreturn} | tee -a -i ${logfilepath}
                    return ${errorreturn}
                fi
                
                if ${DoFileSlurp} ; then
                    #echo `${dtzs}`${dtzsep} '      Dump to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                    #GETDATA=`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | jq '.'`
                    #DATA=`echo ${GETDATA} | jq '.objects[]'`
                    
                    #echo ${DATA} >> ${Slurpworkfileexport}
                    
                    if [ -s ${APICLIfileexport} ] ; then
                        # exported json file is not zero length, so process for slurp
                        echo `${dtzs}`${dtzsep} '      Dump to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                        cat ${APICLIfileexport} | jq '.objects[]' > ${Slurpworkfileexport}
                    else
                        # exported json file is zero length, so do not process file for slurp
                        if ${APISCRIPTVERBOSE} ; then
                            echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} | tee -a -i ${logfilepath}
                        else
                            echo `${dtzs}`${dtzsep} '      NOT dumping zero lenghth file to slurp work file '${Slurpworkfileexport} >> ${logfilepath}
                        fi
                    fi
                fi
                
            fi
            
            objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
            #currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
            currentoffset=${nextoffset}
            
            # MODIFIED 2022-02-15 -
            
            CheckAPIKeepAlive
            
        done
        
        export Slurpstarfilename=
        export Slurpstarfilefqpn=
        export Finaljsonfilename=
        export Finaljsonfileexport=
        
        export Finaljsonfilename=${APICLIobjectstype}
        if [ x"${APICLIexportnameaddon}" != x"" ] ; then
            export Finaljsonfilename=${Finaljsonfilename}'_'${APICLIexportnameaddon}
        fi
        export Finaljsonfileexport=${APICLIpathexport}/${APICLIfileexportpre}${Finaljsonfilename}${APICLIfileexportpost}
        
        
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
                    
                    cp -fv ${Slurpstarfilefqpn} ${APICLIfileexport} >> ${logfilepath} 2>&1
                fi
                
                # Handle placement of final object JSON file into standing current object repository next
            else
                echo `${dtzs}`${dtzsep} '  Only single JSON file created, no need to SLURP together the file!' | tee -a -i ${logfilepath}
            fi
        fi
        
        # Handle placement of final object JSON file into standing current object repository
        
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
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Tail of the export file : '${Finaljsonfileexport} | tee -a -i ${logfilepath}
            echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            #tail ${APICLIfileexport} | tee -a -i ${logfilepath}
            tail ${Finaljsonfileexport} | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
            echo '----------------------------------------------------------------------' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Tail of the export file : '${Finaljsonfileexport} >> ${logfilepath}
            echo '----------------------------------------------------------------------' >> ${logfilepath}
            echo >> ${logfilepath}
            #tail ${APICLIfileexport} >> ${logfilepath}
            tail ${Finaljsonfileexport} >> ${logfilepath}
            echo >> ${logfilepath}
            echo '----------------------------------------------------------------------' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} >>  ${logfilepath}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} 'ExportRAWObjectToJSON procedure returns :  '${errorreturn} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2022-03-11


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckAPIVersionAndExecuteOperation :  Check the API Version running where we're logged in and if good execute operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2022-03-11 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckAPIVersionAndExecuteOperation () {
    #
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
    echo `${dtzs}`${dtzsep} 'Required minimum API version for object : '${APICLIobjectstype}' is API version = '${APIobjectminversion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Logged in management server API version = '${CurrentAPIVersion}' Check version : "'${CheckAPIVersion}'"' | tee -a -i ${logfilepath}
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) ] ; then
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
        echo `${dtzs}`${dtzsep} 'Current API Version ('${CurrentAPIVersion}') does not meet minimum API version expected requirement ('${APIobjectminversion}')' | tee -a -i ${logfilepath}
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
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2022-03-11


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

# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} ${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - simple objects - '${scriptactiondescriptor}' starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


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

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=network
export APICLIobjectstype=networks
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# wildcard objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.2
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=wildcard
export APICLIobjectstype=wildcards
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=group-with-exclusion
export APICLIobjectstype=groups-with-exclusion
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=address-range
export APICLIobjectstype=address-ranges
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# multicast-address-ranges objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=multicast-address-range
export APICLIobjectstype=multicast-address-ranges
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=dns-domain
export APICLIobjectstype=dns-domains
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# security-zones objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dynamic-object objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tag objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=tag
export APICLIobjectstype=tags
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-gateway objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-clusters
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=simple-cluster
export APICLIobjectstype=simple-clusters
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# checkpoint-hosts
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=true
export APIobjectderefgrpmem=false
export APICLIobjecttype=checkpoint-hosts
export APICLIobjectstype=checkpoint-hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=time
export APICLIobjectstype=times
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time-group objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-role objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# opsec-application objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# trusted-client objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=trusted-client
export APICLIobjectstype=trusted-clients
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsv-profile objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=lsv-profile
export APICLIobjectstype=lsv-profiles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# gsn-handover-group objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=gsn-handover-group
export APICLIobjectstype=gsn-handover-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-point-name objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=access-point-names
export APICLIobjectstype=access-point-names
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-point-name objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=access-point-names
export APICLIobjectstype=access-point-names
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-server objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.7
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.7
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=tacacs-group
export APICLIobjectstype=tacacs-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsm-gateways objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.8
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=lsm-gateway
export APICLIobjectstype=lsm-gateways
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsm-clusters objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.8
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=lsm-cluster
export APICLIobjectstype=lsm-clusters
export APICLICSVobjecttype=${APICLIobjectstype}
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

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-gtp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.7
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-gtp
export APICLIobjectstype=services-gtp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-citrix-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-citrix-tcp
export APICLIobjectstype=services-citrix-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-compound-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=service-compound-tcp
export APICLIobjectstype=services-compound-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation




# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Users
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# ADDED 2021-01-31 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Users' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2021-01-31

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# users
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-groups
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=true
export APICLIobjecttype=user-group
export APICLIobjectstype=user-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-templates
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# identity-tags
# -------------------------------------------------------------------------------------------------

export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
export APIobjectminversion=1.6.1
export APIobjectcansetifexists=false
export APIobjectderefgrpmem=false
export APICLIobjecttype=identity-tag
export APICLIobjectstype=identity-tags
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19


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
# handle complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}

# MODIFIED 2021-02-23 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep}${APICLIdetaillvl}' '${scriptformattext}' '${scriptactiontext}' - complex objects - '${scriptactiondescriptor}' Starting!' | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-02-23


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#
# Currently JSON export does not require complex object handling
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

