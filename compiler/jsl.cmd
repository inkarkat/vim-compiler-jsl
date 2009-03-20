@echo off
::* NOTE:
::  The optional JavaScript Lint configuration file must reside in this script's
::  directory under the name 'jsl.conf'. 
::
::* DEPENDENCIES:
::  - GNU sed available through %PATH% or 'unix.cmd' script. 
::  - $TOOLBOXHOME points to the base directory of the toolbox that contains the
::    used tools.  
::
::* REVISION	DATE		REMARKS 
::	001	20-Mar-2009	file creation

:: Source UNIX utilities if 'sed' is not accessible. 
for %%F in (sed.exe) do if "%%~$PATH:F" == "" call unix --quiet || exit /B 1

set jslConf=%~dpn0.conf
if not exist "%jslConf%" (set jslConf=) else (set jslConf=-conf "%jslConf%")

:: Wrapper for jsl.exe
:: JavaScript Lint emits an empty line after each "pointer line". We filter this
:: away here, because there are problems if we include this in the pattern. 
"%~n0.exe" %jslConf% %* 2>&1 | sed -e "/^$/d"

