# LIMITATIONS and CAVEATS

## UPDATED:  2023-03-08

This document outlines limitations and caveats to the implementation of R8X API export, import, set-update, and delete scripts utilizing bash mgmt_cli commands.

## DISCLAIMER

This is a work in progress and may update irregularly.

The author is currently utilizing R81.20 with API version 1.9 and these limitations and caveats are based on current experience on this level of implementation for the R8X API.

Currently, R81.20 GA T627 JHF N/A Take is implemented for testing

In some cases,

- the indicated limitations may be bugs or concept errors in the R8X API
- the limitation may exist because of the complexity of the object
- the limitation may exist due to security implementation restricting access to data needed at export, thus not having that data at import (e.g. passwords or shared secrets)

## LIMITATIONS and CAVEATS GENERAL

Testing of all scenarios is not plausible, so issues and problems should be reported for review and potential future fix.

This is a best effort development operation and benefitting of financial incentive, so missing features or capabilities might be addressed in the future, but there are zero guarantees.

## LIMITATIONS and CAVEATS VERSION SPECIFIC

R81.20 EA Public T437 - This release has provided some issues with changes under the hood of Gaia and also some challenges in changes to the API version 1.9 handling of objects on import via mgmt_cli.

- Service objects may fail to import if the values for aggressive aging set use of default timeout, but the column for timeout does not have a zero value, which might be exported because the database includes that issue.  
  - FIXED:  release v00.60.12.000, now create multiple export files depending on the object type parameters.
- User and User Template objects import has some issues that still need investigation

## LIMITATIONS and CAVEATS Authentication

It is recommended that operation of the scripts be preceeded by at least one manual authentication to the target management host (even local host) to overtly accept the management hosts certificate.

v00.60.08.060 :  To remove a cause of sudden apparent hang during logon, the mgmt_cli parameter (`--unsafe-auto-accept true`) was added to all authentication operations that include a defined management server (so parameter `-m {management_server_address}`) to avoid the hidden wait for acceptance of the remote management server certificate.

v00.60.08.060 :  Execution UI and logs now provide a command view of the mgmt_cli command executed with all parameters shown as utilized (except password which is shown as ***).  This should help with any troubleshooting on issues with authentication and evaluation of command line parameters.

## LIMITATIONS and CAVEATS by Management platform (SMS or MDSM)

SMS (Security Management Server) currenlty operates as expected and the ability to work with blocks of up-to 500 objects is possible.  With R81.10 JHF 9 GA Take, no issues with performance were identified explicitly.

MDSM (Multi-Domain Security Management) currenlty operates with significant impact to performance due to intentional management API throttling and CPM heap size limitation implemented to protect the MDSM MDS (Multi-Domain Server [host]) and the ability to work with blocks of up-to 500 objects is possible, except for certain objects where this block limit is set to 250.  With R81.10 JHF 9 GA Take, great issues with performance are identified and either domain specific export operations should be executed or plenty of time allocated.  This is very evident in operations with "application-site" objects, which on 2021-10 number about 9000+ objects, and can only be handled in slices of 250 objects to avoid mgmt_cli API time-out condition, which generates garbage data.

Research on improving performance is ongoing and efforts to address the MDSM performance impact through Secure Knowledge based guidance is in research.

Using R81+ api command provides the option to enable/disable throtting (`api on|off throttling`) and this can provide an option for faster execution and reduce the risk of timeouts; however, this needs to be tested on the MDSM and also impact to MDSM operation accounted for.

v00.60.08.055 :  To allow for users wanting to accelerate operation on MDSM, the command line options --OVERRIDEMAXOBJECTS and --MAXOBJECTS {value} were added to allow tweaking the max object limit to obtain a faster execution.

v00.06.08.075 :  Attempting to see how the mgmt_cli parameter --conn-timeout {value|180 default} seconds can improve operations, by adding to key mgmt_cli operations and setting value to 600 seconds.  Also added command line parameters to allow external configuration of that value.  Based on testing with MDSM MDS with 2 domains, operational levels using 250 object limit were achieved for "application-site" objects, which proved most impactful.

v00.60.12.000 :  Added additional output on error to try to determine the cause of the failure in both mgmt_cli and JQ query calls, since MDSM is still having issues with > 125 limit of objects, failing with error 502.

## LIMITATIONS and CAVEATS by Smart-1 Cloud (MaaS and EPMaaS)

Smart-1 Cloud (MaaS) is under development pending access capabilities and available time.  Some CLI plumbing (like --context) are provided, but are not tested adequately.

Addition of the --MaaS|--maas|--MAAS CLI option now specifically controls whether the scripts are to operate towards MaaS (Smart-1 Cloud), and stipulate required additional parameters to function.

Basic function of tested without successful authentication, so more testing and testing feedback needed/requested.

## LIMITATIONS and CAVEATS by object type

### General limitations

If the object does not provide a method to output a required key value during export, import may not provide that object's missing key value.  If possible, a subsequent additional step may address the issue.

v00.60.12.100 - Currently RADIUS server object and RADIUS servers group object types do not exist in API versions prior to R81.20 GA API version 1.9, so details about RADIUS configuration for neither export, nor import are possible as of current implementation of API 1.8.1 [R81.20 with JHF 79] and earlier.  Customers on version with API 1.9 and later have Radius Server and Radius Group objects.

### User Objects

- "authentication-method" significantly impacts export approach for user objects, thus the key "authentication-method" and values for it are not included in the basic user object export.  Instead they are handled in "authentication-method" specific complex object export, one CSV for each "authentication-method"

- RADIUS "authentication-method" supports import when the RADIUS server is set to "ANY"

- TACACS "server-type" DOES NOT support import when the TACACS server is set to "TACACS+", because the exported information is "TACACS_PLUS_" which is not the expected values

- Users with "authentication-method" "check point password" will get a generic complex password set in the CSV file, since the export of their password or even a hash is not avialable.  To import that user with a defined password for authentication, the CSV used for the import must be MANUALLY EDITED to reflect the desired actual password.  Careless import may clobber existing authentication settings and user known password.  CAVEAT EMPTOR!

- Certificates are currently not handled, export may not be plausible

### application-site Objects

- Check Point currently provides in excess of 10,000 actual application-site objects as part Application Control and URL Filtering updates, and even with a limited update there are thousands of values.
- The regular API calls associated with application-site objects DO NOTHING to address the need to distinguish customer created application-site objects or customer CLONED application-site objects.  The show application-sites "filter" parameter is of ZERO value and there are no examples of note provided to use it for such a query, which would still require parsing all 10K+ objects in slices no greater than 500 on SMS and 250 (or smaller) on MDSM 
- This object type has a significant level of effort required for both json and CSV export, especially if trying to obtain the customer's custom application-site objects.  This impact is extremely heavy on MDSM where current implementation (R81+) has implemented API throtteling to limit overall performance impact.
- As of script version v00.60.12.000, the application-site object is classified as a Critical Performance Impacting (CPI) object and not generally exported unless the --DO-CPI options is utilized in CLI parameters
- It is not recommended to execute CSV export of application-site objects by activating the --DO-CPI option, unless resourses and time are available, especially on MDSM!
- Weak management server hardware will have a drastic impact on the export of application-site objects and should be reviewed.
- Customers utilizing CLONED application-site objects should review their requirement and accept that they are not easily exported in CSV format.  JSON export and utilization of other methods to generate/import them are recommended, like using the Management API in REST approach via tools like POSTMAN, where the JSON can be reused with some edits.
- MITIGATION (minimum version v00.60.12.100.500):  to address the problem of exporting customer created custom application-site objects a method was found utilizing a Generic API generic object call that specifically allows showing the custom application-site objects created by the customer; however, this does not address CLONED application-site objects (which currenly don't have a mitigation!).  Utilization of the appication-site via generic object is NOT a CPI object approach and can export the customer's created custom application-sites
- WORKAROUND, ASSIST (minimum version v00.60.12.100.500):  if a full json export with all objects (-SO --format json) is generated with --DO-CPI before CSV export, then the most up-to-date json data for the application-sites is available and can accellerate the export to CSV if the esport is -NSO (so NO SYSTEM objects) with --DO-CPI.
- WARNING!  Nothing stops the execution with --DO-CPI when -SO and -OSO are selected, and using that combination -SO|-OSO --DO-CPI for Objects CSV or Special Objects CSV export will lead to a significant effort by the system to generate the 10K+ SYSTEM application-site objects, and their element exports for url-list and additional-categories, which are VERY intensive operations.  USE WITH EXTREME DILIGENCE

### User-Template Objects

- "authentication-method" significantly impacts export approach for user-template objects.  Unlike user objects, the basic details about the "authentication-method" are exportable and importable--with caveats

- RADIUS "authentication-method" DOES NOT support import when the RADIUS server is set to "ANY"

- TACACS "server-type" DOES NOT support import when the TACACS server is set to "TACACS+", because the exported information is "TACACS_PLUS_" which is not the expected value and requires manual adjustment to correctly import.  This operation of changing the output is not possible programatically at this juncture.

### User and User-Template Objects

- Locations currently not handled, as this requires a concept and approach

- Times currently not handled, as this requires a concept and approach

### LSM Objects

- lsm-gateway and lsm-cluster objects are Work-In-Progress (WIP) and may not provide CSV results of value until further data can be collected and analyzed

- v00.60.08.060 :  lsm-gateway[s] now provides limited CSV data that can work for import, as well as a CSV export NOT_FOR_IMPORT of raw information from the lsm-gateway objects as a reference for the implemented system.

### SMTP Server Objects

- The password field won't export, so it is populated with a placeholder value that needs to be either set before import, or reset on the object

- Since the smtp-server object can exist with our without username and password, additional harvesting is required to harvest those smtp-servers with username and password (authenticaton = true), as well as those without username and password (authenticaton = false)

### Network Feed Objects

- This object has an option to configure any number of custom-header names and values and the current scripting (v00.60.12) harvests the first five (5) of these value pairs.  If more are required, either editing and expanding the number to cover the needed additional values is required.

### Interoperable Device Objects

- Since these are essentially third-party gateways, or gateways managed by other management servers, there are many more interfaces configured than just a single one.  The current implementation only harvests the first interface.  Additional interface harvesting may happen later, if code for that process is not significantly difficult.

### SmartTask Objects

- This object has a potential problem importing because of the way the e-mail body for certain tasks is saved, not as a base64 encooded datum, but instead implants escaped characters to handle some functions.  Export to CSV is handled such that the JQ option for "( .["${key}"] | tojson )" is utilized to generate a result that includes the original escaped characters (so essentially almost the same raw JSON from the mgmt_cli query); however, in the CSV this result is provide with tripple double-quotes (""") on either end, which may cause issues on import.
- FEEDBACK for the import of this object would be appreciated.
