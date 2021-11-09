#!/bin/bash
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
# SCRIPT API action handler template
#
#
ScriptVersion=00.60.08
ScriptRevision=050
ScriptDate=2021-11-08
TemplateVersion=00.60.08
APISubscriptsLevel=006
APISubscriptsVersion=00.60.08
APISubscriptsRevision=050

#

export APIActionsScriptVersion=v${ScriptVersion}
export APIActionScriptTemplateVersion=v${TemplateVersion}

export APIActionsScriptVersionX=v${ScriptVersion//./x}
export APIActionScriptTemplateVersionX=v${TemplateVersion//./x}

ActionScriptName=api_mgmt_cli_shell_template_action_handler.template.${APISubscriptsRevision}.v${ScriptVersion}
export APIActionScriptFileNameRoot=api_mgmt_cli_shell_template_action_handler.template
export APIActionScriptShortName=api_mgmt_cli_shell_template_action_handler
export APIActionScriptnohupName=${APIActionScriptShortName}
export APIActionScriptDescription="API action handler template"

# =================================================================================================
# =================================================================================================
# START action script:  X
# =================================================================================================


if ${APISCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'ActionScriptName:  '${ActionScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'ActionScriptName:  '${ActionScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} >> ${logfilepath}
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

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

return 0

# =================================================================================================
# END action script:  X
# =================================================================================================
# =================================================================================================

