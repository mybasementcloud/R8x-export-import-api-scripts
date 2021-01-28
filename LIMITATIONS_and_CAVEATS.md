# LIMITATIONS and CAVEATS

This document outlines limitations and caveats to the implementation of R8X API export, import, set-update, and delete scripts utilizing bash mgmt_cli commands.

## DISCLAIMER

This is a work in progress and may update irregularly.

The author is currently utilizing R81 with API version 1.7 and these limitations and caveats are based on current experience on this level of implementation for the R8X API.

Currently, R81 JHF 11 Ongoing Take is implemented for testing

In some cases, 
- the indicated limitations may be bugs or concept errors in the R8X API
- the limitation may exist because of the complexity of the object
- the limitation may exist due to security implementation restricting access to data needed at export, thus not having that data at import (e.g. passwords or shared secrets)

## LIMITATIONS and CAVEATS by object type

### General limitations
If the object does not provide a method to output a required key value during export, import may not provide that object's missing key value.  If possible, a subsequent additional step may address the issue.

Currently RADIUS server object and RADIUS servers group object types do not exist, so details about RADIUS configuration for neither export, nor import are possible as of current implementation of API 1.7.

### User Objects
    1.) "authentication-method" significantly impacts export approach for user objects, thus the key "authentication-method" and values for it are not included in the basic user object export.  Instead they are handled in "authentication-method" specific complex object export, one CSV for each "authentication-method"

    2.)  RADIUS "authentication-method" supports import when the RADIUS server is set to "ANY"

    3.)  TACACS "authentication-method" DOES NOT support import when the RADIUS server is set to "ANY"

    4.)  Certificates are currently not handled, export may not be plausible

    5.)  Users with "authentication-method" "check point password" will get a generic complex password set in the CSV file, since the export of their password or even a hash is not avialable.  To import that user with a defined password for authentication, the CSV used for the import must be MANUALLY EDITED to reflect the desired actual password.  Careless import may clobber existing authentication settings and user known password.  CAVEAT EMPTOR!

### User-Template Objects
    1.) "authentication-method" significantly impacts export approach for user-template objects.  Unlike user objects, the basic details about the "authentication-method" are exportable and importable--with caveats

    2.)  RADIUS "authentication-method" DOES NOT support import when the RADIUS server is set to "ANY"

    3.)  TACACS "authentication-method" DOES NOT support import when the RADIUS server is set to "ANY"

