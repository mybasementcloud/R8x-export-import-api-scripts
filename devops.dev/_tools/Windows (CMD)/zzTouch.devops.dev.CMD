@ECHO OFF

REM ----------------------------------------------------------------
REM Find Touch Utility
REM ----------------------------------------------------------------

SET PATHTOUCH=

if exist "C:\APPS\Touch\touch.exe" GOTO :SETAPPSTOUCH_C
if exist "D:\APPS\Touch\touch.exe" GOTO :SETAPPSTOUCH_D
if exist "C:\APPS\_Utilities\touch.exe" GOTO :SETAPPSUTILS_C
if exist "D:\APPS\_Utilities\touch.exe" GOTO :SETAPPSUTILS_D

GOTO :ERRNOTOUCH

:SETAPPSTOUCH_C
SET PATHTOUCH=C:\APPS\Touch\touch.exe
GOTO :LASTCHKAPPS

:SETAPPSTOUCH_D
SET PATHTOUCH=D:\APPS\Touch\touch.exe
GOTO :LASTCHKAPPS

:SETAPPSUTILS_C
SET PATHTOUCH=C:\APPS\_Utilities\touch.exe
GOTO :LASTCHKAPPS

:SETAPPSUTILS_D
SET PATHTOUCH=D:\APPS\_Utilities\touch.exe
GOTO :LASTCHKAPPS

:LASTCHKAPPS
if "%PATHTOUCH%"=="" goto :ERRNOTOUCH

REM ----------------------------------------------------------------
REM Initial variables
REM ----------------------------------------------------------------

SET CURDIR=%CD%

GOTO :FIRST

REM ----------------------------------------------------------------
REM ----------------------------------------------------------------
REM ----------------------------------------------------------------

REM ----------------------------------------------------------------
REM Touch Directory
REM ----------------------------------------------------------------
:sub_TOUCHDIR

SET "TARGETDIR=%~1"

ECHO Touch "%TARGETDIR%"

REM CD /D "%TARGETDIR%"
PUSHD "%TARGETDIR%"

REM FOR %%I IN (*.CMD) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"
REM FOR %%I IN (v*.) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"
FOR %%I IN (*.version) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"
FOR %%I IN (*.sh) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"
FOR %%I IN (*.json) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"

REM CD /D "%CURDIR%"
POPD

EXIT /B 0
REM GOTO EOF
REM ----------------------------------------------------------------
REM ----------------------------------------------------------------


REM ----------------------------------------------------------------
REM ----------------------------------------------------------------
REM ----------------------------------------------------------------

:FIRST

REM CALL :sub_TOUCHDIR "%CURDIR%"
CALL :sub_TOUCHDIR "_api_subscripts"
CALL :sub_TOUCHDIR "_api_subscripts\_code_snippets"
CALL :sub_TOUCHDIR "_templates.wip"
REM CALL :sub_TOUCHDIR "_templates.wip\_code_snippet"
CALL :sub_TOUCHDIR "csv_tools.wip"
REM CALL :sub_TOUCHDIR "csv_tools.wip\_code_snippet"
CALL :sub_TOUCHDIR "export_import.wip"
CALL :sub_TOUCHDIR "Session_Cleanup.wip"


REM ----------------------------------------------------------------
GOTO :DONE

REM *****************************************************************
REM *****************************************************************
:DONE

SET PATHTOUCH=
SET CURDIR=
SET TARGETDIR=
SET NEXTOP=

@ECHO ON

REM *****************************************************************
exit /b

REM *****************************************************************
REM *****************************************************************
REM Error Handling
REM *****************************************************************

REM ----------------------------------------------------------------
:ERRNOTOUCH
ECHO.
ECHO No TOUCH.EXE Found
ECHO.

GOTO :DONE

REM *****************************************************************
REM *****************************************************************
