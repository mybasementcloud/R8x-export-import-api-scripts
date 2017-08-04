#!/bin/bash
#
# SCRIPT Object dump action operations for API CLI Operations
#
ScriptVersion=00.24.00
ScriptDate=2017-08-03

#

export APIActionsScriptVersion=v00x24x00
ScriptName=cli_api_export_objects_actions

# =================================================================================================
# Validate Actions Script version is correct for caller
# =================================================================================================


if [ x"$APIScriptVersion" = x"$APIActionsScriptVersion" ] ; then
    # Script and Actions Script versions match, go ahead
    echo
    echo 'Verify Actions Scripts Version - OK'
    echo
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo
    echo 'Verify Actions Scripts Version - Missmatch'
    echo 'Calling Script version : '$APIScriptVersion
    echo 'Actions Script version : '$APIActionsScriptVersion
    echo
    exit 255
fi


# =================================================================================================
# =================================================================================================
# START:  Export objects to json in set detail level from root script
# =================================================================================================


echo
echo $APICLIdetaillvl' - Starting!'
echo

export APICLIpathexport=$APICLIpathbase/$APICLIdetaillvl
#export APICLIpathexport=$APICLIpathbase/csv
#export APICLIpathexport=$APICLIpathbase/import
#export APICLIpathexport=$APICLIpathbase/delete
export APICLIfileexportpost='_'$APICLIdetaillvl'_'$APICLIfileexportsufix

echo
echo 'Dump "'$APICLIdetaillvl'" details to path:  '$APICLIpathexport
echo

# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure
# -------------------------------------------------------------------------------------------------

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the $APICLIobjecttype details is exported to a json at the $APICLIdetaillvl.

MainOperationalProcedure () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    export APICLIfileexport=$APICLIpathexport/$APICLIfileexportpre$APICLIobjecttype$APICLIfileexportpost
    echo

    echo 'Dump '$APICLIobjecttype' to '$APICLIfileexport

    export MgmtCLI_Base_OpParms="--format json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjecttype limit 1 offset 0 details-level "$APICLIdetaillvl" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    if [ $objectstoshow -le 0 ] ; then
        echo "$objectstoshow $APICLIobjecttype objects found!"
        echo "Skipping!"
    else
    
        echo "Processing $objectstoshow $APICLIobjecttype objects in $APICLIObjectLimit object historychunks:"
    
        objectslefttoshow=$objectstoshow
        currentoffset=0
    
        while [ $objectslefttoshow -ge 1 ] ; do
            # we have objects to process
    
            if [ $currentoffset -gt 0 ] ; then
                # Export file for the next $APICLIObjectLimit objects
                export APICLIfileexport=$APICLIpathexport/$APICLIfileexportpre$APICLIobjecttype'_'$currentoffset'_'$APICLIfileexportpost
            fi
    
            echo "  Now processing up to next $APICLIObjectLimit objects starting with object $currentoffset of $objectslefttoshow remainging!"
    
            mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms > $APICLIfileexport
    
            objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
            currentoffset=`expr $currentoffset + $APICLIObjectLimit`
    
        done
    
    
        echo
        tail $APICLIfileexport
        echo
    fi
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo
    return 0
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# host objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=hosts

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=networks

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=groups

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=groups-with-exclusion

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=address-ranges

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# multicast-address-ranges objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=multicast-address-ranges

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=dns-domains

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# security-zones objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=security-zones

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# dynamic-object objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=dynamic-objects
MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# simple-gateway objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=simple-gateways

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# time objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=times

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# time-group objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=time-groups

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# access-role objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=access-roles

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# opsec-application objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=opsec-applications

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Identifying Data
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# tag objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=tags

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Services and Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# services-tcp objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=services-tcp

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=services-udp

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=services-icmp

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=services-icmp6

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=services-sctp

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=services-other

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=services-dce-rpc

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=services-rpc

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=service-groups

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=application-sites

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=application-site-categories

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=application-site-groups

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# no more objects
# -------------------------------------------------------------------------------------------------

echo
echo $APICLIdetaillvl' - Completed!'
echo

echo
echo

# =================================================================================================
# END:  Export objects to json in set detail level from root script
# =================================================================================================
# =================================================================================================

