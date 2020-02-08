#!/bin/bash
#
# SCRIPT API action handler template
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
ScriptVersion=00.40.00
ScriptRevision=000
ScriptDate=2020-02-07
TemplateVersion=00.40.00
CommonScriptsVersion=00.40.00
CommonScriptsRevision=006

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

