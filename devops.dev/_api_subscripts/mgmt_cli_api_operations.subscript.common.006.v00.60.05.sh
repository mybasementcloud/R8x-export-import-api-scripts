#!/bin/bash
#
# SCRIPT subscript for CLI Operations for management CLI API operations handling
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
ScriptVersion=00.60.05
ScriptRevision=010
ScriptDate=2021-02-10
TemplateVersion=00.60.05
APISubscriptsVersion=00.60.05
APISubscriptsRevision=006

#

export APISubscriptsScriptVersion=v${ScriptVersion}
export APISubscriptsScriptTemplateVersion=v${TemplateVersion}

export APISubscriptsScriptVersionX=v${ScriptVersion//./x}
export APISubscriptsScriptTemplateVersionX=v${TemplateVersion//./x}

APISubScriptName=mgmt_cli_api_operations.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}
export APISubScriptFileNameRoot=mgmt_cli_api_operations.subscript.common
export APISubScriptShortName=mgmt_cli_api_operations
export APISubScriptnohupName=${APISubScriptShortName}
export APISubScriptDescription="subscript for CLI Operations for management CLI API operations handling"


# =================================================================================================
# =================================================================================================
# START subscript:  Management CLI API Operations Handler
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

# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------


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
# 
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END Procedures:  Local Proceedures
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# GaiaWebSSLPortCheck - Check local Gaia Web SSL Port configuration for local operations
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-09-11 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GaiaWebSSLPortCheck - Check local Gaia Web SSL Port configuration for local operations
#

GaiaWebSSLPortCheck () {
    
    # Removing dependency on clish to avoid collissions when database is locked
    #
    #export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
    #
    export pythonpath=${MDS_FWDIR}/Python/bin/
    export get_api_local_port=`${pythonpath}/python ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
    export api_local_port=${get_api_local_port//\"/}
    export currentapisslport=${api_local_port}
    
    if ${SCRIPTVERBOSE} ; then
        echo 'Current Gaia web ssl-port : '${currentapisslport} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo 'Current Gaia web ssl-port : '${currentapisslport} >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-11


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#GaiaWebSSLPortCheck

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ScriptAPIVersionCheck - Check version of the script to ensure it is able to operate at minimum expected
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-09-11 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# ScriptAPIVersionCheck - Check version of the script to ensure it is able to operate at minimum 
# expected to correctly execute.
#

ScriptAPIVersionCheck () {
    
    SetupTempLogFile
    
    GetAPIVersion=$(mgmt_cli show api-versions -r true -f json --port ${currentapisslport} | ${JQ} '.["current-version"]' -r)
    export CheckAPIVersion=${GetAPIVersion}
    
    if [ ${CheckAPIVersion} = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=${CheckAPIVersion}
    fi
    
    echo 'API version = '${CurrentAPIVersion} >> ${subscriptstemplogfilepath}
    
    if [ $(expr ${MinAPIVersionRequired} '<=' ${CurrentAPIVersion}) ] ; then
        # API is sufficient version
        echo >> ${subscriptstemplogfilepath}
        
        HandleShowTempLogFile
        
    else
        # API is not of a sufficient version to operate
        echo >> ${subscriptstemplogfilepath}
        echo 'Current API Version ('${CurrentAPIVersion}') does not meet minimum API version expected requirement ('${MinAPIVersionRequired}')' >> ${subscriptstemplogfilepath}
        echo >> ${subscriptstemplogfilepath}
        echo '! termination execution !' >> ${subscriptstemplogfilepath}
        echo >> ${subscriptstemplogfilepath}
        
        ForceShowTempLogFile
        
        return 250
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-11


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# subCheckStatusOfAPI - repeated proceedure
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# repeated procedure description
#

subCheckStatusOfAPI () {
    #
    
    errorresult=0
    
    SetupTempLogFile CheckStatusOfApi
    
    # -------------------------------------------------------------------------------------------------
    # Check that the API is actually running and up so we don't run into wierd problems
    # -------------------------------------------------------------------------------------------------
    
    echo >> ${subscriptstemplogfilepath}
    echo '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
    echo 'Check API Operational Status before starting' >> ${subscriptstemplogfilepath}
    echo '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
    echo >> ${subscriptstemplogfilepath}
    
    export pythonpath=${MDS_FWDIR}/Python/bin/
    export get_api_local_port=`${pythonpath}/python ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
    export api_local_port=${get_api_local_port//\"/}
    export currentapisslport=${api_local_port}
    
    echo 'First make sure we do not have any issues:' >> ${subscriptstemplogfilepath}
    echo >> ${subscriptstemplogfilepath}
    
    mgmt_cli -r true show version --port ${currentapisslport} >> ${subscriptstemplogfilepath}
    errorresult=$?
    
    echo >> ${subscriptstemplogfilepath}
    
    if [ ${errorresult} -ne 0 ] ; then
        #api operation NOT OK, so anything that is not a 0 result is a fail!
        echo "API is not operating as expected so API calls will probably fail!" >> ${subscriptstemplogfilepath}
        echo 'Still executing api status for additional details' >> ${subscriptstemplogfilepath}
    else
        #api operations status OK
        echo "API is operating as expected so api status should work as expected!" >> ${subscriptstemplogfilepath}
    fi
    
    echo >> ${subscriptstemplogfilepath}
    echo 'Next check api status:' >> ${subscriptstemplogfilepath}
    echo >> ${subscriptstemplogfilepath}
    
    # Execute the API check with api status to a temporary log file, since tee throws off the results of error checking
    api status >> ${subscriptstemplogfilepath}
    errorresult=$?
    
    echo >> ${subscriptstemplogfilepath}
    echo 'API status check result ( 0 = OK ) : '${errorresult} >> ${subscriptstemplogfilepath}
    echo >> ${subscriptstemplogfilepath}
    
    HandleShowTempLogFile
    
    if [ ${errorresult} -ne 0 ] ; then
        #api operations status NOT OK, so anything that is not a 0 result is a fail!
        echo "API is not operating as expected so API calls will probably fail!" | tee -a -i ${subscriptstemplogfilepath}
        echo 'Critical Error '${errorresult}'- Exiting Script !!!!' | tee -a -i ${subscriptstemplogfilepath}
        echo | tee -a -i ${subscriptstemplogfilepath}
        echo "Log output in file ${subscriptstemplogfilepath}" | tee -a -i ${subscriptstemplogfilepath}
        echo | tee -a -i ${subscriptstemplogfilepath}
    else
        #api operations status OK
        echo "API is operating as expected so API calls should work!" | tee -a -i ${subscriptstemplogfilepath}
        echo | tee -a -i ${subscriptstemplogfilepath}
        echo "Current Log output in file ${subscriptstemplogfilepath}" | tee -a -i ${subscriptstemplogfilepath}
        echo | tee -a -i ${subscriptstemplogfilepath}
    fi
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i ${subscriptstemplogfilepath}
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    return ${errorresult}
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#subCheckStatusOfAPI
#errorresult=$?
#if [ ${errorresult} -ne 0 ] ; then
    #api operations status NOT OK, so anything that is not a 0 result is a fail!
    #Do something based on it not being ready or working!
    
    #exit ${errorresult}
#else
    #api operations status OK
    #Do something based on it being ready and working!
    
#fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED -11-16

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END Procedures:  Local Proceedures - Handle important basics
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Setup Login Parameters and Mgmt_CLI handler procedures
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# subHandleMgmtCLIPublish - publish changes if needed
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# subHandleMgmtCLIPublish - publish changes if needed
#

subHandleMgmtCLIPublish () {
    #
    # subHandleMgmtCLIPublish - publish changes if needed
    #
    
    # APICLIsessionerrorfile is created at login
    #export APICLIsessionerrorfile=id.`date +%Y%m%d-%H%M%S%Z`.err
    echo >> ${APICLIsessionerrorfile}
    echo 'mgmt_cli publish operation' >> ${APICLIsessionerrorfile}
    echo >> ${APICLIsessionerrorfile}
    
    if [ x"$script_use_publish" = x"true" ] ; then
        echo | tee -a -i ${logfilepath}
        echo 'Publish changes!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        mgmt_cli publish -s ${APICLIsessionfile} >> ${logfilepath} 2>> ${APICLIsessionerrorfile}
        EXITCODE=$?
        cat ${APICLIsessionerrorfile} >> ${logfilepath}
        
        echo | tee -a -i ${logfilepath}
    else
        echo | tee -a -i ${logfilepath}
        echo 'Nothing to Publish!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        EXITCODE=0
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# subHandleMgmtCLILogout - Logout from mgmt_cli, also cleanup session file
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Logout from mgmt_cli, also cleanup session file
#

subHandleMgmtCLILogout () {
    #
    # subHandleMgmtCLILogout - Logout from mgmt_cli, also cleanup session file
    #
    
    # APICLIsessionerrorfile is created at login
    #export APICLIsessionerrorfile=id.`date +%Y%m%d-%H%M%S%Z`.err
    echo >> ${APICLIsessionerrorfile}
    echo 'mgmt_cli logout operation' >> ${APICLIsessionerrorfile}
    echo >> ${APICLIsessionerrorfile}
    
    echo | tee -a -i ${logfilepath}
    echo 'Logout of mgmt_cli!  Then remove session file : '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    mgmt_cli logout -s ${APICLIsessionfile} >> ${logfilepath} 2>> ${APICLIsessionerrorfile}
    EXITCODE=$?
    cat ${APICLIsessionerrorfile} >> ${logfilepath}
    
    rm ${APICLIsessionfile} | tee -a -i ${logfilepath}
    rm ${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_ROOT_Login - Login to the API via mgmt_cli login using ROOT credentials
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-12-14 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_ROOT_Login () {
    #
    # Login to the API via mgmt_cli login using ROOT credentials
    #
    
    # Handle if ROOT User -r true parameter
    
    EXITCODE=0
    
    echo 'Login to mgmt_cli as root user -r true and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    # Handle management server parameter error if combined with ROOT User
    if [ x"${CLIparm_mgmt}" != x"" ] ; then
        echo | tee -a -i ${logfilepath}
        echo 'mgmt_cli parameter error!!!!' | tee -a -i ${logfilepath}
        echo 'ROOT User (-r true) parameter can not be combined with -m <Management_Server>!!!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 254
    fi
    
    export loginparmstring=' -r true'
    
    if [ x"${domaintarget}" != x"" ] ; then
        # Handle domain parameter for login string
        export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
        
        if ${APISCRIPTVERBOSE} ; then
            echo 'Execute login with loginparmstring "'${loginparmstring}'" As Root with Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
        else
            echo 'Execute login with loginparmstring "'${loginparmstring}'" As Root with Domain "'${domaintarget}'"' >> ${logfilepath}
            echo >> ${logfilepath}
        fi
        
        mgmt_cli login -r true domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
        EXITCODE=$?
        cat ${APICLIsessionerrorfile} >> ${logfilepath}
    else
        if ${APISCRIPTVERBOSE} ; then
            echo 'Execute login with loginparmstring "'${loginparmstring}'" As Root' | tee -a -i ${logfilepath}
            echo | tee -a -i ${logfilepath}
        else
            echo 'Execute login with loginparmstring "'${loginparmstring}'" As Root' >> ${logfilepath}
            echo >> ${logfilepath}
        fi
        
        mgmt_cli login -r true session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
        EXITCODE=$?
        cat ${APICLIsessionerrorfile} >> ${logfilepath}
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-12-14


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_API_KEY_Login - Login to the API via mgmt_cli login using api-key credentials
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-12-14 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_API_KEY_Login () {
    #
    # Login to the API via mgmt_cli login using api-key credentials
    #
    
    # Handle if --api-key parameter set
    
    EXITCODE=0
    
    echo 'Login to mgmt_cli with API key "'${CLIparm_api_key}'" and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    if [ x"${domaintarget}" != x"" ] ; then
        # Handle domain parameter for login string
        export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
        
        # Handle management server parameter for mgmt_cli parms
        if [ x"${CLIparm_mgmt}" != x"" ] ; then
            export mgmttarget='-m "'${CLIparm_mgmt}'"'
            
            if ${APISCRIPTVERBOSE} ; then
                echo 'Execute login using API key' | tee -a -i ${logfilepath}
                echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                echo | tee -a -i ${logfilepath}
            else
                echo 'Execute login using API key' >> ${logfilepath}
                echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                echo >> ${logfilepath}
            fi
            
            mgmt_cli login api-key "${CLIparm_api_key}" domain "${domaintarget}" -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
            EXITCODE=$?
            cat ${APICLIsessionerrorfile} >> ${logfilepath}
        else
            
            if ${APISCRIPTVERBOSE} ; then
                echo 'Execute login using API key to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                echo | tee -a -i ${logfilepath}
            else
                echo 'Execute login using API key to Domain "'${domaintarget}'"' >> ${logfilepath}
                echo >> ${logfilepath}
            fi
            
            mgmt_cli login api-key "${CLIparm_api_key}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
            EXITCODE=$?
            cat ${APICLIsessionerrorfile} >> ${logfilepath}
        fi
    else
        # Handle management server parameter for mgmt_cli parms
        if [ x"${CLIparm_mgmt}" != x"" ] ; then
            export mgmttarget='-m "'${CLIparm_mgmt}'"'
            
            if ${APISCRIPTVERBOSE} ; then
                echo 'Execute login using API key' | tee -a -i ${logfilepath}
                echo 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                echo | tee -a -i ${logfilepath}
            else
                echo 'Execute login using API key' >> ${logfilepath}
                echo 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                echo >> ${logfilepath}
            fi
            
            mgmt_cli login api-key "${CLIparm_api_key}" -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
            EXITCODE=$?
            cat ${APICLIsessionerrorfile} >> ${logfilepath}
        else
            
            if ${APISCRIPTVERBOSE} ; then
                echo 'Execute login using API key' | tee -a -i ${logfilepath}
                echo | tee -a -i ${logfilepath}
            else
                echo 'Execute login using API key' >> ${logfilepath}
                echo >> ${logfilepath}
            fi
            
            mgmt_cli login api-key "${CLIparm_api_key}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
            EXITCODE=$?
            cat ${APICLIsessionerrorfile} >> ${logfilepath}
        fi
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-12-14


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_User_Login - Login to the API via mgmt_cli login using User credentials
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-12-14 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_User_Login () {
    #
    # Login to the API via mgmt_cli login using User credentials
    #
    EXITCODE=0
    
    echo 'Login to mgmt_cli and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    if [ x"${CLIparm_password}" != x"" ] ; then
        # Handle password parameter
        export loginparmstring=${loginparmstring}' password "'${CLIparm_password}'"'
        
        if [ x"${domaintarget}" != x"" ] ; then
            # Handle domain parameter for login string
            export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
            
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain and Management' | tee -a -i ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain and Management' >> ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                mgmt_cli login user ${APICLIusername} password "${CLIparm_password}" domain "${domaintarget}" -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                mgmt_cli login user ${APICLIusername} password "${CLIparm_password}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Management' | tee -a -i ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Management' >> ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                mgmt_cli login user ${APICLIusername} password "${CLIparm_password}" -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                mgmt_cli login user ${APICLIusername} password "${CLIparm_password}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        fi
    else
        # Handle NO password parameter
        
        if [ x"${domaintarget}" != x"" ] ; then
            # Handle domain parameter for login string
            export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
            
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain and Management' | tee -a -i ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain and Management' >> ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                mgmt_cli login user ${APICLIusername} domain "${domaintarget}" -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                mgmt_cli login user ${APICLIusername} domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Management' | tee -a -i ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Management' >> ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                mgmt_cli login user ${APICLIusername} -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                mgmt_cli login user ${APICLIusername} session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        fi
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-12-14


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_Admin_User_Login - Login to the API via mgmt_cli login using Admin user credentials
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-12-14 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_Admin_User_Login () {
    #
    # Login to the API via mgmt_cli login using Admin user credentials
    #
    # Handle Admin User
    
    EXITCODE=0
    
    echo 'Login to mgmt_cli as '${APICLIadmin}' and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    if [ x"${APICLIadmin}" != x"" ] ; then
        export loginparmstring=${loginparmstring}" user ${APICLIadmin}"
    else
        echo | tee -a -i ${logfilepath}
        echo 'mgmt_cli parameter error!!!!' | tee -a -i ${logfilepath}
        echo 'Admin User variable not set!!!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 254
    fi
    
    if [ x"${CLIparm_password}" != x"" ] ; then
        # Handle password parameter
        export loginparmstring=${loginparmstring}' password "'${CLIparm_password}'"'
        
        if [ x"${domaintarget}" != x"" ] ; then
            # Handle domain parameter for login string
            export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
            
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain and Management' | tee -a -i ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain and Management' >> ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                mgmt_cli login user ${APICLIadmin} password "${CLIparm_password}" domain "${domaintarget}" -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                mgmt_cli login user ${APICLIadmin} password "${CLIparm_password}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Management' | tee -a -i ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Management' >> ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                mgmt_cli login user ${APICLIadmin} password "${CLIparm_password}" -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                mgmt_cli login user ${APICLIadmin} password "${CLIparm_password}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        fi
    else
        # Handle NO password parameter
        
        if [ x"${domaintarget}" != x"" ] ; then
            # Handle domain parameter for login string
            export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
            
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain and Management' | tee -a -i ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain and Management' >> ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                mgmt_cli login user ${APICLIadmin} domain "${domaintarget}" -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                mgmt_cli login user ${APICLIadmin} domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Management' | tee -a -i ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User with Management' >> ${logfilepath}
                    echo 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                mgmt_cli login user ${APICLIadmin} -m "${CLIparm_mgmt}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User' | tee -a -i ${logfilepath}
                    echo | tee -a -i ${logfilepath}
                else
                    echo 'Execute login with loginparmstring "'${loginparmstring}'" As User' >> ${logfilepath}
                    echo >> ${logfilepath}
                fi
                
                mgmt_cli login user ${APICLIadmin} session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        fi
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-12-14


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLILogin - Login to the API via mgmt_cli login
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Login to the API via mgmt_cli login
#

HandleMgmtCLILogin () {
    #
    # Login to the API via mgmt_cli login
    #
    
    EXITCODE=0
    
    export loginstring=
    export loginparmstring=
    
    # MODIFIED 2018-05-04 -
    export APICLIsessionerrorfile=id.`date +%Y%m%d-%H%M%S%Z`.err
    echo 'API CLI Session Error File : '${APICLIsessionerrorfile} >> ${APICLIsessionerrorfile}
    echo >> ${APICLIsessionerrorfile}
    echo 'mgmt_cli login operation' >> ${APICLIsessionerrorfile}
    echo >> ${APICLIsessionerrorfile}
    
    # MODIFIED 2018-05-03 -
    if [ ! -z "${CLIparm_sessionidfile}" ] ; then
        # CLIparm_sessionidfile value is set so use it
        export APICLIsessionfile=${CLIparm_sessionidfile}
    else
        # Updated to make session id file unique in case of multiple admins running script from same folder
        export APICLIsessionfile=id.`date +%Y%m%d-%H%M%S%Z`.txt
    fi
    
    # MODIFIED 2018-05-03 -
    export domainnamenospace=
    if [ ! -z "${domaintarget}" ] ; then
        # Handle domain name that might include space if the value is set
        #export domainnamenospace="$(echo -e "${domaintarget}" | tr -d '[:space:]')"
        #export domainnamenospace=$(echo -e ${domaintarget} | tr -d '[:space:]')
        export domainnamenospace=$(echo -e ${domaintarget} | tr ' ' '_')
    else
        export domainnamenospace=
    fi
    
    if [ ! -z "${domainnamenospace}" ] ; then
        # Handle domain name that might include space
        if [ ! -z "${CLIparm_sessionidfile}" ] ; then
            # adjust if CLIparm_sessionidfile was set, since that might be a complete path, append the path to it 
            export APICLIsessionfile=${APICLIsessionfile}.${domainnamenospace}
        else
            # assume the session file is set to a local file and prefix the domain to it
            export APICLIsessionfile=${domainnamenospace}.${APICLIsessionfile}
        fi
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo 'APICLIwebsslport  :  '${APICLIwebsslport} | tee -a -i ${logfilepath}
        echo 'APISessionTimeout :  '${APISessionTimeout} | tee -a -i ${logfilepath}
        echo 'Domain Target     :  '${domaintarget} | tee -a -i ${logfilepath}
        echo 'Domain no space   :  '${domainnamenospace} | tee -a -i ${logfilepath}
        echo 'APICLIsessionfile :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo 'APICLIwebsslport  :  '${APICLIwebsslport} >> ${logfilepath}
        echo 'APISessionTimeout :  '${APISessionTimeout} >> ${logfilepath}
        echo 'Domain Target     :  '${domaintarget} >> ${logfilepath}
        echo 'Domain no space   :  '${domainnamenospace} >> ${logfilepath}
        echo 'APICLIsessionfile :  '${APICLIsessionfile} >> ${logfilepath}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo 'mgmt_cli Login!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    if [ x"${CLIparm_rootuser}" = x"true" ] ; then
        # Handle if ROOT User -r true parameter
        
        HandleMgmtCLI_ROOT_Login
        EXITCODE=$?
        
        echo 'mgmt_cli login with ROOT credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    elif [ x"${CLIparm_api_key}" != x"" ] ; then
        # Handle if --api-key parameter set
        
        HandleMgmtCLI_API_KEY_Login
        EXITCODE=$?
        
        echo 'mgmt_cli login with api-key credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    elif [ x"${APICLIadmin}" != x"" ] ; then
        # Handle Admin User
        
        HandleMgmtCLI_Admin_User_Login
        EXITCODE=$?
        
        echo 'mgmt_cli login with Admin User credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    else
        # Handle User
        
        HandleMgmtCLI_User_Login
        EXITCODE=$?
        
        echo 'mgmt_cli login with User credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    fi
    
    if [ "${EXITCODE}" != "0" ] ; then
        
        echo | tee -a -i ${logfilepath}
        echo 'mgmt_cli login error!  EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        cat ${APICLIsessionfile} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 255
        
    else
        
        echo "mgmt_cli login success!" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        cat ${APICLIsessionfile} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# subSetupLogin2MgmtCLI - Setup Login to Management CLI
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

subSetupLogin2MgmtCLI () {
    #
    # setup the mgmt_cli login fundamentals
    #
    
    SUBEXITCODE=0
    
    #export APICLIwebsslport=${currentapisslport}
    
    if [ ! -z "${CLIparm_mgmt}" ] ; then
        # working with remote management server
        if ${APISCRIPTVERBOSE} ; then
            echo 'Working with remote management server' | tee -a -i ${logfilepath}
        fi
        
        # MODIFIED 2020-11-16 -
        # Stipulate that if running on the actual management host, use it's web ssl-port value
        # unless we're running with the management server setting CLIparm_mgmt, then use the
        # passed parameter from the CLI or default to 443
        #
        if ${APISCRIPTVERBOSE} ; then
            echo | tee -a -i ${logfilepath}
            echo 'Initial ${APICLIwebsslport}   = '${APICLIwebsslport} | tee -a -i ${logfilepath}
            echo 'Current ${CLIparm_websslport} = '${CLIparm_websslport} | tee -a -i ${logfilepath}
        else
            echo >> ${logfilepath}
            echo 'Initial ${APICLIwebsslport}   = '${APICLIwebsslport} >> ${logfilepath}
            echo 'Current ${CLIparm_websslport} = '${CLIparm_websslport} >> ${logfilepath}
        fi
        
        if [ ! -z "${CLIparm_websslport}" ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo 'Working with web ssl-port from CLI parms' | tee -a -i ${logfilepath}
            else
                echo 'Working with web ssl-port from CLI parms' >> ${logfilepath}
            fi
            export APICLIwebsslport=${CLIparm_websslport}
        else
            # Default back to expected SSL port, since we won't know what the remote management server configuration for web ssl-port is.
            # This may change once Gaia API is readily available and can be checked.
            if ${APISCRIPTVERBOSE} ; then
                echo 'Remote management cannot currently be queried for web ssl-port, so defaulting to 443.' | tee -a -i ${logfilepath}
                echo 'A login failure may indicate that remote management is NOT using web ssl-port 443 for the API!' | tee -a -i ${logfilepath}
            else
                echo 'Remote management cannot currently be queried for web ssl-port, so defaulting to 443.' >> ${logfilepath}
                echo 'A login failure may indicate that remote management is NOT using web ssl-port 443 for the API!' >> ${logfilepath}
            fi
            export APICLIwebsslport=443
        fi
    else
        # not working with remote management server
        if ${APISCRIPTVERBOSE} ; then
            echo 'Not working with remote management server' | tee -a -i ${logfilepath}
        else
            echo 'Not working with remote management server' >> ${logfilepath}
        fi
        
        # MODIFIED 2020-11-16 -
        # Stipulate that if running on the actual management host, use it's web ssl-port value
        # unless we're running with the management server setting CLIparm_mgmt, then use the
        # passed parameter from the CLI or default to 443
        #
        if ${APISCRIPTVERBOSE} ; then
            echo | tee -a -i ${logfilepath}
            echo 'Initial APICLIwebsslport   = '${APICLIwebsslport} | tee -a -i ${logfilepath}
            echo 'Current CLIparm_websslport = '${CLIparm_websslport} | tee -a -i ${logfilepath}
            echo 'Current currentapisslport  = '${currentapisslport} | tee -a -i ${logfilepath}
        else
            echo >> ${logfilepath}
            echo 'Initial APICLIwebsslport   = '${APICLIwebsslport} >> ${logfilepath}
            echo 'Current CLIparm_websslport = '${CLIparm_websslport} >> ${logfilepath}
            echo 'Current currentapisslport  = '${currentapisslport} >> ${logfilepath}
        fi
        
        if [ ! -z "${CLIparm_websslport}" ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo 'Working with web ssl-port from CLI parms' | tee -a -i ${logfilepath}
            else
                echo 'Working with web ssl-port from CLI parms' >> ${logfilepath}
            fi
            export APICLIwebsslport=${CLIparm_websslport}
        else
            if ${APISCRIPTVERBOSE} ; then
                echo 'Working with web ssl-port harvested from Gaia' | tee -a -i ${logfilepath}
            else
                echo 'Working with web ssl-port harvested from Gaia' >> ${logfilepath}
            fi
            export APICLIwebsslport=${currentapisslport}
        fi
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo 'Final APICLIwebsslport     = '${APICLIwebsslport} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        echo 'Final APICLIwebsslport     = '${APICLIwebsslport} >> ${logfilepath}
        echo >> ${logfilepath}
    fi
    # ADDED 2020-11-16 -
    # Handle login session-timeout parameter
    #
    
    export APISessionTimeout=600
    
    MinAPISessionTimeout=10
    MaxAPISessionTimeout=3600
    DefaultAPISessionTimeout=600
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo 'Initial ${APISessionTimeout}      = '${APISessionTimeout} | tee -a -i ${logfilepath}
        echo 'Current ${CLIparm_sessiontimeout} = '${CLIparm_sessiontimeout} | tee -a -i ${logfilepath}
    else
        echo | tee -a -i ${logfilepath}
        echo 'Initial ${APISessionTimeout}      = '${APISessionTimeout} >> ${logfilepath}
        echo 'Current ${CLIparm_sessiontimeout} = '${CLIparm_sessiontimeout} >> ${logfilepath}
    fi
    
    if [ ! -z ${CLIparm_sessiontimeout} ]; then
        # CLI Parameter for session-timeout was passed
        if [ ${CLIparm_sessiontimeout} -lt ${MinAPISessionTimeout} ] ||  [ ${CLIparm_sessiontimeout} -gt ${MaxAPISessionTimeout} ]; then
            # parameter is outside of range for MinAPISessionTimeout to MaxAPISessionTimeout
            echo 'Value of ${CLIparm_sessiontimeout} ('${CLIparm_sessiontimeout}') is out side of allowed range!' | tee -a -i ${logfilepath}
            echo 'Allowed session-timeout value range is '${MinAPISessionTimeout}' to '${MaxAPISessionTimeout} | tee -a -i ${logfilepath}
            echo 'Setting default session-timeout value '${DefaultAPISessionTimeout} | tee -a -i ${logfilepath}
            export APISessionTimeout=${DefaultAPISessionTimeout}
        else
            # parameter is within range for MinAPISessionTimeout to MaxAPISessionTimeout
            export APISessionTimeout=${CLIparm_sessiontimeout}
        fi
    else
        # CLI Parameter for session-timeout not set
        export APISessionTimeout=${DefaultAPISessionTimeout}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo | tee -a -i ${logfilepath}
        echo 'Final ${APISessionTimeout}       = '${APISessionTimeout} | tee -a -i ${logfilepath}
    else
        echo >> ${logfilepath}
        echo 'Final ${APISessionTimeout}       = '${APISessionTimeout} >> ${logfilepath}
    fi
    
    # MODIFIED 2020-12-14-
    #
    # Removed requirement to force using and admin user
    #
    
    if [ ! -z "${CLIparm_user}" ] ; then
        export APICLIadmin=${CLIparm_user}
    else
        export APICLIadmin=
    fi
    
    # Clear variables that need to be set later
    
    export mgmttarget=
    export domaintarget=
    
    return ${SUBEXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16

# -------------------------------------------------------------------------------------------------
# subLogin2MgmtCLI - Process Login to Management CLI
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

subLogin2MgmtCLI () {
    #
    # Execute the mgmt_cli login and address results
    #
    
    SUBEXITCODE=0
    
    HandleMgmtCLILogin
    SUBEXITCODE=$?
    
    if [ "${SUBEXITCODE}" != "0" ] ; then
        
        echo | tee -a -i ${logfilepath}
        echo "Terminating script..." | tee -a -i ${logfilepath}
        echo "Exitcode ${SUBEXITCODE}" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return ${SUBEXITCODE}
        
    else
        echo | tee -a -i ${logfilepath}
    fi
    
    return ${SUBEXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# MgmtCLIAPIOperationsInitialChecks - Handle the first call of this Management CLI API Handler
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Handle the first call of this Management CLI API Handler
#

MgmtCLIAPIOperationsInitialChecks () {
    #
    
    errorresult=0
    
    # -------------------------------------------------------------------------------------------------
    # Make sure API is up and running if we are doing API work
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2020-11-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    subCheckStatusOfAPI "$@"
    errorresult=$?
    
    if [ ${errorresult} -ne 0 ] ; then
        #api operations status NOT OK, so anything that is not a 0 result is a fail!
        #Do something based on it not being ready or working!
        
        echo "API Error!" | tee -a -i ${logfilepath}
        echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo 'Log output in file   : '"${logfilepath}" | tee -a -i ${logfilepath}
        
        return ${errorresult}
    else
        #api operations status OK
        #Do something based on it being ready and working!
        
        echo "API OK, proceeding!" >> ${logfilepath}
    fi
    
    GaiaWebSSLPortCheck
    
    export CheckAPIVersion=
    
    ScriptAPIVersionCheck
    errorresult=$?
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-19
    
    return ${errorresult}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-11


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Setup Login Parameters and Mgmt_CLI handler procedures
# =================================================================================================
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Management CLI API Operations Handler
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Handle the operational COMMAND send in CLI parameter 1 for this subscript call
# -------------------------------------------------------------------------------------------------

errorresult=0

export mcao_script_action=$1

if ${APISCRIPTVERBOSE} ; then
    echo | tee -a -i ${logfilepath}
    echo 'Management CLI API Operations Handler' | tee -a -i ${logfilepath}
    echo 'Action :  '${mcao_script_action} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
else
    echo >> ${logfilepath}
    echo 'Management CLI API Operations Handler' >> ${logfilepath}
    echo 'Action :  '${mcao_script_action} >> ${logfilepath}
    echo >> ${logfilepath}
fi

# Commands to execute specific actions in this script:
# CHECK |INIT - Initialize the API operations with checks of wether API is running, get port, API minimum version
# SETUPLOGIN  - Execute setup of API login based on CLI parameters passed and processed previously
# LOGIN       - Execute API login based on CLI parameters passed and processed previously
# PUBLISH     - Execute API publish based on previous login and session file
# LOGOUT      - Execute API logout based on previous login and session file
# APISTATUS   - Execute just the API Status check

case "${mcao_script_action}" in
    CHECK | INIT ) 
        # Handle Initial Check Of Handler
        MgmtCLIAPIOperationsInitialChecks "$@"
        errorresult=$?
        ;;
    SETUPLOGIN ) 
        # Handle Setup
        subSetupLogin2MgmtCLI "$@"
        errorresult=$?
        ;;
    LOGIN ) 
        # Handle Login
        subLogin2MgmtCLI "$@"
        errorresult=$?
        ;;
    PUBLISH ) 
        # Handle Publish
        subHandleMgmtCLIPublish "$@"
        errorresult=$?
        ;;
    LOGOUT ) 
        # Handle Logout
        subHandleMgmtCLILogout "$@"
        errorresult=$?
        ;;
    APISTATUS ) 
        # Handle API Status Check
        subCheckStatusOfAPI "$@"
        errorresult=$?
        ;;
    *)
        # Handle missing parameter
        errorresult=253
        
        echo | tee -a -i ${logfilepath}
        echo 'Management CLI API Operations Handler Critical Error, undefined action!!!' | tee -a -i ${logfilepath}
        echo 'Action :  '${mcao_script_action} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        ;;
esac


if ${APISCRIPTVERBOSE} ; then
    echo | tee -a -i ${logfilepath}
    echo 'Action :  '${mcao_script_action}'  Error Result :  '${errorresult} | tee -a -i ${logfilepath}
else
    echo >> ${logfilepath}
    echo 'Action :  '${mcao_script_action}'  Error Result :  '${errorresult} >> ${logfilepath}
fi


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Management CLI API Operations Handler
# =================================================================================================
# =================================================================================================


if ${APISCRIPTVERBOSE} ; then
    echo | tee -a -i ${logfilepath}
    echo 'API Subscript Completed :  '${APISubScriptName} | tee -a -i ${logfilepath}
else
    echo >> ${logfilepath}
    echo 'API Subscript Completed :  '${APISubScriptName} >> ${logfilepath}
fi


return ${errorresult}


# =================================================================================================
# END subscript:  Management CLI API Operations Handler
# =================================================================================================
# =================================================================================================


