#!/bin/bash
#
# SCRIPT Template API common action handling
#
# (C) 2016-2019 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
#
ScriptVersion=00.33.00
ScriptRevision=000
ScriptDate=2019-01-18
TemplateVersion=00.33.00
CommonScriptsVersion=00.33.00
CommonScriptsRevision=005

#

export APICommonActionsScriptVersion=v${ScriptVersion//./x}
export APICommonActionScriptTemplateVersion=v${TemplateVersion//./x}
ActionScriptName=api_mgmt_cli_shell_template_common_action_handler.template.action.common.$CommonScriptsRevision.v$ScriptVersion

# =================================================================================================
# Validate Common Actions Script version is correct for caller
# =================================================================================================


if [ x"$APIExpectedCommonScriptsVersion" = x"$APICommonActionsScriptVersion" ] ; then
    # Script and Common Actions Script versions match, go ahead
    echo >> $APICLIlogfilepath
    echo 'Verify Common Actions Scripts Version - OK' >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Common Actions Scripts Version - Missmatch' | tee -a -i $APICLIlogfilepath
    echo 'Expected Common Script version : '$APIExpectedCommonScriptsVersion | tee -a -i $APICLIlogfilepath
    echo 'Current  Common Script version : '$APICommonActionsScriptVersion | tee -a -i $APICLIlogfilepath
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


# =================================================================================================
# START:  Local Proceedures
# =================================================================================================

export APICLIActionstemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log

# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #

    export APICLIActionstemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log

    rm $APICLIActionstemplogfilepath >> $APICLIlogfilepath 2> $APICLIlogfilepath

    touch $APICLIActionstemplogfilepath

    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-18 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
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
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-18

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


