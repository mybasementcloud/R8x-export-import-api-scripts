#!/bin/bash
#
# SCRIPT Object dump action operations for API CLI Operations
#
ScriptVersion=00.26.01
ScriptDate=2017-10-27

#

export APIActionsScriptVersion=v00x26x01
ActionScriptName=cli_api_export_objects_actions

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
echo 'ActionScriptName:  '$ActionScriptName'  Script Version: '$APIActionsScriptVersion

# -------------------------------------------------------------------------------------------------
# Start executing Main operations
# -------------------------------------------------------------------------------------------------


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

    export MgmtCLI_Base_OpParms="--format json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    if [ $objectstoshow -le 0 ] ; then
        echo "Found $objectstoshow $APICLIobjecttype objects.  No objects found!  Skipping!..."
    else
    
        echo
        echo "Processing $objectstoshow $APICLIobjecttype objects in $APICLIObjectLimit object historychunks:"
        echo 'Dump '$APICLIobjectstype' to '$APICLIfileexport

        objectslefttoshow=$objectstoshow
        currentoffset=0
    
        while [ $objectslefttoshow -ge 1 ] ; do
            # we have objects to process
    
            if [ $currentoffset -gt 0 ] ; then
                # Export file for the next $APICLIObjectLimit objects
                export APICLIfileexport=$APICLIpathexport/$APICLIfileexportpre$APICLIobjecttype'_'$currentoffset'_'$APICLIfileexportpost
            fi
    
            echo "  Now processing up to next $APICLIObjectLimit objects starting with object $currentoffset of $objectslefttoshow remaining!"
    
            mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms > $APICLIfileexport
    
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

export APICLIobjecttype=host
export APICLIobjectstype=hosts

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=network
export APICLIobjectstype=networks

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group
export APICLIobjectstype=groups

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group-with-exclusion
export APICLIobjectstype=groups-with-exclusion

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=address-range
export APICLIobjectstype=address-ranges

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# multicast-address-ranges objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=multicast-address-range
export APICLIobjectstype=multicast-address-ranges

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dns-domain
export APICLIobjectstype=dns-domains

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# security-zones objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# dynamic-object objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# simple-gateway objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# time objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time
export APICLIobjectstype=times

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# time-group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# access-role objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# opsec-application objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Identifying Data
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# tag objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=tag
export APICLIobjectstype=tags

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Services and Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# services-tcp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories

MainOperationalProcedure


# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups

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

