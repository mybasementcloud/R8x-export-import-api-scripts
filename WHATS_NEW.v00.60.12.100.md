# R8x-export-import-api-scripts - What's NEW in v00.60.12

What's NEW in Check Point R8x Export, Import, Set/Update, Rename to new-name, and Delete mgmt_cli API scripts for bash on Check Point Gaia OS management hosts, using CSV files (v00.60.xx.yyy)

## UPDATED:  2023-03-14

Interim update

## What's New

As of v00.60.11 this file will document major changes and additions to the version.

- Specific limitations and caveats are added to the LIMITATIONS_and_CAVEATS.md file for reference.
- Details of object type specific capabilities are documented in the supported_objects.{version}.tsv

## v00.60.12

### v00.60.12 New Objects Supported

#### v00.60.12 New JSON exports

- Added support for Data Center objects:  Data Center Servers, Data Center Objects, and Data Center Queries for json export
- Added support for custom application-site objects via generic object capture json export
- Added support for custom application-site objects via generic object capture and array evaluation to generate custom application-sites json export

#### v00.60.12 New JSON and CSV exports

- Added support for Global Properties special object/properties for json and csv export, when exporting domain other than "System Data", or on SMS
- Added support for Policy Settings special object/properties for json and csv export, when exporting domain other than "System Data", or on SMS
- Added support for API Settings special object/properties for json and csv export, when exporting domain "System Data" (also on SMS using domain "System Data")
- Addes support for Radius Server and Radius Group objects for API version 1.9 and later [R81.20 GA], for all operations
- Addes support for Repository Script objects for API version 1.9 and later [R81.20 GA], for all special object operations
- Addes support for SmartTasks objects for API version 1.9 and later [R81.20 GA], for all operations

#### v00.60.12 New CSV exports

- Added support for application-site objects url-list and additional-categories elements-CSV files (like group members), done in special objects export script or when enabling export of Critical Performance Impacting (CPI) objects
- Added support for custom application-site objects via generic object capture and array evaluation to generate custom application-sites csv export and import, two variants
  - first export variant for CSV import with elements-CSV files (see next New Objects Supported) -- NOT A CPI object!
  - second export variant for CSV import alternative, with up to 20 url-list entries and 10 additional-categories in the exported file
- Added support for custom application-site objects via generic object capture and array evaluation for actual additional-categories and url-list elements-CSV files (like group members), for csv export and import
- Added support for hosts that have NAT configured and that do not have NAT configured to explicit files for easier handling, for csv operations.  The original hosts and hosts_NO_NAT operations are still available.  Import should either utilize:  hosts, hosts_NO_NAT, or hosts_with_NAT and hosts_without_NAT files.  JSON export is possible for the object; however, it is disabled to avoid need for more complicated CSV export, as all the data is in the normal hosts file.

### v00.60.12 Operational Changes

- Added Command Line Parameters to handle specific domains:  "System Data" and "Global", --domain-System-Data|--dSD|--dsd and --domain-Global|--dG|--dg respectively, to handle issues with operational scripts and passing quoted parameters with spaces, as well as easier domain specific execution.
- Added support for export of special objects and properties to json
- Added support for basic plumbing for delete, export, import, set/update, rename, and augment CSV files for special objects and properties via CSV
- Added support for per object | special object/properties specific control of utilization of "details-level", "ignore-errors", "ignore-warnings"
- Modified CSV key value sets exported by default for application-site objects
- Added information more detailed error handling mgmt_cli and JQ calls, to help with identification of problems and performance related limitations
- Added object_operations script files for MDSM with max object limit configuration for 100 objects
- Added CLI parameters to determine handling of Critical Performance Impacting (CPI) objects, [--DO-CPI | --Override-Critical-Performance-Impact] or [--NO-CPI | --NO-Critical-Performance-Impact], like application-site objects with > 10,000 Check Point provided objects to handle.  Default mode is to exclude CPI objects from export operations [--NO-CPI | --NO-Critical-Performance-Impact]
- Added script variants to handle special objects for object export, all domain objects export, and all domains objects CSV export.
- Added handler for json extraction of specific objects from a larger set based on export of a reference key value from a generic object query
- Harmonization of the json file slurp operation across different export functions and implementation of some common procedures based on redundant implementations
- Corrections of object association with different main script operations, like export, import, delete, etc.; to ensure that the correct things will work or get skipped
- Added files for operational export of minimum necessary exports for import under the root of the script:  _minimum_export.sh, _minimum_exports_with_some_do_cpi.sh, and _minimum_system_data_exports_with_some_do_cpi.sh
- Modified CheckAPIKeepAlive to limit impact of mgmt_cli keep alive calls by checking the last time the procedure was called and only executing an actual mgmt_cli keep alive action if the current default interval of 60 seconds has passed since the last execution; otherwise, make a quick note in logs and continue.  A future command line parameter may be added to control the actual interval between required mgmt_cli keep alive executions.
- Reorganized layout of Object Definition Data to make it easier to see variants when reviewing script code
- Cosmetic changes to enhance the flow of operation display, especially when utilization -v (Verbose) logging mode
- Homogenized and harmonized how the routines handling CSV export of complex objects based on generic object queries and associated arrays to the complex object operate, to reduce the number of places to adjust certain processing methods.

## v00.60.11

### v00.60.11 New Objects Supported

- Added support for objects type smtp-servers from API version 1.9 (R81.20) forward
- Added support for objects type network-feeds from API version 1.9 (R81.20) forward
- Added support for objects type interoperable-devices from API version 1.9 (R81.20) forward

### v00.60.11 Operational Changes

- Addresses issue where service objects that have aggressive aging settings need to be separated between those that are set to use the defautl time out and those that do not use the default timeout, which now generates explicit CSV files for each supported import operation, but also a dedicated reference export that combines all of that service time for review
- Addresses issue where TACACS Server object import needs specific information for TACACS versus TACACS+ configuration.  Specific CSV files for each TACACS server type are generated for input, which also addresses the limitation that the API exports a value for TACACS+ that can't import.  Also generate a consolidated reference export.
- Added support for objects to have an initial object specific selection criteria based on key and value data.  Future expansion is possible.
- Reference only exports now use standard name extension of "REFERENCE_DO_NOT_IMPORT" added to the regular name.
