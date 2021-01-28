#!/bin/bash
#
# SCRIPT Object dump to CSV action operations for API CLI Operations
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
#
ScriptVersion=00.60.02
ScriptRevision=010
ScriptDate=2021-01-27
TemplateVersion=00.60.02
APISubscriptsVersion=00.60.02
APISubscriptsRevision=006

#

export APIActionsScriptVersion=v${ScriptVersion}
export APIActionScriptTemplateVersion=v${TemplateVersion}

export APIActionsScriptVersionX=v${ScriptVersion//./x}
export APIActionScriptTemplateVersionX=v${TemplateVersion//./x}

ActionScriptName=cli_api_export_objects_actions_to_csv
export APIActionScriptFileNameRoot=cli_api_export_objects_actions_to_csv
export APIActionScriptShortName=export_objects_actions_to_csv
export APIActionScriptnohupName=${APIActionScriptShortName}
export APIActionScriptDescription="Object dump to CSV action operations for API CLI Operations"

# =================================================================================================
# =================================================================================================
# START:  Export objects to csv
# =================================================================================================


if ${APISCRIPTVERBOSE} ; then
    echo | tee -a -i ${logfilepath}
    echo 'ActionScriptName:  '${ActionScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} | tee -a -i ${logfilepath}
else
    echo >> ${logfilepath}
    echo 'ActionScriptName:  '${ActionScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} >> ${logfilepath}
fi


# =================================================================================================
# Validate Actions Script version is correct for caller
# =================================================================================================


if [ x"${APIExpectedActionScriptsVersion}" = x"${APIActionsScriptVersion}" ] ; then
    # Script and Actions Script versions match, go ahead
    echo >> ${logfilepath}
    echo 'Verify Actions Scripts Version - OK' >> ${logfilepath}
    echo >> ${logfilepath}
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo | tee -a -i ${logfilepath}
    echo 'Raw Script name        : '$0 | tee -a -i ${logfilepath}
    echo 'Subscript version name : '${APIActionsScriptVersion}' '${ActionScriptName} | tee -a -i ${logfilepath}
    echo 'Calling Script version : '${APIScriptVersion} | tee -a -i ${logfilepath}
    echo 'Verify Actions Scripts Version - Missmatch' | tee -a -i ${logfilepath}
    echo 'Expected Action Script version : '${APIExpectedActionScriptsVersion} | tee -a -i ${logfilepath}
    echo 'Current  Action Script version : '${APIActionsScriptVersion} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}

    exit 250
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# START:  Local Proceedures
# =================================================================================================

export actionstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log

# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-17 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #
    
    if [ -z "$1" ]; then
        # No explicit name passed for action
        export actionstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log
    else
        # explicit name passed for action
        export actionstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'$1'_'${DATEDTGS}.log
    fi
    
    if [ -w ${actionstemplogfilepath} ] ; then
        rm ${actionstemplogfilepath} >> ${logfilepath} 2>&1
    fi
    
    touch ${actionstemplogfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-17

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
    
    if ${APISCRIPTVERBOSE} ; then
        # verbose mode so show the logged results and copy to normal log file
        cat ${actionstemplogfilepath} | tee -a -i ${logfilepath}
    else
        # NOT verbose mode so push logged results to normal log file
        cat ${actionstemplogfilepath} >> ${logfilepath}
    fi
    
    rm ${actionstemplogfilepath} >> ${logfilepath} 2>&1
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
    
    cat ${actionstemplogfilepath} | tee -a -i ${logfilepath}
    
    rm ${actionstemplogfilepath} >> ${logfilepath} 2>&1
    
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
export primarytargetoutputformat=${FileExtCSV}

export MinAPIObjectLimit=500
export MaxAPIObjectLimit=500
export WorkAPIObjectLimit=${MaxAPIObjectLimit}


# =================================================================================================
# Start executing Main operations
# =================================================================================================

# MODIFIED 2018-05-04-4 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export templogfilepath=/var/tmp/templog_${ScriptName}.`date +%Y%m%d-%H%M%S%Z`.log
echo > ${templogfilepath}

echo 'Configure working paths for export and dump' >> ${templogfilepath}
echo >> ${templogfilepath}

echo 'domainnamenospace = '${domainnamenospace} >> ${templogfilepath}
echo 'CLIparm_NODOMAINFOLDERS = '${CLIparm_NODOMAINFOLDERS} >> ${templogfilepath}
echo 'primarytargetoutputformat = '${primarytargetoutputformat} >> ${templogfilepath}
echo 'APICLICSVExportpathbase = '${APICLICSVExportpathbase} >> ${templogfilepath}
echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo 'WorkAPIObjectLimit = '${WorkAPIObjectLimit} >> ${templogfilepath}

# ------------------------------------------------------------------------

if [ ! -z "${domainnamenospace}" ] && [ "${CLIparm_NODOMAINFOLDERS}" != "true" ] ; then
    # Handle adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}/${domainnamenospace}
    
    echo 'Handle adding domain name to path for MDM operations' >> ${templogfilepath}
    echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
    fi
else
    # NOT adding domain name to path for MDM operations
    export APICLIpathexport=${APICLICSVExportpathbase}
    
    echo 'NOT adding domain name to path for MDM operations' >> ${templogfilepath}
    echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
    fi
fi

# ------------------------------------------------------------------------

# primary operation is export to primarytargetoutputformat
export APICLIpathexport=${APICLIpathexport}/${primarytargetoutputformat}

echo | tee -a -i ${templogfilepath}
echo 'Export to '${primarytargetoutputformat}' Starting!' | tee -a -i ${templogfilepath}

if [ ! -r ${APICLIpathexport} ] ; then
    mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
fi

echo >> ${templogfilepath}
echo 'After Evaluation of script type' >> ${templogfilepath}
echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}

# ------------------------------------------------------------------------

if [ x"${primarytargetoutputformat}" = x"${FileExtJSON}" ] ; then
    # for JSON provide the detail level
    
    export APICLIpathexport=${APICLIpathexport}/${APICLIdetaillvl}
    
    if [ ! -r ${APICLIpathexport} ] ; then
        mkdir -p -v ${APICLIpathexport} >> ${templogfilepath}
    fi
    
    export APICLIJSONpathexportwip=
    if [ x"$script_uses_wip_json" = x"true" ] ; then
        # script uses work-in-progress (wip) folder for json
        
        export APICLIJSONpathexportwip=${APICLIpathexport}/wip
        
        if [ ! -r ${APICLIJSONpathexportwip} ] ; then
            mkdir -p -v ${APICLIJSONpathexportwip} >> ${templogfilepath}
        fi
    fi
else
    export APICLIJSONpathexportwip=
fi

echo >> ${templogfilepath}
echo 'After handling json target' >> ${templogfilepath}
echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo 'APICLIJSONpathexportwip = '${APICLIJSONpathexportwip} >> ${templogfilepath}

# ------------------------------------------------------------------------

if [ x"${primarytargetoutputformat}" = x"${FileExtCSV}" ] ; then
    # for CSV handle specifics, like wip
    
    export APICLICSVpathexportwip=
    if [ x"$script_uses_wip" = x"true" ] ; then
        # script uses work-in-progress (wip) folder for csv
        
        export APICLICSVpathexportwip=${APICLIpathexport}/wip
        
        if [ ! -r ${APICLICSVpathexportwip} ] ; then
            mkdir -p -v ${APICLICSVpathexportwip} >> ${templogfilepath}
        fi
    fi
else
    export APICLICSVpathexportwip=
fi

echo >> ${templogfilepath}
echo 'After handling csv target' >> ${templogfilepath}
echo 'APICLIpathexport = '${APICLIpathexport} >> ${templogfilepath}
echo 'APICLICSVpathexportwip = '${APICLICSVpathexportwip} >> ${templogfilepath}

# ------------------------------------------------------------------------

export APICLIfileexportpost='_'${APICLIdetaillvl}'_'${APICLIfileexportsuffix}

export APICLICSVheaderfilesuffix=header

export APICLICSVfileexportpost='_'${APICLIdetaillvl}'_'${APICLICSVfileexportsuffix}

export APICLIJSONheaderfilesuffix=header
export APICLIJSONfooterfilesuffix=footer

export APICLIJSONfileexportpost='_'${APICLIdetaillvl}'_'${APICLIJSONfileexportsuffix}

echo >> ${templogfilepath}
echo 'Setup other file and path variables' >> ${templogfilepath}
echo 'APICLIfileexportpost = '${APICLIfileexportpost} >> ${templogfilepath}
echo 'APICLICSVheaderfilesuffix = '${APICLICSVheaderfilesuffix} >> ${templogfilepath}
echo 'APICLICSVfileexportpost = '${APICLICSVfileexportpost} >> ${templogfilepath}
echo 'APICLIJSONheaderfilesuffix = '${APICLIJSONheaderfilesuffix} >> ${templogfilepath}
echo 'APICLIJSONfooterfilesuffix = '${APICLIJSONfooterfilesuffix} >> ${templogfilepath}
echo 'APICLIJSONfileexportpost = '${APICLIJSONfileexportpost} >> ${templogfilepath}

# ------------------------------------------------------------------------

echo >> ${templogfilepath}

cat ${templogfilepath} >> ${logfilepath}
rm -v ${templogfilepath} >> ${logfilepath}

# ------------------------------------------------------------------------

echo 'Dump "'${APICLIdetaillvl}'" details to path:  '${APICLIpathexport} | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04-4


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START : Main Operational repeated proceedures - Export Objects to raw JSON
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# SetupExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportObjectsToCSVviaJQ () {
    
    echo | tee -a -i ${logfilepath}
    
    # Build the object type specific output file
    
    export APICLICSVfilename=${APICLIobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLICSVfilename=${APICLICSVfilename}'_'${APICLIexportnameaddon}
    fi
    export APICLICSVfilename=${APICLICSVfilename}'_'${APICLIdetaillvl}'_csv'${APICLICSVfileexportsuffix}
    export APICLICSVfile=${APICLIpathexport}/${APICLICSVfilename}
    export APICLICSVfilewip=${APICLICSVpathexportwip}/${APICLICSVfilename}
    export APICLICSVfileheader=${APICLICSVfilewip}.${APICLICSVheaderfilesuffix}
    export APICLICSVfiledata=${APICLICSVfilewip}.data
    export APICLICSVfilesort=${APICLICSVfilewip}.sort
    export APICLICSVfileoriginal=${APICLICSVfilewip}.original
    
    
    if [ ! -r ${APICLICSVpathexportwip} ] ; then
        mkdir -p -v ${APICLICSVpathexportwip} | tee -a -i ${logfilepath}
    fi
    
    if [ -r ${APICLICSVfile} ] ; then
        rm ${APICLICSVfile} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileheader} ] ; then
        rm ${APICLICSVfileheader} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfiledata} ] ; then
        rm ${APICLICSVfiledata} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfilesort} ] ; then
        rm ${APICLICSVfilesort} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileoriginal} ] ; then
        rm ${APICLICSVfileoriginal} >> ${logfilepath}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo "Creat ${APICLIobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    #
    # Troubleshooting output
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
        echo 'CSVFileHeader' - ${CSVFileHeader} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    echo ${CSVFileHeader} > ${APICLICSVfileheader} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# The FinalizeExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeExportObjectsToCSVviaJQ () {
    #
    # The FinalizeExportObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
    #
    
    if [ ! -r "${APICLICSVfileheader}" ] ; then
        # Uh, Oh, something went wrong, no header file
        echo | tee -a -i ${logfilepath}
        echo '!!!! Error header file missing : '${APICLICSVfileheader} | tee -a -i ${logfilepath}
        echo 'Terminating!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 254
        
    elif [ ! -r "${APICLICSVfiledata}" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo | tee -a -i ${logfilepath}
        echo '!!!! Error data file missing : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo 'Terminating!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 253
        
    elif [ ! -s "${APICLICSVfiledata}" ] ; then
        # data file is empty, nothing was found
        echo | tee -a -i ${logfilepath}
        echo '!! data file is empty : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo 'Skipping CSV creation!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 0
        
    fi
    
    echo | tee -a -i ${logfilepath}
    echo "Sort data and build CSV export file" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfileoriginal}
    cat ${APICLICSVfiledata} >> ${APICLICSVfileoriginal}
    
    sort ${APICLICSVsortparms} ${APICLICSVfiledata} > ${APICLICSVfilesort}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfile}
    cat ${APICLICSVfilesort} >> ${APICLICSVfile}
    
    echo | tee -a -i ${logfilepath}
    echo "Done creating ${APICLIobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    head ${APICLICSVfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportObjectsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjectstype} item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectsToCSVviaJQ () {
    #
    
    if [[ ${number_of_objects} -lt 1 ]] ; then
        # no objects of this type
        
        echo "No objects of type ${APICLIobjecttype} to process, skipping..." | tee -a -i ${logfilepath}
        
        return 0
       
    else
        # we have objects to handle
        echo "Processing ${number_of_objects} ${APICLIobjecttype} objects..." | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    fi
    
    # MODIFIED 2021-01-18 -
    #
    # The standard output for each CSV is name, color, comments block, by default.  This
    # object data exists for all objects, plus the UID.  In the future there may be  more
    # CLI Parameter controls provided to just dump the name, name & UID, or just UID 
    # instead of the full dump of values.  These are useful for things like delete operations
    #
    
    if [ x"${CSVFileHeader}" != x"" ] ; then
        # CSVFileHeader is NOT blank or empty
        export CSVFileHeader='"name","color","comments",'${CSVFileHeader}
    else
        # CSVFileHeader is blank or empty
        export CSVFileHeader='"name","color","comments"'
    fi
    
    if [ x"${CSVJQparms}" != x"" ] ; then
        # CSVFileHeader is NOT blank or empty
        export CSVJQparms='.["name"], .["color"], .["comments"], '${CSVJQparms}
    else
        # CSVFileHeader is blank or empty
        export CSVJQparms='.["name"], .["color"], .["comments"]'
    fi
    
    # MODIFIED 2021-01-16 -
    # Let's only do this one time for each object and put this at the end of the collected data
    
    if ${CSVEXPORT05TAGS} ; then
        export CSVFileHeader=${CSVFileHeader}',"tags.0","tags.1","tags.2","tags.3","tags.4"'
        export CSVJQparms=${CSVJQparms}', .["tags"][0]["name"], .["tags"][1]["name"], .["tags"][2]["name"], .["tags"][3]["name"], .["tags"][4]["name"]'
    fi
    
    if ${CSVEXPORT10TAGS} ; then
        export CSVFileHeader=${CSVFileHeader}',"tags.5","tags.6","tags.7","tags.8","tags.9"'
        export CSVJQparms=${CSVJQparms}', .["tags"][5]["name"], .["tags"][6]["name"], .["tags"][7]["name"], .["tags"][8]["name"], .["tags"][9]["name"]'
    fi
    
    if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        export CSVFileHeader=${CSVFileHeader}',"uid","domain.name","domain.domain-type"'
        export CSVJQparms=${CSVJQparms}', .["uid"], .["domain"]["name"], .["domain"]["domain-type"]'
    fi
    
    if ${CLIparm_CSVEXPORTDATACREATOR} ; then
        export CSVFileHeader=${CSVFileHeader}',"meta-info.creator","meta-info.creation-time.iso-8601","meta-info.last-modifier","meta-info.last-modify-time.iso-8601"'
        export CSVJQparms=${CSVJQparms}', .["meta-info"]["creator"], .["meta-info"]["creation-time"]["iso-8601"], .["meta-info"]["last-modifier"], .["meta-info"]["last-modify-time"]["iso-8601"]'
    fi
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
        export CSVJQparms=${CSVJQparms}', true'
    fi
    
    SetupExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure SetupExportObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    export MgmtCLI_Base_OpParms="-f json -s ${APICLIsessionfile}"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"full\" ${MgmtCLI_Base_OpParms}"
    
    # MODIFIED 2018-07-20 - CLEANED UP 2020-10-05
    
    # This should work, but might need more tweeks if other data types use more values
    #export notsystemobjectselector='select(."domain"."name" | contains ("Check Point Data", "APPI Data", "IPS Data") | not)'
    #export notsystemobjectselector='select(any(."domain"."name"; in("Check Point Data", "APPI Data", "IPS Data")) | not)'
    #export notsystemobjectselector='select((."domain"."name" != "Check Point Data") and (."domain"."name" != "APPI Data") and (."domain"."name" != "IPS Data"))'
    #
    # Current alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    echo | tee -a -i ${logfilepath}
    echo "Export ${APICLIobjectstype} to CSV File" | tee -a -i ${logfilepath}
    echo "  and dump to ${APICLICSVfile}" | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo "  mgmt_cli parameters : ${MgmtCLI_Show_OpParms}" | tee -a -i ${logfilepath}
        echo '  CSVJQparms' - ${CSVJQparms} | tee -a -i ${logfilepath}
        echo "  System Object Selector : "${notsystemobjectselector} | tee -a -i ${logfilepath}
    fi
    echo | tee -a -i ${logfilepath}
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        #errorreturn=$?
        
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
        else   
            # Don't Ignore System Objects
            mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
            errorreturn=$?
        fi
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo 'Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
    done
    
    FinalizeExportObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure FinalizeExportObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo
        echo "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# GetNumberOfObjectsviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-10-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetNumberOfObjectsviaJQ () {
    #
    # The GetNumberOfObjectsviaJQ obtains the number of objects for that object type indicated.
    #
    
    export objectstotal=
    
    #
    # Troubleshooting output
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
        echo 'Get objectstotal of object type '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    fi
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    errorreturn=$?
    
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem during mgmt_cli objectstotal operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    export number_of_objects=${objectstotal}
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-10-05


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckAPIVersionAndExecuteOperation :  Check the API Version running where we're logged in and if good execute operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckAPIVersionAndExecuteOperation () {
    #
    # Check the API Version running where we're logged in and if good execute operation
    #
    
    GetAPIVersion=$(mgmt_cli show api-versions -f json -s ${APICLIsessionfile} | ${JQ} '.["current-version"]' -r)
    export CheckAPIVersion=${GetAPIVersion}
    
    if [ ${CheckAPIVersion} = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=${CheckAPIVersion}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo 'Required minimum API version for object : '${APICLIobjectstype}' is API version = '${APIobjectminversion} | tee -a -i ${logfilepath}
    echo 'Logged in management server API version = '${CurrentAPIVersion}' Check version : "'${CheckAPIVersion}'"' | tee -a -i ${logfilepath}
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) ] ; then
        # API is sufficient version
        echo | tee -a -i ${logfilepath}
        
        ExportObjectsToCSVviaJQ
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo 'Error '${errorreturn}' in ExportObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
        fi
        
    else
        # API is not of a sufficient version to operate on for this object
        echo | tee -a -i ${logfilepath}
        echo 'Current API Version ('${CurrentAPIVersion}') does not meet minimum API version expected requirement ('${APIobjectminversion}')' | tee -a -i ${logfilepath}
        echo '! skipping object '${APICLIobjectstype}'!' | tee -a -i ${logfilepath}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END : Main Operational repeated proceedures - Export Objects to CSV
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# handle simple objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo ${APICLIdetaillvl}' CSV Export - simple objects - Export to CSV starting!'
echo

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Network Objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Network Objects' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# host objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address","ipv6-address"'
export CSVFileHeader=${CSVFileHeader}',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.ipv4-address","nat-settings.ipv6-address","nat-settings.method"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address"], .["ipv6-address"]'
export CSVJQparms=${CSVJQparms}', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"]'
export CSVJQparms=${CSVJQparms}', .["nat-settings"]["ipv4-address"], .["nat-settings"]["ipv6-address"], .["nat-settings"]["method"]'

objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_hosts="${objectstotal_hosts}"
export number_of_objects=${number_hosts}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# host objects - NO NAT Details
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=NO_NAT

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address","ipv6-address"'
#export CSVFileHeader=${CSVFileHeader}',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.ipv4-address","nat-settings.ipv6-address","nat-settings.method"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address"], .["ipv6-address"]'
#export CSVJQparms=${CSVJQparms}', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"]'
#export CSVJQparms=${CSVJQparms}', .["nat-settings"]["ipv4-address"], .["nat-settings"]["ipv6-address"], .["nat-settings"]["method"]'

objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_hosts="${objectstotal_hosts}"
export number_of_objects=${number_hosts}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=network
export APICLIobjectstype=networks
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"broadcast","subnet4","mask-length4","subnet6","mask-length6"'
export CSVFileHeader=${CSVFileHeader}',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.method"'

export CSVJQparms=
export CSVJQparms='.["broadcast"], .["subnet4"], .["mask-length4"], .["subnet6"], .["mask-length6"]'
export CSVJQparms=${CSVJQparms}', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"], .["nat-settings"]["method"]'

objectstotal_networks=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_networks="$objectstotal_networks"
export number_of_objects=${number_networks}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# wildcard objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.2
export APICLIobjecttype=wildcard
export APICLIobjectstype=wildcards
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address","ipv4-mask-wildcard","ipv6-address","ipv6-mask-wildcard"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address"], .["ipv4-mask-wildcard"], .["ipv6-address"], .["ipv6-mask-wildcard"]'

objectstotal_wildcards=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_wildcards="${objectstotal_wildcards}"
export number_of_objects=${number_wildcards}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader='"name","color","comments"'

export CSVJQparms=
#export CSVJQparms='.["name"], .["color"], .["comments"]'

objectstotal_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_groups="${objectstotal_groups}"
export number_of_objects=${number_groups}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=group-with-exclusion
export APICLIobjectstype=groups-with-exclusion
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"include","except"'

export CSVJQparms=
export CSVJQparms='.["include"]["name"], .["except"]["name"]'

objectstotal_groupswithexclusion=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_groupswithexclusion="${objectstotal_groupswithexclusion}"
export number_of_objects=${number_groupswithexclusion}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=address-range
export APICLIobjectstype=address-ranges
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address-first","ipv4-address-last"'
export CSVFileHeader=${CSVFileHeader}',"ipv6-address-first","ipv6-address-last"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address-first"], .["ipv4-address-last"]'
export CSVJQparms=${CSVJQparms}', .["ipv6-address-first"], .["ipv6-address-last"]'

objectstotal_addressranges=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_addressranges="${objectstotal_addressranges}"
export number_of_objects=${number_addressranges}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# multicast-address-range objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=multicast-address-range
export APICLIobjectstype=multicast-address-ranges
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"ipv4-address-first","ipv4-address-last"'
export CSVFileHeader=${CSVFileHeader}',"ipv6-address-first","ipv6-address-last"'

export CSVJQparms=
export CSVJQparms='.["ipv4-address-first"], .["ipv4-address-last"]'
export CSVJQparms=${CSVJQparms}', .["ipv6-address-first"], .["ipv6-address-last"]'

objectstotal_multicastaddressranges=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_multicastaddressranges="${objectstotal_multicastaddressranges}"
export number_of_objects=${number_multicastaddressranges}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=dns-domain
export APICLIobjectstype=dns-domains
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"is-sub-domain"'

export CSVJQparms=
export CSVJQparms='.["is-sub-domain"]'

objectstotal_dnsdomains=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_dnsdomains="${objectstotal_dnsdomains}"
export number_of_objects=${number_dnsdomains}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# security-zone objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=security-zone
export APICLIobjectstype=security-zones
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_securityzones=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_securityzones="${objectstotal_securityzones}"
export number_of_objects=${number_securityzones}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# dynamic-object objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=dynamic-object
export APICLIobjectstype=dynamic-objects
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_dynamicobjects=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_dynamicobjects="${objectstotal_dynamicobjects}"
export number_of_objects=${number_dynamicobjects}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tag objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=tag
export APICLIobjectstype=tags
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_tags=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tags="${objectstotal_tags}"
export number_of_objects=${number_tags}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-gateway objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=simple-gateway
export APICLIobjectstype=simple-gateways
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_simplegateways=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_simplegateways="${objectstotal_simplegateways}"
export number_of_objects=${number_simplegateways}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# simple-cluster objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6
export APICLIobjecttype=simple-cluster
export APICLIobjectstype=simple-clusters
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_simpleclusters=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_simpleclusters="${objectstotal_simpleclusters}"
export number_of_objects=${number_simpleclusters}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# checkpoint-host objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=checkpoint-hosts
export APICLIobjectstype=checkpoint-hosts
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_checkpointhosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_checkpointhosts="${objectstotal_checkpointhosts}"
export number_of_objects=${number_checkpointhosts}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=time
export APICLIobjectstype=times
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"start.date","start.time","start.iso-8601","start.posix","start-now"'
export CSVFileHeader=${CSVFileHeader}',"end.date","end.time","end.iso-8601","end.posix","end-never"'
export CSVFileHeader=${CSVFileHeader}',"recurrence.pattern"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["start"]["date"], .["start"]["time"], .["start"]["iso-8601"], .["start"]["posix"], .["start-now"]'
export CSVJQparms=${CSVJQparms}', .["end"]["date"], .["end"]["time"], .["end"]["iso-8601"], .["end"]["posix"], .["end-never"]'
export CSVJQparms=${CSVJQparms}', .["recurrence"]["pattern"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_times=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_times="${objectstotal_times}"
export number_of_objects=${number_times}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# time_group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_time_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_time_groups="${objectstotal_time_groups}"
export number_of_objects=${number_time_groups}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-role objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=access-role
export APICLIobjectstype=access-roles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_access_roles=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_access_roles="${objectstotal_access_roles}"
export number_of_objects=${number_access_roles}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# opsec-application objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=opsec-application
export APICLIobjectstype=opsec-applications
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"type"'
export CSVFileHeader=${CSVFileHeader}',"cpmi.enabled","cpmi.administrator-profile","cpmi.use-administrator-credentials"'
export CSVFileHeader=${CSVFileHeader}',"lea.enabled","lea.access-permissions","lea.administrator-profile"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms='.["name"], .["color"], .["comments"]'

export CSVJQparms=${CSVJQparms}', .["type"]'
export CSVJQparms=${CSVJQparms}', .["cpmi"]["enabled"], .["cpmi"]["administrator-profile"], .["cpmi"]["use-administrator-credentials"]'
export CSVJQparms=${CSVJQparms}', .["lea"]["enabled"], .["lea"]["access-permissions"], .["lea"]["administrator-profile"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_opsec_applications=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_opsec_applications="${objectstotal_opsec_applications}"
export number_of_objects=${number_opsec_applications}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# trusted-client objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=trusted-client
export APICLIobjectstype=trusted-clients
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_trustedclients=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_trustedclients="${objectstotal_trustedclients}"
export number_of_objects=${number_trustedclients}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# lsv-profile objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6
export APICLIobjecttype=lsv-profile
export APICLIobjectstype=lsv-profiles
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_lsvprofiles=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_lsvprofiles="${objectstotal_lsvprofiles}"
export number_of_objects=${number_number_lsvprofiles}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# gsn-handover-group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=gsn-handover-group
export APICLIobjectstype=gsn-handover-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_gsnhandovergroups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_gsnhandovergroups="${objectstotal_gsnhandovergroups}"
export number_of_objects=${number_gsnhandovergroups}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# access-point-name objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=access-point-names
export APICLIobjectstype=access-point-names
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_accesspointnames=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_accesspointnames="${objectstotal_accesspointnames}"
export number_of_objects=${number_accesspointnames}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-server objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"encryption","priority","server-type","server.name","service","secret-key"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["encryption"], .["priority"], .["server-type"], .["server"]["name"], .["service"], ""'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_tacacsservers=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tacacsservers="${objectstotal_tacacsservers}"
export number_of_objects=${number_tacacsservers}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# tacacs-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=tacacs-group
export APICLIobjectstype=tacacs-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=

export CSVJQparms=

objectstotal_tacacsgroups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_tacacsgroups="${objectstotal_tacacsgroups}"
export number_of_objects=${number_tacacsgroups}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Service & Applications
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Service & Applications' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# services-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-tcp
export APICLIobjectstype=services-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"port","protocol","source-port"'
export CSVFileHeader=${CSVFileHeader}',"aggressive-aging.enable","aggressive-aging.default-timeout","aggressive-aging.timeout","aggressive-aging.use-default-timeout"'
export CSVFileHeader=${CSVFileHeader}',"keep-connections-open-after-policy-installation","match-by-protocol-signature","match-for-any","override-default-settings"'
export CSVFileHeader=${CSVFileHeader}',"session-timeout","use-default-session-timeout","sync-connections-on-cluster"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'

export CSVJQparms=
export CSVJQparms='.["port"], .["protocol"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-by-protocol-signature"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'

objectstotal_services_tcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_tcp="${objectstotal_services_tcp}"
export number_of_objects=${number_services_tcp}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-udp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-udp
export APICLIobjectstype=services-udp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"port","protocol","source-port"'
export CSVFileHeader=${CSVFileHeader}',"accept-replies","aggressive-aging.enable","aggressive-aging.default-timeout","aggressive-aging.timeout","aggressive-aging.use-default-timeout"'
export CSVFileHeader=${CSVFileHeader}',"keep-connections-open-after-policy-installation","match-by-protocol-signature","match-for-any","override-default-settings"'
export CSVFileHeader=${CSVFileHeader}',"session-timeout","use-default-session-timeout","sync-connections-on-cluster"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'

export CSVJQparms=
export CSVJQparms='.["port"], .["protocol"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["accept-replies"], .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-by-protocol-signature"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'

objectstotal_services_udp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_udp="${objectstotal_services_udp}"
export number_of_objects=${number_services_udp}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-icmp
export APICLIobjectstype=services-icmp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"icmp-code","icmp-type","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["icmp-code"], .["icmp-type"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_icmp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_icmp="${objectstotal_services_icmp}"
export number_of_objects=${number_services_icmp}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-icmp6 objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-icmp6
export APICLIobjectstype=services-icmp6
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"icmp-code","icmp-type","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["icmp-code"], .["icmp-type"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_icmp6=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_icmp6="${objectstotal_services_icmp6}"
export number_of_objects=${number_services_icmp6}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-sctp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-sctp
export APICLIobjectstype=services-sctp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"port","source-port"'
export CSVFileHeader=${CSVFileHeader}',"aggressive-aging.enable","aggressive-aging.default-timeout","aggressive-aging.timeout","aggressive-aging.use-default-timeout"'
export CSVFileHeader=${CSVFileHeader}',"keep-connections-open-after-policy-installation","match-for-any"'
export CSVFileHeader=${CSVFileHeader}',"session-timeout","use-default-session-timeout","sync-connections-on-cluster"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'

export CSVJQparms=
export CSVJQparms='.["port"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-for-any"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'

objectstotal_services_sctp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_sctp="${objectstotal_services_sctp}"
export number_of_objects=${number_services_sctp}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-other objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-other
export APICLIobjectstype=services-other
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"port","source-port"'
export CSVFileHeader=${CSVFileHeader}',"accept-replies","ip-protocol","action","match"'
export CSVFileHeader=${CSVFileHeader}',"aggressive-aging.enable","aggressive-aging.default-timeout","aggressive-aging.timeout","aggressive-aging.use-default-timeout"'
export CSVFileHeader=${CSVFileHeader}',"keep-connections-open-after-policy-installation","match-for-any","override-default-settings"'
export CSVFileHeader=${CSVFileHeader}',"session-timeout","use-default-session-timeout","sync-connections-on-cluster"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'

export CSVJQparms=
export CSVJQparms='.["port"], .["source-port"]'
export CSVJQparms=${CSVJQparms}', .["accept-replies"], .["ip-protocol"], .["action"], .["match"]'
export CSVJQparms=${CSVJQparms}', .["aggressive-aging"]["enable"], .["aggressive-aging"]["default-timeout"], .["aggressive-aging"]["timeout"], .["aggressive-aging"]["use-default-timeout"]'
export CSVJQparms=${CSVJQparms}', .["keep-connections-open-after-policy-installation"], .["match-for-any"], .["override-default-settings"]'
export CSVJQparms=${CSVJQparms}', .["session-timeout"], .["use-default-session-timeout"], .["sync-connections-on-cluster"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'

objectstotal_services_other=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_other="${objectstotal_services_other}"
export number_of_objects=${number_services_other}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-dce-rpc objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-dce-rpc
export APICLIobjectstype=services-dce-rpc
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"interface-uuid","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["interface-uuid"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_dce_rpc=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_dce_rpc="${objectstotal_services_dce_rpc}"
export number_of_objects=${number_services_dce_rpc}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# services-rpc objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-rpc
export APICLIobjectstype=services-rpc
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"program-number","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["program-number"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_services_rpc=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_services_rpc="${objectstotal_services_rpc}"
export number_of_objects=${number_services_rpc}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-gtp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=service-gtp
export APICLIobjectstype=services-gtp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"version","allow-usage-of-static-ip","cs-fallback-and-srvcc","radio-access-technology"'
export CSVFileHeader=${CSVFileHeader}',"restoration-and-recovery","reverse-service","trace-management"'
export CSVFileHeader=${CSVFileHeader}',"access-point-name.enable","access-point-name.apn","apply-access-policy-on-user-traffic.enable","apply-access-policy-on-user-traffic.add-imsi-field-to-log"'
export CSVFileHeader=${CSVFileHeader}',"imsi-prefix.enable","imsi-prefix.prefix","interface-profile.profile","interface-profile.custom-message-types"'
export CSVFileHeader=${CSVFileHeader}',"ldap-group.enable","ldap-group.group","ldap-group.according-to"'
export CSVFileHeader=${CSVFileHeader}',"ms-isdn.enable","ms-isdn.ms-isdn","selection-mode.enable","selection-mode.mode"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.utran","radio-access-technology.geran","radio-access-technology.wlan","radio-access-technology.gan"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.hspa-evolution","radio-access-technology.eutran","radio-access-technology.virtual","radio-access-technology.nb-iot"'
export CSVFileHeader=${CSVFileHeader}',"radio-access-technology.other-types-range.enable","radio-access-technology.other-types-range.types"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["version"], .["allow-usage-of-static-ip"], .["cs-fallback-and-srvcc"], .["radio-access-technology"]'
export CSVJQparms=${CSVJQparms}', .["restoration-and-recovery"], .["reverse-service"], .["trace-management"]'
export CSVJQparms=${CSVJQparms}', .["access-point-name"]["enable"], .["access-point-name"]["apn"], .["apply-access-policy-on-user-traffic"]["enable"], .["apply-access-policy-on-user-traffic"]["add-imsi-field-to-log"]'
export CSVJQparms=${CSVJQparms}', .["imsi-prefix"]["enable"], .["imsi-prefix"]["prefix"], .["interface-profile"]["profile"], .["interface-profile"]["custom-message-types"]'
export CSVJQparms=${CSVJQparms}', .["ldap-group"]["enable"], .["ldap-group"]["group"], .["ldap-group"]["according-to"]'
export CSVJQparms=${CSVJQparms}', .["ms-isdn"]["enable"], .["ms-isdn"]["ms-isdn"], .["selection-mode"]["enable"], .["selection-mode"]["mode"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["utran"], .["radio-access-technology"]["geran"], .["radio-access-technology"]["wlan"], .["radio-access-technology"]["gan"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["hspa-evolution"], .["radio-access-technology"]["eutran"], .["radio-access-technology"]["virtual"], .["radio-access-technology"]["nb-iot"]'
export CSVJQparms=${CSVJQparms}', .["radio-access-technology"]["other-types-range"]["enable"], .["radio-access-technology"]["other-types-range"]["types"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescitrixtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescitrixtcp="${objectstotal_servicescitrixtcp}"
export number_of_objects=${number_servicescitrixtcp}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-citrix-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=service-citrix-tcp
export APICLIobjectstype=services-citrix-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"application"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["application"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescitrixtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescitrixtcp="${objectstotal_servicescitrixtcp}"
export number_of_objects=${number_servicescitrixtcp}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-compound-tcp objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=service-compound-tcp
export APICLIobjectstype=services-compound-tcp
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"compound-service","keep-connections-open-after-policy-installation"'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["compound-service"], .["keep-connections-open-after-policy-installation"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_servicescompoundtcp=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_servicescompoundtcp="${objectstotal_servicescompoundtcp}"
export number_of_objects=${number_servicescompoundtcp}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
# service-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=

export CSVJQparms=

objectstotal_service_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_service_groups="${objectstotal_service_groups}"
export number_of_objects=${number_service_groups}

CheckAPIVersionAndExecuteOperation


#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-08-28
# MODIFIED 2021-01-19 - 3 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-sites objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=application-site
export APICLIobjectstype=application-sites
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"primary-category","urls-defined-as-regular-expression"'
# user-defined can't be imported so while shown, it adds no value for normal operations
if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export CSVFileHeader=${CSVFileHeader}',"user-defined","risk"'
fi
# The next elements are more complex elements, but required for import add operation
export CSVFileHeader=${CSVFileHeader}',"url-list.0","application-signature.0"'
# The next elements are more complex elements, but NOT required for import add operation
export CSVFileHeader=${CSVFileHeader}',"additional-categories.0"'
export CSVFileHeader=${CSVFileHeader}',"description'
#export CSVFileHeader=${CSVFileHeader}',"element","element","element","element"'
#export CSVFileHeader=${CSVFileHeader}',"element.subelement","element.subelement","element.subelement","element.subelement"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["primary-category"], .["urls-defined-as-regular-expression"]'
# user-defined can't be imported so while shown, it adds no value for normal operations
if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export CSVJQparms=${CSVJQparms}', .["user-defined"], .["risk"]'
fi
# The next elements are more complex elements, but required for import add operation
export CSVJQparms=${CSVJQparms}', .["url-list"][0], .["application-signature"][0]'
# The next elements are more complex elements, but NOT required for import add operation
export CSVJQparms=${CSVJQparms}', .["additional-categories"][0]'
export CSVJQparms=${CSVJQparms}', .["description"]'
#export CSVJQparms=${CSVJQparms}', .["element"], .["element"], .["element"], .["element"]'
#export CSVJQparms=${CSVJQparms}', .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"], .["element"]["subelement"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_application_sites=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_sites="${objectstotal_application_sites}"
export number_of_objects=${number_application_sites}

CheckAPIVersionAndExecuteOperation


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-19 - 3
# MODIFIED 2021-01-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-categories objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=application-site-category
export APICLIobjectstype=application-site-categories
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
# user-defined can't be imported so while shown, it adds no value for normal operations
if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export CSVFileHeader='"user-defined"'
fi

export CSVJQparms=
# user-defined can't be imported so while shown, it adds no value for normal operations
if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    export CSVJQparms='.["user-defined"]'
fi

objectstotal_application_site_categories=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_site_categories="${objectstotal_application_site_categories}"
export number_of_objects=${number_application_site_categories}

CheckAPIVersionAndExecuteOperation


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-19
# MODIFIED 2021-01-19 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# application-site-groups objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=

export CSVJQparms=

objectstotal_application_site_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_application_site_groups="${objectstotal_application_site_groups}"
export number_of_objects=${number_application_site_groups}

CheckAPIVersionAndExecuteOperation


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-19


# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Users
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Users' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# -------------------------------------------------------------------------------------------------
# user objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

# User export with credential information is not working properly when done this way, so not exporting authentication method here.
# Handling the export of explicit per user authentication method and inforamtion later in specific complex objects, one export for each authentication-method
# NOTE:  It is not possible to export users Check Point Password value

export CSVFileHeader=
export CSVFileHeader='"template","e-mail","phone-number"'
#export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server.name","tacacs-server.name"'
export CSVFileHeader=${CSVFileHeader}',"expiration-date"'
export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["template"], .["e-mail"], .["phone-number"]'
#export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
export CSVJQparms=${CSVJQparms}', .["expiration-date"]["iso-8601"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_users=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_users="${objectstotal_users}"
export number_of_objects=${number_users}

CheckAPIVersionAndExecuteOperation

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-group objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=user-group
export APICLIobjectstype=user-groups
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"email"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["email"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_user_groups=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_user_groups="${objectstotal_user_groups}"
export number_of_objects=${number_user_groups}

CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# user-template objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=user-template
export APICLIobjectstype=user-templates
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"authentication-method","radius-server.name","tacacs-server.name"'
export CSVFileHeader=${CSVFileHeader}',"expiration-by-global-properties","expiration-date"'
export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
export CSVJQparms=${CSVJQparms}', .["expiration-by-global-properties"], .["expiration-date"]["iso-8601"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_user_templates=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_user_templates="${objectstotal_user_templates}"
export number_of_objects=${number_user_templates}

CheckAPIVersionAndExecuteOperation

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2020-08-19

# ADDED 2020-08-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# identity-tag objects
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.6.1
export APICLIobjecttype=identity-tag
export APICLIobjectstype=identity-tags
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"external-identifier"'
#export CSVFileHeader=${CSVFileHeader}',"OBJECT_PARAMETER_HEADERS"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["external-identifier"]'
#export CSVJQparms=${CSVJQparms}', .["OBJECT_PARAMETERS"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_identity_tags=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_identity_tags="${objectstotal_identity_tags}"
export number_of_objects=${number_identity_tags}

CheckAPIVersionAndExecuteOperation

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


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Common Complex Object Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2017-11-09 -


# -------------------------------------------------------------------------------------------------
# SetupExportComplexObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The SetupExportComplexObjectsToCSVviaJQ is the setup actions for the script's repeated actions.
#

SetupExportComplexObjectsToCSVviaJQ () {
    
    export APICLICSVfilename=${APICLIcomplexobjectstype}
    if [ x"${APICLIexportnameaddon}" != x"" ] ; then
        export APICLICSVfilename=${APICLICSVfilename}'_'${APICLIexportnameaddon}
    fi
    export APICLICSVfilename=${APICLICSVfilename}'_'${APICLIdetaillvl}'_csv'${APICLICSVfileexportsuffix}
    export APICLICSVfile=${APICLIpathexport}/${APICLICSVfilename}
    export APICLICSVfilewip=${APICLICSVpathexportwip}/${APICLICSVfilename}
    export APICLICSVfileheader=${APICLICSVfilewip}.${APICLICSVheaderfilesuffix}
    export APICLICSVfiledata=${APICLICSVfilewip}.data
    export APICLICSVfilesort=${APICLICSVfilewip}.sort
    export APICLICSVfileoriginal=${APICLICSVfilewip}.original
    
    
    if [ ! -r ${APICLICSVpathexportwip} ] ; then
        mkdir -p -v ${APICLICSVpathexportwip} | tee -a -i ${logfilepath}
    fi
    
    if [ -r ${APICLICSVfile} ] ; then
        rm ${APICLICSVfile} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileheader} ] ; then
        rm ${APICLICSVfileheader} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfiledata} ] ; then
        rm ${APICLICSVfiledata} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfilesort} ] ; then
        rm ${APICLICSVfilesort} >> ${logfilepath}
    fi
    if [ -r ${APICLICSVfileoriginal} ] ; then
        rm ${APICLICSVfileoriginal} >> ${logfilepath}
    fi
    
    echo | tee -a -i ${logfilepath}
    echo "Create ${APICLIcomplexobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    #
    # Troubleshooting output
    #
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
        echo 'CSVFileHeader' - ${CSVFileHeader} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    echo ${CSVFileHeader} > ${APICLICSVfileheader} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# FinalizeExportComplexObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinalizeExportComplexObjectsToCSVviaJQ () {
    #
    # The FinalizeExportComplexObjectsToCSVviaJQ is the finaling actions for the script's repeated actions.
    #
    
    if [ ! -r "${APICLICSVfileheader}" ] ; then
        # Uh, Oh, something went wrong, no header file
        echo | tee -a -i ${logfilepath}
        echo '!!!! Error header file missing : '${APICLICSVfileheader} | tee -a -i ${logfilepath}
        echo 'Terminating!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 254
        
    elif [ ! -r "${APICLICSVfiledata}" ] ; then
        # Uh, Oh, something went wrong, no data file
        echo | tee -a -i ${logfilepath}
        echo '!!!! Error data file missing : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo 'Terminating!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 253
        
    elif [ ! -s "${APICLICSVfiledata}" ] ; then
        # data file is empty, nothing was found
        echo | tee -a -i ${logfilepath}
        echo '!! data file is empty : '${APICLICSVfiledata} | tee -a -i ${logfilepath}
        echo 'Skipping CSV creation!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        return 0
        
    fi
    
    echo | tee -a -i ${logfilepath}
    echo "Sort data and build CSV export file" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfileoriginal}
    cat ${APICLICSVfiledata} >> ${APICLICSVfileoriginal}
    
    sort ${APICLICSVsortparms} ${APICLICSVfiledata} > ${APICLICSVfilesort}
    
    cat ${APICLICSVfileheader} > ${APICLICSVfile}
    cat ${APICLICSVfilesort} >> ${APICLICSVfile}
    
    echo | tee -a -i ${logfilepath}
    echo "Done creating ${APICLIcomplexobjectstype} CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    head ${APICLICSVfile} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    
    echo | tee -a -i ${logfilepath}
    return 0
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Common Complex Object Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Generic Complex Objects Type Handler
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Generic Complex Objects Type Handler' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------

# ADDED 2021-01-18 -


# -------------------------------------------------------------------------------------------------
# PopulateArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfObjectsType generates an array of objects type objects for further processing.

PopulateArrayOfObjectsType () {
    
    # MODIFIED 2018-07-20 -
    
    # System Object selection operands
    # Future alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    
    echo "  ${APICLIobjectstype} - Populate up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentobjecttypesoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} '.objects[] | '"${notsystemobjectselector}"' | .name | @sh' -r`"
    else   
        # Don't Ignore System Objects
        MGMT_CLI_OBJECTSTYPE_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentobjecttypesoffset} details-level "standard" -s ${APICLIsessionfile} -f json | ${JQ} ".objects[].name | @sh" -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    while read -r line; do
        ALLOBJECTSTYPARRAY+=("${line}")
        echo -n '.'
    done <<< "${MGMT_CLI_OBJECTSTYPE_STRING}"
    echo
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# GetArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfObjectsType generates an array of objects type objects for further processing.

GetArrayOfObjectsType () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    echo | tee -a -i ${logfilepath}
    echo 'Generate array of '${APICLIobjectstype} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    ALLOBJECTSTYPARRAY=()
    
    export MgmtCLI_Base_OpParms="-f json -s ${APICLIsessionfile}"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"${APICLIdetaillvl}\" ${MgmtCLI_Base_OpParms}"
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    
    currentobjecttypesoffset=0
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentobjecttypesoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
        
        PopulateArrayOfObjectsType
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentobjecttypesoffset=`expr ${currentobjecttypesoffset} + ${WorkAPIObjectLimit}`
    done
    
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# DumpArrayOfObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfObjectsType outputs the array of objects type objects.

DumpArrayOfObjectsType () {
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all objects found
        
        # print the elements in the array
        echo | tee -a -i ${logfilepath}
        echo 'Dump '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        for i in "${ALLOBJECTSTYPARRAY[@]}"
        do
            echo "$i, ${i//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo | tee -a -i ${logfilepath}
        echo 'Done dumping '${APICLIobjectstype} | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


# -------------------------------------------------------------------------------------------------
# CollectMembersInObjectsType proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectMembersInObjectsType outputs the number of objects type members in a group in the array of objects type objects and collects them into the csv file.

CollectMembersInObjectsType () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo | tee -a -i ${logfilepath}
    echo 'Use array of '${APICLIobjectstype}' to generate objects type members CSV' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    for i in "${ALLOBJECTSTYPARRAY[@]}"
    do
        echo | tee -a -i ${logfilepath}
        
        MEMBERS_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${i//\'/}" -s ${APICLIsessionfile} -f json | ${JQ} ".members | length")
        
        NUM_OBJECTSTYPE_MEMBERS=${MEMBERS_COUNT}
        
        if [ ${NUM_OBJECTSTYPE_MEMBERS} -gt 0 ]; then
            # More than zero (0) interfaces, something to process
            echo Group "${i//\'/}"' number of members = '"${NUM_OBJECTSTYPE_MEMBERS}" | tee -a -i ${logfilepath}
            
            COUNTER=0
            
            while [ ${COUNTER} -lt ${NUM_OBJECTSTYPE_MEMBERS} ]; do
                
                MEMBER_NAME=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} ".members[${COUNTER}].name")
                
                if ${APISCRIPTVERBOSE} ; then
                    # Verbose mode ON
                    echo -n '.'
                fi
                
                # Build the output line
                echo -n ${i//\'/},${MEMBER_NAME} >> ${APICLICSVfiledata}
                
                if ${CSVADDEXPERRHANDLE} ; then
                    echo -n 'e'
                    
                    #export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
                    #export CSVJQparms=${CSVJQparms}', true, true'
                    #
                    echo -n ', true, true' >> ${APICLICSVfiledata}
                    
                    # May need to add plumbing to handle the case that not all objects types might support set-if-exists
                    # For now just keep it separate
                    #
                    #export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
                    #export CSVJQparms=${CSVJQparms}', true'
                    
                    #echo -n ', true' >> ${APICLICSVfiledata}
                fi
                
                echo >> ${APICLICSVfiledata}
                
                let COUNTER=COUNTER+1
                
            done
            
        else
            echo Group "${i//\'/}"' number of members = NONE (0 zero)'
        fi
        
    done
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# GetObjectMembers proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetObjectMembers generate output of objects type members from existing objects type objects

GetObjectMembers () {
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        #export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
        #export CSVJQparms=${CSVJQparms}', true'
    fi
    
    SetupExportComplexObjectsToCSVviaJQ
    
    GetArrayOfObjectsType
    
    DumpArrayOfObjectsType
    
    CollectMembersInObjectsType
    
    errorreturn=0
    
    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Error '${errorreturn}' in FinalizeExportComplexObjectsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
    fi
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GenericComplexObjectsMembersHandler proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GenericComplexObjectsMembersHandler () {
    #
    # Generic Handler for Complex Object Types
    
    errorreturn=0
    
    objectstotal_object=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    export number_object="${objectstotal_object}"
    
    if [ ${number_object} -le 0 ] ; then
        # No groups found
        echo | tee -a -i ${logfilepath}
        echo 'No '${APICLIobjectstype}' to generate members from!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    else
        GetObjectMembers
        errorreturn=$?
    fi
    
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END :  Generic Complex Object Member Handling Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=group
export APICLIobjectstype=groups
export APICLIcomplexobjecttype=group-member
export APICLIcomplexobjectstype=group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Time Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=time-group
export APICLIobjectstype=time-groups
export APICLIcomplexobjecttype=time-group-member
export APICLIcomplexobjectstype=time-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : TACACS Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.7
export APICLIobjecttype=tacacs-group
export APICLIobjectstype=tacacs-groups
export APICLIcomplexobjecttype=tacacs-group-member
export APICLIcomplexobjectstype=tacacs-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Service Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=service-group
export APICLIobjectstype=service-groups
export APICLIcomplexobjecttype=service-group-member
export APICLIcomplexobjectstype=service-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : Application Site Group Members
# -------------------------------------------------------------------------------------------------

export APIobjectminversion=1.1
export APICLIobjecttype=application-site-group
export APICLIobjectstype=application-site-groups
export APICLIcomplexobjecttype=application-site-group-member
export APICLIcomplexobjectstype=application-site-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# Generic OBJECT Members : user-group members
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-18 -

export APIobjectminversion=1.6.1
export APICLIobjecttype=user-group
export APICLIobjectstype=user-groups
export APICLIcomplexobjecttype=user-group-member
export APICLIcomplexobjectstype=user-group-members
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

GenericComplexObjectsMembersHandler


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Specific Complex Objects :  These require extra plumbing
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Specific Complex Objects :  These require extra plumbing' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : host interfaces
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Specific Complex OBJECT : host interfaces' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# MODIFIED 2021-01-27 -

# -------------------------------------------------------------------------------------------------
# PopulateArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# PopulateArrayOfHostInterfaces populates array of host objects for further processing.

PopulateArrayOfHostInterfaces () {
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    # MODIFIED 2018-07-20 -
    
    # System Object selection operands
    # Future alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    
    echo | tee -a -i ${logfilepath}
    echo "  ${APICLIobjectstype} - Populate up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currenthostoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    # MGMT_CLI_HOSTS_STRING is a string with multiple lines. Each line contains a name of a host.
    
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} '.objects[] | '"${notsystemobjectselector}"' | .name | @sh' -r`"
    else
        # Don't Ignore System Objects
        MGMT_CLI_HOSTS_STRING="`mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currenthostoffset} details-level "standard" -s ${APICLIsessionfile} -f json | ${JQ} '.objects[].name | @sh' -r`"
    fi
    
    # break the string into an array - each element of the array is a line in the original string
    # there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
    fi
    
    while read -r line; do
        
        ALLHOSTSARR+=("${line}")
        
        echo -n '.' | tee -a -i ${logfilepath}
        
        arraylength=${#ALLHOSTSARR[@]}
        arrayelement=$((arraylength-1))
        
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            # Output list of all hosts found
            echo -n ' '"${line}"', ' | tee -a -i ${logfilepath}
            echo -n "$(eval echo ${line})"', ' | tee -a -i ${logfilepath}
            echo -n "$arraylength"', ' | tee -a -i ${logfilepath}
            echo -n "$arrayelement"', ' | tee -a -i ${logfilepath}
            #echo -n "$(eval echo ${ALLHOSTARR[${arrayelement}]})"', ' | tee -a -i ${logfilepath}
        fi
        
        #INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${ALLHOSTARR[${arrayelement}]})" details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} ".interfaces | length")
        INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "$(eval echo ${line})" details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} ".interfaces | length")
        
        NUM_HOST_INTERFACES=${INTERFACES_COUNT}
        
        if ${APISCRIPTVERBOSE} ; then
            echo -n "${NUM_HOST_INTERFACES}"', ' | tee -a -i ${logfilepath}
        else
            echo -n "${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
        fi
        
        if [ ${NUM_HOST_INTERFACES} -gt 0 ]; then
            HOSTSARR+=("${line}")
            let HostInterfacesCount=HostInterfacesCount+${NUM_HOST_INTERFACES}
            echo -n '!' | tee -a -i ${logfilepath}
        else
            echo -n '-' | tee -a -i ${logfilepath}
        fi
        
        if ${APISCRIPTVERBOSE} ; then
            # Verbose mode ON
            echo | tee -a -i ${logfilepath}
        fi
        
    done <<< "${MGMT_CLI_HOSTS_STRING}"
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo | tee -a -i ${logfilepath}
        echo 'HostInterfacesCount = '${HostInterfacesCount} | tee -a -i ${logfilepath}
    fi
    
    export HostInterfacesCount=${HostInterfacesCount}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# GetArrayOfHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetArrayOfHostInterfaces generates an array of host objects for further processing.

GetArrayOfHostInterfaces () {
    
    echo | tee -a -i ${logfilepath}
    echo 'Generate array of hosts' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    HOSTSARR=()
    ALLHOSTSARR=()
    
    export MgmtCLI_Base_OpParms="-f json -s ${APICLIsessionfile}"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"${APICLIdetaillvl}\" ${MgmtCLI_Base_OpParms}"
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" ${MgmtCLI_Base_OpParms} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    
    currenthostoffset=0
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currenthostoffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
        
        PopulateArrayOfHostInterfaces
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currenthostoffset=`expr ${currenthostoffset} + ${WorkAPIObjectLimit}`
    done
    
    echo | tee -a -i ${logfilepath}
    
    echo | tee -a -i ${logfilepath}
    echo 'Final HostInterfacesCount = '${HostInterfacesCount} | tee -a -i ${logfilepath}
    echo 'Final Host Array = '\>"${HOSTSARR[@]}"\< | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# DumpArrayOfHostsObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# DumpArrayOfHostsObjects outputs the array of host objects.

DumpArrayOfHostsObjects () {
    
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        # Output list of all hosts found
        
        # print the elements in the array
        #echo | tee -a -i ${logfilepath}
        #echo Dump All hosts | tee -a -i ${logfilepath}
        #echo | tee -a -i ${logfilepath}
        #
        #for i in "${ALLHOSTSARR[@]}"
        #do
        #    echo "$i, ${i//\'/}" | tee -a -i ${logfilepath}
        #done
        
        echo | tee -a -i ${logfilepath}
        echo hosts with interfaces defined | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
        for j in "${HOSTSARR[@]}"
        do
            echo "$j, ${j//\'/}" | tee -a -i ${logfilepath}
        done
        
        echo | tee -a -i ${logfilepath}
        echo Done dumping hosts | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# CollectInterfacesInHostObjects proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CollectInterfacesInHostObjects outputs the host interfaces in a host in the array of host objects and collects them into the csv file.

CollectInterfacesInHostObjects () {
    
    #
    # using bash variables in a jq expression
    #
    
    echo | tee -a -i ${logfilepath}
    echo 'Use array of hosts to generate host interfaces CSV' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    for i in "${HOSTSARR[@]}"
    do
        echo | tee -a -i ${logfilepath}
        echo Host with interfaces "${i//\'/}" | tee -a -i ${logfilepath}
        
        INTERFACES_COUNT=$(mgmt_cli show ${APICLIobjecttype} name "${i//\'/}" -s ${APICLIsessionfile} -f json | ${JQ} ".interfaces | length")
        
        NUM_HOST_INTERFACES=${INTERFACES_COUNT}
        
        if [ ${NUM_HOST_INTERFACES} -gt 0 ]; then
            # More than zero (0) interfaces, something to process
            echo host "${i//\'/}"' number of interfaces = '"${NUM_HOST_INTERFACES}" | tee -a -i ${logfilepath}
            
            COUNTER=0
            if ${APISCRIPTVERBOSE} ; then
                # Verbose mode ON
                echo ${CSVFileHeader} | tee -a -i ${logfilepath}
            fi
            
            while [ ${COUNTER} -lt ${NUM_HOST_INTERFACES} ]; do
                
                #echo -n '.' | tee -a -i ${logfilepath}
                
                #export CSVJQparms='.["name"], .["interfaces"]['${COUNTER}']["name"]'
                #export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet4"], .["interfaces"]['${COUNTER}']["mask-length4"], .["interfaces"]['${COUNTER}']["subnet-mask"]'
                #export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet4"], .["interfaces"]['${COUNTER}']["mask-length4"],
                #export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet6"], .["interfaces"]['${COUNTER}']["mask-length6"]'
                #export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["color"], .["interfaces"]['${COUNTER}']["comments"]'
                
                INTERFACE_NAME=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["name"]')
                INTERFACE_subnet4=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["subnet4"]')
                INTERFACE_masklength4=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["mask-length4"]')
                INTERFACE_subnetmask=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["subnet-mask"]')
                INTERFACE_subnet6=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["subnet6"]')
                INTERFACE_masklength6=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["mask-length6"]')
                INTERFACE_COLOR=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["color"]')
                INTERFACE_COMMENT=$(mgmt_cli show ${APICLIobjecttype} name ${i//\'/} -s ${APICLIsessionfile} -f json | ${JQ} '.["interfaces"]['${COUNTER}']["comments"]')
                
                export CSVoutputline="${i//\'/}","$INTERFACE_NAME"
                #export CSVoutputline=${CSVoutputline},"${INTERFACE_subnet4}","${INTERFACE_masklength4}","$INTERFACE_subnetmask"
                export CSVoutputline=${CSVoutputline},"${INTERFACE_subnet4}","${INTERFACE_masklength4}"
                export CSVoutputline=${CSVoutputline},"${INTERFACE_subnet6}","${INTERFACE_masklength6}"
                export CSVoutputline=${CSVoutputline},"${INTERFACE_COLOR}","${INTERFACE_COMMENT}"
                
                if ${CSVADDEXPERRHANDLE} ; then
                    #export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
                    #export CSVJQparms=${CSVJQparms}', true, true'
                    #
                    
                    export CSVoutputline=${CSVoutputline}', true, true'
                    
                    # May need to add plumbing to handle the case that not all objects types might support set-if-exists
                    # For now just keep it separate
                    #
                    #export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
                    #export CSVJQparms=${CSVJQparms}', true'
                    
                    export CSVoutputline=${CSVoutputline}', true'
                fi
                
                if ${APISCRIPTVERBOSE} ; then
                    # Verbose mode ON
                    echo ${CSVoutputline} | tee -a -i ${logfilepath}
                fi
                
                echo ${CSVoutputline} >> ${APICLICSVfiledata} | tee -a -i ${logfilepath}
                
                let COUNTER=COUNTER+1
                
            done
        else
            echo host "${i//\'/}"' number of interfaces = NONE (0 zero)' | tee -a -i ${logfilepath}
        fi
        
    done
    
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# GetHostInterfaces proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetHostInterfaces generate output of host's interfaces from existing hosts with interface objects

GetHostInterfaces () {
    
    export HostInterfacesCount=0
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
        export CSVJQparms=${CSVJQparms}', true'
    fi
    
    SetupExportComplexObjectsToCSVviaJQ
    
    GetArrayOfHostInterfaces
    
    if [ ${HostInterfacesCount} -gt 0 ]; then
        # We have host interfaces to process
        DumpArrayOfHostsObjects
        
        CollectInterfacesInHostObjects
        
        FinalizeExportComplexObjectsToCSVviaJQ
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            return ${errorreturn}
        fi
        
    else
        # No host interfaces
        echo | tee -a -i ${logfilepath}
        echo '! No host interfaces found' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
    fi
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : host interfaces
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.1
export APICLIobjecttype=host
export APICLIobjectstype=hosts
export APICLIcomplexobjecttype=host-interface
export APICLIcomplexobjectstype=host-interfaces
export APICLICSVobjecttype=${APICLIcomplexobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","interfaces.add.name"'
export CSVFileHeader=${CSVFileHeader}',"interfaces.add.subnet4","interfaces.add.mask-length4"'
export CSVFileHeader=${CSVFileHeader}',"interfaces.add.subnet6","interfaces.add.mask-length6"'
export CSVFileHeader=${CSVFileHeader}',"interfaces.add.color","interfaces.add.comments"'

export CSVJQparms='.["name"], .["interfaces"]['${COUNTER}']["name"]'
export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet4"], .["interfaces"]['${COUNTER}']["mask-length4"]'
export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["subnet6"], .["interfaces"]['${COUNTER}']["mask-length6"]'
export CSVJQparms=${CSVJQparms}', .["interfaces"]['${COUNTER}']["color"], .["interfaces"]['${COUNTER}']["comments"]'


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_hosts=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_hosts="${objectstotal_hosts}"

if [ ${number_hosts} -le 0 ] ; then
    # No hosts found
    echo | tee -a -i ${logfilepath}
    echo 'No hosts to generate interfaces from!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
else
    # hosts found
    echo | tee -a -i ${logfilepath}
    echo 'Check hosts to generate interfaces!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    GetHostInterfaces
fi

echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : users authentications
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'Specific Complex OBJECT : users authentications' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# ExportUserAuthenticationsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ExportUserAuthenticationsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the ${APICLIobjectstype} item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportUserAuthenticationsToCSVviaJQ () {
    #
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
        export CSVJQparms=${CSVJQparms}', true'
    fi
    
    SetupExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure SetupExportComplexObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        return ${errorreturn}
    fi
    
    export MgmtCLI_Base_OpParms="-f json -s ${APICLIsessionfile}"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms="details-level \"full\" ${MgmtCLI_Base_OpParms}"
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    
    export userauthtypeselectorelement='."'"${APICLIexportkeycheck}"'" == "'"${APICLIexportkeyvalue}"'"'
    
    # MODIFIED 2018-07-20 -
    
    # System Object selection operands
    # Future alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselectorelement='."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not'
    
    # We need to assemble a more complicated selection method for this
    #
    if ${NoSystemObjects} ; then
        # Ignore System Objects
        export userauthobjectselector='select(('"${notsystemobjectselectorelement}"') and ('"${userauthtypeselectorelement}"'))'
    else
        # Don't Ignore System Objects
        export userauthobjectselector='select('"${userauthtypeselectorelement}"')'
    fi
    
    echo | tee -a -i ${logfilepath}
    echo '  '${APICLIobjectstype}' - Populate up to next '${WorkAPIObjectLimit}' '${APICLIobjecttype}' objects starting with object '${currentuseroffset}' of '${objectslefttoshow}' remaining!' | tee -a -i ${logfilepath}
    echo '  '${APICLIobjectstype}' - Selection criteria '${userauthobjectselector} | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:" | tee -a -i ${logfilepath}
    
    objectslefttoshow=${objectstoshow}
    currentuseroffset=0
    
    echo | tee -a -i ${logfilepath}
    echo "Export ${APICLIobjectstype} to CSV File" | tee -a -i ${logfilepath}
    echo "  and dump to ${APICLICSVfile}" | tee -a -i ${logfilepath}
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo "  mgmt_cli parameters : ${MgmtCLI_Show_OpParms}" | tee -a -i ${logfilepath}
        echo '  CSVJQparms' - ${CSVJQparms} | tee -a -i ${logfilepath}
        echo "  User Authentication Selector : "${userauthobjectselector} | tee -a -i ${logfilepath}
    fi
    echo | tee -a -i ${logfilepath}
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentuseroffset} of ${objectslefttoshow} remaining!" | tee -a -i ${logfilepath}
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentuseroffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        #errorreturn=$?
        
        mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentuseroffset} details-level "full" -s ${APICLIsessionfile} -f json | ${JQ} '.objects[] | '"${userauthobjectselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r >> ${APICLICSVfiledata}
        errorreturn=$?
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo 'Problem during mgmt_cli operation! error return = '${errorreturn} | tee -a -i ${logfilepath}
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentuseroffset=`expr ${currentuseroffset} + ${WorkAPIObjectLimit}`
    done
    
    FinalizeExportComplexObjectsToCSVviaJQ
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Problem found in procedure FinalizeExportComplexObjectsToCSVviaJQ! error return = '${errorreturn} | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
        return ${errorreturn}
    fi
    
    if ${APISCRIPTVERBOSE} ; then
        echo
        echo "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}" | tee -a -i ${logfilepath}
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo | tee -a -i ${logfilepath}
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# GetUserAuthentications proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# GetUserAuthentications generate output of host's interfaces from existing hosts with interface objects

GetUserAuthentications () {
    
    errorreturn=0
    
    ExportUserAuthenticationsToCSVviaJQ
    
    errorreturn=$?
    if [ ${errorreturn} != 0 ] ; then
        # Something went wrong, terminate
        echo 'Error '${errorreturn}' in ExportUserAuthenticationsToCSVviaJQ procedure' | tee -a -i ${logfilepath}
    fi
    
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    
    return ${errorreturn}
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Specific Complex OBJECT : user authentications :  passwords
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-27 - 

export APIobjectminversion=1.6.1
export APICLIobjecttype=user
export APICLIobjectstype=users

#
# APICLICSVsortparms can change due to the nature of the object
#
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
#export CSVFileHeader='"template","e-mail","phone-number"'
#export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server.name","tacacs-server.name"'
#export CSVFileHeader=${CSVFileHeader}',"expiration-date"'
#export CSVFileHeader=${CSVFileHeader}',"encryption.enable-ike","encryption.enable-public-key","encryption.enable-shared-secret"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
#export CSVJQparms='.["template"], .["e-mail"], .["phone-number"]'
#export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
#export CSVJQparms=${CSVJQparms}', .["expiration-date"]["iso-8601"]'
#export CSVJQparms=${CSVJQparms}', .["encryption"]["ike"], .["encryption"]["public-key"], .["encryption"]["shared-secret"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

# MODIFIED 2021-01-27 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

objectstotal_users=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -s ${APICLIsessionfile} | ${JQ} ".total")
export number_users="${objectstotal_users}"

if [ ${number_users} -le 0 ] ; then
    # No Users found
    echo | tee -a -i ${logfilepath}
    echo 'No '${APICLIobjectstype}' to generate authentications from!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
else
    # Users found
    
    # User export with credential information is not working properly when done as a complete object.
    # Handling the export of explicit per user authentication method and inforamtion later in specific complex objects, one export for each authentication-method
    # NOTE:  It is not possible to export users Check Point Password value
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-checkpointpassword'
    export APICLIcomplexobjectstype='users-with-auth-checkpointpassword'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='check point password'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    # NOTE:  It is not possible to export users Check Point Password value
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"password"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', "Pr0v1d3Us3rPa$$W0rdH3r3!"'
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-ospassword'
    export APICLIcomplexobjectstype='users-with-auth-ospassword'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='os password'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-securid'
    export APICLIcomplexobjectstype='users-with-auth-securid'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='securid'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-radius'
    export APICLIcomplexobjectstype='users-with-auth-radius'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='radius'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    #export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server.name","tacacs-server.name"'
    #export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"radius-server"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', .["radius-server"]["name"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-tacacs'
    export APICLIcomplexobjectstype='users-with-auth-tacacs'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='tacacs'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    
    #export CSVFileHeader=${CSVFileHeader}',"authentication-method","radius-server.name","tacacs-server.name"'
    #export CSVJQparms=${CSVJQparms}', .["authentication-method"], .["radius-server"]["name"], .["tacacs-server"]["name"]'
    
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    export CSVFileHeader=${CSVFileHeader}',"tacacs-server.name"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    export CSVJQparms=${CSVJQparms}', .["tacacs-server"]["name"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------------------------------
    # Specific Complex OBJECT : user authentications :  passwords
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2021-01-27 - 
    
    export APIobjectminversion=1.6.1
    export APICLIobjecttype=user
    export APICLIobjectstype=users
    export APICLIcomplexobjecttype='user-with-auth-undefined'
    export APICLIcomplexobjectstype='users-with-auth-undefined'
    export APICLICSVobjecttype=${APICLIcomplexobjectstype}
    export APICLIexportnameaddon=
    
    export APICLIexportkeycheck='authentication-method'
    export APICLIexportkeyvalue='undefined'
    
    #
    # APICLICSVsortparms can change due to the nature of the object
    #
    export APICLICSVsortparms='-f -t , -k 1,1'
    
    export CSVFileHeader='"name","authentication-method"'
    #export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey"'
    
    export CSVJQparms='.["name"], .["authentication-method"]'
    #export CSVJQparms=${CSVJQparms}', .["key"]["subkey"], .["key"]["subkey"]'
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    GetUserAuthentications
    
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more complex objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo 'No more complex objects' | tee -a -i ${logfilepath}
echo '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# No more objects
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


echo | tee -a -i ${logfilepath}
echo ${APICLIdetaillvl}' CSV dump - Completed!' | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

echo | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

return 0


# =================================================================================================
# END:  Export objects to csv
# =================================================================================================
# =================================================================================================

