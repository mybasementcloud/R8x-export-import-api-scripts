#!/bin/bash
#
# SCRIPT Object delete using object-names csv files for API CLI Operations
#
ScriptVersion=00.22.00
ScriptDate=2017-07-20

#

export APIScriptVersion=v00x22x00
ScriptName=cli_api_delete_objects_using_csv_$APIScriptVersion

if [ x"$APISCRIPTVERBOSE" = x"" ] ; then
    # Verbose mode not set from shell level
    echo
elif [ x"$APISCRIPTVERBOSE" = x"FALSE" ] ; then
    # Verbose mode set OFF from shell level
    echo
else
    echo
    echo 'Script :  '$0
    echo 'Verbose mode set'
    echo
fi

# -------------------------------------------------------------------------------------------------
# Root script declarations
# -------------------------------------------------------------------------------------------------

#export APIScriptSubFilePrefix=cli_api_export_objects
#export APIScriptSubFile=$APIScriptSubFilePrefix'_actions_'$APIScriptVersion.sh
#export APIScriptCSVSubFile=$APIScriptSubFilePrefix'_actions_to_csv_'$APIScriptVersion.sh

# =================================================================================================
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
# -v | --verbose
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
    echo '  Verbose mode               -v | --verbose'
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
    echo ' Example: Export:'
    echo
    echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -o "/var/tmp/script_dump.txt"'
    echo
    echo ' Example: Import:'
    echo
    echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -o "/var/tmp/script_dump.txt" -i "/var/tmp/import/"'
    echo
    echo ' Example: Delete:'
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
if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
    echo
    echo "CLI Parameters Before"
    for i ; do echo - $i ; done
    echo CLI parms - number "$#" parms "$@"
    echo
fi


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
            # Help and Standard Operations
            '-?' | --help )
                SHOWHELP=true
                ;;
            '-v' | --verbose )
                export APISCRIPTVERBOSE=TRUE
                ;;
            # Handle immediate opts like this
            -r | --root )
                CLIparm_rootuser=true
                ;;
#           -f | --force )
#               FORCE=true
#               ;;
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
            # Anything unknown is recorded for later
            * )
                REMAINS="$REMAINS \"$OPT\""
                break
                ;;
        esac
        # Check for multiple short options
        # NOTICE: be sure to update this pattern to match valid options
        # Remove any characters matching "-", and then the values between []'s
        #NEXTOPT="${OPT#-[upmdsor?]}" # try removing single short opt
        NEXTOPT="${OPT#-[vrf?]}" # try removing single short opt
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
if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
    # Verbose mode ON
    
    #echo -e "After: \n CLIparm_rootuser='$CLIparm_rootuser' \n CLIparm_user='$CLIparm_user' \n CLIparm_password='$CLIparm_password' \n CLIparm_mgmt='$CLIparm_mgmt' \n CLIparm_domain='$CLIparm_domain' \n CLIparm_sessionidfile='$CLIparm_sessionidfile' \n CLIparm_outputpath='$CLIparm_outputpath' \n CLIparm_importpath='$CLIparm_importpath' \n CLIparm_deletepath='$CLIparm_deletepath' \n CLIparm_csvpath='$CLIparm_csvpath' \n SHOWHELP='$SHOWHELP' \n remains='$REMAINS'"
    
    export outstring=
    export outstring=$outstring"After: \n "
    export outstring=$outstring"CLIparm_rootuser='$CLIparm_rootuser' \n "
    export outstring=$outstring"CLIparm_user='$CLIparm_user' \n "
    export outstring=$outstring"CLIparm_password='$CLIparm_password' \n "
    export outstring=$outstring"CLIparm_mgmt='$CLIparm_mgmt' \n "
    export outstring=$outstring"CLIparm_domain='$CLIparm_domain' \n "
    export outstring=$outstring"CLIparm_sessionidfile='$CLIparm_sessionidfile' \n "
    export outstring=$outstring"CLIparm_outputpath='$CLIparm_outputpath' \n "
    export outstring=$outstring"CLIparm_importpath='$CLIparm_importpath' \n "
    export outstring=$outstring"CLIparm_deletepath='$CLIparm_deletepath' \n "
    export outstring=$outstring"CLIparm_csvpath='$CLIparm_csvpath' \n "
    export outstring=$outstring"SHOWHELP='$SHOWHELP' \n "
    export outstring=$outstring"APISCRIPTVERBOSE='$APISCRIPTVERBOSE' \n "
    export outstring=$outstring"remains='$REMAINS'"
    
    echo
    echo -e $outstring
    echo
    for i ; do echo - $i ; done
    echo
    
fi

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


# =================================================================================================
# =================================================================================================
# START:  Setup Standard Parameters
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
# END:  Setup Standard Parameters
# =================================================================================================
# =================================================================================================


# =================================================================================================
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
echo 'APICLIadmin       :  '$APICLIadmin
echo 'APICLIsessionfile :  '$APICLIsessionfile
echo

loginstring=
mgmttarget=
domaintarget=

if [ x"$CLIparm_rootuser" = x"true" ] ; then
#   Handle Root User
    loginstring="--root true "
else
#   Handle admin user parameter
    if [ x"$APICLIadmin" != x"" ] ; then
        loginstring="user $APICLIadmin"
    else
        loginstring=$loginstring
    fi
    
#   Handle password parameter
    if [ x"$CLIparm_password" != x"" ] ; then
        if [ x"$loginstring" != x"" ] ; then
            loginstring=$loginstring" password \"$CLIparm_password\""
        else
            loginstring="password \"$CLIparm_password\""
        fi
    else
        loginstring=$loginstring
    fi
fi

if [ x"$CLIparm_domain" != x"" ] ; then
#   Handle domain parameter for login string
    if [ x"$loginstring" != x"" ] ; then
        loginstring=$loginstring" domain \"$CLIparm_domain\""
    else
        loginstring="loginstring \"$CLIparm_domain\""
    fi
else
    loginstring=$loginstring
fi

#   Handle management server parameter for mgmt_cli parms
if [ x"$CLIparm_mgmt" != x"" ] ; then
    if [ x"$mgmttarget" != x"" ] ; then
        mgmttarget=$mgmttarget" -m \"$CLIparm_mgmt\""
    else
        mgmttarget="-m \"$CLIparm_mgmt\""
    fi
else
    mgmttarget=$mgmttarget
fi

#   Handle domain parameter for mgmt_cli parms
if [ x"$CLIparm_domain" != x"" ] ; then
    if [ x"$domaintarget" != x"" ] ; then
        domaintarget=$domaintarget" -d \"$CLIparm_domain\""
    else
        domaintarget="-d \"$CLIparm_domain\""
    fi
else
    domaintarget=$domaintarget
fi

echo
echo 'mgmt_cli Login!'
echo
echo 'Login to mgmt_cli as '$APICLIadmin' and save to session file :  '$APICLIsessionfile
echo

#
# Testing - Dump login string bullt from parameters
#
if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
    echo 'Execute login with loginstring '\"$loginstring\"
    echo 'Execute operations with domaintarget '\"$domaintarget\"
    echo 'Execute operations with mgmttarget '\"$mgmttarget\"
    echo
fi

# Until we know when to use the -d parameter for domains with mgmt_cli, only use the domain in login
#
#if [ x"$domaintarget" = x"" ] ; then
#    if [ x"$mgmttarget" = x"" ] ; then
#        mgmt_cli login $loginstring > $APICLIsessionfile
#    else
#        mgmt_cli login $loginstring $mgmttarget > $APICLIsessionfile
#    fi
#else
#    if [ x"$mgmttarget" = x"" ] ; then
#        mgmt_cli login $loginstring $domaintarget > $APICLIsessionfile
#    else
#        mgmt_cli login $loginstring $domaintarget $mgmttarget > $APICLIsessionfile
#    fi
#fi
if [ x"$mgmttarget" = x"" ] ; then
    mgmt_cli login $loginstring > $APICLIsessionfile
else
    mgmt_cli login $loginstring $mgmttarget > $APICLIsessionfile
fi
if [ $? != 0 ] ; then
    
    echo
    echo
    echo "mgmt_cli login error!"
    echo "Terminating script..."
    echo
    exit 255

else
    
    echo "mgmt_cli login success!"
    echo
    cat $APICLIsessionfile
    echo
    
fi


# =================================================================================================
# END:  Setup Login Parameters and Login to Mgmt_CLI
# =================================================================================================
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
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

#if [ x"$CLIparm_importpath" != x"" ] ; then
#    export APICLICSVImportpathbase=$CLIparm_importpath
#else
#    export APICLICSVImportpathbase=./import.csv
#fi

if [ x"$CLIparm_deletepath" != x"" ] ; then
    export APICLICSVDeletepathbase=$CLIparm_deletepath
else
    export APICLICSVDeletepathbase=./delete.csv
fi

export APICLIpathbase=$APICLIpathroot/$DATE

if [ ! -r $APICLIpathroot ] ; then
    mkdir $APICLIpathroot
fi
if [ ! -r $APICLIpathbase ] ; then
    mkdir $APICLIpathbase
fi
#if [ ! -r $APICLIpathbase/csv ] ; then
#    mkdir $APICLIpathbase/csv
#fi
#if [ ! -r $APICLIpathbase/full ] ; then
#    mkdir $APICLIpathbase/full
#fi
#if [ ! -r $APICLIpathbase/standard ] ; then
#    mkdir $APICLIpathbase/standard
#fi
#if [ ! -r $APICLIpathbase/import ] ; then
#    mkdir $APICLIpathbase/import
#fi
if [ ! -r $APICLIpathbase/delete ] ; then
    mkdir $APICLIpathbase/delete
fi


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations
# -------------------------------------------------------------------------------------------------


export APICLIfileoutputpre=dump_
export APICLIfileoutputext=json
export APICLIfileoutputsufix=$DATE'.'$APICLIfileoutputext
export APICLICSVfileoutputext=csv
export APICLICSVfileoutputsufix='.'$APICLICSVfileoutputext

export APICLIObjectLimit=500

# =================================================================================================
# START:  Export objects to csv
# =================================================================================================


#export APICLIdetaillvl=standard

export APICLIdetaillvl=name


# -------------------------------------------------------------------------------------------------
# Start executing Main operations
# -------------------------------------------------------------------------------------------------


echo
echo $APICLIdetaillvl' - Delete using CSV Starting!'
echo

#export APICLIpathoutput=$APICLIpathbase/$APICLIdetaillvl
#export APICLIpathoutput=$APICLIpathbase/csv
#export APICLIpathoutput=$APICLIpathbase/import
export APICLIpathoutput=$APICLIpathbase/delete
export APICLIfileoutputpost='_'$APICLIdetaillvl'_'$APICLIfileoutputsufix
#export APICLICSVheaderfilesuffix=header
#export APICLIpathoutputwip=$APICLIpathoutput/wip
#if [ ! -r $APICLIpathoutputwip ] 
#then
#    mkdir $APICLIpathoutputwip
#fi

echo
echo 'Dump "'$APICLIdetaillvl'" details to path:  '$APICLIpathoutput
echo


# -------------------------------------------------------------------------------------------------
# Main Operational repeated proceedure - DeleteSimpleObjects
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Operational repeated proceedure - Delete Simple Objects
# -------------------------------------------------------------------------------------------------

# The Operational repeated proceedure - Delete Simple Objects is the meat of the script's simple
# objects releated repeated actions.
#
# For this script the $APICLIobjecttype items are deleted.

DeleteSimpleObjects () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    
    export APICLIDeleteCSVfile=$APICLICSVDeletepathbase/$APICLICSVobjecttype'_'$APICLIdetaillvl'_csv'$APICLICSVfileoutputsufix
    export OutputPath=$APICLIpathoutput/$APICLIfileoutputpre'add_'$APICLIobjecttype'_'$APICLIfileoutputext
    
    if [ ! -r $APICLIDeleteCSVfile ] ; then
        # no CSV file for this type of object
        echo
        echo 'CSV file for object '$APICLIobjecttype' missing : '$APICLIDeleteCSVfile
        echo 'Skipping!'
        echo
        return 0
    fi

    echo
    echo "Delete $APICLIobjecttype using CSV File : $APICLIDeleteCSVfile and dump to $OutputPath"
    echo
    
    mgmt_cli delete $APICLIobjecttype --batch $APICLIDeleteCSVfile ignore-warnings true ignore-errors true --ignore-errors true --format json -s $APICLIsessionfile > $OutputPath

    echo
    tail $OutputPath
    echo
    echo

    echo
    echo 'Publish $APICLIobjecttype object changes!  This could take a while...'
    echo
    mgmt_cli publish -s $APICLIsessionfile
        
    echo
    echo "Done with Deleting $APICLIobjecttype using CSV File : $APICLIDeleteCSVfile"

    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo
    return 0
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# handle simple objects
# -------------------------------------------------------------------------------------------------

echo
echo $APICLIdetaillvl' CSV delete - simple objects - Delete using CSV starting!'
echo

# -------------------------------------------------------------------------------------------------
# group-with-exclusion objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=group-with-exclusion
export APICLICSVobjecttype=groups-with-exclusion

DeleteSimpleObjects


# -------------------------------------------------------------------------------------------------
# group objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=group
export APICLICSVobjecttype=groups

DeleteSimpleObjects


# -------------------------------------------------------------------------------------------------
# security-zones objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=security-zone
export APICLICSVobjecttype=security-zones

DeleteSimpleObjects


# -------------------------------------------------------------------------------------------------
# dns-domain objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=dns-domain
export APICLICSVobjecttype=dns-domains

DeleteSimpleObjects


# -------------------------------------------------------------------------------------------------
# address-range objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=address-range
export APICLICSVobjecttype=address-ranges

DeleteSimpleObjects


# -------------------------------------------------------------------------------------------------
# network objects
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=network
export APICLICSVobjecttype=networks

DeleteSimpleObjects


# -------------------------------------------------------------------------------------------------
# host objects
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=host
export APICLICSVobjecttype=hosts

DeleteSimpleObjects


# -------------------------------------------------------------------------------------------------
# no more simple objects
# -------------------------------------------------------------------------------------------------

echo
echo $APICLIdetaillvl' CSV delete - simple objects - Complete!'
echo

echo
echo $APICLIdetaillvl' CSV import - Completed!'
echo



# -------------------------------------------------------------------------------------------------
# no more objects
# -------------------------------------------------------------------------------------------------

echo
echo 'Delete Completed!'
echo


# =================================================================================================
# END:  Main operations - 
# =================================================================================================
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Publish, Cleanup, and Dump output
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Publish Changes
# -------------------------------------------------------------------------------------------------

echo
echo 'Publish changes!'
echo
mgmt_cli publish -s $APICLIsessionfile

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
# =================================================================================================


