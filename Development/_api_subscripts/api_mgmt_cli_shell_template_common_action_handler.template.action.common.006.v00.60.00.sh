#!/bin/bash
#
# SCRIPT Template API common action handling
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
ScriptVersion=00.60.00
ScriptRevision=000
ScriptDate=2020-09-10
TemplateVersion=00.60.00
APISubscriptsVersion=00.60.00
APISubscriptsRevision=006

#

export APISubscriptsActionsScriptVersion=v${ScriptVersion//./x}
export APISubscriptsActionScriptTemplateVersion=v${TemplateVersion//./x}
ActionScriptName=api_mgmt_cli_shell_template_common_action_handler.template.action.common.$APISubscriptsRevision.v$ScriptVersion

# =================================================================================================
# Validate Common Actions Script version is correct for caller
# =================================================================================================


if [ x"$APIExpectedAPISubscriptsVersion" = x"$APISubscriptsActionsScriptVersion" ] ; then
    # Script and Common Actions Script versions match, go ahead
    echo >> $APICLIlogfilepath
    echo 'Verify Common Actions Scripts Version - OK' >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Common Actions Scripts Version - Missmatch' | tee -a -i $APICLIlogfilepath
    echo 'Expected Common Script version : '$APIExpectedAPISubscriptsVersion | tee -a -i $APICLIlogfilepath
    echo 'Current  Common Script version : '$APISubscriptsActionsScriptVersion | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 250
fi


# =================================================================================================
# =================================================================================================
# START common action script:  X
# =================================================================================================


if [ "$APISCRIPTVERBOSE" = "true" ] ; then
    echo | tee -a -i $APICLIlogfilepath
    echo 'ActionScriptName:  '$ActionScriptName'  Script Version: '$ScriptVersion'  Revision:  '$ScriptRevision | tee -a -i $APICLIlogfilepath
else
    echo >> $APICLIlogfilepath
    echo 'ActionScriptName:  '$ActionScriptName'  Script Version: '$ScriptVersion'  Revision:  '$ScriptRevision >> $APICLIlogfilepath
fi


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


export APICLIActionstemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log


# =================================================================================================
# START:  Local Proceedures
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-10 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #
    
    if [ -z "$1" ]; then
        # No explicit name passed for action
        export APICLIActionstemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log
    else
        # explicit name passed for action
        export APICLIActionstemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$1'_'$DATEDTGS.log
    fi
    
    rm $APICLIActionstemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath
    
    touch $APICLIActionstemplogfilepath
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-10

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
    
    if [ "$APISCRIPTVERBOSE" = "true" ] ; then
        # verbose mode so show the logged results and copy to normal log file
        cat $APICLIActionstemplogfilepath | tee -a -i $APICLIlogfilepath
    else
        # NOT verbose mode so push logged results to normal log file
        cat $APICLIActionstemplogfilepath >> $APICLIlogfilepath
    fi
    
    rm $APICLIActionstemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath
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
    
    cat $APICLIActionstemplogfilepath | tee -a -i $APICLIlogfilepath
    
    rm $APICLIActionstemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-10

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Local Proceedures
# =================================================================================================


# =================================================================================================
# START:  X
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  X
# =================================================================================================


# =================================================================================================
# END common action script:  X
# =================================================================================================
# =================================================================================================


