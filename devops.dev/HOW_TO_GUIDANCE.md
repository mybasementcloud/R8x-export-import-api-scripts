# HOW TO GUIDANCE for operation of R8x-export-import-api-scripts

Check Point R8x Export, Import, Set/Update, Rename to new-name, and Delete mgmt_cli API scripts for bash on Check Point Gaia OS management hosts, using CSV files (v00.60.xx.yyy)

Additional documentation and information will be provided in .md, .tsv, and potentially .xlsx files in the repository.

## UPDATED:  2023-03-14

Interim update, reorganize the README.MD and add a Quick Start

## Basic Idea of Operation

The basic idea behind the scripts is to do the following:

1. Export everything to a json repository location in a full json dump of all supported objects, with or without Critical Performance Impacting (CPI) object (e.g. application-sites, of which there are 10,000 from Check Point)
      1. If working on the management server itself, there are operational scripts that execute a series of exports, and even a full test of the import, set-update, delete operations with exports.  These are in the ./devops.dev/objects.wip/object_operations folder
      2. While not necessary, the -v parameter can help with any issues that come up during operations, since much is logged then.
      3. Exported files are named specifically to enable utilization in the CSV export
2. Use the json repository to then help with the CSV export of all objects, again with or without CPI objects
3. Take the exported CSV files and check them
      1. It is STRONG RECOMMENDED to use --CSVERR CLI option for CSV operations to ensure the error handling columns are added to facilitate other than export operations.  The operational scripts all include this setting and other best practice CLI parameters from my experience.
      2. Exported files are named specifically to enable import (or specific import/change operations, like rename-to-name, delete, etc.) and should not be renamed to ensure operational success.
      3. Cloned application-site objects require a full export with the --DO-CPI CLI parameter, and the time to harvest that data, because those are not “custom” application sites, like those created from scratch or clones of those from-scratch application-sites
4. Make a copy of the exported CSV files [folder] and place that into a new folder which is the import target, in that folder make any needed changes, like removal or addition of objects to the CSVs
      1. NOTE:  the CSV files are sensitive to changes to return handling (LF vs CR/LF), so editing them in EXCEL can be a problem which will need correcting.  A TSV/CSV editor that respect Linux/Unix format is OK
      2. Since group member exports will include references to management server and gateways, those entries need to be either removed, or the target for import needs those objects to exist already, else there will be errors in the operation.
      3. The import operation should skip files that it can’t ingest, because the logic will also indicate if an expected file has an object that can handle import for that version of the API—not a problem going from older to newer.
      4. On execution, the output folder (like the recommended --RESULTS location will get a log file for the operation, but also a json file for each objects import that will show any objects with warnings or errors)
5. If there are object specific errors on import, it may be possible to fix those in a copied CSV with the correction needed, removing rows of objects that have been successfully imported for that object.
6. There are caveats and in some cases, like MDSM, performance is outside of the scripts control, instead based on the implemented API code.
      1. Older versions of the API do not support creation of many objects of the new versions, so if that is an issue, it may be necessary to upgrade the management server to more current API before exporting
      1. Because of the nature of CSV based --batch based import, down grade based import is not plausible and will fail in objects that have additional options in current versions.  This should not generally be an issue for import.

## Considerations

Some of the objects have API based issues where it is not possible to export as a single CSV file (like certain service type objects), so multiple export CSVs are provided that handle the nuances of the import requirements.  TACACS servers are an issue where the export of TACACS+ actually breaks the import and the import file needs editing to change the import value to the one the API supports:  https://sc1.checkpoint.com/documents/latest/APIs/index.html#cli/add-tacacs-server~v1.9%20

API 1.9 R81.20 supports many additional objects, like global properties, which I broke up into multiple files to ensure all the values can be exported and imported, since it is a huge set of key values.
