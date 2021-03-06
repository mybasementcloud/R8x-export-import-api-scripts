#!/bin/bash
#
# SCRIPT show domains
#
# (C) 2016-2020 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/R8x-export-import-api-scripts
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
ScriptVersion=00.02.00
ScriptDate=2020-09-10
#

export BASHScriptVersion=v00x02x00

export pythonpath=$MDS_FWDIR/Python/bin/
export get_api_local_port=`$pythonpath/python $MDS_FWDIR/scripts/api_get_port.py -f json | $JQ '. | .external_port'`
export api_local_port=${get_api_local_port//\"/}
export currentapisslport=$api_local_port

echo '"System Data"' > domains_list.txt
echo '"Global"' >> domains_list.txt

mgmt_cli show domains -r true --port $currentapisslport --format json | jq '.objects[].name' >> domains_list.txt
cat domains_list.txt
