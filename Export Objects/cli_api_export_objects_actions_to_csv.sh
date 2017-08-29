#!/bin/bash
#
# SCRIPT Object dump to CSV action operations for API CLI Operations
#
ScriptVersion=00.25.00
ScriptDate=2017-08-28

#

export APIActionsScriptVersion=v00x25x00
ScriptName=cli_api_export_objects_actions_to_csv

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
# START:  Export objects to csv
# =================================================================================================


echo
echo 'ActionScriptName:  '$ActionScriptName'  Script Version: '$APIActionsScriptVersion

# -------------------------------------------------------------------------------------------------
# Start executing Main operations
# -------------------------------------------------------------------------------------------------


echo
echo $APICLIdetaillvl' - Dump to CSV Starting!'
echo

#export APICLIpathexport=$APICLIpathbase/$APICLIdetaillvl
export APICLIpathexport=$APICLIpathbase/csv
#export APICLIpathexport=$APICLIpathbase/import
#export APICLIpathexport=$APICLIpathbase/delete
export APICLIfileexportpost='_'$APICLIdetaillvl'_'$APICLIfileexportsufix
export APICLICSVheaderfilesuffix=header
export APICLIpathexportwip=$APICLIpathexport/wip
if [ ! -r $APICLIpathexportwip ] 
then
    mkdir $APICLIpathexportwip
fi

echo
echo 'Dump "'$APICLIdetaillvl'" details to path:  '$APICLIpathexport
echo


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# The SetupExportObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportObjectsToCSVviaJQ () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    
    export APICLICSVfilename=$APICLIobjecttype'_'$APICLIdetaillvl'_csv'$APICLICSVfileexportsufix
    export APICLICSVfile=$APICLIpathexport/$APICLICSVfilename
    export APICLICSVfilewip=$APICLIpathexportwip/$APICLICSVfilename
    export APICLICSVfileheader=$APICLICSVfilewip.$APICLICSVheaderfilesuffix
    export APICLICSVfiledata=$APICLICSVfilewip.data
    export APICLICSVfilesort=$APICLICSVfilewip.sort
    export APICLICSVfileoriginal=$APICLICSVfilewip.original

    
    if [ ! -r $APICLIpathexportwip ] ; then
        mkdir $APICLIpathexportwip
    fi

    if [ -r $APICLICSVfile ] ; then
        rm $APICLICSVfile
    fi
    if [ -r $APICLICSVfileheader ] ; then
        rm $APICLICSVfileheader
    fi
    if [ -r $APICLICSVfiledata ] ; then
        rm $APICLICSVfiledata
    fi
    if [ -r $APICLICSVfilesort ] ; then
        rm $APICLICSVfilesort
    fi
    if [ -r $APICLICSVfileoriginal ] ; then
        rm $APICLICSVfileoriginal
    fi
    
    echo
    echo "Creat $APICLIobjecttype CSV File : $APICLICSVfile"
    echo
    
    #
    # Troubleshooting output
    #
    if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
        # Verbose mode ON
        echo
        echo '$CSVFileHeader' - $CSVFileHeader
        echo
    
    fi
    
    echo $CSVFileHeader > $APICLICSVfileheader
    echo
    
    echo
    return 0
    
    #
}

# -------------------------------------------------------------------------------------------------

# The FinalizeExportObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
#

FinalizeExportObjectsToCSVviaJQ () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    if [ ! -r $APICLICSVfileheader ] ; then
        # Uh, Oh, something went wrong, no header file
        echo
        echo '!!!! Error header file missing : '$APICLICSVfileheader
        echo 'Terminating!'
        echo
        exit 254
        
    elif [ ! -r $APICLICSVfiledata ] ; then
        # Uh, Oh, something went wrong, no data file
        echo
        echo '!!!! Error data file missing : '$APICLICSVfiledata
        echo 'Terminating!'
        echo
        exit 253
        
    fi

    echo
    echo "Sort data and build CSV export file"
    echo
    
    cat $APICLICSVfileheader > $APICLICSVfileoriginal
    cat $APICLICSVfiledata >> $APICLICSVfileoriginal
    
    sort $APICLICSVsortparms $APICLICSVfiledata > $APICLICSVfilesort
    
    cat $APICLICSVfileheader > $APICLICSVfile
    cat $APICLICSVfilesort >> $APICLICSVfile
    
    echo
    echo "Done creating $APICLIobjecttype CSV File : $APICLICSVfile"
    echo
    
    head $APICLICSVfile
    echo
    echo
   
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo
    return 0
    
    #
}

# -------------------------------------------------------------------------------------------------

# MODIFIED 2017-08-28  \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportObjectsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the $APICLIobjecttype item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectsToCSVviaJQ () {
    #
    
    if [ $number_of_objects -le 1 ] ; then
        # no objects of this type
 
        echo "No objects of type $APICLIobjecttype to process, skipping..."

        return 0
       
    else
        # we have objects to handle
        echo
        echo "Process $number_of_objects $APICLIobjecttype objects..."
        echo
   fi

    SetupExportObjectsToCSVviaJQ
    
    #
    # Troubleshooting output
    #
    if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
        # Verbose mode ON
        echo
        echo '$CSVJQparms' - $CSVJQparms
        echo
    fi
    
    export MgmtCLI_Base_OpParms="--format json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjecttype limit 1 offset 0 details-level "$APICLIdetaillvl" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    echo "Processing $objectstoshow $APICLIobjecttype objects in $APICLIObjectLimit object chunks:"

    objectslefttoshow=$objectstoshow
    currentoffset=0

    echo
    echo "Exportport $APICLIobjecttype to CSV File"
    echo "  mgmt_cli parameters : $MgmtCLI_Show_OpParms"
    echo "  and dump to $APICLICSVfile"
    echo
    
    while [ $objectslefttoshow -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next $APICLIObjectLimit objects starting with object $currentoffset of $objectslefttoshow remainging!"

        mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms | $JQ '.objects[] | [ '"$CSVJQparms"' ] | @csv' -r >> $APICLICSVfiledata
        errorreturn=$?
        if [ $errorreturn != 0 ] ; then
            # Something went wrong, terminate
            exit $errorreturn
        fi

        objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
        currentoffset=`expr $currentoffset + $APICLIObjectLimit`
    done

    echo
    
    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        exit $errorreturn
    fi
    
    if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
        echo
        echo "Done with Exporting $APICLIobjecttype to CSV File : $APICLICSVfile"
    
        read -t $WAITTIME -n 1 -p "Any key to continue : " anykey
    
    fi
    
    echo
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\  MODIFIED 2017-08-28
# ADDED 2017-08-28 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#


# -------------------------------------------------------------------------------------------------
# GetNumberOfObjectsviaJQ
# -------------------------------------------------------------------------------------------------

# The GetNumberOfObjectsviaJQ is the obtains the number of objects for that type indicated.
#

GetNumberOfObjectsviaJQ () {

    export objectstotal=
    export objectsfrom=
    export objectsto=
    
    #
    # Troubleshooting output
    #
    if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
        # Verbose mode ON
        echo
        echo '$CSVJQparms' - $CSVJQparms
        echo
    fi
    
    objectstotal=$(mgmt_cli show $APICLIobjecttype limit 1 offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile | $JQ ".total")
    errorreturn=$?

    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        exit $errorreturn
    fi
    
    echo
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ ADDED 2017-08-28

# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# hosts
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=hosts
export APICLIobjectstype=hosts
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"ipv4-address","ipv6-address"'
export CSVFileHeader=$CSVFileHeader',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.ipv4-address","nat-settings.ipv6-address","nat-settings.method"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["ipv4-address"], .["ipv6-address"]'
export CSVJQparms=$CSVJQparms', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"]'
export CSVJQparms=$CSVJQparms', .["nat-settings"]["ipv4-address"], .["nat-settings"]["ipv6-address"], .["nat-settings"]["method"]'

objectstotal_hosts=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_hosts="$objectstotal_hosts"
export number_of_objects=$number_hosts

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# networks
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=networks
export APICLIobjectstype=networks
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"broadcast","subnet4","mask-length4","subnet6","mask-length6"'
export CSVFileHeader=$CSVFileHeader',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.method"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["broadcast"], .["subnet4"], .["mask-length4"], .["subnet6"], .["mask-length6"]'
export CSVJQparms=$CSVJQparms', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"], .["nat-settings"]["method"]'

objectstotal_networks=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_networks="$objectstotal_networks"
export number_of_objects=$number_networks

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# groups
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=groups
export APICLIobjectstype=groups
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'

export CSVJQparms='.["name"], .["color"], .["comments"]'

objectstotal_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_groups="$objectstotal_groups"
export number_of_objects=$number_groups

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=groups-with-exclusion
export APICLIobjectstype=groups-with-exclusion
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"include","except"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["include"]["name"], .["except"]["name"]'

objectstotal_groupswithexclusion=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_groupswithexclusion="$objectstotal_groupswithexclusion"
export number_of_objects=$number_groupswithexclusion

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# address-ranges
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=address-ranges
export APICLIobjectstype=address-ranges
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"ipv4-address-first","ipv4-address-last"'
export CSVFileHeader=$CSVFileHeader',"ipv6-address-first","ipv6-address-last"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["ipv4-address-first"], .["ipv4-address-last"]'
export CSVJQparms=$CSVJQparms', .["ipv6-address-first"], .["ipv6-address-last"]'

objectstotal_addressranges=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_addressranges="$objectstotal_addressranges"
export number_of_objects=$number_addressranges

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# multicast-address-ranges
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=multicast-address-range
export APICLIobjectstype=multicast-address-ranges

objectstotal_multicastaddressranges=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_multicastaddressranges="$objectstotal_multicastaddressranges"
export number_of_objects=$number_multicastaddressranges


# -------------------------------------------------------------------------------------------------
# dns-domains
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dns-domains
export APICLIobjectstype=dns-domains
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"is-sub-domain"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["is-sub-domain"]'

objectstotal_dnsdomains=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_dnsdomains="$objectstotal_dnsdomains"
export number_of_objects=$number_dnsdomains

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# security-zones
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=security-zones
export APICLIobjectstype=security-zones
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_securityzones=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_securityzones="$objectstotal_securityzones"
export number_of_objects=$number_securityzones

ExportObjectsToCSVviaJQ


# ADDED 2017-07-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Future objects to export to CSV
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# dynamic-objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_dynamicobjects=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_dynamicobjects="$objectstotal_dynamicobjects"
export number_of_objects=$number_dynamicobjects

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# simple-gateways
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_simplegateways=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_simplegateways="$objectstotal_simplegateways"
export number_of_objects=$number_simplegateways

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# times
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time
export APICLIobjectstype=times

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_times=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_times="$objectstotal_times"
export number_of_objects=$number_times

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# time_groups
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_time_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_time_groups="$objectstotal_time_groups"
export number_of_objects=$number_time_groups

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# access-roles
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_access_roles=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_access_roles="$objectstotal_access_roles"
export number_of_objects=$number_access_roles

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# opsec-applications
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_opsec_applications=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_opsec_applications="$objectstotal_opsec_applications"
export number_of_objects=$number_opsec_applications

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Services and Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#echo
#echo 'Services and Applications'
#echo
#echo >> $APICLIlogfilepath
#echo 'Services and Applications' >> $APICLIlogfilepath
#echo >> $APICLIlogfilepath

# -------------------------------------------------------------------------------------------------
# services-tcp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_tcp=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_services_tcp="$objectstotal_services_tcp"
export number_of_objects=$number_services_tcp

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_udp=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_services_udp="$objectstotal_services_udp"
export number_of_objects=$number_services_udp

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_icmp=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_services_icmp="$objectstotal_services_icmp"
export number_of_objects=$number_services_icmp

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_icmp6=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_services_icmp6="$objectstotal_services_icmp6"
export number_of_objects=$number_services_icmp6

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_sctp=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_services_sctp="$objectstotal_services_sctp"
export number_of_objects=$number_services_sctp

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_other=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_services_other="$objectstotal_services_other"
export number_of_objects=$number_services_other

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_dce_rpc=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_services_dce_rpc="$objectstotal_services_dce_rpc"
export number_of_objects=$number_services_dce_rpc

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_rpc=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_services_rpc="$objectstotal_services_rpc"
export number_of_objects=$number_services_rpc

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_service_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_service_groups="$objectstotal_service_groups"
export number_of_objects=$number_service_groups

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-sites
export APICLIobjectstype=application-sites

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_application_sites=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_application_sites="$objectstotal_application_sites"
export number_of_objects=$number_application_sites

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_application_site_categories=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_application_site_categories="$objectstotal_application_site_categories"
export number_of_objects=$number_application_site_categories

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-groups
export APICLIobjectstype=application-site-groups

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_application_site_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_application_site_groups="$objectstotal_application_site_groups"
export number_of_objects=$number_application_site_groups

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Identifying Data
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#echo
#echo 'Identifying Data'
#echo

# -------------------------------------------------------------------------------------------------
# tags
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=tags
export APICLIobjectstype=tags

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_tags=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_tags="$objectstotal_tags"
export number_of_objects=$number_tags

#ExportObjectsToCSVviaJQ

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-08-28


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# no more simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2017-08-03 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# group members
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group-members
export APICLIobjectstype=groups

# -------------------------------------------------------------------------------------------------
# SetupGetGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

#
# SetupGetGroupMembers

SetupGetGroupMembers () {

    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,2'
    
    export CSVFileHeader='"name","members.add"'
    
    SetupExportObjectsToCSVviaJQ
    
    return 0
}
    
# -------------------------------------------------------------------------------------------------
# FinalizeGetGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

#
# FinalizeGetGroupMembers

FinalizeGetGroupMembers () {

    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        exit $errorreturn
    fi
    
    return 0
}
    
# -------------------------------------------------------------------------------------------------
# PopulateArrayOfGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

#
# PopulateArrayOfGroupObjects generates an array of group objects for further processing.

PopulateArrayOfGroupObjects () {
    
    # MGMT_CLI_GROUPS_STRING is a string with multiple lines. Each line contains a name of a group members.
    # in this example the output of mgmt_cli is not sent to a file, instead it is passed to jq directly using a pipe.
    
    MGMT_CLI_GROUPS_STRING="`mgmt_cli show groups limit $APICLIObjectLimit offset $currentgroupoffset details-level "standard" -s $APICLIsessionfile --format json | $JQ ".objects[].name | @sh" -r`"
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    while read -r line; do
        ALLGROUPARR+=("$line")
        echo -n '.'
    done <<< "$MGMT_CLI_GROUPS_STRING"
    echo
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# GetArrayOfGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

#
# GetArrayOfGroupObjects generates an array of group objects for further processing.

GetArrayOfGroupObjects () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    echo
    echo 'Generate array of groups'
    echo
    
    ALLGROUPARR=()

    export MgmtCLI_Base_OpParms="--format json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    echo "Processing $objectstoshow $APICLIobjectstype objects in $APICLIObjectLimit object chunks:"

    objectslefttoshow=$objectstoshow

    currentgroupoffset=0
    
    while [ $objectslefttoshow -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currenthostoffset of $objectslefttoshow remainging!"

        PopulateArrayOfGroupObjects
        errorreturn=$?
        if [ $errorreturn != 0 ] ; then
            # Something went wrong, terminate
            exit $errorreturn
        fi

        objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
        currenthostoffset=`expr $currenthostoffset + $APICLIObjectLimit`
    done

    
    return 0
}


# -------------------------------------------------------------------------------------------------
# DumpArrayOfGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

#
# DumpArrayOfGroupObjects outputs the array of group objects.

DumpArrayOfGroupObjects () {
    
    # print the elements in the array
    echo
    echo groups
    echo
    #echo >> $APICLIlogfilepath
    #echo groups >> $APICLIlogfilepath
    #echo >> $APICLIlogfilepath
    
    for i in "${ALLGROUPARR[@]}"
    do
        if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
            # Verbose mode ON
            # Output list of all groups found
            echo "$i, ${i//\'/}"
        fi
        #echo "$i, ${i//\'/}" >> $APICLIlogfilepath
    done
    
    echo
    echo Done dumping groups
    echo
    #echo >> $APICLIlogfilepath
    #echo Done dumping groups >> $APICLIlogfilepath
    #echo >> $APICLIlogfilepath
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# CollectMembersInGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

#
# CollectMembersInGroupObjects outputs the number of group members in a group in the array of group objects and collects them into the csv file.

CollectMembersInGroupObjects () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo
    echo 'Use array of groups to generate group members CSV'
    echo
    #echo >> $APICLIlogfilepath
    #echo 'Use array of groups to export group members in each group' >> $APICLIlogfilepath
    #echo >> $APICLIlogfilepath
    
    for i in "${ALLGROUPARR[@]}"
    do
        echo
        echo group "${i//\'/}"
    
        MEMBERS_COUNT=$(mgmt_cli show group name "${i//\'/}" -s $APICLIsessionfile --format json | $JQ ".members | length")
    
        NUM_GROUP_MEMBERS=$MEMBERS_COUNT

        if [ $NUM_GROUP_MEMBERS -gt 0 ]; then
            # More than zero (0) interfaces, something to process
            echo Group "${i//\'/}"' number of members = '"$NUM_GROUP_MEMBERS"
            #echo Group "${i//\'/}"' number of members = '"$NUM_GROUP_MEMBERS" >> $APICLIlogfilepath
            
            COUNTER=0
            
            while [ $COUNTER -lt $NUM_GROUP_MEMBERS ]; do
                
                MEMBER_NAME=$(mgmt_cli show group name ${i//\'/} -s $APICLIsessionfile --format json | $JQ ".members[$COUNTER].name")
                
                #echo -n '.'
                
                echo ${i//\'/},$MEMBER_NAME >> $APICLICSVfiledata
                #echo ${i//\'/},$MEMBER_NAME >> $APICLIlogfilepath
                
                let COUNTER=COUNTER+1
                
            done
            
        else
            echo
        fi

    done
    
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# GetGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

#
# GetGroupMembers generate output of group members from existing group objects

GetGroupMembers () {

    SetupGetGroupMembers

    GetArrayOfGroupObjects

    DumpArrayOfGroupObjects

    CollectMembersInGroupObjects

    FinalizeGetGroupMembers

}
    
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

objectstotal_groups=$(mgmt_cli show groups limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_groups="$objectstotal_groups"

if [ $number_groups -le 0 ] ; then
    # No groups found
    echo
    echo 'No groups to generate members from!'
    echo
    echo >> $APICLIlogfilepath
    echo 'No groups to generate members from!' >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
else
    GetGroupMembers
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-08-03
# ADD 2017-08-03  \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#
# -------------------------------------------------------------------------------------------------
# host interfaces
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=host-interfaces
export APICLIobjectstype=hosts

# -------------------------------------------------------------------------------------------------
# SetupGetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

#
# SetupGetHostInterfaces

SetupGetHostInterfaces () {

    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","interfaces.add.name"'
    #export CSVFileHeader=$CSVFileHeader',"interfaces.add.subnet4","interfaces.add.mask-length4","interfaces.add.subnet-mask"'
    export CSVFileHeader=$CSVFileHeader',"interfaces.add.subnet4","interfaces.add.mask-length4"'
    export CSVFileHeader=$CSVFileHeader',"interfaces.add.subnet6","interfaces.add.mask-length6"'
    export CSVFileHeader=$CSVFileHeader',"interfaces.add.color","interfaces.add.comments"'
    
    export CSVJQparms='.["name"], .["interfaces"]['$COUNTER']["name"]'
    #export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet4"], .["interfaces"]['$COUNTER']["mask-length4"], .["interfaces"]['$COUNTER']["subnet-mask"]'
    export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet4"], .["interfaces"]['$COUNTER']["mask-length4"]'
    export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet6"], .["interfaces"]['$COUNTER']["mask-length6"]'
    export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["color"], .["interfaces"]['$COUNTER']["comments"]'

    SetupExportObjectsToCSVviaJQ
    
    return 0
}
    
# -------------------------------------------------------------------------------------------------
# FinalizeGetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

#
# FinalizeGetHostInterfaces

FinalizeGetHostInterfaces () {

    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        exit $errorreturn
    fi
    
    return 0
}
    
# -------------------------------------------------------------------------------------------------
# PopulateArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

#
# PopulateArrayOfHostInterfaces populates array of host objects for further processing.

PopulateArrayOfHostInterfaces () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #

    # MGMT_CLI_HOSTS_STRING is a string with multiple lines. Each line contains a name of a host.
    # in this example the output of mgmt_cli is not sent to a file, instead it is passed to jq directly using a pipe.
    
    MGMT_CLI_HOSTS_STRING="`mgmt_cli show hosts limit $APICLIObjectLimit offset $currenthostoffset details-level "standard" -s $APICLIsessionfile --format json | $JQ ".objects[].name | @sh" -r`"
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    while read -r line; do

        ALLHOSTSARR+=("$line")

        echo -n '.'

        arraylength=${#ALLHOSTSARR[@]}
        arrayelement=$((arraylength-1))
        

        if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
            # Verbose mode ON
            # Output list of all hosts found
            echo -n "$line"' '
            echo -n "$(eval echo $line)"' '
            echo -n "$arraylength"' '
            echo -n "$arrayelement"' '
            #echo -n "$(eval echo ${ALLHOSTARR[${arrayelement}]})"' '
        fi

        #INTERFACES_COUNT=$(mgmt_cli show host name "$(eval echo ${ALLHOSTARR[${arrayelement}]})" details-level "full" -s $APICLIsessionfile --format json | $JQ ".interfaces | length")
        INTERFACES_COUNT=$(mgmt_cli show host name "$(eval echo $line)" details-level "full" -s $APICLIsessionfile --format json | $JQ ".interfaces | length")

        NUM_HOST_INTERFACES=$INTERFACES_COUNT

        if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
            # Verbose mode ON
            echo -n $NUM_HOST_INTERFACES' '
        fi

        if [ $NUM_HOST_INTERFACES -gt 0 ]; then
            HOSTSARR+=("$line")
            if [ x"$APISCRIPTVERBOSE" != x"TRUE" ] ; then
                echo -n $NUM_HOST_INTERFACES
            fi
            echo -n '!'
        fi

         if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
            # Verbose mode ON
            echo
        fi

    done <<< "$MGMT_CLI_HOSTS_STRING"
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# GetArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

#
# GetArrayOfHostInterfaces generates an array of host objects for further processing.

GetArrayOfHostInterfaces () {
    
    echo
    echo 'Generate array of hosts'
    echo
    
    HOSTSARR=()
    ALLHOSTSARR=()

    export MgmtCLI_Base_OpParms="--format json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    echo "Processing $objectstoshow $APICLIobjectstype objects in $APICLIObjectLimit object chunks:"

    objectslefttoshow=$objectstoshow

    currenthostoffset=0

    while [ $objectslefttoshow -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currenthostoffset of $objectslefttoshow remainging!"

        PopulateArrayOfHostInterfaces
        errorreturn=$?
        if [ $errorreturn != 0 ] ; then
            # Something went wrong, terminate
            exit $errorreturn
        fi

        objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
        currenthostoffset=`expr $currenthostoffset + $APICLIObjectLimit`
    done

    echo
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# DumpArrayOfHostsObjects proceedure
# -------------------------------------------------------------------------------------------------

#
# DumpArrayOfHostsObjects outputs the array of host objects.

DumpArrayOfHostsObjects () {
    
    # print the elements in the array
    echo
    echo All hosts
    echo
    #echo >> $APICLIlogfilepath
    #echo All hosts >> $APICLIlogfilepath
    #echo >> $APICLIlogfilepath
    
    for i in "${ALLHOSTSARR[@]}"
    do
        if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
            # Verbose mode ON
            # Output list of all hosts found
            echo "$i, ${i//\'/}"
        fi
        #echo "$i, ${i//\'/}" >> $APICLIlogfilepath
    done
    
    echo
    echo hosts with interfaces defined
    echo
    #echo >> $APICLIlogfilepath
    #echo hosts with interfaces defined >> $APICLIlogfilepath
    #echo >> $APICLIlogfilepath
    
    for j in "${HOSTSARR[@]}"
    do
        echo "$j, ${j//\'/}"
        #echo "$j, ${j//\'/}" >> $APICLIlogfilepath
    done
    
    echo
    echo Done dumping hosts
    echo
    #echo >> $APICLIlogfilepath
    #echo Done dumping hosts >> $APICLIlogfilepath
    #echo >> $APICLIlogfilepath
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjects proceedure
# -------------------------------------------------------------------------------------------------

#
# CollectInterfacesInHostObjects outputs the host interfaces in a host in the array of host objects and collects them into the csv file.

CollectInterfacesInHostObjects () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo
    echo 'Use array of hosts to generate host interfaces CSV'
    echo
    #echo >> $APICLIlogfilepath
    #echo 'Use array of hosts to export interfaces in each host' >> $APICLIlogfilepath
    #echo >> $APICLIlogfilepath
    
    for i in "${HOSTSARR[@]}"
    do
        echo
        echo Host with interfaces "${i//\'/}"
    
        INTERFACES_COUNT=$(mgmt_cli show host name "${i//\'/}" -s $APICLIsessionfile --format json | $JQ ".interfaces | length")

        NUM_HOST_INTERFACES=$INTERFACES_COUNT
    
        if [ $NUM_HOST_INTERFACES -gt 0 ]; then
            # More than zero (0) interfaces, something to process
            echo host "${i//\'/}"' number of interfaces = '"$NUM_HOST_INTERFACES"
            #echo host "${i//\'/}"' number of interfaces = '"$NUM_HOST_INTERFACES" >> $APICLIlogfilepath
       
            COUNTER=0
            echo $CSVFileHeader
            
            while [ $COUNTER -lt $NUM_HOST_INTERFACES ]; do
        
                #echo -n '.'
    
                #export CSVJQparms='.["name"], .["interfaces"]['$COUNTER']["name"]'
                ##export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet4"], .["interfaces"]['$COUNTER']["mask-length4"], .["interfaces"]['$COUNTER']["subnet-mask"]'
                #export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet4"], .["interfaces"]['$COUNTER']["mask-length4"],
                #export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet6"], .["interfaces"]['$COUNTER']["mask-length6"]'
                #export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["color"], .["interfaces"]['$COUNTER']["comments"]'

                #mgmt_cli show host name BeasleyQNAP-01 details-level "full" --format json -r true | $CPDIR/jq/jq '.["interfaces"][0]["mask-length4"]'

                INTERFACE_NAME=$(mgmt_cli show host name ${i//\'/} -s $APICLIsessionfile --format json | $JQ '.["interfaces"]['$COUNTER']["name"]')
                INTERFACE_subnet4=$(mgmt_cli show host name ${i//\'/} -s $APICLIsessionfile --format json | $JQ '.["interfaces"]['$COUNTER']["subnet4"]')
                INTERFACE_masklength4=$(mgmt_cli show host name ${i//\'/} -s $APICLIsessionfile --format json | $JQ '.["interfaces"]['$COUNTER']["mask-length4"]')
                INTERFACE_subnetmask=$(mgmt_cli show host name ${i//\'/} -s $APICLIsessionfile --format json | $JQ '.["interfaces"]['$COUNTER']["subnet-mask"]')
                INTERFACE_subnet6=$(mgmt_cli show host name ${i//\'/} -s $APICLIsessionfile --format json | $JQ '.["interfaces"]['$COUNTER']["subnet6"]')
                INTERFACE_masklength6=$(mgmt_cli show host name ${i//\'/} -s $APICLIsessionfile --format json | $JQ '.["interfaces"]['$COUNTER']["mask-length6"]')
                INTERFACE_COLOR=$(mgmt_cli show host name ${i//\'/} -s $APICLIsessionfile --format json | $JQ '.["interfaces"]['$COUNTER']["color"]')
                INTERFACE_COMMENT=$(mgmt_cli show host name ${i//\'/} -s $APICLIsessionfile --format json | $JQ '.["interfaces"]['$COUNTER']["comments"]')
                
                export CSVoutputline="${i//\'/}","$INTERFACE_NAME"
                #export CSVoutputline=$CSVoutputline,"$INTERFACE_subnet4","$INTERFACE_masklength4","$INTERFACE_subnetmask"
                export CSVoutputline=$CSVoutputline,"$INTERFACE_subnet4","$INTERFACE_masklength4"
                export CSVoutputline=$CSVoutputline,"$INTERFACE_subnet6","$INTERFACE_masklength6"
                export CSVoutputline=$CSVoutputline,"$INTERFACE_COLOR","$INTERFACE_COMMENT"
                
                echo $CSVoutputline
                echo $CSVoutputline >> $APICLICSVfiledata
                #echo $CSVoutputline >> $APICLIlogfilepath
        
                let COUNTER=COUNTER+1
        
            done
        else
            echo
        fi
    
    done
    
    
    return 0
}


# -------------------------------------------------------------------------------------------------
# GetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

#
# GetHostInterfaces generate output of host's interfaces from existing hosts with interface objects

GetHostInterfaces () {

    SetupGetHostInterfaces

    GetArrayOfHostInterfaces

    DumpArrayOfHostsObjects

    CollectInterfacesInHostObjects

    FinalizeGetHostInterfaces

}
    
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

objectstotal_hosts=$(mgmt_cli show hosts limit 1 offset 0 details-level "standard" --format json -s $APICLIsessionfile | $JQ ".total")
export number_hosts="$objectstotal_hosts"

if [ $number_hosts -le 0 ] ; then
    # No hosts found
    echo
    echo 'No hosts to generate interfaces from!'
    echo
    echo >> $APICLIlogfilepath
    echo 'No hosts to generate interfaces from!' >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
else
    GetHostInterfaces
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\  ADD 2017-08-03


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# no more complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# no more objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo $APICLIdetaillvl' CSV dump - Completed!'
echo

echo
echo

# =================================================================================================
# END:  Export objects to csv
# =================================================================================================
# =================================================================================================

