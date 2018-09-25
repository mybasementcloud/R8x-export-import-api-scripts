#!/bin/bash
#
# SCRIPT Template for CLI Operations for command line parameters handling
#
ScriptVersion=00.30.00
ScriptDate=2018-09-21

#

export APIActionsScriptVersion=v00x30x00
ActionScriptName=identify_gaia_and_installation.action.common.005.v$ScriptVersion

# =================================================================================================
# Validate Actions Script version is correct for caller
# =================================================================================================


if [ x"$APIScriptVersion" = x"$APIActionsScriptVersion" ] ; then
    # Script and Actions Script versions match, go ahead
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Actions Scripts Version - OK' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Actions Scripts Version - Missmatch' | tee -a -i $APICLIlogfilepath
    echo 'Calling Script version : '$APIScriptVersion | tee -a -i $APICLIlogfilepath
    echo 'Actions Script version : '$APIActionsScriptVersion | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 250
fi


# =================================================================================================
# =================================================================================================
# START action script:  handle command line parameters
# =================================================================================================


echo | tee -a -i $APICLIlogfilepath
echo 'ActionScriptName:  '$ActionScriptName'  Script Version: '$APIActionsScriptVersion | tee -a -i $APICLIlogfilepath

# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# =================================================================================================
# START:  Determine version of server and type
# =================================================================================================

# =================================================================================================
# START:  Local Proceedures
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# Start :  Determine version of server and type
# -------------------------------------------------------------------------------------------------


IdentifyGaiaVersionAndInstallationType () {

    #
    # Identify Gaia Version And Installation Type
    #
    
    #----------------------------------------------------------------------------------------
    #----------------------------------------------------------------------------------------
    #
    # Gaia version and installation type identification
    #
    #----------------------------------------------------------------------------------------
    #----------------------------------------------------------------------------------------
    
    export gaiaversionoutputfile=/var/tmp/gaiaversion_$DATEDTGS.txt
    echo > $gaiaversionoutputfile
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    # START: Identify Gaia Version and Installation Type Details
    # -------------------------------------------------------------------------------------------------
    
    
    export gaiaversion=$(clish -c "show version product" | cut -d " " -f 6)
    echo 'Gaia Version : $gaiaversion = '$gaiaversion | tee -a -i $gaiaversionoutputfile
    echo | tee -a -i $gaiaversionoutputfile
    
    Check4SMS=0
    Check4EPM=0
    Check4MDS=0
    Check4GW=0
    
    workfile=/var/tmp/cpinfo_ver.txt
    cpinfo -y all > $workfile 2>&1
    Check4EP773003=`grep -c "Endpoint Security Management R77.30.03 " $workfile`
    Check4EP773002=`grep -c "Endpoint Security Management R77.30.02 " $workfile`
    Check4EP773001=`grep -c "Endpoint Security Management R77.30.01 " $workfile`
    Check4EP773000=`grep -c "Endpoint Security Management R77.30 " $workfile`
    Check4EP=`grep -c "Endpoint Security Management" $workfile`
    Check4SMS=`grep -c "Security Management Server" $workfile`
    Check4SMSR80x10=`grep -c "Security Management Server R80.10 " $workfile`
    Check4SMSR80x20=`grep -c "Security Management Server R80.20 " $workfile`
    Check4SMSR80x20xM1=`grep -c "Security Management Server R80.20.M1 " $workfile`
    Check4SMSR80x20xM2=`grep -c "Security Management Server R80.20.M2 " $workfile`
    rm $workfile
    
    if [ "$MDSDIR" != '' ]; then
        Check4MDS=1
    else 
        Check4MDS=0
    fi
    
    if [ $Check4SMS -gt 0 ] && [ $Check4MDS -gt 0 ]; then
        echo "System is Multi-Domain Management Server!" | tee -a -i $gaiaversionoutputfile
        Check4GW=0
    elif [ $Check4SMS -gt 0 ] && [ $Check4MDS -eq 0 ]; then
        echo "System is Security Management Server!" | tee -a -i $gaiaversionoutputfile
        Check4SMS=1
        Check4GW=0
    else
        echo "System is a gateway!" | tee -a -i $gaiaversionoutputfile
        Check4GW=1
    fi
    echo
    
    if [ $Check4SMSR80x10 -gt 0 ]; then
        echo "Security Management Server version R80.10" | tee -a -i $gaiaversionoutputfile
        export gaiaversion=R80.10
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
            echo "Endpoint Security Server version R80.10" | tee -a -i $gaiaversionoutputfile
        else
        	Check4EPM=0
        fi
    elif [ $Check4SMSR80x20 -gt 0 ]; then
        echo "Security Management Server version R80.20" | tee -a -i $gaiaversionoutputfile
        export gaiaversion=R80.20
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
            echo "Endpoint Security Server version R80.20" | tee -a -i $gaiaversionoutputfile
        else
        	Check4EPM=0
        fi
    elif [ $Check4SMSR80x20xM1 -gt 0 ]; then
        echo "Security Management Server version R80.20.M1" | tee -a -i $gaiaversionoutputfile
        export gaiaversion=R80.20.M1
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
            echo "Endpoint Security Server version R80.20.M1" | tee -a -i $gaiaversionoutputfile
        else
        	Check4EPM=0
        fi
    elif [ $Check4SMSR80x20xM2 -gt 0 ]; then
        echo "Security Management Server version R80.20.M2" | tee -a -i $gaiaversionoutputfile
        export gaiaversion=R80.20.M2
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
            echo "Endpoint Security Server version R80.20.M2" | tee -a -i $gaiaversionoutputfile
        else
        	Check4EPM=0
        fi
    elif [ $Check4EP773000 -gt 0 ] && [ $Check4EP773003 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.03" | tee -a -i $gaiaversionoutputfile
        export gaiaversion=R77.30.03
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ] && [ $Check4EP773002 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.02" | tee -a -i $gaiaversionoutputfile
        export gaiaversion=R77.30.02
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ] && [ $Check4EP773001 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.01" | tee -a -i $gaiaversionoutputfile
        export gaiaversion=R77.30.01
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30" | tee -a -i $gaiaversionoutputfile
        export gaiaversion=R77.30
        Check4EPM=1
    else
        echo "Not Gaia Endpoint Security Server R77.30" | tee -a -i $gaiaversionoutputfile
        
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
        else
        	Check4EPM=0
        fi
        
    fi
    
    echo | tee -a -i $gaiaversionoutputfile
    echo 'Final $gaiaversion = '$gaiaversion | tee -a -i $gaiaversionoutputfile
    echo | tee -a -i $gaiaversionoutputfile
    
    if [ $Check4MDS -eq 1 ]; then
    	echo 'Multi-Domain Management stuff...' | tee -a -i $gaiaversionoutputfile
    fi
    
    if [ $Check4SMS -eq 1 ]; then
    	echo 'Security Management Server stuff...' | tee -a -i $gaiaversionoutputfile
    fi
    
    if [ $Check4EPM -eq 1 ]; then
    	echo 'Endpoint Security Management Server stuff...' | tee -a -i $gaiaversionoutputfile
    fi
    
    if [ $Check4GW -eq 1 ]; then
    	echo 'Gateway stuff...' | tee -a -i $gaiaversionoutputfile
    fi
    
    #echo
    #export gaia_kernel_version=$(uname -r)
    #if [ "$gaia_kernel_version" == "2.6.18-92cpx86_64" ]; then
    #    echo "OLD Kernel version $gaia_kernel_version" | tee -a -i $gaiaversionoutputfile
    #elif [ "$gaia_kernel_version" == "3.10.0-514cpx86_64" ]; then
    #    echo "NEW Kernel version $gaia_kernel_version" | tee -a -i $gaiaversionoutputfile
    #else
    #    echo "Kernel version $gaia_kernel_version" | tee -a -i $gaiaversionoutputfile
    #fi
    #echo
    
    echo | tee -a -i $gaiaversionoutputfile
    export gaia_kernel_version=$(uname -r)
    export kernelv2x06=2.6
    export kernelv3x10=3.10
    export checkthiskernel=`echo "${gaia_kernel_version}" | grep -i "$kernelv2x06"`
    export isitoldkernel=`test -z $checkthiskernel; echo $?`
    export checkthiskernel=`echo "${gaia_kernel_version}" | grep -i "$kernelv3x10"`
    export isitnewkernel=`test -z $checkthiskernel; echo $?`
    
    if [ $isitoldkernel -eq 1 ] ; then
        echo "OLD Kernel version $gaia_kernel_version" | tee -a -i $gaiaversionoutputfile
    elif [ $isitnewkernel -eq 1 ]; then
        echo "NEW Kernel version $gaia_kernel_version" | tee -a -i $gaiaversionoutputfile
    else
        echo "Kernel version $gaia_kernel_version" | tee -a -i $gaiaversionoutputfile
    fi
    echo
    
    # Alternative approach from Health Check
    
    sys_type="N/A"
    sys_type_MDS=false
    sys_type_SMS=false
    sys_type_SmartEvent=false
    sys_type_GW=false
    sys_type_STANDALONE=false
    sys_type_VSX=false
    sys_type_UEPM=false
    sys_type_UEPM_EndpointServer=false
    sys_type_UEPM_PolicyServer=false
    
    
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
    
    if [[ $($CPDIR/bin/cpprod_util FwIsFirewallModule 2> /dev/null) == *"1"*  ]]; then
        sys_type_GW=true
        sys_type="GATEWAY"
    else
        sys_type_GW=false
    fi
    
    if [[ $($CPDIR/bin/cpprod_util FwIsStandAlone 2> /dev/null) == *"1"* ]]; then
        sys_type_STANDALONE=true
        sys_type="STANDALONE"
    else
        sys_type_STANDALONE=false
    fi
    
    if [[ $($CPDIR/bin/cpprod_util UepmIsInstalled 2> /dev/null) == *"1"* ]]; then
    	sys_type_UEPM=true
    	sys_type="UEPM"
    else
    	sys_type_UEPM=false
    fi
    
    if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
    	sys_type_UEPM_EndpointServer=true
    else
    	sys_type_UEPM_EndpointServer=false
    fi
    
    if [[ $($CPDIR/bin/cpprod_util UepmIsPolicyServer 2> /dev/null) == *"1"* ]]; then
    	sys_type_UEPM_PolicyServer=true
    else
    	sys_type_UEPM_PolicyServer=false
    fi
    
    echo "sys_type = "$sys_type | tee -a -i $gaiaversionoutputfile
    echo | tee -a -i $gaiaversionoutputfile
    echo "System Type : SMS                  :"$sys_type_SMS | tee -a -i $gaiaversionoutputfile
    echo "System Type : MDS                  :"$sys_type_MDS | tee -a -i $gaiaversionoutputfile
    echo "System Type : SmartEvent           :"$sys_type_SmartEvent | tee -a -i $gaiaversionoutputfile
    echo "System Type : GATEWAY              :"$sys_type_GW | tee -a -i $gaiaversionoutputfile
    echo "System Type : STANDALONE           :"$sys_type_STANDALONE | tee -a -i $gaiaversionoutputfile
    echo "System Type : VSX                  :"$sys_type_VSX | tee -a -i $gaiaversionoutputfile
    echo "System Type : UEPM                 :"$sys_type_UEPM | tee -a -i $gaiaversionoutputfile
    echo "System Type : UEPM Endpoint Server :"$sys_type_UEPM_EndpointServer | tee -a -i $gaiaversionoutputfile
    echo "System Type : UEPM Policy Server   :"$sys_type_UEPM_PolicyServer | tee -a -i $gaiaversionoutputfile
    echo | tee -a -i $gaiaversionoutputfile
    
    # -------------------------------------------------------------------------------------------------
    # END: Identify Gaia Version and Installation Type Details
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    return 0
}



# =================================================================================================
# END:  Local Proceedures
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo >> $APICLIlogfilepath
echo '-------------------------------------------------------------------------------------------------' >> $APICLIlogfilepath
echo '-------------------------------------------------------------------------------------------------' >> $APICLIlogfilepath
echo ' Identify Gaia Version and Installation Type Details ' >> $APICLIlogfilepath
echo '-------------------------------------------------------------------------------------------------' >> $APICLIlogfilepath
echo >> $APICLIlogfilepath

IdentifyGaiaVersionAndInstallationType

cat $gaiaversionoutputfile >> $APICLIlogfilepath
echo >> $APICLIlogfilepath
echo '-------------------------------------------------------------------------------------------------' >> $APICLIlogfilepath
echo '-------------------------------------------------------------------------------------------------' >> $APICLIlogfilepath
echo >> $APICLIlogfilepath

rm $gaiaversionoutputfile

# -------------------------------------------------------------------------------------------------
# End :  Determine version of server and type  
# -------------------------------------------------------------------------------------------------

# =================================================================================================
# END:  Determine version of server and type
# =================================================================================================
# =================================================================================================


# =================================================================================================
# END:  
# =================================================================================================
# =================================================================================================


