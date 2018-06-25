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
SET NEXTOP=:FIRST

GOTO %NEXTOP%

REM ----------------------------------------------------------------
REM Touch Directory
REM ----------------------------------------------------------------
:TOUCHDIR

ECHO Touch "%TARGETDIR%"
CD /D "%TARGETDIR%"
REM FOR %%I IN (*.CMD) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"
REM FOR %%I IN (v*.) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"
FOR %%I IN (*.sh) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"
FOR %%I IN (*.version) DO "%PATHTOUCH%" "%%I" >> "%TEMP%\TouchDir.log"
CD /D "%CURDIR%"

GOTO %NEXTOP%
REM ----------------------------------------------------------------
REM ----------------------------------------------------------------


REM ----------------------------------------------------------------
:FIRST
SET TARGETDIR=%CURDIR%
SET NEXTOP=:SECOND
GOTO :TOUCHDIR

REM ----------------------------------------------------------------
:SECOND


REM ----------------------------------------------------------------
goto :DONE

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

goto :DONE

REM *****************************************************************
REM *****************************************************************
