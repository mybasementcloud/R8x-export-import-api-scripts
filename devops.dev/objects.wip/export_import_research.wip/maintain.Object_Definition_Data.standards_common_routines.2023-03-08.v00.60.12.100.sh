#!/bin/bash
#
# (C) 2016-2023 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
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
# SCRIPT Maintain :  Object Definition Data:  Standards, Common Routines
#
#
ScriptVersion=00.60.12
ScriptRevision=100
ScriptSubRevision=750
ScriptDate=2023-03-14
TemplateVersion=00.60.12
APISubscriptsLevel=010
APISubscriptsVersion=00.60.12
APISubscriptsRevision=100


#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#
# Concept, Algorithm, Approach
#
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#
# Object Definition Data:  Standards
#
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


# +-------------------------------------------------------------------------------------------------
# | Simple Object :  Standard Simple objects
# +-------------------------------------------------------------------------------------------------

#ClearObjectDefinitionData

#export APICLIobjecttype='<object_type_singular>'
#export APICLIobjectstype='<object_type_plural>'
#export APIobjectminversion='<object_type_api_version>'
#export APIobjectexportisCPI=false

#export APIobjectspecifickey=

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#export APIobjectjsonrepofileobject=${APICLIobjectstype}
#export APICLICSVobjecttype=${APICLIobjectstype}

#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

#export APIobjectdoexport=true
#export APIobjectdoexportJSON=true
#export APIobjectdoexportCSV=true
#export APIobjectdoimport=true
#export APIobjectdorename=true
#export APIobjectdoupdate=true
#export APIobjectdodelete=true

#export APIobjectusesdetailslevel=true
#export APIobjectcanignorewarning=true
#export APIobjectcanignoreerror=true
#export APIobjectcansetifexists=true
#export APIobjectderefgrpmem=false
#export APIobjecttypehasname=true
#export APIobjecttypehasuid=true
#export APIobjecttypehasdomain=true
#export APIobjecttypehastags=true
#export APIobjecttypehasmeta=true
#export APIobjecttypeimportname=true

#export APIobjectCSVFileHeaderAbsoluteBase=false
#export APIobjectCSVJQparmsAbsoluteBase=false

#export APIobjectCSVexportWIP=false

#CheckAPIVersionAndExecuteOperation


# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------


#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/------------------------------------------------------------------------------------------------------------------------------------------------------------\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/




#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/------------------------------------------------------------------------------------------------------------------------------------------------------------\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/




#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/------------------------------------------------------------------------------------------------------------------------------------------------------------\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/




#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/------------------------------------------------------------------------------------------------------------------------------------------------------------\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

# +-------------------------------------------------------------------------------------------------
# | Complex Object : Specific Complex OBJECT : 
# |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
# |  - Reference Details and initial object
# +-------------------------------------------------------------------------------------------------

#export APICLIobjecttype=<object_type_singular>
#export APICLIobjectstype=<object_type_plural>
#export APICLIcomplexobjecttype=<complex_object_type_singular>
#export APICLIcomplexobjectstype=<complex_object_type_plural>
#export APIobjectminversion=<object_type_api_version>|example:  1.1
#export APIobjectexportisCPI=false|true

#export APIGenObjectTypes=<Generic-Object-Type>|example:  generic-objects
#export APIGenObjectClassField=<Generic-Object-ClassField>|example:  class-name
#export APIGenObjectClass=<Generic-Object-Class>|example:  "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
#export APIGenObjectClassShort=<Generic-Object-Class-Short>|example:  "appfw.CpmiUserApplication"
#export APIGenObjectField=<Generic-Object-Key-Field>|example:  uid

#export APIGenObjobjecttype=<Generic-Object-Type>|example:  appfw_CpmiUserApplication_application-site
#export APIGenObjobjectstype=<Generic-Objects-Type-plural>|example:  appfw_CpmiUserApplication_application-sites
#export APIGenObjcomplexobjecttype=<Generic-Complex-Object-Type>|example:  appfw_CpmiUserApplication_application-site
#export APIGenObjcomplexobjectstype=<Generic-Complex-Objects-Type-plural>|example:  appfw_CpmiUserApplication_application-sites
#export APIGenObjobjectkey=name
#export APIGenObjobjectkeydetailslevel=standard

#export APIobjectspecifickey='url-list'

#export APIobjectspecificselector00key=
#export APIobjectspecificselector00value=
#export APICLIexportnameaddon=

#export APICLIexportcriteria01key=
#export APICLIexportcriteria01value=

#export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
#export APICLICSVobjecttype=${APICLIobjectstype}
#export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
#export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
#export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
#export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}
#
#export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
#export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}

#export APIobjectdoexport=true
#export APIobjectdoexportJSON=true
#export APIobjectdoexportCSV=true
#export APIobjectdoimport=true
#export APIobjectdorename=true
#export APIobjectdoupdate=true
#export APIobjectdodelete=true

#export APIobjectusesdetailslevel=true
#export APIobjectcanignorewarning=true
#export APIobjectcanignoreerror=true
#export APIobjectcansetifexists=false
#export APIobjectderefgrpmem=false
#export APIobjecttypehasname=true
#export APIobjecttypehasuid=true
#export APIobjecttypehasdomain=true
#export APIobjecttypehastags=true
#export APIobjecttypehasmeta=true
#export APIobjecttypeimportname=true

#export APIobjectCSVFileHeaderAbsoluteBase=false
#export APIobjectCSVJQparmsAbsoluteBase=false

#export APIobjectCSVexportWIP=false

#export AugmentExportedFields=false

#if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
    #export AugmentExportedFields=true
#elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
    #export AugmentExportedFields=true
#elif ${OnlySystemObjects} ; then
    #export AugmentExportedFields=true
#else
    #export AugmentExportedFields=false
#fi

#if ! ${AugmentExportedFields} ; then
    #export APICLIexportnameaddon=
#else
    #export APICLIexportnameaddon=FOR_REFERENCE_ONLY
#fi

##
## APICLICSVsortparms can change due to the nature of the object
##
#export APICLICSVsortparms='-f -t , -k 1,1'

#export CSVFileHeader=
#if ! ${AugmentExportedFields} ; then
    #export CSVFileHeader='"primary-category"'
    ## The risk key is not imported
    ##export CSVFileHeader=${CSVFileHeader}',"risk"'
#else
    #export CSVFileHeader='"application-id","primary-category"'
    ## The risk key is not imported
    ##export CSVFileHeader=${CSVFileHeader}',"risk"'
#fi
##export CSVFileHeader=
##export CSVFileHeader='"key","key"'
##export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
##export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
##export CSVFileHeader=${CSVFileHeader}',"icon"'

#export CSVJQparms=
#if ! ${AugmentExportedFields} ; then
    #export CSVJQparms='.["primary-category"]'
    ## The risk key is not imported
    ##export CSVJQparms=${CSVJQparms}', .["risk"]'
#else
    #export CSVJQparms='.["application-id"], .["primary-category"]'
    ## The risk key is not imported
    #export CSVJQparms=${CSVJQparms}', .["risk"]'
#fi
##export CSVJQparms=
##export CSVJQparms='.["value"], .["value"]'
##export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
##export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
##export CSVJQparms=${CSVJQparms}', .["icon"]'

# +-------------------------------------------------------------------------------------------------
# +-------------------------------------------------------------------------------------------------

#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#
# Object Definition Data:  Common Routines
#
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

# -------------------------------------------------------------------------------------------------
# ClearObjectDefinitionData
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The ClearObjectDefinitionData clear the data associated with objects to zero and start clean.
#

ClearObjectDefinitionData () {
    
    #
    # Maximum Object defined
    #
    
    # +-------------------------------------------------------------------------------------------------
    # | Complex Object : Specific Complex OBJECT : 
    # |  - Custom User Objects via :  generic-objects class-name "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
    # |  - Reference Details and initial object
    # +-------------------------------------------------------------------------------------------------
    
    #export APICLIobjecttype=<object_type_singular>
    #export APICLIobjectstype=<object_type_plural>
    #export APICLIcomplexobjecttype=<complex_object_type_singular>
    #export APICLIcomplexobjectstype=<complex_object_type_plural>
    #export APIobjectminversion=<object_type_api_version>|example:  1.1
    #export APIobjectexportisCPI=false|true
    
    #export APIGenObjectTypes=<Generic-Object-Type>|example:  generic-objects
    #export APIGenObjectClassField=<Generic-Object-ClassField>|example:  class-name
    #export APIGenObjectClass=<Generic-Object-Class>|example:  "com.checkpoint.objects.appfw.dummy.CpmiUserApplication"
    #export APIGenObjectClassShort=<Generic-Object-Class-Short>|example:  "appfw.CpmiUserApplication"
    #export APIGenObjectField=<Generic-Object-Key-Field>|example:  uid
    
    #export APIGenObjobjecttype=<Generic-Object-Type>|example:  appfw_CpmiUserApplication_application-site
    #export APIGenObjobjectstype=<Generic-Objects-Type-plural>|example:  appfw_CpmiUserApplication_application-sites
    #export APIGenObjcomplexobjecttype=<Generic-Complex-Object-Type>|example:  appfw_CpmiUserApplication_application-site
    #export APIGenObjcomplexobjectstype=<Generic-Complex-Objects-Type-plural>|example:  appfw_CpmiUserApplication_application-sites
    #export APIGenObjobjectkey=name
    #export APIGenObjobjectkeydetailslevel=standard
    
    #export APIobjectspecifickey='url-list'
    
    #export APIobjectspecificselector00key=
    #export APIobjectspecificselector00value=
    #export APICLIexportnameaddon=
    
    #export APICLIexportcriteria01key=
    #export APICLIexportcriteria01value=
    
    #export APIobjectjsonrepofileobject=${APICLIcomplexobjectstype}
    #export APICLICSVobjecttype=${APICLIobjectstype}
    #export APIGenObjjsonrepofileobject=${APIGenObjobjectstype}
    #export APIGenObjcomplexjsonrepofileobject=${APIGenObjcomplexobjectstype}
    #export APIGenObjCSVobjecttype=${APIGenObjobjectstype}
    #export APIGenObjcomplexCSVobjecttype=${APIGenObjcomplexobjectstype}
    #
    #export APIobjectrecommendedlimit=${DefaultAPIObjectLimit}
    #export APIobjectrecommendedlimitMDSM=${DefaultAPIObjectLimitMDSM}
    
    #export APIobjectdoexport=true
    #export APIobjectdoexportJSON=true
    #export APIobjectdoexportCSV=true
    #export APIobjectdoimport=true
    #export APIobjectdorename=true
    #export APIobjectdoupdate=true
    #export APIobjectdodelete=true
    
    #export APIobjectusesdetailslevel=true
    #export APIobjectcanignorewarning=true
    #export APIobjectcanignoreerror=true
    #export APIobjectcansetifexists=false
    #export APIobjectderefgrpmem=false
    #export APIobjecttypehasname=true
    #export APIobjecttypehasuid=true
    #export APIobjecttypehasdomain=true
    #export APIobjecttypehastags=true
    #export APIobjecttypehasmeta=true
    #export APIobjecttypeimportname=true
    
    #export APIobjectCSVFileHeaderAbsoluteBase=false
    #export APIobjectCSVJQparmsAbsoluteBase=false
    
    #export APIobjectCSVexportWIP=false
    
    #export AugmentExportedFields=false
    
    #if ${CLIparm_CSVEXPORTDATADOMAIN} ; then
        #export AugmentExportedFields=true
    #elif ${CLIparm_CSVEXPORTDATACREATOR} ; then
        #export AugmentExportedFields=true
    #elif ${OnlySystemObjects} ; then
        #export AugmentExportedFields=true
    #else
        #export AugmentExportedFields=false
    #fi
    
    #if ! ${AugmentExportedFields} ; then
        #export APICLIexportnameaddon=
    #else
        #export APICLIexportnameaddon=FOR_REFERENCE_ONLY
    #fi
    
    ##
    ## APICLICSVsortparms can change due to the nature of the object
    ##
    #export APICLICSVsortparms='-f -t , -k 1,1'
    
    #export CSVFileHeader=
    #if ! ${AugmentExportedFields} ; then
        #export CSVFileHeader='"primary-category"'
        ## The risk key is not imported
        ##export CSVFileHeader=${CSVFileHeader}',"risk"'
    #else
        #export CSVFileHeader='"application-id","primary-category"'
        ## The risk key is not imported
        ##export CSVFileHeader=${CSVFileHeader}',"risk"'
    #fi
    ##export CSVFileHeader=
    ##export CSVFileHeader='"key","key"'
    ##export CSVFileHeader=${CSVFileHeader}',"key","key","key","key"'
    ##export CSVFileHeader=${CSVFileHeader}',"key.subkey","key.subkey","key.subkey","key.subkey"'
    ##export CSVFileHeader=${CSVFileHeader}',"icon"'
    
    #export CSVJQparms=
    #if ! ${AugmentExportedFields} ; then
        #export CSVJQparms='.["primary-category"]'
        ## The risk key is not imported
        ##export CSVJQparms=${CSVJQparms}', .["risk"]'
    #else
        #export CSVJQparms='.["application-id"], .["primary-category"]'
        ## The risk key is not imported
        #export CSVJQparms=${CSVJQparms}', .["risk"]'
    #fi
    ##export CSVJQparms=
    ##export CSVJQparms='.["value"], .["value"]'
    ##export CSVJQparms=${CSVJQparms}', .["value"], .["value"], .["value"], .["value"]'
    ##export CSVJQparms=${CSVJQparms}', .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"], .["value"]["subvalue"]'
    ##export CSVJQparms=${CSVJQparms}', .["icon"]'
    
    # +-------------------------------------------------------------------------------------------------
    # +-------------------------------------------------------------------------------------------------
    
    export APICLIobjecttype=
    export APICLIobjectstype=
    export APICLIcomplexobjecttype=
    export APICLIcomplexobjectstype=
    export APIobjectminversion=
    export APIobjectexportisCPI=
    
    export APIGenObjectTypes=
    export APIGenObjectClassField=
    export APIGenObjectClass=
    export APIGenObjectClassShort=
    export APIGenObjectField=
    
    export APIGenObjobjecttype=
    export APIGenObjobjectstype=
    export APIGenObjcomplexobjecttype=
    export APIGenObjcomplexobjectstype=
    export APIGenObjjsonrepofileobject=
    export APIGenObjcomplexjsonrepofileobject=
    export APIGenObjCSVobjecttype=
    export APIGenObjcomplexCSVobjecttype=
    export APIGenObjobjectkey=
    export APIGenObjobjectkeydetailslevel=
    
    export APIobjectspecifickey=
    
    export APIobjectspecificselector00key=
    export APIobjectspecificselector00value=
    export APICLIexportnameaddon=
    
    export APICLIexportcriteria01key=
    export APICLIexportcriteria01value=
    
    export APIobjectjsonrepofileobject=
    export APICLICSVobjecttype=
    export APIobjectrecommendedlimit=
    export APIobjectrecommendedlimitMDSM=
    
    export APIobjectdoexport=
    export APIobjectdoexportJSON=
    export APIobjectdoexportCSV=
    export APIobjectdoimport=
    export APIobjectdorename=
    export APIobjectdoupdate=
    export APIobjectdodelete=
    
    export APIobjectusesdetailslevel=
    export APIobjectcanignorewarning=
    export APIobjectcanignoreerror=
    export APIobjectcansetifexists=
    export APIobjectderefgrpmem=
    export APIobjecttypehasname=
    export APIobjecttypehasuid=
    export APIobjecttypehasdomain=
    export APIobjecttypehastags=
    export APIobjecttypehasmeta=
    export APIobjecttypeimportname=
    
    export APIobjectCSVFileHeaderAbsoluteBase=
    export APIobjectCSVJQparmsAbsoluteBase=
    
    export APIobjectCSVexportWIP=
    
    export AugmentExportedFields=
    
    export CSVFileHeader=
    export CSVJQparms=
    
    # +-------------------------------------------------------------------------------------------------
    # +-------------------------------------------------------------------------------------------------
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-08:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/------------------------------------------------------------------------------------------------------------------------------------------------------------\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

# -------------------------------------------------------------------------------------------------
# DumpObjectDefinitionData
# -------------------------------------------------------------------------------------------------

# MODIFIED 2023-03-08:01 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# The DumpObjectDefinitionData dump the content of the current object definition data to terminal and/or log.
#

DumpObjectDefinitionData () {
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    
    if ${APISCRIPTVERBOSE} ; then
        echo `${dtzs}`${dtzsep} 'Object Definition Data details - show and log' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AAA' "${AAA}" | tee -a -i ${logfilepath}
        #
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjecttype' "${APICLIobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjectstype' "${APICLIobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjecttype' "${APICLIcomplexobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjectstype' "${APICLIcomplexobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectminversion' "${APIobjectminversion}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectexportisCPI' "${APIobjectexportisCPI}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectTypes' "${APIGenObjectTypes}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassField' "${APIGenObjectClassField}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClass' "${APIGenObjectClass}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassShort' "${APIGenObjectClassShort}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectField' "${APIGenObjectField}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjecttype' "${APIGenObjobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjecttype' "${APIGenObjcomplexobjecttype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjectstype' "${APIGenObjcomplexobjectstype}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjjsonrepofileobject' "${APIGenObjjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexjsonrepofileobject' "${APIGenObjcomplexjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjCSVobjecttype' "${APIGenObjCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexCSVobjecttype' "${APIGenObjcomplexCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkey' "${APIGenObjobjectkey}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkeydetailslevel' "${APIGenObjobjectkeydetailslevel}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecifickey' "${APIobjectspecifickey}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00key' "${APIobjectspecificselector00key}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00value' "${APIobjectspecificselector00value}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportnameaddon' "${APICLIexportnameaddon}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01key' "${APICLIexportcriteria01key}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01value' "${APICLIexportcriteria01value}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVobjecttype' "${APICLICSVobjecttype}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimit' "${APIobjectrecommendedlimit}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimitMDSM' "${APIobjectrecommendedlimitMDSM}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexport' "${APIobjectdoexport}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportJSON' "${APIobjectdoexportJSON}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportCSV' "${APIobjectdoexportCSV}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoimport' "${APIobjectdoimport}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdorename' "${APIobjectdorename}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoupdate' "${APIobjectdoupdate}" | tee -a -i ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdodelete' "${APIobjectdodelete}" | tee -a -i ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectusesdetailslevel' "${APIobjectusesdetailslevel}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignorewarning' "${APIobjectcanignorewarning}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignoreerror' "${APIobjectcanignoreerror}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcansetifexists' "${APIobjectcansetifexists}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectderefgrpmem' "${APIobjectderefgrpmem}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasname' "${APIobjecttypehasname}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasuid' "${APIobjecttypehasuid}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasdomain' "${APIobjecttypehasdomain}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehastags' "${APIobjecttypehastags}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasmeta' "${APIobjecttypehasmeta}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypeimportname' "${APIobjecttypeimportname}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVFileHeaderAbsoluteBase' "${APIobjectCSVFileHeaderAbsoluteBase}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVJQparmsAbsoluteBase' "${APIobjectCSVJQparmsAbsoluteBase}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVexportWIP' "${APIobjectCSVexportWIP}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AugmentExportedFields' "${AugmentExportedFields}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVFileHeader' "${CSVFileHeader}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVJQparms' "${CSVJQparms}" >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
    else
        echo `${dtzs}`${dtzsep} 'Object Definition Data details - dump to log' | tee -a -i ${logfilepath}
        echo `${dtzs}`${dtzsep} >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
        #printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AAA' "${AAA}" >> ${logfilepath}
        #
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjecttype' "${APICLIobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIobjectstype' "${APICLIobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjecttype' "${APICLIcomplexobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIcomplexobjectstype' "${APICLIcomplexobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectminversion' "${APIobjectminversion}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectexportisCPI' "${APIobjectexportisCPI}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectTypes' "${APIGenObjectTypes}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassField' "${APIGenObjectClassField}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClass' "${APIGenObjectClass}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectClassShort' "${APIGenObjectClassShort}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjectField' "${APIGenObjectField}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjecttype' "${APIGenObjobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectstype' "${APIGenObjobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjecttype' "${APIGenObjcomplexobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexobjectstype' "${APIGenObjcomplexobjectstype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjjsonrepofileobject' "${APIGenObjjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexjsonrepofileobject' "${APIGenObjcomplexjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjCSVobjecttype' "${APIGenObjCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjcomplexCSVobjecttype' "${APIGenObjcomplexCSVobjecttype}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkey' "${APIGenObjobjectkey}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIGenObjobjectkeydetailslevel' "${APIGenObjobjectkeydetailslevel}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecifickey' "${APIobjectspecifickey}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00key' "${APIobjectspecificselector00key}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectspecificselector00value' "${APIobjectspecificselector00value}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportnameaddon' "${APICLIexportnameaddon}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01key' "${APICLIexportcriteria01key}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLIexportcriteria01value' "${APICLIexportcriteria01value}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectjsonrepofileobject' "${APIobjectjsonrepofileobject}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APICLICSVobjecttype' "${APICLICSVobjecttype}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimit' "${APIobjectrecommendedlimit}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectrecommendedlimitMDSM' "${APIobjectrecommendedlimitMDSM}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexport' "${APIobjectdoexport}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportJSON' "${APIobjectdoexportJSON}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoexportCSV' "${APIobjectdoexportCSV}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoimport' "${APIobjectdoimport}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdorename' "${APIobjectdorename}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdoupdate' "${APIobjectdoupdate}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectdodelete' "${APIobjectdodelete}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectusesdetailslevel' "${APIobjectusesdetailslevel}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignorewarning' "${APIobjectcanignorewarning}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcanignoreerror' "${APIobjectcanignoreerror}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectcansetifexists' "${APIobjectcansetifexists}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectderefgrpmem' "${APIobjectderefgrpmem}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasname' "${APIobjecttypehasname}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasuid' "${APIobjecttypehasuid}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasdomain' "${APIobjecttypehasdomain}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehastags' "${APIobjecttypehastags}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypehasmeta' "${APIobjecttypehasmeta}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjecttypeimportname' "${APIobjecttypeimportname}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVFileHeaderAbsoluteBase' "${APIobjectCSVFileHeaderAbsoluteBase}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVJQparmsAbsoluteBase' "${APIobjectCSVJQparmsAbsoluteBase}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'APIobjectCSVexportWIP' "${APIobjectCSVexportWIP}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'AugmentExportedFields' "${AugmentExportedFields}" >> ${logfilepath}
        
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVFileHeader' "${CSVFileHeader}" >> ${logfilepath}
        printf "`${dtzs}`${dtzsep}%-40s = %s\n" 'CSVJQparms' "${CSVJQparms}" >> ${logfilepath}
        
        # +-------------------------------------------------------------------------------------------------
        # +-------------------------------------------------------------------------------------------------
        
    fi
    
    echo `${dtzs}`${dtzsep} '-------------------------------------------------------------------------------' | tee -a -i ${logfilepath}
    echo `${dtzs}`${dtzsep} | tee -a -i ${logfilepath}
    
    return 0
    
    #
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ - MODIFIED 2023-03-08:01


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/------------------------------------------------------------------------------------------------------------------------------------------------------------\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

