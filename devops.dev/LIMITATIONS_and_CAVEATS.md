# LIMITATIONS and CAVEATS

### UPDATED:  2021-11

This document outlines limitations and caveats to the implementation of R8X API export, import, set-update, and delete scripts utilizing bash mgmt_cli commands.

## DISCLAIMER

This is a work in progress and may update irregularly.

The author is currently utilizing R81 with API version 1.7 and these limitations and caveats are based on current experience on this level of implementation for the R8X API.

Currently, R81.10 JHF 9 GA Take is implemented for testing

In some cases, 
- the indicated limitations may be bugs or concept errors in the R8X API
- the limitation may exist because of the complexity of the object
- the limitation may exist due to security implementation restricting access to data needed at export, thus not having that data at import (e.g. passwords or shared secrets)

## LIMITATIONS and CAVEATS GENERAL

Testing of all scenarios is not plausible, so issues and problems should be reported for review and potential future fix.

This is a best effort development operation and benefitting of financial incentive, so missing features or capabilities might be addressed in the future, but there are zero guarantees.

## LIMITATIONS and CAVEATS by Management platform (SMS or MDMS)

SMS (Security Management Server) currenlty operates as expected and the ability to work with blocks of up-to 500 objects is possible.  With R81.10 JHF 9 GA Take, no issues with performance were identified explicitly.

MDSM (Multi-Domain Security Management) currenlty operates with significant impact to performance due to intentional management API throttling and CPM heap size limitation implemented to protect the MDSM MDS (Multi-Domain Server [host]) and the ability to work with blocks of up-to 200 objects is possible, except for certain objects where this block limit is set to 100.  With R81.10 JHF 9 GA Take, great issues with performance are identified and either domain specific export operations should be executed or plenty of time allocated.  This is very evident in operations with "application-site" objects, which on 2021-10 number about 9000+ objects, and can only be handled in slices of 100 objects to avoid mgmt_cli API time-out condition, which generates garbage data.

Research on improving performance is ongoing and efforts to address the MDSM performance impact through Secure Knowledge based guidance is in research.

Using R81+ api command provides the option to enable/disable throtting (`api on|off throttling`) and this can provide an option for faster execution and reduce the risk of timeouts; however, this needs to be tested on the MDSM and also impact to MDSM operation accounted for.

To allow for users wanting to accelerate operation on MDSM, the command line options --OVERRIDEMAXOBJECTS and --MAXOBJECTS {value} were added to allow tweaking the max object limit to obtain a faster execution.

## LIMITATIONS and CAVEATS by Smart-1 Cloud (MaaS and EPMaaS)

Smart-1 Cloud (MaaS) is under development pending access capabilities and available time.  Some CLI plumbing (like --context) are provided, but are not tested adequately.

Addition of the --MaaS|--maas|--MAAS CLI option now specifically controls whether the scripts are to operate towards MaaS (Smart-1 Cloud), and stipulate required additional parameters to function.

More testing and testing feedback needed/requested.

## LIMITATIONS and CAVEATS by object type

### General limitations
If the object does not provide a method to output a required key value during export, import may not provide that object's missing key value.  If possible, a subsequent additional step may address the issue.

Currently RADIUS server object and RADIUS servers group object types do not exist, so details about RADIUS configuration for neither export, nor import are possible as of current implementation of API 1.7.

### User Objects
- "authentication-method" significantly impacts export approach for user objects, thus the key "authentication-method" and values for it are not included in the basic user object export.  Instead they are handled in "authentication-method" specific complex object export, one CSV for each "authentication-method"

- RADIUS "authentication-method" supports import when the RADIUS server is set to "ANY"

- TACACS "server-type" DOES NOT support import when the TACACS server is set to "TACACS+", because the exported information is "TACACS_PLUS_" which is not the expected values

- Users with "authentication-method" "check point password" will get a generic complex password set in the CSV file, since the export of their password or even a hash is not avialable.  To import that user with a defined password for authentication, the CSV used for the import must be MANUALLY EDITED to reflect the desired actual password.  Careless import may clobber existing authentication settings and user known password.  CAVEAT EMPTOR!

- Certificates are currently not handled, export may not be plausible

### User-Template Objects
- "authentication-method" significantly impacts export approach for user-template objects.  Unlike user objects, the basic details about the "authentication-method" are exportable and importable--with caveats

- RADIUS "authentication-method" DOES NOT support import when the RADIUS server is set to "ANY"

- TACACS "server-type" DOES NOT support import when the TACACS server is set to "TACACS+", because the exported information is "TACACS_PLUS_" which is not the expected values

### User and User-Template Objects
- Locations currently not handled, as this requires a concept and approach

- Times currently not handled, as this requires a concept and approach
    

### LSM Objects
- lsm-gateway and lsm-cluster objects are Work-In-Progress (WIP) and may not provide CSV results of value until further data can be collected and analyzed

    
