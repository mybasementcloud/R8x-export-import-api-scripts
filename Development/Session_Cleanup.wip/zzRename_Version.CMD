ECHO OFF
REM * =========================================================================
REM * =========================================================================
REM * CodeSnipet :  Set Text File Editor value
REM * =========================================================================
REM * =========================================================================


IF EXIST "%ProgramFiles%\Just Great Software\EditPad Pro 8\EditPadPro8.exe" GOTO :HAVEEDITPADPRO8
IF EXIST "%ProgramFiles%\Just Great Software\EditPad Lite 8\EditPadLite8.exe" GOTO :HAVEEDITPADLITE8
IF EXIST "%ProgramFiles%\Just Great Software\EditPad Lite 7\EditPadLite7.exe" GOTO :HAVEEDITPADLITE7
SET FILEEDITOR=%windir%\NOTEPAD.EXE
GOTO :EDITORISSET

:HAVEEDITPADPRO8
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Pro 8\EditPadPro8.exe
SET FILEEDITORNAME=EditPad Pro 8
GOTO :EDITORISSET

:HAVEEDITPADLITE8
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Lite 8\EditPadLite8.exe
SET FILEEDITORNAME=EditPad Lite 8
GOTO :EDITORISSET

:HAVEEDITPADLITE7
SET FILEEDITOR=%ProgramFiles%\Just Great Software\EditPad Lite 7\EditPadLite7.exe
SET FILEEDITORNAME=EditPad Lite 7
GOTO :EDITORISSET

:EDITORISSET
REM START "%FILEEDITORNAME%" /B /MAX "%FILEEDITOR%" "%LOGFILE%"

REM * =========================================================================
REM * =========================================================================


REM -----------------------------------------------------------------
REM -----------------------------------------------------------------
REM The following Section executes VBS Scripting to set the current date in
REM the path for the created Support Folder structure.
REM -----------------------------------------------------------------

SET DATESCRIPT=D:\APPS\Scripts\_WorkerScripts\SUFFIXDATE.vbs
IF EXIST "%DATESCRIPT%" GOTO USEDATESCRIPT
SET DATESCRIPT=C:\APPS\Scripts\_WorkerScripts\SUFFIXDATE.vbs

:USEDATESCRIPT
del /F/Q "%TEMP%\datepath.cmd"

"%SystemRoot%\System32\cscript" "%DATESCRIPT%"

call "%TEMP%\datepath.cmd"

REM ECHO PATH_SUFFIX_DATE     = %PATH_SUFFIX_DATE%
REM ECHO PATH_SUFFIX_DATEDASH = %PATH_SUFFIX_DATEDASH%
REM ECHO PATH_SUFFIX_TIME     = %PATH_SUFFIX_TIME%
REM ECHO PATH_SUFFIX_DTG      = %PATH_SUFFIX_DTG%
REM ECHO PATH_SUFFIX_DTGDASH  = %PATH_SUFFIX_DTGDASH%
REM pause

del /F/Q "%TEMP%\datepath.cmd"

REM -----------------------------------------------------------------
REM -----------------------------------------------------------------
REM Configure Display and Output Variables
REM -----------------------------------------------------------------

if "%OUTPUTLOG%"=="" SET OUTPUTLOG=.\BRC64_Rename_Version_%PATH_SUFFIX_DTGDASH%.log

ECHO.
ECHO Log file = "%OUTPUTLOG%"
ECHO.
REM pause

REM -----------------------------------------------------------------
REM -----------------------------------------------------------------

REM -----------------------------------------------------------------
REM Set new version
REM -----------------------------------------------------------------

SET OLDVERSVALUE=00x00x00

ECHO.
ECHO Paramter 1 = "%1"
ECHO.

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
SET /P CHKOLDVERSVALUE=Enter new OLD Version (%CHKOLDVERSVALUE%) ^>
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

REM -----------------------------------------------------------------


REM -----------------------------------------------------------------
REM Set new version
REM -----------------------------------------------------------------

SET NEWVERSVALUE=00x00x01

ECHO.
ECHO Paramter 2 = "%2"
ECHO.

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
SET /P OPT1=Find this NEW Version (%CHKNEWVERSVALUE%) [Y/N/C/Q] (%OPT1%) ^>
if /i "%OPT1%"=="Y" GOTO :NEWVERISSET
if /i "%OPT1%"=="N" GOTO :CHANGENEWVERSION
if /i "%OPT1%"=="C" GOTO :CHANGENEWVERSION
if /i "%OPT1%"=="Q" GOTO :QUITNOW2
if "%OPT1%"=="" GOTO :NEWVERISSET
GOTO :ASKNEWVEROK

:CHANGENEWVERSION
ECHO.
SET /P CHKNEWVERSVALUE=Enter new NEW Version (%CHKNEWVERSVALUE%) ^>
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

REM -----------------------------------------------------------------

ECHO.
ECHO Current Folder : "%CD%"
ECHO.

REM pause

REM brc64.exe /DIR:"%WORKDIR%" /PATTERN:"*.jpg" /REPLACECI:" (Small)":"" > "%OUTPUTLOG%"
REM brc64.exe /PATTERN:"*.jpg" /REPLACECI:" (Small)":"" > "%OUTPUTLOG%" /EXECUTE > "%OUTPUTLOG%"
brc64.exe /PATTERN:"*.*" /REPLACECI:"%OLDVERSVALUE%":"%NEWVERSVALUE%" > "%OUTPUTLOG%" /EXECUTE > "%OUTPUTLOG%"

REM start notepad.exe "%OUTPUTLOG%"
START "%FILEEDITORNAME%" /B /MAX "%FILEEDITOR%" "%OUTPUTLOG%"

