#!/bin/bash
#
# SCRIPT Object dump action operations for API CLI Operations
#
ScriptVersion=00.21.00
ScriptDate=2017-05-25

#

ScriptName=cli_api_export_objects_actions_$APIScriptVersion

# =================================================================================================
# =================================================================================================
# START:  Export objects to json in set detail level from root script
# =================================================================================================


echo
echo $APICLIdetaillvl' - Starting!'
echo

export APICLIpathoutput=$APICLIpathbase/$APICLIdetaillvl
#export APICLIpathoutput=$APICLIpathbase/csv
#export APICLIpathoutput=$APICLIpathbase/import
#export APICLIpathoutput=$APICLIpathbase/delete
export APICLIfileoutputpost='_'$APICLIdetaillvl'_'$APICLIfileoutputsufix

echo
echo 'Dump "'$APICLIdetaillvl'" details to path:  '$APICLIpathoutput
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

    export APICLIfileoutput=$APICLIpathoutput/$APICLIfileoutputpre$APICLIobjecttype$APICLIfileoutputpost
    echo

    echo 'Dump '$APICLIobjecttype' to '$APICLIfileoutput

    mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile > $APICLIfileoutput

    echo
    tail $APICLIfileoutput
    echo
    
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
# multicast-address-ranges objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=multicast-address-ranges

MainOperationalProcedure


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
# opsec-applications objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=opsec-applications

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

