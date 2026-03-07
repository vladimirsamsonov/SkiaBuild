@echo off
set SCRIPT_DIR=%~dp0
if "%SCRIPT_DIR:~-1%"=="\" set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%

REM Load Visual Studio environment for x64
call "C:\Program Files\Microsoft Visual Studio\18\Professional\VC\Auxiliary\Build\vcvars64.bat"

REM Show which compiler and SDK are active
where cl
where link
where jar
set WindowsSDKVersion

echo JAVA_HOME is set to: %JAVA_HOME%
echo ===========================================================================================


where python3 >nul 2>&1 && set "PY=python3" || set "PY=python"

REM Run Python build scripts 
%PY% ./script/checkout.py --version m119-fcb55886b9
if errorlevel 1 exit /b 1

%PY% ./script/build.py --build-type Release
if errorlevel 1 exit /b 1

%PY% ./script/archive.py --build-type Release
if errorlevel 1 exit /b 1

echo.
echo All done. 
exit /b 0
