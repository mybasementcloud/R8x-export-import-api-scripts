#!/bin/bash
#
# SCRIPT Object dump to CSV action operations for API CLI Operations
#
ScriptVersion=00.17.25
ScriptDate=2017-01-04
#

ScriptName=cli_api_export_objects_actions_to_csv_$APIScriptVersion

# =================================================================================================
# START:  Export objects to csv
# =================================================================================================


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
# networks
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=networks
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"broadcast","subnet4","mask-length4","subnet6","mask-length6"'
export CSVFileHeader=$CSVFileHeader',"nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.method"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["broadcast"], .["subnet4"], .["mask-length4"], .["subnet6"], .["mask-length6"]'
export CSVJQparms=$CSVJQparms', .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"], .["nat-settings"]["method"]'

#echo '"name","color","comments","broadcast","subnet4","mask-length4","subnet6","mask-length6","nat-settings.auto-rule","nat-settings.hide-behind","nat-settings.install-on","nat-settings.method"' > $APICLICSVfileheader

#mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile | $JQ '.objects[] | [ .["name"], .["color"], .["comments"], .["broadcast"], .["subnet4"], .["mask-length4"], .["subnet6"], .["mask-length6"], .["nat-settings"]["auto-rule"], .["nat-settings"]["hide-behind"], .["nat-settings"]["install-on"], .["nat-settings"]["method"] ] | @csv' -r >> $APICLICSVfile.data

ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# groups
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=groups
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'

export CSVJQparms='.["name"], .["color"], .["comments"]'


#echo '"name","color","comments"' > $APICLICSVfileheader

#mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile | $JQ '.objects[] | [ .["name"], .["color"], .["comments"] ] | @csv' -r >> $APICLICSVfile.data
    
ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# groups-with-exclusion
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=groups-with-exclusion
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"include","except"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["include"]["name"], .["except"]["name"]'

#echo '"name","color","comments","include","except"' > $APICLICSVfileheader

#mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile | $JQ '.objects[] | [ .["name"], .["color"], .["comments"], .["include"]["name"], .["except"]["name"] ] | @csv' -r >> $APICLICSVfile.data

    
ExportObjectsToCSVviaJQ



# -------------------------------------------------------------------------------------------------
# address-ranges
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=address-ranges
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"ipv4-address-first","ipv4-address-last"'
export CSVFileHeader=$CSVFileHeader',"ipv6-address-first","ipv6-address-last"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["ipv4-address-first"], .["ipv4-address-last"]'
export CSVJQparms=$CSVJQparms', .["ipv6-address-first"], .["ipv6-address-last"]'

#echo '"name","color","comments","ipv4-address-first","ipv4-address-last","ipv6-address-first","ipv6-address-last"' > $APICLICSVfileheader

#mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile | $JQ '.objects[] | [ .["name"], .["color"], .["comments"], .["ipv4-address-first"], .["ipv4-address-last"], .["ipv6-address-first"], .["ipv6-address-last"] ] | @csv' -r >> $APICLICSVfile.data
    
ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# dns-domains
# -------------------------------------------------------------------------------------------------

echo
export APICLIobjecttype=dns-domains
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,1'

export CSVFileHeader='"name","color","comments"'
export CSVFileHeader=$CSVFileHeader',"is-sub-domain"'

export CSVJQparms='.["name"], .["color"], .["comments"]'
export CSVJQparms=$CSVJQparms', .["is-sub-domain"]'

#echo '"name","color","comments","is-sub-domain"' > $APICLICSVfileheader

#mgmt_cli show $APICLIobjecttype limit $APICLIObjectLimit offset 0 details-level "$APICLIdetaillvl" --format json -s $APICLIsessionfile | $JQ '.objects[] | [ .["name"], .["color"], .["comments"], .["is-sub-domain"] ] | @csv' -r >> $APICLICSVfile.data
    
ExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# group members
# -------------------------------------------------------------------------------------------------

export APICLIobjecttype=group-members
#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLICSVsortparms='-f -t , -k 1,2'

export CSVFileHeader='"name","members.add"'

#echo 'name,members.add' > $APICLICSVfileheader

SetupExportObjectsToCSVviaJQ

#
# APICLICSVsortparms can change due to the nature of the object
#
export APICLIobjecttype=groups

echo
echo 'Generate array of groups'
echo

# MGMT_CLI_OUTPUT is a string with multiple lines. Each line contains a name of a group members.
# in this example the output of mgmt_cli is not sent to a file, instead it is passed to jq directly using a pipe.

MGMT_CLI_OUTPUT="`mgmt_cli show groups details-level full limit $APICLIObjectLimit -s $APICLIsessionfile --format json | $JQ ".objects[].name | @sh" -r`"

# break the string into an array - each element of the array is a line in the original string
# there are simpler ways, but this way allows the names to contain spaces. Gaia's bash version is 3.x so readarray is not available

ARR=()
while read -r line; do
    ARR+=("$line")
    echo -n '.'
done <<< "$MGMT_CLI_OUTPUT"
echo

# print the elements in the array
echo
echo Groups
echo

for i in "${ARR[@]}"
do
    echo "$i, ${i//\'/}"
done

 

#
# using bash variables in a jq expression
#

echo
echo 'Use array of groups to generate group members CSV'
echo

for i in "${ARR[@]}"
do
    echo
    echo Group "${i//\'/}"

    MEMBERS_COUNT=$(mgmt_cli show group name "${i//\'/}" -s id.txt --format json | $JQ ".members | length")

    echo "number of members in the group ${i//\'/} : $MEMBERS_COUNT"

    COUNTER=0
    
    while [ $COUNTER -lt $MEMBERS_COUNT ]; do

       MEMBER_NAME=$(mgmt_cli show group name ${i//\'/} -s $APICLIsessionfile --format json | $JQ ".members[$COUNTER].name")

       echo -n '.'
       echo ${i//\'/},$MEMBER_NAME >> $APICLICSVfile.data

       let COUNTER=COUNTER+1

    done

done


FinalizeExportObjectsToCSVviaJQ


# -------------------------------------------------------------------------------------------------
# no more objects
# -------------------------------------------------------------------------------------------------

echo
echo $APICLIdetaillvl' CSV dump - Completed!'
echo

echo
echo

# =================================================================================================
# END:  Export objects to csv
# =================================================================================================


