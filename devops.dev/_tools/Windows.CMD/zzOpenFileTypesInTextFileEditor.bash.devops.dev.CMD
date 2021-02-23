@ECHO OFF
REM
REM Script :  Open File Types in Text File Editor - bash scripting - devops.dev files
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

SET _LOCALSCRIPTNAME=zzOpenFileTypesInTextFileEditor.bash.devops.dev
SET _LOCALSCRIPTDATE=2021-02-18
SET _LOCALSCRIPTTIME=2115CDT
SET _LOCALSCRIPTVERSION=v06.03.00
SET _LOCALSCRIPTREVISION=000

SET "_LOCALSCRIPTDESCRIPTION=Open File Types in Text File Editor - bash scripting - devops.dev files"
SET "_LOCALSCRIPTDESCRIPTIONSHORT=Open File Types in Text File Editor, devops.dev bash scripting"

@ECHO:
@ECHO: =====================================================================================
@ECHO: =====================================================================================
@ECHO: Script Name:  %_LOCALSCRIPTNAME%
@ECHO: VERSION:  %_LOCALSCRIPTVERSION%  REVISION:  %_LOCALSCRIPTREVISION%  DATE:  %_LOCALSCRIPTDATE%  TIME:  %_LOCALSCRIPTTIME%
@ECHO: SCRIPT CALLED     :  %0
@ECHO: SCRIPT PARAMETERS :  %*
@ECHO:=====================================================================================
@ECHO:


SET "_scriptStartPath=%CD%"
@ECHO: _scriptStartPath : "%_scriptStartPath%"
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

SET "FILEEDITORNAME="
SET "FILEEDITOR="
SET "DATETIMEGRP="
SET "xPARMNOQUOTES="

SET "_JUSTDOIT="

REM * -------------------------------------------------------------------------
REM * CLEAN UP json file
REM * -------------------------------------------------------------------------

SET "JSON16="

REM * -------------------------------------------------------------------------
REM * CLEAN UP json source file
REM * -------------------------------------------------------------------------

SET "SOURCEJSONPATH="
SET "SOURCEJSONFILENAME="
SET "SOURCEJSONFILE="


REM * -------------------------------------------------------------------------
REM * -------------------------------------------------------------------------

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

REM * -------------------------------------------------------------------------
REM * CLEAN UP json file_meta_info
REM * -------------------------------------------------------------------------

SET "QUERYJSONMETAINFO="

SET "GETjsonfiletype="
SET "GETjsonfileversion="
SET "GETjsonfilerevision="
SET "GETjsonfiledate="
SET "GETjsonfileinformationlevel="
SET "GETjsonMinCMDTemplateVersion="
REM SET "GETjsonXX="

SET "jsonfiletype="
SET "jsonfileversion="
SET "jsonfilerevision="
SET "jsonfiledate="
SET "jsonfileinformationlevel="
SET "jsonMinCMDTemplateVersion="
REM SET "jsonScriptXX="

REM * -------------------------------------------------------------------------
REM * CLEAN UP json solution_info
REM * -------------------------------------------------------------------------

SET "GETjsonScriptSeries="
SET "GETjsonScriptSeriesShort="
SET "GETjsonScriptDate="
SET "GETjsonScriptVersion="
SET "GETjsonScriptRevision="
SET "GETjsonTemplateVersion="
SET "GETjsonTemplateLevel="
SET "GETjsonSubScriptsLevel="
SET "GETjsonSubScriptsVersion="
SET "GETjsonAPISubScriptsLevel="
SET "GETjsonAPISubScriptsVersion="
SET "GETjsonAPISubScriptsRevision="
REM SET "GETjsonXX="

SET "jsonScriptSeries="
SET "jsonScriptSeriesShort="
SET "jsonScriptDate="
SET "jsonScriptVersion="
SET "jsonScriptRevision="
SET "jsonTemplateVersion="
SET "jsonTemplateLevel="
SET "jsonSubScriptsLevel="
SET "jsonSubScriptsVersion="
SET "jsonAPISubScriptsLevel="
SET "jsonAPISubScriptsVersion="
SET "jsonAPISubScriptsRevision="
REM SET "jsonScriptXX="


REM * -------------------------------------------------------------------------
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

@ECHO: CLEAN UP sub_SetTextFileEditorValue

SET "FILEEDITORNAME="
SET "FILEEDITOR="

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_SetTextFileEditorValue
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
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_CONFIGSCRIPTPATHS Start >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
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
@ECHO: Did not find target path ! >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"
GOTO :SUBRTCMNPATHSET

:SUBRTCMNPATHFOUND
@ECHO: Found target path here:  %testthisfqpn% >> "%_scriptLOGFQPN%"
SET "subroutinecommonpath=%testthispath%"
SET "subroutinecommonfqpn=%testthisfqpn%"

:SUBRTCMNPATHSET

REM * -------------------------------------------------------------------------
REM * Log Current Values
REM * -------------------------------------------------------------------------

@ECHO. >> "%_scriptLOGFQPN%"
@ECHO: subroutinescriptname   = %subroutinescriptname% >> "%_scriptLOGFQPN%"
@ECHO: subroutinescriptext    = %subroutinescriptext% >> "%_scriptLOGFQPN%"
@ECHO: subroutinescriptfile   = %subroutinescriptfile% >> "%_scriptLOGFQPN%"
@ECHO: subroutinecommonpath   = %subroutinecommonpath% >> "%_scriptLOGFQPN%"
@ECHO: subroutinecommonfqpn   = %subroutinecommonfqpn% >> "%_scriptLOGFQPN%"
@ECHO: testthispath           = %testthispath% >> "%_scriptLOGFQPN%"
@ECHO: testthisfqpn           = %testthisfqpn% >> "%_scriptLOGFQPN%"
@ECHO: ERRORRETURN            = %ERRORRETURN% >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"

@ECHO. >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_CONFIGSCRIPTPATHS Finished >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
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

@ECHO: CLEAN UP sub_REMOVEQUOTESFROMPARM_VERBOSE

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

@ECHO: Call CLEAN UP Subroutines

CALL :cleanup_sub_SetTextFileEditorValue
CALL :cleanup_sub_REMOVEQUOTESFROMPARM_VERBOSE
CALL :cleanup_sub_1
REM CALL :cleanup_sub_2

REM * -------------------------------------------------------------------------
REM * CLEAN UP Variables we wanted to keep for use by the callers
REM * -------------------------------------------------------------------------

@ECHO: CLEAN UP Variables we wanted to keep for use by the callers

CALL :sub_CLEANUPRESULTVARS

REM * -------------------------------------------------------------------------
REM * CLEAN UP Local Variables
REM * -------------------------------------------------------------------------

@ECHO: CLEAN UP Local Variables

CALL :sub_CLEANUPLOCALVARS

REM * -------------------------------------------------------------------------
REM * CLEAN UP Local Standard Variables
REM * -------------------------------------------------------------------------

@ECHO: CLEAN UP Local Standard Variables

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
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE CLEANUP  
REM -------------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------------

:CLEANUP_SUBROUTINES

@ECHO Call CLEAN UP Subroutines

CALL :cleanup_sub_SetTextFileEditorValue
CALL :cleanup_sub_CONFIGSCRIPTPATHS
CALL :sub_CLEARDTGTZSUFFIXVARS
CALL :cleanup_sub_GetSolutionVersionFromJSON
CALL :cleanup_sub_GetJSONFileDetails
REM CALL :cleanup_sub_
REM CALL :cleanup_sub_

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
REM START MAIN OPERATIONS
REM =====================================================================================
REM =====================================================================================


REM * =========================================================================
REM * CLEAR Variables
REM * =========================================================================

CALL :sub_CLEANUPRESULTVARS
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
@ECHO: Time Zone value processing results: >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"
@ECHO: _TZTIMEOFYEAR          = "%_TZTIMEOFYEAR%" >> "%_scriptLOGFQPN%"
@ECHO: _TZTYPE                = "%_TZTYPE%" >> "%_scriptLOGFQPN%"
@ECHO: _TZCURRENTNAME         = "%_TZCURRENTNAME%" >> "%_scriptLOGFQPN%"
@ECHO: _TZABR                 = "%_TZABR%" >> "%_scriptLOGFQPN%"
@ECHO: _TZABRSTZ              = "%_TZABRSTZ%" >> "%_scriptLOGFQPN%"
@ECHO: _TZABRDTZ              = "%_TZABRDTZ%" >> "%_scriptLOGFQPN%"
@ECHO: _TZCURRENTNAMENOQUOTES = "%_TZCURRENTNAMENOQUOTES%" >> "%_scriptLOGFQPN%"

@ECHO. >> "%_scriptLOGFQPN%"
@ECHO: Date Time Time Zone suffix value results: >> "%_scriptLOGFQPN%"
@ECHO. >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DATE      = "%_DTTZ_SUFFIX_DATE%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DATEDASH  = "%_DTTZ_SUFFIX_DATEDASH%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_TIME      = "%_DTTZ_SUFFIX_TIME%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DTG       = "%_DTTZ_SUFFIX_DTG%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DTGDASH   = "%_DTTZ_SUFFIX_DTGDASH%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_TIMETZ    = "%_DTTZ_SUFFIX_TIMETZ%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DTGTZ     = "%_DTTZ_SUFFIX_DTGTZ%" >> "%_scriptLOGFQPN%"
@ECHO: _DTTZ_SUFFIX_DTGTZDASH = "%_DTTZ_SUFFIX_DTGTZDASH%" >> "%_scriptLOGFQPN%"
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


REM * -----------------------------------------------------------------------------------
REM * END:  Set Date and Time Group values
REM * -----------------------------------------------------------------------------------
REM * ===================================================================================


REM * =========================================================================
REM * =========================================================================


REM * ===================================================================================
REM * JSON Query main variables
REM * ===================================================================================


SET "JSON16=R:\_Common\__JQ\jq-win64.exe"

IF NOT EXIST "%JSON16%" GOTO :ERRJQNOTFOUND


REM * ===================================================================================
REM * JSON Query meta info control variables
REM * ===================================================================================


SET "QUERYJSONMETAINFO=FALSE"

SET "GETjsonfiletype=FALSE"
SET "GETjsonfileversion=FALSE"
SET "GETjsonfilerevision=FALSE"
SET "GETjsonfiledate=FALSE"
SET "GETjsonfileinformationlevel=FALSE"
SET "GETjsonMinCMDTemplateVersion=FALSE"
REM SET "GETjsonXX="


REM * ===================================================================================
REM * JSON Query solution info control variables
REM * ===================================================================================


SET "QUERYJSONSOLUTIONINFO=FALSE"

SET "GETjsonScriptSeries=TRUE"
SET "GETjsonScriptSeriesShort=FALSE"
SET "GETjsonScriptDate=FALSE"
SET "GETjsonScriptVersion=TRUE"
SET "GETjsonScriptRevision=TRUE"
SET "GETjsonTemplateVersion=FALSE"
SET "GETjsonTemplateLevel=FALSE"
SET "GETjsonSubScriptsLevel=FALSE"
SET "GETjsonSubScriptsVersion=FALSE"
SET "GETjsonAPISubScriptsLevel=FALSE"
SET "GETjsonAPISubScriptsVersion=FALSE"
SET "GETjsonAPISubScriptsRevision=FALSE"
REM SET "GETjsonXX="


REM =====================================================================================
REM =====================================================================================


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
@ECHO. >> "%_scriptLOGFQPN%"

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

REM PUSHD
REM CD /D "%_scriptTempWORKDIR%" 

REM PUSHD "%_scriptTempWORKDIR%" 

@ECHO:%_LOCALSCRIPTDESCRIPTIONSHORT%
@ECHO:
@ECHO:%_LOCALSCRIPTDESCRIPTIONSHORT% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

IF "%_JUSTDOIT%"=="TRUE" GOTO :WEAREGOODTOGO

:WEAREGOODTOGO


REM =====================================================================================
REM =====================================================================================
REM JSON File Details
REM =====================================================================================
REM =====================================================================================


REM SET "SOURCEJSONPATH=<<some_path>>"
REM SET "SOURCEJSONPATH=%CD%"
REM SET "SOURCEJSONPATH=R:\CP_DEVOPS\bash 4 Check Point\__Windows.CMD"
REM SET "SOURCEJSONPATH=R:\CP_DEVOPS\bash 4 Check Point\scripts"
REM SET "SOURCEJSONPATH=R:\CP_DEVOPS\R8x API DEVOPS\__Windows.CMD"
SET "SOURCEJSONPATH=R:\CP_DEVOPS\R8x API DEVOPS\devops.dev"
SET "SOURCEJSONFILENAME=solution_info.json"
SET "SOURCEJSONFILE=%SOURCEJSONPATH%\%SOURCEJSONFILENAME%"

@ECHO: SOURCEJSONFILE        = %SOURCEJSONFILE%

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: SOURCEJSONFILE        = %SOURCEJSONFILE% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

REM IF NOT EXIST "%SOURCEJSONFILE%" GOTO :ERRJSONFILENOTFOUND
IF NOT EXIST "%SOURCEJSONFILE%" GOTO :DONEJSONSOLUTIONINFOQUERY


REM * ===================================================================================
REM * ===================================================================================
REM * Execute JSON Query of Solution Info for script series details
REM * ===================================================================================
REM * ===================================================================================


GOTO :STARTJSONQUERY


REM =====================================================================================
REM =====================================================================================
REM =====================================================================================
REM START OF JSON QUERY SUBROUTINES
REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_QueryJSONnonArrayKey  :  Purpose/Description
REM -------------------------------------------------------------------------------------

:sub_QueryJSONnonArrayKey

SET "_sub_querykey=%~1"
SET "_sub_targetvariable=%~2"

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:Subroutine sub_QueryJSONnonArrayKey Start >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

SET "COMMAND2EXECUTE=TYPE ^"%_subSourceJSONFilePath%^" ^| ^"%JSON16%^" ^"%_sub_querykey%^" -r"

REM @ECHO: _sub_querykey       = %_sub_querykey%
REM @ECHO: _sub_targetvariable   = %_sub_targetvariable%
REM @ECHO: COMMAND2EXECUTE       = %COMMAND2EXECUTE%
@ECHO: _sub_querykey       = %_sub_querykey% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: _sub_targetvariable   = %_sub_targetvariable% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: COMMAND2EXECUTE       = %COMMAND2EXECUTE% >> "%_scriptLOGFQPN%" 2>>&1

REM FOR /F "usebackq tokens=1*" %%G IN ( `%COMMAND2EXECUTE%` ) DO SET "%_sub_targetvariable%=%%G"
FOR /F "usebackq tokens=1* delims=" %%G IN ( `%COMMAND2EXECUTE%` ) DO SET "%_sub_targetvariable%=%%~G"

REM @ECHO:
REM @ECHO: %_sub_targetvariable% = %%_sub_targetvariable%%
REM @ECHO:
REM @ECHO: >> "%_scriptLOGFQPN%" 2>>&1
REM @ECHO: %_sub_targetvariable% = %%_sub_targetvariable%% >> "%_scriptLOGFQPN%" 2>>&1
REM @ECHO: >> "%_scriptLOGFQPN%" 2>>&1

@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:Subroutine sub_QueryJSONnonArrayKey Finished >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

SET "_sub_querykey="
SET "_sub_targetvariable="

EXIT /B

REM * -----------------------------------------------------------------------------------
REM * SUBROUTINE IMPLEMENTATION ELEMENTS :  sub_QueryJSONnonArrayKey
REM * -----------------------------------------------------------------------------------

REM CALL :sub_QueryJSONnonArrayKey "%_sub_querykey%" "%_sub_targetvariable%"

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_QueryJSONnonArrayKey
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM END OF JSON QUERY SUBROUTINES
REM =====================================================================================
REM =====================================================================================
REM =====================================================================================


:STARTJSONQUERY


REM =====================================================================================
REM =====================================================================================


GOTO :STARTJSONMETAINFOQUERY


REM =====================================================================================
REM =====================================================================================
REM =====================================================================================
REM START OF JSON META INFO QUERY SUBROUTINES
REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_GetJSONFileDetails  :  Example Subroutine
REM -------------------------------------------------------------------------------------

:sub_GetJSONFileDetails

SET "_subSourceJSONFilePath=%~1"

IF "%~1"=="" (
	ECHO Missing parameter 1
	EXIT /B 255
)

ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO Subroutine sub_GetJSONFileDetails Start >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO Paramter 1 passed : %1 >> "%_scriptLOGFQPN%" 2>>&1
REM ECHO Paramter 2 passed : %2 >> "%_scriptLOGFQPN%" 2>>&1
REM ECHO Paramter 3 passed : %3 >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: _subSourceJSONFilePath = %_subSourceJSONFilePath% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: JSON16                 = %JSON16% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonfiletype%"=="TRUE" GOTO :subDONE_filetype

SET "QUERYKEY=.^\^"file_meta_info^\^".^\^"filetype^\^""
SET "TARGETVARIABLE=jsonfiletype"
SET "jsonfiletype="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfiletype%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfiletype% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_filetype

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonfileversion%"=="TRUE" GOTO :subDONE_fileversion

SET "QUERYKEY=.^\^"file_meta_info^\^".^\^"fileversion^\^""
SET "TARGETVARIABLE=jsonfileversion"
SET "jsonfileversion="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfileversion%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfileversion% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_fileversion

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonfilerevision%"=="TRUE" GOTO :subDONE_filerevision

SET "QUERYKEY=.^\^"file_meta_info^\^".^\^"filerevision^\^""
SET "TARGETVARIABLE=jsonfilerevision"
SET "jsonfilerevision="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfilerevision%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfilerevision% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_filerevision

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonfiledate%"=="TRUE" GOTO :subDONE_filedate

SET "QUERYKEY=.^\^"file_meta_info^\^".^\^"filedate^\^""
SET "TARGETVARIABLE=jsonfiledate"
SET "jsonfiledate="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfiledate%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfiledate% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_filedate

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonfileinformationlevel%"=="TRUE" GOTO :subDONE_fileinformationlevel

SET "QUERYKEY=.^\^"file_meta_info^\^".^\^"fileinformationlevel^\^""
SET "TARGETVARIABLE=jsonfileinformationlevel"
SET "jsonfileinformationlevel="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfileinformationlevel%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonfileinformationlevel% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_fileinformationlevel

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonMinCMDTemplateVersion%"=="TRUE" GOTO :subDONE_MinCMDTemplateVersion

SET "QUERYKEY=.^\^"file_meta_info^\^".^\^"MinCMDTemplateVersion^\^""
SET "TARGETVARIABLE=jsonMinCMDTemplateVersion"
SET "jsonMinCMDTemplateVersion="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonMinCMDTemplateVersion%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonMinCMDTemplateVersion% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_MinCMDTemplateVersion

REM -------------------------------------------------------------------------------

@ECHO:
@ECHO:-------------------------------------------------------------------------------
@ECHO:
ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO Subroutine sub_GetJSONFileDetails Finished >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1

SET "_subSourceJSONFilePath="

EXIT /B

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_GetJSONFileDetails
REM -------------------------------------------------------------------------------------

REM SET "xSubRoutineSetVariable1="
REM CALL :sub_GetJSONFileDetails %parameter%

REM -------------------------------------------------------------------------------------
REM SUBROUTINE CLEANUP : sub_GetJSONFileDetails
REM -------------------------------------------------------------------------------------

:cleanup_sub_GetJSONFileDetails

@ECHO CLEAN UP sub_GetJSONFileDetails

SET "_subSourceJSONFilePath="

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_GetJSONFileDetails
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM END OF JSON META INFO QUERY SUBROUTINES
REM =====================================================================================
REM =====================================================================================
REM =====================================================================================


:STARTJSONMETAINFOQUERY


REM =====================================================================================
REM Query JSON File Meta Inforatin
REM =====================================================================================


SET "jsonfiletype="
SET "jsonfileversion="
SET "jsonfilerevision="
SET "jsonfiledate="
SET "jsonfileinformationlevel="
SET "jsonMinCMDTemplateVersion="
REM SET "jsonScriptXX="

IF /I NOT "%QUERYJSONMETAINFO%"=="TRUE" GOTO :DONEJSONMETAINFOQUERY


REM =====================================================================================
REM Get the required JSON values from Solution Information
REM =====================================================================================


@ECHO:
@ECHO:-------------------------------------------------------------------------------
@ECHO:-------------------------------------------------------------------------------
@ECHO:
ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1

CALL :sub_GetJSONFileDetails "%SOURCEJSONFILE%"

@ECHO:
@ECHO:-------------------------------------------------------------------------------
@ECHO:

IF /I "%GETjsonfiletype%"=="TRUE" @ECHO: jsonfiletype              = %jsonfiletype%
IF /I "%GETjsonfileversion%"=="TRUE" @ECHO: jsonfileversion           = %jsonfileversion%
IF /I "%GETjsonfilerevision%"=="TRUE" @ECHO: jsonfilerevision          = %jsonfilerevision%
IF /I "%GETjsonfiledate%"=="TRUE" @ECHO: jsonfiledate              = %jsonfiledate%
IF /I "%GETjsonfileinformationlevel%"=="TRUE" @ECHO: jsonfileinformationlevel  = %jsonfileinformationlevel%
IF /I "%GETjsonMinCMDTemplateVersion%"=="TRUE" @ECHO: jsonMinCMDTemplateVersion = %jsonMinCMDTemplateVersion%

@ECHO:
@ECHO:-------------------------------------------------------------------------------
@ECHO:-------------------------------------------------------------------------------
@ECHO:

ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: jsonfiletype              = %jsonfiletype% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonfileversion           = %jsonfileversion% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonfilerevision          = %jsonfilerevision% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonfiledate              = %jsonfiledate% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonfileinformationlevel  = %jsonfileinformationlevel% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonMinCMDTemplateVersion = %jsonMinCMDTemplateVersion% >> "%_scriptLOGFQPN%" 2>>&1

ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1


:DONEJSONMETAINFOQUERY


REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM Query Solution Information
REM =====================================================================================
REM =====================================================================================


GOTO :STARTJSONSOLUTIONINFOQUERY


REM =====================================================================================
REM =====================================================================================
REM =====================================================================================
REM START OF JSON SOLUTION INFO QUERY SUBROUTINES
REM =====================================================================================
REM =====================================================================================


REM =====================================================================================
REM -------------------------------------------------------------------------------------
REM START SUBROUTINE:  sub_GetSolutionVersionFromJSON  :  Example Subroutine
REM -------------------------------------------------------------------------------------

:sub_GetSolutionVersionFromJSON

SET "_subSourceJSONFilePath=%~1"

IF "%~1"=="" (
	ECHO Missing parameter 1
	EXIT /B 255
)

ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO Subroutine sub_GetSolutionVersionFromJSON Start >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO Paramter 1 passed : %1 >> "%_scriptLOGFQPN%" 2>>&1
REM ECHO Paramter 2 passed : %2 >> "%_scriptLOGFQPN%" 2>>&1
REM ECHO Paramter 3 passed : %3 >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: _subSourceJSONFilePath = %_subSourceJSONFilePath% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: JSON16                 = %JSON16% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonScriptSeries%"=="TRUE" GOTO :subDONE_ScriptSeries

SET "QUERYKEY=.^\^"solution_info^\^".^\^"ScriptSeries^\^""
SET "TARGETVARIABLE=jsonScriptSeries"
SET "jsonScriptSeries="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptSeries%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptSeries% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_ScriptSeries

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonScriptSeriesShort%"=="TRUE" GOTO :subDONE_ScriptSeriesShort

SET "QUERYKEY=.^\^"solution_info^\^".^\^"ScriptSeriesShort^\^""
SET "TARGETVARIABLE=jsonScriptSeriesShort"
SET "jsonScriptSeriesShort="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptSeriesShort%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptSeriesShort% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_ScriptSeriesShort

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonScriptVersion%"=="TRUE" GOTO :subDONE_ScriptVersion

SET "QUERYKEY=.^\^"solution_info^\^".^\^"ScriptVersion^\^""
SET "TARGETVARIABLE=jsonScriptVersion"
SET "jsonScriptVersion="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptVersion%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptVersion% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_ScriptVersion

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonScriptRevision%"=="TRUE" GOTO :subDONE_ScriptRevision

SET "QUERYKEY=.^\^"solution_info^\^".^\^"ScriptRevision^\^""
SET "TARGETVARIABLE=jsonScriptRevision"
SET "jsonScriptRevision="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptRevision%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptRevision% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_ScriptRevision

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonScriptDate%"=="TRUE" GOTO :subDONE_ScriptDate

SET "QUERYKEY=.^\^"solution_info^\^".^\^"ScriptDate^\^""
SET "TARGETVARIABLE=jsonScriptDate"
SET "jsonScriptDate="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptDate%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonScriptDate% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_ScriptDate

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonTemplateVersion%"=="TRUE" GOTO :subDONE_TemplateVersion

SET "QUERYKEY=.^\^"solution_info^\^".^\^"TemplateVersion^\^""
SET "TARGETVARIABLE=jsonTemplateVersion"
SET "jsonTemplateVersion="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonTemplateVersion%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonTemplateVersion% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_TemplateVersion

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonTemplateLevel%"=="TRUE" GOTO :subDONE_TemplateLevel

SET "QUERYKEY=.^\^"solution_info^\^".^\^"TemplateLevel^\^""
SET "TARGETVARIABLE=jsonTemplateLevel"
SET "jsonTemplateLevel="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonTemplateLevel%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonTemplateLevel% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_TemplateLevel

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonSubScriptsLevel%"=="TRUE" GOTO :subDONE_SubScriptsLevel

SET "QUERYKEY=.^\^"solution_info^\^".^\^"SubScriptsLevel^\^""
SET "TARGETVARIABLE=jsonSubScriptsLevel"
SET "jsonSubScriptsLevel="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonSubScriptsLevel%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonSubScriptsLevel% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_SubScriptsLevel

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonSubScriptsVersion%"=="TRUE" GOTO :subDONE_SubScriptsVersion

SET "QUERYKEY=.^\^"solution_info^\^".^\^"SubScriptsVersion^\^""
SET "TARGETVARIABLE=jsonSubScriptsVersion"
SET "jsonSubScriptsVersion="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonSubScriptsVersion%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonSubScriptsVersion% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_SubScriptsVersion

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonAPISubScriptsLevel%"=="TRUE" GOTO :subDONE_APISubScriptsLevel

SET "QUERYKEY=.^\^"solution_info^\^".^\^"APISubScriptsLevel^\^""
SET "TARGETVARIABLE=jsonAPISubScriptsLevel"
SET "jsonAPISubScriptsLevel="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonAPISubScriptsLevel%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonAPISubScriptsLevel% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_APISubScriptsLevel

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonAPISubScriptsVersion%"=="TRUE" GOTO :subDONE_APISubScriptsVersion

SET "QUERYKEY=.^\^"solution_info^\^".^\^"APISubScriptsVersion^\^""
SET "TARGETVARIABLE=jsonAPISubScriptsVersion"
SET "jsonAPISubScriptsVersion="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonAPISubScriptsVersion%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonAPISubScriptsVersion% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_APISubScriptsVersion

REM -------------------------------------------------------------------------------

IF /I NOT "%GETjsonAPISubScriptsRevision%"=="TRUE" GOTO :subDONE_APISubScriptsRevision

SET "QUERYKEY=.^\^"solution_info^\^".^\^"APISubScriptsRevision^\^""
SET "TARGETVARIABLE=jsonAPISubScriptsRevision"
SET "jsonAPISubScriptsRevision="

CALL :sub_QueryJSONnonArrayKey "%QUERYKEY%" "%TARGETVARIABLE%"

@ECHO: Post CALL : %TARGETVARIABLE% = %jsonAPISubScriptsRevision%
@ECHO: Post CALL : %TARGETVARIABLE% = %jsonAPISubScriptsRevision% >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: >> "%_scriptLOGFQPN%" 2>>&1
@ECHO:------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: >> "%_scriptLOGFQPN%" 2>>&1

:subDONE_APISubScriptsRevision

REM -------------------------------------------------------------------------------

ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO Subroutine sub_GetSolutionVersionFromJSON Finished >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1

SET "_subSourceJSONFilePath="

EXIT /B

REM -------------------------------------------------------------------------------------
REM SUBROUTINE IMPLEMENTATION ELEMENTS : sub_GetSolutionVersionFromJSON
REM -------------------------------------------------------------------------------------

REM SET "xSubRoutineSetVariable1="
REM CALL :sub_GetSolutionVersionFromJSON %parameter%

REM -------------------------------------------------------------------------------------
REM SUBROUTINE CLEANUP : sub_GetSolutionVersionFromJSON
REM -------------------------------------------------------------------------------------

:cleanup_sub_GetSolutionVersionFromJSON

@ECHO CLEAN UP sub_GetSolutionVersionFromJSON

SET "_subSourceJSONFilePath="

EXIT /B 0

REM -------------------------------------------------------------------------------------
REM END SUBROUTINE:  sub_GetSolutionVersionFromJSON
REM -------------------------------------------------------------------------------------
REM =====================================================================================


REM =====================================================================================
REM =====================================================================================
REM END OF JSON SOLUTION INFO QUERY SUBROUTINES
REM =====================================================================================
REM =====================================================================================
REM =====================================================================================


:STARTJSONSOLUTIONINFOQUERY


REM =====================================================================================
REM Query Solution Information
REM =====================================================================================


SET "jsonScriptSeries="
SET "jsonScriptSeriesShort="
SET "jsonScriptDate="
SET "jsonScriptVersion="
SET "jsonScriptRevision="
SET "jsonTemplateVersion="
SET "jsonTemplateLevel="
SET "jsonSubScriptsLevel="
SET "jsonSubScriptsVersion="
SET "jsonAPISubScriptsLevel="
SET "jsonAPISubScriptsVersion="
SET "jsonAPISubScriptsRevision="
REM SET "jsonScriptXX="

IF /I NOT "%QUERYJSONSOLUTIONINFO%"=="TRUE" GOTO :DONEJSONSOLUTIONINFOQUERY


REM =====================================================================================
REM Get the required JSON values from Solution Information
REM =====================================================================================


@ECHO:
@ECHO:-------------------------------------------------------------------------------
@ECHO:-------------------------------------------------------------------------------
@ECHO:
ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1

CALL :sub_GetSolutionVersionFromJSON "%SOURCEJSONFILE%"

@ECHO:
@ECHO:-------------------------------------------------------------------------------
@ECHO:

IF /I "%GETjsonScriptSeries%"=="TRUE" @ECHO: jsonScriptSeries            = %jsonScriptSeries%
IF /I "%GETjsonScriptSeriesShort%"=="TRUE" @ECHO: jsonScriptSeriesShort       = %jsonScriptSeriesShort%
IF /I "%GETjsonScriptDate%"=="TRUE" @ECHO: jsonScriptDate              = %jsonScriptDate%
IF /I "%GETjsonScriptVersion%"=="TRUE" @ECHO: jsonScriptVersion           = %jsonScriptVersion%
IF /I "%GETjsonScriptRevision%"=="TRUE" @ECHO: jsonScriptRevision          = %jsonScriptRevision%
IF /I "%GETjsonTemplateVersion%"=="TRUE" @ECHO: jsonTemplateVersion         = %jsonTemplateVersion%
IF /I "%GETjsonTemplateLevel%"=="TRUE" @ECHO: jsonTemplateLevel           = %jsonTemplateLevel%
IF /I "%GETjsonSubScriptsLevel%"=="TRUE" @ECHO: jsonSubScriptsLevel         = %jsonSubScriptsLevel%
IF /I "%GETjsonSubScriptsVersion%"=="TRUE" @ECHO: jsonSubScriptsVersion       = %jsonSubScriptsVersion%
IF /I "%GETjsonAPISubScriptsLevel%"=="TRUE" @ECHO: jsonAPISubScriptsLevel      = %jsonAPISubScriptsLevel%
IF /I "%GETjsonAPISubScriptsVersion%"=="TRUE" @ECHO: jsonAPISubScriptsVersion    = %jsonAPISubScriptsVersion%
IF /I "%GETjsonAPISubScriptsRevision%"=="TRUE" @ECHO: jsonAPISubScriptsRevision   = %jsonAPISubScriptsRevision%

@ECHO:
@ECHO:-------------------------------------------------------------------------------
@ECHO:-------------------------------------------------------------------------------
@ECHO:

ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1

@ECHO: jsonScriptSeries            = %jsonScriptSeries% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonScriptSeriesShort       = %jsonScriptSeriesShort% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonScriptDate              = %jsonScriptDate% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonScriptVersion           = %jsonScriptVersion% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonScriptRevision          = %jsonScriptRevision% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonTemplateVersion         = %jsonTemplateVersion% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonTemplateLevel           = %jsonTemplateLevel% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonSubScriptsLevel         = %jsonSubScriptsLevel% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonSubScriptsVersion       = %jsonSubScriptsVersion% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonAPISubScriptsLevel      = %jsonAPISubScriptsLevel% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonAPISubScriptsVersion    = %jsonAPISubScriptsVersion% >> "%_scriptLOGFQPN%" 2>>&1
@ECHO: jsonAPISubScriptsRevision   = %jsonAPISubScriptsRevision% >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%" 2>>&1
ECHO. >> "%_scriptLOGFQPN%" 2>>&1


:DONEJSONSOLUTIONINFOQUERY


REM =====================================================================================
REM =====================================================================================


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

REM Check if WORK folders to ignore
IF /I "%_localWORKFOLDER%"=="." GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"==".." GOTO :SKIPWORKACTION
REM IF /I "%_localWORKFOLDER%"=="%_localROOTFOLDER%" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="__folder_template" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="__history" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="__scripting_tools" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="__Updates" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="__Windows.CMD" GOTO :SKIPWORKACTION
REM IF /I "%_localWORKFOLDER%"=="_code_snippets" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="_Deprecated Scripts" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="_fixes" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="_research_scripts" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="_scripting_tools" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="_SYNCAPP" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="_tools" GOTO :SKIPWORKACTION
REM IF /I "%_localWORKFOLDER%"=="Code_Snipets" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="dump" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="delete.csv" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="import.csv" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="sample_data" GOTO :SKIPWORKACTION
IF /I "%_localWORKFOLDER%"=="test" GOTO :SKIPWORKACTION

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_ProcessWORKFolder Start : folder = %_localWORKFOLDER% >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM ECHO. >> "%_scriptLOGFQPN%"

@ECHO: WORK FOLDER = "%_localWORKFOLDER%" >> "%_scriptLOGFQPN%"

PUSHD %_localWORKFOLDER% >> "%_scriptLOGFQPN%"
REM PWD >> "%_scriptLOGFQPN%"
@ECHO: HANDLE THIS WORK DIRECTORYS FILES (%_localWORKFOLDER%) :  %CD% >> "%_scriptLOGFQPN%"
@ECHO: HANDLE THIS WORK DIRECTORYS FILES (%_localWORKFOLDER%) :  %CD%

REM IF NOT "%TARGETEXTENSION1%"=="" FOR %%I IN (%TARGETEXTENSION1%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION2%"=="" FOR %%I IN (%TARGETEXTENSION2%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION3%"=="" FOR %%I IN (%TARGETEXTENSION3%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION4%"=="" FOR %%I IN (%TARGETEXTENSION4%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
IF NOT "%TARGETEXTENSION1%"=="" FOR %%I IN (%TARGETEXTENSION1%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION2%"=="" FOR %%I IN (%TARGETEXTENSION2%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION3%"=="" FOR %%I IN (%TARGETEXTENSION3%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION4%"=="" FOR %%I IN (%TARGETEXTENSION4%) DO (CALL :sub_ProcessFolderFile "%%I")

@ECHO: >> "%_scriptLOGFQPN%"

POPD >> "%_scriptLOGFQPN%"
REM PWD >> "%_scriptLOGFQPN%"
@ECHO: RETURN DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"

REM ECHO. >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_ProcessWORKFolder Finished : folder = %_localWORKFOLDER% >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

GOTO :ENDWORKACTION

:SKIPWORKACTION

@ECHO: SKIPPING FOLDER = "%_localWORKFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: SKIPPING FOLDER = "%_localWORKFOLDER%"

:ENDWORKACTION
REM @ECHO: >> "%_scriptLOGFQPN%"

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

REM Check if folders to ignore
IF /I "%_localROOTFOLDER%"=="__folder_template" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="__history" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="__scripting_tools" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="__Updates" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="__Windows.CMD" GOTO :SKIPACTION
REM IF /I "%_localROOTFOLDER%"=="_code_snippets" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="_Deprecated Scripts" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="_fixes" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="_research_scripts" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="_scripting_tools" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="_SYNCAPP" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="_tools" GOTO :SKIPACTION
REM IF /I "%_localROOTFOLDER%"=="Code_Snipets" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="dump" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="delete.csv" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="import.csv" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="sample_data" GOTO :SKIPACTION
IF /I "%_localROOTFOLDER%"=="test" GOTO :SKIPACTION
REM IF /I "%_localROOTFOLDER%"=="Session_Cleanup" GOTO :SKIPACTION

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: =============================================================================== >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_ProcessROOTFolder Start : folder = %_localROOTFOLDER% >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
REM ECHO. >> "%_scriptLOGFQPN%"

REM Not a folders to ignore
@ECHO: ROOT FOLDER = "%_localROOTFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: ROOT FOLDER = "%_localROOTFOLDER%"

PUSHD %_localROOTFOLDER% >> "%_scriptLOGFQPN%"
REM PWD >> "%_scriptLOGFQPN%"
@ECHO: HANDLE THIS DIRECTORIES FILES :  %CD% >> "%_scriptLOGFQPN%"

REM IF NOT "%TARGETEXTENSION1%"=="" FOR %%I IN (%TARGETEXTENSION1%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION2%"=="" FOR %%I IN (%TARGETEXTENSION2%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION3%"=="" FOR %%I IN (%TARGETEXTENSION3%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
REM IF NOT "%TARGETEXTENSION4%"=="" FOR %%I IN (%TARGETEXTENSION4%) DO (CALL :sub_ProcessFolderFile "%CD%\%%I")
IF NOT "%TARGETEXTENSION1%"=="" FOR %%I IN (%TARGETEXTENSION1%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION2%"=="" FOR %%I IN (%TARGETEXTENSION2%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION3%"=="" FOR %%I IN (%TARGETEXTENSION3%) DO (CALL :sub_ProcessFolderFile "%%I")
IF NOT "%TARGETEXTENSION4%"=="" FOR %%I IN (%TARGETEXTENSION4%) DO (CALL :sub_ProcessFolderFile "%%I")

@ECHO: >> "%_scriptLOGFQPN%"

SET FILESORTWORKDIR=%TEMP%\_tempWORKDIRSORT.TXT

DIR /A:D /B | SORT > "%FILESORTWORKDIR%"

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: WORK DIRECTORIES SORTED : >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
TYPE "%FILESORTWORKDIR%" >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM FOR /F "tokens=*" %%I IN ('DIR /A:D /B | SORT') DO (CALL :sub_ProcessWORKFolder %%H)
FOR /F "delims=" %%H IN (%FILESORTWORKDIR%) DO (CALL :sub_ProcessWORKFolder "%%H")

DEL "%FILESORTWORKDIR%" >> "%_scriptLOGFQPN%"

@ECHO: >> "%_scriptLOGFQPN%"
POPD >> "%_scriptLOGFQPN%"
REM PWD >> "%_scriptLOGFQPN%"
@ECHO: RETURN DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: Subroutine sub_ProcessROOTFolder Finished : folder = %_localROOTFOLDER% >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: =============================================================================== >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO:

GOTO :ENDACTION

:SKIPACTION

@ECHO: SKIPPING FOLDER = "%_localROOTFOLDER%" >> "%_scriptLOGFQPN%"
@ECHO: SKIPPING FOLDER = "%_localROOTFOLDER%"

:ENDACTION
REM @ECHO: >> "%_scriptLOGFQPN%"


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


@ECHO: Log File                        :  "%_scriptLOGFQPN%" >> "%_scriptLOGFQPN%"
@ECHO: Log File                        :  "%_scriptLOGFQPN%"

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
IF "%~4"=="" SET "RAWEXTENSION3=JSON"
IF NOT "%~4"=="" SET "RAWEXTENSION3=%4"

SET "TARGETEXTENSION3=*.%RAWEXTENSION3%"

@ECHO: Target Extension 3 for Action   :  "%TARGETEXTENSION3%" >> "%_scriptLOGFQPN%"
@ECHO: Target Extension 3 for Action   :  "%TARGETEXTENSION3%"

IF "%TARGETEXTENSION3%"=="" GOTO :ENDOFSCRIPT

SET "RAWEXTENSION4="
IF "%~5"=="" SET "RAWEXTENSION4=HELP"
IF NOT "%~5"=="" SET "RAWEXTENSION4=%5"

SET "TARGETEXTENSION4=*.%RAWEXTENSION4%"

@ECHO: Target Extension 4 for Action   :  "%TARGETEXTENSION4%" >> "%_scriptLOGFQPN%"
@ECHO: Target Extension 4 for Action   :  "%TARGETEXTENSION4%"

IF "%TARGETEXTENSION4%"=="" GOTO :ENDOFSCRIPT

@ECHO: >> "%_scriptLOGFQPN%"

PAUSE

PUSHD "%TARGETFOLDER%" >> "%_scriptLOGFQPN%"

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: CURRENT DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: CURRENT DIRECTORY :  %CD%
@ECHO:
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

CALL :sub_ProcessWORKFolder "%CD%"

@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

SET FILESORTROOTDIR=%TEMP%\_tempROOTDIRSORT.TXT

DIR /A:D /B | SORT > "%FILESORTROOTDIR%"

@ECHO: >> "%_scriptLOGFQPN%"
@ECHO: =============================================================================== >> "%_scriptLOGFQPN%"
@ECHO: =============================================================================== >> "%_scriptLOGFQPN%"
@ECHO: ROOT DIRECTORIES SORTED : >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
TYPE "%FILESORTROOTDIR%" >> "%_scriptLOGFQPN%"
@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"
@ECHO: >> "%_scriptLOGFQPN%"

REM FOR /F "delims=" %%G IN (%FILESORTROOTDIR%) DO (CALL :sub_ProcessROOTFolder "%%G")

REM We want these opened in a specific order and only these specific folders

CALL :sub_ProcessROOTFolder "_templates.wip"
CALL :sub_ProcessROOTFolder "_api_subscripts"
CALL :sub_ProcessROOTFolder "export_import.wip"
CALL :sub_ProcessROOTFolder "csv_tools.wip"
CALL :sub_ProcessROOTFolder "Session_Cleanup.wip"

@ECHO: ------------------------------------------------------------------------------- >> "%_scriptLOGFQPN%"

DEL "%FILESORTROOTDIR%" >> "%_scriptLOGFQPN%"

@ECHO: CURRENT DIRECTORY :  %CD% >> "%_scriptLOGFQPN%"
@ECHO: =============================================================================== >> "%_scriptLOGFQPN%"
@ECHO: =============================================================================== >> "%_scriptLOGFQPN%"
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
REM END MAIN OPERATIONS
REM =====================================================================================
REM =====================================================================================


@ECHO:
@ECHO: Log File : "%_scriptLOGFQPN%"
@ECHO: Script Completed : %_LOCALSCRIPTNAME%
@ECHO:

REM PAUSE


REM * =========================================================================
REM * =========================================================================
REM * Script Operational Cleanup before exit
REM * =========================================================================


@ECHO: Cleanup Variables before exit...
@ECHO:


REM * =========================================================================
REM * =========================================================================


CALL :cleanup_sub_GetSolutionVersionFromJSON
CALL :cleanup_sub_GetJSONFileDetails

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

PAUSE

EXIT /b %ERRORLEVEL%


REM *************************************************************************************
REM *************************************************************************************
REM START : Error Handling
REM *************************************************************************************
REM *************************************************************************************


REM -----------------------------------------------------------------
REM Execution Error:  Missing JQ software required for JSON Query
REM -----------------------------------------------------------------
:ERRJQNOTFOUND
ECHO:
ECHO: Execution Error:  Missing JQ software required for JSON Query %JSON16%
ECHO:
SET ERRCRITICAL=JSON_JQ_SOFTWARE_NOT_FOUND
GOTO :ERRDONE


REM -----------------------------------------------------------------
REM Execution Error:  Missing JSON file required for JSON Query
REM -----------------------------------------------------------------
:ERRJSONFILENOTFOUND
ECHO:
ECHO: Execution Error:  Missing JSON file required for JSON Query %SOURCEJSONFILE%
ECHO:
SET ERRCRITICAL=JSON_FILE_FOR_QUERY_NOT_FOUND
GOTO :ERRDONE


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
SET _LOCALSCRIPTNAME=
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
