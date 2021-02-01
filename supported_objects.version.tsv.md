supported_objects.version.tsv - Overview

This document provides an overview of the content approach for the "supported_objects.version.tsv" file provided (example:  "supported_objects.v00.60.01.020.tsv").

The provided TSV (Tab Separated Values) file is listing of the supported objects for export, import, set or update, and delete operations and shows the API objects and their respective supported state.

For some columns there are caveats (e.g. !) which are described at the end of the document

The columns contents are as follows:

- version :  
    This is whether the object (OBJECT) is included in this version release or not (true or false).  
        True indicates it is included in this version
        False indicates it is not included in this version

- OBJECT HANDLER :  
    This is the code type of handler for that object, for purposes of indicating code re-use operations and simplification of the scripts

- OBJECT GROUP :  
    This is the high level API objects group from the Check Point Management API Reference

- OBJECT :  
    This is the specific object type, in plural form, as handled by the scripts.  Plural is used, since the general show command for listing all objects of that type is via the plural of the object type.  Some are custom object types created to handle an objects elements, like a group's group members.

- Recommended Limit :  
    This is the recommended limit value for the number of objects to process in a specific export operation.  This value will be refined and may get more specific details, like values for MDSM object limits, since there are issues with large object in high volume queries due to imposed limitations in R81 (e.g. application-site object)

- Minimum Version :  
    This is the minimum version of the API that is required to operate on the Check Point Management host to utilize the specific object type.  Scripts are writen to identify and handle only those object types that are available to that Management Host's API version installed.  Provisions to specifically indicate operational API version during execution are not present, so the specific Management Host's installed release version API version level is used, and this API version level is subject to modification by Jumbo HotFix installation.

     NOTE:  scripts are generally written using the latest release version, and specific nuances of API version level implementation are not currently adjusted for in downlevel application.  Problems should be raised to the author.

- Supports set-if-exists :  
    Does the object type support the error handling operation "set-if-exists" (true/false)?

- CSV Details :  
    Does the object type have additional object elements available via the API exported to CSV, beyond just name, color, and comments

    - True indicates there are additional or the complete usable (and importable elements) are provided.  This may have caveats based on version and plausibility or testing of specific elements.
    - False indicates that only the common object elements are current exported to CSV.  This may have caveats based on complexity, plausibility, or testing of specific elements.

- Objects JSON ("export_objects_definition.json") :  
    Does the Object type have a definition entry in the Objects JSON files for future external control and steering of the Export Import scripts.  This entry should reflect the details created for the CSV Details entry.

    - True indicates an Objects JSON entry exists
    - False indicates an Objects JSON entry does not exist

The following columns are for tracking implementation in the specific scripts for:  Export to CSV, Export to CSV Action, Export to JSON Action, Import, Set-Update, Delete, and Suppend Error Handling

- Common to all :
    - True : indicates the objects type is implemented.  This may have caveats.  If "disabled" is shown, then it is implemented but turned off by commenting out on purpose!
    - False : indicates the objects type is NOT implemented.  This may have caveats.

- Export CSV :  implementation in "cli_api_export_objects_to_csv.sh" script
- Export CSV Action :  implemented in "cli_api_actions.export_objects_to_csv.sh" actions script, called by scripts:  "cli_api_export_objects.sh", "cli_api_export_all_domains_objects.sh", "cli_api_export_all_domains_objects_to_csv.sh"
- Export JSON Action :  implemented in "cli_api_actions.export_objects_to_json.sh" actions script, called by scripts:  "cli_api_export_objects.sh", "cli_api_export_all_domains_objects.sh", "cli_api_export_all_domains_objects_to_csv.sh"
- Delete :  implemented in "cli_api_delete_objects_using_csv.sh" script
- Import :  implemented in "cli_api_import_objects_from_csv.sh" script
- Set-Update :  implemented in "cli_api_set_update_objects_from_csv.sh" script
- Suppend Error Handling :  implemented in "api_subpend_csv_error_handling_to_csv_files.sh" script

The following columns are for other pertinent information
- Notes
    Notes related to the current objects type
    
Caveats explanation:
- Disabled :  
    The objects type is disabled on purpose though implementation is provided.
- N/A :  
    The objects type implementation for this operation is NOT APPLICABLE (or unfeasible).  This generally for Delete operations, where the objects type is removed in another operation.
- ! :  
    The implementation of this objects type is subject to further review and potential update based on experience with the current implementation and results.  For values that are "false" there is no detail implementation beyond common elements provided and this object may or may not get more attention.
- !+ :  
    The implementation of this objects type is subject to further review, refinement, and potential update based on experience with the current implementation and results, it is generally assumed complete if the value is "true"
- !* :  
    The implementation of this objects type is subject to further review, refinement, and potential update based on experience with the current implementation and results, it is generally assumed partially ready if the value is "true".  This objects type may require detailed implementation of complex object handling to get the most value due to the complexity of the object.
