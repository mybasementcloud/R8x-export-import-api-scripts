# R8x-export-import-api-scripts - What's NEW in v00.60.11

What's NEW in Check Point R8x Export, Import, Set/Update, Rename to new-name, and Delete mgmt_cli API scripts for bash on Check Point Gaia OS management hosts, using CSV files (v00.60.xx.yyy)

## UPDATED:  2022-06-25

Interim update

## What's New

As of v00.60.11 this file will document major changes and additions to the version.

- Specific limitations and caveats are added to the LIMITATIONS_and_CAVEATS.md file for reference.

- Details of object type specific capabilities are documented in the supported_objects.{version}.tsv

### v00.60.11

- Addresses issue where service objects that have aggressive aging settings need to be separated between those that are set to use the defautl time out and those that do not use the default timeout, which now generates explicit CSV files for each supported import operation, but also a dedicated reference export that combines all of that service time for review

- Addresses issue where TACACS Server object import needs specific information for TACACS versus TACACS+ configuration.  Specific CSV files for each TACACS server type are generated for input, which also addresses the limitation that the API exports a value for TACACS+ that can't import.  Also generate a consolidated reference export.

- Added support for objects to have an initial object specific selection criteria based on key and value data.  Future expansion is possible.

- Added support for objects type smtp-servers from API version 1.9 (R81.20) forward

- Added support for objects type network-feeds from API version 1.9 (R81.20) forward

- Added support for objects type interoperable-devices from API version 1.9 (R81.20) forward

- Reference only exports now use standard name extension of "REFERENCE_DO_NOT_IMPORT" added to the regular name.
