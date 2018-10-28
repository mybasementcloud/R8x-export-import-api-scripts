


\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


# ADDED 2018-09-21 -
export gaia_version_handler_root=.
export gaia_version_handler_folder=common
export gaia_version_handler_file=identify_gaia_and_installation.action.common.005.v$ScriptVersion.sh


\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


# -------------------------------------------------------------------------------------------------
# GetGaiaVersionAndInstallationType - Gaia version and installation type Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetGaiaVersionAndInstallationType () {
    #
    # GetGaiaVersionAndInstallationType - Gaia version and installation type Handler calling routine
    #
    
    echo | tee -a -i $APICLIlogfilepath
    echo '--------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Calling external Gaia version and installation type Handling Script" | tee -a -i $APICLIlogfilepath
    echo " - External Script : "$gaia_version_handler | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    . $gaia_version_handler "$@"
    
    echo | tee -a -i $APICLIlogfilepath
    echo "Returned from external Gaia version and installation type Handling Script" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
    if [ "$APISCRIPTVERBOSE" = "true" ] && [ "$NOWAIT" != "true" ] ; then
        echo
        read -t $WAITTIME -n 1 -p "Any key to continue.  Automatic continue after $WAITTIME seconds : " anykey
    fi
    
    echo | tee -a -i $APICLIlogfilepath
    echo "Continueing local execution" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo '--------------------------------------------------------------------------' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-09-21

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call Gaia version and installation type Handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-21 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export gaia_version_handler_path=$gaia_version_handler_root/$gaia_version_handler_folder

export gaia_version_handler=$gaia_version_handler_path/$gaia_version_handler_file

# Check that we can finde the command line parameter handler file
#
if [ ! -r $gaia_version_handler ] ; then
    # no file found, that is a problem
    echo | tee -a -i $APICLIlogfilepath
    echo ' Gaia version and installation type handler script file missing' | tee -a -i $APICLIlogfilepath
    echo '  File not found : '$gaia_version_handler | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Other parameter elements : ' | tee -a -i $APICLIlogfilepath
    echo '  Root of folder path : '$gaia_version_handler_root | tee -a -i $APICLIlogfilepath
    echo '  Folder in Root path : '$gaia_version_handler_folder | tee -a -i $APICLIlogfilepath
    echo '  Folder Root path    : '$gaia_version_handler_path | tee -a -i $APICLIlogfilepath
    echo '  Script Filename     : '$gaia_version_handler_file | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 251
fi

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-09-21

GetGaiaVersionAndInstallationType "$@"


\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


