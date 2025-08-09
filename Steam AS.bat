@echo off
rem [ SETTINGS ]==========================================================
set AppName=Steam Account Switcher
set AppAuthor=h4k70rx
set AppVersion=v2025.03.16
set AppHomePage=https://github.com/h4k70rx
set AppExtName=sas
rem ======================================================================

rem [ APPLICATION ]=======================================================
title %AppName%

if not exist "Steam.exe" (
	echo [ERROR]: Cannot find Steam.exe!
	echo [ERROR]: Please, put the program in the Steam.exe directory!
	echo.
	pause
	exit
)

echo                    ----------------------------------
echo                    %AppName% %AppVersion%
echo                    ------ Developed by %AppAuthor% ------
echo.
echo                      [ %AppHomePage% ]
echo.
echo **************************************************************************
echo *                                                                        *
echo * This application switches easily between your steam accounts.          *
echo *                                                                        *
echo **************************************************************************
echo *                                                                        *
echo * If you want just to start steam with the current account, press ENTER! *
echo *                                                                        *
echo **************************************************************************
echo *                                                                        *
echo * If you launch for first time, you will need to enter your name,        *
echo * password and check "remember me", after that everything is automatic.  *
echo *                                                                        *
echo **************************************************************************
echo.

for /r %%i in (*.%AppExtName%) do echo Current account: %%~ni
set /P account=Please, enter your steam account name: 

if "%account%" == "" ( goto START )

if not exist "%account%.%AppExtName%" (
	del "*.%AppExtName%"
	type nul > "%account%.%AppExtName%"
	taskkill /F /IM Steam.exe
	reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %account% /f
	reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f
)

:START
start steam://open/main
exit
rem ======================================================================