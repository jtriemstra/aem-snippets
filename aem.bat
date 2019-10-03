@echo off
setlocal enabledelayedexpansion

echo %~dp0

set _componentName=%~1
set _lowerComponentName=%_componentName: =-%

set "_UCASE=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set "_LCASE=abcdefghijklmnopqrstuvwxyz"

for /l %%a in (0,1,25) do (
   call set "_FROM=%%_UCASE:~%%a,1%%
   call set "_TO=%%_LCASE:~%%a,1%%
   call set "_lowerComponentName=%%_lowerComponentName:!_FROM!=!_TO!%%
)

echo %_componentName%
echo %_lowerComponentName%

set _scriptPath=%~dp0

xcopy /Y /S /E /Q /I %_scriptPath%__component-name__ %_lowerComponentName%

move /Y "%_lowerComponentName%\__component-name__.html" "%_lowerComponentName%\%_lowerComponentName%.html"

setlocal enableextensions disabledelayedexpansion

set "_contentFile=%_lowerComponentName%\.content.xml"
set "_search=__component-title__"
set "_replace=%_componentName%"

for /f "delims=" %%i in ('type "%_contentFile%" ^& break ^> "%_contentFile%" ') do (
        set "_line=%%i"
        setlocal enabledelayedexpansion
        >>"%_contentFile%" echo(!_line:%_search%=%_replace%!)
        endlocal
    )

endlocal

setlocal enableextensions disabledelayedexpansion

set "_dialogFile=%_lowerComponentName%\_cq_dialog\.content.xml"

for /f "delims=" %%i in ('type "%_dialogFile%" ^& break ^> "%_dialogFile%" ') do (
        set "_line=%%i"
        setlocal enabledelayedexpansion
        >>"%_dialogFile%" echo(!_line:%_search%=%_replace%!)
        endlocal
    )

endlocal