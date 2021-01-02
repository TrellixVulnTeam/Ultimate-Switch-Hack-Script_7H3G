::Script by Shadow256
call tools\storage\functions\ini_scripts.bat
Setlocal enabledelayedexpansion
set this_script_full_path=%~0
set associed_language_script=%language_path%\!this_script_full_path:%ushs_base_path%=!
set associed_language_script=%ushs_base_path%%associed_language_script%
IF NOT EXIST "%associed_language_script%" (
	set associed_language_script=languages\FR_fr\!this_script_full_path:%ushs_base_path%=!
	set associed_language_script=%ushs_base_path%!associed_language_script!
	echo The associated language file cannot be found, please run the updater to download it. French will be set as default.
	pause
)
IF NOT EXIST "%associed_language_script%" (
	echo Language error. Please use the update manager to update the script. This script will now close.
	pause
	endlocal
	goto:eof
)
IF EXIST "%~0.version" (
	set /p this_script_version=<"%~0.version"
) else (
	set this_script_version=1.00.00
)
call "%associed_language_script%" "display_title"
cd >temp.txt
set /p calling_script_dir=<temp.txt
del /q temp.txt
set this_script_dir=%~dp0
%this_script_dir:~0,1%:
IF NOT "%~1"=="" (
	IF EXIST "%~1\*.*" (
		set update_file_path=%~1
		set update_type=1
	) else (
		call "%associed_language_script%" "folder_script_param_error"
		goto:endscript
	)
)
cd "%this_script_dir%"
IF EXIST "%calling_script_dir%\templogs" (
	del /q "%calling_script_dir%\templogs" 2>nul
	rmdir /s /q "%calling_script_dir%\templogs" 2>nul
)
mkdir "%calling_script_dir%\templogs"
echo.
call "%associed_language_script%" "keys_file_selection"
set /p keys_file_path=<"%calling_script_dir%\templogs\tempvar.txt"
IF "%keys_file_path%"=="" (
	call "%associed_language_script%" "no_keys_file_selected_error"
	goto:endscript
)
IF NOT "%update_file_path%"=="" goto:skip_hfs0_select
set launch_xci_explorer=
call "%associed_language_script%" "launch_xci_explorer_choice"
IF NOT "%launch_xci_explorer%"=="" set launch_xci_explorer=%launch_xci_explorer:~0,1%
call "%this_script_dir%\functions\modify_yes_no_always_never_vars.bat" "launch_xci_explorer" "o/n_choice"
IF /i "%launch_xci_explorer%"=="o" XCI-Explorer.exe
:update_package_select
call "%associed_language_script%" "package_folder_select"
set /p update_file_path=<"%calling_script_dir%\templogs\tempvar.txt"
IF "%update_file_path%"=="" (
	call "%associed_language_script%" "no_source_selected_error"
	goto:endscript
)
set update_file_path=%update_file_path:\\=\%
:skip_hfs0_select
cd "%this_script_dir%"
set no_exfat=
call "%associed_language_script%" "noexfat_param_choice"
IF NOT "%no_exfat%"=="" set no_exfat=%no_exfat:~0,1%
call "%this_script_dir%\functions\modify_yes_no_always_never_vars.bat" "no_exfat" "o/n_choice"
IF /i "%no_exfat%"=="o" set no_exfat_param=--no-exfat
:start_update_creation
IF NOT EXIST "%calling_script_dir%\update_packages\*.*" (
	del /q "%calling_script_dir%\update_packages" 2>nul
	mkdir "%calling_script_dir%\update_packages"
)
%calling_script_dir:~0,1%:
cd "%calling_script_dir%\update_packages"
copy /v "%this_script_dir%\..\EmmcHaccGen\save.stub" save.stub >nul
"%this_script_dir%\..\EmmcHaccGen\EmmcHaccGen.exe" --keys "%keys_file_path%" %no_exfat_param% --fw "%update_file_path%"
IF %errorlevel% EQU 0 (
	call "%associed_language_script%" "package_creation_success"
) else (
	call "%associed_language_script%" "package_creation_error"
)
del /q save.stub >nul
:endscript
pause
%calling_script_dir:~0,1%:
cd "%calling_script_dir%"
IF EXIST templogs\*.* (
	rmdir /s /q templogs
)
endlocal