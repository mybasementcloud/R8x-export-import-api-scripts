#!/bin/bash
#
# SCRIPT test reading json export objects definition file
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
ScriptVersion=00.60.06
ScriptRevision=020
ScriptDate=2021-02-23
TemplateVersion=00.60.06
APISubscriptsLevel=006
APISubscriptsVersion=00.60.06
APISubscriptsRevision=020

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


# -------------------------------------------------------------------------------------------------
# Logging variables
# -------------------------------------------------------------------------------------------------


# Logging to nirvana
logfilepath=/dev/null


# -------------------------------------------------------------------------------------------------
# Announce what we are starting here...
# -------------------------------------------------------------------------------------------------

echo | tee -a -i ${logfilepath}
echo 'Script:  '${ScriptName}'  Script Version: '${ScriptVersion}'  Revision: '${ScriptRevision} | tee -a -i ${logfilepath}
echo 'Script original call name :  '$0 | tee -a -i ${logfilepath}
echo | tee -a -i ${logfilepath}

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
        echo "Missing jq, not found in ${CPDIR}/jq/jq, ${CPDIR_PATH}/jq/jq, or ${MDS_CPDIR}/jq/jq" | tee -a -i ${logfilepath}
        echo 'Critical Error - Exiting Script !!!!' | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
        echo "Log output in file ${logfilepath}" | tee -a -i ${logfilepath}
        echo | tee -a -i ${logfilepath}
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


export MinAPIObjectLimit=500
export MaxAPIObjectLimit=500
export WorkAPIObjectLimit=${MaxAPIObjectLimit}


export exobdeffilepath=./export_objects_definition.json
export CSVFileHeader=
export csvJQparsevalue=

echo
echo 'exobdeffilepath = '${exobdeffilepath}
echo 'CSVFileHeader   = '${CSVFileHeader}
echo 'csvJQparsevalue = '${csvJQparsevalue}
echo


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
    
    echo 'readcsvfileheader   = '${readcsvfileheader}
    echo 'readcsvJQparsevalue = '${readcsvJQparsevalue}
    echo
    echo 'CSVFileHeader       = '${CSVFileHeader}
    echo 'csvJQparsevalue     = '${csvJQparsevalue}
    echo
    echo
    
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
    
    echo 'readcsvfileheader       = '${readcsvfileheader}
    echo 'readcsvJQparsevalue     = '${readcsvJQparsevalue}
    echo
    
    export APIobjectminversion=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."api-version"' -r`
    export APICLIobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."objectype"' -r`
    export APICLIobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."objectsype"' -r`
    export APICLICSVobjecttype=${APICLIobjectstype}
    
    export WorkAPIObjectLimit=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."objectlimit"' -r`
    export APICLIobjectsortparms=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."sortparms"' -r`
    export APICLIobjectgroup=`cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | select(."name"=="'"$whichname"'") | ."objectgroup"' -r`
    
    echo 'APIobjectminversion     = '${APIobjectminversion}
    echo 'APICLIobjecttype        = '${APICLIobjecttype}
    echo 'APICLIobjectstype       = '${APICLIobjectstype}
    echo 'APICLICSVobjecttype     = '${APICLICSVobjecttype}
    echo 'WorkAPIObjectLimit      = '${WorkAPIObjectLimit}
    echo 'APICLIobjectsortparms   = '${APICLIobjectsortparms}
    echo 'APICLIobjectgroup       = '${APICLIobjectgroup}
    echo
    echo 'CSVFileHeader           = '${CSVFileHeader}
    echo 'csvJQparsevalue         = '${csvJQparsevalue}
    echo
    echo
    
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
    
    echo 'readcsvfileheader       = '${readcsvfileheader}
    echo 'readcsvJQparsevalue     = '${readcsvJQparsevalue}
    echo
    
    export APIobjectminversion=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."api-version"' -r`
    export APICLIobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."objectype"' -r`
    export APICLIobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."objectsype"' -r`
    export APICLICSVobjecttype=${APICLIobjectstype}
    export APICLIcomplexobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."complexobjecttype"' -r`
    export APICLIcomplexobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."complexobjectstype"' -r`
    
    export WorkAPIObjectLimit=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."objectlimit"' -r`
    export APICLIobjectsortparms=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."sortparms"' -r`
    export APICLIobjectgroup=`cat "${exobdeffilepath}" | ${JQ16} '.complex_object_members[] | select(."name"=="'"$whichname"'") | ."objectgroup"' -r`
    
    echo 'APIobjectminversion     = '${APIobjectminversion}
    echo 'APICLIobjecttype        = '${APICLIobjecttype}
    echo 'APICLIobjectstype       = '${APICLIobjectstype}
    echo 'APICLICSVobjecttype     = '${APICLICSVobjecttype}
    echo 'APICLIcomplexobjecttype = '${APICLIcomplexobjecttype}
    echo 'APICLIcomplexobjectstype= '${APICLIcomplexobjectstype}
    echo 'WorkAPIObjectLimit      = '${WorkAPIObjectLimit}
    echo 'APICLIobjectsortparms   = '${APICLIobjectsortparms}
    echo 'APICLIobjectgroup       = '${APICLIobjectgroup}
    echo
    echo 'CSVFileHeader           = '${CSVFileHeader}
    echo 'csvJQparsevalue         = '${csvJQparsevalue}
    echo
    echo
    
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
    
    echo 'readcsvfileheader       = '${readcsvfileheader}
    echo 'readcsvJQparsevalue     = '${readcsvJQparsevalue}
    echo
    
    export APIobjectminversion=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."api-version"' -r`
    export APICLIobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."objectype"' -r`
    export APICLIobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."objectsype"' -r`
    export APICLICSVobjecttype=${APICLIobjectstype}
    export APICLIcomplexobjecttype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."complexobjecttype"' -r`
    export APICLIcomplexobjectstype=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."complexobjectstype"' -r`
    
    export WorkAPIObjectLimit=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."objectlimit"' -r`
    export APICLIobjectsortparms=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."sortparms"' -r`
    export APICLIobjectgroup=`cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | select(."name"=="'"$whichname"'") | ."objectgroup"' -r`
    
    echo 'APIobjectminversion     = '${APIobjectminversion}
    echo 'APICLIobjecttype        = '${APICLIobjecttype}
    echo 'APICLIobjectstype       = '${APICLIobjectstype}
    echo 'APICLICSVobjecttype     = '${APICLICSVobjecttype}
    echo 'APICLIcomplexobjecttype = '${APICLIcomplexobjecttype}
    echo 'APICLIcomplexobjectstype= '${APICLIcomplexobjectstype}
    echo 'WorkAPIObjectLimit      = '${WorkAPIObjectLimit}
    echo 'APICLIobjectsortparms   = '${APICLIobjectsortparms}
    echo 'APICLIobjectgroup       = '${APICLIobjectgroup}
    echo
    echo 'CSVFileHeader           = '${CSVFileHeader}
    echo 'csvJQparsevalue         = '${csvJQparsevalue}
    echo
    echo
    
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
#echo

set_default_csv_export_elements "${elementname}"

export elementname=name-only

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo

set_default_csv_export_elements "${elementname}"

export elementname=name-and-uid

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo

set_default_csv_export_elements "${elementname}"

export elementname=uid-only

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo

set_default_csv_export_elements "${elementname}"

export elementname=tags05

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo

set_default_csv_export_elements "${elementname}"

export elementname=tags10

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo

set_default_csv_export_elements "${elementname}"

export elementname=domain

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo

set_default_csv_export_elements "${elementname}"

export elementname=meta-info

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo

set_default_csv_export_elements "${elementname}"

export elementname=errorhandling

#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVFileHeader"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.default_csv_export_elements[] | select(."name"=="'"${elementname}"'") | ."CSVJQparms"' -r
#echo

set_default_csv_export_elements "${elementname}"

echo '-------------------------------------------------------------------------------------------------'
echo '-------------------------------------------------------------------------------------------------'


export keepercsvfileheader=${CSVFileHeader}
export keepercsvJQparsevalue=${csvJQparsevalue}


echo '-------------------------------------------------------------------------------------------------'
echo '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_simplexobjects_csv_export_elements "host"

echo '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_simplexobjects_csv_export_elements "network"

echo '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_simplexobjects_csv_export_elements "group"

echo '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_simplexobjects_csv_export_elements "service TCP"

echo '-------------------------------------------------------------------------------------------------'


echo '-------------------------------------------------------------------------------------------------'
echo '-------------------------------------------------------------------------------------------------'


echo '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_complexobjectmembers_csv_export_elements "user group member"

echo '-------------------------------------------------------------------------------------------------'


echo '-------------------------------------------------------------------------------------------------'
echo '-------------------------------------------------------------------------------------------------'


echo '-------------------------------------------------------------------------------------------------'

export CSVFileHeader=${keepercsvfileheader}
export csvJQparsevalue=${keepercsvJQparsevalue}

set_complexobjects_csv_export_elements "host interface"

echo '-------------------------------------------------------------------------------------------------'


echo '-------------------------------------------------------------------------------------------------'
echo '-------------------------------------------------------------------------------------------------'


#cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | ."name"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | ."name"' -c
cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | ."name"'
echo

echo '-------------------------------------------------------------------------------------------------'

cat "${exobdeffilepath}" | ${JQ16} '.simplex_objects[] | "\"" + .name + "\","' -j
echo

echo '-------------------------------------------------------------------------------------------------'
echo '-------------------------------------------------------------------------------------------------'

#cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | ."name"' -r
#cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | ."name"' -c
cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | ."name"'
echo

echo '-------------------------------------------------------------------------------------------------'

cat "${exobdeffilepath}" | ${JQ16} '.complex_objects[] | "\"" + .name + "\","' -j
echo

echo '-------------------------------------------------------------------------------------------------'


