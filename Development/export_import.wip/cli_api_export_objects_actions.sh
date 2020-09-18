#!/bin/bash
#
# SCRIPT Object dump action operations for API CLI Operations
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

export APIActionsScriptVersion=v${ScriptVersion//./x}
export APIActionScriptTemplateVersion=v${TemplateVersion//./x}
ActionScriptName=cli_api_export_objects_actions

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
# START:  Export objects to json in set detail level from root script
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


# =================================================================================================
# START:  Local Proceedures
# =================================================================================================

export APICLIActionstemplogfilepath=/var/tmp/$ScriptName'_'$APIScriptVersion'_temp_'$DATEDTGS.log

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


# =================================================================================================
# END:  Local Proceedures
# =================================================================================================


# ADDED 2018-04-25 -
export primarytargetoutputformat=$FileExtJSON


# =================================================================================================
# Start executing Main operations
# =================================================================================================

# MODIFIED 2018-05-04-4 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export templogfilepath=/var/tmp/templog_$ScriptName.`date +%Y%m%d-%H%M%S%Z`.log
echo > $templogfilepath

echo 'Configure working paths for export and dump' >> $templogfilepath
echo >> $templogfilepath

echo "domainnamenospace = '$domainnamenospace' " >> $templogfilepath
echo "CLIparm_NODOMAINFOLDERS = '$CLIparm_NODOMAINFOLDERS' " >> $templogfilepath
echo "primarytargetoutputformat = '$primarytargetoutputformat' " >> $templogfilepath
echo "APICLICSVExportpathbase = '$APICLICSVExportpathbase' " >> $templogfilepath
echo "APICLIpathexport = '$APICLIpathexport' " >> $templogfilepath

# ------------------------------------------------------------------------

if [ ! -z "$domainnamenospace" ] && [ "$CLIparm_NODOMAINFOLDERS" != "true" ] ; then
    # Handle adding domain name to path for MDM operations
    export APICLIpathexport=$APICLICSVExportpathbase/$domainnamenospace

    echo 'Handle adding domain name to path for MDM operations' >> $templogfilepath
    echo "APICLIpathexport = '$APICLIpathexport' " >> $templogfilepath

    if [ ! -r $APICLIpathexport ] ; then
        mkdir -p -v $APICLIpathexport >> $templogfilepath
    fi
else
    # NOT adding domain name to path for MDM operations
    export APICLIpathexport=$APICLICSVExportpathbase

    echo 'NOT adding domain name to path for MDM operations' >> $templogfilepath
    echo "APICLIpathexport = '$APICLIpathexport' " >> $templogfilepath

    if [ ! -r $APICLIpathexport ] ; then
        mkdir -p -v $APICLIpathexport >> $templogfilepath
    fi
fi

# ------------------------------------------------------------------------

# primary operation is export to primarytargetoutputformat
export APICLIpathexport=$APICLIpathexport/$primarytargetoutputformat

echo | tee -a -i $APICLIlogfilepath $templogfilepath
echo 'Export to '$primarytargetoutputformat' Starting!' | tee -a -i $APICLIlogfilepath $templogfilepath

if [ ! -r $APICLIpathexport ] ; then
    mkdir -p -v $APICLIpathexport >> $templogfilepath
fi

echo >> $templogfilepath
echo 'After Evaluation of script type' >> $templogfilepath
echo "APICLIpathexport = '$APICLIpathexport' " >> $templogfilepath
echo " = '$' " >> $templogfilepath

# ------------------------------------------------------------------------

if [ x"$primarytargetoutputformat" = x"$FileExtJSON" ] ; then
    # for JSON provide the detail level

    export APICLIpathexport=$APICLIpathexport/$APICLIdetaillvl

    if [ ! -r $APICLIpathexport ] ; then
        mkdir -p -v $APICLIpathexport >> $templogfilepath
    fi

    export APICLIJSONpathexportwip=
    if [ x"$script_uses_wip_json" = x"true" ] ; then
        # script uses work-in-progress (wip) folder for json
    
        export APICLIJSONpathexportwip=$APICLIpathexport/wip
        
        if [ ! -r $APICLIJSONpathexportwip ] ; then
            mkdir -p -v $APICLIJSONpathexportwip >> $templogfilepath
        fi
    fi
else    
    export APICLIJSONpathexportwip=
fi

echo >> $templogfilepath
echo 'After handling json target' >> $templogfilepath
echo "APICLIpathexport = '$APICLIpathexport' " >> $templogfilepath
echo "APICLIJSONpathexportwip = '$APICLIJSONpathexportwip' " >> $templogfilepath

# ------------------------------------------------------------------------

if [ x"$primarytargetoutputformat" = x"$FileExtCSV" ] ; then
    # for CSV handle specifics, like wip

    export APICLICSVpathexportwip=
    if [ x"$script_uses_wip" = x"true" ] ; then
        # script uses work-in-progress (wip) folder for csv
    
        export APICLICSVpathexportwip=$APICLIpathexport/wip
        
        if [ ! -r $APICLICSVpathexportwip ] ; then
            mkdir -p -v $APICLICSVpathexportwip >> $templogfilepath
        fi
    fi
else
    export APICLICSVpathexportwip=
fi

echo >> $templogfilepath
echo 'After handling csv target' >> $templogfilepath
echo "APICLIpathexport = '$APICLIpathexport' " >> $templogfilepath
echo "APICLICSVpathexportwip = '$APICLICSVpathexportwip' " >> $templogfilepath

# ------------------------------------------------------------------------

export APICLIfileexportpost='_'$APICLIdetaillvl'_'$APICLIfileexportsuffix

export APICLICSVheaderfilesuffix=header

export APICLICSVfileexportpost='_'$APICLIdetaillvl'_'$APICLICSVfileexportsuffix

export APICLIJSONheaderfilesuffix=header
export APICLIJSONfooterfilesuffix=footer

export APICLIJSONfileexportpost='_'$APICLIdetaillvl'_'$APICLIJSONfileexportsuffix

echo >> $templogfilepath
echo 'Setup other file and path variables' >> $templogfilepath
echo "APICLIfileexportpost = '$APICLIfileexportpost' " >> $templogfilepath
echo "APICLICSVheaderfilesuffix = '$APICLICSVheaderfilesuffix' " >> $templogfilepath
echo "APICLICSVfileexportpost = '$APICLICSVfileexportpost' " >> $templogfilepath
echo "APICLIJSONheaderfilesuffix = '$APICLIJSONheaderfilesuffix' " >> $templogfilepath
echo "APICLIJSONfooterfilesuffix = '$APICLIJSONfooterfilesuffix' " >> $templogfilepath
echo "APICLIJSONfileexportpost = '$APICLIJSONfileexportpost' " >> $templogfilepath

# ------------------------------------------------------------------------

echo >> $templogfilepath

cat $templogfilepath >> $APICLIlogfilepath
rm -v $templogfilepath >> $APICLIlogfilepath

# ------------------------------------------------------------------------

echo 'Dump "'$APICLIdetaillvl'" details to path:  '$APICLIpathexport | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04-4


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Main Operational repeated proceedures - Export Objects to raw JSON
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportRAWObjectToJSON
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The Main Operational Procedure is the meat of the script's repeated actions.
#
# For this script the $APICLIobjecttype details is exported to a json at the $APICLIdetaillvl.

ExportRAWObjectToJSON () {
    #
    # Export Objects to raw JSON
    #
    
    # MODIFIED 2018-07-20 -
    
    # System Object selection operands
    # This one won't work because upgrades set all objects to creator = System"
    # export notsystemobjectselector='select(."meta-info"."creator" != "System")'
    #export notsystemobjectselector='select(."meta-info"."creator" | contains ("System") | not)'
    #
    # This should work if assumptions aren't wrong
    #export notsystemobjectselector='select(."domain"."name" != "Check Point Data")'
    
    #
    # This should work, but might need more tweeks if other data types use more values
    #export notsystemobjectselector='select(."domain"."name" | contains ("Check Point Data", "APPI Data", "IPS Data") | not)'
    #export notsystemobjectselector='select(any(."domain"."name"; in("Check Point Data", "APPI Data", "IPS Data")) | not)'
    #export notsystemobjectselector='select((."domain"."name" != "Check Point Data") and (."domain"."name" != "APPI Data") and (."domain"."name" != "IPS Data"))'
    
    #
    # Future alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['$systemobjectdomains'] | index($a) | not)'
    
    export APICLIfilename=$APICLIobjectstype
    if [ x"$APICLIexportnameaddon" != x"" ] ; then
        export APICLIfilename=$APICLIfilename'_'$APICLIexportnameaddon
    fi

    export APICLIfileexport=$APICLIpathexport/$APICLIfileexportpre$APICLIfilename$APICLIfileexportpost

    export MgmtCLI_Base_OpParms="-f json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    if [ $objectstoshow -le 0 ] ; then
        echo "Found $objectstoshow $APICLIobjecttype objects.  No objects found!  Skipping!..." | tee -a -i $APICLIlogfilepath
    else
    
        echo | tee -a -i $APICLIlogfilepath
        echo "Processing $objectstoshow $APICLIobjecttype objects in $APICLIObjectLimit object chunks:" | tee -a -i $APICLIlogfilepath

        objectslefttoshow=$objectstoshow
        currentoffset=0
    
        while [ $objectslefttoshow -ge 1 ] ; do
            # we have objects to process
    
            nextoffset=`expr $currentoffset + $APICLIObjectLimit`

            #if [ $currentoffset -gt 0 ] ; then
            #    # Export file for the next $APICLIObjectLimit objects
            #    export APICLIfileexport=$APICLIpathexport/$APICLIfileexportpre$APICLIobjectstype'_'$currentoffset'_'$APICLIfileexportpost
            #fi
    
            # 2017-11-20 Updating naming of files for multiple $APICLIObjectLimit chunks to clean-up name listing
            if [ $objectstotal -gt $APICLIObjectLimit ] ; then
                # Export file for the next $APICLIObjectLimit objects
                export APICLIfilename=$APICLIobjectstype
                if [ x"$APICLIexportnameaddon" != x"" ] ; then
                    export APICLIfilename=$APICLIfilename'_'$APICLIexportnameaddon
                fi

                #export APICLIfilename=$APICLIfilename'_'$currentoffset'-'$nextoffset'_of_'$objectstotal

                currentoffsetformatted=`printf "%05d" $currentoffset`
                nextoffsetformatted=`printf "%05d" $nextoffset`
                objectstotalformatted=`printf "%05d" $objectstotal`
                export APICLIfilename=$APICLIfilename'_'$currentoffsetformatted'-'$nextoffsetformatted'_of_'$objectstotalformatted

                #export APICLIfileexport=$APICLIpathexport/$APICLIfileexportpre$APICLIobjectstype'_'$currentoffset'_'$APICLIfileexportpost
                export APICLIfileexport=$APICLIpathexport/$APICLIfileexportpre$APICLIfilename$APICLIfileexportpost
            fi
    
            echo "  Now processing up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currentoffset to $nextoffset of $objectslefttoshow remaining!" | tee -a -i $APICLIlogfilepath
            echo '    Dump to '$APICLIfileexport | tee -a -i $APICLIlogfilepath

            # MODIFIED 2018-07-20 -
                
            if [ x"$NoSystemObjects" = x"true" ] ; then
                # Ignore System Objects
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    echo '      No System Objects.  Selector = '$notsystemobjectselector | tee -a -i $APICLIlogfilepath
                fi
                mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms | $JQ '.objects[] | '"$notsystemobjectselector" >> $APICLIfileexport
            else   
                # Don't Ignore System Objects
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    echo '      All objects, including System Objects' | tee -a -i $APICLIlogfilepath
                fi
                mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms >> $APICLIfileexport
            fi
            
            objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
            #currentoffset=`expr $currentoffset + $APICLIObjectLimit`
            currentoffset=$nextoffset
    
        done
    
    
        echo | tee -a -i $APICLIlogfilepath
        tail $APICLIfileexport | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi
    
    echo | tee -a -i $APICLIlogfilepath
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-03-05

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# END : Main Operational repeated proceedures - Export Objects to raw JSON
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# host objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=network
export APICLIobjectstype=networks
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group-with-exclusion
export APICLIobjectstype=groups-with-exclusion
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=address-range
export APICLIobjectstype=address-ranges
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# multicast-address-ranges objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=multicast-address-range
export APICLIobjectstype=multicast-address-ranges
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dns-domain
export APICLIobjectstype=dns-domains
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# security-zones objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# dynamic-object objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# simple-gateway objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# time objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time
export APICLIobjectstype=times
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# time-group objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# access-role objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# opsec-application objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


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
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


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
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON


# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON



# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Users
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo 'Users'
echo
echo >> $APICLIlogfilepath
echo 'Users' >> $APICLIlogfilepath
echo >> $APICLIlogfilepath

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# users
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=users
export APICLIobjectstype=users
export APICLICSVobjecttype=$APICLIobjectstype
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-groups
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user-groups
export APICLIobjectstype=user-groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-templates
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user-templates
export APICLIobjectstype=user-templates
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# identity-tags
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=identity-tags
export APICLIobjectstype=identity-tags
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

ExportRAWObjectToJSON

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# no more simple objects
# -------------------------------------------------------------------------------------------------

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19
# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# handle complex objects
# -------------------------------------------------------------------------------------------------

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19
# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# no more complex objects
# -------------------------------------------------------------------------------------------------

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# -------------------------------------------------------------------------------------------------
# no more objects
# -------------------------------------------------------------------------------------------------

echo | tee -a -i $APICLIlogfilepath
echo $APICLIdetaillvl' - Completed!' | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

echo | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

return 0

# =================================================================================================
# END:  Export objects to json in set detail level from root script
# =================================================================================================
# =================================================================================================

