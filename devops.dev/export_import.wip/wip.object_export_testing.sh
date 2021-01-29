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
ScriptVersion=00.60.03
ScriptRevision=010
ScriptDate=2021-01-29
TemplateVersion=00.60.03
APISubscriptsVersion=00.60.03
APISubscriptsRevision=006

#

export APITestScriptVersion=v${ScriptVersion}
export APITestScriptTemplateVersion=v${TemplateVersion}

export APITestScriptVersionX=v${ScriptVersion//./x}
export APITestScriptTemplateVersionX=v${TemplateVersion//./x}

TestScriptName=cli_api_export_objects_actions_to_csv
export APITestScriptFileNameRoot=cli_api_export_objects_actions_to_csv
export APITestScriptShortName=export_objects_actions_to_csv
export APITestScriptnohupName=${APITestScriptShortName}
export APITestScriptDescription="Object dump to CSV action operations for API CLI Operations"

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START Initial Script Setup
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# =================================================================================================
# START:  Setup Root Parameters
# =================================================================================================


export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`

export scriptspathroot=/var/log/__customer/upgrade_export/scripts

export rootscriptconfigfile=__root_script_config.sh

export logfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log


# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------


echo
echo 'TestScriptName:  '${TestScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision}
echo

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Root script declarations
# -------------------------------------------------------------------------------------------------

# ADDED 2018-11-20 -

# Output folder is relative to local folder where script is started, e.g. ./dump
#
export OutputRelLocalPath=true


# If there are issues with running in /home/ subfolder set this to false
#
export IgnoreInHome=true


# Configure output file folder target
# One of these needs to be set to true, just one
#
export OutputToRoot=false
export OutputToDump=true
export OutputToChangeLog=false
export OutputToOther=false
#
# if OutputToOther is true, then this next value needs to be set
#
export OtherOutputFolder=Specify_The_Folder_Here

# if we are date-time stamping the output location as a subfolder of the 
# output folder set this to true,  otherwise it needs to be false
#
export OutputDATESubfolder=true
export OutputDTGSSubfolder=false
export OutputSubfolderScriptName=false
export OutputSubfolderScriptShortName=true

export notthispath=/home/
export startpathroot=.

export localdotpath=`echo ${PWD}`
export currentlocalpath=${localdotpath}
export workingpath=$currentlocalpath

# -------------------------------------------------------------------------------------------------

# Set these to a starting state we know before we begin
#
export APISCRIPTVERBOSE=false

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# ADDED 2018-05-03 -
# ================================================================================================
# NOTE:  
#   DefaultMgmtAdmin value is used to set the APICLIadmin value in the setup for logon.  This is
#   the default fall back value if the --user parameter is not used to set the actual management 
#   server admininstrator name.  This value should be set to the organizational standard to
#   simplify operation, since it is the default that is used for mgmt_cli login user, where the
#   password must still be entered
# ================================================================================================

#export DefaultMgmtAdmin=admin
export DefaultMgmtAdmin=administrator


# 2018-05-02 - script type - export objects (specific to CSV)

export script_use_publish="false"

export script_use_export="true"
export script_use_import="false"
export script_use_delete="false"
export script_use_csvfile="false"

export script_dump_csv="true"
export script_dump_json="false"
export script_dump_standard="false"
export script_dump_full="false"

export script_uses_wip="true"
export script_uses_wip_json="false"

# ADDED 2018-10-27 -
export UseR8XAPI=true
export UseJSONJQ=true

# ADDED 2020-02-07 -
export UseJSONJQ16=true

# MODIFIED 2019-01-17 -
# R80       version 1.0
# R80.10    version 1.1
# R80.20.M1 version 1.2
# R80.20 GA version 1.3
# R80.20.M2 version 1.4
# R80.30    version 1.5
# R80.40    version 1.6
# R80.40 JHF 78 version 1.6.1
# R81       version 1.7
#
# For common scripts minimum API version at 1.0 should suffice, otherwise get explicit
#
export MinAPIVersionRequired=1.1

# If the API version needs to be enforced in commands set this to true
# NOTE not currently used!
#
export ForceAPIVersionToMinimum=false

# Wait time in seconds
export WAITTIME=15


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Configure location for api subscripts
# -------------------------------------------------------------------------------------------------

# ADDED 2020-11-16 -
# Configure basic location for api subscripts
export api_subscripts_default_root=..
export api_subscripts_default_folder=_api_subscripts
export api_subscripts_checkfile=api_subscripts_version.${APISubscriptsRevision}.v${APISubscriptsVersion}.version

#
# Check for whether the subscripts are present where expected, if not hard EXIT
#
if [ -r "${api_subscripts_default_root}/${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, found the api subscripts in the default root
    export api_subscripts_root=${api_subscripts_default_root}
elif [ -r "./${api_subscripts_default_folder}/${api_subscripts_checkfile}" ]; then
    # OK, didn't find the api subscripts in the default root, instead found them in the working folder
    export api_subscripts_root=.
else
    # OK, didn't find the api subscripts where we expect to find them, so this is bad!
    echo | tee -a -i ${logfilepath}
    echo 'Missing critical api subscript files that are expected in the one of the following locations:' | tee -a -i ${logfilepath}
    echo ' PREFERRED Location :  '"${api_subscripts_default_root}/${api_subscripts_default_folder}/${api_subscripts_checkfile}" | tee -a -i ${logfilepath}
    echo ' ALTERNATE Location :  '"./${api_subscripts_default_folder}/${api_subscripts_checkfile}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Unable to continue without these api subscript files, so exiting!!!' | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    echo 'Log File location : '"${logfilepath}" | tee -a -i ${logfilepath}
    echo | tee -a -i ${logfilepath}
    exit 1
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -
# Configure basic information for formation of file path for basic script setup API Scripts handler script
#
# basic_script_setup_API_handler_root - root path to basic script setup API Scripts handler script. Period (".") indicates root of script source folder
# basic_script_setup_API_handler_folder - folder for under root path to basic script setup API Scripts handler script
# basic_script_setup_API_handler_file - filename, without path, for basic script setup API Scripts handler script
#

# MODIFIED 2020-11-16 -
export basic_script_setup_API_handler_root=..
export basic_script_setup_API_handler_folder=_api_subscripts
export basic_script_setup_API_handler_file=basic_script_setup_API_scripts.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -
# Configure basic information for formation of file path for command line parameter handler script
#
# cli_api_cmdlineparm_handler_root - root path to command line parameter handler script
# cli_api_cmdlineparm_handler_folder - folder for under root path to command line parameter handler script
# cli_api_cmdlineparm_handler_file - filename, without path, for command line parameter handler script
#

# MODIFIED 2020-09-09 -
export cli_api_cmdlineparm_handler_root=${api_subscripts_root}
export cli_api_cmdlineparm_handler_folder=${api_subscripts_default_folder}
export cli_api_cmdlineparm_handler_file=cmd_line_parameters_handler.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-09 -
# Configure basic information for formation of file path for gaia version handler script
#
# gaia_version__handler_root - root path to gaia version handler script. Period (".") indicates root of script source folder
# gaia_version__handler_folder - folder for under root path to gaia version handler script
# gaia_version__handler_file - filename, without path, for gaia version handler script
#

# MODIFIED 2020-09-09 -
export gaia_version_handler_root=${api_subscripts_root}
export gaia_version_handler_folder=${api_subscripts_default_folder}
export gaia_version_handler_file=identify_gaia_and_installation.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -
# Configure basic information for formation of file path for Script Output Paths and Folders for API scripts handler script
#
# script_output_paths_API_handler_root - root path to Script Output Paths and Folders for API scripts handler script. Period (".") indicates root of script source folder
# script_output_paths_API_handler_folder - folder for under root path to Script Output Paths and Folders for API scripts handler script
# script_output_paths_API_handler_file - filename, without path, for Script Output Paths and Folders for API scripts handler script
#

# MODIFIED 2020-11-16 -
export script_output_paths_API_handler_root=..
export script_output_paths_API_handler_folder=_api_subscripts
export script_output_paths_API_handler_file=script_output_paths_and_folders_API_scripts.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -
# Configure basic information for formation of file path for basic script setup API Scripts handler script
#
# mgmt_cli_API_operations_handler_root - root path to basic script setup API Scripts handler script. Period (".") indicates root of script source folder
# mgmt_cli_API_operations_handler_folder - folder for under root path to basic script setup API Scripts handler script
# mgmt_cli_API_operations_handler_file - filename, without path, for basic script setup API Scripts handler script
#

# MODIFIED 2020-11-16 -
export mgmt_cli_API_operations_handler_root=..
export mgmt_cli_API_operations_handler_folder=_api_subscripts
export mgmt_cli_API_operations_handler_file=mgmt_cli_api_operations.subscript.common.${APISubscriptsRevision}.v${APISubscriptsVersion}.sh

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export FileExtJSON=json
export FileExtCSV=csv
export FileExtTXT=txt

export APICLIfileexportpre=dump_

export APICLIfileexportext=${FileExtJSON}
export APICLIfileexportsuffix=${DATE}'.'${APICLIfileexportext}

export APICLICSVfileexportext=${FileExtCSV}
export APICLICSVfileexportsuffix='.'${APICLICSVfileexportext}

export APICLIJSONfileexportext=${FileExtJSON}
export APICLIJSONfileexportsuffix='.'${APICLIJSONfileexportext}

export MinAPIObjectLimit=500
export MaxAPIObjectLimit=500
export WorkAPIObjectLimit=${MaxAPIObjectLimit}

# Configure basic information for formation of file path for action handler scripts
#
# APIScriptActionFileRoot - root path to for action handler scripts
# APIScriptActionFileFolder - folder under root path to for action handler scripts
# APIScriptActionFilePath - path, for action handler scripts
#
export APIScriptActionFileRoot=.
export APIScriptActionFileFolder=

export APIScriptActionFilePrefix=cli_api_actions

export APIScriptJSONActionFilename=${APIScriptActionFilePrefix}.'export_objects_to_json'.sh
#export APIScriptJSONActionFilename=${APIScriptActionFilePrefix}'_actions_'${APIScriptVersion}.sh

export APIScriptCSVActionFilename=${APIScriptActionFilePrefix}.'export_objects_to_csv'.sh
#export APIScriptCSVActionFilename=${APIScriptActionFilePrefix}'_actions_to_csv_'${APIScriptVersion}.sh

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Setup Root Parameters
# =================================================================================================
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# START Define command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-09-30 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#


#
# Standard R8X API Scripts Command Line Parameters
#
# -? | --help
# -v | --verbose
#
# --NOWAIT
#
# -P <web-ssl-port> | --port <web-ssl-port> | -P=<web-ssl-port> | --port=<web-ssl-port>
# -r | --root
# -u <admin_name> | --user <admin_name> | -u=<admin_name> | --user=<admin_name>
# -p <password> | --password <password> | -p=<password> | --password=<password>
# --api-key "<api_key_value>" | --api-key="<api_key_value>" 
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# --session-timeout <session_time_out> 10-3600
# -l <log_path> | --log-path <log_path> | -l=<log_path> | --log-path=<log_path>'
#
# -o <output_path> | --output <output_path> | -o=<output_path> | --output=<output_path> 
# -c <csv_path> | --csv <csv_path> | -c=<csv_path> | --csv=<csv_path>'
#

# MODIFIED 2020-09-30
export REMAINS=

export SHOWHELP=false
export CLIparm_NOWAIT=

# MODIFIED 2018-09-21 -
#export CLIparm_websslport=443
export CLIparm_websslport=

export CLIparm_rootuser=false
export CLIparm_user=
export CLIparm_password=
# ADDED 2020-08-19 -
export CLIparm_api_key=
export CLIparm_use_api_key=false

export CLIparm_domain=
export CLIparm_sessionidfile=

export CLIparm_sessiontimeout=
export CLIparm_logpath=

export CLIparm_outputpath=
export CLIparm_csvpath=

# --NOWAIT
#
if [ -z "${NOWAIT}" ]; then
    # NOWAIT mode not set from shell level
    export CLIparm_NOWAIT=false
    export NOWAIT=false
elif [ x"`echo "${NOWAIT}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NOWAIT mode set OFF from shell level
    export CLIparm_NOWAIT=false
    export NOWAIT=false
elif [ x"`echo "${NOWAIT}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NOWAIT mode set ON from shell level
    export CLIparm_NOWAIT=true
    export NOWAIT=true
else
    # NOWAIT mode set to wrong value from shell level
    export CLIparm_NOWAIT=false
    export NOWAIT=false
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-09-30
# MODIFIED 2021-01-16 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Specific Scripts Command Line Parameters
#
# -f <format[all|csv|json]> | --format <format[all|csv|json]> | -f=<format[all|csv|json]> | --format=<format[all|csv|json]> 
#
# --details <level[all|full|standard]> | --DETAILSLEVEL <level[all|full|standard]> | --details=<level[all|full|standard]> | --DETAILSLEVEL=<level[all|full|standard]> 
#
# --DEVOPSRESULTS | --RESULTS
# --DEVOPSRESULTSPATH <results_path> | --RESULTSPATH <results_path> | --DEVOPSRESULTSPATH=<results_path> | --RESULTSPATH=<results_path> 
#
# -x <export_path> | --export <export_path> | -x=<export_path> | --export=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path> 
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path> 
#
# --NSO | --no-system-objects
# --SO | --system-objects
#
# --5-TAGS | --CSVEXPORT05TAGS
# --10-TAGS | --CSVEXPORT10TAGS
# --NO-TAGS | --CSVEXPORTNOTAGS
#
# --CLEANUPWIP
# --NODOMAINFOLDERS
# --CSVADDEXPERRHANDLE
#
# --CSVEXPORTDATADOMAIN
# --CSVEXPORTDATACREATOR
# --CSVEXPORTDATAALL
#

# ADDED 2020-11-23 -
# Define output format from all, csv, or json

export CLIparm_format=all
export CLIparm_formatall=true
export CLIparm_formatcsv=true
export CLIparm_formatjson=true

# ADDED 2020-11-23 -
# Define output details level from all, full, or standard for json format output
# Default output details level for json format output is all
export CLIparm_detailslevel=all
export CLIparm_detailslevelall=true
export CLIparm_detailslevelfull=true
export CLIparm_detailslevelstandard=true
# ADDED 2020-11-23 -
# Determine utilization of devops.results folder in parent folder

export CLIparm_UseDevOpsResults=false
export UseDevOpsResults=false
export CLIparm_resultspath=

export CLIparm_exportpath=
export CLIparm_importpath=
export CLIparm_deletepath=

# ADDED 2021-01-16 -
# Define number tags to export to CSV :  5, 10, none

export CSVEXPORT05TAGS=true
export CSVEXPORT10TAGS=false
export CSVEXPORTNOTAGS=false
export CLIparm_CSVEXPORT05TAGS=${CSVEXPORT05TAGS}
export CLIparm_CSVEXPORT10TAGS=${CSVEXPORT10TAGS}
export CLIparm_CSVEXPORTNOTAGS=${CSVEXPORTNOTAGS}

# MODIFIED 2018-06-24 -
#export CLIparm_NoSystemObjects=true
export CLIparm_NoSystemObjects=false

export CLIparm_CLEANUPWIP=
export CLIparm_NODOMAINFOLDERS=
export CLIparm_CSVADDEXPERRHANDLE=

# --CLEANUPWIP
#
if [ -z "${CLEANUPWIP}" ]; then
    # CLEANUPWIP mode not set from shell level
    export CLIparm_CLEANUPWIP=false
    export CLEANUPWIP=false
elif [ x"`echo "${CLEANUPWIP}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CLEANUPWIP mode set OFF from shell level
    export CLIparm_CLEANUPWIP=false
    export CLEANUPWIP=false
elif [ x"`echo "${CLEANUPWIP}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CLEANUPWIP mode set ON from shell level
    export CLIparm_CLEANUPWIP=true
    export CLEANUPWIP=true
else
    # CLEANUPWIP mode set to wrong value from shell level
    export CLIparm_CLEANUPWIP=false
    export CLEANUPWIP=false
fi

# --NODOMAINFOLDERS
#
if [ -z "${NODOMAINFOLDERS}" ]; then
    # NODOMAINFOLDERS mode not set from shell level
    export CLIparm_NODOMAINFOLDERS=false
    export NODOMAINFOLDERS=false
elif [ x"`echo "${NODOMAINFOLDERS}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NODOMAINFOLDERS mode set OFF from shell level
    export CLIparm_NODOMAINFOLDERS=false
    export NODOMAINFOLDERS=false
elif [ x"`echo "${NODOMAINFOLDERS}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NODOMAINFOLDERS mode set ON from shell level
    export CLIparm_NODOMAINFOLDERS=true
    export NODOMAINFOLDERS=true
else
    # NODOMAINFOLDERS mode set to wrong value from shell level
    export CLIparm_NODOMAINFOLDERS=false
    export NODOMAINFOLDERS=false
fi

# --CSVADDEXPERRHANDLE
#
if [ -z "${CSVADDEXPERRHANDLE}" ]; then
    # CSVADDEXPERRHANDLE mode not set from shell level
    export CLIparm_CSVADDEXPERRHANDLE=false
    export CSVADDEXPERRHANDLE=false
elif [ x"`echo "${CSVADDEXPERRHANDLE}" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CSVADDEXPERRHANDLE mode set OFF from shell level
    export CLIparm_CSVADDEXPERRHANDLE=false
    export CSVADDEXPERRHANDLE=false
elif [ x"`echo "${CSVADDEXPERRHANDLE}" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CSVADDEXPERRHANDLE mode set ON from shell level
    export CLIparm_CSVADDEXPERRHANDLE=true
    export CSVADDEXPERRHANDLE=true
else
    # CLEANUPWIP mode set to wrong value from shell level
    export CLIparm_CSVADDEXPERRHANDLE=false
    export CSVADDEXPERRHANDLE=false
fi

# ADDED 2020-09-30 -
# --CSVEXPORTDATADOMAIN :  Export Data Domain information to CSV
# --CSVEXPORTDATACREATOR :  Export Data Creator and other MetaData to CSV
# --CSVEXPORTDATAALL :  Export Data Domain and Data Creator and other MetaData to CSV

export CLIparm_CSVEXPORTDATADOMAIN=false
export CLIparm_CSVEXPORTDATACREATOR=false

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-16


# -------------------------------------------------------------------------------------------------
# END Define command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export APISCRIPTVERBOSE=true


# =================================================================================================
# =================================================================================================
# START:  Export objects to csv
# =================================================================================================


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
        
        echo "No objects of type ${APICLIobjecttype} to process, skipping..."
        
        return 0
       
    else
        # we have objects to handle
        echo "Processing ${number_of_objects} ${APICLIobjecttype} objects..."
        echo
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
    
    # MODIFIED 2021-01-28 -
    
    if ${CSVADDEXPERRHANDLE} ; then
        export CSVFileHeader=${CSVFileHeader}',"ignore-warnings","ignore-errors"'
        export CSVJQparms=${CSVJQparms}', true, true'
        #
        # May need to add plumbing to handle the case that not all objects types might support set-if-exists
        # For now just keep it separate
        #
        if ${APIobjectcansetifexists} ; then
            export CSVFileHeader=${CSVFileHeader}',"set-if-exists"'
            export CSVJQparms=${CSVJQparms}', true'
        fi
    fi
    
    export MgmtCLI_Base_OpParms="-f json -r true"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    
    export MgmtCLI_Show_OpParms='details-level full '${MgmtCLI_Base_OpParms}
    
    # MODIFIED 2018-07-20 - CLEANED UP 2020-10-05
    
    # This should work, but might need more tweeks if other data types use more values
    #export notsystemobjectselector='select(."domain"."name" | contains ("Check Point Data", "APPI Data", "IPS Data") | not)'
    #export notsystemobjectselector='select(any(."domain"."name"; in("Check Point Data", "APPI Data", "IPS Data")) | not)'
    #export notsystemobjectselector='select((."domain"."name" != "Check Point Data") and (."domain"."name" != "APPI Data") and (."domain"."name" != "IPS Data"))'
    #
    # Current alternative if more options to exclude are needed
    export systemobjectdomains='"Check Point Data", "APPI Data", "IPS Data"'
    export notsystemobjectselector='select(."domain"."name" as $a | ['${systemobjectdomains}'] | index($a) | not)'
    
    objectstotal=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -r true | ${JQ} ".total")
    
    objectstoshow=${objectstotal}
    
    echo "Processing ${objectstoshow} ${APICLIobjecttype} objects in ${WorkAPIObjectLimit} object chunks:"
    
    objectslefttoshow=${objectstoshow}
    currentoffset=0
    
    echo
    echo "Export ${APICLIobjectstype} to CSV File"
    echo "  and dump to ${APICLICSVfile}"
    if ${APISCRIPTVERBOSE} ; then
        # Verbose mode ON
        echo "  mgmt_cli parameters : ${MgmtCLI_Show_OpParms}"
        echo '  CSVJQparms' - ${CSVJQparms}
        echo "  System Object Selector : "${notsystemobjectselector}
    fi
    echo
    
    while [ ${objectslefttoshow} -ge 1 ] ; do
        # we have objects to process
        echo "  Now processing up to next ${WorkAPIObjectLimit} ${APICLIobjecttype} objects starting with object ${currentoffset} of ${objectslefttoshow} remaining!"
        
        #mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r
        #errorreturn=$?
        
        if ${NoSystemObjects} ; then
            # Ignore System Objects
            mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | '"${notsystemobjectselector}"' | [ '"${CSVJQparms}"' ] | @csv' -r
            errorreturn=$?
        else   
            # Don't Ignore System Objects
            mgmt_cli show ${APICLIobjectstype} limit ${WorkAPIObjectLimit} offset ${currentoffset} ${MgmtCLI_Show_OpParms} | ${JQ} '.objects[] | [ '"${CSVJQparms}"' ] | @csv' -r
            errorreturn=$?
        fi
        
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo 'Problem during mgmt_cli operation! error return = '${errorreturn}
            return ${errorreturn}
        fi
        
        objectslefttoshow=`expr ${objectslefttoshow} - ${WorkAPIObjectLimit}`
        currentoffset=`expr ${currentoffset} + ${WorkAPIObjectLimit}`
    done
    
    if ${APISCRIPTVERBOSE} ; then
        echo
        echo "Done with Exporting ${APICLIobjectstype} to CSV File : ${APICLICSVfile}"
        
        if ! ${NOWAIT} ; then
            read -t ${WAITTIME} -n 1 -p "Any key to continue.  Automatic continue after ${WAITTIME} seconds : " anykey
        fi
        
    fi
    
    echo
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-18


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
    
    GetAPIVersion=$(mgmt_cli show api-versions -f json -r true | ${JQ} '.["current-version"]' -r)
    export CheckAPIVersion=${GetAPIVersion}
    
    if [ ${CheckAPIVersion} = null ] ; then
        # show api-versions does not exist in version 1.0, so it fails and returns null
        CurrentAPIVersion=1.0
    else
        CurrentAPIVersion=${CheckAPIVersion}
    fi
    
    echo
    echo 'Required minimum API version for object : '${APICLIobjectstype}' is API version = '${APIobjectminversion}
    echo 'Logged in management server API version = '${CurrentAPIVersion}' Check version : "'${CheckAPIVersion}'"'
    
    errorreturn=0
    
    if [ $(expr ${APIobjectminversion} '<=' ${CurrentAPIVersion}) ] ; then
        # API is sufficient version
        echo
        
        ExportObjectsToCSVviaJQ
        errorreturn=$?
        if [ ${errorreturn} != 0 ] ; then
            # Something went wrong, terminate
            echo 'Error '${errorreturn}' in ExportObjectsToCSVviaJQ procedure'
        fi
        
    else
        # API is not of a sufficient version to operate on for this object
        echo
        echo 'Current API Version ('${CurrentAPIVersion}') does not meet minimum API version expected requirement ('${APIobjectminversion}')'
        echo '! skipping object '${APICLIobjectstype}'!'
    fi
    
    echo
    echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
    echo
    
    return ${errorreturn}
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2021-01-27


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# tacacs-server objects
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-01-28 -

export APIobjectminversion=1.7
export APIobjectcansetifexists=false
export APICLIobjecttype=tacacs-server
export APICLIobjectstype=tacacs-servers
export APICLICSVobjecttype=${APICLIobjectstype}
export APICLIexportnameaddon=

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader=
export CSVFileHeader='"server-type"'
export CSVFileHeader=${CSVFileHeader}',"server.name"'
export CSVFileHeader=${CSVFileHeader}',"service"'
export CSVFileHeader=${CSVFileHeader}',"priority"'
export CSVFileHeader=${CSVFileHeader}',"encryption"'
export CSVFileHeader=${CSVFileHeader}',"secret-key"'
#export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
#export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
#export CSVFileHeader=${CSVFileHeader}',"icon"'

export CSVJQparms=
export CSVJQparms='.["server-type"]'
export CSVJQparms=${CSVJQparms}', .["server"]["name"]'
export CSVJQparms=${CSVJQparms}', .["service"]["name"]'
export CSVJQparms=${CSVJQparms}', .["priority"]'
export CSVJQparms=${CSVJQparms}', .["encryption"]'
export CSVJQparms=${CSVJQparms}', ""'
#export CSVJQparms=${CSVJQparms}', "Y0urP4$$w04dH3r3"'
#export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
#export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
#export CSVJQparms=${CSVJQparms}', .["icon"]'

objectstotal_tacacsservers=$(mgmt_cli show ${APICLIobjectstype} limit 1 offset 0 details-level "standard" -f json -r true | ${JQ} ".total")
export number_tacacsservers="${objectstotal_tacacsservers}"
export number_of_objects=${number_tacacsservers}

CheckAPIVersionAndExecuteOperation


# -------------------------------------------------------------------------------------------------
