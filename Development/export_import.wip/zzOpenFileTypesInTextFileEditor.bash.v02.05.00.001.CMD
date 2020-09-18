@ECHO OFF
REM
REM CODESNIPET :  Code Snipet Open File Types in Text File Editor
REM Version    :  02.05.00
REM Date       :  2020-01-11
REM

SET _LOCALSCRIPTNAME=OpenFileTypesInTextFileEditor.bash
SET _LOCALSCRIPTDATE=2020-01-11
SET _LOCALSCRIPTTIME=1115CST
SET _LOCALSCRIPTVERSION=02.05.00
SET _LOCALSCRIPTREVISION=001


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

@ECHO Open File Types in Text File Editor?
@ECHO.
@ECHO Open File Types in Text File Editor? >> "%_scriptLOGFQPN%"
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
REM START SUBROUTINE:  sub_ProcessFolderFile  :  Process a File in the folder
REM -------------------------------------------------------------------------------------

:sub_ProcessFolderFile

REM parameter 1 :  File in Folder

REM -------------------------------------------------------------------------------------

SET "_localFILE="

SET "_localFILE=%~1"

REM ECHO. >> "%_scriptLOGFQPN%"
REM ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM ECHO Subroutine sub_ProcessFolderFile Start >> "%_scriptLOGFQPN%"
REM ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM ECHO. >> "%_scriptLOGFQPN%"

@ECHO:   Process Folder FILE ="%_localFILE%"
@ECHO:   Process Folder FILE ="%_localFILE%" >> "%_scriptLOGFQPN%"
START "%FILEEDITORNAME%" /MAX /B "%FILEEDITOR%" "%_localFILE%"

REM ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM ECHO Subroutine sub_ProcessFolderFile Finished >> "%_scriptLOGFQPN%"
REM ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM ECHO. >> "%_scriptLOGFQPN%"

SET "_localFILE="

EXIT /B

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_ProcessFolderFile
REM * -----------------------------------------------------------------------------------

REM CALL :sub_ProcessFolderFile %parameter%

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_ProcessFolderFile
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_ProcessWORKFolder  :  Process WORK Folders
REM -------------------------------------------------------------------------------------

:sub_ProcessWORKFolder

REM parameter 1 :  WORK Folder

REM -------------------------------------------------------------------------------------

SET "_localWORKFOLDER="

SET "_localWORKFOLDER=%~1"

ECHO. >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO Subroutine sub_ProcessWORKFolder Start >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM ECHO. >> "%_scriptLOGFQPN%"

REM Check if WORK folders to ignore
IF "%_localWORKFOLDER%"=="_SYNCAPP" GOTO :SKIPWORKACTION
IF "%_localWORKFOLDER%"=="_fixes" GOTO :SKIPWORKACTION
IF "%_localWORKFOLDER%"=="_tools" GOTO :SKIPWORKACTION
IF "%_localWORKFOLDER%"=="Code_Snipets" GOTO :SKIPWORKACTION
IF "%_localWORKFOLDER%"=="_research_scripts" GOTO :SKIPWORKACTION

@ECHO: WORK FOLDER = "%_localWORKFOLDER%" >> "%_scriptLOGFQPN%"

PUSHD %_localWORKFOLDER% >> "%_scriptLOGFQPN%"
REM PWD >> "%_scriptLOGFQPN%"
@ECHO: HANDLE THIS DIRECTORYS FILES :  %CD% >> "%_scriptLOGFQPN%"

REM IF NOT "%TARGETEXTENSION1%"=="" FOR %%I IN (%TARGETEXTENSION1%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION2%"=="" FOR %%I IN (%TARGETEXTENSION2%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION3%"=="" FOR %%I IN (%TARGETEXTENSION3%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
IF NOT "%TARGETEXTENSION1%"=="" FOR %%I IN (%TARGETEXTENSION1%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION2%"=="" FOR %%I IN (%TARGETEXTENSION2%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION3%"=="" FOR %%I IN (%TARGETEXTENSION3%) DO (CALL :sub_ProcessFolderFile "%%I")

@ECHO: >> "%_scriptLOGFQPN%"

POPD >> "%_scriptLOGFQPN%"
REM PWD >> "%_scriptLOGFQPN%"
@ECHO: RETURN DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"

GOTO :ENDWORKACTION

:SKIPWORKACTION

@ECHO: SKIPPING FOLDER = "%_localROOTFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: SKIPPING FOLDER = "%_localROOTFOLDER%"

:ENDWORKACTION
REM @ECHO: >> "%_scriptLOGFQPN%"


REM ECHO. >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO Subroutine sub_ProcessWORKFolder Finished >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"

REM -------------------------------------------------------------------------------------

SET "_localWORKFOLDER="

EXIT /B

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_ProcessWORKFolder
REM * -----------------------------------------------------------------------------------

REM CALL :sub_ProcessWORKFolder %parameter%

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_ProcessWORKFolder
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_ProcessROOTFolder  :  Process ROOT Folders
REM -------------------------------------------------------------------------------------

:sub_ProcessROOTFolder

REM parameter 1 :  ROOT Folder

REM -------------------------------------------------------------------------------------

SET "_localROOTFOLDER="

SET "_localROOTFOLDER=%~1"

ECHO. >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO Subroutine sub_ProcessROOTFolder Start >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM ECHO. >> "%_scriptLOGFQPN%"

REM Check if folders to ignore
IF "%_localROOTFOLDER%"=="_SYNCAPP" GOTO :SKIPACTION
IF "%_localROOTFOLDER%"=="_fixes" GOTO :SKIPACTION
IF "%_localROOTFOLDER%"=="_tools" GOTO :SKIPACTION
IF "%_localROOTFOLDER%"=="Session_Cleanup" GOTO :SKIPACTION

REM Not a folders to ignore
@ECHO: ROOT FOLDER = "%_localROOTFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: ROOT FOLDER = "%_localROOTFOLDER%"

PUSHD %_localROOTFOLDER% >> "%_scriptLOGFQPN%"
REM PWD >> "%_scriptLOGFQPN%"
@ECHO: HANDLE THIS DIRECTORIES FILES :  %CD% >> "%_scriptLOGFQPN%"

REM IF NOT "%TARGETEXTENSION1%"=="" FOR %%I IN (%TARGETEXTENSION1%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION2%"=="" FOR %%I IN (%TARGETEXTENSION2%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION3%"=="" FOR %%I IN (%TARGETEXTENSION3%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
IF NOT "%TARGETEXTENSION1%"=="" FOR %%I IN (%TARGETEXTENSION1%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION2%"=="" FOR %%I IN (%TARGETEXTENSION2%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION3%"=="" FOR %%I IN (%TARGETEXTENSION3%) DO (CALL :sub_ProcessFolderFile "%%I")

@ECHO: >> "%_scriptLOGFQPN%"

SET FILESORTWORKDIR=%TEMP%\_tempWORKDIRSORT.TXT

DIR /A:D /B | SORT > "%FILESORTWORKDIR%"

@ECHO: >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: WORK DIRECTORIES SORTED : >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
TYPE "%FILESORTWORKDIR%" >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM FOR /F "tokens=*" %%I IN ('DIR /A:D /B | SORT') DO (CALL :sub_ProcessWORKFolder %%H)
FOR /F %%H IN (%FILESORTWORKDIR%) DO (CALL :sub_ProcessWORKFolder %%H)

DEL "%FILESORTWORKDIR%" >> "%_scriptLOGFQPN%"

@ECHO: >> "%_scriptLOGFQPN%"
POPD >> "%_scriptLOGFQPN%"
REM PWD >> "%_scriptLOGFQPN%"
@ECHO: RETURN DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
GOTO :ENDACTION

:SKIPACTION

@ECHO: SKIPPING FOLDER = "%_localROOTFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: SKIPPING FOLDER = "%_localROOTFOLDER%"

:ENDACTION
REM @ECHO: >> "%_scriptLOGFQPN%"


ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO Subroutine sub_ProcessROOTFolder Finished >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO. >> "%_scriptLOGFQPN%"

REM -------------------------------------------------------------------------------------

SET "_localROOTFOLDER="

EXIT /B

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_ProcessROOTFolder
REM * -----------------------------------------------------------------------------------

REM CALL :sub_ProcessROOTFolder %parameter%

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_ProcessROOTFolder
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

REM SET xFILEFQPN=%~f1
REM SET xFILEPATH=%~p1
REM SET xFILENAMEWEXT=%~nx1
REM SET xFILEDRIVE=%~d1

SET SCRIPTFQPN=%~f0

@ECHO: Script FQPN for Action          :  "%SCRIPTFQPN%" >> "%_scriptLOGFQPN%"
@ECHO: Script FQPN for Action          :  "%SCRIPTFQPN%"

SET SCRIPTNAME=%~nx0

@ECHO: Script Name for Action          :  "%SCRIPTNAME%" >> "%_scriptLOGFQPN%"
@ECHO: Script Name for Action          :  "%SCRIPTNAME%"

SET SCRIPTFOLDER=%~p0

@ECHO: Script Folder for Action        :  "%SCRIPTFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: Script Folder for Action        :  "%SCRIPTFOLDER%"

SET LOCALFOLDER=%CD%

@ECHO: Local Folder for Action         :  "%LOCALFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: Local Folder for Action         :  "%LOCALFOLDER%"

SET TEMPFOLDER=%TEMP%

@ECHO: Temp Folder for Action          :  "%TEMPFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: Temp Folder for Action          :  "%TEMPFOLDER%"


SET "TARGETFOLDER="
IF "%~1"=="" SET "TARGETFOLDER=."
IF EXIST "%1" SET "TARGETFOLDER=%1"

@ECHO: Target Folder for Action        :  "%TARGETFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: Target Folder for Action        :  "%TARGETFOLDER%"

IF "%TARGETFOLDER%"=="" GOTO :ENDOFSCRIPT

SET "RAWEXTENSION1="
IF "%~2"=="" SET "RAWEXTENSION1=VERSION"
IF NOT "%~2"=="" SET "RAWEXTENSION1=%2"

SET "TARGETEXTENSION1=*.%RAWEXTENSION1%"

@ECHO: Target Extension 1 for Action   :  "%TARGETEXTENSION1%" >> "%_scriptLOGFQPN%"
@ECHO: Target Extension 1 for Action   :  "%TARGETEXTENSION1%"

IF "%TARGETEXTENSION1%"=="" GOTO :ENDOFSCRIPT

SET "RAWEXTENSION2="
IF "%~3"=="" SET "RAWEXTENSION2=SH"
IF NOT "%~3"=="" SET "RAWEXTENSION2=%3"

SET "TARGETEXTENSION2=*.%RAWEXTENSION2%"

@ECHO: Target Extension 2 for Action   :  "%TARGETEXTENSION2%" >> "%_scriptLOGFQPN%"
@ECHO: Target Extension 2 for Action   :  "%TARGETEXTENSION2%"

IF "%TARGETEXTENSION2%"=="" GOTO :ENDOFSCRIPT

SET "RAWEXTENSION3="
IF "%~4"=="" SET "RAWEXTENSION3=HELP"
IF NOT "%~4"=="" SET "RAWEXTENSION3=%4"

SET "TARGETEXTENSION3=*.%RAWEXTENSION3%"

@ECHO: Target Extension 3 for Action   :  "%TARGETEXTENSION3%" >> "%_scriptLOGFQPN%"
@ECHO: Target Extension 3 for Action   :  "%TARGETEXTENSION3%"

IF "%TARGETEXTENSION3%"=="" GOTO :ENDOFSCRIPT

@ECHO: >> "%_scriptLOGFQPN%"

PUSHD "%TARGETFOLDER%" >> "%_scriptLOGFQPN%"

@ECHO: >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: CURRENT DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: CURRENT DIRECTORY :  %CD%
@ECHO:
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

CALL :sub_ProcessWORKFolder "%CD%"

ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

SET FILESORTROOTDIR=%TEMP%\_tempROOTDIRSORT.TXT

DIR /A:D /B | SORT > "%FILESORTROOTDIR%"

@ECHO: >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ROOT DIRECTORIES SORTED : >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
TYPE "%FILESORTROOTDIR%" >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

FOR /F %%G IN (%FILESORTROOTDIR%) DO (CALL :sub_ProcessROOTFolder %%G)

ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

DEL "%FILESORTROOTDIR%" >> "%_scriptLOGFQPN%"

@ECHO: CURRENT DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

POPD >> "%_scriptLOGFQPN%"

:ENDOFSCRIPT

@ECHO: CURRENT DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
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
