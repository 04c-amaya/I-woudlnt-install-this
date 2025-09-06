@echo off
:: Auto-elevate to admin if not already
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Cleaning temporary files...
echo.

:: Delete user's temp folder
echo Deleting %TEMP%...
del /f /s /q "%TEMP%\*.*"
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i"

:: Delete system temp folder
echo Deleting C:\Windows\SoftwareDistribution\Downloadh...
del /f /s /q "C:\Windows\SoftwareDistribution\Download*.*"
for /d %%i in ("C:\Windows\SoftwareDistribution\Download*") do rd /s /q "%%i"

:: Delete system temp folder
echo Deleting C:\Windows\Prefetch...
del /f /s /q "C:\Windows\Prefetch\*.*"
for /d %%i in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%i"

echo.
echo Temp cleanup complete.
pause