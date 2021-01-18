@ECHO OFF
REM
REM Script     :  Clear __history Folders : local folder
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

SET _LOCALSCRIPTNAME=zzClear__historyFolders
SET _LOCALSCRIPTDATE=2020-12-11
SET _LOCALSCRIPTTIME=1430CST
SET _LOCALSCRIPTVERSION=05.00.00
SET _LOCALSCRIPTREVISION=000


@ECHO.
@ECHO =====================================================================================
@ECHO =====================================================================================
@ECHO Script Name:  %_LOCALSCRIPTNAME%
@ECHO DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME%
@ECHO VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION%
@ECHO =====================================================================================
@ECHO.
@ECHO.


GOTO :STARTSCRIPT

REM =====================================================================================
REM =====================================================================================
REM =====================================================================================
REM START OF SUBROUTINES
REM =====================================================================================
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

@ECHO. >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO Subroutine sub_CONFIGSCRIPTPATHS Start >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

SET "subroutinecommonpath=" 
SET "subroutinecommonfqpn="
SET "ERRORRETURN=0"

SET "testthispath=.\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"

SET "testthispath=R:\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"

SET "testthispath=S:\Updates\Software\_Common\__SUBROUTINES"
SET "testthisfqpn=%testthispath%\%subroutinescriptfile%"
IF EXIST "%testthisfqpn%" GOTO :SUBRTCMNPATHFOUND
IF NOT EXIST "%testthisfqpn%" @ECHO Did not find target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"

SET "ERRORRETURN=100"
@ECHO Did not find target path ! >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"
GOTO :SUBRTCMNPATHSET

:SUBRTCMNPATHFOUND
@ECHO Found target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"
SET "subroutinecommonpath=%testthispath%"
SET "subroutinecommonfqpn=%testthisfqpn%"

:SUBRTCMNPATHSET

REM * -------------------------------------------------------------------------
REM * Log Current Values
REM * -------------------------------------------------------------------------

@ECHO. >> "%_scriptLOGFQPN%"
@ECHO subroutinescriptname   = %subroutinescriptname% >> "%_scriptLOGFQPN%"
@ECHO subroutinescriptext    = %subroutinescriptext% >> "%_scriptLOGFQPN%"
@ECHO subroutinescriptfile   = %subroutinescriptfile% >> "%_scriptLOGFQPN%"
@ECHO subroutinecommonpath   = %subroutinecommonpath% >> "%_scriptLOGFQPN%"
@ECHO subroutinecommonfqpn   = %subroutinecommonfqpn% >> "%_scriptLOGFQPN%"
@ECHO testthispath           = %testthispath% >> "%_scriptLOGFQPN%"
@ECHO testthisfqpn           = %testthisfqpn% >> "%_scriptLOGFQPN%"
@ECHO ERRORRETURN            = %ERRORRETURN% >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

@ECHO. >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO Subroutine sub_CONFIGSCRIPTPATHS Finished >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

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

@ECHO CLEAN UP sub_CONFIGSCRIPTPATHS

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

REM =====================================================================================
REM Configure Logging paths, folders, and files
REM =====================================================================================

REM SET _scriptLOGSDIR=C:\TEMP
SET _scriptLOGSDIR=%TEMP%
SET _scriptLOGSPATH=%_scriptLOGSDIR%
SET "_scriptLOGSFILE=%_LOCALSCRIPTNAME%.log"
SET "_scriptLOGFQPN=%_scriptLOGSPATH%\%_scriptLOGSFILE%"

IF NOT EXIST "%_scriptLOGSDIR%" MKDIR "%_scriptLOGSDIR%"
IF NOT EXIST "%_scriptLOGSPATH%" MKDIR "%_scriptLOGSPATH%"

@ECHO. > "%_scriptLOGFQPN%"

REM =====================================================================================
REM =====================================================================================

@ECHO ===================================================================================== >> "%_scriptLOGFQPN%"
@ECHO Script Name:  %_LOCALSCRIPTNAME% >> "%_scriptLOGFQPN%"
@ECHO DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME% >> "%_scriptLOGFQPN%"
@ECHO VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION% >> "%_scriptLOGFQPN%"
@ECHO ===================================================================================== >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

REM =====================================================================================
REM =====================================================================================

@ECHO _scriptLOGSDIR         ="%_scriptLOGSDIR%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGSPATH        ="%_scriptLOGSPATH%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGSFILE        ="%_scriptLOGSFILE%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGFQPN         ="%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"


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

@ECHO. >> "%_scriptLOGFQPN%"
@ECHO Time Zone value processing results: >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"
@ECHO _TZTIMEOFYEAR          = "%_TZTIMEOFYEAR%" >> "%_scriptLOGFQPN%"
@ECHO _TZTYPE                = "%_TZTYPE%" >> "%_scriptLOGFQPN%"
@ECHO _TZCURRENTNAME         = "%_TZCURRENTNAME%" >> "%_scriptLOGFQPN%"
@ECHO _TZABR                 = "%_TZABR%" >> "%_scriptLOGFQPN%"
@ECHO _TZABRSTZ              = "%_TZABRSTZ%" >> "%_scriptLOGFQPN%"
@ECHO _TZABRDTZ              = "%_TZABRDTZ%" >> "%_scriptLOGFQPN%"
@ECHO _TZCURRENTNAMENOQUOTES = "%_TZCURRENTNAMENOQUOTES%" >> "%_scriptLOGFQPN%"

@ECHO. >> "%_scriptLOGFQPN%"
@ECHO Date Time Time Zone suffix value results: >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"
@ECHO _DTTZ_SUFFIX_DATE      = "%_DTTZ_SUFFIX_DATE%" >> "%_scriptLOGFQPN%"
@ECHO _DTTZ_SUFFIX_DATEDASH  = "%_DTTZ_SUFFIX_DATEDASH%" >> "%_scriptLOGFQPN%"
@ECHO _DTTZ_SUFFIX_TIME      = "%_DTTZ_SUFFIX_TIME%" >> "%_scriptLOGFQPN%"
@ECHO _DTTZ_SUFFIX_DTG       = "%_DTTZ_SUFFIX_DTG%" >> "%_scriptLOGFQPN%"
@ECHO _DTTZ_SUFFIX_DTGDASH   = "%_DTTZ_SUFFIX_DTGDASH%" >> "%_scriptLOGFQPN%"
@ECHO _DTTZ_SUFFIX_TIMETZ    = "%_DTTZ_SUFFIX_TIMETZ%" >> "%_scriptLOGFQPN%"
@ECHO _DTTZ_SUFFIX_DTGTZ     = "%_DTTZ_SUFFIX_DTGTZ%" >> "%_scriptLOGFQPN%"
@ECHO _DTTZ_SUFFIX_DTGTZDASH = "%_DTTZ_SUFFIX_DTGTZDASH%" >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"


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

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Executing script "%subroutinecommonfqpn%" >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

CALL "%subroutinecommonfqpn%"

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Script "%subroutinecommonfqpn%" Completed >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

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

@ECHO _scriptLOGSDIR         ="%_scriptLOGSDIR%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGSPATH        ="%_scriptLOGSPATH%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGSFILE        ="%_scriptLOGSFILE%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGFQPN         ="%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

REM =====================================================================================
REM CONFIGURE STANDARD LOCAL VARIABLES
REM =====================================================================================

SET _scriptTempWORKDIR=%_scriptLOGSDIR%
SET "DATETIMEGRP=%_DTTZ_SUFFIX_DTGTZDASH%"
SET "_HOST_NAME=%COMPUTERNAME%"

SET "_JUSTDOIT="
REM CHECK IF WE ARE CLEANING UP AFTER OURSELVES
@ECHO Parameter 1 = %1 >> "%_scriptLOGFQPN%"
if "%~1"=="" GOTO :NOCALLPARM1
if %1=="--CLEANUP--" GOTO :CLEANUP_SUBROUTINES
IF %1=="--AUTO--" SET "_JUSTDOIT=TRUE"

:NOCALLPARM1

REM =====================================================================================
REM CONFIGURE LOCAL VARIABLES - UPDATED _scriptLOGFQPN
REM =====================================================================================

SET "_tempLOGFILE=%_scriptLOGFQPN%"
SET _scriptLOGSPATH=%_scriptLOGSDIR%
SET "_scriptLOGSFILE=log_%_LOCALSCRIPTNAME%_%DATETIMEGRP%.log"
SET "_scriptLOGFQPN=%_scriptLOGSPATH%\%_scriptLOGSFILE%"

@ECHO _scriptLOGSDIR         ="%_scriptLOGSDIR%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGSPATH        ="%_scriptLOGSPATH%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGSFILE        ="%_scriptLOGSFILE%" >> "%_scriptLOGFQPN%"
@ECHO _scriptLOGFQPN         ="%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%"
@ECHO _tempLOGFILE           ="%_tempLOGFILE%" >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

TYPE "%_tempLOGFILE%" > "%_scriptLOGFQPN%"

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

@ECHO Backup Scripts to WIP Folders
@ECHO.
@ECHO Backup Scripts to WIP Folders >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

REM IF "%_JUSTDOIT%"=="TRUE" GOTO :WEAREGOODTOGO

REM SET "HOST_NAME="
REM SET /p SERVER_NAME=Enter DHCP Server Name: ( %_HOST_NAME% )^>
REM IF NOT "%HOST_NAME%"=="" set "_HOST_NAME=%_HOST_NAME%"
REM SET "HOST_NAME="

REM SET "ENTERDATETIMEGRP="
REM SET /p ENTERDATETIMEGRP=Check DTGtzn: (%DATETIMEGRP% YYYY-MM-DD-HHMMtzn)^>
REM IF NOT "%ENTERDATETIMEGRP%"=="" set "DATETIMEGRP=%ENTERDATETIMEGRP%"
REM SET "ENTERDATETIMEGRP="

REM :WEAREGOODTOGO

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
REM START SUBROUTINE:  sub_Handle__historyFolderAndContent  :  
REM -------------------------------------------------------------------------------------

:sub_Handle__historyFolderAndContent

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

SET "_localhistoryFolder="
SET _localhistoryFolder=%~1

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

@ECHO:__history Folder :  "%_localhistoryFolder%"
@ECHO:__history Folder :  "%_localhistoryFolder%" >> "%_scriptLOGFQPN%"

PUSHD "%_localhistoryFolder%" >> "%_scriptLOGFQPN%" 2>>&1

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Folder Content >> "%_scriptLOGFQPN%"

DIR >> "%_scriptLOGFQPN%"

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Remove Any Folder Content >> "%_scriptLOGFQPN%"

IF EXIST "%_localhistoryFolder%\*.*" (
	REM Delete it all
	DEL /F /S /Q *.* >> "%_scriptLOGFQPN%" 2>>&1
)

POPD >> "%_scriptLOGFQPN%" 2>>&1

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM __history folder found
@ECHO:Removing folder recursively :  "%_localhistoryFolder%"
@ECHO:Removing folder recursively :  "%_localhistoryFolder%" >> "%_scriptLOGFQPN%"
RMDIR /Q /S "%_localhistoryFolder%\" >> "%_scriptLOGFQPN%" 2>>&1

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM * -----------------------------------------------------------------------------------
REM * Clean-up subroutine local variables
REM * -----------------------------------------------------------------------------------

SET "_localhistoryFolder="

REM * ===================================================================================
REM * Log the results
REM * ===================================================================================

@ECHO:sub_Handle__historyFolderAndContent DONE
@ECHO:

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_Handle__historyFolderAndContent
REM -------------------------------------------------------------------------------------

REM CALL :sub_Handle__historyFolderAndContent Target

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_Handle__historyFolderAndContent
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_HandleSubFoldersRecursive  :  
REM -------------------------------------------------------------------------------------

:sub_HandleSubFoldersRecursive

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------


REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

@ECHO:Sub-Folder :  "%~nx1"  "%~1"
@ECHO:Sub-Folder :  "%~nx1"  "%~1" >> "%_scriptLOGFQPN%"

REM PAUSE

if /I "%~nx1"=="_SYNCAPP" (
	@ECHO:Ignore sub-Folder :  "%1"
	@ECHO:Ignore sub-Folder :  "%1" >> "%_scriptLOGFQPN%"
) ELSE (
	if /I "%~nx1"=="_TOOLS" (
		@ECHO:Ignore sub-Folder :  "%1"
		@ECHO:Ignore sub-Folder :  "%1" >> "%_scriptLOGFQPN%"
	) ELSE (
		@ECHO:Check sub-Folder :  "%~1\"
		@ECHO:Check sub-Folder :  "%~1\" >> "%_scriptLOGFQPN%"
		CALL :sub_Find__historyAndRemoveRecursive "%~1\"
	)
)

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

REM * -----------------------------------------------------------------------------------
REM * Clean-up subroutine local variables
REM * -----------------------------------------------------------------------------------


REM * ===================================================================================
REM * Log the results
REM * ===================================================================================

@ECHO:sub_HandleSubFoldersRecursive DONE
@ECHO:

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_HandleSubFoldersRecursive
REM -------------------------------------------------------------------------------------

REM CALL :sub_HandleSubFoldersRecursive Target

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_HandleSubFoldersRecursive
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_Find__historyAndRemoveRecursive  :  
REM -------------------------------------------------------------------------------------

:sub_Find__historyAndRemoveRecursive

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

SET _sublocalTargetRoot=%~1
SET _sublocalTargetFolder=%_sublocalTargetRoot%__history

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Target Root Folder = "%_sublocalTargetRoot%" >> "%_scriptLOGFQPN%"
@ECHO:Target Folder      = "%_sublocalTargetFolder%"
@ECHO:Target Folder      = "%_sublocalTargetFolder%" >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

IF EXIST "%_sublocalTargetFolder%" (
	REM __history folder found
	
	@ECHO:Target Folder Found!
	@ECHO:Target Folder Found! >> "%_scriptLOGFQPN%"
	
	CALL :sub_Handle__historyFolderAndContent "%_sublocalTargetFolder%"
	
	@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
	
) ELSE (
	REM NOT Source found !
	
	@ECHO:Target Folder does not exist :  "%_sublocalTargetFolder%" !
	@ECHO:Target Folder does not exist :  "%_sublocalTargetFolder%" ! >> "%_scriptLOGFQPN%"
	
	@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
	
)

REM Search for subfolders with content

FOR /D %%G in ("%_sublocalTargetRoot%*.*") DO CALL :sub_HandleSubFoldersRecursive "%_sublocalTargetRoot%%%~nxG"

REM PAUSE

REM * -----------------------------------------------------------------------------------
REM * Clean-up subroutine local variables
REM * -----------------------------------------------------------------------------------

SET "_sublocalTargetRoot="
SET "_sublocalTargetFolder="

REM * ===================================================================================
REM * Log the results
REM * ===================================================================================

@ECHO:sub_Find__historyAndRemoveRecursive DONE
@ECHO:

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_Find__historyAndRemoveRecursive
REM -------------------------------------------------------------------------------------

REM CALL :sub_Find__historyAndRemoveRecursive Target

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_Find__historyAndRemoveRecursive
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_Find__historyAndRemove  :  
REM -------------------------------------------------------------------------------------

:sub_Find__historyAndRemove

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

SET _sublocalTargetRoot=%~1
SET _sublocalTargetFolder=%_sublocalTargetRoot%__history

REM * -------------------------------------------------------------------------
REM * Set subroutine local variables
REM * -------------------------------------------------------------------------

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO:Target Root Folder = "%_sublocalTargetRoot%" >> "%_scriptLOGFQPN%"
@ECHO:Target Folder      = "%_sublocalTargetFolder%"
@ECHO:Target Folder      = "%_sublocalTargetFolder%" >> "%_scriptLOGFQPN%"
@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

IF EXIST "%_sublocalTargetFolder%" (
	REM __history folder found
	
	@ECHO:Target Folder Found!
	@ECHO:Target Folder Found! >> "%_scriptLOGFQPN%"
	
	CALL :sub_Handle__historyFolderAndContent "%_sublocalTargetFolder%"
	
	@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
	
) ELSE (
	REM NOT Source found !
	
	@ECHO:Target Folder does not exist :  "%_sublocalTargetFolder%" !
	@ECHO:Target Folder does not exist :  "%_sublocalTargetFolder%" ! >> "%_scriptLOGFQPN%"
	
	@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
	
)

REM * -----------------------------------------------------------------------------------
REM * Clean-up subroutine local variables
REM * -----------------------------------------------------------------------------------

SET "_sublocalTargetRoot="
SET "_sublocalTargetFolder="

REM * ===================================================================================
REM * Log the results
REM * ===================================================================================

@ECHO:sub_Find__historyAndRemove DONE
@ECHO:

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_Find__historyAndRemove
REM -------------------------------------------------------------------------------------

REM CALL :sub_Find__historyAndRemove Target

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE: sub_Find__historyAndRemove
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

@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

SET STARTFOLDER=.

@ECHO:STARTFOLDER :  "%STARTFOLDER%"
@ECHO:
@ECHO:STARTFOLDER :  "%STARTFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

CALL :sub_Find__historyAndRemove "%STARTFOLDER%\"

REM Search for subfolders with content

FOR /D %%H in ("%STARTFOLDER%\*.*") DO CALL :sub_HandleSubFoldersRecursive "%STARTFOLDER%\%%~nxH"


@ECHO ------------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"


REM =====================================================================================
REM Show the logged results
REM =====================================================================================

START /MAX "%FILEEDITOR%" "%_scriptLOGFQPN%"

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


@ECHO.
@ECHO Log File : "%_scriptLOGFQPN%"
@ECHO Script Completed : %_LOCALSCRIPTNAME%
@ECHO.

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
