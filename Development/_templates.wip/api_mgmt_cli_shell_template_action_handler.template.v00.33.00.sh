#!/bin/bash
#
# SCRIPT API action handler template
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

export APIActionsScriptVersion=v${ScriptVersion//./x}
export APIActionScriptTemplateVersion=v${TemplateVersion//./x}
ActionScriptName=api_mgmt_cli_shell_template_action_handler.template.$CommonScriptsRevision.v$ScriptVersion

# =================================================================================================
# Validate Actions Script version is correct for caller
# =================================================================================================


if [ x"$APIExpectedActionScriptsVersion" = x"$APIActionsScriptVersion" ] ; then
    # Script and Actions Script versions match, go ahead
    echo >> $APICLIlogfilepath
    echo 'Verify Actions Scripts Version - OK' >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Actions Scripts Version - Missmatch' | tee -a -i $APICLIlogfilepath
    echo 'Expected Action Script version : '$APIExpectedActionScriptsVersion | tee -a -i $APICLIlogfilepath
    echo 'Current  Action Script version : '$APIActionsScriptVersion | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 250
fi


# =================================================================================================
# =================================================================================================
# START action script:  X
# =================================================================================================


echo | tee -a -i $APICLIlogfilepath
echo 'Action Script:  '$ActionScriptName'  Script Version: '$ScriptVersion'  Revision: '$ScriptRevision | tee -a -i $APICLIlogfilepath

# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START :  Y
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# END :  Y
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------



# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------



# -------------------------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------------------------

echo | tee -a -i $APICLIlogfilepath

return 0

# =================================================================================================
# END action script:  X
# =================================================================================================
# =================================================================================================

