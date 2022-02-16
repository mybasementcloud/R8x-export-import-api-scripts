#!/bin/bash
#
# (C) 2016-2022 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
#
# ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR 
# DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE 
# RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
# TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
# OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
# APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
# AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
#
# SCRIPT subscript for CLI Operations for identification of Gaia version and Installation handling
#
#
ScriptVersion=00.60.08
ScriptRevision=065
ScriptDate=2022-02-15
TemplateVersion=00.60.08
APISubscriptsLevel=010
APISubscriptsVersion=00.60.08
APISubscriptsRevision=065

#

export APISubscriptsScriptVersion=v${ScriptVersion}
export APISubscriptsScriptTemplateVersion=v${TemplateVersion}

export APISubscriptsScriptVersionX=v${ScriptVersion//./x}
export APISubscriptsScriptTemplateVersionX=v${TemplateVersion//./x}

APISubScriptName=identify_gaia_and_installation.subscript.common.${APISubscriptsLevel}.v${APISubscriptsVersion}
export APISubScriptFileNameRoot=identify_gaia_and_installation.subscript.common
export APISubScriptShortName=identify_gaia_and_installation
export APISubScriptnohupName=${APISubScriptShortName}
export APISubScriptDescription="Subscript for CLI Operations for identification of Gaia version and Installation handling"


# =================================================================================================
# =================================================================================================
# START subscript:  Determine version of server and type
# =================================================================================================


if ${SCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'APISubScriptName:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'APISubScriptName:  '${APISubScriptName}'  Script Version: '${ScriptVersion}'  Revision:  '${ScriptRevision} >> ${logfilepath}
fi


# =================================================================================================
# Validate Common Subscripts  Script version is correct for caller
# =================================================================================================


# MODIFIED 2021-10-21 -

if [ x"${APIExpectedAPISubscriptsVersion}" = x"${APISubscriptsScriptVersion}" ] ; then
    # Script and Common Subscripts Script versions match, go ahead
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Verify Common Subscripts Scripts Version - OK' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
else
    # Script and Subscripts Script versions don't match, ALL STOP!
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Raw Script name        : '$0 | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Subscript version name : '${APISubscriptsScriptVersion}' '${APISubScriptName} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Calling Script version : '${APIScriptVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Verify Common Subscripts Scripts Version - Missmatch' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Expected Common Subscripts Script version : '${APIExpectedAPISubscriptsVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Current  Common Subscripts Script version : '${APISubscriptsScriptVersion} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    exit 250
fi

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# Single Line entries
#printf 'variable :  %-25s = %s\n' "x" ${x} >> ${logfilepath}
#printf "%-35s$ : %s\n" "x" 'x' >> ${logfilepath}
# Two Line entries
#printf "%s\n" "x" >> ${logfilepath}
#printf "%-35s :: %s\n" " " 'x' >> ${logfilepath}


# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# START:  Local Variables
# =================================================================================================


export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log


# =================================================================================================
# START Procedures:  Local Proceedures - 
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# SetupTempLogFile - Setup Temporary Log File and clear any debris
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetupTempLogFile () {
    #
    # SetupTempLogFile - Setup Temporary Log File and clear any debris
    #
    
    if [ -z "$1" ]; then
        # No explicit name passed for action
        export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'${DATEDTGS}.log
    else
        # explicit name passed for action
        export subscriptstemplogfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_temp_'$1'_'${DATEDTGS}.log
    fi
    
    if [ -w ${subscriptstemplogfilepath} ] ; then
        rm ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
    fi
    
    touch ${subscriptstemplogfilepath}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

HandleShowTempLogFile () {
    #
    # HandleShowTempLogFile - Handle Showing of Temporary Log File based on verbose setting
    #
    
    if ${APISCRIPTVERBOSE} ; then
        # verbose mode so show the logged results and copy to normal log file
        cat ${subscriptstemplogfilepath} | tee -a -i ${logfilepath}
    else
        # NOT verbose mode so push logged results to normal log file
        cat ${subscriptstemplogfilepath} >> ${logfilepath}
    fi
    
    rm ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
# -------------------------------------------------------------------------------------------------


# MODIFIED 2020-11-19 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ForceShowTempLogFile () {
    #
    # ForceShowTempLogFile - Handle Showing of Temporary Log File based forced display
    #
    
    cat ${subscriptstemplogfilepath} | tee -a -i ${logfilepath}
    
    rm ${subscriptstemplogfilepath} >> ${logfilepath} 2>&1
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-19


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CheckAndUnlockGaiaDB - Check and Unlock Gaia database
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-09-30 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckAndUnlockGaiaDB () {
    #
    # CheckAndUnlockGaiaDB - Check and Unlock Gaia database
    #
    
    echo -n `${dtzs}`${dtzsep}'Unlock gaia database : '
    
    export gaiadbunlocked=false
    
    until ${gaiadbunlocked} ; do
        
        export checkgaiadblocked=`clish -i -c "lock database override" | grep -i "owned"`
        export isclishowned=`test -z ${checkgaiadblocked}; echo $?`
        
        if [ ${isclishowned} -eq 1 ]; then 
            echo -n '.'
            export gaiadbunlocked=false
        else
            echo -n '!'
            export gaiadbunlocked=true
        fi
        
    done
    
    echo
    echo -n `${dtzs}`${dtzsep}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-09-30

#CheckAndUnlockGaiaDB

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# clishIndependentVersionCheck - Removing dependency on clish to avoid collissions when database is locked
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-11-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

clishIndependentVersionCheck () {
    
    if ${AuthenticationMaaS} ; then
        # For MaaS (Smart-1 Cloud) we stipulate R81
        export gaiaversion=R81
    else
        # Requires that ${JQ} is properly defined in the script
        # so ${UseJSONJQ} = true must be set on template version 2.0.0 and higher
        #
        # Test string, use this to validate if there are problems:
        #
        #export pythonpath=${MDS_FWDIR}/Python/bin/;echo ${pythonpath};echo
        #${pythonpath}/python --help
        #${pythonpath}/python --version
        #
        
        export productversion=$(clish -i -c "show version product" | cut -d " " -f 6)
        
        # Keep the first string before next space in returned product version, since that could be owned 
        # if clish is owned elsewhere
        #
        export gaiaversion=$(echo ${productversion} | cut -d " " -f 1)
        
        # check if clish is owned and if it is, try a different alternative to get the version
        #
        export checkgaiaversion=`echo "${gaiaversion}" | grep -i "owned"`
        export isclishowned=`test -z ${checkgaiaversion}; echo $?`
        if [ ${isclishowned} -eq 1 ]; then 
            cpreleasefile=/etc/cp-release
            if [ -r ${cpreleasefile} ] ; then
                # OK we have the easy-button alternative
                export gaiaversion=$(cat ${cpreleasefile} | cut -d " " -f 4)
            else
                # OK that's not going to work without the file
                
                # Requires that ${JQ} is properly defined in the script
                # so ${UseJSONJQ} = true must be set on template version 0.32.0 and higher
                #
                export pythonpath=${MDS_FWDIR}/Python/bin/
                if ${UseJSONJQ} ; then
                    export get_platform_release=`${pythonpath}/python ${MDS_FWDIR}/scripts/get_platform.py -f json | ${JQ} '. | .release'`
                else
                    export get_platform_release=`${pythonpath}/python ${MDS_FWDIR}/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
                fi
                
                export platform_release=${get_platform_release//\"/}
                export get_platform_release_version=`echo ${get_platform_release//\"/} | cut -d " " -f 4`
                export platform_release_version=${get_platform_release_version//\"/}
                
                export gaiaversion=${platform_release_version}
            fi
        fi
    fi
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-09

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#clishIndependentVersionCheck

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# IdentifyGaiaVersionAndInstallationType - repeated proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2021-11-09 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

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
    
    
    export gaiaversionoutputfile=/var/tmp/gaiaversion_${DATEDTGS}.txt
    
    # remove the file if it exists
    if [ -w ${gaiaversionoutputfile} ] ; then
        rm ${gaiaversionoutputfile} >> ${logfilepath} 2>&1
    fi
    
    touch ${gaiaversionoutputfile} >> ${logfilepath} 2>&1
    
    echo `${dtzs}`${dtzsep} > ${gaiaversionoutputfile}
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    # START: Identify Gaia Version and Installation Type Details
    # -------------------------------------------------------------------------------------------------
    
    clishIndependentVersionCheck
    
    
    
    echo `${dtzs}`${dtzsep} 'Gaia Version : ${gaiaversion} = '${gaiaversion} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
    
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    
    # Alternative approach from Health Check
    
    export sys_type="N/A"
    export sys_type_MDS=false
    export sys_type_SMS=false
    export sys_type_SmartEvent=false
    export sys_type_SmartEvent_CorrelationUnit=false
    export sys_type_GW=false
    export sys_type_STANDALONE=false
    export sys_type_VSX=false
    export sys_type_UEPM_Installed=false
    export sys_type_UEPM_EndpointServer=false
    export sys_type_UEPM_PolicyServer=false
    
    
    if ${AuthenticationMaaS} ; then
        # MaaS (Smart-1 Cloud) doesn't provide a way to do this operation so we populate necessary entries
        echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
        echo `${dtzs}`${dtzsep} 'Final ${gaiaversion} = '${gaiaversion} >> ${gaiaversionoutputfile}
        echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
        
        export Check4SMS=0
        export Check4EPM=0
        export Check4MDS=1
        export Check4GW=0
        
        export sys_type_MDS=true
        export sys_type_SMS=false
        export sys_type="MDS"
    else
        export Check4SMS=0
        export Check4EPM=0
        export Check4MDS=0
        export Check4GW=0
        
        workfile=/var/tmp/cpinfo_ver.${DATEDTGS}.txt
        cpinfo -y all > ${workfile} 2>&1
        
        Check4EP=`grep -c "Endpoint Security Management" ${workfile}`
        Check4EP773003=`grep -c "Endpoint Security Management R77.30.03 " ${workfile}`
        Check4EP773002=`grep -c "Endpoint Security Management R77.30.02 " ${workfile}`
        Check4EP773001=`grep -c "Endpoint Security Management R77.30.01 " ${workfile}`
        Check4EP773000=`grep -c "Endpoint Security Management R77.30 " ${workfile}`
        
        Check4SMS=`grep -c "Security Management Server" ${workfile}`
        
        Check4SMSR80x10=`grep -c "Security Management Server R80.10 " ${workfile}`
        Check4SMSR80x20=`grep -c "Security Management Server R80.20 " ${workfile}`
        Check4SMSR80x20xM1=`grep -c "Security Management Server R80.20.M1 " ${workfile}`
        Check4SMSR80x20xM2=`grep -c "Security Management Server R80.20.M2 " ${workfile}`
        Check4SMSR80x30=`grep -c "Security Management Server R80.30 " ${workfile}`
        Check4SMSR80x40=`grep -c "Security Management Server R80.40 " ${workfile}`
        
        Check4SMSR81=`grep -c "Security Management Server R81 " ${workfile}`
        rm ${workfile}
        
        if [ "${MDSDIR}" != '' ]; then
            export Check4MDS=1
        else 
            export Check4MDS=0
        fi
        
        if [ ${Check4SMS} -gt 0 ] && [ ${Check4MDS} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "System is Multi-Domain Management Server!" >> ${gaiaversionoutputfile}
            export Check4GW=0
        elif [ ${Check4SMS} -gt 0 ] && [ ${Check4MDS} -eq 0 ]; then
            echo `${dtzs}`${dtzsep} "System is Security Management Server!" >> ${gaiaversionoutputfile}
            export Check4SMS=1
            export Check4GW=0
        else
            echo `${dtzs}`${dtzsep} "System is a gateway!" >> ${gaiaversionoutputfile}
            export Check4GW=1
        fi
        echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
        
        if [ ${Check4SMSR80x10} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Security Management Server version R80.10" >> ${gaiaversionoutputfile}
            #export gaiaversion=R80.10
            if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
                export Check4EPM=1
                echo `${dtzs}`${dtzsep} "Endpoint Security Server version R80.10" >> ${gaiaversionoutputfile}
            else
                export Check4EPM=0
            fi
        elif [ ${Check4SMSR80x20} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Security Management Server version R80.20" >> ${gaiaversionoutputfile}
            #export gaiaversion=R80.20
            if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
                export Check4EPM=1
                echo `${dtzs}`${dtzsep} "Endpoint Security Server version R80.20" >> ${gaiaversionoutputfile}
            else
                export Check4EPM=0
            fi
        elif [ ${Check4SMSR80x20xM1} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Security Management Server version R80.20.M1" >> ${gaiaversionoutputfile}
            #export gaiaversion=R80.20.M1
            if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
                export Check4EPM=1
                echo `${dtzs}`${dtzsep} "Endpoint Security Server version R80.20.M1" >> ${gaiaversionoutputfile}
            else
                export Check4EPM=0
            fi
        elif [ ${Check4SMSR80x20xM2} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Security Management Server version R80.20.M2" >> ${gaiaversionoutputfile}
            #export gaiaversion=R80.20.M2
            if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
                export Check4EPM=1
                echo `${dtzs}`${dtzsep} "Endpoint Security Server version R80.20.M2" >> ${gaiaversionoutputfile}
            else
                export Check4EPM=0
            fi
        elif [ ${Check4SMSR80x30} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Security Management Server version R80.30" >> ${gaiaversionoutputfile}
            #export gaiaversion=R80.30
            if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
                export Check4EPM=1
                echo `${dtzs}`${dtzsep} "Endpoint Security Server version R80.30" >> ${gaiaversionoutputfile}
            else
                export Check4EPM=0
            fi
        elif [ ${Check4SMSR80x40} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Security Management Server version R80.40" >> ${gaiaversionoutputfile}
            #export gaiaversion=R80.40
            if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
                export Check4EPM=1
                echo `${dtzs}`${dtzsep} "Endpoint Security Server version R80.40" >> ${gaiaversionoutputfile}
            else
                export Check4EPM=0
            fi
        elif [ ${Check4SMSR81} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Security Management Server version R81" >> ${gaiaversionoutputfile}
            #export gaiaversion=R81
            if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
                Check4EPM=1
                echo `${dtzs}`${dtzsep} "Endpoint Security Server version R81" >> ${gaiaversionoutputfile}
            else
                export Check4EPM=0
            fi
        elif [ ${Check4EP773000} -gt 0 ] && [ ${Check4EP773003} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Endpoint Security Server version R77.30.03" >> ${gaiaversionoutputfile}
            export gaiaversion=R77.30.03
            export Check4EPM=1
        elif [ ${Check4EP773000} -gt 0 ] && [ ${Check4EP773002} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Endpoint Security Server version R77.30.02" >> ${gaiaversionoutputfile}
            export gaiaversion=R77.30.02
            export Check4EPM=1
        elif [ ${Check4EP773000} -gt 0 ] && [ ${Check4EP773001} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Endpoint Security Server version R77.30.01" >> ${gaiaversionoutputfile}
            export gaiaversion=R77.30.01
            export Check4EPM=1
        elif [ ${Check4EP773000} -gt 0 ]; then
            echo `${dtzs}`${dtzsep} "Endpoint Security Server version R77.30" >> ${gaiaversionoutputfile}
            export gaiaversion=R77.30
            export Check4EPM=1
        else
            echo `${dtzs}`${dtzsep} "Not Gaia Endpoint Security Server R77.30" >> ${gaiaversionoutputfile}
            
            if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
                export Check4EPM=1
            else
                export Check4EPM=0
            fi
            
        fi
        
        echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
        echo `${dtzs}`${dtzsep} 'Final ${gaiaversion} = '${gaiaversion} >> ${gaiaversionoutputfile}
        echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
        
        #if [ ${Check4MDS} -eq 1 ]; then
        #    echo `${dtzs}`${dtzsep} 'Multi-Domain Management stuff...' >> ${gaiaversionoutputfile}
        #fi
        #
        #if [ ${Check4SMS} -eq 1 ]; then
        #    echo `${dtzs}`${dtzsep} 'Security Management Server stuff...' >> ${gaiaversionoutputfile}
        #fi
        #
        #if [ ${Check4EPM} -eq 1 ]; then
        #    echo `${dtzs}`${dtzsep} 'Endpoint Security Management Server stuff...' >> ${gaiaversionoutputfile}
        #fi
        #
        #if [ ${Check4GW} -eq 1 ]; then
        #    echo `${dtzs}`${dtzsep} 'Gateway stuff...' >> ${gaiaversionoutputfile}
        #fi
        #echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
        #
        
        #export gaia_kernel_version=$(uname -r)
        #if [ "$gaia_kernel_version" == "2.6.18-92cpx86_64" ]; then
        #    echo `${dtzs}`${dtzsep} "OLD Kernel version $gaia_kernel_version" >> ${gaiaversionoutputfile}
        #elif [ "$gaia_kernel_version" == "3.10.0-514cpx86_64" ]; then
        #    echo `${dtzs}`${dtzsep} "NEW Kernel version $gaia_kernel_version" >> ${gaiaversionoutputfile}
        #else
        #    echo `${dtzs}`${dtzsep} "Kernel version $gaia_kernel_version" >> ${gaiaversionoutputfile}
        #fi
        #echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
        #
        
        export gaia_kernel_version=$(uname -r)
        export kernelv2x06=2.6
        export kernelv3x10=3.10
        export checkthiskernel=`echo "${gaia_kernel_version}" | grep -i "$kernelv2x06"`
        export isitoldkernel=`test -z ${checkthiskernel}; echo $?`
        export checkthiskernel=`echo "${gaia_kernel_version}" | grep -i "$kernelv3x10"`
        export isitnewkernel=`test -z ${checkthiskernel}; echo $?`
        
        if [ ${isitoldkernel} -eq 1 ] ; then
            echo `${dtzs}`${dtzsep} "OLD Kernel version $gaia_kernel_version" >> ${gaiaversionoutputfile}
        elif [ ${isitnewkernel} -eq 1 ]; then
            echo `${dtzs}`${dtzsep} "NEW Kernel version $gaia_kernel_version" >> ${gaiaversionoutputfile}
        else
            echo `${dtzs}`${dtzsep} "Kernel version $gaia_kernel_version" >> ${gaiaversionoutputfile}
        fi
        echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
        
        #  System Type
        if [[ $(echo ${MDSDIR} | grep mds) ]]; then
            export sys_type_MDS=true
            export sys_type_SMS=false
            export sys_type="MDS"
        elif [[ $(${CPDIR}/bin/cpprod_util FwIsFirewallMgmt 2> /dev/null) == *"1"*  ]]; then
            export sys_type_SMS=true
            export sys_type_MDS=false
            export sys_type="SMS"
        else
            export sys_type_SMS=false
            export sys_type_MDS=false
        fi
        
        # Updated to correctly identify if SmartEvent is active
        # ${CPDIR}/bin/cpprod_util RtIsRt -> returns wrong result for MDM
        # ${CPDIR}/bin/cpprod_util RtIsAnalyzerServer -> returns correct result for MDM
        
        if [[ $(${CPDIR}/bin/cpprod_util RtIsAnalyzerServer 2> /dev/null) == *"1"*  ]]; then
            export sys_type_SmartEvent=true
            export sys_type="SmartEvent"
        else
            export sys_type_SmartEvent=false
        fi
        
        if [[ $(${CPDIR}/bin/cpprod_util RtIsAnalyzerCorrelationUnit 2> /dev/null) == *"1"*  ]]; then
            export sys_type_SmartEvent_CorrelationUnit=true
        else
            export sys_type_SmartEvent_CorrelationUnit=false
        fi
        
        if [[ $(${CPDIR}/bin/cpprod_util FwIsVSX 2> /dev/null) == *"1"* ]]; then
            export sys_type_VSX=true
            export sys_type="VSX"
        else
            export sys_type_VSX=false
        fi
        
        if [[ $(${CPDIR}/bin/cpprod_util FwIsFirewallModule 2> /dev/null) == *"1"*  ]]; then
            export sys_type_GW=true
            export sys_type="GATEWAY"
        else
            export sys_type_GW=false
        fi
        
        if [[ $(${CPDIR}/bin/cpprod_util FwIsStandAlone 2> /dev/null) == *"1"* ]]; then
            export sys_type_STANDALONE=true
            export sys_type="STANDALONE"
        else
            export sys_type_STANDALONE=false
        fi
        
        if [[ $(${CPDIR}/bin/cpprod_util UepmIsEps 2> /dev/null) == *"1"* ]]; then
            export sys_type_UEPM_EndpointServer=true
            export sys_type="UEPM"
        else
            export sys_type_UEPM_EndpointServer=false
        fi
        
        if [[ $(${CPDIR}/bin/cpprod_util UepmIsPolicyServer 2> /dev/null) == *"1"* ]]; then
            export sys_type_UEPM_PolicyServer=true
        else
            export sys_type_UEPM_PolicyServer=false
        fi
        
        if [[ $(${CPDIR}/bin/cpprod_util UepmIsInstalled 2> /dev/null) == *"1"* ]]; then
            export sys_type_UEPM_Installed=true
        else
            export sys_type_UEPM_Installed=false
        fi
    fi
    
    echo `${dtzs}`${dtzsep} "sys_type = "${sys_type} >> ${gaiaversionoutputfile}
    
    echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : SMS                   :"${sys_type_SMS} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : MDS                   :"${sys_type_MDS} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : SmartEvent            :"${sys_type_SmartEvent} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : SmEv Correlation Unit :"${sys_type_SmartEvent_CorrelationUnit} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : GATEWAY               :"${sys_type_GW} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : STANDALONE            :"${sys_type_STANDALONE} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : VSX                   :"${sys_type_VSX} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : UEPM Endpoint Server  :"${sys_type_UEPM_EndpointServer} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : UEPM Policy Server    :"${sys_type_UEPM_PolicyServer} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} "System Type : UEPM Installed        :"${sys_type_UEPM_Installed} >> ${gaiaversionoutputfile}
    echo `${dtzs}`${dtzsep} >> ${gaiaversionoutputfile}
    
    # -------------------------------------------------------------------------------------------------
    # END: Identify Gaia Version and Installation Type Details
    # -------------------------------------------------------------------------------------------------
    # -------------------------------------------------------------------------------------------------
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${gaiaversionoutputfile}
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2021-11-09

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#IdentifyGaiaVersionAndInstallationType


# =================================================================================================
# END Procedures:  Local Proceedures
# =================================================================================================


if ${APISCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} ' Identify Gaia Version and Installation Type Details ' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} ' Identify Gaia Version and Installation Type Details ' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
fi

IdentifyGaiaVersionAndInstallationType "$@"

if ${APISCRIPTVERBOSE} ; then
    cat ${gaiaversionoutputfile} | tee -a -i ${logfilepath}
    
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
else
    cat ${gaiaversionoutputfile} >> ${logfilepath}
    
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------' >> ${logfilepath}
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
fi

rm ${gaiaversionoutputfile} >> ${logfilepath} 2>&1

# -------------------------------------------------------------------------------------------------
# End :  Determine version of server and type  
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Determine version of server and type
# =================================================================================================


if ${APISCRIPTVERBOSE} ; then
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} 'API Subscript Completed :  '${APISubScriptName} | tee -a -i ${logfilepath}
else
    echo `${dtzs}`${dtzsep} >> ${logfilepath}
    echo `${dtzs}`${dtzsep} 'API Subscript Completed :  '${APISubScriptName} >> ${logfilepath}
fi


return 0


# =================================================================================================
# END subscript:  
# =================================================================================================
# =================================================================================================


