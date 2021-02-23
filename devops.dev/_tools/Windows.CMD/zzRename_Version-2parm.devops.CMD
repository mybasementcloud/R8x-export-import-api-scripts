@ECHO OFF
REM
REM Script  :  Rename Files with Version using 2 parameters : OldVersion, NewVersion - devops[.dev] folder specific
REM
REM # (C) 2016-2021 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/
REM #
REM # ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR 
REM # DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE 
REM # RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
REM # TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
REM # OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
REM # APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
REM # AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
REM #
REM #

SET _LOCALSCRIPTNAME=zzRename_Version-2parm.devops
SET _LOCALSCRIPTDATE=2021-02-22
SET _LOCALSCRIPTTIME=2100CDT
SET _LOCALSCRIPTVERSION=v06.03.01
SET _LOCALSCRIPTREVISION=000

SET "_LOCALSCRIPTDESCRIPTION=Rename Files with Version using 2 parameters : OldVersion, NewVersion - devops[.dev] folder specific"
SET "_LOCALSCRIPTDESCRIPTIONSHORT=Rename Files with Version using 2 parameters, devops.dev"

@ECHO:
@ECHO:=====================================================================================
@ECHO:=====================================================================================
@ECHO: SCRIPT Name:  %_LOCALSCRIPTNAME%
@ECHO: SCRIPT VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION%  DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME%
@ECHO: SCRIPT CALLED     :  %0
@ECHO: SCRIPT PARAMETERS :  %*
@ECHO:=====================================================================================
@ECHO:


SET "_scriptStartPath=%CD%"
@ECHO: _scriptStartPath : "%_scriptStartPath%"
@ECHO:

REM CHECK IF WE ARE CLEANING UP AFTER OURSELVES
if "%~1"=="" GOTO :NOCALLPARM1
if "%1"=="--CLEANUP--" GOTO :CLEANUP_SUBROUTINES

:NOCALLPARM1
GOTO :STARTSCRIPT

REM =====================================================================================
REM =====================================================================================
REM =====================================================================================
REM START OF SUBROUTINES
REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  DeQuote  :  Purpose/Description
REM -------------------------------------------------------------------------------------

:DeQuote

for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A


EXIT /B

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  DeQuote
REM * -----------------------------------------------------------------------------------

REM * Example:
REM *    Set _mypath="C:\Program Files\ss64\"
REM *    CALL :dequote _mypath
REM *    Echo %_mypath%

REM CALL :DeQuote %parameter%

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  DeQuote
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_GetStringLength  :  Purpose/Description
REM -------------------------------------------------------------------------------------

:sub_GetStringLength

Setlocal EnableDelayedExpansion
:: strLen String [RtnVar]
::             -- String  The string to be measured, surround in quotes if it contains spaces.
::             -- RtnVar  An optional variable to be used to return the string length.
Set "s=#%~1"
Set "len=0"
For %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
  if "!s:~%%N,1!" neq "" (
    set /a "len+=%%N"
    set "s=!s:~%%N!"
  )
)
Endlocal&if "%~2" neq "" (set %~2=%len%) else echo %len%


EXIT /B

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_GetStringLength
REM * -----------------------------------------------------------------------------------

REM CALL :sub_GetStringLength %string_to_check% [%length_variable_name%]

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_GetStringLength
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_SETLOGSLOCATION :  Configure logs folder FQDN
REM -------------------------------------------------------------------------------------

REM ADDED 2021-02-07

:sub_SETLOGSLOCATION

REM ----------------------------------------------------------------
REM Find __LOGS folder
REM ----------------------------------------------------------------

SET "LOGGINGPATH="

if exist ".\__LOGS" GOTO :SETLOGSFOLDER_CURRENT
if exist "..\__LOGS" GOTO :SETLOGSFOLDER_PARENT
if exist "\__LOGS" GOTO :SETLOGSFOLDER_ROOT

GOTO :LASTCHKLOGS

:SETLOGSFOLDER_CURRENT
SET "LOGGINGPATH=.\__LOGS"
PUSHD "%LOGGINGPATH%"
SET "LOGGINGPATH=%CD%"
POPD
GOTO :LASTCHKLOGS

:SETLOGSFOLDER_PARENT
SET "LOGGINGPATH=..\__LOGS"
PUSHD "%LOGGINGPATH%"
SET "LOGGINGPATH=%CD%"
POPD
GOTO :LASTCHKLOGS

:SETLOGSFOLDER_ROOT
SET "LOGGINGPATH=\__LOGS"
PUSHD "%LOGGINGPATH%"
SET "LOGGINGPATH=%CD%"
POPD
GOTO :LASTCHKLOGS

:LASTCHKLOGS
IF NOT "%LOGGINGPATH%"=="" GOTO :LOGSCHKDONE
SET "LOGGINGPATH=%TEMP%"

REM ----------------------------------------------------------------

:LOGSCHKDONE

@ECHO: Current Logging Path : "%LOGGINGPATH%"
@ECHO:

REM ----------------------------------------------------------------


EXIT /B 0

REM ----------------------------------------------------------------
REM ----------------------------------------------------------------


REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_SETLOGSLOCATION
REM -------------------------------------------------------------------------------------

REM SET "LOGGINGPATH="
REM CALL :sub_SETLOGSLOCATION

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_SETLOGSLOCATION
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_CLEANUPLOCALVARS  :  
REM -------------------------------------------------------------------------------------

:sub_CLEANUPLOCALVARS

REM * -------------------------------------------------------------------------
REM * CLEAN UP Local Variables
REM * -------------------------------------------------------------------------

SET "_localLOGFILE="
SET "_remoteLOGFILE="

SET "FILEEDITOR="
SET "FILEEDITORNAME="
SET "DATETIMEGRP="

SET "_JUSTDOIT="


EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_CLEANUPLOCALVARS
REM -------------------------------------------------------------------------------------

REM CALL :sub_CLEANUPLOCALVARS

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_CLEANUPLOCALVARS
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_CLEANUPRESULTVARS  :  
REM -------------------------------------------------------------------------------------

:sub_CLEANUPRESULTVARS

REM * -------------------------------------------------------------------------
REM * Variables we want to keep for use by the callers
REM * -------------------------------------------------------------------------


EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_CLEANUPRESULTVARS
REM -------------------------------------------------------------------------------------

REM CALL :sub_CLEANUPRESULTVARS

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_CLEANUPRESULTVARS
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_CLEANUPLOCALSTANDARDVARS  :  Clear Local Standard Variables
REM -------------------------------------------------------------------------------------

:sub_CLEANUPLOCALSTANDARDVARS

REM * -------------------------------------------------------------------------
REM * CLEAN UP Local Standard Variables
REM * -------------------------------------------------------------------------

SET "_LOCALSCRIPTNAME="
SET "_LOCALSCRIPTDATE="
SET "_LOCALSCRIPTTIME="
SET "_LOCALSCRIPTVERSION="
SET "_LOCALSCRIPTREVISION="

SET "_scriptLOGSDIR="
SET "_scriptLOGSPATH="
SET "_scriptLOGSFILE="

SET "_HOST_NAME="


EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_CLEANUPLOCALSTANDARDVARS
REM -------------------------------------------------------------------------------------

REM CALL :sub_CLEANUPLOCALSTANDARDVARS

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_CLEANUPLOCALSTANDARDVARS
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_SetTextFileEditorValue  :  Purpose/Description
REM -------------------------------------------------------------------------------------

:sub_SetTextFileEditorValue

REM * -------------------------------------------------------------------------
REM * CodeSnipet :  Set Text File Editor value
REM * -------------------------------------------------------------------------

SET "FILEEDITOR="

IF EXIST "%ProgramFiles%\Just Great Software\EditPad Pro 8\EditPadPro8.exe" GOTO :HAVEEDITPADPRO8
IF EXIST "%ProgramFiles%\Just Great Software\EditPad Lite 8\EditPadLite8.exe" GOTO :HAVEEDITPADLITE8
IF EXIST "%ProgramFiles%\Just Great Software\EditPad Lite 7\EditPadLite7.exe" GOTO :HAVEEDITPADLITE7
SET FILEEDITORNAME=NOTEPAD
SET FILEEDITOR=%windir%\NOTEPAD.EXE
GOTO :EDITORISSET

:HAVEEDITPADPRO8
SET FILEEDITORNAME=EditPad Pro 8
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Pro 8\EditPadPro8.exe
GOTO :EDITORISSET

:HAVEEDITPADLITE8
SET FILEEDITORNAME=EditPad Lite 8
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Lite 8\EditPadLite8.exe
GOTO :EDITORISSET

:HAVEEDITPADLITE7
SET FILEEDITORNAME=EditPad Lite 7
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Lite 7\EditPadLite7.exe
GOTO :EDITORISSET

:EDITORISSET
REM START "%FILEEDITORNAME%" /MAX /B "%FILEEDITOR%" "%_scriptLOGFQPN%"

REM * -------------------------------------------------------------------------
REM * -------------------------------------------------------------------------

EXIT /B 0

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_SetTextFileEditorValue
REM * -----------------------------------------------------------------------------------

REM SET "FILEEDITORNAME="
REM SET "FILEEDITOR="
REM CALL :sub_SetTextFileEditorValue

REM START "%FILEEDITORNAME%" /MAX /B "%FILEEDITOR%" "%_scriptLOGFQPN%"

REM -------------------------------------------------------------------------------------
REM SUBROUTINE CLEANUP : sub_SetTextFileEditorValue
REM -------------------------------------------------------------------------------------

:cleanup_sub_SetTextFileEditorValue

@ECHO:CLEAN UP sub_SetTextFileEditorValue

SET "FILEEDITORNAME="
SET "FILEEDITOR="

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_CLEARCONFIGSCRIPTPATHSVARS  :  Clear sub_CONFIGSCRIPTPATHS Working Variables
REM -------------------------------------------------------------------------------------

:sub_CLEARCONFIGSCRIPTPATHSVARS

REM * -------------------------------------------------------------------------
REM * Clear sub_CONFIGSCRIPTPATHS Working Variables
REM * -------------------------------------------------------------------------

SET "subroutinescriptname="
SET "subroutinescriptext="
SET "subroutinescriptfile="
SET "subroutinecommonpath=" 
SET "subroutinecommonfqpn=" 


EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_CLEARCONFIGSCRIPTPATHSVARS
REM -------------------------------------------------------------------------------------

REM CALL :sub_CLEARCONFIGSCRIPTPATHSVARS

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_CLEARCONFIGSCRIPTPATHSVARS
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_CONFIGSCRIPTPATHS  :  Configure Script Paths
REM -------------------------------------------------------------------------------------

:sub_CONFIGSCRIPTPATHS

REM * -------------------------------------------------------------------------
REM * Subroutine Operations
REM * -------------------------------------------------------------------------

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:Subroutine sub_CONFIGSCRIPTPATHS Start >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

SET "subroutinecommonpath=" 
SET "subroutinecommonfqpn="
SET "ERRORRETURN=0"

SET "testthispath=.\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO:Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%" 2>>&1

SET "testthispath=R:\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO:Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%" 2>>&1

SET "testthispath=S:\Updates\Software\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO:Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%" 2>>&1

SET "ERRORRETURN=100"
@ECHO:Did not find target path ! >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
GOTO :SUBRTCMNPATHSET

:SUBRTCMNPATHFOUND
@ECHO:Found target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%" 2>>&1
SET "subroutinecommonpath=%testthispath%"
SET "subroutinecommonfqpn=%testthisfqpn%"

:SUBRTCMNPATHSET

REM * -------------------------------------------------------------------------
REM * Log Current Values
REM * -------------------------------------------------------------------------

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:subroutinescriptname   = %subroutinescriptname% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:subroutinescriptext    = %subroutinescriptext% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:subroutinescriptfile   = %subroutinescriptfile% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:subroutinecommonpath   = %subroutinecommonpath% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:subroutinecommonfqpn   = %subroutinecommonfqpn% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:testthispath           = %testthispath% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:testthisfqpn           = %testthisfqpn% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:ERRORRETURN            = %ERRORRETURN% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:Subroutine sub_CONFIGSCRIPTPATHS Finished >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

SET "testthispath="
SET "testthisfqpn="

EXIT /B %ERRORRETURN%

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_CONFIGSCRIPTPATHS
REM -------------------------------------------------------------------------------------

REM SET "xSetParameter1="
REM CALL :sub_CONFIGSCRIPTPATHS

REM -------------------------------------------------------------------------------------
REM SUBROUTINE CLEANUP : sub_CONFIGSCRIPTPATHS
REM -------------------------------------------------------------------------------------

:cleanup_sub_CONFIGSCRIPTPATHS

@ECHO:CLEAN UP sub_CONFIGSCRIPTPATHS

SET "subroutinecommonpath=" 
SET "subroutinecommonfqpn="
REM SET "ERRORRETURN="

SET "testthispath="
SET "testthisfqpn="

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_CONFIGSCRIPTPATHS
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_CLEARDTGTZSUFFIXVARS  :  
REM -------------------------------------------------------------------------------------

:sub_CLEARDTGTZSUFFIXVARS

REM * -------------------------------------------------------------------------
REM * Variables we want to keep for use by the callers
REM * -------------------------------------------------------------------------

SET "_TZTYPE="
SET "_TZTIMEOFYEAR="
SET "_TZCURRENTNAME="
SET "_TZABR="
SET "_TZABRSTZ="
SET "_TZABRDTZ="
SET "_TZCURRENTNAMENOQUOTES="

SET "_DTTZ_SUFFIX_DATE="
SET "_DTTZ_SUFFIX_DATEDASH="
SET "_DTTZ_SUFFIX_TIME="
SET "_DTTZ_SUFFIX_DTG="
SET "_DTTZ_SUFFIX_DTGDASH="
SET "_DTTZ_SUFFIX_TIMETZ="
SET "_DTTZ_SUFFIX_DTGTZ="
SET "_DTTZ_SUFFIX_DTGTZDASH="


EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_CLEARDTGTZSUFFIXVARS
REM -------------------------------------------------------------------------------------

REM CALL :sub_CLEARDTGTZSUFFIXVARS

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_CLEARDTGTZSUFFIXVARS
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_LOGDTGTZSUFFIXRESULTS  :  Log Results
REM -------------------------------------------------------------------------------------

:sub_LOGDTGTZSUFFIXRESULTS

REM * -------------------------------------------------------------------------
REM * Log Results
REM * -------------------------------------------------------------------------

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:Time Zone value processing results: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_TZTIMEOFYEAR          = "%_TZTIMEOFYEAR%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_TZTYPE                = "%_TZTYPE%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_TZCURRENTNAME         = "%_TZCURRENTNAME%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_TZABR                 = "%_TZABR%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_TZABRSTZ              = "%_TZABRSTZ%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_TZABRDTZ              = "%_TZABRDTZ%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_TZCURRENTNAMENOQUOTES = "%_TZCURRENTNAMENOQUOTES%" >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:Date Time Time Zone suffix value results: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_DTTZ_SUFFIX_DATE      = "%_DTTZ_SUFFIX_DATE%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_DTTZ_SUFFIX_DATEDASH  = "%_DTTZ_SUFFIX_DATEDASH%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_DTTZ_SUFFIX_TIME      = "%_DTTZ_SUFFIX_TIME%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_DTTZ_SUFFIX_DTG       = "%_DTTZ_SUFFIX_DTG%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_DTTZ_SUFFIX_DTGDASH   = "%_DTTZ_SUFFIX_DTGDASH%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_DTTZ_SUFFIX_TIMETZ    = "%_DTTZ_SUFFIX_TIMETZ%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_DTTZ_SUFFIX_DTGTZ     = "%_DTTZ_SUFFIX_DTGTZ%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:_DTTZ_SUFFIX_DTGTZDASH = "%_DTTZ_SUFFIX_DTGTZDASH%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1


REM * -------------------------------------------------------------------------

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_LOGDTGTZSUFFIXRESULTS
REM -------------------------------------------------------------------------------------

REM CALL :sub_LOGDTGTZSUFFIXRESULTS

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_LOGDTGTZSUFFIXRESULTS
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM END OF SUBROUTINES
REM =====================================================================================
REM =====================================================================================
REM =====================================================================================


:STARTSCRIPT

REM =====================================================================================
REM CLEAR MAIN LOCAL VARIABLES
REM =====================================================================================

CALL :sub_CLEANUPLOCALVARS

REM * =========================================================================
REM *  Handle Logging Variables, Folders, Paths, and Files
REM * =========================================================================


SET "LOGGINGPATH="
CALL :sub_SETLOGSLOCATION

REM SET _scriptLOGSDIR=C:\TEMP
REM SET _scriptLOGSDIR=%TEMP%
SET "_scriptLOGSDIR=%LOGGINGPATH%"
SET "_scriptLOGSPATH=%_scriptLOGSDIR%"
SET "_scriptLOGSFILE=%_LOCALSCRIPTNAME%.log"
SET "_scriptLOGFQPN=%_scriptLOGSPATH%\%_scriptLOGSFILE%"

IF NOT EXIST "%_scriptLOGSDIR%" MKDIR "%_scriptLOGSDIR%"
IF NOT EXIST "%_scriptLOGSPATH%" MKDIR "%_scriptLOGSPATH%"

@ECHO: > "%_scriptLOGFQPN%"


REM =====================================================================================
REM =====================================================================================


@ECHO:===================================================================================== >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: SCRIPT Name:  %_LOCALSCRIPTNAME% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: SCRIPT VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION%  DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: SCRIPT CALLED     :  %0 >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: SCRIPT PARAMETERS :  %* >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:===================================================================================== >> "%_scriptLOGFQPN%" 2>>&1
REM @ECHO: >> "%_scriptLOGFQPN%" 2>>&1


REM =====================================================================================
REM =====================================================================================


REM @ECHO: ============================================================================= >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: Script Logging Details - Initial >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _scriptLOGSDIR         ="%_scriptLOGSDIR%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _scriptLOGSPATH        ="%_scriptLOGSPATH%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _scriptLOGSFILE        ="%_scriptLOGSFILE%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _scriptLOGFQPN         ="%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: ============================================================================= >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1


REM =====================================================================================
REM Configure Text File Editor value
REM =====================================================================================

CALL :sub_SetTextFileEditorValue

REM =====================================================================================
REM =====================================================================================


REM * ===================================================================================
REM * -----------------------------------------------------------------------------------
REM * START:  Set Date and Time Group values
REM * -----------------------------------------------------------------------------------

REM * -----------------------------------------------------------------------------------
REM * Variables for Script paths
REM * -----------------------------------------------------------------------------------

CALL :sub_CLEARCONFIGSCRIPTPATHSVARS

REM * -----------------------------------------------------------------------------------
REM * Set Local Variables for DTG_SUFFIX subroutine
REM * -----------------------------------------------------------------------------------

SET "subroutinescriptname=subroutine.Set_DTG_SUFFIX.COMPACT"
SET "subroutinescriptext=CMD"
SET "subroutinescriptfile=%subroutinescriptname%.%subroutinescriptext%"
SET "subroutinecommonpath="
SET "subroutinecommonfqpn="

REM * -----------------------------------------------------------------------------------
REM * Variables set by call to DTG_SUFFIX subroutine
REM * -----------------------------------------------------------------------------------

CALL :sub_CLEARDTGTZSUFFIXVARS

REM * -----------------------------------------------------------------------------------
REM * Configure basic variables and set appropriate subroutine paths
REM * -----------------------------------------------------------------------------------

CALL :sub_CONFIGSCRIPTPATHS

REM * -----------------------------------------------------------------------------------
REM * Call the operational subroutine to set the required values
REM * -----------------------------------------------------------------------------------

IF NOT EXIST "%subroutinecommonpath%" GOTO :ERRNOCOMMONSUBROUTINESPATH
IF NOT EXIST "%subroutinecommonfqpn%" GOTO :ERRNOSUBROUTINESCRIPT

REM * -----------------------------------------------------------------------------------
REM * Protect Local Log File value _scriptLOGFQPN since that is used in the called subroutine
REM * -----------------------------------------------------------------------------------

SET "_localLOGFILE="
SET "_remoteLOGFILE="
SET "_localLOGFILE=%_scriptLOGFQPN%"

@ECHO:------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:Executing script "%subroutinecommonfqpn%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1

CALL "%subroutinecommonfqpn%"

@ECHO:------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:Script "%subroutinecommonfqpn%" Completed >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1

REM * -----------------------------------------------------------------------------------
REM * Restore Local Log File value _scriptLOGFQPN and retain remote subroutine _scriptLOGFQPN value
REM * -----------------------------------------------------------------------------------

SET "_remoteLOGFILE=%_scriptLOGFQPN%"
SET "_scriptLOGFQPN=%_localLOGFILE%"

REM * -----------------------------------------------------------------------------------
REM * Log the results
REM * -----------------------------------------------------------------------------------

CALL :sub_LOGDTGTZSUFFIXRESULTS


REM * -----------------------------------------------------------------------------------
REM * END:  Set Date and Time Group values
REM * -----------------------------------------------------------------------------------
REM * ===================================================================================

REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM START MAIN OPERATIONS
REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM CONFIGURE STANDARD LOCAL VARIABLES
REM =====================================================================================

SET "_scriptTempWORKDIR=%_scriptLOGSDIR%"
SET "DATETIMEGRP=%_DTTZ_SUFFIX_DTGTZDASH%"
SET "_HOST_NAME=%COMPUTERNAME%"

SET "_JUSTDOIT="
REM CHECK IF WE ARE CLEANING UP AFTER OURSELVES
@ECHO:Parameter 1 = %1 >> "%_scriptLOGFQPN%" 2>>&1
if "%~1"=="" GOTO :NOCALLPARM1
if %1=="--CLEANUP--" GOTO :CLEANUP_SUBROUTINES
IF %1=="--AUTO--" SET "_JUSTDOIT=TRUE"

:NOCALLPARM1

REM =====================================================================================
REM CONFIGURE LOCAL VARIABLES - UPDATED _scriptLOGFQPN
REM =====================================================================================

SET "_tempLOGFILE=%_scriptLOGFQPN%"
SET "_scriptLOGSPATH=%_scriptLOGSDIR%"
SET "_scriptLOGSFILE=log_%_LOCALSCRIPTNAME%_%DATETIMEGRP%.log"
SET "_scriptLOGFQPN=%_scriptLOGSPATH%\%_scriptLOGSFILE%"

TYPE "%_tempLOGFILE%" > "%_scriptLOGFQPN%"
IF /I NOT "%_tempLOGFILE%"=="%_scriptLOGFQPN%" GOTO :DONEXFERLOGFILE

DEL /F/Q "%_tempLOGFILE%"

:DONEXFERLOGFILE

@ECHO: =============================================================================
@ECHO: ============================================================================= >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: Script Logging Details - Final
@ECHO: Script Logging Details - Final >> "%_scriptLOGFQPN%" 2>>&1
REM @ECHO:  _scriptLOGSDIR         ="%_scriptLOGSDIR%"
@ECHO:  _scriptLOGSDIR         ="%_scriptLOGSDIR%" >> "%_scriptLOGFQPN%" 2>>&1
REM @ECHO:  _scriptLOGSPATH        ="%_scriptLOGSPATH%"
@ECHO:  _scriptLOGSPATH        ="%_scriptLOGSPATH%" >> "%_scriptLOGFQPN%" 2>>&1
REM @ECHO:  _scriptLOGSFILE        ="%_scriptLOGSFILE%"
@ECHO:  _scriptLOGSFILE        ="%_scriptLOGSFILE%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _scriptLOGFQPN         ="%_scriptLOGFQPN%"
@ECHO:  _scriptLOGFQPN         ="%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%" 2>>&1
REM @ECHO:  _tempLOGFILE           ="%_tempLOGFILE%"
@ECHO:  _tempLOGFILE           ="%_tempLOGFILE%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: =============================================================================
@ECHO: ============================================================================= >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
REM @ECHO:
REM =====================================================================================
REM CONFIGURE LOCAL VARIABLES
REM =====================================================================================

REM 

REM =====================================================================================
REM GET TO WHERE THE WORK IS DONE
REM =====================================================================================

REM CD /D "%_scriptTempWORKDIR%" 

REM PUSHD "%_scriptTempWORKDIR%" 

@ECHO:%_LOCALSCRIPTDESCRIPTIONSHORT%
@ECHO:
@ECHO:%_LOCALSCRIPTDESCRIPTIONSHORT% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

IF "%_JUSTDOIT%"=="TRUE" GOTO :WEAREGOODTOGO

REM SET "HOST_NAME="
REM SET /p SERVER_NAME=Enter DHCP Server Name: ( %_HOST_NAME% )^>
REM IF NOT "%HOST_NAME%"=="" set "_HOST_NAME=%_HOST_NAME%"
REM SET "HOST_NAME="

REM SET "ENTERDATETIMEGRP="
REM SET /p ENTERDATETIMEGRP=Check DTGtzn: (%DATETIMEGRP% YYYY-MM-DD-HHMMtzn)^>
REM IF NOT "%ENTERDATETIMEGRP%"=="" set "DATETIMEGRP=%ENTERDATETIMEGRP%"
REM SET "ENTERDATETIMEGRP="

:WEAREGOODTOGO

REM * ===================================================================================
REM * ===================================================================================
REM * Open File Types in Text File Editor
REM * ===================================================================================
REM * ===================================================================================

GOTO :SKIPMAINSUBROUTINES

REM =====================================================================================
REM =====================================================================================
REM =====================================================================================
REM START OF MAIN SUBROUTINES
REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_ProcessFolderFileRename  :  Process a File in the folder
REM -------------------------------------------------------------------------------------

:sub_ProcessFolderFileRename

REM parameter 1 :  File in Folder

REM -------------------------------------------------------------------------------------

SET "_localFILEFOLDER="

SET "_localFILEFOLDER=%~1"

if exist "%_localFILEFOLDER%" goto :Parm1Set

@ECHO:   Folder does not exist ="%_localFILEFOLDER%"
@ECHO:   Skipping!
@ECHO:   Folder does not exist ="%_localFILEFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO:   Skipping! >> "%_scriptLOGFQPN%"

SET "_localFILE="

EXIT /B


:Parm1Set
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_ProcessFolderFileRename Start >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"


@ECHO:   Process Folder ="%_localFILEFOLDER%"
@ECHO:   Process Folder ="%_localFILEFOLDER%" >> "%_scriptLOGFQPN%"

brc64.exe /DIR:"%_localFILEFOLDER%" /PATTERN:"*.*" /REPLACECI:"%OLDVERSVALUE%":"%NEWVERSVALUE%" >> "%_scriptLOGFQPN%" /EXECUTE >> "%_scriptLOGFQPN%"

IF NOT EXIST "%_localFILEFOLDER%\help.%OLDVERSVALUE%" GOTO :NOHELPFOLDERTOMOVE

@ECHO:   Process Folder Help ="%_localFILEFOLDER%\help.%OLDVERSVALUE%"
@ECHO:   Process Folder Help ="%_localFILEFOLDER%\help.%OLDVERSVALUE%" >> "%_scriptLOGFQPN%"

MOVE "%_localFILEFOLDER%\help.%OLDVERSVALUE%" "%_localFILEFOLDER%\help.%NEWVERSVALUE%" >> "%_scriptLOGFQPN%"

:NOHELPFOLDERTOMOVE

@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_ProcessFolderFileRename Finished >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

SET "_localFILE="

EXIT /B

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_ProcessFolderFileRename
REM * -----------------------------------------------------------------------------------

REM CALL :sub_ProcessFolderFileRename %parameter%

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_ProcessFolderFileRename
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM END OF MAIN SUBROUTINES
REM =====================================================================================
REM =====================================================================================
REM =====================================================================================

:SKIPMAINSUBROUTINES

REM * ===================================================================================
REM * ===================================================================================
REM * Rename version X to version Y in folders for devops.dev
REM * ===================================================================================
REM * ===================================================================================

@ECHO: >> "%_scriptLOGFQPN%"

REM -----------------------------------------------------------------
REM -----------------------------------------------------------------


REM -----------------------------------------------------------------
REM Set new version
REM -----------------------------------------------------------------

SET OLDVERSVALUE=00x00x00

@ECHO:
@ECHO: Paramter 1 = "%1"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Paramter 1 = "%1" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM ECHO ON

REM ----------------------------------------------------------------
REM Ask if this version is sufficient OK
REM ----------------------------------------------------------------
SET CHKOLDVERSVALUE=%1

:ASKOLDVEROK
SET OPT1=Y
@ECHO:
@ECHO: Old Version to Find and replace.  Validate OLD version is OK as entered?  
@ECHO:   [Y]es is OK, [N]o or [C]hange to update value, [Q]uit Rename_Version
@ECHO:
SET /P OPT1=Find this OLD Version (%CHKOLDVERSVALUE%) [Y/N/C/Q] (%OPT1%) ^>
if /i "%OPT1%"=="Y" GOTO :OLDVERISSET
if /i "%OPT1%"=="N" GOTO :CHANGEOLDVERSION
if /i "%OPT1%"=="C" GOTO :CHANGEOLDVERSION
if /i "%OPT1%"=="Q" GOTO :QUITNOW1
if "%OPT1%"=="" GOTO :OLDVERISSET
GOTO :ASKOLDVEROK

:CHANGEOLDVERSION
@ECHO:
SET /P CHKOLDVERSVALUE=Enter updated OLD Version (%CHKOLDVERSVALUE%) ^>
GOTO :ASKOLDVEROK

:QUITNOW1
EXIT

:OLDVERISSET

if "%CHKOLDVERSVALUE%"=="" goto :NoParm2Set
SET OLDVERSVALUE=%CHKOLDVERSVALUE%

:NoParm2Set

@ECHO:
@ECHO: Old Version Value = "%OLDVERSVALUE%"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Old Version Value = "%OLDVERSVALUE%" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM -----------------------------------------------------------------


REM -----------------------------------------------------------------
REM Set new version
REM -----------------------------------------------------------------

SET NEWVERSVALUE=00x00x01

@ECHO:
@ECHO: Paramter 2 = "%2"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Paramter 2 = "%2" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM ECHO ON

REM ----------------------------------------------------------------
REM Ask if this version is sufficient OK
REM ----------------------------------------------------------------
SET CHKNEWVERSVALUE=%2

:ASKNEWVEROK
SET OPT1=Y
@ECHO:
@ECHO: New Version to Find and replace.  Validate NEW version is OK as entered?  
@ECHO:   [Y]es is OK, [N]o or [C]hange to update value, [Q]uit Rename_Version
@ECHO:
SET /P OPT1=Replace with this NEW Version (%CHKNEWVERSVALUE%) [Y/N/C/Q] (%OPT1%) ^>
if /i "%OPT1%"=="Y" GOTO :NEWVERISSET
if /i "%OPT1%"=="N" GOTO :CHANGENEWVERSION
if /i "%OPT1%"=="C" GOTO :CHANGENEWVERSION
if /i "%OPT1%"=="Q" GOTO :QUITNOW2
if "%OPT1%"=="" GOTO :NEWVERISSET
GOTO :ASKNEWVEROK

:CHANGENEWVERSION
@ECHO:
SET /P CHKNEWVERSVALUE=Enter updated NEW Version (%CHKNEWVERSVALUE%) ^>
GOTO :ASKNEWVEROK

:QUITNOW2
EXIT

:NEWVERISSET

if "%CHKNEWVERSVALUE%"=="" goto :NoParm3Set
SET NEWVERSVALUE=%CHKNEWVERSVALUE%

:NoParm3Set

@ECHO:
@ECHO: New Version Value= "%NEWVERSVALUE%"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: New Version Value = "%OLDVERSVALUE%" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM -----------------------------------------------------------------

SET "CURDIR=%CD%"

@ECHO:
@ECHO: Current Folder : "%CURDIR%"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Current Folder : "%CURDIR%" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

CALL :sub_ProcessFolderFileRename "%CURDIR%"
CALL :sub_ProcessFolderFileRename "%CURDIR%\_api_subscripts"
CALL :sub_ProcessFolderFileRename "%CURDIR%\_api_subscripts\_code_snippets"
CALL :sub_ProcessFolderFileRename "%CURDIR%\_templates.wip"
REM CALL :sub_ProcessFolderFileRename "%CURDIR%\_templates.wip\_code_snippets"
CALL :sub_ProcessFolderFileRename "%CURDIR%\csv_tools.wip"
REM CALL :sub_ProcessFolderFileRename "%CURDIR%\csv_tools.wip\_code_snippets"
CALL :sub_ProcessFolderFileRename "%CURDIR%\export_import.wip"
CALL :sub_ProcessFolderFileRename "%CURDIR%\MDM.wip"
CALL :sub_ProcessFolderFileRename "%CURDIR%\Session_Cleanup.wip"

REM We'll leave the __Updates alone
REM CALL :sub_ProcessFolderFileRename "%CURDIR%\__Updates"


REM * ===================================================================================
REM * Log the results
REM * ===================================================================================


REM @ECHO. >> "%_scriptLOGFQPN%"


REM * =========================================================================
REM * =========================================================================

REM =====================================================================================
REM Show the logged results
REM =====================================================================================

REM START "%FILEEDITORNAME%" /MAX /B "%FILEEDITOR%" "%_scriptLOGFQPN%"

REM =====================================================================================
REM GET TO WHERE WE STARTED
REM =====================================================================================

REM POPD

REM * =========================================================================
REM * =========================================================================


REM =====================================================================================
REM Show the logged results
REM =====================================================================================

@ECHO:
@ECHO:Log File : "%_scriptLOGFQPN%"
@ECHO:Script Completed : %_LOCALSCRIPTNAME%
@ECHO:

START "%FILEEDITORNAME%" /MAX /B "%FILEEDITOR%" "%_scriptLOGFQPN%"
REM PAUSE


REM =====================================================================================
REM =====================================================================================
REM END MAIN OPERATIONS
REM =====================================================================================
REM =====================================================================================


REM * =========================================================================
REM * =========================================================================
REM * Script Operational Cleanup before exit
REM * =========================================================================

REM * =========================================================================
REM * Variables we want to keep for use by the callers
REM * =========================================================================

CALL :sub_CLEARCONFIGSCRIPTPATHSVARS
CALL :sub_CLEARDTGTZSUFFIXVARS
CALL :sub_CLEANUPRESULTVARS

REM * =========================================================================
REM * CLEAN UP Local Variables
REM * =========================================================================

CALL :sub_CLEANUPLOCALVARS

REM * =========================================================================
REM * CLEAN UP Local Standard Variables
REM * =========================================================================

CALL :sub_CLEANUPLOCALSTANDARDVARS

REM * =========================================================================
REM * =========================================================================


REM *************************************************************************************
REM =====================================================================================
REM ALL DONE, EXIT BEFORE ERROR HANDLING
REM =====================================================================================
REM *************************************************************************************

EXIT /b %ERRORLEVEL%


REM *************************************************************************************
REM *************************************************************************************
REM START : Help Handling
REM *************************************************************************************
REM *************************************************************************************


:HandleHelp

@ECHO:
@ECHO:-------------------------------------------------------------------------------
@ECHO:-------------------------------------------------------------------------------
@ECHO:HELP for Script : %0
@ECHO:-------------------------------------------------------------------------------
@ECHO:^>%0 [OPTIONS] [COMMANDS] [FOLDERS]
@ECHO:

REM  :000000000011111111122222222223333333333444444444455555555556666666666777777777788888888889
REM  :123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

@ECHO: OPTIONS:
@ECHO:      Display Help                     /?^|/HELP^|-HELP^|--HELP
@ECHO:
@ECHO: COMMANDS:
@ECHO:
@ECHO: FOLDERS                : Folders provides ability to set specific folders
@ECHO:                        : to process.  Default is ".", so local path where
@ECHO:                        : executed.
@ECHO:
@ECHO:   NOTES                :
@ECHO:      X
@ECHO:

REM  :000000000011111111122222222223333333333444444444455555555556666666666777777777788888888889
REM  :123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

EXIT /B

REM *************************************************************************************
REM *************************************************************************************
REM END : Help Handling
REM *************************************************************************************
REM *************************************************************************************


REM *************************************************************************************
REM *************************************************************************************
REM START : Error Handling
REM *************************************************************************************
REM *************************************************************************************


REM -----------------------------------------------------------------
REM Execution Error:  Missing Common Subroutines Scripts path
REM -----------------------------------------------------------------
:ERRNOCOMMONSUBROUTINESPATH
@ECHO:
@ECHO: Execution Error:  Missing Common Subroutines Scripts path %subroutinecommonpath%
@ECHO:
SET ERRCRITICAL=COMMON_SUBROUTINES_SCRIPTS_PATH_NOT_FOUND
GOTO :ERRDONE


REM -----------------------------------------------------------------
REM Execution Error:  Missing Subroutine Script
REM -----------------------------------------------------------------
:ERRNOSUBROUTINESCRIPT
@ECHO:
@ECHO: Execution Error:  Missing Subroutine Script %subroutinecommonfqpn%
@ECHO:
SET ERRCRITICAL=SUBROUTINE_SCRIPT_NOT_FOUND
GOTO :ERRDONE


REM -----------------------------------------------------------------
REM Error:  Critical Error Already Set at Start
REM -----------------------------------------------------------------
:ERRCRITSET
@ECHO: Critical Error Set!  Critical Error = "ERRCRITICAL"
@ECHO:
GOTO :ERRDONE


REM -----------------------------------------------------------------
:ERRHANDLR


REM -----------------------------------------------------------------
:ERRDONE
@ECHO:
@ECHO: !!!!! Error Exit from Script %_LOCALSCRIPTNAME%, Error:  %ERRCRITICAL%
@ECHO: !!!!! Error Exit from Script %_LOCALSCRIPTNAME%, Error:  %ERRCRITICAL% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: ! Log file location : "%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%" 2>>&1
SET LOCALSCRIPTNAME=
@ECHO:
PAUSE
@ECHO: ... exiting...
@ECHO:

EXIT /b %ERRORLEVEL%

REM *************************************************************************************
REM *************************************************************************************
REM END : Error Handling
REM *************************************************************************************
REM *************************************************************************************

REM =====================================================================================
REM =====================================================================================
REM =====================================================================================
REM END OF CODE SNIPET FILE
REM =====================================================================================
REM =====================================================================================
REM =====================================================================================
