ECHO OFF
REM
REM Script  :  Create __Updates script files based on DGTS NOW for devops.dev
REM
REM # (C) 2016-2020 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/bash_4_Check_Point_scripts
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

SET _LOCALSCRIPTNAME=zzMakeUpdatesScriptsNow.devops.dev
SET _LOCALSCRIPTDATE=2021-02-09
SET _LOCALSCRIPTTIME=1530CDT
SET _LOCALSCRIPTVERSION=v06.01.00
SET _LOCALSCRIPTREVISION=000

SET "_LOCALSCRIPTDESCRIPTION=Create __Updates script files based on DGTS NOW for devops.dev"
SET "_LOCALSCRIPTDESCRIPTIONSHORT=Create __Updates script files for devops.dev"

@ECHO:
@ECHO: =====================================================================================
@ECHO: =====================================================================================
@ECHO: Script Name:  %_LOCALSCRIPTNAME%
@ECHO: VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION%  DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME%
@ECHO: SCRIPT CALLED     :  %0
@ECHO: SCRIPT PARAMETERS :  %*
@ECHO: =====================================================================================
@ECHO:
@ECHO:


REM CHECK IF WE ARE CLEANING UP AFTER OURSELVES
if "%~1"=="" GOTO :NOCALLPARM1
if %1=="--CLEANUP--" GOTO :CLEANUP_SUBROUTINES

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
SET FILEEDITOR=%windir%\NOTEPAD.EXE
GOTO :EDITORISSET

:HAVEEDITPADPRO8
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Pro 8\EditPadPro8.exe
GOTO :EDITORISSET

:HAVEEDITPADLITE8
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Lite 8\EditPadLite8.exe
GOTO :EDITORISSET

:HAVEEDITPADLITE7
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Lite 7\EditPadLite7.exe
GOTO :EDITORISSET

:EDITORISSET
REM START /MAX "%FILEEDITOR%" "%_scriptLOGFQPN%"

REM * -------------------------------------------------------------------------
REM * -------------------------------------------------------------------------

EXIT /B 0

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_SetTextFileEditorValue
REM * -----------------------------------------------------------------------------------

REM CALL :sub_SetTextFileEditorValue

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

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_CONFIGSCRIPTPATHS Start >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

SET "subroutinecommonpath=" 
SET "subroutinecommonfqpn="
SET "ERRORRETURN=0"

SET "testthispath=.\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO: Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"

SET "testthispath=R:\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO: Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"

SET "testthispath=S:\Updates\Software\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO: Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"

SET "ERRORRETURN=100"
@ECHO: Did not find target path ! >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"
GOTO :SUBRTCMNPATHSET

:SUBRTCMNPATHFOUND
@ECHO: Found target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"
SET "subroutinecommonpath=%testthispath%"
SET "subroutinecommonfqpn=%testthisfqpn%"

:SUBRTCMNPATHSET

REM * -------------------------------------------------------------------------
REM * Log Current Values
REM * -------------------------------------------------------------------------

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: subroutinescriptname   = %subroutinescriptname% >> "%_scriptLOGFQPN%"
@ECHO: subroutinescriptext    = %subroutinescriptext% >> "%_scriptLOGFQPN%"
@ECHO: subroutinescriptfile   = %subroutinescriptfile% >> "%_scriptLOGFQPN%"
@ECHO: subroutinecommonpath   = %subroutinecommonpath% >> "%_scriptLOGFQPN%"
@ECHO: subroutinecommonfqpn   = %subroutinecommonfqpn% >> "%_scriptLOGFQPN%"
@ECHO: testthispath           = %testthispath% >> "%_scriptLOGFQPN%"
@ECHO: testthisfqpn           = %testthisfqpn% >> "%_scriptLOGFQPN%"
@ECHO: ERRORRETURN            = %ERRORRETURN% >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_CONFIGSCRIPTPATHS Finished >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

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

@ECHO: CLEAN UP sub_CONFIGSCRIPTPATHS

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
@ECHO SCRIPT Name:  %_LOCALSCRIPTNAME% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO SCRIPT VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION%  DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO SCRIPT CALLED     :  %0 >> "%_scriptLOGFQPN%" 2>>&1
@ECHO SCRIPT PARAMETERS :  %* >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:===================================================================================== >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

REM =====================================================================================
REM =====================================================================================

@ECHO: ============================================================================= >> "%_scriptLOGFQPN%" 2>>&1
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
REM * ===================================================================================
REM * CodeSnipet :  Set Date and Time Group values
REM * ===================================================================================
REM * ===================================================================================

GOTO :SETDTGTZSUFFIX

REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM START OF CODE SNIPET SUBROUTINES
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------


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

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Time Zone value processing results: >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: _TZTIMEOFYEAR          = "%_TZTIMEOFYEAR%" >> "%_scriptLOGFQPN%"
@ECHO: _TZTYPE                = "%_TZTYPE%" >> "%_scriptLOGFQPN%"
@ECHO: _TZCURRENTNAME         = "%_TZCURRENTNAME%" >> "%_scriptLOGFQPN%"
@ECHO: _TZABR                 = "%_TZABR%" >> "%_scriptLOGFQPN%"
@ECHO: _TZABRSTZ              = "%_TZABRSTZ%" >> "%_scriptLOGFQPN%"
@ECHO: _TZABRDTZ              = "%_TZABRDTZ%" >> "%_scriptLOGFQPN%"
@ECHO: _TZCURRENTNAMENOQUOTES = "%_TZCURRENTNAMENOQUOTES%" >> "%_scriptLOGFQPN%"

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Date Time Time Zone suffix value results: >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DATE      = "%_DTTZ_SUFFIX_DATE%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DATEDASH  = "%_DTTZ_SUFFIX_DATEDASH%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_TIME      = "%_DTTZ_SUFFIX_TIME%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DTG       = "%_DTTZ_SUFFIX_DTG%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DTGDASH   = "%_DTTZ_SUFFIX_DTGDASH%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_TIMETZ    = "%_DTTZ_SUFFIX_TIMETZ%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DTGTZ     = "%_DTTZ_SUFFIX_DTGTZ%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DTGTZDASH = "%_DTTZ_SUFFIX_DTGTZDASH%" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"


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


REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM END OF CODE SNIPET SUBROUTINES
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM =====================================================================================


:SETDTGTZSUFFIX

CALL :sub_CLEARCONFIGSCRIPTPATHSVARS

REM * -------------------------------------------------------------------------
REM * Set Local Variables
REM * -------------------------------------------------------------------------

SET "subroutinescriptname=subroutine.Set_DTG_SUFFIX.COMPACT"
SET "subroutinescriptext=CMD"
SET "subroutinescriptfile=%subroutinescriptname%.%subroutinescriptext%"
SET "subroutinecommonpath=" 
SET "subroutinecommonfqpn=" 

REM * -------------------------------------------------------------------------
REM * Variables set by call
REM * -------------------------------------------------------------------------

CALL :sub_CLEARDTGTZSUFFIXVARS

REM * ===================================================================================
REM * Configure basic variables and set appropriate subroutine paths
REM * ===================================================================================

CALL :sub_CONFIGSCRIPTPATHS

REM * ===================================================================================
REM * Call the operational subroutine to set the required values
REM * ===================================================================================

IF NOT EXIST "%subroutinecommonpath%" GOTO :ERRNOCOMMONSUBROUTINESPATH
IF NOT EXIST "%subroutinecommonfqpn%" GOTO :ERRNOSUBROUTINESCRIPT

REM * -----------------------------------------------------------------------------------
REM * Protect Local Log File value _scriptLOGFQPN since that is used in the called subroutine
REM * -----------------------------------------------------------------------------------
SET "_localLOGFILE="
SET "_remoteLOGFILE="
SET "_localLOGFILE=%_scriptLOGFQPN%"

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Executing script "%subroutinecommonfqpn%" >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

CALL "%subroutinecommonfqpn%"

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Script "%subroutinecommonfqpn%" Completed >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM * -----------------------------------------------------------------------------------
REM * Restore Local Log File value _scriptLOGFQPN and retain remote subroutine _scriptLOGFQPN value
REM * -----------------------------------------------------------------------------------
SET "_remoteLOGFILE=%_scriptLOGFQPN%"
SET "_scriptLOGFQPN=%_localLOGFILE%"

REM * ===================================================================================
REM * Log the results
REM * ===================================================================================

CALL :sub_LOGDTGTZSUFFIXRESULTS


REM * =========================================================================
REM * =========================================================================


REM =====================================================================================
REM =====================================================================================
REM START MAIN OPERATIONS
REM =====================================================================================
REM =====================================================================================

REM =====================================================================================
REM =====================================================================================

@ECHO: _scriptLOGSDIR         ="%_scriptLOGSDIR%" >> "%_scriptLOGFQPN%"
@ECHO: _scriptLOGSPATH        ="%_scriptLOGSPATH%" >> "%_scriptLOGFQPN%"
@ECHO: _scriptLOGSFILE        ="%_scriptLOGSFILE%" >> "%_scriptLOGFQPN%"
@ECHO: _scriptLOGFQPN         ="%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM =====================================================================================
REM CONFIGURE STANDARD LOCAL VARIABLES
REM =====================================================================================

SET "_scriptTempWORKDIR=%_scriptLOGSDIR%"
SET "DATETIMEGRP=%_DTTZ_SUFFIX_DTGTZDASH%"
SET "_HOST_NAME=%COMPUTERNAME%"

SET "_JUSTDOIT="
REM CHECK IF WE ARE CLEANING UP AFTER OURSELVES
@ECHO: Parameter 1 = %1 >> "%_scriptLOGFQPN%"
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
@ECHO:  _scriptLOGSDIR         ="%_scriptLOGSDIR%"
@ECHO:  _scriptLOGSDIR         ="%_scriptLOGSDIR%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _scriptLOGSPATH        ="%_scriptLOGSPATH%"
@ECHO:  _scriptLOGSPATH        ="%_scriptLOGSPATH%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _scriptLOGSFILE        ="%_scriptLOGSFILE%"
@ECHO:  _scriptLOGSFILE        ="%_scriptLOGSFILE%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _scriptLOGFQPN         ="%_scriptLOGFQPN%"
@ECHO:  _scriptLOGFQPN         ="%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:  _tempLOGFILE           ="%_tempLOGFILE%"
@ECHO:  _tempLOGFILE           ="%_tempLOGFILE%" >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: =============================================================================
@ECHO: ============================================================================= >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:

REM =====================================================================================
REM CONFIGURE LOCAL VARIABLES
REM =====================================================================================

REM 

REM =====================================================================================
REM GET TO WHERE THE WORK IS DONE
REM =====================================================================================

REM PUSHD
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
REM * Backup Scripts to WIP Folders
REM * ===================================================================================
REM * ===================================================================================

GOTO :SKIPMAINSUBROUTINES

REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM START OF MAIN SUBROUTINES
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_XCopySourcToTargetwithXcopyParms  :  
REM -------------------------------------------------------------------------------------

:sub_XCopySourcToTargetwithXcopyParms

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

SET _sublocalXcopyParms=%~1
SET _sublocalSource=%~2
SET _sublocalTarget=%~3

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Source         = "%_sublocalSource%" >> "%_scriptLOGFQPN%"
@ECHO:Target         = "%_sublocalTarget%" >> "%_scriptLOGFQPN%"
@ECHO:XcopyParms     = "%_sublocalXcopyParms%" >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

IF EXIST "%_sublocalSource%" (
	REM Source found
	
	REM Check target directory exists, and if not create it
	IF NOT EXIST "%_sublocalTarget%" MKDIR "%_sublocalTarget%" >> "%_scriptLOGFQPN%"
	
	@ECHO:XCopying using "%_sublocalXcopyParms%" from "%_sublocalSource%" to "%_sublocalTarget%"
	@ECHO:XCopying from Source to Target using XcopyParms >> "%_scriptLOGFQPN%"
	@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
	
	XCOPY "%_sublocalSource%" "%_sublocalTarget%" %_sublocalXcopyParms% >> "%_scriptLOGFQPN%"
	
) ELSE (
	REM NOT Source found !
	
	@ECHO:Source does not exist "%_sublocalSource%" !
	@ECHO:Source does not exist "%_sublocalSource%" ! >> "%_scriptLOGFQPN%"
)

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM * -----------------------------------------------------------------------------------
REM * Clean-up subroutine local variables
REM * -----------------------------------------------------------------------------------
SET "_sublocalSource="
SET "_sublocalTarget="
SET "_sublocalXcopyParms="

REM * ===================================================================================
REM * Log the results
REM * ===================================================================================


EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_XCopySourcToTargetwithXcopyParms
REM -------------------------------------------------------------------------------------

REM CALL :sub_XCopySourcToTargetwithXcopyParms XCopyParms Source Target

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_XCopySourcToTargetwithXcopyParms
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_CopySourceToTargetwithCopyParms  :  
REM -------------------------------------------------------------------------------------

:sub_CopySourceToTargetwithCopyParms

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

SET _sublocalCopyParms=%~1
SET _sublocalSource=%~2
SET _sublocalTarget=%~3

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Source         = "%_sublocalSource%" >> "%_scriptLOGFQPN%"
@ECHO:Target         = "%_sublocalTarget%" >> "%_scriptLOGFQPN%"
@ECHO:CopyParms     = "%_sublocalCopyParms%" >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

IF EXIST "%_sublocalSource%" (
	REM Source found
	
	@ECHO:Copying using "%_sublocalCopyParms%" from "%_sublocalSource%" to "%_sublocalTarget%"
	@ECHO:Copying from Source to Target using CopyParms >> "%_scriptLOGFQPN%"
	@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
	
	COPY %_sublocalCopyParms% "%_sublocalSource%" "%_sublocalTarget%" >> "%_scriptLOGFQPN%"
	
) ELSE (
	REM NOT Source found !
	
	@ECHO:Source does not exist "%_sublocalSource%" !
	@ECHO:Source does not exist "%_sublocalSource%" ! >> "%_scriptLOGFQPN%"
)

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM * -----------------------------------------------------------------------------------
REM * Clean-up subroutine local variables
REM * -----------------------------------------------------------------------------------
SET "_sublocalSource="
SET "_sublocalTarget="
SET "_sublocalXcopyParms="

REM * ===================================================================================
REM * Log the results
REM * ===================================================================================


EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_CopySourceToTargetwithCopyParms
REM -------------------------------------------------------------------------------------

REM CALL :sub_CopySourceToTargetwithCopyParms XCopyParms Source Target

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_CopySourceToTargetwithCopyParms
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM END OF MAIN SUBROUTINES
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM =====================================================================================


:SKIPMAINSUBROUTINES

REM -----------------------------------------------------------------
REM -----------------------------------------------------------------

REM -----------------------------------------------------------------
REM Set version
REM -----------------------------------------------------------------

SET "VERSVALUE="

@ECHO:
@ECHO: Paramter 1 = "%1"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Paramter 1 = "%1" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM ECHO ON

REM ----------------------------------------------------------------
REM Ask if this version is OK
REM ----------------------------------------------------------------
SET "CHKVERSVALUE=%1"

:ASKVEROK
SET OPT1=Y
@ECHO:
@ECHO: Version for __Updates folder subfolder.  Validate version is OK as entered?  
@ECHO:   [Y]es is OK, [N]o or [C]hange to update value, [Q]uit Rename_Version
@ECHO:
SET /P OPT1=Use this Version (%CHKVERSVALUE%), may be blank () [Y/N/C/Q] (%OPT1%) ^>
if /i "%OPT1%"=="Y" GOTO :OLDVERISSET
if /i "%OPT1%"=="N" GOTO :CHANGEOLDVERSION
if /i "%OPT1%"=="C" GOTO :CHANGEOLDVERSION
if /i "%OPT1%"=="Q" GOTO :QUITNOW1
if "%OPT1%"=="" GOTO :OLDVERISSET
GOTO :ASKVEROK

:CHANGEOLDVERSION
@ECHO:
SET /P CHKVERSVALUE=Enter updated Version (%CHKVERSVALUE%) ^>
GOTO :ASKVEROK

:QUITNOW1
EXIT

:OLDVERISSET

if "%CHKVERSVALUE%"=="" goto :NoParm1Set
SET "VERSVALUE=%CHKVERSVALUE%"

:NoParm1Set

@ECHO:
@ECHO: Version Value = "%VERSVALUE%"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Version Value = "%VERSVALUE%" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM -----------------------------------------------------------------


REM -----------------------------------------------------------------
REM Set Revision
REM -----------------------------------------------------------------

SET "REVISIONVALUE="

@ECHO:
@ECHO: Paramter 2 = "%2"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Paramter 2 = "%2" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM ECHO ON

REM ----------------------------------------------------------------
REM Ask if this Revision is OK
REM ----------------------------------------------------------------
SET "CHKREVISIONVALUE=%2"

REM We will not use revision without version, so skip if empty.
IF "%VERSVALUE%"=="" GOTO :REVISIONISSET

:ASKREVISIONOK
SET OPT1=Y
@ECHO:
@ECHO: Revision for __Updates folder subfolder.  Validate Revision is OK as entered?  
@ECHO:   [Y]es is OK, [N]o or [C]hange to update value, [Q]uit Rename_Version
@ECHO:
SET /P OPT1=Use this Revision (%CHKREVISIONVALUE%), may be blank () [Y/N/C/Q] (%OPT1%) ^>
if /i "%OPT1%"=="Y" GOTO :REVISIONISSET
if /i "%OPT1%"=="N" GOTO :CHANGEOLDREVISION
if /i "%OPT1%"=="C" GOTO :CHANGEOLDREVISION
if /i "%OPT1%"=="Q" GOTO :QUITNOW2
if "%OPT1%"=="" GOTO :REVISIONISSET
GOTO :ASKREVISIONOK

:CHANGEOLDREVISION
@ECHO:
SET /P CHKREVISIONVALUE=Enter updated Revision (%CHKREVISIONVALUE%) ^>
GOTO :ASKREVISIONOK

:QUITNOW2
EXIT

:REVISIONISSET

if "%CHKREVISIONVALUE%"=="" goto :NoParm2Set
SET "REVISIONVALUE=%CHKREVISIONVALUE%"

:NoParm2Set

@ECHO:
@ECHO: Revision Value = "%REVISIONVALUE%"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Revision Value = "%REVISIONVALUE%" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM -----------------------------------------------------------------


REM -----------------------------------------------------------------
REM -----------------------------------------------------------------

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

SET XCOPYPARMS=/v/S/E/I/F/H/R/K/Y

REM CALL :sub_XCopySourcToTargetwithXcopyParms %XCOPYPARMS% <source_files> <target_folder>

REM CALL :sub_XCopySourcToTargetwithXcopyParms %XCOPYPARMS% ".\scripts\GAIA\*.sh" ".\__gaia\"


REM This needs a solution, but probably also more coding
REM CALL :sub_XCopySourcToTargetwithXcopyParms %XCOPYPARMS% ".\scripts\SMS\help.v??.??.??\*.help" ".\scripts.wip\SMS.wip\help.v??.??.??\*.help"


@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM SET XCOPYPARMS=/v/I/F/H/R/K/Y
SET COPYPARMS=/V/Y

REM CALL :sub_XCopySourcToTargetwithXcopyParms %XCOPYPARMS% ".\scripts\GAIA\*.sh" ".\__gaia\"
REM IF NOT EXIST ".\scripts\GAIA\update_gaia_dynamic_cli.sh" CALL :sub_XCopySourcToTargetwithXcopyParms %XCOPYPARMS% ".\scripts\GAIA\update_gaia_dynamic_cli.*.sh" ".\__gaia\update_gaia_dynamic_cli.sh"



SET "TARGETUPDATEFOLDER=.\__Updates\%_DTTZ_SUFFIX_DATEDASH%--MM-DD Script Overhaul"

SET "FOLDERVERSIONVALUE="

IF "%VERSVALUE%"=="" GOTO :NOFOLDERVERSION
SET "FOLDERVERSIONVALUE=%VERSVALUE%"

IF "%REVISIONVALUE%"=="" GOTO :NOFOLDERREVISION
SET "FOLDERVERSIONVALUE=%FOLDERVERSIONVALUE%.%REVISIONVALUE%"

:NOFOLDERREVISION
SET "TARGETUPDATEFOLDER=%TARGETUPDATEFOLDER% %FOLDERVERSIONVALUE%"

:NOFOLDERVERSION


REM Check target directory exists, and if not create it
IF NOT EXIST "%TARGETUPDATEFOLDER%" MKDIR "%TARGETUPDATEFOLDER%" >> "%_scriptLOGFQPN%"

SET "SOURCEFILE000=.\__scripting_tools\_fixes_update_info.TBEx.YYYY-MM-DD-HHmmZZZ.original.sh"
SET "TARGETFILE000M=%TARGETUPDATEFOLDER%\_fixes_update_info.TBEx.%_DTTZ_SUFFIX_DATEDASH%-XXXXZZZ.original.sh"
SET "TARGETFILE000A=%TARGETUPDATEFOLDER%\_fixes_update_info.TBEx.%_DTTZ_SUFFIX_DTGTZDASH%.original.sh"
IF NOT EXIST "%TARGETFILE000M%" (
	CALL :sub_CopySourceToTargetwithCopyParms %COPYPARMS% "%SOURCEFILE000%" "%TARGETFILE000M%"
) ELSE (
	CALL :sub_CopySourceToTargetwithCopyParms %COPYPARMS% "%SOURCEFILE000%" "%TARGETFILE000A%"
)

SET "SOURCEFILE001=.\__scripting_tools\_fixes_update_info.TBEx.YYYY-MM-DD-HHmmZZZ.updated.sh"
SET "TARGETFILE001M=%TARGETUPDATEFOLDER%\_fixes_update_info.TBEx.%_DTTZ_SUFFIX_DATEDASH%-XXXXZZZ.updated.sh"
SET "TARGETFILE001A=%TARGETUPDATEFOLDER%\_fixes_update_info.TBEx.%_DTTZ_SUFFIX_DTGTZDASH%.updated.sh"
IF NOT EXIST "%TARGETFILE001M%" (
	CALL :sub_CopySourceToTargetwithCopyParms %COPYPARMS% "%SOURCEFILE001%" "%TARGETFILE001M%"
) ELSE (
	CALL :sub_CopySourceToTargetwithCopyParms %COPYPARMS% "%SOURCEFILE001%" "%TARGETFILE001A%"
)


REM * -----------------------------------------------------------------------------------
REM * -----------------------------------------------------------------------------------



GOTO :SKIPARCHIVESUBROUTINES

REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM START OF MAIN SUBROUTINES
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_MakeArchiveVersionFolder  :  
REM -------------------------------------------------------------------------------------

:sub_MakeArchiveVersionFolder

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

SET "_sublocaltarget=%~1"
SET "_sublocalversion=%~2"

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Target        = "%_sublocalTarget%" >> "%_scriptLOGFQPN%"
@ECHO: Version       = "%_sublocalversion%" >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

IF EXIST "%_sublocaltarget%" @ECHO: Target folder "%_sublocaltarget%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%_sublocaltarget%" @ECHO: Target folder "%_sublocaltarget%" does NOT exist!  Creating... >> "%_scriptLOGFQPN%"
IF NOT EXIST "%_sublocaltarget%" MKDIR "%_sublocaltarget%" >> "%_scriptLOGFQPN%"

IF EXIST "%_sublocaltarget%\%_sublocalversion%" @ECHO: Target folder "%_sublocaltarget%\%_sublocalversion%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%_sublocaltarget%\%_sublocalversion%" @ECHO: Target folder "%_sublocaltarget%\%_sublocalversion%" does NOT exist!  Creating... >> "%_scriptLOGFQPN%"
IF NOT EXIST "%_sublocaltarget%\%_sublocalversion%" MKDIR "%_sublocaltarget%\%_sublocalversion%" >> "%_scriptLOGFQPN%"

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM * -----------------------------------------------------------------------------------
REM * Clean-up subroutine local variables
REM * -----------------------------------------------------------------------------------
SET "_sublocaltarget="
SET "_sublocalversion="

REM * ===================================================================================
REM * Log the results
REM * ===================================================================================


EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_MakeArchiveVersionFolder
REM -------------------------------------------------------------------------------------

REM CALL :sub_MakeArchiveVersionFolder TARGETFOLDER VERSIONVALUE

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_MakeArchiveVersionFolder
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM END OF MAIN SUBROUTINES
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM =====================================================================================


:SKIPARCHIVESUBROUTINES

REM -----------------------------------------------------------------
REM -----------------------------------------------------------------

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

SET "TARGETFOLDERROOT=.."
SET "TARGETFOLDERBASE=devops.dev.archive"
SET "TARGETFOLDERMAIN=%TARGETFOLDERROOT%\%TARGETFOLDERBASE%"

REM .sh.backup
REM common.wip.archive
REM csv_tools.wip.archive
REM export_import.wip.archive
REM Session_Cleanup.wip.archive
REM zzz_testing.wip.archive
REM _api_subscripts.archive
REM _templates.wip.archive
REM __folder_template.archive
REM __root.archive
REM __scripting_tools.archive
REM __Updates.archive
REM __Windows (CMD).archive


IF "%VERSVALUE%"=="" GOTO :SkipArchiveFolderCheck

@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Check on %TARGETFOLDERMAIN% for version specific folders in subfolders 
@ECHO: Check on %TARGETFOLDERMAIN% for version specific folders in subfolders >> "%_scriptLOGFQPN%"
@ECHO:
@ECHO: >> "%_scriptLOGFQPN%"

IF NOT EXIST "%TARGETFOLDERMAIN%" GOTO :SkipArchiveFolderCheck

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\.sh.backup"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\__folder_template.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\__root.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\__scripting_tools.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\__Updates.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\__Windows (CMD).archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\_api_subscripts.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\_templates.wip.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\common.wip.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\csv_tools.wip.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\export_import.wip.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\Session_Cleanup.wip.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"

SET "TARGETFOLDERWORK=%TARGETFOLDERMAIN%\zzz_testing.wip.archive"

IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!
IF EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" @ECHO: Target folder "%TARGETFOLDERWORK%\%VERSVALUE%" exists!  >> "%_scriptLOGFQPN%"
IF NOT EXIST "%TARGETFOLDERWORK%\%VERSVALUE%" CALL :sub_MakeArchiveVersionFolder "%TARGETFOLDERWORK%" "%VERSVALUE%"



:SkipArchiveFolderCheck


REM @ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM @ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM @ECHO:
REM @ECHO: >> "%_scriptLOGFQPN%"
REM @ECHO: Remove unwanted files that are copied to __gaia 
REM @ECHO: Remove unwanted files that are copied to __gaia >> "%_scriptLOGFQPN%"
REM @ECHO:
REM @ECHO: >> "%_scriptLOGFQPN%"

REM DEL /F /Q ".\__gaia\updatescripts.sample.sh" >> "%_scriptLOGFQPN%"
REM DEL /F /Q ".\__gaia\updatescripts.sample.*.sh" >> "%_scriptLOGFQPN%"


@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Updates files >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

DIR "%TARGETUPDATEFOLDER%" >> "%_scriptLOGFQPN%"

@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"


REM =====================================================================================
REM Show the logged results
REM =====================================================================================

START "%FILEEDITORNAME%" /MAX /B "%FILEEDITOR%" "%_scriptLOGFQPN%"

REM =====================================================================================
REM GET TO WHERE WE STARTED
REM =====================================================================================

REM POPD

REM * =========================================================================
REM * =========================================================================


REM =====================================================================================
REM =====================================================================================
REM END MAIN OPERATIONS
REM =====================================================================================
REM =====================================================================================


@ECHO:
@ECHO: Log File : "%_scriptLOGFQPN%"
@ECHO: Script Completed : %_LOCALSCRIPTNAME%
@ECHO:

PAUSE

REM * =========================================================================
REM * =========================================================================
REM * Script Operational Cleanup before exit
REM * =========================================================================

REM * =========================================================================
REM * Variables we want to keep for use by the callers
REM * =========================================================================

REM CALL :sub_CLEARDTGTZSUFFIXVARS

REM CALL :sub_CLEANUPRESULTVARS

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
@ECHO: !!!!! Error Exit from Script %_LOCALSCRIPTNAME%, Error:  %ERRCRITICAL% >> "%_scriptLOGFQPN%"
@ECHO: !!!!! Error Exit from Script %_LOCALSCRIPTNAME%, Error:  %ERRCRITICAL% >> "%_scriptLOGFQPN%"
@ECHO: ! Log file location : "%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%"
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
