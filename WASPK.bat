:: Windows All Start Up Programs Checker
@echo off
:main
cls
echo.
echo.
echo    ======================================
echo    WASPK  -  Startup programs check - Jir
echo       Easily find most startup programs
echo       --------------------------------
echo      1.-Folders
echo      2.-MsConfig
echo      3.-Services
echo      4.-Task Scheduler
echo      5.-Registries
echo      6.-Group Policies ^(Win Pro/Ent^)
echo      0.-Leave
echo    ======================================
echo.

choice /c 1234560 /n /m "[Input]:"

if %errorlevel% == 6 (
	goto :gpp
) else if %errorlevel% == 5 (
	goto :regd
) else if %errorlevel% == 4 (
	goto :tsksch
) else if %errorlevel% == 3 (
	goto :srvs
) else if %errorlevel% == 2 (
	goto :mscfg
) else if %errorlevel% == 1 (
	goto :fldrs
) else if %errorlevel% == 7 (
	goto :lve
)
goto :eof
::==============================================================================
:fldrs
cls
echo.
echo.
echo    ======================================
echo      Programs in this folders will start
echo       automatically, delete or move the
echo         programs that you dont want.
echo      Consider some might be shorcuts and
echo           Not the programs itself
echo       --------------------------------
echo      1.-User Startups
echo      2.-Machine Startups
echo      0.-Back to Menu
echo    ======================================
echo.

choice /c 120 /n /m "[Input]:"

if %errorlevel% == 2 (
	explorer shell:common startup
) else if %errorlevel% == 1 (
	explorer shell:startup
) else if %errorlevel% == 3 (
	goto :main
)
goto :fldrs
::==============================================================================
:mscfg
cls
echo.
echo.
echo    ======================================
echo    In the tab "Startup" you can go to the
echo      task manager and disable programs.
echo       In the tab "Services" individual
echo      programs. I recommend you to filter
echo           out Microsoft Programs
echo       --------------------------------
echo      1.-MsConfig
echo      0.-Back to Menu
echo    ======================================
echo.

choice /c 10 /n /m "[Input]:"

if %errorlevel% == 1 (
	msconfig
) else if %errorlevel% == 2 (
	goto :main
)
goto :mscfg
::==============================================================================
:srvs
cls
echo.
echo.
echo    ======================================
echo     Here you can either disable or turn
echo     them to manual start up. You should  
echo    REALLY know what you're doing in here.
echo       --------------------------------
echo      1.-Services
echo      0.-Back to Menu
echo    ======================================
echo.

choice /c 10 /n /m "[Input]:"

if %errorlevel% == 1 (
	services.msc
) else if %errorlevel% == 2 (
	goto :main
)
goto :srvs
::==============================================================================
:tsksch
cls
echo.
echo.
echo    ======================================
echo      This are tasks that automatically
echo      run based on triggers, this can be
echo       used to run programs on startup.
echo       --------------------------------
echo      1.-Task Scheduler
echo      0.-Back to Menu
echo    ======================================
echo.

choice /c 10 /n /m "[Input]:"

if %errorlevel% == 1 (
	taskschd.msc
) else if %errorlevel% == 2 (
	goto :main
)
goto :tsksch
::==============================================================================
:regd
cls
echo.
echo.
echo    ======================================
echo      Common registry keys that indicate
echo       startup programs, delete the ones
echo       you want to prevent from starting
echo      REALLY know what you're doing here.
echo       --------------------------------
echo      1.-HKUser/Run
echo      2.-HKUser/RunOnce
echo      3.-HKUser/Pol/Exp/Run
echo      4.-HKLMachine/Run
echo      5.-HKLMachine/RunOnce
echo      6.-HKLMachine/Pol/Exp/Run
echo      7.-HKLMachine/Actv/Installed Comp
echo      8.-HKLMachine/WindowsNT/WinLogon
echo      9.-HKLMachine/Sess Mgr/BootExecute
echo      0.-Back to Menu
echo    ======================================
echo.

choice /c 1234567890 /n /m "[Input]:"

if %errorlevel% == 1 (
	set OpenKey=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
) else if %errorlevel% == 2 (
	set OpenKey=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
) else if %errorlevel% == 3 (
	set OpenKey=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
) else if %errorlevel% == 4 (
	set OpenKey=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run
) else if %errorlevel% == 5 (
	set OpenKey=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce
) else if %errorlevel% == 6 (
	set OpenKey=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
) else if %errorlevel% == 7 (
	set OpenKey=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components
) else if %errorlevel% == 8 (
	set OpenKey=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
) else if %errorlevel% == 9 (
	set OpenKey=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\BootExecute
) else if %errorlevel% == 10 (
	goto :main
)

REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "%OpenKey%" /f
regedit

goto :regd
::==============================================================================
:gpp
cls
echo.
echo.
echo    ======================================
echo      Common policies relating to startup
echo      sequences:
echo      Computer Config=^>Admin Templates=^>System=^>Logon
echo      Computer Config=^>Windows Settings=^>Scripts ^(Startup/Shutdown^) 
:: yeah, went out of ui, deal with it
echo       |^(Only for Windows Pro/Enterprise^)
echo       --------------------------------
echo      1.-Group Policy Editor
echo      0.-Back to Menu
echo    ======================================
echo.

choice /c 10 /n /m "[Input]:"

if %errorlevel% == 1 (
	gpedit.msc
) else if %errorlevel% == 2 (
	goto :main
)
goto :gpp
::==============================================================================
:lve
echo.
echo See ya ^<3 &pause>nul
::u3u
goto :eof