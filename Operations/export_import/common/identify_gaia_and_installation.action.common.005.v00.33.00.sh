#!/bin/bash
#
# SCRIPT Template for CLI Operations for command line parameters handling
#
# (C) 2016-2019 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
#
ScriptVersion=00.33.00
ScriptRevision=000
ScriptDate=2019-01-18
TemplateVersion=00.33.00
CommonScriptsVersion=00.33.00
CommonScriptsRevision=005

#

export APICommonActionsScriptVersion=v${ScriptVersion//./x}
export APICommonActionScriptTemplateVersion=v${TemplateVersion//./x}
ActionScriptName=identify_gaia_and_installation.action.common.$CommonScriptsRevision.v$ScriptVersion

# =================================================================================================
# Validate Common Actions Script version is correct for caller
# =================================================================================================


if [ x"$APIExpectedCommonScriptsVersion" = x"$APICommonActionsScriptVersion" ] ; then
    # Script and Common Actions Script versions match, go ahead
    echo >> $APICLIlogfilepath
    echo 'Verify Common Actions Scripts Version - OK' >> $APICLIlogfilepath
    echo >> $APICLIlogfilepath
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Common Actions Scripts Version - Missmatch' | tee -a -i $APICLIlogfilepath
    echo 'Expected Common Script version : '$APIExpectedCommonScriptsVersion | tee -a -i $APICLIlogfilepath
    echo 'Current  Common Script version : '$APICommonActionsScriptVersion | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 250
fi


# =================================================================================================
# =================================================================================================
# START:  Determine version of server and type
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
    
    
    export productversion=$(clish -i -c "show version product" | cut -d " " -f 6)

    # Keep the first string before next space in returned product version, since that could be owned 
    # if clish is owned elsewhere
    #
    export gaiaversion=$(echo $productversion | cut -d " " -f 1)

    # check if clish is owned and if it is, try a different alternative to get the version
    #
    export checkgaiaversion=`echo "${gaiaversion}" | grep -i "owned"`
    export isclishowned=`test -z $checkgaiaversion; echo $?`
    if [ $isclishowned -eq 1 ]; then 
        cpreleasefile=/etc/cp-release
        if [ -r $cpreleasefile ] ; then
            # OK we have the easy-button alternative
            export gaiaversion=$(cat $cpreleasefile | cut -d " " -f 4)
        else
            # OK that's not going to work without the file

            # Requires that $JQ is properly defined in the script
            # so $UseJSONJQ = true must be set on template version 0.32.0 and higher
            #
            export pythonpath=$MDS_FWDIR/Python/bin/
            if $UseJSONJQ ; then
                export get_platform_release=`$pythonpath/python $MDS_FWDIR/scripts/get_platform.py -f json | $JQ '. | .release'`
            else
                export get_platform_release=`$pythonpath/python $MDS_FWDIR/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
            fi
            
            export platform_release=${get_platform_release//\"/}
            export get_platform_release_version=`echo ${get_platform_release//\"/} | cut -d " " -f 4`
            export platform_release_version=${get_platform_release_version//\"/}
            
            export gaiaversion=$platform_release_version
        fi
    fi

    
    echo 'Gaia Version : $gaiaversion = '$gaiaversion >> $gaiaversionoutputfile
    echo >> $gaiaversionoutputfile
    
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
        echo "System is Multi-Domain Management Server!" >> $gaiaversionoutputfile
        Check4GW=0
    elif [ $Check4SMS -gt 0 ] && [ $Check4MDS -eq 0 ]; then
        echo "System is Security Management Server!" >> $gaiaversionoutputfile
        Check4SMS=1
        Check4GW=0
    else
        echo "System is a gateway!" >> $gaiaversionoutputfile
        Check4GW=1
    fi
    echo
    
    if [ $Check4SMSR80x10 -gt 0 ]; then
        echo "Security Management Server version R80.10" >> $gaiaversionoutputfile
        export gaiaversion=R80.10
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
            echo "Endpoint Security Server version R80.10" >> $gaiaversionoutputfile
        else
        	Check4EPM=0
        fi
    elif [ $Check4SMSR80x20 -gt 0 ]; then
        echo "Security Management Server version R80.20" >> $gaiaversionoutputfile
        export gaiaversion=R80.20
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
            echo "Endpoint Security Server version R80.20" >> $gaiaversionoutputfile
        else
        	Check4EPM=0
        fi
    elif [ $Check4SMSR80x20xM1 -gt 0 ]; then
        echo "Security Management Server version R80.20.M1" >> $gaiaversionoutputfile
        export gaiaversion=R80.20.M1
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
            echo "Endpoint Security Server version R80.20.M1" >> $gaiaversionoutputfile
        else
        	Check4EPM=0
        fi
    elif [ $Check4SMSR80x20xM2 -gt 0 ]; then
        echo "Security Management Server version R80.20.M2" >> $gaiaversionoutputfile
        export gaiaversion=R80.20.M2
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
            echo "Endpoint Security Server version R80.20.M2" >> $gaiaversionoutputfile
        else
        	Check4EPM=0
        fi
    elif [ $Check4EP773000 -gt 0 ] && [ $Check4EP773003 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.03" >> $gaiaversionoutputfile
        export gaiaversion=R77.30.03
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ] && [ $Check4EP773002 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.02" >> $gaiaversionoutputfile
        export gaiaversion=R77.30.02
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ] && [ $Check4EP773001 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30.01" >> $gaiaversionoutputfile
        export gaiaversion=R77.30.01
        Check4EPM=1
    elif [ $Check4EP773000 -gt 0 ]; then
        echo "Endpoint Security Server version R77.30" >> $gaiaversionoutputfile
        export gaiaversion=R77.30
        Check4EPM=1
    else
        echo "Not Gaia Endpoint Security Server R77.30" >> $gaiaversionoutputfile
        
        if [[ $($CPDIR/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
        	Check4EPM=1
        else
        	Check4EPM=0
        fi
        
    fi
    
    echo >> $gaiaversionoutputfile
    echo 'Final $gaiaversion = '$gaiaversion >> $gaiaversionoutputfile
    echo >> $gaiaversionoutputfile
    
    if [ $Check4MDS -eq 1 ]; then
    	echo 'Multi-Domain Management stuff...' >> $gaiaversionoutputfile
    fi
    
    if [ $Check4SMS -eq 1 ]; then
    	echo 'Security Management Server stuff...' >> $gaiaversionoutputfile
    fi
    
    if [ $Check4EPM -eq 1 ]; then
    	echo 'Endpoint Security Management Server stuff...' >> $gaiaversionoutputfile
    fi
    
    if [ $Check4GW -eq 1 ]; then
    	echo 'Gateway stuff...' >> $gaiaversionoutputfile
    fi
    
    #echo
    #export gaia_kernel_version=$(uname -r)
    #if [ "$gaia_kernel_version" == "2.6.18-92cpx86_64" ]; then
    #    echo "OLD Kernel version $gaia_kernel_version" >> $gaiaversionoutputfile
    #elif [ "$gaia_kernel_version" == "3.10.0-514cpx86_64" ]; then
    #    echo "NEW Kernel version $gaia_kernel_version" >> $gaiaversionoutputfile
    #else
    #    echo "Kernel version $gaia_kernel_version" >> $gaiaversionoutputfile
    #fi
    #echo
    
    echo >> $gaiaversionoutputfile
    export gaia_kernel_version=$(uname -r)
    export kernelv2x06=2.6
    export kernelv3x10=3.10
    export checkthiskernel=`echo "${gaia_kernel_version}" | grep -i "$kernelv2x06"`
    export isitoldkernel=`test -z $checkthiskernel; echo $?`
    export checkthiskernel=`echo "${gaia_kernel_version}" | grep -i "$kernelv3x10"`
    export isitnewkernel=`test -z $checkthiskernel; echo $?`
    
    if [ $isitoldkernel -eq 1 ] ; then
        echo "OLD Kernel version $gaia_kernel_version" >> $gaiaversionoutputfile
    elif [ $isitnewkernel -eq 1 ]; then
        echo "NEW Kernel version $gaia_kernel_version" >> $gaiaversionoutputfile
    else
        echo "Kernel version $gaia_kernel_version" >> $gaiaversionoutputfile
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
    
    echo "sys_type = "$sys_type >> $gaiaversionoutputfile
    echo >> $gaiaversionoutputfile
    echo "System Type : SMS                  :"$sys_type_SMS >> $gaiaversionoutputfile
    echo "System Type : MDS                  :"$sys_type_MDS >> $gaiaversionoutputfile
    echo "System Type : SmartEvent           :"$sys_type_SmartEvent >> $gaiaversionoutputfile
    echo "System Type : GATEWAY              :"$sys_type_GW >> $gaiaversionoutputfile
    echo "System Type : STANDALONE           :"$sys_type_STANDALONE >> $gaiaversionoutputfile
    echo "System Type : VSX                  :"$sys_type_VSX >> $gaiaversionoutputfile
    echo "System Type : UEPM                 :"$sys_type_UEPM >> $gaiaversionoutputfile
    echo "System Type : UEPM Endpoint Server :"$sys_type_UEPM_EndpointServer >> $gaiaversionoutputfile
    echo "System Type : UEPM Policy Server   :"$sys_type_UEPM_PolicyServer >> $gaiaversionoutputfile
    echo >> $gaiaversionoutputfile
    
    # -------------------------------------------------------------------------------------------------
    # END: Identify Gaia Version and Installation Type Details
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    return 0
}


# =================================================================================================
# END:  Local Proceedures
# =================================================================================================


echo >> $APICLIlogfilepath
echo '-------------------------------------------------------------------------------------------------' >> $APICLIlogfilepath
echo '-------------------------------------------------------------------------------------------------' >> $APICLIlogfilepath
echo ' Identify Gaia Version and Installation Type Details ' >> $APICLIlogfilepath
echo '-------------------------------------------------------------------------------------------------' >> $APICLIlogfilepath
echo >> $APICLIlogfilepath

IdentifyGaiaVersionAndInstallationType "$@"

cat $gaiaversionoutputfile | tee -a -i $APICLIlogfilepath

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


