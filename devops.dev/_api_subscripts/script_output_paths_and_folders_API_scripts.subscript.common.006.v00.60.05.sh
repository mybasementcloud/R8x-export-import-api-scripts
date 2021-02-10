#!/bin/bash
#
# SCRIPT Configure Script Output Paths and Fodlers for API Scripts common action handling
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

APISubScriptName=script_output_paths_and_folders_API_scripts.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}
export APISubScriptFileNameRoot=script_output_paths_and_folders_API_scripts.subscript.common
export APISubScriptShortName=script_output_paths_and_folders_API_scripts
export APISubScriptnohupName=${APISubScriptShortName}
export APISubScriptDescription="Configure Script Output Paths and Fodlers for API Scripts common action handling"

# =================================================================================================
# =================================================================================================
# START subscript:  Configure Script Output Paths and Fodlers for API Scripts
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
# localrootscriptconfiguration - Local Root Script Configuration setup
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-26 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

localrootscriptconfiguration () {
    #
    # Local Root Script Configuration setup
    #
    
    # WAITTIME in seconds for read -t commands, but check if it's already set
    if [ -z ${WAITTIME} ]; then
        export WAITTIME=15
    fi
    
    export customerpathroot=/var/log/__customer
    export customerdownloadpathroot=${customerpathroot}/download
    export downloadpathroot=${customerdownloadpathroot}
    export customerscriptspathroot=${customerpathroot}/_scripts
    export scriptspathmain=${customerscriptspathroot}
    export scriptspathb4CP=${scriptspathmain}/bash_4_Check_Point
    export customerworkpathroot=${customerpathroot}/upgrade_export
    export outputpathroot=${customerworkpathroot}
    export dumppathroot=${customerworkpathroot}/dump
    export changelogpathroot=${customerworkpathroot}/Change_Log
    
    export customerapipathroot=${customerpathroot}/devops
    export customerapiwippathroot=${customerpathroot}/devops.dev
    
    export customerdevopspathroot=${customerpathroot}/devops
    export customerdevopsdevpathroot=${customerpathroot}/devops.dev
    export customerdevopsresultspathroot=${customerpathroot}/devops.results
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-26


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleRootScriptConfiguration - Root Script Configuration
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-26 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleRootScriptConfiguration () {
    #
    # Root Script Configuration
    #
    
    # -------------------------------------------------------------------------------------------------
    # START: Root Script Configuration
    # -------------------------------------------------------------------------------------------------
    
    if [ -r "${scriptspathroot}/${rootscriptconfigfile}" ] ; then
        # Found the Root Script Configuration File in the folder for scripts
        # So let's call that script to configure what we need
        
        if ${APISCRIPTVERBOSE} ; then
            echo 'Root Script Config in scripts folder :  '${scriptspathroot}/${rootscriptconfigfile} | tee -a -i ${logfilepath}
        else
            echo 'Root Script Config in scripts folder :  '${scriptspathroot}/${rootscriptconfigfile} >> ${logfilepath}
        fi
        
        . ${scriptspathroot}/${rootscriptconfigfile} "$@"
        errorreturn=$?
    elif [ -r "../${rootscriptconfigfile}" ] ; then
        # Found the Root Script Configuration File in the folder above the executiong script
        # So let's call that script to configure what we need
        
        if ${APISCRIPTVERBOSE} ; then
            echo 'Root Script Config in folder above :  ../'${rootscriptconfigfile} | tee -a -i ${logfilepath}
        else
            echo 'Root Script Config in folder above :  ../'${rootscriptconfigfile} >> ${logfilepath}
        fi
        
        . ../${rootscriptconfigfile} "$@"
        errorreturn=$?
    elif [ -r "${rootscriptconfigfile}" ] ; then
        # Found the Root Script Configuration File in the folder with the executiong script
        # So let's call that script to configure what we need
        
        if ${APISCRIPTVERBOSE} ; then
            echo 'Root Script Config in current folder :  '${rootscriptconfigfile} | tee -a -i ${logfilepath}
        else
            echo 'Root Script Config in current folder :  '${rootscriptconfigfile} >> ${logfilepath}
        fi
        
        . ${rootscriptconfigfile} "$@"
        errorreturn=$?
    else
        # Did not the Root Script Configuration File
        # So let's call local configuration
        
        if ${APISCRIPTVERBOSE} ; then
            echo 'Root Script Config NOT found, using local procedure!' | tee -a -i ${logfilepath}
        else
            echo 'Root Script Config NOT found, using local procedure!' >> ${logfilepath}
        fi
        
        localrootscriptconfiguration "$@"
        errorreturn=$?
    fi
    
    # -------------------------------------------------------------------------------------------------
    # Check for critical configuration values
    # -------------------------------------------------------------------------------------------------
    
    if [ x"${customerdevopspathroot}" == x"" ] ; then
        export customerdevopspathroot=${customerpathroot}/devops
        if ${APISCRIPTVERBOSE} ; then
            echo 'Root Script Config missing parameter:  customerdevopspathroot='${customerdevopspathroot} | tee -a -i ${logfilepath}
        else
            echo 'Root Script Config missing parameter:  customerdevopspathroot='${customerdevopspathroot} >> ${logfilepath}
        fi
    fi
    if [ x"${customerdevopsdevpathroot}" == x"" ] ; then
        export customerdevopsdevpathroot=${customerpathroot}/devops.dev
        if ${APISCRIPTVERBOSE} ; then
            echo 'Root Script Config missing parameter:  customerdevopsdevpathroot='${customerdevopsdevpathroot} | tee -a -i ${logfilepath}
        else
            echo 'Root Script Config missing parameter:  customerdevopsdevpathroot='${customerdevopsdevpathroot} >> ${logfilepath}
        fi
    fi
    if [ x"${customerdevopsresultspathroot}" == x"" ] ; then
        export customerdevopsresultspathroot=${customerpathroot}/devops.results
        if ${APISCRIPTVERBOSE} ; then
            echo 'Root Script Config missing parameter:  customerdevopsresultspathroot='${customerdevopsresultspathroot} | tee -a -i ${logfilepath}
        else
            echo 'Root Script Config missing parameter:  customerdevopsresultspathroot='${customerdevopsresultspathroot} >> ${logfilepath}
        fi
    fi
    
    # -------------------------------------------------------------------------------------------------
    # END:  Root Script Configuration
    # -------------------------------------------------------------------------------------------------
    
    return ${errorreturn}
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-26


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleLaunchInHomeFolder - Handle if folder where this was launched is the $HOME Folder
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-26 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleLaunchInHomeFolder () {
    #
    # Handle if folder where this was launched is the $HOME Folder
    #
    
    export expandedpath=$(cd ${ScriptSourceFolder} ; pwd)
    export startpathroot=${expandedpath}
    export checkthispath=`echo "${expandedpath}" | grep -i "$notthispath"`
    export isitthispath=`test -z ${checkthispath}; echo $?`
    
    if [ ${isitthispath} -eq 1 ] ; then
        #Oh, Oh, we're in the home directory executing, not good!!!
        #Configure outputpathroot for ${alternatepathroot} folder since we can't run in /home/
        echo 'In home directory folder : '${startpathroot} >> ${logfilepath}
        export outputpathroot=${alternatepathroot}
    else
        #OK use the current folder and create working sub-folder
        echo 'NOT in home directory folder : '${startpathroot} >> ${logfilepath}
        # let's not change the configuration provided
        #export outputpathroot=${startpathroot}
    fi
    
    if [ ! -r ${outputpathroot} ] ; then
        #not where we're expecting to be, since ${outputpathroot} is missing here
        #maybe this hasn't been run here yet.
        #OK, so make the expected folder and set permissions we need
        mkdir -p -v ${outputpathroot} >> ${logfilepath}
        chmod 775 ${outputpathroot} >> ${logfilepath}
    else
        #set permissions we need
        chmod 775 ${outputpathroot} >> ${logfilepath}
    fi
    
    #Now that outputroot is not in /home/ let's work on where we are working from
    
    export expandedpath=$(cd ${outputpathroot} ; pwd)
    export outputpathroot=${expandedpath}
    export dumppathroot=${outputpathroot}/dump
    export changelogpathroot=${outputpathroot}/Change_Log
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-26


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ShowFinalOutputAndLogPaths - repeated proceedure
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-26 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ShowFinalOutputAndLogPaths () {
    #
    # repeated procedure description
    #
    
    #----------------------------------------------------------------------------------------
    # Output and Log file and folder Information
    #----------------------------------------------------------------------------------------
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        
        echo "Controls : " | tee -a -i ${logfilepath}
        echo ' UseDevOpsResults               : '"${UseDevOpsResults}" | tee -a -i ${logfilepath}
        echo ' OutputRelLocalPath             : '"${OutputRelLocalPath}" | tee -a -i ${logfilepath}
        echo ' IgnoreInHome                   : '"${IgnoreInHome}" | tee -a -i ${logfilepath}
        echo ' OutputToRoot                   : '"${OutputToRoot}" | tee -a -i ${logfilepath}
        echo ' OutputToDump                   : '"${OutputToDump}" | tee -a -i ${logfilepath}
        echo ' OutputToChangeLog              : '"$OutputToChangeLog" | tee -a -i ${logfilepath}
        echo ' OutputToOther                  : '"${OutputToOther}" | tee -a -i ${logfilepath}
        echo ' OtherOutputFolder              : '"${OtherOutputFolder}" | tee -a -i ${logfilepath}
        echo ' OutputDATESubfolder            : '"${OutputDATESubfolder}" | tee -a -i ${logfilepath}
        echo ' OutputDTGSSubfolder            : '"${OutputDTGSSubfolder}" | tee -a -i ${logfilepath}
        echo ' OutputSubfolderScriptName      : '"${OutputSubfolderScriptName}" | tee -a -i ${logfilepath}
        echo ' OutputSubfolderScriptShortName : '"${OutputSubfolderScriptShortName}" | tee -a -i ${logfilepath}
        echo ' CLIparm_NOHUP                  : '"${CLIparm_NOHUP}" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        echo "Output and Log file, folder locations: " | tee -a -i ${logfilepath}
        echo ' ScriptSourceFolder             : '"${ScriptSourceFolder}" | tee -a -i ${logfilepath}
        echo ' APICLIpathroot                 : '"${APICLIpathroot}" | tee -a -i ${logfilepath}
        echo ' APICLIpathbase                 : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
        echo ' logfilepath                    : '"${logfilepath}" | tee -a -i ${logfilepath}
        echo ' logfilepathbase                : '"${logfilepathbase}" | tee -a -i ${logfilepath}
        echo ' logfilepathfirst               : '"${logfilepathfirst}" | tee -a -i ${logfilepath}
        echo ' logfilepathfinal               : '"${logfilepathfinal}" | tee -a -i ${logfilepath}
        echo ' customerpathroot               : '"${customerpathroot}" | tee -a -i ${logfilepath}
        echo ' customerworkpathroot           : '"${customerworkpathroot}" | tee -a -i ${logfilepath}
        echo ' dumppathroot                   : '"${dumppathroot}" | tee -a -i ${logfilepath}
        echo ' changelogpathroot              : '"${changelogpathroot}" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
            echo
        fi
        
    else
        # Verbose mode OFF
        
        echo "Controls : " >> ${logfilepath}
        echo ' UseDevOpsResults               : '"${UseDevOpsResults}" >> ${logfilepath}
        echo ' OutputRelLocalPath             : '"${OutputRelLocalPath}" >> ${logfilepath}
        echo ' IgnoreInHome                   : '"${IgnoreInHome}" >> ${logfilepath}
        echo ' OutputToRoot                   : '"${OutputToRoot}" >> ${logfilepath}
        echo ' OutputToDump                   : '"${OutputToDump}" >> ${logfilepath}
        echo ' OutputToChangeLog              : '"$OutputToChangeLog" >> ${logfilepath}
        echo ' OutputToOther                  : '"${OutputToOther}" >> ${logfilepath}
        echo ' OtherOutputFolder              : '"${OtherOutputFolder}" >> ${logfilepath}
        echo ' OutputDATESubfolder            : '"${OutputDATESubfolder}" >> ${logfilepath}
        echo ' OutputDTGSSubfolder            : '"${OutputDTGSSubfolder}" >> ${logfilepath}
        echo ' OutputSubfolderScriptName      : '"${OutputSubfolderScriptName}" >> ${logfilepath}
        echo ' OutputSubfolderScriptShortName : '"${OutputSubfolderScriptShortName}" >> ${logfilepath}
        echo ' CLIparm_NOHUP                  : '"${CLIparm_NOHUP}" >> ${logfilepath}
        echo >> ${logfilepath}
        
        echo "Output and Log file, folder locations: " | tee -a -i ${logfilepath}
        echo ' ScriptSourceFolder             : '"${ScriptSourceFolder}" | tee -a -i ${logfilepath}
        echo ' APICLIpathroot                 : '"${APICLIpathroot}" >> ${logfilepath}
        echo ' APICLIpathbase                 : '"${APICLIpathbase}" | tee -a -i ${logfilepath}
        echo ' logfilepath                    : '"${logfilepath}" | tee -a -i ${logfilepath}
        echo ' logfilepathbase                : '"${logfilepathbase}" >> ${logfilepath}
        echo ' logfilepathfirst               : '"${logfilepathfirst}" >> ${logfilepath}
        echo ' logfilepathfinal               : '"${logfilepathfinal}" >> ${logfilepath}
        echo ' customerpathroot               : '"${customerpathroot}" >> ${logfilepath}
        echo ' customerworkpathroot           : '"${customerworkpathroot}" >> ${logfilepath}
        echo ' dumppathroot                   : '"${dumppathroot}" >> ${logfilepath}
        echo ' changelogpathroot              : '"${changelogpathroot}" >> ${logfilepath}
        echo | tee -a -i ${logfilepath}
    fi
    
    return 0
}


#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-26


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureRootPath - Configure root and base path
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -

ConfigureRootPath () {
    
    # ---------------------------------------------------------
    # Create the base path and directory structure for output
    # ---------------------------------------------------------
    
    if ${UseDevOpsResults} ; then
        # CLI parameter indicates to use the devops.results folder
        if [ x"${CLIparm_resultspath}" != x"" ] ; then
            # CLI parameter indicates to use the devops.results folder and a path was supplied so use it
            if ${OutputRelLocalPath} ; then
                export APICLIpathroot=${CLIparm_resultspath}
            else
                # need to expand this other path to ensure things work
                export expandedpath=$(cd ${CLIparm_resultspath} ; pwd)
                export APICLIpathroot=${expandedpath}
            fi
            echo 'Set root output CLI parameter : APICLIpathroot = '"${APICLIpathroot}" >> ${logfilepath}
        else
            # CLI parameter indicates to use the devops.results folder but no path was supplied so use default
            if [ -z ${customerdevopsresultspathroot} ] ; then
                # Uh Oh, missing critical parameter set
                echo 'Missing required RESULTS locaton :  '${customerdevopsresultspathroot} | tee -a -i ${logfilepath}
                echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
                echo | tee -a -i ${logfilepath}
                echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
                echo | tee -a -i ${logfilepath}
                
                exit 250
            fi
            export APICLIpathroot=${customerdevopsresultspathroot}
        fi
        
    elif [ x"${CLIparm_outputpath}" != x"" ] ; then
        if ${OutputRelLocalPath} ; then
            export APICLIpathroot=${CLIparm_outputpath}
        else
            # need to expand this other path to ensure things work
            export expandedpath=$(cd ${CLIparm_outputpath} ; pwd)
            export APICLIpathroot=${expandedpath}
        fi
        echo 'Set root output CLI parameter : APICLIpathroot = '"${APICLIpathroot}" >> ${logfilepath}
    else
        # CLI parameter for outputpath not set
        
        if ${OutputToRoot} ; then
            # output to outputpathroot
            if ${OutputRelLocalPath} ; then
                export APICLIpathroot=.
            else
                export APICLIpathroot=${outputpathroot}
            fi
            
            echo 'Set root output to Root : APICLIpathroot = '"${APICLIpathroot}" >> ${logfilepath}
            
        elif ${OutputToDump} ; then
            # output to dump folder
            if ${OutputRelLocalPath} ; then
                export APICLIpathroot=./dump
            else
                export APICLIpathroot=${dumppathroot}
            fi
            
            echo 'Set root output to Dump : APICLIpathroot = '"${APICLIpathroot}" >> ${logfilepath}
            
        elif $OutputToChangeLog ; then
            # output to Change Log
            if ${OutputRelLocalPath} ; then
                export APICLIpathroot=./Change_Log
            else
                export APICLIpathroot=${changelogpathroot}
            fi
            
            echo 'Set root output to Change Log : APICLIpathroot = '"${APICLIpathroot}" >> ${logfilepath}
            
        elif ${OutputToOther} ; then
            # output to other folder that should be set in ${OtherOutputFolder}
            if ${OutputRelLocalPath} ; then
                export APICLIpathroot=./${OtherOutputFolder}
            else
                # need to expand this other path to ensure things work
                export expandedpath=$(cd ${OtherOutputFolder} ; pwd)
                export APICLIpathroot=${expandedpath}
            fi
            
            echo 'Set root output to Other : APICLIpathroot = '"${APICLIpathroot}" >> ${logfilepath}
            
        else
            # Huh, what... this should have been set, well the use dump
            # output to dumppathroot
            if ${OutputRelLocalPath} ; then
                export APICLIpathroot=./dump
            else
                export APICLIpathroot=${dumppathroot}
            fi
            
            echo 'Set root output to default Dump : APICLIpathroot = '"${APICLIpathroot}" >> ${logfilepath}
            
        fi
        
    fi
    
    echo '${APICLIpathroot} = '${APICLIpathroot} >> ${logfilepath}
    
    if [ ! -r ${APICLIpathroot} ] ; then
        mkdir -p -v ${APICLIpathroot} | tee -a -i ${logfilepath}
        chmod 775 ${APICLIpathroot} | tee -a -i ${logfilepath}
    else
        chmod 775 ${APICLIpathroot} | tee -a -i ${logfilepath}
    fi
        
    if ${OutputDTGSSubfolder} ; then
        # Use subfolder based on date-time group
        # this shifts the base output folder down a level
        export APICLIpathbase=${APICLIpathroot}/${DATEDTGS}
    elif ${OutputDATESubfolder} ; then
        export APICLIpathbase=${APICLIpathroot}/${DATE}
    else
        export APICLIpathbase=${APICLIpathroot}
    fi
    
    echo '${APICLIpathbase} = '${APICLIpathbase} >> ${logfilepath}
    
    # 2020-11-23 activated
    # In the future we may add this naming extension
    if ${OutputSubfolderScriptName} ; then
        # Add script name to the Subfolder name
        export APICLIpathbase=${APICLIpathbase}.${APIScriptFileNameRoot}
    elif ${OutputSubfolderScriptShortName} ; then
        # Add short script name to the Subfolder name
        export APICLIpathbase=${APICLIpathbase}.${APIScriptShortName}
    else
        export APICLIpathbase=${APICLIpathbase}
    fi
    
    echo '${APICLIpathbase} = '${APICLIpathbase} >> ${logfilepath}
    
    if [ ! -r ${APICLIpathbase} ] ; then
        mkdir -p -v ${APICLIpathbase} | tee -a -i ${logfilepath}
        chmod 775 ${APICLIpathbase} | tee -a -i ${logfilepath}
    else
        chmod 775 ${APICLIpathbase} | tee -a -i ${logfilepath}
    fi
}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureLogPath - Configure log file path and handle temporary log file
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -

ConfigureLogPath () {
    
    # ---------------------------------------------------------
    # Create the base path and directory structure for logging
    #----------------------------------------------------------------------------------------
    
    export logfilepathbase=${APICLIpathbase}
    export logfilepathfirst=${logfilepath}
    
    # Setup the log file fully qualified path based on final locations
    #
    if [ -z "${CLIparm_logpath}" ]; then
        # CLI parameter for logfile not set
        export logfilepathbase=${APICLIpathbase}
    else
        # CLI parameter for logfile set
        #export logfilepathbase=${CLIparm_logpath}
        
        # need to expand this other path to ensure things work
        export expandedpath=$(cd ${CLIparm_logpath} ; pwd)
        export logfilepathbase=${expandedpath}
    fi
    
    export logfilepathfinal=${logfilepathbase}/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log
    
    # if we've been logging, move the temporary log to the final path
    #
    if [ "${logfilepath}" != "${logfilepathfinal}" ] ; then
        # original ${logfilepath} and new ${logfilepathfinal} ARE NOT the same
        if [ -w ${logfilepath} ]; then
            # Move content from working log file to final log file
            #mv ${logfilepath} ${logfilepathfinal} >> ${logfilepathfinal} 2>&1
            cat ${logfilepath} >> ${logfilepathfinal} 2>&1
            rm ${logfilepath} >> ${logfilepathfinal} 2>&1
        fi
        
        # And then set the logfilepath value to the final one
        #
        export logfilepath=${logfilepathfinal}
    else
        # original ${logfilepath} and new ${logfilepathfinal} ARE the same
        # And then set the logfilepath value to the final one since we need to makes sure
        #
        export logfilepath=${logfilepathfinal}
    fi
    
    #----------------------------------------------------------------------------------------
    # Done setting log paths
    #----------------------------------------------------------------------------------------
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleScriptInNOHUPModeLogging - Configure additional logging and clean-up for script in NOHUP mode
# -------------------------------------------------------------------------------------------------


# MODIFIED 2021-02-06 -

HandleScriptInNOHUPModeLogging () {
    #
    # Configure additional logging and clean-up for script in NOHUP mode
    #
    #----------------------------------------------------------------------------------------
    # Handle clean-up file creation for nohup operation
    #----------------------------------------------------------------------------------------
    
    if ${CLIparm_NOHUP}; then
        
        echo 'Create NOHUP Clean-up File : ' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        if [ -n ${CLIparm_NOHUPScriptName} ]; then
            # nohup operation script name was passed in CLI parameters
            export script2nohup=${CLIparm_NOHUPScriptName}
        elif [ -n ${APIScriptShortName} ]; then
            # nohup operation script name uses local definition
            export script2nohup=${APIScriptShortName}
        else
            # nohup operation script name ${APIScriptShortName} does not exist???
            # OK so do some script level manipulation
            export script2nohup=${APIScriptFileNameRoot}
        fi
        
        # Nonsense based on some initial research, we'll leave this for now
        #
        export script2nohuppath=$(dirname "${script2nohup}")
        export script2nohupfile=$(basename -- "${script2nohup}")
        export script2nohupfile="${script2nohup##*/}"
        export script2nohupfilename="${script2nohupfile##*.}"
        export script2nohupfileext="${script2nohupfile%.*}"
        
        #export script2nohupfile=${script2nohup//\"}
        
        if [ -n ${CLIparm_NOHUPDTG} ]; then
            export script2nohupDTG=${CLIparm_NOHUPDTG//\"}
        else
            #export script2nohupDTG=${DATEDTGS}
            export script2nohupDTG=${DATEDTG}
        fi
        
        #export script2nohupstdoutlog=${outputpathroot}/.nohup.${script2nohupDTG}.${script2nohupfile}.stdout.txt
        #export script2nohupstderrlog=${outputpathroot}/.nohup.${script2nohupDTG}.${script2nohupfile}.stderr.txt
        #export script2watchnohupwork=${outputpathroot}/.nohup.${script2nohupDTG}.${script2nohupfile}.watchme.sh
        #export script2cleannohupwork=${outputpathroot}/.nohup.${script2nohupDTG}.${script2nohupfile}.cleanup.sh
        #export script2watchdiskspace=${outputpathroot}/.nohup.${script2nohupDTG}.${script2nohupfile}.diskspace.sh
        #export script2logdisklv_log=${outputpathroot}/.nohup.${script2nohupDTG}.${script2nohupfile}.diskspace.vg_splat-lv_log.sh
        #export script2logdisklvcrnt=${outputpathroot}/.nohup.${script2nohupDTG}.${script2nohupfile}.diskspace.vg_splat-lv_current.sh
        
        export script2nohupstdoutlog=${ScriptSourceFolder}/.nohup.${script2nohupDTG}.${script2nohupfile}.stdout.txt
        export script2nohupstderrlog=${ScriptSourceFolder}/.nohup.${script2nohupDTG}.${script2nohupfile}.stderr.txt
        export script2watchnohupwork=${ScriptSourceFolder}/.nohup.${script2nohupDTG}.${script2nohupfile}.watchme.sh
        export script2cleannohupwork=${ScriptSourceFolder}/.nohup.${script2nohupDTG}.${script2nohupfile}.cleanup.sh
        
        export script2nohupactive=${ScriptSourceFolder}/.nohup.${script2nohupDTG}.${script2nohupfile}.scriptisactive.sh
        
        export script2watchdiskspace=${ScriptSourceFolder}/.nohup.${script2nohupDTG}.${script2nohupfile}.diskspace.sh
        export script2logdisklv_log=${ScriptSourceFolder}/.nohup.${script2nohupDTG}.${script2nohupfile}.diskspace.vg_splat-lv_log.sh
        export script2logdisklvcrnt=${ScriptSourceFolder}/.nohup.${script2nohupDTG}.${script2nohupfile}.diskspace.vg_splat-lv_current.sh
        
        echo 'NOHUP Clean-up related files and values : ' | tee -a -i ${logfilepath}
        echo ' ScriptSourceFolder       : '"${ScriptSourceFolder}" | tee -a -i ${logfilepath}
        echo ' script2nohup             : '"${script2nohup}" | tee -a -i ${logfilepath}
        echo ' script2nohuppath         : '"${script2nohuppath}" | tee -a -i ${logfilepath}
        echo ' script2nohupfile         : '"${script2nohupfile}" | tee -a -i ${logfilepath}
        echo ' script2nohupfilename     : '"${script2nohupfilename}" | tee -a -i ${logfilepath}
        echo ' script2nohupfileext      : '"${script2nohupfileext}" | tee -a -i ${logfilepath}
        echo ' script2nohupDTG          : '"${script2nohupDTG}" | tee -a -i ${logfilepath}
        
        echo ' script2nohupstdoutlog    : '"${script2nohupstdoutlog}" | tee -a -i ${logfilepath}
        echo ' script2nohupstderrlog    : '"${script2nohupstderrlog}" | tee -a -i ${logfilepath}
        echo ' script2watchnohupwork    : '"${script2watchnohupwork}" | tee -a -i ${logfilepath}
        echo ' script2cleannohupwork    : '"${script2cleannohupwork}" | tee -a -i ${logfilepath}
        
        echo ' script2nohupactive       : '"${script2nohupactive}" | tee -a -i ${logfilepath}
        
        echo ' script2watchdiskspace    : '"${script2watchdiskspace}" | tee -a -i ${logfilepath}
        echo ' script2logdisklv_log     : '"${script2logdisklv_log}" | tee -a -i ${logfilepath}
        echo ' script2logdisklvcrnt     : '"${script2logdisklvcrnt}" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        touch ${script2cleannohupwork} >> ${logfilepath}
        chmod 775 ${script2cleannohupwork} >> ${logfilepath}
        
        echo '#!/bin/bash' > ${script2cleannohupwork}
        echo '#' >> ${script2cleannohupwork}
        echo >> ${script2cleannohupwork}
        echo 'if [ -r '${script2nohupactive}' ] ; then echo 'Script still running!'; exit ; fi' >> ${script2cleannohupwork}
        echo >> ${script2cleannohupwork}
        echo 'mv '${script2nohupstdoutlog}' '${APICLIpathbase} >> ${script2cleannohupwork}
        echo 'mv '${script2nohupstderrlog}' '${APICLIpathbase} >> ${script2cleannohupwork}
        echo 'mv '${script2watchnohupwork}' '${APICLIpathbase} >> ${script2cleannohupwork}
        echo 'cp '${script2cleannohupwork}' '${APICLIpathbase} >> ${script2cleannohupwork}
        echo 'mv '${script2watchdiskspace}' '${APICLIpathbase} >> ${script2cleannohupwork}
        echo 'mv '${script2logdisklv_log}' '${APICLIpathbase} >> ${script2cleannohupwork}
        echo 'mv '${script2logdisklvcrnt}' '${APICLIpathbase} >> ${script2cleannohupwork}
        echo 'echo' >> ${script2cleannohupwork}
        echo 'ls -alh '${APICLIpathbase} >> ${script2cleannohupwork}
        echo 'echo' >> ${script2cleannohupwork}
        echo 'rm '${script2cleannohupwork} >> ${script2cleannohupwork}
        echo 'echo' >> ${script2cleannohupwork}
        echo >> ${script2cleannohupwork}
        echo
        
        touch ${script2nohupactive} >> ${logfilepath}
        
        echo >> ${logfilepath}
        echo '------------------------------------------------------------------------------' >> ${logfilepath}
        echo 'Dump nohup cleanup script to log file:  '${script2cleannohupwork} >> ${logfilepath}
        echo '------------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        cat ${script2cleannohupwork} >> ${logfilepath}
        echo >> ${logfilepath}
        echo '------------------------------------------------------------------------------' >> ${logfilepath}
        echo 'Copy nohup cleanup script to log folder:  '${logfilepathbase} >> ${logfilepath}
        echo '------------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        cp ${script2cleannohupwork} ${logfilepathbase} >> ${logfilepath}
        echo >> ${logfilepath}
        echo '------------------------------------------------------------------------------' >> ${logfilepath}
        echo >> ${logfilepath}
        echo >> ${logfilepath}
        
    else
        
        echo 'NOT in NOHUP mode!  No need for NOHUP Clean-up File ' >> ${logfilepath}
        echo >> ${logfilepath}
        
    fi
    
    #----------------------------------------------------------------------------------------
    # Done Handle clean-up file creation for nohup operation
    #----------------------------------------------------------------------------------------
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureOtherCLIParameterPaths - Configure other path and folder values based on CLI parameters
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ConfigureOtherCLIParameterPaths () {
    
    # ---------------------------------------------------------
    # Setup other paths we may need - but these should not create folders (yet)
    # Configure other path and folder values based on CLI parameters
    # ---------------------------------------------------------
    
    export APICLICSVExportpathbase=
    #if ${script_use_export} ; then
        #if [ x"${CLIparm_exportpath}" != x"" ] ; then
            #export APICLICSVExportpathbase=${CLIparm_exportpath}
        #else
            #export APICLICSVExportpathbase=${APICLIpathbase}
        #fi
    #fi
    
    # Since we use the ${APICLICSVExportpathbase} as a base folder for output results, 
    # we need this for all operations.  
    # FUTURE UDPATE : migrate the common dump location to a new standard variable
    #
    if [ x"${CLIparm_exportpath}" != x"" ] ; then
        export APICLICSVExportpathbase=${CLIparm_exportpath}
    else
        export APICLICSVExportpathbase=${APICLIpathbase}
    fi
    
    export APICLICSVImportpathbase=
    if ${script_use_import} ; then
        if [ x"${CLIparm_importpath}" != x"" ] ; then
            export APICLICSVImportpathbase=${CLIparm_importpath}
        else
            export APICLICSVImportpathbase=./import.csv
        fi
    fi
    
    export APICLICSVDeletepathbase=
    if ${script_use_delete} ; then
        if [ x"${CLIparm_deletepath}" != x"" ] ; then
            export APICLICSVDeletepathbase=${CLIparm_deletepath}
        else
            export APICLICSVDeletepathbase=./delete.csv
        fi
    fi
    
    export APICLICSVcsvpath=
    if ${script_use_csvfile} ; then
        if [ x"${CLIparm_csvpath}" != x"" ] ; then
            export APICLICSVcsvpath=${CLIparm_csvpath}
        else
            export APICLICSVcsvpath=./domains.csv
        fi
    fi
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureOtherCLIParameterValues - Configure other values based on CLI parameters
# -------------------------------------------------------------------------------------------------

ConfigureOtherCLIParameterValues () {
    
    # ---------------------------------------------------------
    # Setup other variables based on CLI parameters
    # ---------------------------------------------------------
    
    #export NoSystemObjects=false
    export NoSystemObjects=true
    
    export NoSystemObjectsValue=`echo "${CLIparm_NoSystemObjects}" | tr '[:upper:]' '[:lower:]'`
    
    #if [ x"${NoSystemObjectsValue}" = x"true" ] ; then
        #export NoSystemObjects=true
    #else
        #export NoSystemObjects=false
    #fi
    
    if [ x"${NoSystemObjectsValue}" = x"false" ] ; then
        export NoSystemObjects=false
    else
        export NoSystemObjects=true
    fi
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ExecuteScriptOutputPathsforAPIScripts - Execute Script Output Paths and Folders for API scripts
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-16 -

ExecuteScriptOutputPathsforAPIScripts () {
    
    # -------------------------------------------------------------------------------------------------
    # Root Script Configuration
    # -------------------------------------------------------------------------------------------------
    
    
    HandleRootScriptConfiguration "$@"
    
    
    #----------------------------------------------------------------------------------------
    # Setup root folder and path values
    #----------------------------------------------------------------------------------------
    
    
    export alternatepathroot=${customerworkpathroot}
    
    if ! ${IgnoreInHome} ; then
        HandleLaunchInHomeFolder "$@"
    fi
    
    
    #----------------------------------------------------------------------------------------
    # working folder, path, and log file values
    #----------------------------------------------------------------------------------------
    # Configure Common CLI Parameter Values
    # Formerly
    #ConfigureCommonCLIParameterValues
    #
    
    ConfigureRootPath "$@"
    
    ConfigureLogPath "$@"
    
    HandleScriptInNOHUPModeLogging "$@"
    
    ShowFinalOutputAndLogPaths "$@"
    
    #----------------------------------------------------------------------------------------
    # other path and folder values
    #----------------------------------------------------------------------------------------
    # Configure Specific CLI Parameter Values
    # Formerly
    #ConfigureSpecificCLIParameterValues
    #
    
    ConfigureOtherCLIParameterPaths "$@"
    
    ConfigureOtherCLIParameterValues "$@"
    
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END Procedures:  Local Proceedures
# =================================================================================================


# =================================================================================================
# START:  Configure Script Output Paths and Fodlers for API Scripts
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Setup Script Output Paths and other CLI Parameters after Command Line Parameter Processor
# -------------------------------------------------------------------------------------------------

ExecuteScriptOutputPathsforAPIScripts "$@"

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Configure Script Output Paths and Fodlers for API Scripts
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
# END subscript:  Configure Script Output Paths and Fodlers for API Scripts
# =================================================================================================
# =================================================================================================


