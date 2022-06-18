# Testing Operations SMS

#
# JSON and CSV Exports, builds JSON Repository
#
cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL
cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR
cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL

#
# JSON only Exports, builds JSON Repository
#
cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO
cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO
cli_api_export_objects.sh -v -r --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO

#
# CSV only Exports
#
cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL
cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR
cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL

# --type-of-export <export_type> | --type-of-export=<export_type>
#  Supported <export_type> values for export to CSV :  <"standard"|"name-only"|"name-and-uid"|"uid-only"|"rename-to-new-name"|"name-for-delete">
#    "standard" {DEFAULT} :  Standard Export of all supported object key values
#    "name-only"          :  Export of just the name key value for object
#    "name-and-uid"       :  Export of name and uid key value for object
#    "uid-only"           :  Export of just the uid key value of objects
#    "rename-to-new-name" :  Export of name key value for object rename
#    "name-for-delete"    :  Export of name key value for object delete also sets other settings needed for clean delete control CSV
#    For an export for a delete operation via CSV, use "name-only"

cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-only'
cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'name-and-uid'
cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'uid-only'
cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t 'rename-to-new-name'

# For DELETE!
cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --NO-TAGS --CSVERR -t 'name-for-delete'
cli_api_export_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO -t 'name-for-delete'
