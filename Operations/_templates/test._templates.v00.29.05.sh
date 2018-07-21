#!/bin/bash
#
# SCRIPT Base Template testing script for automated execution of standard tests
#
ScriptVersion=00.29.05
ScriptDate=2018-07-20

#

export APIScriptVersion=v00x29x05
ScriptName=test._templates.v$ScriptVersion

# =================================================================================================
# =================================================================================================
# START script
# =================================================================================================
# =================================================================================================

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START Configure root parameters
# -------------------------------------------------------------------------------------------------

export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`

export Testinglogfileroot=.
export Testinglogfilefolder=dump/testing/$DATE
export Testinglogfilename=Testing_log_$ScriptName.`date +%Y%m%d-%H%M%S%Z`.log

# -------------------------------------------------------------------------------------------------
# Root script declarations
# -------------------------------------------------------------------------------------------------

export Script2TestPath=.

export TestSSLport=443

# 2018-05-04 - script type - script testing 

export script_test_template="true"
export script_test_export_import="false"

export script_test_common="true"

# Wait time in seconds
export WAITTIME=15


# -------------------------------------------------------------------------------------------------
# END Configure root parameters
# -------------------------------------------------------------------------------------------------
# =================================================================================================

# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START common procedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SetupTestingLogFile - Setup log file for testing operation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTestingLogFile () {
    #
    # SetupTestingLogFile - Setup log file for testing operation
    #
    
    export Testinglogfilebase=$Testinglogfileroot/$Testinglogfilefolder
    export Testinglogfile=$Testinglogfilebase/$Testinglogfilename
    
    if [ ! -r $Testinglogfilebase ] ; then
        mkdir -p -v $Testinglogfilebase
    fi
    
    touch $Testinglogfile
    
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i $Testinglogfile
    echo | tee -a -i $Testinglogfile
    echo 'Script:  '$ScriptName'  Script Version: '$APIScriptVersion | tee -a -i $Testinglogfile
    echo | tee -a -i $Testinglogfile
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# FinishUpTesting - handle testing finish up operations and close out log file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FinishUpTesting () {
    #
    # handle testing finish up operations and close out log file
    #

    echo 'Testing Operations Completed' | tee -a -i $Testinglogfile
    
    if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
        # Verbose mode ON
    
        echo | tee -a -i $Testinglogfile
        #echo "Files in >$Testinglogfileroot<" | tee -a -i $Testinglogfile
        #ls -alh $Testinglogfileroot | tee -a -i $Testinglogfile
        #echo | tee -a -i $Testinglogfile
    
        echo "Files in >$Testinglogfilebase<" | tee -a -i $Testinglogfile
        ls -alhR $Testinglogfilebase | tee -a -i $Testinglogfile
        echo | tee -a -i $Testinglogfile
    fi
    
    echo | tee -a -i $Testinglogfile
    echo "Testing Results in directory $Testinglogfilebase" | tee -a -i $Testinglogfile
    echo "Log output in file $Testinglogfile" | tee -a -i $Testinglogfile
    echo | tee -a -i $Testinglogfile
    echo '-------------------------------------------------------------------------------------------------' | tee -a -i $Testinglogfile
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# DetermineGaiaVersionAndInstallType - Determine the version of Gaia and installation type
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

DetermineGaiaVersionAndInstallType () {
    #
    # DetermineGaiaVersionAndInstallType - Determine the version of Gaia and installation type
    #

    #----------------------------------------------------------------------------------------
    #----------------------------------------------------------------------------------------
    #
    # Gaia version and installation type identification
    #
    #----------------------------------------------------------------------------------------
    #----------------------------------------------------------------------------------------
    
    
    export gaiaversion=$(clish -c "show version product" | cut -d " " -f 6)
    echo 'Gaia Version : $gaiaversion = '$gaiaversion | tee -a -i $Testinglogfile
    echo | tee -a -i $Testinglogfile
    
    export Check4SMS=0
    export Check4EPM=0
    export Check4MDS=0
    export Check4GW=0
    
    workfile=/var/tmp/cpinfo_ver.`date +%Y%m%d-%H%M%S%Z`.txt
    cpinfo -y all > $workfile 2>&1 | tee -a -i $Testinglogfile
    Check4EP773003=`grep -c "Endpoint Security Management R77.30.03 " $workfile`
    Check4EP773002=`grep -c "Endpoint Security Management R77.30.02 " $workfile`
    Check4EP773001=`grep -c "Endpoint Security Management R77.30.01 " $workfile`
    Check4EP773000=`grep -c "Endpoint Security Management R77.30 " $workfile`
    Check4EP=`grep -c "Endpoint Security Management" $workfile`
    Check4SMS=`grep -c "Security Management Server" $workfile`
    rm -v $workfile | tee -a -i $Testinglogfile
    
    if [ "$MDSDIR" != '' ]; then
        Check4MDS=1
    else 
        Check4MDS=0
    fi
    
    if [ $Check4SMS -gt 0 ] && [ $Check4MDS -gt 0 ]; then
        echo "System is Multi-Domain Management Server!" | tee -a -i $Testinglogfile
        Check4GW=0
    elif [ $Check4SMS -gt 0 ] && [ $Check4MDS -eq 0 ]; then
        echo "System is Security Management Server!" | tee -a -i $Testinglogfile
        Check4SMS=1
        Check4GW=0
    else
        echo "System is a gateway!" | tee -a -i $Testinglogfile
        Check4GW=1
    fi
    echo
    
    if [ $Check4EP773000 -gt 0 ] && [ $Check4EP773003 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.03" | tee -a -i $Testinglogfile
        export gaiaversion=R77.30.03
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ] && [ $Check4EP773002 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.02" | tee -a -i $Testinglogfile
        export gaiaversion=R77.30.02
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ] && [ $Check4EP773001 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.01" | tee -a -i $Testinglogfile
        export gaiaversion=R77.30.01
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30" | tee -a -i $Testinglogfile
        export gaiaversion=R77.30
        Check4EPM=1
    else
        echo "Not Gaia Endpoint Security Server" | tee -a -i $Testinglogfile
        Check4EPM=0
    fi
    
    echo | tee -a -i $Testinglogfile
    echo 'Final $gaiaversion = '$gaiaversion | tee -a -i $Testinglogfile
    echo | tee -a -i $Testinglogfile
    
    if [ $Check4MDS -eq 1 ]; then
    	echo 'Multi-Domain Management stuff...' | tee -a -i $Testinglogfile
    fi
    
    if [ $Check4SMS -eq 1 ]; then
    	echo 'Security Management Server stuff...' | tee -a -i $Testinglogfile
    fi
    
    if [ $Check4EPM -eq 1 ]; then
    	echo 'Endpoint Security Management Server stuff...' | tee -a -i $Testinglogfile
    fi
    
    if [ $Check4GW -eq 1 ]; then
    	echo 'Gateway stuff...' | tee -a -i $Testinglogfile
    fi
    
    echo | tee -a -i $Testinglogfile
    export gaia_kernel_version=$(uname -r)
    if [ "$gaia_kernel_version" == "2.6.18-92cpx86_64" ]; then
        echo "OLD Kernel version $gaia_kernel_version" | tee -a -i $Testinglogfile
    elif [ "$gaia_kernel_version" == "3.10.0-514cpx86_64" ]; then
        echo "NEW Kernel version $gaia_kernel_version" | tee -a -i $Testinglogfile
    elif [ "$gaia_kernel_version" == "3.10.0-693cpx86_64" ]; then
        echo "NEW Kernel version $gaia_kernel_version" | tee -a -i $Testinglogfile
    else
        echo "Kernel version $gaia_kernel_version" | tee -a -i $Testinglogfile
    fi
    echo | tee -a -i $Testinglogfile
    
    # Alternative approach from Health Check
    
    sys_type="N/A"
    sys_type_MDS=false
    sys_type_SMS=false
    sys_type_SmartEvent=false
    sys_type_GW=false
    sys_type_STANDALONE=false
    sys_type_VSX=false
    
    #  System Type
    if [[ $(echo $MDSDIR | grep mds) ]]; then
        sys_type_MDS=true
        sys_type_SMS=false
        sys_type="MDS"
    elif [[ $($CPDIR/bin/cpprod_util FwIsFirewallMgmt 2> /dev/null) == *"1"*  ]]; then
        sys_type_SMS=true
        sys_type_MDS=false
        sys_type="SMS"
    else
        sys_type_SMS=false
        sys_type_MDS=false
    fi
    
    # Updated to correctly identify if SmartEvent is active
    # $CPDIR/bin/cpprod_util RtIsRt -> returns wrong result for MDM
    # $CPDIR/bin/cpprod_util RtIsAnalyzerServer -> returns correct result for MDM
    
    if [[ $($CPDIR/bin/cpprod_util RtIsAnalyzerServer 2> /dev/null) == *"1"*  ]]; then
        sys_type_SmartEvent=true
        sys_type="SmartEvent"
    else
        sys_type_SmartEvent=false
    fi
    
    if [[ $($CPDIR/bin/cpprod_util FwIsVSX 2> /dev/null) == *"1"* ]]; then
    	sys_type_VSX=true
    	sys_type="VSX"
    else
    	sys_type_VSX=false
    fi
    
    if [[ $($CPDIR/bin/cpprod_util FwIsStandAlone 2> /dev/null) == *"1"* ]]; then
        sys_type_STANDALONE=true
        sys_type="STANDALONE"
    else
        sys_type_STANDALONE=false
    fi
    
    if [[ $($CPDIR/bin/cpprod_util FwIsFirewallModule 2> /dev/null) == *"1"*  ]]; then
        sys_type_GW=true
        sys_type="GATEWAY"
    else
        sys_type_GW=false
    fi
    
    echo "sys_type = "$sys_type | tee -a -i $Testinglogfile
    echo | tee -a -i $Testinglogfile
    echo "System Type : SMS        :"$sys_type_SMS | tee -a -i $Testinglogfile
    echo "System Type : MDS        :"$sys_type_MDS | tee -a -i $Testinglogfile
    echo "System Type : SmartEvent :"$sys_type_SmartEvent | tee -a -i $Testinglogfile
    echo "System Type : GATEWAY    :"$sys_type_GW | tee -a -i $Testinglogfile
    echo "System Type : STANDALONE :"$sys_type_STANDALONE | tee -a -i $Testinglogfile
    echo "System Type : VSX        :"$sys_type_VSX | tee -a -i $Testinglogfile
    echo | tee -a -i $Testinglogfile
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# END common procedures
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START testing procedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ResetExternalParameters - Reset Externally controllable parameters
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ResetExternalParameters () {
    #
    # Reset Externally controllable parameters
    #

    export APISCRIPTVERBOSE=
    export NOWAIT=
    export CLEANUPWIP=
    export NODOMAINFOLDERS=
    export CSVEXPORTADDIGNOREERR=

}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04


# -------------------------------------------------------------------------------------------------
# HandleScriptTesting_CLIParms - repeated proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-03-2 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#


#
# Standard R8X API Scripts Command Line Parameters
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
# -o <output_path> | --output <output_path> | -o=<output_path> | --output=<output_path> 
#
# -x <export_path> | --export <export_path> | -x=<export_path> | --export=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path>'
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path>'
#
# -c <csv_path> | --csv <csv_path> | -c=<csv_path> | --csv=<csv_path>'
#
# --NSO | --no-system-objects
# --SO | --system-objects
#
# --NOWAIT
#
# --CLEANUPWIP
# --NODOMAINFOLDERS
# --CSVEXPORTADDIGNOREERR
#

# MODIFIED 2018-05-04 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleScriptTesting_CLIParms () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #

    ResetExternalParameters

    . $Script2TestFilepath -?
    . $Script2TestFilepath --help


    if [ $Check4MDS -eq 1 ] ; then
        # MDM Tests
    	echo 'Multi-Domain Management stuff...' | tee -a -i $Testinglogfile

    elif [ $Check4SMS -eq 1 ] || [ $Check4EPM -eq 1 ] ; then
        # Just SMS Tests
    	echo 'Security Management Server stuff...' | tee -a -i $Testinglogfile
        if [ $Check4EPM -eq 1 ] ; then
            # EPM (not just SMS) Tests
        	echo 'Endpoint Security Management Server stuff...' | tee -a -i $Testinglogfile
        fi
        
        . $Script2TestFilepath --port $TestSSLport -r
        . $Script2TestFilepath --port $TestSSLport -v -r
        . $Script2TestFilepath --port $TestSSLport --verbose -r
        . $Script2TestFilepath --port $TestSSLport -v -u _apiadmin
        . $Script2TestFilepath --port $TestSSLport -v -u _apiadmin -p Cpwins1!
        
        ResetExternalParameters

        . $Script2TestFilepath --port $TestSSLport -v --NOWAIT -r
        . $Script2TestFilepath --port $TestSSLport -v --NOWAIT -u _apiadmin
        . $Script2TestFilepath --port $TestSSLport -v --NOWAIT -u _apiadmin -p Cpwins1!
        
        if [ x"$script_test_template" = x"true" ] ; then
            # testing templates, so work the full set of parameters

            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -r --CLEANUPWIP --NODOMAINFOLDERS --CSVEXPORTADDIGNOREERR
            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -r --CLEANUPWIP --NODOMAINFOLDERS --CSVEXPORTADDIGNOREERR --SO
            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -r --CLEANUPWIP --NODOMAINFOLDERS --CSVEXPORTADDIGNOREERR --NSO

            ResetExternalParameters

            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -r -l $Testinglogfilebase -o $Testinglogfilebase/output -x $Testinglogfilebase/export -i /var/tmp/import.csv -k /var/tmp/delete.csv

            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -r -l $Testinglogfilebase -c $Testinglogfilebase/example_csv.csv

            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -u _apiadmin -p Cpwins1! --CLEANUPWIP --NODOMAINFOLDERS --CSVEXPORTADDIGNOREERR
            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -u _apiadmin -p Cpwins1! --CLEANUPWIP --NODOMAINFOLDERS --CSVEXPORTADDIGNOREERR --SO

        fi

    elif [ $Check4GW -eq 1 ] ; then
        # GW Tests - when that has an API
    	echo 'Gateway stuff...' | tee -a -i $Testinglogfile

    else
        # and what is this????
        echo 'and what is this????' | tee -a -i $Testinglogfile

    fi
    
    if [ $Check4MDS -eq 1 ] ; then
        # More MDM Tests
    	echo 'More Multi-Domain Management stuff...' | tee -a -i $Testinglogfile

        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "System Data" -r
        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "System Data" -u _apiadmin
        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "System Data" -u _apiadmin -p Cpwins1!
        
        # This is a forced failure test
        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "GLOBAL" -r

        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "Global" -r
        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "Global" -u _apiadmin
        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "Global" -u _apiadmin -p Cpwins1!
        
        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "EXAMPLE-DEMO" -r
        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "EXAMPLE-DEMO" -u _apiadmin
        . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "EXAMPLE-DEMO" -u _apiadmin -p Cpwins1!
        
        if [ x"$script_test_template" = x"true" ] ; then
            # testing templates, so work the full set of parameters
            
            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "Global" -r -l $Testinglogfilebase -o $Testinglogfilebase/output -x $Testinglogfilebase/export -i /var/tmp/import.csv -k /var/tmp/delete.csv
            . $Script2TestFilepath -v --port $TestSSLport --NOWAIT -d "System Data" -r -l $Testinglogfilebase -o $Testinglogfilebase/output -x $Testinglogfilebase/export -i /var/tmp/import.csv -k /var/tmp/delete.csv
                
        fi

    fi
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END testing procedures
# -------------------------------------------------------------------------------------------------
# =================================================================================================

SetupTestingLogFile


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START testing
# -------------------------------------------------------------------------------------------------

DetermineGaiaVersionAndInstallType

export TestSSLport=$(clish -c "show web ssl-port" | cut -d " " -f 2)
echo 'Current Gaia web ssl-port : '$TestSSLport | tee -a -i $Testinglogfile


export Script2TestName=api_mgmt_cli_shell_template_with_cmd_line_parameters.template.v$ScriptVersion.sh

export Script2TestFilepath=$Script2TestPath/$Script2TestName

HandleScriptTesting_CLIParms "$@"


export Script2TestName=api_mgmt_cli_shell_template_with_cmd_line_parameters_script.template.v$ScriptVersion.sh

export Script2TestFilepath=$Script2TestPath/$Script2TestName

HandleScriptTesting_CLIParms "$@"

# -------------------------------------------------------------------------------------------------
# END testing
# -------------------------------------------------------------------------------------------------
# =================================================================================================


# =================================================================================================
# =================================================================================================
# END script
# =================================================================================================
# =================================================================================================

FinishUpTesting "$@"

# =================================================================================================
# =================================================================================================
# =================================================================================================
# =================================================================================================

