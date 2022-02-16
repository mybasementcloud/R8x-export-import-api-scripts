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
# SCRIPT subscript for CLI Operations for management CLI API operations handling
#
#
ScriptVersion=00.60.08
ScriptRevision=065
ScriptDate=2022-02-15
TemplateVersion=00.60.08
APISubscriptsLevel=010
APISubscriptsVersion=00.60.08
APISubscriptsRevision=065

#

export APISubscriptsScriptVersion=v${ScriptVersion}
export APISubscriptsScriptTemplateVersion=v${TemplateVersion}

export APISubscriptsScriptVersionX=v${ScriptVersion//./x}
export APISubscriptsScriptTemplateVersionX=v${TemplateVersion//./x}

APISubScriptName=mgmt_cli_api_operations.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}
export APISubScriptFileNameRoot=mgmt_cli_api_operations.subscript.common
export APISubScriptShortName=mgmt_cli_api_operations
export APISubScriptnohupName=${APISubScriptShortName}
export APISubScriptDescription="Subscript for CLI Operations for management CLI API operations handling"


# =================================================================================================
# =================================================================================================
# START subscript:  Management CLI API Operations Handler
# =================================================================================================


if ${SCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'APISubScriptName:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'APISubScriptName:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} >> ${logfilepath}
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


# MODIFIED 2021-11-09 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GaiaWebSSLPortCheck - Check local Gaia Web SSL Port configuration for local operations
#

GaiaWebSSLPortCheck () {
    
    if ${AuthenticationMaaS} ; then
        # MaaS (Smart-1 Cloud) operation is via standard HTTPS/SSL so always port 443
        export currentapisslport=443
    elif [ ! -z "${CLIparm_mgmt}" ] ; then
        # Remote management server operation stipulates standard HTTPS/SSL so always port 443
        export currentapisslport=443
    else
        # Not working MaaS so will check locally for Gaia web SSL port setting
        # Removing dependency on clish to avoid collissions when database is locked
        #
        #export currentapisslport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
        #
        export pythonpath=${MDS_FWDIR}/Python/bin/
        export get_api_local_port=`${pythonpath}/python ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
        export api_local_port=${get_api_local_port//\"/}
        export currentapisslport=${api_local_port}
    fi
    
    if ${SCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Current Gaia web ssl-port : '${currentapisslport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Current Gaia web ssl-port : '${currentapisslport} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-11-09


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#GaiaWebSSLPortCheck

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ScriptAPIVersionCheck - Check version of the script to ensure it is able to operate at minimum expected
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-11-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# ScriptAPIVersionCheck - Check version of the script to ensure it is able to operate at minimum 
# expected to correctly execute.
#

ScriptAPIVersionCheck () {
    
    SetupTempLogFile
    
    if ${AuthenticationMaaS} ; then
        # Working with MaaS (Smart-1 Cloud) so normal checks won't work, do something to compensate
        GetAPIVersion=${MaxMaaSAPIVersion}
        export CheckAPIVersion=${GetAPIVersion}
        CurrentAPIVersion=${CheckAPIVersion}
    else
        # Not working with MaaS (Smart-1 Cloud) so normal checks are required
        GetAPIVersion=$(mgmt_cli show api-versions -r true -f json --port ${currentapisslport} | ${JQ} '.["current-version"]' -r)
        export CheckAPIVersion=${GetAPIVersion}
        
        if [ ${CheckAPIVersion} = null ] ; then
            # show api-versions does not exist in version 1.0, so it fails and returns null
            CurrentAPIVersion=1.0
        else
            CurrentAPIVersion=${CheckAPIVersion}
        fi
        
    fi
    
    export addversion2keepalive=false
    if [ $(expr ${CurrentAPIVersion} '<=' 1.5) ] ; then
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=true
    else
        # API is version that requires --version ${CurrentAPIVersion} extension
        export addversion2keepalive=false
    fi
    
    if ${AuthenticationMaaS} ; then
        echo `${dtzs}`${dtzsep} 'MaaS presumtive API version = '${CurrentAPIVersion} >> ${subscriptstemplogfilepath}
    else
        echo `${dtzs}`${dtzsep} 'API version = '${CurrentAPIVersion} >> ${subscriptstemplogfilepath}
    fi
    
    if [ $(expr ${MinAPIVersionRequired} '<=' ${CurrentAPIVersion}) ] ; then
        # API is sufficient version
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} 'Current API Version ('${CurrentAPIVersion}') meets the minimum API version expected requirement ('${MinAPIVersionRequired}')' >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        
        HandleShowTempLogFile
        
    else
        # API is not of a sufficient version to operate
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} 'Current API Version ('${CurrentAPIVersion}') does not meet minimum API version expected requirement ('${MinAPIVersionRequired}')' >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} '! termination execution !' >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        
        ForceShowTempLogFile
        
        return 250
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-09


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# subCheckStatusOfAPI - repeated proceedure
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-11-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
    echo `${dtzs}`${dtzsep} 'Check API Operational Status before starting' >> ${subscriptstemplogfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
    echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
    
    if ${AuthenticationMaaS} ; then
        # MaaS (Smart-1 Cloud) api operations status is expected to be OK, since we can't check before hand, until we authenticate
        echo `${dtzs}`${dtzsep} "MaaS (Smart-1 Cloud) operations, so stipulate all is OK with the API" | tee -a -i ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} "API is operating as expected so API calls should work!" | tee -a -i ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} "Current Log output in file ${subscriptstemplogfilepath}" | tee -a -i ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${subscriptstemplogfilepath}
    else
        
        export pythonpath=${MDS_FWDIR}/Python/bin/
        export get_api_local_port=`${pythonpath}/python ${MDS_FWDIR}/scripts/api_get_port.py -f json | ${JQ} '. | .external_port'`
        export api_local_port=${get_api_local_port//\"/}
        export currentapisslport=${api_local_port}
        
        echo `${dtzs}`${dtzsep} 'First make sure we do not have any issues:' >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        
        echo `${dtzs}`${dtzsep} 'System Version according to mgmt_cli: ' >> ${subscriptstemplogfilepath}
        echo '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
        echo >> ${subscriptstemplogfilepath}
        
        mgmt_cli -r true show version --port ${currentapisslport} >> ${subscriptstemplogfilepath}
        errorresult=$?
        
        echo '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
        
        if [ ${errorresult} -ne 0 ] ; then
            #api operation NOT OK, so anything that is not a 0 result is a fail!
            echo `${dtzs}`${dtzsep} "API is not operating as expected so API calls will probably fail!" >> ${subscriptstemplogfilepath}
            echo `${dtzs}`${dtzsep} 'Still executing api status for additional details' >> ${subscriptstemplogfilepath}
        else
            #api operations status OK
            echo `${dtzs}`${dtzsep} "API is operating as expected so api status should work as expected!" >> ${subscriptstemplogfilepath}
        fi
        
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} 'API Versions according to mgmt_cli: ' >> ${subscriptstemplogfilepath}
        echo '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
        echo >> ${subscriptstemplogfilepath}
        
        mgmt_cli -r true show api-versions --port ${currentapisslport} >> ${subscriptstemplogfilepath}
        errorresult=$?
        
        echo '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
        
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} 'Next check api status:' >> ${subscriptstemplogfilepath}
        
        echo '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
        
        # Execute the API check with api status to a temporary log file, since tee throws off the results of error checking
        api status >> ${subscriptstemplogfilepath}
        errorresult=$?
        
        echo '-------------------------------------------------------------------------------------------------' >> ${subscriptstemplogfilepath}
        
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} 'API status check result ( 0 = OK ) : '${errorresult} >> ${subscriptstemplogfilepath}
        echo `${dtzs}`${dtzsep} >> ${subscriptstemplogfilepath}
        
        if [ ${errorresult} -ne 0 ] ; then
            #api operations status NOT OK, so anything that is not a 0 result is a fail!
            echo `${dtzs}`${dtzsep} "API is not operating as expected so API calls will probably fail!" | tee -a -i ${subscriptstemplogfilepath}
            echo `${dtzs}`${dtzsep} 'Critical Error '${errorresult}'- Exiting Script !!!!' | tee -a -i ${subscriptstemplogfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${subscriptstemplogfilepath}
            echo `${dtzs}`${dtzsep} "Log output in file ${subscriptstemplogfilepath}" | tee -a -i ${subscriptstemplogfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${subscriptstemplogfilepath}
        else
            #api operations status OK
            echo `${dtzs}`${dtzsep} "API is operating as expected so API calls should work!" | tee -a -i ${subscriptstemplogfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${subscriptstemplogfilepath}
            echo `${dtzs}`${dtzsep} "Current Log output in file ${subscriptstemplogfilepath}" | tee -a -i ${subscriptstemplogfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${subscriptstemplogfilepath}
        fi
    fi
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' | tee -a -i ${subscriptstemplogfilepath}
    
    HandleShowTempLogFile
    
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
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-09

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
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    # APICLIsessionerrorfile is created at login
    #export APICLIsessionerrorfile=id.`date +%Y%m%d-%H%M%S%Z`.err
    echo `${dtzs}`${dtzsep} >> ${APICLIsessionerrorfile}
    echo `${dtzs}`${dtzsep} 'mgmt_cli publish operation' >> ${APICLIsessionerrorfile}
    echo `${dtzs}`${dtzsep} >> ${APICLIsessionerrorfile}
    
    if [ x"$script_use_publish" = x"true" ] ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Publish changes!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        mgmt_cli publish -s ${APICLIsessionfile} >> ${logfilepath} 2>> ${APICLIsessionerrorfile}
        EXITCODE=$?
        cat ${APICLIsessionerrorfile} >> ${logfilepath}
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Nothing to Publish!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        EXITCODE=0
    fi
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
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
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    # APICLIsessionerrorfile is created at login
    #export APICLIsessionerrorfile=id.`date +%Y%m%d-%H%M%S%Z`.err
    echo `${dtzs}`${dtzsep} >> ${APICLIsessionerrorfile}
    echo `${dtzs}`${dtzsep} 'mgmt_cli logout operation' >> ${APICLIsessionerrorfile}
    echo `${dtzs}`${dtzsep} >> ${APICLIsessionerrorfile}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Logout of mgmt_cli!  Then remove session file : '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    mgmt_cli logout -s ${APICLIsessionfile} >> ${logfilepath} 2>> ${APICLIsessionerrorfile}
    EXITCODE=$?
    cat ${APICLIsessionerrorfile} >> ${logfilepath}
    
    rm ${APICLIsessionfile} | tee -a -i ${logfilepath}
    rm ${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_MaaS_Login - Login to the API via mgmt_cli login on MaaS (Smart-1 Cloud) using required credential elements
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-11-10 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_MaaS_Login () {
    #
    # Login to the API via mgmt_cli login on MaaS (Smart-1 Cloud) using required credential elements
    #
    
    # Handle if --api-key parameter set
    
    EXITCODE=0
    
    #printf "`${dtzs}`${dtzsep}""%-35s : %s\n" "x" ${x} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Login to mgmt_cli for MaaS Authentication with all required parameters and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}"" - %-25s : %s\n" "Management Server" ${CLIparm_mgmt} | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}"" - %-25s : %s\n" "Domain" ${domaintarget} | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}"" - %-25s : %s\n" "API Context" ${CLIparm_api_context} | tee -a -i ${logfilepath}
    printf "`${dtzs}`${dtzsep}"" - %-25s : %s\n" "API Key" ${CLIparm_api_key} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if ${AuthenticationMaaS} ; then
        # Handle domain parameter for login string
        export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
        
        # Handle management server parameter for mgmt_cli parms
        export mgmttarget='-m "'${CLIparm_mgmt}'"'
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Execute login using API key' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Execute operations with api context "'${CLIparm_api_context} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Execute operations with api key "'${CLIparm_api_key} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Execute login using API key' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Execute operations with api context "'${CLIparm_api_context}'"' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Execute operations with api key "'${CLIparm_api_key}'"' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
        fi
        
        #echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' -d '\"${domaintarget}\"' --context '\"${CLIparm_api_context}\"' login api-key '\"${CLIparm_api_key}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
        
        #mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" -d "${domaintarget}" --context "${CLIparm_api_context}" login api-key "${CLIparm_api_key}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
        #EXITCODE=$?
        
        echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' -d '\"${domaintarget}\"' --context '\"${CLIparm_api_context}\"' login api-key '\'${CLIparm_api_key}\'' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
        
        mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" -d "${domaintarget}" --context "${CLIparm_api_context}" login api-key \'${CLIparm_api_key}\' session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
        EXITCODE=$?
        
        cat ${APICLIsessionerrorfile} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'MaaS Authentication executed!  Exit with EXITCODE = '${EXITCODE}'!' | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'MaaS Authentication is not set, so why are we here?!!!!  Exit!' | tee -a -i ${logfilepath}
        EXITCODE=255
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-10


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_ROOT_Login - Login to the API via mgmt_cli login using ROOT credentials
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-11-10 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_ROOT_Login () {
    #
    # Login to the API via mgmt_cli login using ROOT credentials
    #
    
    # Handle if ROOT User -r true parameter
    
    EXITCODE=0
    
    echo `${dtzs}`${dtzsep} 'Login to mgmt_cli as root user -r true and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    # Handle management server parameter error if combined with ROOT User
    if [ x"${CLIparm_mgmt}" != x"" ] ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'mgmt_cli parameter error!!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'ROOT User (-r true) parameter can not be combined with -m <Management_Server>!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        return 254
    fi
    
    export loginparmstring=' -r true'
    
    if [ x"${domaintarget}" != x"" ] ; then
        # Handle domain parameter for login string
        export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
        
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As Root with Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As Root with Domain "'${domaintarget}'"' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
        fi
        
        echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login -r true domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
        
        mgmt_cli login -r true domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
        EXITCODE=$?
        cat ${APICLIsessionerrorfile} >> ${logfilepath}
    else
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As Root' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As Root' >> ${logfilepath}
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
        fi
        
        echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login -r true session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
        
        mgmt_cli login -r true session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
        EXITCODE=$?
        cat ${APICLIsessionerrorfile} >> ${logfilepath}
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-10


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_API_KEY_Login - Login to the API via mgmt_cli login using api-key credentials
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-11-10 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_API_KEY_Login () {
    #
    # Login to the API via mgmt_cli login using api-key credentials
    #
    
    # Handle if --api-key parameter set
    
    EXITCODE=0
    
    echo `${dtzs}`${dtzsep} 'Login to mgmt_cli with API key "'${CLIparm_api_key}'" and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ x"${domaintarget}" != x"" ] ; then
        # Handle domain parameter for login string
        export loginparmstring=${loginparmstring}' domain "'${domaintarget}'"'
        
        # Handle management server parameter for mgmt_cli parms
        if [ x"${CLIparm_mgmt}" != x"" ] ; then
            export mgmttarget='-m "'${CLIparm_mgmt}'"'
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Execute login using API key' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Execute login using API key' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
            fi
            
            if ! ${CLIparm_use_api_context} ; then
                # Not using --context value
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login api-key '\"${CLIparm_api_key}\"' domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login api-key "${CLIparm_api_key}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
            else
                # Using --context value
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute operations with api context "'${CLIparm_api_context} | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute operations with api context "'${CLIparm_api_context} >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' --context '\"${CLIparm_api_context}\"' login api-key '\"${CLIparm_api_key}\"' domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" -d "${domaintarget}" --context "${CLIparm_api_context}" login api-key "${CLIparm_api_key}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
            fi
            
        else
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Execute login using API key to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Execute login using API key to Domain "'${domaintarget}'"' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
            fi
            
            echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login api-key '\"${CLIparm_api_key}\"' domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
            
            mgmt_cli login api-key "${CLIparm_api_key}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
            EXITCODE=$?
            cat ${APICLIsessionerrorfile} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
        fi
    else
        # Handle management server parameter for mgmt_cli parms
        if [ x"${CLIparm_mgmt}" != x"" ] ; then
            export mgmttarget='-m "'${CLIparm_mgmt}'"'
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Execute login using API key' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Execute login using API key' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
            fi
            
            echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login api-key '\"${CLIparm_api_key}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
            
            mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login api-key "${CLIparm_api_key}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
            EXITCODE=$?
            cat ${APICLIsessionerrorfile} >> ${logfilepath}
        else
            
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Execute login using API key' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Execute login using API key' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} >> ${logfilepath}
            fi
            
            echo `${dtzs}`${dtzsep} 'COMMAND :  login api-key '\"${CLIparm_api_key}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
            
            mgmt_cli login api-key "${CLIparm_api_key}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
            EXITCODE=$?
            cat ${APICLIsessionerrorfile} >> ${logfilepath}
        fi
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-10


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_User_Login - Login to the API via mgmt_cli login using User credentials
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-11-10 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_User_Login () {
    #
    # Login to the API via mgmt_cli login using User credentials
    #
    EXITCODE=0
    
    echo `${dtzs}`${dtzsep} 'Login to mgmt_cli and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
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
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain and Management' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain and Management' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login user '\"${APICLIusername}\"' password *** domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login user ${APICLIusername} password "${CLIparm_password}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login user '\"${APICLIusername}\"' password *** domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli login user ${APICLIusername} password "${CLIparm_password}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Management' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Management' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login user '\"${APICLIusername}\"' password *** session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login user ${APICLIusername} password "${CLIparm_password}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login user '\"${APICLIusername}\"' password *** session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
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
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain and Management' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain and Management' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login user '\"${APICLIusername}\"' domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login user ${APICLIusername} domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login user '\"${APICLIusername}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli login user ${APICLIusername} domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Management' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Management' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login user '\"${APICLIusername}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login user ${APICLIusername} session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                read -p "Username: " APICLIusername
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login user '\"${APICLIusername}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli login user ${APICLIusername} session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        fi
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-10


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleMgmtCLI_Admin_User_Login - Login to the API via mgmt_cli login using Admin user credentials
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-11-10 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleMgmtCLI_Admin_User_Login () {
    #
    # Login to the API via mgmt_cli login using Admin user credentials
    #
    # Handle Admin User
    
    EXITCODE=0
    
    echo `${dtzs}`${dtzsep} 'Login to mgmt_cli as '${APICLIadmin}' and save to session file :  '${APICLIsessionfile} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if [ x"${APICLIadmin}" != x"" ] ; then
        export loginparmstring=${loginparmstring}" user ${APICLIadmin}"
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'mgmt_cli parameter error!!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Admin User variable not set!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
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
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain and Management' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain and Management' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login user '\"${APICLIadmin}\"' password *** domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login user ${APICLIadmin} password "${CLIparm_password}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login user '\"${APICLIadmin}\"' password *** domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli login user ${APICLIadmin} password "${CLIparm_password}" domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Management' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password and Management' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login user '\"${APICLIadmin}\"' password *** session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login user ${APICLIadmin} password "${CLIparm_password}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Password' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login user '\"${APICLIadmin}\"' password *** session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
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
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain and Management' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain and Management' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'" to Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login user '\"${APICLIadmin}\"' domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login user ${APICLIadmin} domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain "'${domaintarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Domain "'${domaintarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login user '\"${APICLIadmin}\"' domain '\"${domaintarget}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli login user ${APICLIadmin} domain "${domaintarget}" session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        else
            # Handle management server parameter for mgmt_cli parms
            if [ x"${CLIparm_mgmt}" != x"" ] ; then
                export mgmttarget='-m "'${CLIparm_mgmt}'"'
                
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Management' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User with Management' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} 'Execute operations with mgmttarget "'${mgmttarget}'"' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli --unsafe-auto-accept true -m '\"${CLIparm_mgmt}\"' login user '\"${APICLIadmin}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli --unsafe-auto-accept true -m "${CLIparm_mgmt}" login user ${APICLIadmin} session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            else
                if ${APISCRIPTVERBOSE} ; then
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User' | tee -a -i ${logfilepath}
                    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
                else
                    echo `${dtzs}`${dtzsep} 'Execute login with loginparmstring "'${loginparmstring}'" As User' >> ${logfilepath}
                    echo `${dtzs}`${dtzsep} >> ${logfilepath}
                fi
                
                echo `${dtzs}`${dtzsep} 'COMMAND :  mgmt_cli login user '\"${APICLIadmin}\"' session-timeout '${APISessionTimeout}' --port '${APICLIwebsslport}' -f json > '${APICLIsessionfile}' 2>> '${APICLIsessionerrorfile} | tee -a -i ${logfilepath}
                
                mgmt_cli login user ${APICLIadmin} session-timeout ${APISessionTimeout} --port ${APICLIwebsslport} -f json > ${APICLIsessionfile} 2>> ${APICLIsessionerrorfile}
                EXITCODE=$?
                cat ${APICLIsessionerrorfile} >> ${logfilepath}
            fi
        fi
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-10


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
    echo `${dtzs}`${dtzsep} 'API CLI Session Error File : '${APICLIsessionerrorfile} >> ${APICLIsessionerrorfile}
    echo `${dtzs}`${dtzsep} >> ${APICLIsessionerrorfile}
    echo `${dtzs}`${dtzsep} 'mgmt_cli login operation' >> ${APICLIsessionerrorfile}
    echo `${dtzs}`${dtzsep} >> ${APICLIsessionerrorfile}
    
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
        # Single Line entries
        #printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "x" ${x} | tee -a -i ${logfilepath}
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIwebsslport" ${APICLIwebsslport} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APISessionTimeout" ${APISessionTimeout} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Domain Target" ${domaintarget} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Domain no space" ${domainnamenospace} | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIsessionfile" ${APICLIsessionfile} | tee -a -i ${logfilepath}
    else
        # Single Line entries
        #printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "x" ${x} >> ${logfilepath}
        
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIwebsslport" ${APICLIwebsslport} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APISessionTimeout" ${APISessionTimeout} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Domain Target" ${domaintarget} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "Domain no space" ${domainnamenospace} >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}"'variable :  %-25s = %s\n' "APICLIsessionfile" ${APICLIsessionfile} >> ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'mgmt_cli Login!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    if ${AuthenticationMaaS} ; then
        # Handle if --MaaS parameter set
        
        HandleMgmtCLI_MaaS_Login
        EXITCODE=$?
        
        echo `${dtzs}`${dtzsep} 'mgmt_cli login with MaaS credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    elif [ x"${CLIparm_rootuser}" = x"true" ] ; then
        # Handle if ROOT User -r true parameter
        
        HandleMgmtCLI_ROOT_Login
        EXITCODE=$?
        
        echo `${dtzs}`${dtzsep} 'mgmt_cli login with ROOT credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    elif [ x"${CLIparm_api_key}" != x"" ] ; then
        # Handle if --api-key parameter set
        
        HandleMgmtCLI_API_KEY_Login
        EXITCODE=$?
        
        echo `${dtzs}`${dtzsep} 'mgmt_cli login with api-key credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    elif [ x"${APICLIadmin}" != x"" ] ; then
        # Handle Admin User
        
        HandleMgmtCLI_Admin_User_Login
        EXITCODE=$?
        
        echo `${dtzs}`${dtzsep} 'mgmt_cli login with Admin User credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    else
        # Handle User
        
        HandleMgmtCLI_User_Login
        EXITCODE=$?
        
        echo `${dtzs}`${dtzsep} 'mgmt_cli login with User credentials result : EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        
    fi
    
    if [ "${EXITCODE}" != "0" ] ; then
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'mgmt_cli login error!  EXITCODE = '${EXITCODE} | tee -a -i ${logfilepath}
        echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo  | tee -a -i ${logfilepath}
        cat ${APICLIsessionfile} | tee -a -i ${logfilepath}
        echo  | tee -a -i ${logfilepath}
        echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        return 255
        
    else
        
        echo `${dtzs}`${dtzsep} "mgmt_cli login success!" | tee -a -i ${logfilepath}
        echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        echo  | tee -a -i ${logfilepath}
        cat ${APICLIsessionfile} | tee -a -i ${logfilepath}
        echo  | tee -a -i ${logfilepath}
        echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
        
    fi
    
    return ${EXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# subSetupLogin2MgmtCLI - Setup Login to Management CLI
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-11-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

subSetupLogin2MgmtCLI () {
    #
    # setup the mgmt_cli login fundamentals
    #
    
    SUBEXITCODE=0
    
    #export APICLIwebsslport=${currentapisslport}
    
    if ${AuthenticationMaaS} ; then
        # MaaS (Smart-1 Cloud) operation is via standard HTTPS/SSL so always port 443
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Working with Maas (Smart-1 Cloud) management server' | tee -a -i ${logfilepath}
        fi
        
        # MODIFIED 2020-11-16 -
        # Stipulate that if running on the actual management host, use it's web ssl-port value
        # unless we're running with the management server setting CLIparm_mgmt, then use the
        # passed parameter from the CLI or default to 443
        #
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Initial ${APICLIwebsslport}   = '${APICLIwebsslport} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Current ${CLIparm_websslport} = '${CLIparm_websslport} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Initial ${APICLIwebsslport}   = '${APICLIwebsslport} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Current ${CLIparm_websslport} = '${CLIparm_websslport} >> ${logfilepath}
        fi
        
        if [ ! -z "${CLIparm_websslport}" ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Working with web ssl-port from CLI parms, this may break authentication due to wrong port' | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Working with web ssl-port from CLI parms, this may break authentication due to wrong port' >> ${logfilepath}
            fi
            export APICLIwebsslport=${CLIparm_websslport}
        else
            # Default back to expected SSL port, since we won't know what the remote management server configuration for web ssl-port is.
            # This may change once Gaia API is readily available and can be checked.
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Maas (Smart-1 Cloud) management server cannot currently be queried for web ssl-port, so defaulting to 443.' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'A login failure may indicate that Maas (Smart-1 Cloud) management server is NOT using web ssl-port 443 for the API!' | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Maas (Smart-1 Cloud) management server cannot currently be queried for web ssl-port, so defaulting to 443.' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} 'A login failure may indicate that Maas (Smart-1 Cloud) management server is NOT using web ssl-port 443 for the API!' >> ${logfilepath}
            fi
            export APICLIwebsslport=443
        fi
    elif [ ! -z "${CLIparm_mgmt}" ] ; then
        # working with remote management server
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Working with remote management server' | tee -a -i ${logfilepath}
        fi
        
        # MODIFIED 2020-11-16 -
        # Stipulate that if running on the actual management host, use it's web ssl-port value
        # unless we're running with the management server setting CLIparm_mgmt, then use the
        # passed parameter from the CLI or default to 443
        #
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Initial ${APICLIwebsslport}   = '${APICLIwebsslport} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Current ${CLIparm_websslport} = '${CLIparm_websslport} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Initial ${APICLIwebsslport}   = '${APICLIwebsslport} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Current ${CLIparm_websslport} = '${CLIparm_websslport} >> ${logfilepath}
        fi
        
        if [ ! -z "${CLIparm_websslport}" ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Working with web ssl-port from CLI parms' | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Working with web ssl-port from CLI parms' >> ${logfilepath}
            fi
            export APICLIwebsslport=${CLIparm_websslport}
        else
            # Default back to expected SSL port, since we won't know what the remote management server configuration for web ssl-port is.
            # This may change once Gaia API is readily available and can be checked.
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Remote management cannot currently be queried for web ssl-port, so defaulting to 443.' | tee -a -i ${logfilepath}
                echo `${dtzs}`${dtzsep} 'A login failure may indicate that remote management is NOT using web ssl-port 443 for the API!' | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Remote management cannot currently be queried for web ssl-port, so defaulting to 443.' >> ${logfilepath}
                echo `${dtzs}`${dtzsep} 'A login failure may indicate that remote management is NOT using web ssl-port 443 for the API!' >> ${logfilepath}
            fi
            export APICLIwebsslport=443
        fi
    else
        # not working with remote management server
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} 'Not working with remote management server' | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} 'Not working with remote management server' >> ${logfilepath}
        fi
        
        # MODIFIED 2020-11-16 -
        # Stipulate that if running on the actual management host, use it's web ssl-port value
        # unless we're running with the management server setting CLIparm_mgmt, then use the
        # passed parameter from the CLI or default to 443
        #
        if ${APISCRIPTVERBOSE} ; then
            echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Initial APICLIwebsslport   = '${APICLIwebsslport} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Current CLIparm_websslport = '${CLIparm_websslport} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Current currentapisslport  = '${currentapisslport} | tee -a -i ${logfilepath}
        else
            echo `${dtzs}`${dtzsep} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Initial APICLIwebsslport   = '${APICLIwebsslport} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Current CLIparm_websslport = '${CLIparm_websslport} >> ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Current currentapisslport  = '${currentapisslport} >> ${logfilepath}
        fi
        
        if [ ! -z "${CLIparm_websslport}" ] ; then
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Working with web ssl-port from CLI parms' | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Working with web ssl-port from CLI parms' >> ${logfilepath}
            fi
            export APICLIwebsslport=${CLIparm_websslport}
        else
            if ${APISCRIPTVERBOSE} ; then
                echo `${dtzs}`${dtzsep} 'Working with web ssl-port harvested from Gaia' | tee -a -i ${logfilepath}
            else
                echo `${dtzs}`${dtzsep} 'Working with web ssl-port harvested from Gaia' >> ${logfilepath}
            fi
            export APICLIwebsslport=${currentapisslport}
        fi
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Final APICLIwebsslport     = '${APICLIwebsslport} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} 'Final APICLIwebsslport     = '${APICLIwebsslport} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
    fi
    # ADDED 2020-11-16 -
    # Handle login session-timeout parameter
    #
    
    export APISessionTimeout=600
    
    MinAPISessionTimeout=10
    MaxAPISessionTimeout=3600
    #DefaultAPISessionTimeout=600
    DefaultAPISessionTimeout=1800
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Initial ${APISessionTimeout}      = '${APISessionTimeout} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Current ${CLIparm_sessiontimeout} = '${CLIparm_sessiontimeout} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Initial ${APISessionTimeout}      = '${APISessionTimeout} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Current ${CLIparm_sessiontimeout} = '${CLIparm_sessiontimeout} >> ${logfilepath}
    fi
    
    if [ ! -z ${CLIparm_sessiontimeout} ]; then
        # CLI Parameter for session-timeout was passed
        if [ ${CLIparm_sessiontimeout} -lt ${MinAPISessionTimeout} ] ||  [ ${CLIparm_sessiontimeout} -gt ${MaxAPISessionTimeout} ]; then
            # parameter is outside of range for MinAPISessionTimeout to MaxAPISessionTimeout
            echo `${dtzs}`${dtzsep} 'Value of ${CLIparm_sessiontimeout} ('${CLIparm_sessiontimeout}') is out side of allowed range!' | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Allowed session-timeout value range is '${MinAPISessionTimeout}' to '${MaxAPISessionTimeout} | tee -a -i ${logfilepath}
            echo `${dtzs}`${dtzsep} 'Setting default session-timeout value '${DefaultAPISessionTimeout} | tee -a -i ${logfilepath}
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
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Final ${APISessionTimeout}       = '${APISessionTimeout} | tee -a -i ${logfilepath}
    else
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Final ${APISessionTimeout}       = '${APISessionTimeout} >> ${logfilepath}
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
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-09

# -------------------------------------------------------------------------------------------------
# subLogin2MgmtCLI - Process Login to Management CLI
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

subLogin2MgmtCLI () {
    #
    # Execute the mgmt_cli login and address results
    #
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    SUBEXITCODE=0
    
    HandleMgmtCLILogin
    SUBEXITCODE=$?
    
    if [ "${SUBEXITCODE}" != "0" ] ; then
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Terminating script..." | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Exitcode ${SUBEXITCODE}" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        #return ${SUBEXITCODE}
        
    else
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    fi
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    return ${SUBEXITCODE}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# MgmtCLIAPIOperationsInitialChecks - Handle the first call of this Management CLI API Handler
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-10-25 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
    
    # MODIFIED 2021-10-25 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
    #
    
    subCheckStatusOfAPI "$@"
    errorresult=$?
    
    if [ ${errorresult} -ne 0 ] ; then
        #api operations status NOT OK, so anything that is not a 0 result is a fail!
        #Do something based on it not being ready or working!
        
        echo `${dtzs}`${dtzsep} "API Error!" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Log output in file   : '"${logfilepath}" | tee -a -i ${logfilepath}
        
        return ${errorresult}
    else
        #api operations status OK
        #Do something based on it being ready and working!
        
        echo `${dtzs}`${dtzsep} "API OK, proceeding!" >> ${logfilepath}
    fi
    
    GaiaWebSSLPortCheck
    
    export CheckAPIVersion=
    export addversion2keepalive=false
    
    ScriptAPIVersionCheck
    errorresult=$?
    
    #
    # /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-10-25
    
    return ${errorresult}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-10-25


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
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Management CLI API Operations Handler' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Action :  '${mcao_script_action} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Management CLI API Operations Handler' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Action :  '${mcao_script_action} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
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
        
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Management CLI API Operations Handler Critical Error, undefined action!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Action :  '${mcao_script_action} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        ;;
esac


if ${APISCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Action :  '${mcao_script_action}'  Error Result :  '${errorresult} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Action :  '${mcao_script_action}'  Error Result :  '${errorresult} >> ${logfilepath}
fi


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Management CLI API Operations Handler
# =================================================================================================
# =================================================================================================


if ${APISCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'API Subscript Completed :  '${APISubScriptName} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'API Subscript Completed :  '${APISubScriptName} >> ${logfilepath}
fi


return ${errorresult}


# =================================================================================================
# END subscript:  Management CLI API Operations Handler
# =================================================================================================
# =================================================================================================


