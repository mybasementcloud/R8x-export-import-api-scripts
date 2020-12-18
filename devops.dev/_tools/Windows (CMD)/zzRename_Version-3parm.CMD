ECHO OFF
REM
REM CODESNIPET :  Rename Files with Version using 3 parameters : OldVersion, NewVersion, TargetFolder - scripts folder specific
REM Version    :  04.25.00
REM Date       :  2020-01-11
REM

SET _LOCALSCRIPTNAME=RenameFilesWithVersion3Parameter.bash
SET _LOCALSCRIPTDATE=2020-01-11
SET _LOCALSCRIPTTIME=2245CST
SET _LOCALSCRIPTVERSION=04.25.00
SET _LOCALSCRIPTREVISION=010


@ECHO.
@ECHO =====================================================================================
@ECHO =====================================================================================
@ECHO Script Name:  %_LOCALSCRIPTNAME%
@ECHO VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION%  DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME%
@ECHO SCRIPT CALLED     :  %0
@ECHO SCRIPT PARAMETERS :  %*
@ECHO =====================================================================================
@ECHO.
@ECHO.


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
REM START SUBROUTINE:  sub_CLEANUPLOCALVARS  :  
REM -------------------------------------------------------------------------------------

:sub_CLEANUPLOCALVARS

REM * -------------------------------------------------------------------------
REM * CLEAN UP Local Variables
REM * -------------------------------------------------------------------------


SET "_localLOGFILE="
SET "_remoteLOGFILE="

SET "FILEEDITORNAME="
SET "FILEEDITOR="
SET "DATETIMEGRP="
SET "xPARMNOQUOTES="

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

SET "_scriptLOGSDIR="
SET "_scriptLOGSPATH="
SET "_scriptLOGSFILE="

SET "_LOCALSCRIPTNAME="
SET "_LOCALSCRIPTDATE="
SET "_LOCALSCRIPTTIME="
SET "_LOCALSCRIPTVERSION="
SET "_LOCALSCRIPTREVISION="


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

@ECHO CLEAN UP sub_SetTextFileEditorValue

SET "FILEEDITORNAME="
SET "FILEEDITOR="

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_SetTextFileEditorValue
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_REMOVEQUOTESFROMPARM  :  Remove Quotes (") From Parameter
REM -------------------------------------------------------------------------------------

:sub_REMOVEQUOTESFROMPARM

SET "xPARMNOQUOTES="

IF "%~1"=="" (
	ECHO Missing parameter 1
	EXIT /B 255
)

SET xPARMNOQUOTES=%~1

EXIT /B

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_REMOVEQUOTESFROMPARM_VERBOSE
REM * -----------------------------------------------------------------------------------

REM SET xPARMNOQUOTES=
REM CALL :sub_REMOVEQUOTESFROMPARM %parameter%
REM SET <TARGET_VARIABLE>=%xPARMNOQUOTES%
REM SET xPARMNOQUOTES=

REM -------------------------------------------------------------------------------------
REM SUBROUTINE CLEANUP : sub_REMOVEQUOTESFROMPARM_VERBOSE
REM -------------------------------------------------------------------------------------

:cleanup_sub_REMOVEQUOTESFROMPARM_VERBOSE

@ECHO CLEAN UP sub_REMOVEQUOTESFROMPARM_VERBOSE

SET "xPARMNOQUOTES="

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_REMOVEQUOTESFROMPARM
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE CLEANUP  
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------

:CLEANUP_SUBROUTINES

@ECHO Call CLEAN UP Subroutines

CALL :cleanup_sub_SetTextFileEditorValue
CALL :cleanup_sub_REMOVEQUOTESFROMPARM_VERBOSE
CALL :cleanup_sub_1
REM CALL :cleanup_sub_2

REM * -------------------------------------------------------------------------
REM * CLEAN UP Variables we wanted to keep for use by the callers
REM * -------------------------------------------------------------------------

@ECHO CLEAN UP Variables we wanted to keep for use by the callers

CALL :sub_CLEANUPRESULTVARS

REM * -------------------------------------------------------------------------
REM * CLEAN UP Local Variables
REM * -------------------------------------------------------------------------

@ECHO CLEAN UP Local Variables

CALL :sub_CLEANUPLOCALVARS

REM * -------------------------------------------------------------------------
REM * CLEAN UP Local Standard Variables
REM * -------------------------------------------------------------------------

@ECHO CLEAN UP Local Standard Variables

CALL :sub_CLEANUPLOCALSTANDARDVARS

REM -------------------------------------------------------------------------------------

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------
REM END SUBROUTINE CLEANUP  
REM -------------------------------------------------------------------------------------
REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM END OF SUBROUTINES
REM =====================================================================================
REM =====================================================================================
REM =====================================================================================

:STARTSCRIPT

REM =====================================================================================
REM =====================================================================================
REM START CODE SNIPET MAIN OPERATIONS
REM =====================================================================================
REM =====================================================================================


REM * =========================================================================
REM * CLEAR Variables
REM * =========================================================================

CALL :sub_CLEANUPRESULTVARS
CALL :sub_CLEANUPLOCALVARS

REM * =========================================================================
REM * Handle Logging Variables, Folders, Paths, and Files
REM * =========================================================================

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
@ECHO VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION%  DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME% >> "%_scriptLOGFQPN%"
@ECHO SCRIPT CALLED     :  %0 >> "%_scriptLOGFQPN%"
@ECHO SCRIPT PARAMETERS :  %* >> "%_scriptLOGFQPN%"
@ECHO ===================================================================================== >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

REM =====================================================================================
REM Configure Text File Editor value
REM =====================================================================================

CALL :sub_SetTextFileEditorValue

REM =====================================================================================
REM =====================================================================================

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
@ECHO Parameter 2 = %2 >> "%_scriptLOGFQPN%"
@ECHO Parameter 3 = %3 >> "%_scriptLOGFQPN%"
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

@ECHO Rename Files with new Version - 2 Parameter operation!
@ECHO.
@ECHO Rename Files with new Version - 2 Parameter operation! >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

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
ECHO. >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO Subroutine sub_ProcessFolderFileRename Start >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"


@ECHO:   Process Folder ="%_localFILEFOLDER%"
@ECHO:   Process Folder ="%_localFILEFOLDER%" >> "%_scriptLOGFQPN%"

brc64.exe /DIR:"%_localFILEFOLDER%" /PATTERN:"*.*" /REPLACECI:"%OLDVERSVALUE%":"%NEWVERSVALUE%" >> "%_scriptLOGFQPN%" /EXECUTE >> "%_scriptLOGFQPN%"


ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO Subroutine sub_ProcessFolderFileRename Finished >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"

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
REM * Do Something 1
REM * ===================================================================================
REM * ===================================================================================

@ECHO: >> "%_scriptLOGFQPN%"

REM -----------------------------------------------------------------
REM -----------------------------------------------------------------

REM -----------------------------------------------------------------
REM Set Target Folder
REM -----------------------------------------------------------------

SET TARGETFOLDER=.

ECHO.
ECHO Paramter 3 = "%3"
ECHO.

REM ECHO ON

if not exist %3 goto :NoParm3Set
SET TARGETFOLDER=%~3

REM ECHO Work Directory = "%TARGETFOLDER%"
REM if not %TARGETFOLDER:~0,3%==" goto :NoQuotes
REM SET TARGETFOLDER=%TARGETFOLDER:~3%
REM SET TARGETFOLDER=%TARGETFOLDER:~0,-3%
REM :NoQuotes
REM ECHO OFF

:NoParm3Set

ECHO.
ECHO Target Folder = "%TARGETFOLDER%"
ECHO.


REM -----------------------------------------------------------------
REM Set new version
REM -----------------------------------------------------------------

SET OLDVERSVALUE=00x00x00

ECHO.
ECHO Paramter 1 = "%1"
ECHO.
ECHO. >> "%_scriptLOGFQPN%"
ECHO Paramter 1 = "%1" >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"

REM ECHO ON

REM ----------------------------------------------------------------
REM Ask if this version is sufficient OK
REM ----------------------------------------------------------------
SET CHKOLDVERSVALUE=%1

:ASKOLDVEROK
SET OPT1=Y
ECHO.
ECHO Old Version to Find and replace.  Validate OLD version is OK as entered?  
ECHO   [Y]es is OK, [N]o or [C]hange to update value, [Q]uit Rename_Version
ECHO.
SET /P OPT1=Find this OLD Version (%CHKOLDVERSVALUE%) [Y/N/C/Q] (%OPT1%) ^>
if /i "%OPT1%"=="Y" GOTO :OLDVERISSET
if /i "%OPT1%"=="N" GOTO :CHANGEOLDVERSION
if /i "%OPT1%"=="C" GOTO :CHANGEOLDVERSION
if /i "%OPT1%"=="Q" GOTO :QUITNOW1
if "%OPT1%"=="" GOTO :OLDVERISSET
GOTO :ASKOLDVEROK

:CHANGEOLDVERSION
ECHO.
SET /P CHKOLDVERSVALUE=Enter updated OLD Version (%CHKOLDVERSVALUE%) ^>
GOTO :ASKOLDVEROK

:QUITNOW1
EXIT

:OLDVERISSET

if "%CHKOLDVERSVALUE%"=="" goto :NoParm2Set
SET OLDVERSVALUE=%CHKOLDVERSVALUE%

:NoParm2Set

ECHO.
ECHO Old Version Value = "%OLDVERSVALUE%"
ECHO.
ECHO. >> "%_scriptLOGFQPN%"
ECHO Old Version Value = "%OLDVERSVALUE%" >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"

REM -----------------------------------------------------------------


REM -----------------------------------------------------------------
REM Set new version
REM -----------------------------------------------------------------

SET NEWVERSVALUE=00x00x01

ECHO.
ECHO Paramter 2 = "%2"
ECHO.
ECHO. >> "%_scriptLOGFQPN%"
ECHO Paramter 2 = "%2" >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"

REM ECHO ON

REM ----------------------------------------------------------------
REM Ask if this version is sufficient OK
REM ----------------------------------------------------------------
SET CHKNEWVERSVALUE=%2

:ASKNEWVEROK
SET OPT1=Y
ECHO.
ECHO New Version to Find and replace.  Validate NEW version is OK as entered?  
ECHO   [Y]es is OK, [N]o or [C]hange to update value, [Q]uit Rename_Version
ECHO.
SET /P OPT1=Replace with this NEW Version (%CHKNEWVERSVALUE%) [Y/N/C/Q] (%OPT1%) ^>
if /i "%OPT1%"=="Y" GOTO :NEWVERISSET
if /i "%OPT1%"=="N" GOTO :CHANGENEWVERSION
if /i "%OPT1%"=="C" GOTO :CHANGENEWVERSION
if /i "%OPT1%"=="Q" GOTO :QUITNOW2
if "%OPT1%"=="" GOTO :NEWVERISSET
GOTO :ASKNEWVEROK

:CHANGENEWVERSION
ECHO.
SET /P CHKNEWVERSVALUE=Enter updated NEW Version (%CHKNEWVERSVALUE%) ^>
GOTO :ASKNEWVEROK

:QUITNOW2
EXIT

:NEWVERISSET

if "%CHKNEWVERSVALUE%"=="" goto :NoParm3Set
SET NEWVERSVALUE=%CHKNEWVERSVALUE%

:NoParm3Set

ECHO.
ECHO New Version Value= "%NEWVERSVALUE%"
ECHO.
ECHO. >> "%_scriptLOGFQPN%"
ECHO New Version Value = "%OLDVERSVALUE%" >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"

REM -----------------------------------------------------------------

ECHO.
ECHO Current Folder : "%CD%"
ECHO.
ECHO. >> "%_scriptLOGFQPN%"
ECHO Current Folder : "%CD%" >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"


@ECHO: >> "%_scriptLOGFQPN%"


REM * ===================================================================================
REM * Enter the target folder for operations
REM * ===================================================================================


PUSHD "%TARGETFOLDER%" >> "%_scriptLOGFQPN%"

@ECHO: >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: CURRENT DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: CURRENT DIRECTORY :  %CD%
@ECHO:


REM * ===================================================================================
REM * Do what we came to do
REM * ===================================================================================


CALL :sub_ProcessFolderFileRename "."


REM * ===================================================================================
REM * Operation completed
REM * ===================================================================================


@ECHO:
@ECHO: Done Processing Target Folder
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: Done Processing Target Folder >> "%_scriptLOGFQPN%"


REM * ===================================================================================
REM * Return to calling folder
REM * ===================================================================================


POPD >> "%_scriptLOGFQPN%"

@ECHO:
@ECHO: CURRENT DIRECTORY :  %CD%
@ECHO:
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: CURRENT DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"


REM * ===================================================================================
REM * Log the results
REM * ===================================================================================


REM @ECHO. >> "%_scriptLOGFQPN%"


REM * =========================================================================
REM * =========================================================================

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
REM END CODE SNIPET MAIN OPERATIONS
REM =====================================================================================
REM =====================================================================================

@ECHO.
@ECHO Log File : "%_scriptLOGFQPN%"
@ECHO Code Snipet Completed : %_LOCALSCRIPTNAME%
@ECHO.

REM PAUSE

REM * =========================================================================
REM * =========================================================================
REM * Script Operational Cleanup before exit
REM * =========================================================================

REM * =========================================================================
REM * Variables we want to keep for use by the callers
REM * =========================================================================

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
ECHO:
ECHO: Execution Error:  Missing Common Subroutines Scripts path %subroutinecommonpath%
ECHO:
SET ERRCRITICAL=COMMON_SUBROUTINES_SCRIPTS_PATH_NOT_FOUND
GOTO :ERRDONE


REM -----------------------------------------------------------------
REM Execution Error:  Missing Subroutine Script
REM -----------------------------------------------------------------
:ERRNOSUBROUTINESCRIPT
ECHO:
ECHO: Execution Error:  Missing Subroutine Script %subroutinecommonfqpn%
ECHO:
SET ERRCRITICAL=SUBROUTINE_SCRIPT_NOT_FOUND
GOTO :ERRDONE


REM -----------------------------------------------------------------
REM Error:  Critical Error Already Set at Start
REM -----------------------------------------------------------------
:ERRCRITSET
ECHO: Critical Error Set!  Critical Error = "ERRCRITICAL"
ECHO:
GOTO :ERRDONE


REM -----------------------------------------------------------------
:ERRHANDLR


REM -----------------------------------------------------------------
:ERRDONE
@ECHO:
@ECHO: !!!!! Error Exit from Script %_LOCALSCRIPTNAME%, Error:  %ERRCRITICAL% >> "%_scriptLOGFQPN%"
@ECHO: !!!!! Error Exit from Script %_LOCALSCRIPTNAME%, Error:  %ERRCRITICAL% >> "%_scriptLOGFQPN%"
@ECHO: ! Log file location : "%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%"
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
