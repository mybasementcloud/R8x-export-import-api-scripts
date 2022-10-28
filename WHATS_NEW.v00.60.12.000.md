# R8x-export-import-api-scripts - What's NEW in v00.60.12

What's NEW in Check Point R8x Export, Import, Set/Update, Rename to new-name, and Delete mgmt_cli API scripts for bash on Check Point Gaia OS management hosts, using CSV files (v00.60.xx.yyy)

## UPDATED:  2022-10-27

Interim update

## What's New

As of v00.60.11 this file will document major changes and additions to the version.

- Specific limitations and caveats are added to the LIMITATIONS_and_CAVEATS.md file for reference.

- Details of object type specific capabilities are documented in the supported_objects.{version}.tsv

### v00.60.12

- Added support for export of special objects and properties to json

- Added support for basic plumbing for delete, export, import, set/update, rename, and augment CSV files for special objects and properties via CSV

- Added support for per object | special object/properties specific control of utilization of "details-level", "ignore-errors", "ignore-warnings"

- Added support for Global Properties special object/properties for json export, when exporting domain other than "System Data", or on SMS

- Added support for Policy Settings special object/properties for json export, when exporting domain other than "System Data", or on SMS

- Added support for API Settings special object/properties for json export, when exporting domain "System Data"

- Modified CSV key value sets exported by default for application-site objects

- Added support for application-site objects url-list and additional-categories sub-CSV files (like group members), done in special objects export script

- Added information more detailed error handling mgmt_cli and JQ calls, to help with identification of problems and performance related limitations

- Added object_operations script files for MDSM with max object limit configuration for 100 objects

### v00.60.11

- Addresses issue where service objects that have aggressive aging settings need to be separated between those that are set to use the defautl time out and those that do not use the default timeout, which now generates explicit CSV files for each supported import operation, but also a dedicated reference export that combines all of that service time for review

- Addresses issue where TACACS Server object import needs specific information for TACACS versus TACACS+ configuration.  Specific CSV files for each TACACS server type are generated for input, which also addresses the limitation that the API exports a value for TACACS+ that can't import.  Also generate a consolidated reference export.

- Added support for objects to have an initial object specific selection criteria based on key and value data.  Future expansion is possible.

- Added support for objects type smtp-servers from API version 1.9 (R81.20) forward

- Added support for objects type network-feeds from API version 1.9 (R81.20) forward

- Added support for objects type interoperable-devices from API version 1.9 (R81.20) forward

- Reference only exports now use standard name extension of "REFERENCE_DO_NOT_IMPORT" added to the regular name.
