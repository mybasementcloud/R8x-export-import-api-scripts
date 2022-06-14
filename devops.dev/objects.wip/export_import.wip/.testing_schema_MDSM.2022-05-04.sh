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
# Testing schema for MDSM MDS with domain "EXAMPLE-DEMO"
#
#
ScriptVersion=00.60.09
ScriptRevision=020
ScriptSubRevision=085
ScriptDate=2022-06-13
TemplateVersion=00.60.09
APISubscriptsLevel=010
APISubscriptsVersion=00.60.09
APISubscriptsRevision=020

#

#
# These script calls should be executed manually
#
exit 0

#"System Data"
#"Global"
#"EXAMPLE-DEMO"


# Export, Import, Set-Update, Delete specific testing

./cli_api_import_objects_from_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" -i "/var/log/__customer/devops.dev/export_import.wip/test/import.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" --NSO --10-TAGS --CSVERR

./cli_api_set_update_objects_from_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" -i "/var/log/__customer/devops.dev/export_import.wip/test/set_update.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" --NSO --10-TAGS --CSVERR

./cli_api_delete_objects_using_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" -k "/var/log/__customer/devops.dev/export_import.wip/test/delete.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS -d "EXAMPLE-DEMO" --NSO --10-TAGS --CSVERR

# Export specific testing

./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format all --KEEPCSVWIP --SO --10-TAGS --CSVALL
./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format all --KEEPCSVWIP --NSO --10-TAGS --CSVERR
./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format all --KEEPCSVWIP --OSO --10-TAGS --CSVALL

./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --SO
./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --NSO
./cli_api_export_all_domains_objects.sh -r -v --NOWAIT --RESULTS --format json --KEEPCSVWIP --OSO

./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --SO --10-TAGS --CSVALL
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --10-TAGS --CSVERR
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --OSO --10-TAGS --CSVALL

./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t "name-only"
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t "name-and-uid"
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t "uid-only"
./cli_api_export_all_domains_objects_to_csv.sh -r -v --NOWAIT --RESULTS --JSONREPO --NSO --CSVERR -t "rename-to-new-name"


