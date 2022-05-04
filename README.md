# R8x-export-import-api-scripts

Check Point R8x Export, Import, Set/Update, Rename to new-name, and Delete mgmt_cli API scripts for bash on Check Point Gaia OS management hosts, using CSV files (v00.60.xx.yyy)

Additional documentation and information will be provided in .md, .tsv, and potentially .xlsx files in the repository.

## UPDATED:  2022-05

Interim update, reorganize the README.MD and add a Quick Start

## Overview

The export, import, set-update, rename-to-new-name, and delete using CSV files scripts in this post, currently version 00.60.09.005 dated 2022-05-03, are intended to allow operations on an existing R80, R80.10, R80.20[|.M1|.M2], R80.30, R80.40, R81, and R81.10 [EA R81.20 possibly] Check Point management server (SMS or MDM) from bash expert mode on the Check Point management server host or another API enabled Check Point management server host instance (Check Point Gaia OS R8X) able to authenticate and reach the target management server host.  Utilization from other LINUX releases is not supported, tested, or assumed to work.

- Check Point Management API documentation is here:
<https://sc1.checkpoint.com/documents/latest/APIs/index.html#introduction>
- Details about supported Check Point API management objects are documented in the file supported_objects.{version}.tsv file, which is updated with each version
- Scrubbing of exported data prior to import is highly recommended to ensure import or other operations take place on the desired objects.
- Smart-1 Cloud MaaS support is under evaluation and development, though CLI parameter for --context was added to facilitate current use--this is not yet tested effectively.

These scripts show examples of:

- an export of objects with full and standard json output, and export to csv output that can be reused for import or other operations.
  - "standard" export of all plausible object keys and their values for supported objects
  - "name-only" export of object key "name" values for supported objects.  This export is used with the delete operation (scrub ensure only the desired targets are deleted)
  - "uid-only" export of object key "uid" values for supported objects
  - "name-and-uid" export of object keys "name" and "uid" with their respective values for supported objects
  - "rename-to-new-name" export of object key "name" and values for supported objects, a second "name" is provided under the "new-name" key for renaming operations
- an import of objects from csv output generated by the export to csv operations above
- a set (or update) operation of different objects, similar to the import operation using csv output generated by export operation
- a script to delete objects using csv files created by an object export in "name-only" mode to csv for the respective items deleted.
NOTE:  DANGER!, DANGER!, DANGER!  Use at own risk with extreme care!
- CSV manipulation scripts to add error handling columns to existing CSV files for addressing import, set-update, rename-to-new-name, and delete operations
- MDM script to document domains and output to a domains_list.txt file for reference in calls to other scripts
- Session Cleanup scripts to show and also remove zero lock sessions that may accumulate.
- Script templates for writing new scripts and utilize the existing capabilities provided for CLI parameter handling and basic API related operations, like logon, logoff, publish.

For direct questions, contact the author at ericb (at) checkpoint (dot) com
    or lookup information on <https://community.checkpoint.com> CheckMates community.

### DESCRIPTION

This post includes a set of script packages, which can be used independently or combined.  All script files end with .sh for bash shell and are intended for Check Point Software Technologies Gaia OS bash expert implementation on release versions R80, R80.10, R80.20[including M1 & M2], R80.30, R80.40, R81, and R81.10; potentially later versions.  Scripts in the packages have specific purposes and some scripts call subscripts for extensive repeated or common operations (e.g. CLI parameter handling, mgmt_cli authentication and basic operations, etc.).  The packages also include specific expected default directory folders that are not created by the script action.  

A set script templates is also provided to help with development of other scripts.

### PACKAGE INFORMATION

Releases have packages for the key script folders:

The script packages are:

- Deployment Package  :  devops.dev.{version}.tgz

The approach to provided compressed packages was changed to facilitate quicker implementation and deployment on the management hosts.

### REQUIREMENTS

- Check Point Gaia OS based Management host with version R80 or higher to run the mgmt_cli commands
- To properly execute the scripts successfully, the user executing must have appropriate rights to access the Check Point Gaia OS based Management host in bash expert mode as well as credentials for access agaist the target Check Point based Management host API (SmartConsole administrator user account)
- To use the Export/Import scripts under objects.wip/export_import.wip|objects/export_import folder the subscripts folder _api_subscripts is required at the same level as the objects.wip|objects folder.

### INSTALLATION RECOMMENDATION

Recommended installation is to use the provided devops.dev.{version}.tgz and expand that to the working folder on the Gaia OS host, which should be placed under /var/log/ folder to ensure survival during Gaia OS upgrades.  The tgz file is the devops.dev folder with current scripts and tools, and a devops.results folder for results if using --RESULTS option, and the devops.my_data for holding modified csv files for operations.

## QUICK START

To quickly start working with the scripts, do the following.

1. Create the working __customer folder under /var/log, if that does not exist and configure

      ```mkdir /var/log/__customer```

      ```chmod 775 /var/log/__customer```

      ```cd /var/log/__customer```

2. Download the release tgz file and deploy to a work folder on the target management host, like /var/log/__customer, the folder should be under the /var/log folder to ensure survival during upgrades

3. Expand the TGZ file, e.g.

      Example:  ```tar -xvf devops.dev.{version}.tgz```

      ```tar -xvf devops.dev.v00.60.09.005.tgz```

4. Goto to the export import folder

      ```cd ./objects.wip/export_import.wip```

5. Execute desired script with help parameter to show command options

      Example:  ```./cli_api_export_objects_to_csv.sh --help```

## VERSION RELATED CHANGES AND RELEASE APPROACH

As of v00.60.00.050 the approach the folder structure has changed and object specific scripts are under objects.wip folder.
As of v00.60.00.045 the approach to shared scripts has changed to focus only on the current work in progress under devops.dev folder.
As of v00.60.00.075 the added connection time out handling for mgmt_cli calls, added default 600 seconds and CLI parameter for external control.

As of v00.60.08 the efforts are made to expidite the operations involving generations of CSV exports, but these are dependent on up-to-date json data from the management database, to this end a JSON Repository was implemented, more details are below.  

Well functioning sets of scripts shall be packaged into releases that can be downloaded as a set for quick deployment and implementation.  Future effort to create an installation and update solution, similar to other scripting solutions targeting Check Point Software Technologies will be analyzed, pending method of providing sustainable locations for such downloads.

### PRESUMPTIVE FOLDER STRUCTURE

With v00.60.08.050 the folder structure was adjusted to facilitate the other project future work with policy and layers and sharing the _templates and_api_subscripts folders as well as tools.

Presumptive folder structure for R8X API Management CLI (mgmt_cli) Template based scripts

- [.wip] named folders are for development operations

| Folder | Folder Purpose |
|:---|:---|
|/...{script_home_folder}/|the folder containing the script set, generally ```/var/log/__customer/devops[.dev]```|
|./_api_subscripts[.wip]|folder for all scripts|
|./_templates[.wip]|folder for all scripts|
|./tools|folder for all scripts with additional tools not assumed on system|
|./objects[.wip]|folder for objects operations focused scripts|
|./objects[.wip]/csv_tools[.wip]|folder for objects operations for csv handling focused scripts|
|./objects[.wip]/export_import[.wip]|folder for objects operations export, import, set, rename, and delete focused scripts|
|./Policy_and_Layers[.wip]|folder for policy and layers operations focused scripts|
|./Session_Cleanup[.wip]|folder for Session Cleanup operation focused scripts|
|./tools.MDSM[.wip]|folder for Tools focused on MDSM operations scripts|

### JSON REPOSITORY

As of v00.60.08.000 the efforts are made to expidite the operations involving generations of CSV exports, but these are dependent on up-to-date json data from the management database.  With version v00.60.08.000 and later, additional controls are introducted to help create a "__json_objects_repository" folder with a repository of objects json data as files for fast JQ parsing in CSV exports.  If, during CSV export operation a required json repository file is not found, then the normal mgmg_cli call is made instead.  The "__json_objects_repository" folder is located in the normal results folder, but has CLI parameter controls for explicit setting of the json repository folder.
