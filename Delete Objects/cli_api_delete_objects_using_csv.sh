#!/bin/bash
#
# SCRIPT Object delete using object-names csv files for API CLI Operations
#
ScriptVersion=00.24.00
ScriptDate=2017-08-03

#

export APIScriptVersion=v00x24x00
ScriptName=cli_api_delete_objects_using_csv

# ADDED 2017-07-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# =================================================================================================
# START script
# =================================================================================================


echo
echo 'Script:  '$ScriptName'  Script Version: '$APIScriptVersion

# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------

export minapiversionrequired=1.0

getapiversion=$(mgmt_cli show api-versions --format json -r true | $CPDIR/jq/jq '.["current-version"]' -r)
export checkapiversion=$getapiversion
if [ $checkapiversion = null ] ; then
    # show api-versions does not exist in version 1.0, so it fails and returns null
    currentapiversion=1.0
else
    currentapiversion=$checkapiversion
fi

echo 'API version = '$currentapiversion

if [ $(expr $minapiversionrequired '<=' $currentapiversion) ] ; then
    # API is sufficient version
    echo
else
    # API is not of a sufficient version to operate
    echo
    echo 'Current API Version ('$currentapiversion') does not meet minimum API version requirement ('$minapiversionrequired')'
    echo
    echo '! termination execution !'
    echo
    exit 250
fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-07-21

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

# ADDED 2017-07-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export script_use_publish="TRUE"

export script_use_export="TRUE"
export script_use_import="FALSE"
export script_use_delete="TRUE"

export script_dump_standard="FALSE"
export script_dump_full="FALSE"
export script_dump_csv="FALSE"

export script_use_csvfile="FALSE"

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-07-21
# ADDED 2017-08-03 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Wait time in seconds
export WAITTIME=15

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-08-03

#export APIScriptSubFilePrefix=cli_api_export_objects
#export APIScriptSubFile=$APIScriptSubFilePrefix'_actions_'$APIScriptVersion.sh
#export APIScriptCSVSubFile=$APIScriptSubFilePrefix'_actions_to_csv_'$APIScriptVersion.sh

# MODIFIED 2017-07-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# =================================================================================================
# =================================================================================================
# START:  Command Line Parameter Handling and Help
# =================================================================================================


# Code template for parsing command line parameters using only portable shell
# code, while handling both long and short params, handling '-f file' and
# '-f=file' style param data and also capturing non-parameters to be inserted
# back into the shell positional parameters.

SHOWHELP=false
CLIparm_websslport=443
CLIparm_rootuser=false
CLIparm_user=
CLIparm_password=
CLIparm_mgmt=
CLIparm_domain=
CLIparm_sessionidfile=
CLIparm_logpath=

CLIparm_exportpath=
CLIparm_importpath=
CLIparm_deletepath=

CLIparm_csvpath=

#
# Standard Command Line Parameters
#
# -? | --help
# -v | --verbose
# -P <web-ssl-port> | --port <web-ssl-port> | -P=<web-ssl-port> | --port=<web-ssl-port>
# -r | --root
# -u <admin_name> | --user <admin_name> | -u=<admin_name> | --user=<admin_name>
# -p <password> | --password <password> | -p=<password> | --password=<password>
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# -l <log_path> | --log-path <log_path> | -l=<log_path> | --log-path=<log_path>'
#
# -x <export_path> | --export <export_path> | -x=<export_path> | --export=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path>'
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path>'
#
# -c <csv_path> | --csv <csv_path> | -c=<csv_path> | --csv=<csv_path>'
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
    echo $0' [-?][-v]|[-r]|[-u <admin_name>] [-p <password>]]|[-P <web ssl port>] [-m <server_IP>] [-d <domain>] [-s <session_file_filepath>]|[-x <export_path>] [-i <import_path>] [-k <delete_path>] [-l <log_path>]'
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
    echo
    echo '  Set [web ssl] Port         -P <web-ssl-port> | --port <web-ssl-port> |'
    echo '                             -P=<web-ssl-port> | --port=<web-ssl-port>'
    echo '  Set Management Server IP   -m <server_IP> | --management <server_IP> |'
    echo '                             -m=<server_IP> | --management=<server_IP>'
    echo '  Set Management Domain      -d <domain> | --domain <domain> |'
    echo '                             -d=<domain> | --domain=<domain>'
    echo '  Set session file path      -s <session_file_filepath> |'
    echo '                             --session-file <session_file_filepath> |'
    echo '                             -s=<session_file_filepath> |'
    echo '                             --session-file=<session_file_filepath>'
    echo
    echo '  Set log file path          -l <log_path> | --log-path <log_path> |'
    echo '                             -l=<log_path> | --log-path=<log_path>'
    echo
    if [ x"$script_use_export" = x"TRUE" ] ; then
        echo '  Set export file path       -x <export_path> | --export <export_path> |'
        echo '                             -x=<export_path> | --export=<export_path>'
    fi
    if [ x"$script_use_import" = x"TRUE" ] ; then
        echo '  Set import file path       -i <import_path> | --import-path <import_path> |'
        echo '                             -i=<import_path> | --import-path=<import_path>'
    fi
    if [ x"$script_use_delete" = x"TRUE" ] ; then
        echo '  Set delete file path       -k <delete_path> | --delete-path <delete_path> |'
        echo '                             -k=<delete_path> | --delete-path=<delete_path>'
    fi
    if [ x"$script_use_csvfile" = x"TRUE" ] ; then
        echo '  Set csv file path          -c <csv_path> | --csv <csv_path |'
        echo '                             -c=<csv_path> | --csv=<csv_path>'
    fi
    echo
    echo '  session_file_filepath = fully qualified file path for session file'
    echo '  log_path = fully qualified folder path for log files'
    if [ x"$script_use_export" = x"TRUE" ] ; then
        echo '  export_path = fully qualified folder path for export file'
    fi
    if [ x"$script_use_import" = x"TRUE" ] ; then
        echo '  import_path = fully qualified folder path for import files'
    fi
    if [ x"$script_use_delete" = x"TRUE" ] ; then
        echo '  delete_path = fully qualified folder path for delete files'
    fi
    if [ x"$script_use_csvfile" = x"TRUE" ] ; then
        echo '  csv_path = fully qualified file path for csv file'
    fi
    echo
    echo ' NOTE:  Only use Management Server IP (-m) parameter if operating from a '
    echo '        different host than the management host itself.'
    echo

    echo ' Example: General :'
    echo
    echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump/"'
    echo

    if [ x"$script_use_export" = x"TRUE" ] ; then
        echo ' Example: Export:'
        echo
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump/" -x "/var/tmp/script_dump/export/"'
        echo
    fi

    if [ x"$script_use_import" = x"TRUE" ] ; then
        echo ' Example: Import:'
        echo
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump/" -x "/var/tmp/script_dump/export/" -i "/var/tmp/import/"'
        echo
    fi
    
    if [ x"$script_use_delete" = x"TRUE" ] ; then
        echo ' Example: Delete:'
        echo
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump/" -x "/var/tmp/script_dump/export/" -k "/var/tmp/delete/"'
        echo
    fi
    
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
            -P=* | --port=* )
                CLIparm_websslport="${OPT#*=}"
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
            -l=* | --log-path=* )
                CLIparm_logpath="${OPT#*=}"
                #shift
                ;;
            -x=* | --export=* )
                CLIparm_exportpath="${OPT#*=}"
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
            -c=* | --csv=* )
                CLIparm_csvpath="${OPT#*=}"
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
            -P* | --port )
                CLIparm_websslport="$2"
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
            -l* | --log-path )
                CLIparm_logpath="$2"
                shift
                ;;
            -x* | --export )
                CLIparm_exportpath="$2"
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
            -c* | --csv )
                CLIparm_csvpath="$2"
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
    
    export outstring=
    export outstring=$outstring"After: \n "
    export outstring=$outstring"CLIparm_rootuser='$CLIparm_rootuser' \n "
    export outstring=$outstring"CLIparm_user='$CLIparm_user' \n "
    export outstring=$outstring"CLIparm_password='$CLIparm_password' \n "

    export outstring=$outstring"CLIparm_websslport='$CLIparm_websslport' \n "
    export outstring=$outstring"CLIparm_mgmt='$CLIparm_mgmt' \n "
    export outstring=$outstring"CLIparm_domain='$CLIparm_domain' \n "
    export outstring=$outstring"CLIparm_sessionidfile='$CLIparm_sessionidfile' \n "
    export outstring=$outstring"CLIparm_logpath='$CLIparm_logpath' \n "

    if [ x"$script_use_export" = x"TRUE" ] ; then
        export outstring=$outstring"CLIparm_exportpath='$CLIparm_exportpath' \n "
    fi
    if [ x"$script_use_import" = x"TRUE" ] ; then
        export outstring=$outstring"CLIparm_importpath='$CLIparm_importpath' \n "
    fi
    if [ x"$script_use_delete" = x"TRUE" ] ; then
        export outstring=$outstring"CLIparm_deletepath='$CLIparm_deletepath' \n "
    fi
    if [ x"$script_use_csvfile" = x"TRUE" ] ; then
        export outstring=$outstring"CLIparm_csvpath='$CLIparm_csvpath' \n "
    fi
    
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

#
# -------------------------------------------------------------------------------- MODIFIED 2017-06-05


# =================================================================================================
# =================================================================================================
# START:  Setup Standard Parameters
# =================================================================================================

# ADDED 2017-07-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export gaiaversion=$(clish -c "show version product" | cut -d " " -f 6)

if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
    echo 'Gaia Version : $gaiaversion = '$gaiaversion
    echo
fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/- ADDED 2017-07-21


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

if [ x"$APISCRIPTVERBOSE" = x"TRUE" ] ; then
    echo 'Date Time Group   :  '$DATE
    echo
fi

# =================================================================================================
# END:  Setup Standard Parameters
# =================================================================================================
# =================================================================================================


# MODIFIED 2017-07-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

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

if [ x"$CLIparm_websslport" != x"" ] ; then
#   Handle web ssl port parameter for login string
    if [ x"$loginstring" != x"" ] ; then
        loginstring=$loginstring" --port $CLIparm_websslport"
    else
        loginstring="--port $CLIparm_websslport"
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

if [ x"$mgmttarget" = x"" ] ; then
    mgmt_cli login $loginstring > $APICLIsessionfile
else
    mgmt_cli login $loginstring $mgmttarget > $APICLIsessionfile
fi
EXITCODE=$?
if [ "$EXITCODE" != "0" ] ; then
    
    echo
    echo "mgmt_cli login error!"
    echo
    cat $APICLIsessionfile
    echo
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

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-07-21
# MODIFIED 2017-07-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# =================================================================================================
# =================================================================================================
# START:  Setup CLI Parameters
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations - CLI
# -------------------------------------------------------------------------------------------------

if [ x"$CLIparm_logpath" != x"" ] ; then
    export APICLIlogpathroot=$CLIparm_logpath
else
    export APICLIlogpathroot=./dump
fi

export APICLIlogpathbase=$APICLIlogpathroot/$DATE

if [ ! -r $APICLIlogpathroot ] ; then
    mkdir $APICLIlogpathroot
fi
if [ ! -r $APICLIlogpathbase ] ; then
    mkdir $APICLIlogpathbase
fi

export APICLIlogfilepath=$APICLIlogpathbase/$ScriptName'_'$APIScriptVersion'_'$DATE.log

if [ x"$script_use_export" = x"TRUE" ] ; then
    if [ x"$CLIparm_exportpath" != x"" ] ; then
        export APICLIpathroot=$CLIparm_exportpath
    else
        export APICLIpathroot=./dump
    fi
  
    export APICLIpathbase=$APICLIpathroot/$DATE
    
    if [ ! -r $APICLIpathroot ] ; then
        mkdir $APICLIpathroot
    fi
    if [ ! -r $APICLIpathbase ] ; then
        mkdir $APICLIpathbase
    fi
fi

if [ x"$script_use_import" = x"TRUE" ] ; then
    if [ x"$CLIparm_importpath" != x"" ] ; then
        export APICLICSVImportpathbase=$CLIparm_importpath
    else
        export APICLICSVImportpathbase=./import.csv
    fi
    
    if [ ! -r $APICLIpathbase/import ] ; then
        mkdir $APICLIpathbase/import
    fi
fi

if [ x"$script_use_delete" = x"TRUE" ] ; then
    if [ x"$CLIparm_deletepath" != x"" ] ; then
        export APICLICSVDeletepathbase=$CLIparm_deletepath
    else
        export APICLICSVDeletepathbase=./delete.csv
    fi
    
    if [ ! -r $APICLIpathbase/delete ] ; then
        mkdir $APICLIpathbase/delete
    fi
fi

if [ x"$script_use_csvfile" = x"TRUE" ] ; then
    if [ x"$CLIparm_csvpath" != x"" ] ; then
        export APICLICSVcsvpath=$CLIparm_csvpath
    else
        export APICLICSVcsvpath=./domains.csv
    fi
    
fi

if [ x"$script_dump_csv" = x"TRUE" ] ; then
    if [ ! -r $APICLIpathbase/csv ] ; then
        mkdir $APICLIpathbase/csv
    fi
fi

if [ x"$script_dump_full" = x"TRUE" ] ; then
    if [ ! -r $APICLIpathbase/full ] ; then
        mkdir $APICLIpathbase/full
    fi
fi

if [ x"$script_dump_standard" = x"TRUE" ] ; then
    if [ ! -r $APICLIpathbase/standard ] ; then
        mkdir $APICLIpathbase/standard
    fi
fi

    
# =================================================================================================
# END:  Setup CLI Parameters
# =================================================================================================
# =================================================================================================

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-07-21

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# =================================================================================================
# START:  Main operations - 
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Set parameters for Main operations
# -------------------------------------------------------------------------------------------------


export APICLIfileexportpre=dump_
export APICLIfileexportext=json
export APICLIfileexportsufix=$DATE'.'$APICLIfileexportext
export APICLICSVfileexportext=csv
export APICLICSVfileexportsufix='.'$APICLICSVfileexportext

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

#export APICLIpathexport=$APICLIpathbase/$APICLIdetaillvl
#export APICLIpathexport=$APICLIpathbase/csv
#export APICLIpathexport=$APICLIpathbase/import
export APICLIpathexport=$APICLIpathbase/delete
export APICLIfileexportpost='_'$APICLIdetaillvl'_'$APICLIfileexportsufix
#export APICLICSVheaderfilesuffix=header
#export APICLIpathexportwip=$APICLIpathexport/wip
#if [ ! -r $APICLIpathexportwip ] 
#then
#    mkdir $APICLIpathexportwip
#fi

echo
echo 'Dump "'$APICLIdetaillvl'" details to path:  '$APICLIpathexport
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
    
    export APICLIDeleteCSVfile=$APICLICSVDeletepathbase/$APICLICSVobjecttype'_'$APICLIdetaillvl'_csv'$APICLICSVfileexportsufix
    export OutputPath=$APICLIpathexport/$APICLIfileexportpre'add_'$APICLIobjecttype'_'$APICLIfileexportext
    
    if [ ! -r $APICLIDeleteCSVfile ] ; then
        # no CSV file for this type of object
        echo
        echo 'CSV file for object '$APICLIobjecttype' missing : '$APICLIDeleteCSVfile
        echo 'Skipping!'
        echo
        return 0
    fi

    export MgmtCLI_Base_OpParms="--format json -s $APICLIsessionfile"
    export MgmtCLI_IgnoreErr_OpParms="ignore-warnings true ignore-errors true --ignore-errors true"
    export MgmtCLI_Delete_OpParms="details-level \"$APICLIdetaillvl\" $MgmtCLI_IgnoreErr_OpParms $MgmtCLI_Base_OpParms"
    
    echo
    echo "Delete $APICLIobjecttype using CSV File : $APICLIDeleteCSVfile"
    echo "  mgmt_cli parameters : $MgmtCLI_Delete_OpParms"
    echo "  and dump to $OutputPath"
    echo
    
    mgmt_cli delete $APICLIobjecttype --batch $APICLIDeleteCSVfile $MgmtCLI_Delete_OpParms > $OutputPath

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
# =================================================================================================
# START:  Publish, Cleanup, and Dump export
# =================================================================================================


# MODIFIED 2017-07-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# Publish Changes
# -------------------------------------------------------------------------------------------------


if [ x"$script_use_publish" = x"TRUE" ] ; then
    echo
    echo 'Publish changes!'
    echo
    mgmt_cli publish -s $APICLIsessionfile
    echo
else
    echo
    echo 'Nothing to Publish!'
    echo
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-07-21

# -------------------------------------------------------------------------------------------------
# Logout from mgmt_cli, also cleanup session file
# -------------------------------------------------------------------------------------------------

echo
echo 'Logout of mgmt_cli!  Then remove session file.'
echo
mgmt_cli logout -s $APICLIsessionfile

rm $APICLIsessionfile

# MODIFIED 2017-07-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# -------------------------------------------------------------------------------------------------
# Clean-up and exit
# -------------------------------------------------------------------------------------------------

echo 'CLI Operations Completed'

if [ "$APICLIlogpathbase" != "$APICLIpathroot" ] ; then
    echo
    ls -alh $APICLIlogpathbase
    echo
fi

echo
ls -alh $APICLIpathroot
echo
echo
ls -alhR $APICLIpathroot/$DATE
echo

echo "Log output in file $APICLIlogfilepath"
echo

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2017-07-21


# =================================================================================================
# END:  Publish, Cleanup, and Dump output
# =================================================================================================
# =================================================================================================


