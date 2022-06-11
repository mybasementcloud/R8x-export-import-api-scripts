# File and Folder Purpose and Utilization

## UPDATED:  2022-06-10

Updated to reflect changes to version, folder structure, and filenames.

### Version v00.60.09.015:005 2022-06-10

The value of ${version} for this document is one of the following:

- Version:  v00.60.09       ${version}
- Version:  v00.60.09.015   ${version.revision}

## Overview

This document provides an overview of the file and folder purpose and utilization for the R8X Management API Scripts for Objects and Policy and Layers export, import, set-update, delete, and rename operations, as well as the development environment elements provided.

The approach is to provide a folder by folder overview of provided files and their respective purpose and potential utilization.

## Folder Structure .../devops.dev

The devops.dev folder is the root development folder deployed for the scripts package and should be installed somewhere under the /var/log/ folder of the Check Point Gaia host installation.  The working default approach for MyBasementCloud is /var/log/__customer/ as that root for /var/log/__customer/devops.dev.

### Root-Folder .../deveops.dev

The root of the .../devops.dev folder contains the main documentation and control files for all R8X API development efforts including both Object operations for export, import, set-update, delete, and rename, as well as the Policy and Layers operations for export and import.

#### Documentation files

Documentation related files in formats that support the material presented.  Markdown (.md) files are used for text document style files, while Tab Separated Value (.tsv) files are used for table style information.

Files:

- command_line_parameters.devops.${version.revision}.tsv  :  this documentation file outlines the different Command Line Interface (CLI) Parameters for the scripts as a Tab Separated Value (.tsv) file.
- File_and_Folder_Purpose_and_Utilization.${version.revision}.md  :  this documentation file is the current file being read, describing the purpose and utilization of the files and folders of the project.
- LIMITATIONS_and_CAVEATS.md  :  this documentation file lists the current known limitations and caveats for the script package
- README.md  :  this documentation file is the primary overview documentation for the scripts project, and is also used on GitHub for the project README.md file
- supported_objects.version.tsv.md  :  this documentation file describes the table columns of the supported_objects.${version.revision}.tsv file for reference.
- supported_objects.${version.revision}.tsv  :  this documentation file identifies the supported objects for the Objects operations scripts, and how they are supported for the different operations.  Each objects is provide a row in the Tab Separated Value (.tsv) file, and the columns are specific items described or documented.

#### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- devops_version.${version.revision}.version  :  Version reference file for this version and revision of the scripts - empty file
- ${version.revision}.${subrevision}.wip.${DATE-TIME-GROUP[YYYY-MM-DD-HHmmZZZ]}}.info  :  Version reference file with version, revision, subrevision, and Date-Time-Group - empty file

#### Environmental Control Files for Operational Script Execution (json)

These files are used for the actual operations of the scripts and utilized in the deployed environment.

Files:

- .environment_info.json  :  JSON file for configuration/customization of user experience when executing scripts in operational environment, in this case bash on Check Point Gaia host.

#### Environmental Control Files for Development Script Execution (json)

These files are used for the development operations of the scripts and utilized in the development environment, but can be utilized in the deployed environment for operations also at a later time.

Files:

- solution_info.json  :  JSON file for configuration/identification of the scripts during operations in the development environment, used by the Windows Command Line (CMD) Development Environment Files
- solution_info.devops.dev.${version.revision}.json  :  Versioned and solution identified copy of the solution_info.json file

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzMakeUpdatesScriptsNow.devops.dev.objects.CMD
- zzOpenFileTypesInTextFileEditor.devops.dev.objects.bash.CMD
- zzOpenFileTypesInTextFileEditor.devops.dev.policy_and_layers.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-2parm.devops.dev.objects.CMD
- zzZRz_Rename_Version-2parm.devops.dev.policy_and_layers.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.devops.dev.objects.CMD
- zzZTz_Touch.devops.dev.policy_and_layers.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

### Folder:  .../deveops.dev/__folder_template

Template for an new folders created under the existing folder structure with default files and folders stipulated for a new solution or needed folder.

Not provided to GitHub.

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.sh.CMD

### Folder:  .../deveops.dev/__LOGS

Folder for logs generated by scripts for the Windows Command Line (CMD) and future PowerShell development scripts.

Not provided to GitHub.

### Folder:  .../deveops.dev/__scripting_tools

Folder for development operations scripts and templates for change documentation files and developmental strawman content.

Not provided to GitHub.

#### Windows Command Line (CMD) Development Environment Files

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

### Folder:  .../deveops.dev/__Updates

The folder for tracking changes to the specific operations scripts is the '.../deveops.dev/__Updates' with subfolders for Objects and Policy and Layers operations.

Not provided to GitHub.

#### Windows Command Line (CMD) Development Environment Files

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

#### Sub-Folder:  .../deveops.dev/__Updates/Objects

Objects operations script changes are documented in this folder in specific subfolders based on the detail version and date of the changes made.

#### Sub-Folder:  .../deveops.dev/__Updates/Policy_and_Layers

Policy and Layers operations script changes are documented in this folder in specific subfolders based on the detail version and date of the changes made.

### Folder:  .../deveops.dev/__Windows.CMD

The development environment Windows Command Line scripts specific to '.../devops.dev' are stored and developed in this folder, which is also the root target for distribution of common Windows Command Line scripts in the MyBasementCloud environment.

Not provided to GitHub.

#### Environmental Control Files for Development Script Execution (json)

These files are used for the development operations of the scripts and utilized in the development environment, but can be utilized in the deployed environment for operations also at a later time.

Files:

- solution_info.json  :  JSON file for configuration/identification of the scripts during operations in the development environment, used by the Windows Command Line (CMD) Development Environment Files.  Specific to the scripting for Windows Command Line in the '.../deveops.dev/__Windows.CMD' folder
- solution_info.${CMD_version.CMD_revision}.json  :  Version copy of 'solution_info.json'

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files local to the devops.dev environment managed here:

- __deploy_current_CMD_files.devops.dev.CMD  :  Script to deploy the Windows Command Line scripts to their utilization and backuup folders
- __deploy_current_CMD_files.devops.dev.${CMD_version.CMD_revision}.CMD  :  Versioned copy of '__deploy_current_CMD_files.devops.dev.CMD file'
- __MakeFixesScriptsNow.devops.dev.Windows.CMD.CMD  :  Script to create the files to document changes for the Windows Command Line scripts during the development process
- __MakeFixesScriptsNow.devops.dev.Windows.CMD.${CMD_version.CMD_revision}.CMD  :  Versioned copy of '__MakeFixesScriptsNow.devops.dev.Windows.CMD.${CMD_version.CMD_revision}.CMD'
- _fixes_updates_info.TBEx.devops.dev._Windows.CMD.${DATE_YYYY-MM-DD}.${CMD_version.CMD_revision}.original.CMD  :  File documenting original content revised by script update
- _fixes_updates_info.TBEx.devops.dev._Windows.CMD.${DATE_YYYY-MM-DD}.${CMD_version.CMD_revision}.updated.CMD  :  File documenting changed content revised by script update
- zzMakeUpdatesScriptsNow.devops.dev.objects.CMD  :  Script to create the files used to document changes for the bash scripts for devops.dev Objects operations during the development process
- zzMakeUpdatesScriptsNow.devops.dev.objects.${CMD_version.CMD_revision}.CMD  :  Versioned copy of 'zzMakeUpdatesScriptsNow.devops.dev.objects.CMD'
- zzMakeUpdatesScriptsNow.devops.dev.policy_and_layers.CMD  :  Script to create the files used to document changes for the bash scripts for devops.dev Policy and Layers operations during the development process
- zzMakeUpdatesScriptsNow.devops.dev.policy_and_layers.${CMD_version.CMD_revision}.CMD  :  Versioned copy of 'zzMakeUpdatesScriptsNow.devops.dev.policy_and_layers.CMD'
- zzOpenFileTypesInTextFileEditor.devops.dev.objects.bash.CMD  :  Script to open devops.dev Objects operations bash scripts in Windows Text Editor pulling from specific folders
- zzOpenFileTypesInTextFileEditor.devops.dev.objects.bash.${CMD_version.CMD_revision}.CMD  :  Versioned copy of 'zzOpenFileTypesInTextFileEditor.devops.dev.objects.bash.CMD'
- zzOpenFileTypesInTextFileEditor.devops.dev.policy_and_layers.bash.CMD  :  Script to open devops.dev Policy and Layers operations bash scripts in Windows Text Editor pulling from specific folders
- zzOpenFileTypesInTextFileEditor.devops.dev.policy_and_layers.bash.${CMD_version.CMD_revision}.CMD  :  Versioned copy of 'zzOpenFileTypesInTextFileEditor.devops.dev.policy_and_layers.bash.CMD'
- zzZRz_Rename_Version-2parm.devops.dev.objects.CMD  :  Script that executes a rename utilizing two parameters "old version" and "new version" on the files in the devops.dev Objects operations scripts folders
- zzZRz_Rename_Version-2parm.devops.dev.objects.${CMD_version.CMD_revision}.CMD  :  Versioned copy of 'zzZRz_Rename_Version-2parm.devops.dev.objects.CMD'
- zzZRz_Rename_Version-2parm.devops.dev.policy_and_layers.CMD  :  Script that executes a rename utilizing two parameters "old version" and "new version" on the files in the devops.dev Policy and Layers operations scripts folders
- zzZRz_Rename_Version-2parm.devops.dev.policy_and_layers.${CMD_version.CMD_revision}.CMD  :  Versioned copy of 'zzZRz_Rename_Version-2parm.devops.dev.policy_and_layers.CMD'
- zzZTz_Touch.devops.dev.objects.CMD  :  Script to execute a Unix touch operation on all the files associated with the devop.dev Objects operations scripts
- zzZTz_Touch.devops.dev.objects.${CMD_version.CMD_revision}.CMD  :  Versioned copy of 'zzZTz_Touch.devops.dev.objects.CMD'
- zzZTz_Touch.devops.dev.policy_and_layers.CMD  :  Script to execute a Unix touch operation on all the files associated with the devop.dev Policy and Layers operations scripts
- zzZTz_Touch.devops.dev.policy_and_layers.${CMD_version.CMD_revision}.CMD  :  Versioned copy of 'zzZTz_Touch.devops.dev.policy_and_layers.CMD'

Windows Command Line script Files common to MyBasementCloud script development operations managed elsewhere:

- WINTOUCH.CMD  :  Script to execute Windows equivalent of Unix touch operation
- zzOpenFileTypesInTextFileEditor.versions.CMD  :  Script to open version related files in Windows Text Editor pulling from folder and all subfolders
- zzOpenFileTypesInTextFileEditor.Windows_CMD.CMD  :  Script to open Windows CMD files in Windows Text Editor pulling from folder and all subfolders
- zzOpenFileTypesInTextFileEditor.Windows_CMD.CMD_Tools.CMD  :  Script to open Windows CMD files in Windows Text Editor pulling from folder in a script development CMD file specific order
- zzZCz_Clear__historyFolders.CMD  :  Script to clear and remove the hidden __history folders from this folder and all subfolders, created by the text editor
- zzZRz_Rename_Version-3parm.CMD  :  Script that executes a rename utilizing three parameters "old version", "new version", and "starting folder path" on the files in the "starting folder path" folder and sub-folders
- zzZRz_Rename_Version.CMD  :  Script that executes a rename utilizing two parameters "old version" and "new version"on the files in the current folder
- zzZRz_Rename_Version_Recursive.CMD  :  Script that executes a rename utilizing two parameters "old version" and "new version"on the files in the current folder and all sub-folders
- zzZSz_Create_Shortcuts_in_Current_Folder.CMD  :  Creates Windows shortcuts files for all files in the current folder
- zzZSz_Create_Shortcuts_in_Parent_Folder.CMD  :  Creates Windows shortcuts files for all files in the parent folder of the current folder
- zzZTz_Lock.CMD  :  Executes a lock operation on all files, setting them to read-only
- zzZTz_Touch.CMD  :  Executes Unix touch command on all files
- zzZTz_Touch.sh.CMD  :  Executes Unix touch command on all bash .sh files
- zzZTz_TouchLock.CMD  :  Executes a Unix touch command and then locok (set to read-only) on all files
- zzZTz_Unlock.CMD  :  Executes an unlock operation on all files, setting them to read-write
- zzZTz_UnlockTouch.CMD  :  Executes and unlock operation (set to read-write) followed by a Unix touch operation on all files
- zzZTz_UnlockTouchReLock.CMD  :  Executes and unlock operation (set to read-write) followed by a Unix touch operation on all files followed by a lock operation on all files, setting them to read-only

### Folder:  .../deveops.dev/_api_subscripts

To simplify script development and operations, common operations are collected into subscripts, in this case with the Check Point Management REST API operations focus, thus API subscripts.  These subscripts are utilized by scripts that leverage the script templates in the '.../devops.dev/_templates[.wip]' folder, like those under '../objects[.wip]'

#### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- api_subscripts_version.${functional_level}.${version}.version  :  Version file identifying the API subscripts
- version.api_subscripts.${version.revision}.version  :  Version file identifying the API subscripts, used for alternative method from first

#### Script Files

Script Files:

- basic_script_setup_API_scripts.subscript.common.${functional_level}.${version}.sh  :  Subscript to handle basic setup of the bash script for Check Point Management API operations
- cmd_line_parameters_handler.subscript.common.${functional_level}.${version}.sh  :  Subscript to handle Command Line Parameters, parsing the script primary call for parameters and evaluating the information.  Also provides associated specific Command Line Parameter based help.
- identify_gaia_and_installation.subscript.common.${functional_level}.${version}.sh  :  Subscript with Check Point Gaia host specific scripting to identify installed version and installation type specifics.
- mgmt_cli_api_operations.subscript.common.${functional_level}.${version}.sh  :  Subscript for handling common operations for the Check Point Management REST API operated in bash via mgmt_cli calls.
- script_output_paths_and_folders_API_scripts.subscript.common.${functional_level}.${version}.sh  :  Subscript that handles configuration of variables for script operational common file paths and folder locations including creating of missing folders for the Check Point Management API scripts.  This subscript also includes the handling for nohup operations initiated by a "do_script_nohup[.sh]" call as defined by the 'bash 4 Check Point' scripts that are standard implementation for MyBasementCloud operations.

#### Script Template Files

Template files for scripts specific to this folder and/or operation.

Script Template Files:

- api_mgmt_cli_shell_template_common_subscripts_handler.template.subscript.common.${functional_level}.${version}.sh  :  Template script file for subscript type script files with specific validations to ensure versioning fidelity.

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

#### Sub-Folder:  .../deveops.dev/_api_subscripts/_code_snippets

Code Snippets are segments of script code for copy-pasting into scripts to perform a specific set of operations.  The '_code_snippets' folder for the '_api_subscripts' provides the Code Snippets for the specific API Subscripts, to utilize them in other scripts.

##### Script Files

Script Files:

- code_snippet.basic_script_setup_API_scripts.common.${functional_level}.${version}.sh  :  Code Snippets for implementation utilization of the 'basic_script_setup_API_scripts.subscript.common.${functional_level}.${version}.sh' script
- code_snippet.cmd_line_parameters_handler.common.${functional_level}.${version}.sh  :  Code Snippets for implementation utilization of the 'cmd_line_parameters_handler.subscript.common.${functional_level}.${version}.sh' script
- code_snippet.identify_gaia_and Installation.common.${functional_level}.${version}.sh  :  Code Snippets for implementation utilization of the 'identify_gaia_and_installation.subscript.common.${functional_level}.${version}.sh' script
- code_snippet.mgmt_cli_api_operations.common.${functional_level}.${version}.sh  :  Code Snippets for implementation utilization of the 'mgmt_cli_api_operations.subscript.common.${functional_level}.${version}.sh' script
- code_snippet.script_output_paths_and_folders_API_scripts.common.${functional_level}.${version}.sh  :  Code Snippets for implementation utilization of the 'script_output_paths_and_folders_API_scripts.subscript.common.${functional_level}.${version}.sh' script

##### Windows Command Line (CMD) Development Environment Files

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzTouch.sh.CMD

### Folder:  .../deveops.dev/_templates.wip

The '_templates[.wip]' folder contains bash script templates and some rough testing files for generating bash scripts for the devops.dev operations, utilizing the API subscripts in the '../_api_subscripts' folder.  Most bash shell [.sh] scripts provided are written utilizing these templates.

#### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- _templates_version.${version.revision}.version  :  Version file for the script templates provided

#### Environmental Control Files for Operational Script Execution (json)

These files are used for the actual operations of the scripts and utilized in the deployed environment.

Files:

- .environment_info.json  :  JSON file with environmental controls as an example and for use with the provided bash script templates.

#### Script Template Files

Template files for scripts specific to this folder and/or operation.  These templates are fully functional scripts missing the desired operational content for the final script, but are able to demonstrate operations with the API subscripts

Script Template Files:

- api_mgmt_cli_shell_template_action_handler.template.${version}.sh  :  Template for generating an action handler subscript.
- api_mgmt_cli_shell_template_with_cmd_line_parameters.template.${version}.sh  :  Template for generating a script that utilizes Command Line Paramenters, but handles those parameters in the main script, not via the common Command Line Paramenter handler API subscript 'cmd_line_parameters_handler.subscript.common.${functional_level}.${version}.sh'.  Includes Check Point Management API handling for login, operatin (defined by script developer), publish, policy installation if needed [future], and logout operations.
- api_mgmt_cli_shell_template_with_cmd_line_parameters_script.template.${version}.sh  :  Template for generating a script that utilizes Command Line Paramenters, via the common Command Line Paramenter handler API subscript 'cmd_line_parameters_handler.subscript.common.${functional_level}.${version}.sh'.  Includes Check Point Management API handling for login, operatin (defined by script developer), publish, policy installation if needed [future], and logout operations.

#### Script Files

Script Files:

- test._script.environment_info_json.${version}.sh  :  Test script to evaluate operation of the JSON file '.environment_info.json', for configuring local environmental and display parameters.
- test._templates.${version}.sh  :  Test script for executing tests against the 'api_mgmt_cli_shell_template_with_cmd_line_parameters_script.template.${version}.sh' template.

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

#### Sub-Folder:  .../deveops.dev/_templates.wip/dump

Default output folder for bash scripts if not specifically changed or referenced.

#### Sub-Folder:  .../deveops.dev/_templates.wip/_Reference

Folder for research and reference materials used in the script template development process.

##### Reference Files

Files:

- reference.jq_queries_and_output_formating.bash

### Folder:  .../deveops.dev/_tools

Tools distribution folder to include expected tools utilization by the '.../devops.dev' scripts operations.

#### Sub-Folder:  .../deveops.dev/_tools/JQ

Folder with the current JSON Query binaries from GitHub for distribution with distribution files.  Distribution content is in the '../GitHub' subfolder.

Current JSON Query version: 01.06.2018-11.01 

#### Sub-Folder:  .../deveops.dev/_tools/Windows.CMD

Tools repository folder for deployable Windows Command Line (CMD) and PowerShell [Future] files for deployment distribution.

Not provided to GitHub.

### Folder:  .../deveops.dev/objects.wip

Scripts for the Management API Objects operations for export, import, set-update, delete, and rename, as well as CSV file management scripts are located here.  The main folders below break out the operations for CSV file management version Objects operations.

#### Windows Command Line (CMD) Development Environment Files

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

### Folder:  .../deveops.dev/objects.wip/csv_tools.wip

#### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- csv_tools_version.${version.revision}.version  :  Current version details for the '../csv_tools.wip' scripts

#### Script Files

Script Files:

- api_add_csv_error_handling_to_csv_file.sh  :  Raw script to handle processing of a single file, passed as command line parameter to modify with CSV error handling columns.
- api_subpend_csv_error_handling_to_object_csv_files.sh  :  Script that processes all CSV files in a provided folder for addition of CSV error handling columns, supports standard command line parameter processing.

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

### Folder:  .../deveops.dev/objects.wip/export_import.wip

export_import.wip folder is for scripts executing the actual export, import, set-update, delete, and rename operations, as well as scripts that execute a set of these operations for complete processes, like testing, or common exports.  The folder also includes default locations for output and where operational files could be found for certain operations, like testing, import, or delete, and a default dump output folder.

#### Documentation files

Documentation related files in formats that support the material presented.  Markdown (.md) files are used for text document style files, while Tab Separated Value (.tsv) files are used for table style information.

Files:

- supported_objects.WIP.${version.revision}.tsv  :  This documentation file identifies the supported objects for the Objects operations scripts as a Work-In-Progress (WIP), and how they are supported for the different operations.  Each objects is provide a row in the Tab Separated Value (.tsv) file, and the columns are specific items described or documented.
- .testing_schema_MDSM.2022-05-04.sh  :  Schema of scripts with command line parameters to execute testing against MDSM.
- .testing_schema_SMS.2022-05-04.sh  :  Schema of scripts with command line parameters to execute testing against SMS.

#### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- export_import_version.${version.revision}.version  :  Current version of the '../export_import.wip' script files

#### Script Files - Delete

Script Files:

- cli_api_delete_objects_using_csv.sh  :  Script to delete objects on target SMS or MDSM Domain using CSV files in supported format, controlled by Command Line Parameters.  All CSV files are expected in the same source folder.

#### Script Files - Export

Script Files:

- cli_api_actions.export_objects_to_csv.sh  :  Action handler for object export to CSV format, utilized by other scripts.
- cli_api_actions.export_objects_to_json.sh  :  Action handler for object export to JSON format, utilized by other scripts.  Also populates the JSON Repository.
- cli_api_export_all_domains_objects.sh  :  Script to handle looping through all MDSM domains on a target MDSM MDS exporting all objects in JSON and CSV format controlled by Command Line Parameters, also populating the JSON repository.
- cli_api_export_all_domains_objects_to_csv.sh  :  Script to handle looping through all MDSM domains on a target MDSM MDS exporting all objects in CSV format controlled by Command Line Parameters.
- cli_api_export_objects.sh  :  Script to handle exporting all objects on an SMS or for a specific MDSM Domain in JSON and CSV format controlled by Command Line Parameters, also populating the JSON repository.
- cli_api_export_objects_to_csv.sh  :  Script to handle exporting all objects on an SMS or for a specific MDSM Domain in CSV format controlled by Command Line Parameters.
- cli_api_export_objects_to_csv.testing.msdm.sh  :  Script to handle subset of objects export, based on in script changes to active or commented out object actions, for CSV format, to assist in testing and developing complete and/or working exports for objects, on MDSM MDS target host.
- cli_api_export_objects_to_csv.testing.sh  :  Script to handle subset of objects export, based on in script changes to active or commented out object actions, for CSV format, to assist in testing and developing complete and/or working exports for objects, on SMS target host.

#### Script Files - Import

Script Files:

- cli_api_import_objects_from_csv.sh  :  Script to import objects to target SMS or MDSM Domain using CSV files in supported format, controlled by Command Line Parameters.  All CSV files are expected in the same source folder.

#### Script Files - Rename

Script Files:

- cli_api_rename_to_new_name_objects_from_csv.sh  :  Script to rename objects on target SMS or MDSM Domain using CSV files in supported format, controlled by Command Line Parameters.  All CSV files are expected in the same source folder.

#### Script Files - Set-Update

Script Files:

- cli_api_set_update_objects_from_csv.sh  :  Script to set or update objects on target SMS or MDSM Domain using CSV files in supported format, controlled by Command Line Parameters.  All CSV files are expected in the same source folder.

#### Script Files - JSON output

Script Files:

- 500plus_objects_to_single_json_in_dump.lite.sh  :  Process all instances of a type of object provided as a Command Line Parameter into a single JSON output file.

#### Script Files - Testing

Script Files:

- wip.object_export_testing.sh  :  Script to handle specific objects export, based on in script changes to active or commented out object actions, for CSV format, to assist in testing and developing complete and/or working exports for objects, on SMS target host.
- wip.test_read_exobdef_json_file.sh  :  Script to test the operations for reading JSON Object Export Definition Files, for development of JSON controlled operations on objects.

#### JSON Object Export Definition Files

JSON Files:

- export_objects_definition.json  :  JSON Object Export Definition file for operational implementation.
- export_objects_definition.template.json  :  JSON Object Export Definition file template for operational implementation.
- export_objects_definition.test.json  :  JSON Object Export Definition file for testing implementation.

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

#### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/_Deprecated_Scripts

Location for scripts deprecated since last version release, may not be present.

#### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/delete.csv

Default folder for expected files during Object delete operations.

#### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/dump

Default folder for output files during Object operations.

#### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/import.csv

Default folder for expected files during Object import operations.

#### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/test

Example CSV files and instructions to test the objects operations processes.

##### Test Operations Files

Files:

- testing_operations_multi_domain_regular.txt  :  sample instructions for execution in MDSM environment
- testing_operations_single_management_regular.txt  :  sample instructions for execution in SMS environment

##### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/test/delete.csv

Example CSV files to test deleting objects process.

###### CSV Test or Example Files

Files:

- address-ranges_name_csv.csv
- dns-domains_name_csv.csv
- groups-with-exclusion_name_csv.csv
- groups_name_csv.csv
- hosts_name_csv.csv
- networks_name_csv.csv
- security-zones_name_csv.csv

##### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/test/delete.large.csv

Example CSV files to test deleting with a large number of objects process.

###### CSV Test or Example Files

Files:

- address-ranges_name_csv.csv
- dns-domains_name_csv.csv
- groups-with-exclusion_name_csv.csv
- groups_name_csv.csv
- hosts_name_csv.csv
- networks_name_csv.csv
- security-zones_name_csv.csv

##### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/test/import.csv

Example CSV files to test the import objects process.

###### CSV Test or Example Files

Files:

- address-ranges_full_csv.csv
- dns-domains_full_csv.csv
- group-members_full_csv.csv
- groups-with-exclusion_full_csv.csv
- groups_full_csv.csv
- host-interfaces_full_csv.csv
- hosts_full_csv.csv
- networks_full_csv.csv
- security-zones_full_csv.csv

##### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/test/import.large.csv

Example CSV files to test the import with a large number of objects process.

###### CSV Test or Example Files

Files:

- address-ranges_full_csv.csv
- dns-domains_full_csv.csv
- group-members_full_csv.csv
- groups-with-exclusion_full_csv.csv
- groups_full_csv.csv
- host-interfaces_full_csv.csv
- hosts_full_csv.csv
- networks_full_csv.csv
- security-zones_full_csv.csv

##### Sub-Folder:  .../deveops.dev/objects.wip/export_import.wip/test/set_update.csv

Example CSV files to test the set-update process.

###### CSV Test or Example Files

Files:

- groups_full_csv.csv
- hosts_full_csv.csv
- networks_full_csv.csv
- security-zones_full_csv.csv

### Folder:  .../deveops.dev/objects.wip/object_operations

The 'object_operations' folder provides operations scripts that execute a process utilizing the scripts in the './export_import[.wip]' and './csv_tools[.wip]' folders.

#### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- object_operations_version.${version.revision}.version  :  Current version details for the '../object_operations' scripts

#### Script Files

Script Files:

- common_csv_exports.sh  :  Execute the common standard export to CSV with all objects (-SO) and Non-System Objects (NSO) for SMS.
- common_csv_exports_mdsm.sh  :  Execute the common standard export to CSV with all objects (-SO) and Non-System Objects (NSO) for MDSM.
- common_exports.sh  :  Execute the common standard export to JSON and CSV, populating the JSON repository with all objects (-SO) and Non-System Objects (NSO) for SMS.
- common_exports_mdsm.sh  :  Execute the common standard export to JSON and CSV, populating the JSON repository with all objects (-SO) and Non-System Objects (NSO) for MDSM.
- refresh_all_json_object_repositories.sh  :  Execute scripts to refresh all JSON Respositories for an SMS, including all objects (-SO), Non-System Objects (-NSO), and Only System Objecs (-OSO).
- refresh_all_json_object_repositories_mdsm.sh  :  Execute scripts to refresh all JSON Respositories for an MDSM MDS, including all objects (-SO), Non-System Objects (-NSO), and Only System Objecs (-OSO).
- refresh_json_object_repository.sh  :  Execute scripts to refresh JSON Respository for an SMS, only for the all objects (-SO) repository.
- refresh_json_object_repository_mdsm.sh  :  Execute scripts to refresh JSON Respository for an MDSM MDS, only for the all objects (-SO) repository.

#### Script Files - Testing

Script Files:

- test_exports.sh  :  Execute complete set of scripts to test the export operations scripts, with output of JSON and CSV files, including building all JSON Repositories, for SMS.
- test_exports_csv.sh  :  Execute subset set of scripts to test the export operations scripts, with output of CSV files, utilizing JSON Repositories, for SMS.
- test_exports_csv_mdsm.sh  :  Execute subset set of scripts to test the export operations scripts, with output of CSV files, utilizing JSON Repositories, for MDSM.
- test_exports_json.sh  :  Execute subset set of scripts to test the export operations scripts, with output of JSON files, including building all JSON Repositories, for SMS.
- test_exports_json_mdsm.sh  :  Execute subset set of scripts to test the export operations scripts, with output of JSON files, including building all JSON Repositories, for MDSM.
- test_exports_mdsm.sh  :  Execute complete set of scripts to test the export operations scripts, with output of JSON and CSV files, including building all JSON Repositories, for MDSM.

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

### Folder:  .../deveops.dev/Policy_and_Layers.wip

#### Root-Folder:  .../deveops.dev/Policy_and_Layers.wip

##### Documentation files

Documentation related files in formats that support the material presented.  Markdown (.md) files are used for text document style files, while Tab Separated Value (.tsv) files are used for table style information.

Files:

- CAVEATS_AND_LIMITATIONS.md
- LICENSE
- README.md

##### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- devops_policy_and_layers_version.v00.00.09.000.version
- v00.00.09.000.wip.2021-06-22-1800CDT.info

##### Environmental Control Files for Development Script Execution (json)

These files are used for the development operations of the scripts and utilized in the development environment, but can be utilized in the deployed environment for operations also at a later time.

Files:

- solution_info.devops.dev.policy_and_layers.v00.00.09.000.json
- solution_info.json

##### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzMakeUpdatesScriptsNow.devops.dev.policy_and_layers.CMD
- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.devops.dev.policy_and_layers.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-2parm.devops.dev.policy_and_layers.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.devops.dev.policy_and_layers.CMD
- zzZTz_Touch.sh.CMD

#### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/_export.csv

#### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/_import.csv

#### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/__Reference_and_Research

##### Reference and Research Files

Files:

- https-inspection-rule-detail.example.json
- threat-prevention-profile-detail.example.json
- threat-prevention-rule-detail.example.json

#### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/__testing

#### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/Access_Control_Policy

##### Documentation files

Documentation related files in formats that support the material presented.  Markdown (.md) files are used for text document style files, while Tab Separated Value (.tsv) files are used for table style information.

Files:

- CAVEATS_AND_LIMITATIONS_Access_Control_Policy.md
- README.md

##### Script Files

Script Files:

- list_layer_names.access-layers-from-package.v00.00.09.sh
- list_layer_names.access-layers.v00.00.09.sh
 
##### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/Access_Control_Policy/_export.csv

##### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/Access_Control_Policy/_import.csv

#### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/HTTPS_Inspection_Policy

##### Documentation files

Documentation related files in formats that support the material presented.  Markdown (.md) files are used for text document style files, while Tab Separated Value (.tsv) files are used for table style information.

Files:

- CAVEATS_AND_LIMITATIONS_HTTPS_Inspection_Policy.md
- README.md

##### Script Files

Script Files:

- export_to_csv_https_inspection_rule_base.v00.00.09.sh
- import_from_csv_https_inspection_rule_base.v00.00.09.sh
- list_layer_names.https-layers-from-package.v00.00.09.sh
- list_layer_names.https-layers.v00.00.09.sh

##### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/HTTPS_Inspection_Policy/_export.csv

##### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/HTTPS_Inspection_Policy/_import.csv

#### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/Threat_Prevention_Policy

##### Documentation files

Documentation related files in formats that support the material presented.  Markdown (.md) files are used for text document style files, while Tab Separated Value (.tsv) files are used for table style information.

Files:

- CAVEATS_AND_LIMITATIONS_Threat_Prevention_Policy.md
- README.md

##### Script Files

Script Files:

- export_to_csv_threat_prevention_global_exceptions.v00.00.09.sh
- export_to_csv_threat_prevention_profiles.export_only.v00.00.09.sh
- export_to_csv_threat_prevention_profiles.v00.00.09.sh
- export_to_csv_threat_prevention_rule_base.v00.00.09.sh
- import_from_csv_threat_prevention_global_exceptions.v00.00.09.wip.sh
- import_from_csv_threat_prevention_profiles.v00.00.09.wip.sh
- import_from_csv_threat_prevention_rule_base.v00.00.09.wip.sh
- list_layer_names.threat-layers-from-package.v00.00.09.sh
- list_layer_names.threat-layers.v00.00.09.sh

##### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/Threat_Prevention_Policy/_export.csv

##### Sub-Folder:  .../deveops.dev/Policy_and_Layers.wip/Threat_Prevention_Policy/_import.csv

### Folder:  .../deveops.dev/Session_Cleanup.wip

The Session Cleanup scripts are used to handle situation when there are too many API sessions open on the target management host and those sessions that are expired need to be removed.

#### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- Session_Cleanup_version.${B4CP_version.revision}.template.${version.revision}.version  :  Version details for the Session Cleanup files

#### Script Files

Script Files:

- remove_zerolocks_sessions.v05.60.09.sh  :  Remove all user's sessions that are expired and have Zero locks.
- remove_zerolocks_web_api_sessions.v05.60.09.sh  :  Remove all web_api user's sessions that are expired and have Zero locks.
- show_zerolocks_sessions.v05.60.09.sh  :  Show all user's sessions that are expired and have Zero locks.
- show_zerolocks_web_api_sessions.v05.60.09.sh  :  Show all web_api user's sessions that are expired and have Zero locks.

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

### Folder:  .../deveops.dev/tools.MDSM.wip

The '' folder provides tools to provide supporting operations for working with Check Point Multi-Domain Security Management (MDSM) management hosts Multi-Domain Servers (MDS)

#### Script Files

Script Files:

- MDM_Get_Domains_List.${version}.sh  :  Script to output the current list of MDSM Domains on the management host, with Command Line Parameter support for authentication
- show_domains_api.${version}.sh  :  Script to output the current list of the local management hosts MDSM Domains, stipulating ability to authenticate locally with '-r true' and operating on the actual Multi-Domain Server (MDS) directly.

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- zzOpenFileTypesInTextFileEditor.bash.CMD
- zzOpenFileTypesInTextFileEditor.versions.CMD
- zzZCz_Clear__historyFolders.CMD
- zzZRz_Rename_Version-3parm.CMD
- zzZRz_Rename_Version.CMD
- zzZRz_Rename_Version_Recursive.CMD
- zzZTz_Touch.CMD
- zzZTz_Touch.sh.CMD

### Folder:  .../deveops.dev/zzz_testing.wip

The '.../deveops.dev/zzz_testing.wip' folder is used for scripting R&D and documenting the results of the research and testing.

Not provided to GitHub.

### Folder Description Template

#### Documentation files

Documentation related files in formats that support the material presented.  Markdown (.md) files are used for text document style files, while Tab Separated Value (.tsv) files are used for table style information.

Files:

- x

#### Package Version Identification Files  

These files provide information regarding the version of the package of scripts.

Files:

- x

#### Environmental Control Files for Operational Script Execution (json)

These files are used for the actual operations of the scripts and utilized in the deployed environment.

Files:

- .environment_info.json

#### Environmental Control Files for Development Script Execution (json)

These files are used for the development operations of the scripts and utilized in the development environment, but can be utilized in the deployed environment for operations also at a later time.

Files:

- x

#### Script Files

Script Files:

- x

#### Script Template Files

Template files for scripts specific to this folder and/or operation.

Script Template Files:

- a

#### Windows Command Line (CMD) Development Environment Files (not commonly distributed or provided in GitHub)

Script files for use in Windows Command Line (CMD) Development Environment, potentially PowerShell in the future, to handle common operations during the script development process.  These Development Environment scripts may be environment specific to both the development technology/environment, as well as the script focus.  Intelligent naming is stipulated where plausible.  If a __Windows.CMD folder exists, then the details of the script file purposes is explained there.

Windows Command Line script Files:

- x

#### Y

Files:

- x

#### Not Provided to GitHub

Not provided to GitHub.

