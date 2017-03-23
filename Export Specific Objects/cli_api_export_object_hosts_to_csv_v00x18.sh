#!/bin/bash
#
# SCRIPT Object export hosts to CSV file for API CLI Operations
#
ScriptVersion=00.18.03
ScriptDate=2017-03-22

#

export APIScriptVersion=v00x18
ScriptName=cli_api_export_object_hosts_to_csv_$APIScriptVersion

#export APIScriptSubFilePrefix=cli_api_export_objects
#export APIScriptSubFile=$APIScriptSubFilePrefix'_actions_'$APIScriptVersion.sh
#export APIScriptCSVSubFile=$APIScriptSubFilePrefix'_actions_to_csv_'$APIScriptVersion.sh

# =================================================================================================
# START:  Command Line Parameter Handling and Help
# =================================================================================================


# Code template for parsing command line parameters using only portable shell
# code, while handling both long and short params, handling '-f file' and
# '-f=file' style param data and also capturing non-parameters to be inserted
# back into the shell positional parameters.

SHOWHELP=false
CLIparm_rootuser=false
CLIparm_user=
CLIparm_password=
CLIparm_mgmt=
CLIparm_domain=
CLIparm_sessionidfile=
CLIparm_outputpath=
CLIparm_importpath=
CLIparm_deletepath=

#
# Standard Command Line Parameters
#
# -? | --help
# -r | --root
# -u <admin_name> | --user <admin_name> | -u=<admin_name> | --user=<admin_name>
# -p <password> | --password <password> | -p=<password> | --password=<password>
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | -session-file <session_file_filepath> | -s=<session_file_filepath> | -session-file=<session_file_filepath>
# -o <output_path> | --output <output_path> | -o=<output_path> | --output=<output_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path>'
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path>'
#

# -------------------------------------------------------------------------------------------------
# Help display proceedure
# -------------------------------------------------------------------------------------------------

# Show help information

doshowhelp () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo
    echo $ScriptName' [-?]|[[-r]|[-u <admin_name>] [-p <password>]] [-m <server_IP>] [-d <domain>] [-s <session_file_filepath>] [-o <output_path>] [-i <import_path>]'
    echo
    echo ' Script Version:  '$ScriptVersion'  Date:  '$ScriptDate
    echo
    echo ' Standard Command Line Parameters: '
    echo
    echo '  Show Help                  -? | --help'
    echo
    echo '  Authenticate as root       -r | --root'
    echo '  Set Console User Name      -u <admin_name> | --user <admin_name> |'
    echo '                             -u=<admin_name> | --user=<admin_name>'
    echo '  Set Console User password  -p <password> | --password <password> |'
    echo '                             -p=<password> | --password=<password>'
    echo '  Set Management Server IP   -m <server_IP> | --management <server_IP> |'
    echo '                             -m=<server_IP> | --management=<server_IP>'
    echo '  Set Management Domain      -d <domain> | --domain <domain> |'
    echo '                             -d=<domain> | --domain=<domain>'
    echo '  Set session file path      -s <session_file_filepath> |'
    echo '                             -session-file <session_file_filepath> |'
    echo '                             -s=<session_file_filepath> |'
    echo '                             -session-file=<session_file_filepath>'
    echo '  Set output file path       -o <output_path> | --output <output_path> |'
    echo '                             -o=<output_path> | --output=<output_path>'
    echo '  Set import file path       -i <import_path> | --import-path <import_path> |'
    echo '                             -i=<import_path> | --import-path=<import_path>'
    echo '  Set delete file path       -k <delete_path> | --delete-path <delete_path> |'
    echo '                             -k=<delete_path> | --delete-path=<delete_path>'
    echo
    echo '  session_file_filepath = fully qualified file path for session file'
    echo '  output_path = fully qualified file path for output file'
    echo '  import_path = fully qualified folder path for import files'
    echo '  delete_path = fully qualified folder path for delete files'
    echo
    echo ' Example:'
    echo
    echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -o "/var/tmp/script_dump.txt" -k "/var/tmp/delete/"'
    echo
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo
    return 1
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#
# Testing
#
#echo "Before"
#for i ; do echo - $i ; done
#echo CLI parms - number "$#" parms "$@"
#echo
#


# -------------------------------------------------------------------------------------------------
# Process command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------

while [ -n "$1" ]; do
    # Copy so we can modify it (can't modify $1)
    OPT="$1"

    # testing
    #echo 'OPT = '$OPT
    #

    # Detect argument termination
    if [ x"$OPT" = x"--" ]; then
        # testing
        # echo "Argument termination"
        #
        
        shift
        for OPT ; do
            REMAINS="$REMAINS \"$OPT\""
            done
            break
        fi
    # Parse current opt
    while [ x"$OPT" != x"-" ] ; do
        case "$OPT" in
            # Handle --flag=value opts like this
            -u=* | --user=* )
                CLIparm_user="${OPT#*=}"
                #shift
                ;;
            -p=* | --password=* )
                CLIparm_password="${OPT#*=}"
                #shift
                ;;
            -m=* | --management=* )
                CLIparm_mgmt="${OPT#*=}"
                #shift
                ;;
            -d=* | --domain=* )
                CLIparm_domain="${OPT#*=}"
                #shift
                ;;
            -s=* | --session-file=* )
                CLIparm_sessionidfile="${OPT#*=}"
                #shift
                ;;
            -o=* | --output=* )
                CLIparm_outputpath="${OPT#*=}"
                #shift
                ;;
            -i=* | --import-path=* )
                CLIparm_importpath="${OPT#*=}"
                #shift
                ;;
            -k=* | --delete-path=* )
                CLIparm_deletepath="${OPT#*=}"
                #shift
                ;;
            # and --flag value opts like this
            -u* | --user )
                CLIparm_user="$2"
                shift
                ;;
            -p* | --password )
                CLIparm_password="$2"
                shift
                ;;
            -m* | --management )
                CLIparm_mgmt="$2"
                shift
                ;;
            -d* | --domain )
                CLIparm_domain="$2"
                shift
                ;;
            -s* | --session-file )
                CLIparm_sessionidfile="$2"
                shift
                ;;
            -o* | --output )
                CLIparm_outputpath="$2"
                shift
                ;;
            -i* | --import-path )
                CLIparm_importpath="$2"
                shift
                ;;
            -k* | --delete-path )
                CLIparm_deletepath="$2"
                shift
                ;;
            -r* | --root )
                CLIparm_rootuser=true
                ;;
#           -f* | --force )
#               FORCE=true
#               ;;
            # Help and Standard Operations
            '-?' | --help )
                SHOWHELP=true
                ;;
            # Anything unknown is recorded for later
            * )
                REMAINS="$REMAINS \"$OPT\""
                break
                ;;
        esac
        # Check for multiple short options
        # NOTICE: be sure to update this pattern to match valid options
        NEXTOPT="${OPT#-[upmdsor?]}" # try removing single short opt
        if [ x"$OPT" != x"$NEXTOPT" ] ; then
            OPT="-$NEXTOPT"  # multiple short opts, keep going
        else
            break  # long form, exit inner loop
        fi
    done
    # Done with that param. move to next
    shift
done
# Set the non-parameters back into the positional parameters ($1 $2 ..)
eval set -- $REMAINS

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#
# Testing - Dump aquired values
#
#echo -e "After: \n CLIparm_rootuser='$CLIparm_rootuser' \n CLIparm_user='$CLIparm_user' \n CLIparm_password='$CLIparm_password' \n CLIparm_mgmt='$CLIparm_mgmt' \n CLIparm_domain='$CLIparm_domain' \n CLIparm_sessionidfile='$CLIparm_sessionidfile' \n CLIparm_outputpath='$CLIparm_outputpath' \n CLIparm_importpath='$CLIparm_importpath' \n CLIparm_deletepath='$CLIparm_deletepath' \n SHOWHELP='$SHOWHELP' \n remains='$REMAINS'"
#for i ; do echo - $i ; done


# -------------------------------------------------------------------------------------------------
# Handle request for help and exit
# -------------------------------------------------------------------------------------------------

#
# Was help requested, if so show it and exit
#
if [ x"$SHOWHELP" = x"true" ] ; then
    # Show Help
    doshowhelp
    exit
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Command Line Parameter Handling and Help
# =================================================================================================


# =================================================================================================
# Setup Standard Parameters
# =================================================================================================


#points to where jq is installed
#Apparently MDM, MDS, and Domains don't agree on who sets CPDIR, so better to check!
#export JQ=${CPDIR}/jq/jq
if [ -r ${CPDIR}/jq/jq ] 
then
    export JQ=${CPDIR}/jq/jq
elif [ -r /opt/CPshrd-R80/jq/jq ]
then
    export JQ=/opt/CPshrd-R80/jq/jq
else
    echo "Missing jq, not found in ${CPDIR}/jq/jq or /opt/CPshrd-R80/jq/jq"
    exit 1
fi


export DATE=`date +%Y-%m-%d-%H%M%Z`

echo 'Date Time Group   :  '$DATE
echo

# =================================================================================================
# START:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================


if [ x"$CLIparm_user" != x"" ] ; then
    export APICLIadmin=$CLIparm_user
else
    export APICLIadmin=administrator
fi

if [ x"$CLIparm_sessionidfile" != x"" ] ; then
    export APICLIsessionfile=$CLIparm_sessionidfile
else
    export APICLIsessionfile=id.txt
fi


#
# Testing - Dump aquired values
#
#echo 'APICLIadmin       :  '$APICLIadmin
#echo 'APICLIsessionfile :  '$APICLIsessionfile
#echo

loginstring=

if [ x"$CLIparm_rootuser" = x"true" ] ; then
    loginstring="--root true "
else
    if [ x"$APICLIadmin" != x"" ] ; then
        loginstring="user $APICLIadmin "
    else
        loginstring=$loginstring
    fi
    
    if [ x"$CLIparm_password" != x"" ] ; then
        loginstring=$loginstring"-p \"$CLIparm_password\" "
    else
        loginstring=$loginstring
    fi
fi

if [ x"$CLIparm_mgmt" != x"" ] ; then
    loginstring=$loginstring"-m \"$CLIparm_mgmt\" "
else
    loginstring=$loginstring
fi

if [ x"$CLIparm_domain" != x"" ] ; then
    loginstring=$loginstring"-d \"$CLIparm_domain\" "
else
    loginstring=$loginstring
fi

#if [ x"$CLIparm_password" = x"" ] ; then
#    mgmt_cli login user $APICLIadmin > $APICLIsessionfile
#else
#    mgmt_cli login user $APICLIadmin -p "$CLIparm_password" > $APICLIsessionfile
#fi

echo
echo 'mgmt_cli Login!'
echo
echo 'Login to mgmt_cli as '$APICLIadmin' and save to session file :  '$APICLIsessionfile
echo
#mgmt_cli login user $APICLIadmin > $APICLIsessionfile

#
# Testing - Dump login string bullt from parameters
#
#echo "Execute login with "\'$loginstring\'
#echo

mgmt_cli login $loginstring > $APICLIsessionfile
if [ $? != 0 ] ; then
    
    echo
    echo
    echo "mgmt_cli login error!"
    echo "Terminating script..."
    echo
    exit 255

else
    
    echo
    cat $APICLIsessionfile
    echo
    
fi


# =================================================================================================
# END:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================


# =================================================================================================
# START:  Main operations - 
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations
# -------------------------------------------------------------------------------------------------

if [ x"$CLIparm_outputpath" != x"" ] ; then
    export APICLIpathroot=$CLIparm_outputpath
else
    export APICLIpathroot=./dump
fi

export APICLIpathbase=$APICLIpathroot/$DATE

if [ ! -r $APICLIpathroot ] 
then
    mkdir $APICLIpathroot
fi
if [ ! -r $APICLIpathbase ] 
then
    mkdir $APICLIpathbase
fi
if [ ! -r $APICLIpathbase/csv ] 
then
    mkdir $APICLIpathbase/csv
fi
#if [ ! -r $APICLIpathbase/full ] 
#then
#    mkdir $APICLIpathbase/full
#fi
#if [ ! -r $APICLIpathbase/standard ] 
#then
#    mkdir $APICLIpathbase/standard
#fi
#if [ ! -r $APICLIpathbase/import ] 
#then
#    mkdir $APICLIpathbase/import
#fi
#if [ ! -r $APICLIpathbase/delete ] 
#then
#    mkdir $APICLIpathbase/delete
#fi

export APICLIfileoutputpre=dump_
export APICLIfileoutputext=json
export APICLIfileoutputsufix=$DATE'.'$APICLIfileoutputext
export APICLICSVfileoutputext=csv
export APICLICSVfileoutputsufix='.'$APICLICSVfileoutputext

export APICLIObjectLimit=500

# -------------------------------------------------------------------------------------------------
# Start executing Main operations
# -------------------------------------------------------------------------------------------------

#export APICLIdetaillvl=standard

export APICLIdetaillvl=full

echo
echo $APICLIdetaillvl' - Dump to CSV Starting!'
echo

#export APICLIpathoutput=$APICLIpathbase/$APICLIdetaillvl
export APICLIpathoutput=$APICLIpathbase/csv
#export APICLIpathoutput=$APICLIpathbase/import
#export APICLIpathoutput=$APICLIpathbase/delete
export APICLIfileoutputpost='_'$APICLIdetaillvl'_'$APICLIfileoutputsufix
export APICLICSVheaderfilesuffix=header

echo
echo 'Dump "'$APICLIdetaillvl'" details to path:  '$APICLIpathoutput
echo


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - ExportObjectsToCSVviaJQ
# -------------------------------------------------------------------------------------------------

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
    
    export APICLICSVfile=$APICLIpathoutput/$APICLIobjecttype'_'$APICLIdetaillvl'_csv'$APICLICSVfileoutputsufix
    export APICLICSVfileheader=$APICLICSVfile.$APICLICSVheaderfilesuffix
    
    if [ -r $APICLICSVfile ] 
    then
        rm $APICLICSVfile
    fi
    if [ -r $APICLICSVfileheader ] 
    then
        rm $APICLICSVfileheader
    fi
    
    echo
    echo "Creat $APICLIobjecttype CSV File : $APICLICSVfile"
    echo
    
    #
    # Troubleshooting output
    #
    #echo '$CSVFileHeader' - $CSVFileHeader
    #echo
    
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

    echo
    echo "Sort data and build CSV output file"
    echo
    
    cat $APICLICSVfileheader > $APICLICSVfile.original
    cat $APICLICSVfile.data >> $APICLICSVfile.original
    
    sort $APICLICSVsortparms $APICLICSVfile.data > $APICLICSVfile.sort
    
    cat $APICLICSVfileheader > $APICLICSVfile
    cat $APICLICSVfile.sort >> $APICLICSVfile
    
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

# The ExportObjectsToCSVviaJQ is the meat of the script's repeated actions.
#
# For this script the $APICLIobjecttype item's name is exported to a CSV file and sorted.
# The original exported data and raw sorted data are retained in separate files, as is the header
# for the CSV file generated.

ExportObjectsToCSVviaJQ () {
    #
    
    SetupExportObjectsToCSVviaJQ
    
    #
    # Troubleshooting output
    #
    #echo '$CSVJQparms' - $CSVJQparms
    #echo
    
    mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile | $JQ '.objects[] | [ '"$CSVJQparms"' ] | @csv' -r >> $APICLICSVfile.data
    
    echo
    
    FinalizeExportObjectsToCSVviaJQ
    
    echo
    return 0
    
    #
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# hosts
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=hosts
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

#echo '"name","color","comments","ipv4-address","ipv6-address","nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.ipv4-address","nat-settings.ipv6-address","nat-settings.method"' > $APICLICSVfile

#mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile | $JQ '.objects[] | [ .["name"], .["color"], .["comments"], .["ipv4-address"], .["ipv6-address"], .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"], .["nat-settings"]["ipv4-address"], .["nat-settings"]["ipv6-address"], .["nat-settings"]["method"] ] | @csv' -r >> $APICLICSVfile.data
    
ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# no more objects
# -------------------------------------------------------------------------------------------------

echo
echo $APICLIdetaillvl' CSV dump - Completed!'
echo

echo
echo


# -------------------------------------------------------------------------------------------------
# Finished with exporting
# -------------------------------------------------------------------------------------------------

echo
echo 'Dumps Completed!'
echo


# =================================================================================================
# END:  Main operations - 
# =================================================================================================


# =================================================================================================
# START:  Publish, Cleanup, and Dump output
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Publish Changes
# -------------------------------------------------------------------------------------------------

#echo
#echo 'Publish changes!'
#echo
#mgmt_cli publish -s $APICLIsessionfile

# -------------------------------------------------------------------------------------------------
# Logout from mgmt_cli, also cleanup session file
# -------------------------------------------------------------------------------------------------

echo
echo 'Logout of mgmt_cli!'
echo
mgmt_cli logout -s $APICLIsessionfile
rm $APICLIsessionfile

# -------------------------------------------------------------------------------------------------
# Clean-up and exit
# -------------------------------------------------------------------------------------------------

echo 'CLI Operations Completed'

echo
ls -alh $APICLIpathroot
echo
echo
ls -alhR $APICLIpathroot/$DATE
echo


# =================================================================================================
# END:  Publish, Cleanup, and Dump output
# =================================================================================================


