#!/bin/bash
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
# Testing schema for SMS
#
#
ScriptVersion=00.60.08
ScriptRevision=060
ScriptDate=2021-11-10
TemplateVersion=00.60.08
APISubscriptsLevel=010
APISubscriptsVersion=00.60.08
APISubscriptsRevision=060

#

#
# These script calls should be executed manually
#
exit 0

./cli_api_import_objects_from_csv.sh -v -r --NOWAIT --RESULTS -i "/var/log/__customer/devops.dev/export_import.wip/test/import.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS --NSO --10-TAGS

./cli_api_set_update_objects_from_csv.sh -v -r --NOWAIT --RESULTS -i "/var/log/__customer/devops.dev/export_import.wip/test/set_update.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS --NSO --10-TAGS

./cli_api_delete_objects_using_csv.sh -v -r --NOWAIT --RESULTS -k "/var/log/__customer/devops.dev/export_import.wip/test/delete.csv"

./cli_api_export_objects_to_csv.sh -v -r --NOWAIT --RESULTS --NSO --10-TAGS


