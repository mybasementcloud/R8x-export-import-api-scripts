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
#
# -#- Start Making Changes Here -#- 
#
# SCRIPT test reading json export objects definition file
#
#
ScriptVersion=00.60.09
ScriptRevision=020
ScriptSubRevision=045
ScriptDate=2022-06-11
TemplateVersion=00.60.09
APISubscriptsLevel=010
APISubscriptsVersion=00.60.09
APISubscriptsRevision=015

#

export APIScriptVersion=v${ScriptVersion}
export APIScriptTemplateVersion=v${TemplateVersion}

export APIScriptVersionX=v${ScriptVersion//./x}
export APIScriptTemplateVersionX=v${TemplateVersion//./x}

export APIExpectedActionScriptsVersion=v${ScriptVersion}
export APIExpectedAPISubscriptsVersion=v${APISubscriptsVersion}

export APIExpectedActionScriptsVersionX=v${ScriptVersion//./x}
export APIExpectedAPISubscriptsVersionX=v${APISubscriptsVersion//./x}

ScriptName=wip.test_read_exobdef_json_file
export APIScriptFileNameRoot=wip.test_read_exobdef_json_file
export APIScriptShortName=wip.test_read_exobdef_json_file
export APIScriptnohupName=${APIScriptShortName}
export APIScriptDescription="test reading json export objects definition fil"

# =================================================================================================
# =================================================================================================
# START script
# =================================================================================================
# =================================================================================================


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
export dtgs_script_start=`date -u +%F-%T-%Z`

#
# rootsafeworkpath     :  This is the path where it is safe to store scripts, to survive upgrades and patching
# customerpathroot     :  Path to the customer work environment, should be under ${rootsafeworkpath}
# scriptspathroot      :  Path to the folder with bash 4 Check Point scripts installation (b4CP)
#

export rootsafeworkpath=/var/log
export customerpathroot=${rootsafeworkpath}/__customer
export scriptspathroot=${customerpathroot}/upgrade_export/scripts

export rootscriptconfigfile=__root_script_config.sh

export logfilepath=/var/tmp/${ScriptName}'_'${APIScriptVersion}'_'${DATEDTGS}.log

export dtzs='date -u +%Y%m%d-%T-%Z'
export dtzsep=' | '


# -------------------------------------------------------------------------------------------------
# UI Display Prefix Parameters, check if user has set environment preferences
# -------------------------------------------------------------------------------------------------


export dot_enviroinfo_file='.environment_info.json'
export dot_enviroinfo_path=${customerpathroot}
export dot_enviroinfo_fqpn=
if [ -r "./${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path='.'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "../${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path='..'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "${scriptspathroot}/${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path=${scriptspathroot}
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
elif [ -r "${customerpathroot}/${dot_enviroinfo}" ] ; then
    export dot_enviroinfo_path=${customerpathroot}
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
else
    export dot_enviroinfo_path='.'
    export dot_enviroinfo_fqpn=${dot_enviroinfo_path}/${dot_enviroinfo_file}
fi

if [ -r ${dot_enviroinfo_fqpn} ] ; then
    getdtzs=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."dtzs"`
    readdtzs=${getdtzs}
    if [ x"${readdtzs}" != x"" ] ; then
        export dtzs=${readdtzs}
    fi
    getdtzsep=`cat ${dot_enviroinfo_fqpn} | jq -r ."script_ui_config"."dtzsep"`
    readdtzsep=${getdtzsep}
    if [ x"${readdtzsep}" != x"" ] ; then
        export dtzsep=${readdtzsep}
    fi
fi


# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------

echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision}.${ScriptSubRevision} | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} 'Script original call name :  '$0 | tee -a -i ${logfilepath}
echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# ConfigureJQLocation - Configure the value of JQ based on installation
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-11-16 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# ConfigureJQLocation - Configure the value of JQ based on installation
#

# MODIFIED 2020-02-07 -
ConfigureJQLocation () {
    #
    # Configure JQ variable value for JSON parsing
    #
    # variable JQ points to where jq is installed
    #
    # Apparently MDM, MDS, and Domains don't agree on who sets CPDIR, so better to check!
    
    #export JQ=${CPDIR}/jq/jq
    
    
    # =============================================================================
    # JSON Query JQ and version specific JQ16 values
    # =============================================================================
    
    export JQNotFound=true
    export UseJSONJQ=false
    
    # JQ points to where the default jq is installed, probably version 1.4
    if [ -r ${CPDIR}/jq/jq ] ; then
        export JQ=${CPDIR}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    elif [ -r ${CPDIR_PATH}/jq/jq ] ; then
        export JQ=${CPDIR_PATH}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    elif [ -r ${MDS_CPDIR}/jq/jq ] ; then
        export JQ=${MDS_CPDIR}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    else
        export JQ=
        export JQNotFound=true
        export UseJSONJQ=false
    fi
    
    # JQ16 points to where jq 1.6 is installed, which is not generally part of Gaia, even R80.40EA (2020-01-20)
    export JQ16NotFound=true
    export UseJSONJQ16=false
    
    # As of template version v04.21.00 we also added jq version 1.6 to the mix and it lives in the customer path root /tools/JQ folder by default
    export JQ16PATH=${customerpathroot}/_tools/JQ
    export JQ16FILE=jq-linux64
    export JQ16FQFN=$JQ16PATH$JQ16FILE
    
    if [ -r ${JQ16FQFN} ] ; then
        # OK we have the easy-button alternative
        export JQ16=${JQ16FQFN}
        export JQ16NotFound=false
        export UseJSONJQ16=true
    elif [ -r "./_tools/JQ/${JQ16FILE}" ] ; then
        # OK we have the local folder alternative
        export JQ16=./_tools/JQ/${JQ16FILE}
        export JQ16NotFound=false
        export UseJSONJQ16=true
    elif [ -r "../_tools/JQ/${JQ16FILE}" ] ; then
        # OK we have the parent folder alternative
        export JQ16=../_tools/JQ/${JQ16FILE}
        export JQ16NotFound=false
        export UseJSONJQ16=true
    else
        # nope, not part of the package, so clear the values
        export JQ16=
        export JQ16NotFound=true
        export UseJSONJQ16=false
    fi
    
    if ${JQNotFound} ; then
        echo `${dtzs}`${dtzsep} "Missing jq, not found in ${CPDIR}/jq/jq, ${CPDIR_PATH}/jq/jq, or ${MDS_CPDIR}/jq/jq" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        exit 1
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2020-11-16


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# variable JQ points to where jq is installed
export JQ=${CPDIR_PATH}/jq/jq

ConfigureJQLocation


# MODIFIED 2022-03-10 -
#
export AbsoluteAPIMaxObjectLimit=500
export MinAPIObjectLimit=50
export MaxAPIObjectLimit=${AbsoluteAPIMaxObjectLimit}
export MaxAPIObjectLimitSlowObjects=100
export DefaultAPIObjectLimitMDSMXtraSlow=50
export DefaultAPIObjectLimitMDSMSlow=100
export DefaultAPIObjectLimitMDSMMedium=250
export DefaultAPIObjectLimitMDSMFast=500
export SlowObjectAPIObjectLimitMDSMXtraSlow=25
export SlowObjectAPIObjectLimitMDSMSlow=50
export SlowObjectAPIObjectLimitMDSMMedium=100
export SlowObjectAPIObjectLimitMDSMFast=200
#export RecommendedAPIObjectLimitMDSM=200
export RecommendedAPIObjectLimitMDSM=${DefaultAPIObjectLimitMDSMMedium}
export DefaultAPIObjectLimit=${MaxAPIObjectLimit}
export DefaultAPIObjectLimitMDSM=${RecommendedAPIObjectLimitMDSM}
export DefaultAPIObjectLimitMDSMSlowObjects=${SlowObjectAPIObjectLimitMDSMSlow}


export exobdeffilepath=./export_objects_definition.json
export CSVFileHeader=
export csvJQparsevalue=

echo `${dtzs}`${dtzsep}
echo `${dtzs}`${dtzsep} 'exobdeffilepath = '${exobdeffilepath}
echo `${dtzs}`${dtzsep} 'CSVFileHeader   = '${CSVFileHeader}
echo `${dtzs}`${dtzsep} 'csvJQparsevalue = '${csvJQparsevalue}
echo `${dtzs}`${dtzsep}


#getcsvfileheaderval=$(cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r)
#getcsvJQparseval=$(cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r)
#getcsvfileheaderval=`cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r`
#getcsvJQparseval=`cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r`

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# set_default_csv_export_elements : Set the values for default csv export elements
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-10-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

set_default_csv_export_elements  () {
    #
    
    whichname=$1
    
    export readcsvfileheader=`cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"$whichname"'") | ."CSVFileHeader"' -r`
    export readcsvJQparsevalue=`cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"$whichname"'") | ."CSVJQparms"' -r`
    
    if [ -z "${CSVFileHeader}" ] ; then
        export CSVFileHeader=${readcsvfileheader}
    else
        export CSVFileHeader=${CSVFileHeader}','${readcsvfileheader}
    fi
    
    if [ -z "${csvJQparsevalue}" ] ; then
        export csvJQparsevalue=${readcsvJQparsevalue}
    else
        export csvJQparsevalue=${csvJQparsevalue}', '${readcsvJQparsevalue}
    fi
    
    echo `${dtzs}`${dtzsep} 'readcsvfileheader   = '${readcsvfileheader}
    echo `${dtzs}`${dtzsep} 'readcsvJQparsevalue = '${readcsvJQparsevalue}
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep} 'CSVFileHeader       = '${CSVFileHeader}
    echo `${dtzs}`${dtzsep} 'csvJQparsevalue     = '${csvJQparsevalue}
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep}
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-10-02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#set_default_csv_export_elements <parm1=elementname>

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# set_simplexobjects_csv_export_elements : Set the values for simplex export elements
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-10-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

set_simplexobjects_csv_export_elements () {
    #
    
    whichname=$1
    
    export readcsvfileheader=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."CSVFileHeader"' -r`
    export readcsvJQparsevalue=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."CSVJQparms"' -r`
    
    if [ -z "${CSVFileHeader}" ] ; then
        export CSVFileHeader=${readcsvfileheader}
    else
        export CSVFileHeader=${CSVFileHeader}','${readcsvfileheader}
    fi
    
    if [ -z "${csvJQparsevalue}" ] ; then
        export csvJQparsevalue=${readcsvJQparsevalue}
    else
        export csvJQparsevalue=${csvJQparsevalue}', '${readcsvJQparsevalue}
    fi
    
    echo `${dtzs}`${dtzsep} 'readcsvfileheader       = '${readcsvfileheader}
    echo `${dtzs}`${dtzsep} 'readcsvJQparsevalue     = '${readcsvJQparsevalue}
    echo `${dtzs}`${dtzsep}
    
    export APIobjectminversion=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."api-version"' -r`
    export APICLIobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."objectype"' -r`
    export APICLIobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."objectsype"' -r`
    export APICLICSVobjecttype=${APICLIobjectstype}
    
    export WorkAPIObjectLimit=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."objectlimit"' -r`
    export APICLIobjectsortparms=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."sortparms"' -r`
    export APICLIobjectgroup=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."objectgroup"' -r`
    
    echo `${dtzs}`${dtzsep} 'APIobjectminversion     = '${APIobjectminversion}
    echo `${dtzs}`${dtzsep} 'APICLIobjecttype        = '${APICLIobjecttype}
    echo `${dtzs}`${dtzsep} 'APICLIobjectstype       = '${APICLIobjectstype}
    echo `${dtzs}`${dtzsep} 'APICLICSVobjecttype     = '${APICLICSVobjecttype}
    echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit      = '${WorkAPIObjectLimit}
    echo `${dtzs}`${dtzsep} 'APICLIobjectsortparms   = '${APICLIobjectsortparms}
    echo `${dtzs}`${dtzsep} 'APICLIobjectgroup       = '${APICLIobjectgroup}
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep} 'CSVFileHeader           = '${CSVFileHeader}
    echo `${dtzs}`${dtzsep} 'csvJQparsevalue         = '${csvJQparsevalue}
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep}
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-10-02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#set_simplexobjects_csv_export_elements <parm1=elementname>

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# set_complexobjectmembers_csv_export_elements : Set the values for compolex export elements
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-10-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

set_complexobjectmembers_csv_export_elements () {
    #
    
    whichname=$1
    
    export readcsvfileheader=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."CSVFileHeader"' -r`
    export readcsvJQparsevalue=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."CSVJQparms"' -r`
    
    if [ -z "${CSVFileHeader}" ] ; then
        export CSVFileHeader=${readcsvfileheader}
    else
        export CSVFileHeader=${CSVFileHeader}','${readcsvfileheader}
    fi
    
    if [ -z "${csvJQparsevalue}" ] ; then
        export csvJQparsevalue=${readcsvJQparsevalue}
    else
        export csvJQparsevalue=${csvJQparsevalue}', '${readcsvJQparsevalue}
    fi
    
    echo `${dtzs}`${dtzsep} 'readcsvfileheader       = '${readcsvfileheader}
    echo `${dtzs}`${dtzsep} 'readcsvJQparsevalue     = '${readcsvJQparsevalue}
    echo `${dtzs}`${dtzsep}
    
    export APIobjectminversion=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."api-version"' -r`
    export APICLIobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."objectype"' -r`
    export APICLIobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."objectsype"' -r`
    export APICLICSVobjecttype=${APICLIobjectstype}
    export APICLIcomplexobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."complexobjecttype"' -r`
    export APICLIcomplexobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."complexobjectstype"' -r`
    
    export WorkAPIObjectLimit=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."objectlimit"' -r`
    export APICLIobjectsortparms=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."sortparms"' -r`
    export APICLIobjectgroup=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."objectgroup"' -r`
    
    echo `${dtzs}`${dtzsep} 'APIobjectminversion     = '${APIobjectminversion}
    echo `${dtzs}`${dtzsep} 'APICLIobjecttype        = '${APICLIobjecttype}
    echo `${dtzs}`${dtzsep} 'APICLIobjectstype       = '${APICLIobjectstype}
    echo `${dtzs}`${dtzsep} 'APICLICSVobjecttype     = '${APICLICSVobjecttype}
    echo `${dtzs}`${dtzsep} 'APICLIcomplexobjecttype = '${APICLIcomplexobjecttype}
    echo `${dtzs}`${dtzsep} 'APICLIcomplexobjectstype= '${APICLIcomplexobjectstype}
    echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit      = '${WorkAPIObjectLimit}
    echo `${dtzs}`${dtzsep} 'APICLIobjectsortparms   = '${APICLIobjectsortparms}
    echo `${dtzs}`${dtzsep} 'APICLIobjectgroup       = '${APICLIobjectgroup}
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep} 'CSVFileHeader           = '${CSVFileHeader}
    echo `${dtzs}`${dtzsep} 'csvJQparsevalue         = '${csvJQparsevalue}
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep}
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-10-02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#set_complexobjectmembers_csv_export_elements <parm1=elementname>

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# set_complexobjects_csv_export_elements : Set the values for compolex export elements
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-10-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

set_complexobjects_csv_export_elements () {
    #
    
    whichname=$1
    
    export readcsvfileheader=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."CSVFileHeader"' -r`
    export readcsvJQparsevalue=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."CSVJQparms"' -r`
    
    if [ -z "${CSVFileHeader}" ] ; then
        export CSVFileHeader=${readcsvfileheader}
    else
        export CSVFileHeader=${CSVFileHeader}','${readcsvfileheader}
    fi
    
    if [ -z "${csvJQparsevalue}" ] ; then
        export csvJQparsevalue=${readcsvJQparsevalue}
    else
        export csvJQparsevalue=${csvJQparsevalue}', '${readcsvJQparsevalue}
    fi
    
    echo `${dtzs}`${dtzsep} 'readcsvfileheader       = '${readcsvfileheader}
    echo `${dtzs}`${dtzsep} 'readcsvJQparsevalue     = '${readcsvJQparsevalue}
    echo `${dtzs}`${dtzsep}
    
    export APIobjectminversion=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."api-version"' -r`
    export APICLIobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."objectype"' -r`
    export APICLIobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."objectsype"' -r`
    export APICLICSVobjecttype=${APICLIobjectstype}
    export APICLIcomplexobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."complexobjecttype"' -r`
    export APICLIcomplexobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."complexobjectstype"' -r`
    
    export WorkAPIObjectLimit=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."objectlimit"' -r`
    export APICLIobjectsortparms=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."sortparms"' -r`
    export APICLIobjectgroup=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."objectgroup"' -r`
    
    echo `${dtzs}`${dtzsep} 'APIobjectminversion     = '${APIobjectminversion}
    echo `${dtzs}`${dtzsep} 'APICLIobjecttype        = '${APICLIobjecttype}
    echo `${dtzs}`${dtzsep} 'APICLIobjectstype       = '${APICLIobjectstype}
    echo `${dtzs}`${dtzsep} 'APICLICSVobjecttype     = '${APICLICSVobjecttype}
    echo `${dtzs}`${dtzsep} 'APICLIcomplexobjecttype = '${APICLIcomplexobjecttype}
    echo `${dtzs}`${dtzsep} 'APICLIcomplexobjectstype= '${APICLIcomplexobjectstype}
    echo `${dtzs}`${dtzsep} 'WorkAPIObjectLimit      = '${WorkAPIObjectLimit}
    echo `${dtzs}`${dtzsep} 'APICLIobjectsortparms   = '${APICLIobjectsortparms}
    echo `${dtzs}`${dtzsep} 'APICLIobjectgroup       = '${APICLIobjectgroup}
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep} 'CSVFileHeader           = '${CSVFileHeader}
    echo `${dtzs}`${dtzsep} 'csvJQparsevalue         = '${csvJQparsevalue}
    echo `${dtzs}`${dtzsep}
    echo `${dtzs}`${dtzsep}
    
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-10-02


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#set_complexobjects_csv_export_elements <parm1=elementname>

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


export elementname=common

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

export elementname=name-only

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

export elementname=name-and-uid

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

export elementname=uid-only

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

export elementname=tags05

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

export elementname=tags10

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

export elementname=domain

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

export elementname=meta-info

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

export elementname=errorhandling

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo `${dtzs}`${dtzsep}

set_default_csv_export_elements "${elementname}"

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'


export keepercsvfileheader=${CSVFileHeader}
export keepercsvJQparsevalue=${csvJQparsevalue}


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_simplexobjects_csv_export_elements "host"

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_simplexobjects_csv_export_elements "network"

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_simplexobjects_csv_export_elements "group"

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_simplexobjects_csv_export_elements "service TCP"

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_complexobjectmembers_csv_export_elements "user group member"

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_complexobjects_csv_export_elements "host interface"

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'


echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'


#cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | ."name"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | ."name"' -c
cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | ."name"'
echo `${dtzs}`${dtzsep}

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | "\"" + .name + "\","' -j
echo `${dtzs}`${dtzsep}

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'
echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

#cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | ."name"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | ."name"' -c
cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | ."name"'
echo `${dtzs}`${dtzsep}

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'

cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | "\"" + .name + "\","' -j
echo `${dtzs}`${dtzsep}

echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------------------------'


