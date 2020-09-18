#!/bin/bash
#
# SCRIPT Object dump to CSV action operations for API CLI Operations
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
ScriptVersion=00.50.00
ScriptRevision=055
ScriptDate=2020-09-10
TemplateVersion=00.50.00
CommonScriptsVersion=00.50.00
CommonScriptsRevision=006

#

export APIActionsScriptVersion=v${ScriptVersion//./x}
export APIActionScriptTemplateVersion=v${TemplateVersion//./x}
ActionScriptName=cli_api_export_objects_actions_to_csv

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
# START:  Export objects to csv
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


# =================================================================================================
# END:  Local Proceedures
# =================================================================================================


# ADDED 2018-04-25 -
export primarytargetoutputformat=$FileExtCSV


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


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportObjectsToCSVviaJQ () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    
    export APICLICSVfilename=$APICLIobjectstype
    if [ x"$APICLIexportnameaddon" != x"" ] ; then
        export APICLICSVfilename=$APICLICSVfilename'_'$APICLIexportnameaddon
    fi
    export APICLICSVfilename=$APICLICSVfilename'_'$APICLIdetaillvl'_csv'$APICLICSVfileexportsuffix
    export APICLICSVfile=$APICLIpathexport/$APICLICSVfilename
    export APICLICSVfilewip=$APICLICSVpathexportwip/$APICLICSVfilename
    export APICLICSVfileheader=$APICLICSVfilewip.$APICLICSVheaderfilesuffix
    export APICLICSVfiledata=$APICLICSVfilewip.data
    export APICLICSVfilesort=$APICLICSVfilewip.sort
    export APICLICSVfileoriginal=$APICLICSVfilewip.original

    
    if [ ! -r $APICLICSVpathexportwip ] ; then
        mkdir -p -v $APICLICSVpathexportwip | tee -a -i $APICLIlogfilepath
    fi

    if [ -r $APICLICSVfile ] ; then
        rm $APICLICSVfile >> $APICLIlogfilepath
    fi
    if [ -r $APICLICSVfileheader ] ; then
        rm $APICLICSVfileheader >> $APICLIlogfilepath
    fi
    if [ -r $APICLICSVfiledata ] ; then
        rm $APICLICSVfiledata >> $APICLIlogfilepath
    fi
    if [ -r $APICLICSVfilesort ] ; then
        rm $APICLICSVfilesort >> $APICLIlogfilepath
    fi
    if [ -r $APICLICSVfileoriginal ] ; then
        rm $APICLICSVfileoriginal >> $APICLIlogfilepath
    fi
    
    echo | tee -a -i $APICLIlogfilepath
    echo "Creat $APICLIobjectstype CSV File : $APICLICSVfile" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    #
    # Troubleshooting output
    #
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        echo | tee -a -i $APICLIlogfilepath
        echo '$CSVFileHeader' - $CSVFileHeader | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    
    fi
    
    echo $CSVFileHeader > $APICLICSVfileheader | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    echo | tee -a -i $APICLIlogfilepath
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# The FinalizeExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeExportObjectsToCSVviaJQ () {
    #
    # The FinalizeExportObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
    #

    if [ ! -r "$APICLICSVfileheader" ] ; then
        # Uh, Oh, something went wrong, no header file
        echo | tee -a -i $APICLIlogfilepath
        echo '!!!! Error header file missing : '$APICLICSVfileheader | tee -a -i $APICLIlogfilepath
        echo 'Terminating!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return 254
        
    elif [ ! -r "$APICLICSVfiledata" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo | tee -a -i $APICLIlogfilepath
        echo '!!!! Error data file missing : '$APICLICSVfiledata | tee -a -i $APICLIlogfilepath
        echo 'Terminating!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return 253
        
    elif [ ! -s "$APICLICSVfiledata" ] ; then
        # data file is empty, nothing was found
        echo | tee -a -i $APICLIlogfilepath
        echo '!! data file is empty : '$APICLICSVfiledata | tee -a -i $APICLIlogfilepath
        echo 'Skipping CSV creation!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return 0
        
    fi

    echo | tee -a -i $APICLIlogfilepath
    echo "Sort data and build CSV export file" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    cat $APICLICSVfileheader > $APICLICSVfileoriginal
    cat $APICLICSVfiledata >> $APICLICSVfileoriginal
    
    sort $APICLICSVsortparms $APICLICSVfiledata > $APICLICSVfilesort
    
    cat $APICLICSVfileheader > $APICLICSVfile
    cat $APICLICSVfilesort >> $APICLICSVfile
    
    echo | tee -a -i $APICLIlogfilepath
    echo "Done creating $APICLIobjectstype CSV File : $APICLICSVfile" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    head $APICLICSVfile | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
   
    
    echo | tee -a -i $APICLIlogfilepath
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportObjectsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the $APICLIobjectstype item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectsToCSVviaJQ () {
    #
    
    if [[ $number_of_objects -lt 1 ]] ; then
        # no objects of this type
 
        echo "No objects of type $APICLIobjecttype to process, skipping..." | tee -a -i $APICLIlogfilepath

        return 0
       
    else
        # we have objects to handle
        echo "Processing $number_of_objects $APICLIobjecttype objects..." | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi

    SetupExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure SetupExportObjectsToCSVviaJQ! error return = '$errorreturn | tee -a -i $APICLIlogfilepath
        return $errorreturn
    fi
    
    export MgmtCLI_Base_OpParms="-f json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"full\" $MgmtCLI_Base_OpParms"
    
    # MODIFIED 2018-07-20 -
    
    # System Object selection operands
    # This one won't work because upgrades set all objects to creator = System"
    #export notsystemobjectselector='select(."meta-info"."creator" | contains ("System") | not)'
    #
    # This should work if assumptions aren't wrong (not complete enough based on object type)
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
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")

    objectstoshow=$objectstotal

    echo "Processing $objectstoshow $APICLIobjecttype objects in $APICLIObjectLimit object chunks:" | tee -a -i $APICLIlogfilepath

    objectslefttoshow=$objectstoshow
    currentoffset=0

    echo | tee -a -i $APICLIlogfilepath
    echo "Export $APICLIobjectstype to CSV File" | tee -a -i $APICLIlogfilepath
    echo "  and dump to $APICLICSVfile" | tee -a -i $APICLIlogfilepath
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        echo "  mgmt_cli parameters : $MgmtCLI_Show_OpParms" | tee -a -i $APICLIlogfilepath
        echo '  $CSVJQparms' - $CSVJQparms | tee -a -i $APICLIlogfilepath
        echo "  System Object Selector : "$notsystemobjectselector | tee -a -i $APICLIlogfilepath
    fi
    echo | tee -a -i $APICLIlogfilepath

    while [ $objectslefttoshow -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currentoffset of $objectslefttoshow remaining!" | tee -a -i $APICLIlogfilepath

        #mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms | $JQ '.objects[] | [ '"$CSVJQparms"' ] | @csv' -r >> $APICLICSVfiledata
        #errorreturn=$?

        if [ x"$NoSystemObjects" = x"true" ] ; then
            # Ignore System Objects
            #mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms | $JQ '.objects[] | select(."meta-info"."creator" != "System") | [ '"$CSVJQparms"' ] | @csv' -r >> $APICLICSVfiledata
            mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms | $JQ '.objects[] | '"$notsystemobjectselector"' | [ '"$CSVJQparms"' ] | @csv' -r >> $APICLICSVfiledata
            errorreturn=$?
        else   
            # Don't Ignore System Objects
            mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currentoffset $MgmtCLI_Show_OpParms | $JQ '.objects[] | [ '"$CSVJQparms"' ] | @csv' -r >> $APICLICSVfiledata
            errorreturn=$?
        fi

        if [ $errorreturn != 0 ] ; then
            # Something went wrong, terminate
            echo 'Problem during mgmt_cli operation! error return = '$errorreturn | tee -a -i $APICLIlogfilepath
            return $errorreturn
        fi

        objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
        currentoffset=`expr $currentoffset + $APICLIObjectLimit`
    done

    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure FinalizeExportObjectsToCSVviaJQ! error return = '$errorreturn | tee -a -i $APICLIlogfilepath
        return $errorreturn
    fi
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        echo
        echo "Done with Exporting $APICLIobjectstype to CSV File : $APICLICSVfile" | tee -a -i $APICLIlogfilepath
    
        if [ "$CLIparm_NOWAIT" != "true" ] ; then
            read -t $WAITTIME -n 1 -p "Any key to continue.  Automatic continue after $WAITTIME seconds : " anykey
        fi
    
    fi
    
    echo | tee -a -i $APICLIlogfilepath
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# GetNumberOfObjectsviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetNumberOfObjectsviaJQ () {
    #
    # The GetNumberOfObjectsviaJQ obtains the number of objects for that object type indicated.
    #
    
    export objectstotal=
    
    #
    # Troubleshooting output
    #
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        echo | tee -a -i $APICLIlogfilepath
        echo 'Get objectstotal of object type '$APICLIobjectstype | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
    errorreturn=$?

    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem during mgmt_cli objectstotal operation! error return = '$errorreturn | tee -a -i $APICLIlogfilepath
        return $errorreturn
    fi
    
    export number_of_objects=$objectstotal

    echo | tee -a -i $APICLIlogfilepath
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04

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

export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"ipv4-address","ipv6-address"'
export CSVFileHeader=$CSVFileHeader',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.ipv4-address","nat-settings.ipv6-address","nat-settings.method"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["ipv4-address"], .["ipv6-address"]'
export CSVJQparms=$CSVJQparms', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"]'
export CSVJQparms=$CSVJQparms', .["nat-settings"]["ipv4-address"], .["nat-settings"]["ipv6-address"], .["nat-settings"]["method"]'

objectstotal_hosts=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_hosts="$objectstotal_hosts"
export number_of_objects=$number_hosts

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# networks
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=network
export APICLIobjectstype=networks
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"broadcast","subnet4","mask-length4","subnet6","mask-length6"'
export CSVFileHeader=$CSVFileHeader',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.method"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["broadcast"], .["subnet4"], .["mask-length4"], .["subnet6"], .["mask-length6"]'
export CSVJQparms=$CSVJQparms', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"], .["nat-settings"]["method"]'

objectstotal_networks=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_networks="$objectstotal_networks"
export number_of_objects=$number_networks

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# groups
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'

objectstotal_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_groups="$objectstotal_groups"
export number_of_objects=$number_groups

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group-with-exclusion
export APICLIobjectstype=groups-with-exclusion
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"include","except"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["include"]["name"], .["except"]["name"]'

objectstotal_groupswithexclusion=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_groupswithexclusion="$objectstotal_groupswithexclusion"
export number_of_objects=$number_groupswithexclusion

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# address-ranges
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=address-range
export APICLIobjectstype=address-ranges
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"ipv4-address-first","ipv4-address-last"'
export CSVFileHeader=$CSVFileHeader',"ipv6-address-first","ipv6-address-last"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["ipv4-address-first"], .["ipv4-address-last"]'
export CSVJQparms=$CSVJQparms', .["ipv6-address-first"], .["ipv6-address-last"]'

objectstotal_addressranges=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_addressranges="$objectstotal_addressranges"
export number_of_objects=$number_addressranges

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# multicast-address-ranges
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=multicast-address-range
export APICLIobjectstype=multicast-address-ranges
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"ipv4-address-first","ipv4-address-last"'
export CSVFileHeader=$CSVFileHeader',"ipv6-address-first","ipv6-address-last"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["ipv4-address-first"], .["ipv4-address-last"]'
export CSVJQparms=$CSVJQparms', .["ipv6-address-first"], .["ipv6-address-last"]'

objectstotal_multicastaddressranges=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_multicastaddressranges="$objectstotal_multicastaddressranges"
export number_of_objects=$number_multicastaddressranges

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# dns-domains
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dns-domain
export APICLIobjectstype=dns-domains
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"is-sub-domain"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["is-sub-domain"]'

objectstotal_dnsdomains=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_dnsdomains="$objectstotal_dnsdomains"
export number_of_objects=$number_dnsdomains

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# security-zones
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_securityzones=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_securityzones="$objectstotal_securityzones"
export number_of_objects=$number_securityzones

ExportObjectsToCSVviaJQ


# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# dynamic-objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_dynamicobjects=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_dynamicobjects="$objectstotal_dynamicobjects"
export number_of_objects=$number_dynamicobjects

ExportObjectsToCSVviaJQ


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27

# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Services and Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo 'Services and Applications'
echo
echo >> $APICLIlogfilepath
echo 'Services and Applications' >> $APICLIlogfilepath
echo >> $APICLIlogfilepath

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27

# MODIFIED 2018-05-02 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',"icon"'
export CSVFileHeader=$CSVFileHeader',"primary-category","risk","description","urls-defined-as-regular-expression"'
export CSVFileHeader=$CSVFileHeader', "meta-info.creator","user-defined","read-only"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', .["icon"]'
export CSVJQparms=$CSVJQparms', .["primary-category"], .["risk"], .["description"], .["urls-defined-as-regular-expression"]'
export CSVJQparms=$CSVJQparms', .["meta-info"]["creator"], .["user-defined"], .["read-only"]'

objectstotal_application_sites=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_application_sites="$objectstotal_application_sites"
export number_of_objects=$number_application_sites

ExportObjectsToCSVviaJQ

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-02


# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',"icon"'
export CSVFileHeader=$CSVFileHeader',"user-defined","read-only", "meta-info.creator"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', .["icon"]'
export CSVJQparms=$CSVJQparms', .["user-defined"], .["read-only"], .["meta-info"]["creator"]'

objectstotal_application_site_categories=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_application_site_categories="$objectstotal_application_site_categories"
export number_of_objects=$number_application_site_categories

ExportObjectsToCSVviaJQ

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27


# MODIFIED 2017-10-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',"icon"'
export CSVFileHeader=$CSVFileHeader',"user-defined","read-only", "meta-info.creator"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', .["icon"]'
export CSVJQparms=$CSVJQparms', .["user-defined"], .["read-only"], .["meta-info"]["creator"]'

objectstotal_application_site_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_application_site_groups="$objectstotal_application_site_groups"
export number_of_objects=$number_application_site_groups

ExportObjectsToCSVviaJQ

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-10-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Identifying Data
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo 'Identifying Data'
echo

# -------------------------------------------------------------------------------------------------
# tags
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=tags
export APICLIobjectstype=tags
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_tags=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_tags="$objectstotal_tags"
export number_of_objects=$number_tags

ExportObjectsToCSVviaJQ


# ADDED 2017-07-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Future objects to export to CSV
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# simple-gateways
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_simplegateways=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_simplegateways="$objectstotal_simplegateways"
export number_of_objects=$number_simplegateways

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# times
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time
export APICLIobjectstype=times
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_times=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_times="$objectstotal_times"
export number_of_objects=$number_times

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# time_groups
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_time_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_time_groups="$objectstotal_time_groups"
export number_of_objects=$number_time_groups

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# access-roles
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_access_roles=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_access_roles="$objectstotal_access_roles"
export number_of_objects=$number_access_roles

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# opsec-applications
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_opsec_applications=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
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
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_tcp=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_services_tcp="$objectstotal_services_tcp"
export number_of_objects=$number_services_tcp

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_udp=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_services_udp="$objectstotal_services_udp"
export number_of_objects=$number_services_udp

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_icmp=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_services_icmp="$objectstotal_services_icmp"
export number_of_objects=$number_services_icmp

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_icmp6=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_services_icmp6="$objectstotal_services_icmp6"
export number_of_objects=$number_services_icmp6

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_sctp=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_services_sctp="$objectstotal_services_sctp"
export number_of_objects=$number_services_sctp

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_other=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_services_other="$objectstotal_services_other"
export number_of_objects=$number_services_other

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_dce_rpc=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_services_dce_rpc="$objectstotal_services_dce_rpc"
export number_of_objects=$number_services_dce_rpc

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_services_rpc=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_services_rpc="$objectstotal_services_rpc"
export number_of_objects=$number_services_rpc

#ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APICLICSVobjecttype=$APICLIobjectstype
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_service_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_service_groups="$objectstotal_service_groups"
export number_of_objects=$number_service_groups

#ExportObjectsToCSVviaJQ


#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-08-28


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
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"template","e-mail","phone-number"'
export CSVFileHeader=$CSVFileHeader',"authentication-method","radius-server.name","tacacs-server.name"'
export CSVFileHeader=$CSVFileHeader',"expiration-date"'
export CSVFileHeader=$CSVFileHeader',"encryption.enable-ike", "encryption.enable-public-key", "encryption.enable-shared-secret"'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["template"], .["e-mail"], .["phone-number"]'
export CSVJQparms=$CSVJQparms', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
export CSVJQparms=$CSVJQparms', .["expiration-date"]["iso-8601"]'
export CSVJQparms=$CSVJQparms', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_users=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_users="$objectstotal_users"
export number_of_objects=$number_users

ExportObjectsToCSVviaJQ

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

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"email"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["email"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_user_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_user_groups="$objectstotal_user_groups"
export number_of_objects=$number_user_groups

ExportObjectsToCSVviaJQ

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

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"authentication-method","radius-server.name","tacacs-server.name"'
export CSVFileHeader=$CSVFileHeader',"expiration-by-global-properties","expiration-date"'
export CSVFileHeader=$CSVFileHeader',"encryption.enable-ike", "encryption.enable-public-key", "encryption.enable-shared-secret"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
export CSVJQparms=$CSVJQparms', .["expiration-by-global-properties"], .["expiration-date"]["iso-8601"]'
export CSVJQparms=$CSVJQparms', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_user_templates=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_user_templates="$objectstotal_user_templates"
export number_of_objects=$number_user_templates

ExportObjectsToCSVviaJQ

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

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"tags.0.name","tags.1.name","tags.2.name","tags.3.name","tags.4.name","tags.5.name","tags.6.name"'
export CSVFileHeader=$CSVFileHeader',"external-identifier"'
#export CSVFileHeader=$CSVFileHeader',<<<OBJECT_PARAMETER_HEADERS>>>'
#export CSVFileHeader=$CSVFileHeader',"icon"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"], .["tags"][5]["name"], .["tags"][6]["name"]'
export CSVJQparms=$CSVJQparms', .["external-identifier"]'
#export CSVJQparms=$CSVJQparms', <<<OBJECT_PARAMETERS>>>'
#export CSVJQparms=$CSVJQparms', .["icon"]'

objectstotal_identity_tags=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_identity_tags="$objectstotal_identity_tags"
export number_of_objects=$number_identity_tags

ExportObjectsToCSVviaJQ

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19


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

# ADDED 2017-11-09  \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# SetupExportComplexObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportComplexObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportComplexObjectsToCSVviaJQ () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    echo
    
    export APICLICSVfilename=$APICLIcomplexobjectstype'_'$APICLIdetaillvl'_csv'$APICLICSVfileexportsuffix
    export APICLICSVfile=$APICLIpathexport/$APICLICSVfilename
    export APICLICSVfilewip=$APICLICSVpathexportwip/$APICLICSVfilename
    export APICLICSVfileheader=$APICLICSVfilewip.$APICLICSVheaderfilesuffix
    export APICLICSVfiledata=$APICLICSVfilewip.data
    export APICLICSVfilesort=$APICLICSVfilewip.sort
    export APICLICSVfileoriginal=$APICLICSVfilewip.original

    
    if [ ! -r $APICLICSVpathexportwip ] ; then
        mkdir -p -v $APICLICSVpathexportwip | tee -a -i $APICLIlogfilepath
    fi

    if [ -r $APICLICSVfile ] ; then
        rm $APICLICSVfile >> $APICLIlogfilepath
    fi
    if [ -r $APICLICSVfileheader ] ; then
        rm $APICLICSVfileheader >> $APICLIlogfilepath
    fi
    if [ -r $APICLICSVfiledata ] ; then
        rm $APICLICSVfiledata >> $APICLIlogfilepath
    fi
    if [ -r $APICLICSVfilesort ] ; then
        rm $APICLICSVfilesort >> $APICLIlogfilepath
    fi
    if [ -r $APICLICSVfileoriginal ] ; then
        rm $APICLICSVfileoriginal >> $APICLIlogfilepath
    fi
    
    echo | tee -a -i $APICLIlogfilepath
    echo "Creat $APICLIcomplexobjectstype CSV File : $APICLICSVfile" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    #
    # Troubleshooting output
    #
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        echo | tee -a -i $APICLIlogfilepath
        echo '$CSVFileHeader' - $CSVFileHeader | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    
    fi
    
    echo $CSVFileHeader > $APICLICSVfileheader | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    echo | tee -a -i $APICLIlogfilepath
    return 0
    
    #
}


# -------------------------------------------------------------------------------------------------

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------
# FinalizeExportComplexObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeExportComplexObjectsToCSVviaJQ () {
    #
    # The FinalizeExportComplexObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
    #

    if [ ! -r "$APICLICSVfileheader" ] ; then
        # Uh, Oh, something went wrong, no header file
        echo | tee -a -i $APICLIlogfilepath
        echo '!!!! Error header file missing : '$APICLICSVfileheader | tee -a -i $APICLIlogfilepath
        echo 'Terminating!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return 254
        
    elif [ ! -r "$APICLICSVfiledata" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo | tee -a -i $APICLIlogfilepath
        echo '!!!! Error data file missing : '$APICLICSVfiledata | tee -a -i $APICLIlogfilepath
        echo 'Terminating!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return 253
        
    elif [ ! -s "$APICLICSVfiledata" ] ; then
        # data file is empty, nothing was found
        echo | tee -a -i $APICLIlogfilepath
        echo '!! data file is empty : '$APICLICSVfiledata | tee -a -i $APICLIlogfilepath
        echo 'Skipping CSV creation!' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        return 0
        
    fi

    echo | tee -a -i $APICLIlogfilepath
    echo "Sort data and build CSV export file" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    cat $APICLICSVfileheader > $APICLICSVfileoriginal
    cat $APICLICSVfiledata >> $APICLICSVfileoriginal
    
    sort $APICLICSVsortparms $APICLICSVfiledata > $APICLICSVfilesort
    
    cat $APICLICSVfileheader > $APICLICSVfile
    cat $APICLICSVfilesort >> $APICLICSVfile
    
    echo | tee -a -i $APICLIlogfilepath
    echo "Done creating $APICLIcomplexobjectstype CSV File : $APICLICSVfile" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    head $APICLICSVfile | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    
    echo | tee -a -i $APICLIlogfilepath
    return 0
    
}

# -------------------------------------------------------------------------------------------------

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05
#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\  ADDED 2017-11-09


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2018-05-05 -

# -------------------------------------------------------------------------------------------------
# group members
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLIcomplexobjecttype=group-member
export APICLIcomplexobjectstype=group-members
export APICLICSVobjecttype=$APICLIcomplexobjectstype
export APICLIexportnameaddon=

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupGetGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# SetupGetGroupMembers

SetupGetGroupMembers () {

    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,2'
    
    export CSVFileHeader='"name","members.add"'
    
    SetupExportComplexObjectsToCSVviaJQ
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05

    
# -------------------------------------------------------------------------------------------------
# FinalizeGetGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

#
# FinalizeGetGroupMembers

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeGetGroupMembers () {

    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        return $errorreturn
    fi
    
    return 0
}
    

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfGroupObjects generates an array of group objects for further processing.

PopulateArrayOfGroupObjects () {
    
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
    
    echo "  $APICLIobjectstype - Populate up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currentgroupoffset of $objectslefttoshow remaining!" | tee -a -i $APICLIlogfilepath

    # MGMT_CLI_GROUPS_STRING is a string with multiple lines. Each line contains a name of a group members.
    # in this example the output of mgmt_cli is not sent to a file, instead it is passed to jq directly using a pipe.
    
    #MGMT_CLI_GROUPS_STRING="`mgmt_cli show groups limit $APICLIObjectLimit offset $currentgroupoffset details-level "standard" -s $APICLIsessionfile -f json | $JQ ".objects[].name | @sh" -r`"
    
    if [ x"$NoSystemObjects" = x"true" ] ; then
        # Ignore System Objects
        #MGMT_CLI_GROUPS_STRING="`mgmt_cli show groups limit $APICLIObjectLimit offset $currentgroupoffset details-level "full" -s $APICLIsessionfile -f json | $JQ ".objects[] | '"$notsystemobjectselector"' | .name | @sh" -r`"
        MGMT_CLI_GROUPS_STRING="`mgmt_cli show groups limit $APICLIObjectLimit offset $currentgroupoffset details-level "full" -s $APICLIsessionfile -f json | $JQ '.objects[] | '"$notsystemobjectselector"' | .name | @sh' -r`"
    else   
        # Don't Ignore System Objects
        MGMT_CLI_GROUPS_STRING="`mgmt_cli show groups limit $APICLIObjectLimit offset $currentgroupoffset details-level "standard" -s $APICLIsessionfile -f json | $JQ ".objects[].name | @sh" -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    while read -r line; do
        ALLGROUPARR+=("$line")
        echo -n '.'
    done <<< "$MGMT_CLI_GROUPS_STRING"
    echo
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# GetArrayOfGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfGroupObjects generates an array of group objects for further processing.

GetArrayOfGroupObjects () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Generate array of groups' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    ALLGROUPARR=()

    export MgmtCLI_Base_OpParms="-f json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    echo "Processing $objectstoshow $APICLIobjecttype objects in $APICLIObjectLimit object chunks:" | tee -a -i $APICLIlogfilepath

    objectslefttoshow=$objectstoshow

    currentgroupoffset=0
    
    while [ $objectslefttoshow -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currentgroupoffset of $objectslefttoshow remaining!" | tee -a -i $APICLIlogfilepath

        PopulateArrayOfGroupObjects
        errorreturn=$?
        if [ $errorreturn != 0 ] ; then
            # Something went wrong, terminate
            return $errorreturn
        fi

        objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
        currentgroupoffset=`expr $currentgroupoffset + $APICLIObjectLimit`
    done

    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# DumpArrayOfGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfGroupObjects outputs the array of group objects.

DumpArrayOfGroupObjects () {
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        # Output list of all groups found
 
        # print the elements in the array
        echo | tee -a -i $APICLIlogfilepath
        echo Dump groups | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
        for i in "${ALLGROUPARR[@]}"
        do
            echo "$i, ${i//\'/}" | tee -a -i $APICLIlogfilepath
        done
        
        echo | tee -a -i $APICLIlogfilepath
        echo Done dumping groups | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# CollectMembersInGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectMembersInGroupObjects outputs the number of group members in a group in the array of group objects and collects them into the csv file.

CollectMembersInGroupObjects () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Use array of groups to generate group members CSV' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    for i in "${ALLGROUPARR[@]}"
    do
        echo | tee -a -i $APICLIlogfilepath
    
        MEMBERS_COUNT=$(mgmt_cli show $APICLIobjecttype name "${i//\'/}" -s $APICLIsessionfile -f json | $JQ ".members | length")
    
        NUM_GROUP_MEMBERS=$MEMBERS_COUNT

        if [ $NUM_GROUP_MEMBERS -gt 0 ]; then
            # More than zero (0) interfaces, something to process
            echo Group "${i//\'/}"' number of members = '"$NUM_GROUP_MEMBERS" | tee -a -i $APICLIlogfilepath
            
            COUNTER=0
            
            while [ $COUNTER -lt $NUM_GROUP_MEMBERS ]; do
                
                MEMBER_NAME=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ ".members[$COUNTER].name")
                
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    # Verbose mode ON
                    echo -n '.'
                fi
                
                echo ${i//\'/},$MEMBER_NAME >> $APICLICSVfiledata
                
                let COUNTER=COUNTER+1
                
            done
            
        else
            echo Group "${i//\'/}"' number of members = NONE (0 zero)'
        fi

    done
    
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# GetGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetGroupMembers generate output of group members from existing group objects

GetGroupMembers () {

    SetupGetGroupMembers

    GetArrayOfGroupObjects

    DumpArrayOfGroupObjects

    CollectMembersInGroupObjects

    FinalizeGetGroupMembers

}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05

    
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_groups="$objectstotal_groups"

if [ $number_groups -le 0 ] ; then
    # No groups found
    echo | tee -a -i $APICLIlogfilepath
    echo 'No groups to generate members from!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
else
    GetGroupMembers
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# MODIFIED 2018-05-05 -

# -------------------------------------------------------------------------------------------------
# host interfaces
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLIcomplexobjecttype=host-interface
export APICLIcomplexobjectstype=host-interfaces
export APICLICSVobjecttype=$APICLIcomplexobjectstype
export APICLIexportnameaddon=

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupGetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

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

    SetupExportComplexObjectsToCSVviaJQ
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05

    
# -------------------------------------------------------------------------------------------------
# FinalizeGetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# FinalizeGetHostInterfaces

FinalizeGetHostInterfaces () {

    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        return $errorreturn
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05

    
# -------------------------------------------------------------------------------------------------
# PopulateArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfHostInterfaces populates array of host objects for further processing.

PopulateArrayOfHostInterfaces () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
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
    
    echo | tee -a -i $APICLIlogfilepath
    echo "  $APICLIobjectstype - Populate up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currenthostoffset of $objectslefttoshow remaining!" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    # MGMT_CLI_HOSTS_STRING is a string with multiple lines. Each line contains a name of a host.
    # in this example the output of mgmt_cli is not sent to a file, instead it is passed to jq directly using a pipe.
    
    #MGMT_CLI_HOSTS_STRING="`mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currenthostoffset details-level "standard" -s $APICLIsessionfile -f json | $JQ ".objects[].name | @sh" -r`"
    
    if [ x"$NoSystemObjects" = x"true" ] ; then
        # Ignore System Objects
        #MGMT_CLI_HOSTS_STRING="`mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currenthostoffset details-level "full" -s $APICLIsessionfile -f json | $JQ ".objects[] | '"$notsystemobjectselector"' | .name | @sh" -r`"
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currenthostoffset details-level "full" -s $APICLIsessionfile -f json | $JQ '.objects[] | '"$notsystemobjectselector"' | .name | @sh' -r`"
    else   
        # Don't Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show $APICLIobjectstype limit $APICLIObjectLimit offset $currenthostoffset details-level "standard" -s $APICLIsessionfile -f json | $JQ ".objects[].name | @sh" -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
     if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        echo | tee -a -i $APICLIlogfilepath

        # Output list of all hosts found - Header
        echo -n '. $line, ' | tee -a -i $APICLIlogfilepath
        echo -n '$(eval echo $line), ' | tee -a -i $APICLIlogfilepath
        echo -n 'arraylength, ' | tee -a -i $APICLIlogfilepath
        echo -n 'arrayelement, ' | tee -a -i $APICLIlogfilepath
        #echo -n '$(eval echo ${ALLHOSTARR[${arrayelement}]}) ' | tee -a -i $APICLIlogfilepath
        echo -n '$NUM_HOST_INTERFACES, NUM_HOST_INTERFACES > 0 ' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi

    while read -r line; do

        ALLHOSTSARR+=("$line")

        echo -n '.' | tee -a -i $APICLIlogfilepath

        arraylength=${#ALLHOSTSARR[@]}
        arrayelement=$((arraylength-1))
        

        if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            # Verbose mode ON
            # Output list of all hosts found
            echo -n ' '"$line"', ' | tee -a -i $APICLIlogfilepath
            echo -n "$(eval echo $line)"', ' | tee -a -i $APICLIlogfilepath
            echo -n "$arraylength"', ' | tee -a -i $APICLIlogfilepath
            echo -n "$arrayelement"', ' | tee -a -i $APICLIlogfilepath
            #echo -n "$(eval echo ${ALLHOSTARR[${arrayelement}]})"', ' | tee -a -i $APICLIlogfilepath
        fi

        #INTERFACES_COUNT=$(mgmt_cli show $APICLIobjecttype name "$(eval echo ${ALLHOSTARR[${arrayelement}]})" details-level "full" -s $APICLIsessionfile -f json | $JQ ".interfaces | length")
        INTERFACES_COUNT=$(mgmt_cli show $APICLIobjecttype name "$(eval echo $line)" details-level "full" -s $APICLIsessionfile -f json | $JQ ".interfaces | length")

        NUM_HOST_INTERFACES=$INTERFACES_COUNT

        if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            echo -n "$NUM_HOST_INTERFACES"', ' | tee -a -i $APICLIlogfilepath
        else
            echo -n "$NUM_HOST_INTERFACES" | tee -a -i $APICLIlogfilepath
        fi

        if [ $NUM_HOST_INTERFACES -gt 0 ]; then
            HOSTSARR+=("$line")
            let HostInterfacesCount=HostInterfacesCount+$NUM_HOST_INTERFACES
            echo -n '!' | tee -a -i $APICLIlogfilepath
        else
            echo -n '-' | tee -a -i $APICLIlogfilepath
        fi

         if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
            # Verbose mode ON
            echo | tee -a -i $APICLIlogfilepath
        fi

    done <<< "$MGMT_CLI_HOSTS_STRING"

    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        echo | tee -a -i $APICLIlogfilepath
        echo 'HostInterfacesCount = '$HostInterfacesCount | tee -a -i $APICLIlogfilepath
    fi

    export HostInterfacesCount=$HostInterfacesCount

    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# GetArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfHostInterfaces generates an array of host objects for further processing.

GetArrayOfHostInterfaces () {
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Generate array of hosts' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    HOSTSARR=()
    ALLHOSTSARR=()

    export MgmtCLI_Base_OpParms="-f json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    echo "Processing $objectstoshow $APICLIobjecttype objects in $APICLIObjectLimit object chunks:" | tee -a -i $APICLIlogfilepath

    objectslefttoshow=$objectstoshow

    currenthostoffset=0

    while [ $objectslefttoshow -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currenthostoffset of $objectslefttoshow remaining!" | tee -a -i $APICLIlogfilepath

        PopulateArrayOfHostInterfaces
        errorreturn=$?
        if [ $errorreturn != 0 ] ; then
            # Something went wrong, terminate
            return $errorreturn
        fi

        objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
        currenthostoffset=`expr $currenthostoffset + $APICLIObjectLimit`
    done

    echo | tee -a -i $APICLIlogfilepath
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Final HostInterfacesCount = '$HostInterfacesCount | tee -a -i $APICLIlogfilepath
    echo 'Final Host Array = '\>"${HOSTSARR[@]}"\< | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# DumpArrayOfHostsObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfHostsObjects outputs the array of host objects.

DumpArrayOfHostsObjects () {
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        # Output list of all hosts found
    
        # print the elements in the array
        #echo | tee -a -i $APICLIlogfilepath
        #echo Dump All hosts | tee -a -i $APICLIlogfilepath
        #echo | tee -a -i $APICLIlogfilepath
        #
        #for i in "${ALLHOSTSARR[@]}"
        #do
        #    echo "$i, ${i//\'/}" | tee -a -i $APICLIlogfilepath
        #done
        
        echo | tee -a -i $APICLIlogfilepath
        echo hosts with interfaces defined | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
        for j in "${HOSTSARR[@]}"
        do
            echo "$j, ${j//\'/}" | tee -a -i $APICLIlogfilepath
        done
        
        echo | tee -a -i $APICLIlogfilepath
        echo Done dumping hosts | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
    fi

    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectInterfacesInHostObjects outputs the host interfaces in a host in the array of host objects and collects them into the csv file.

CollectInterfacesInHostObjects () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Use array of hosts to generate host interfaces CSV' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    for i in "${HOSTSARR[@]}"
    do
        echo | tee -a -i $APICLIlogfilepath
        echo Host with interfaces "${i//\'/}" | tee -a -i $APICLIlogfilepath
    
        INTERFACES_COUNT=$(mgmt_cli show $APICLIobjecttype name "${i//\'/}" -s $APICLIsessionfile -f json | $JQ ".interfaces | length")

        NUM_HOST_INTERFACES=$INTERFACES_COUNT
    
        if [ $NUM_HOST_INTERFACES -gt 0 ]; then
            # More than zero (0) interfaces, something to process
            echo host "${i//\'/}"' number of interfaces = '"$NUM_HOST_INTERFACES" | tee -a -i $APICLIlogfilepath
       
            COUNTER=0
            if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                # Verbose mode ON
                echo $CSVFileHeader | tee -a -i $APICLIlogfilepath
            fi

            while [ $COUNTER -lt $NUM_HOST_INTERFACES ]; do
        
                #echo -n '.' | tee -a -i $APICLIlogfilepath
    
                #export CSVJQparms='.["name"], .["interfaces"]['$COUNTER']["name"]'
                #export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet4"], .["interfaces"]['$COUNTER']["mask-length4"], .["interfaces"]['$COUNTER']["subnet-mask"]'
                #export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet4"], .["interfaces"]['$COUNTER']["mask-length4"],
                #export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["subnet6"], .["interfaces"]['$COUNTER']["mask-length6"]'
                #export CSVJQparms=$CSVJQparms', .["interfaces"]['$COUNTER']["color"], .["interfaces"]['$COUNTER']["comments"]'

                INTERFACE_NAME=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ '.["interfaces"]['$COUNTER']["name"]')
                INTERFACE_subnet4=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ '.["interfaces"]['$COUNTER']["subnet4"]')
                INTERFACE_masklength4=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ '.["interfaces"]['$COUNTER']["mask-length4"]')
                INTERFACE_subnetmask=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ '.["interfaces"]['$COUNTER']["subnet-mask"]')
                INTERFACE_subnet6=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ '.["interfaces"]['$COUNTER']["subnet6"]')
                INTERFACE_masklength6=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ '.["interfaces"]['$COUNTER']["mask-length6"]')
                INTERFACE_COLOR=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ '.["interfaces"]['$COUNTER']["color"]')
                INTERFACE_COMMENT=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ '.["interfaces"]['$COUNTER']["comments"]')
                
                export CSVoutputline="${i//\'/}","$INTERFACE_NAME"
                #export CSVoutputline=$CSVoutputline,"$INTERFACE_subnet4","$INTERFACE_masklength4","$INTERFACE_subnetmask"
                export CSVoutputline=$CSVoutputline,"$INTERFACE_subnet4","$INTERFACE_masklength4"
                export CSVoutputline=$CSVoutputline,"$INTERFACE_subnet6","$INTERFACE_masklength6"
                export CSVoutputline=$CSVoutputline,"$INTERFACE_COLOR","$INTERFACE_COMMENT"
                
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    # Verbose mode ON
                    echo $CSVoutputline | tee -a -i $APICLIlogfilepath
                    fi

                echo $CSVoutputline >> $APICLICSVfiledata | tee -a -i $APICLIlogfilepath
        
                let COUNTER=COUNTER+1
        
            done
        else
            echo host "${i//\'/}"' number of interfaces = NONE (0 zero)' | tee -a -i $APICLIlogfilepath
        fi
    
    done
    
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# GetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetHostInterfaces generate output of host's interfaces from existing hosts with interface objects

GetHostInterfaces () {

    export HostInterfacesCount=0

    SetupGetHostInterfaces

    GetArrayOfHostInterfaces

    if [ $HostInterfacesCount -gt 0 ]; then
        # We have host interfaces to process
        DumpArrayOfHostsObjects
    
        CollectInterfacesInHostObjects
    
        FinalizeGetHostInterfaces

    else
        # No host interfaces
        echo | tee -a -i $APICLIlogfilepath
        echo '! No host interfaces found' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    fi
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_hosts=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_hosts="$objectstotal_hosts"

if [ $number_hosts -le 0 ] ; then
    # No hosts found
    echo | tee -a -i $APICLIlogfilepath
    echo 'No hosts to generate interfaces from!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
else
    GetHostInterfaces
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-05


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-08-19 -

# -------------------------------------------------------------------------------------------------
# user-group members
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=user-group
export APICLIobjectstype=user-groups
export APICLIcomplexobjecttype=user-group-member
export APICLIcomplexobjectstype=user-group-members
export APICLICSVobjecttype=$APICLIcomplexobjectstype
export APICLIexportnameaddon=

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupGetUserGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# SetupGetUserGroupMembers

SetupGetUserGroupMembers () {

    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,2'
    
    export CSVFileHeader='"name","members.add"'
    
    SetupExportComplexObjectsToCSVviaJQ
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19

    
# -------------------------------------------------------------------------------------------------
# FinalizeGetUserGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

#
# FinalizeGetUserGroupMembers

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeGetUserGroupMembers () {

    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ $errorreturn != 0 ] ; then
        # Something went wrong, terminate
        return $errorreturn
    fi
    
    return 0
}
    

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfUserGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfUserGroupObjects generates an array of user-group objects for further processing.

PopulateArrayOfUserGroupObjects () {
    
    # MODIFIED 2020-08-19 -
    #
    # This should work, but might need more tweeks if other data types use more values
    #export notsystemobjectselector='select((."domain"."name" != "Check Point Data") and (."domain"."name" != "APPI Data") and (."domain"."name" != "IPS Data"))'
    #
    # Future alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['$systemobjectdomains'] | index($a) | not)'
    
    echo "  $APICLIobjectstype - Populate up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currentusergroupoffset of $objectslefttoshow remaining!" | tee -a -i $APICLIlogfilepath

    # MGMT_CLI_USER_GROUPS_STRING is a string with multiple lines. Each line contains a name of a group members.
    # in this example the output of mgmt_cli is not sent to a file, instead it is passed to jq directly using a pipe.
    
    #MGMT_CLI_USER_GROUPS_STRING="`mgmt_cli show groups limit $APICLIObjectLimit offset $currentusergroupoffset details-level "standard" -s $APICLIsessionfile -f json | $JQ ".objects[].name | @sh" -r`"
    
    if [ x"$NoSystemObjects" = x"true" ] ; then
        # Ignore System Objects
        #MGMT_CLI_USER_GROUPS_STRING="`mgmt_cli show user-groups limit $APICLIObjectLimit offset $currentusergroupoffset details-level "full" -s $APICLIsessionfile -f json | $JQ ".objects[] | '"$notsystemobjectselector"' | .name | @sh" -r`"
        MGMT_CLI_USER_GROUPS_STRING="`mgmt_cli show user-groups limit $APICLIObjectLimit offset $currentusergroupoffset details-level "full" -s $APICLIsessionfile -f json | $JQ '.objects[] | '"$notsystemobjectselector"' | .name | @sh' -r`"
    else   
        # Don't Ignore System Objects
        MGMT_CLI_USER_GROUPS_STRING="`mgmt_cli show user-groups limit $APICLIObjectLimit offset $currentusergroupoffset details-level "standard" -s $APICLIsessionfile -f json | $JQ ".objects[].name | @sh" -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    while read -r line; do
        ALLUSERGROUPARR+=("$line")
        echo -n '.'
    done <<< "$MGMT_CLI_USER_GROUPS_STRING"
    echo
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19


# -------------------------------------------------------------------------------------------------
# GetArrayOfUserGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfUserGroupObjects generates an array of group objects for further processing.

GetArrayOfUserGroupObjects () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Generate array of user groups' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    ALLUSERGROUPARR=()

    export MgmtCLI_Base_OpParms="-f json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_Base_OpParms"
    
    objectstotal=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" $MgmtCLI_Base_OpParms | $JQ ".total")

    objectstoshow=$objectstotal

    echo "Processing $objectstoshow $APICLIobjecttype objects in $APICLIObjectLimit object chunks:" | tee -a -i $APICLIlogfilepath

    objectslefttoshow=$objectstoshow

    currentusergroupoffset=0
    
    while [ $objectslefttoshow -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next $APICLIObjectLimit $APICLIobjecttype objects starting with object $currentusergroupoffset of $objectslefttoshow remaining!" | tee -a -i $APICLIlogfilepath

        PopulateArrayOfUserGroupObjects
        errorreturn=$?
        if [ $errorreturn != 0 ] ; then
            # Something went wrong, terminate
            return $errorreturn
        fi

        objectslefttoshow=`expr $objectslefttoshow - $APICLIObjectLimit`
        currentusergroupoffset=`expr $currentusergroupoffset + $APICLIObjectLimit`
    done

    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19


# -------------------------------------------------------------------------------------------------
# DumpArrayOfUserGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfUserGroupObjects outputs the array of group objects.

DumpArrayOfUserGroupObjects () {
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
        # Output list of all groups found
 
        # print the elements in the array
        echo | tee -a -i $APICLIlogfilepath
        echo 'Dump user groups' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
        
        for i in "${ALLUSERGROUPARR[@]}"
        do
            echo "$i, ${i//\'/}" | tee -a -i $APICLIlogfilepath
        done
        
        echo | tee -a -i $APICLIlogfilepath
        echo 'Done dumping user groups' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19


# -------------------------------------------------------------------------------------------------
# CollectMembersInUserGroupObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectMembersInUserGroupObjects outputs the number of group members in a group in the array of group objects and collects them into the csv file.

CollectMembersInUserGroupObjects () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo | tee -a -i $APICLIlogfilepath
    echo 'Use array of user groups to generate user group members CSV' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    for i in "${ALLUSERGROUPARR[@]}"
    do
        echo | tee -a -i $APICLIlogfilepath
        
        MEMBERS_COUNT=$(mgmt_cli show $APICLIobjecttype name "${i//\'/}" -s $APICLIsessionfile -f json | $JQ ".members | length")
        
        NUM_USER_GROUP_MEMBERS=$MEMBERS_COUNT
        
        if [ $NUM_USER_GROUP_MEMBERS -gt 0 ]; then
            # More than zero (0) members, something to process
            echo 'User-Group '"${i//\'/}"' number of members = '"$NUM_USER_GROUP_MEMBERS" | tee -a -i $APICLIlogfilepath
            
            COUNTER=0
            
            while [ $COUNTER -lt $NUM_USER_GROUP_MEMBERS ]; do
                
                MEMBER_NAME=$(mgmt_cli show $APICLIobjecttype name ${i//\'/} -s $APICLIsessionfile -f json | $JQ ".members[$COUNTER].name")
                
                if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
                    # Verbose mode ON
                    echo -n '.'
                fi
                
                echo ${i//\'/},$MEMBER_NAME >> $APICLICSVfiledata
                
                let COUNTER=COUNTER+1
                
            done
            
        else
            echo Group "${i//\'/}"' number of members = NONE (0 zero)'
        fi
        
    done
    
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19


# -------------------------------------------------------------------------------------------------
# GetUserGroupMembers proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetUserGroupMembers generate output of group members from existing group objects

GetUserGroupMembers () {

    SetupGetUserGroupMembers

    GetArrayOfUserGroupObjects

    DumpArrayOfUserGroupObjects

    CollectMembersInUserGroupObjects

    FinalizeGetUserGroupMembers

}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19

    
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-08-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_user_groups=$(mgmt_cli show $APICLIobjectstype limit 1 offset 0 details-level "standard" -f json -s $APICLIsessionfile | $JQ ".total")
export number_user_groups="$objectstotal_user_groups"

if [ $number_user_groups -le 0 ] ; then
    # No user groups found
    echo | tee -a -i $APICLIlogfilepath
    echo 'No user groups to generate members from!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
else
    GetUserGroupMembers
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-08-19

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


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

echo | tee -a -i $APICLIlogfilepath
echo $APICLIdetaillvl' CSV dump - Completed!' | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

echo | tee -a -i $APICLIlogfilepath
echo | tee -a -i $APICLIlogfilepath

return 0

# =================================================================================================
# END:  Export objects to csv
# =================================================================================================
# =================================================================================================

