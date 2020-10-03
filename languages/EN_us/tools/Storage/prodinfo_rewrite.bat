set lng_label_exist=0
%ushs_base_path%tools\gnuwin32\bin\grep.exe -c -E "^:%~1$" <"%~0" >"%ushs_base_path%temp_lng_var.txt"
set /p lng_label_exist=<"%ushs_base_path%temp_lng_var.txt"
del /q "%ushs_base_path%temp_lng_var.txt"
IF "%lng_label_exist%"=="0" (
	call "!associed_language_script:%language_path%=languages\FR_fr!" "%~1"
	goto:eof
) else (
	goto:%~1
)

:display_title
title PRODINFO reparing %this_script_version% - Shadow256 Ultimate Switch Hack Script %ushs_version%
goto:eof

:intro
echo This script allow to  execute repairing operations on PRODINFO.
echo.
echo Caution, before proceeding to flash such a file, please first make a dump of your current PRODINFO file.
echo.
echo You will need the console key file dumped via Lockpick-RCM as well as a PRODINFO file from the same console.
goto:eof

:prodinfo_input_file_select_choice
echo Select the source prodinfo file
pause
%windir%\system32\wscript.exe //Nologo TOOLS\Storage\functions\open_file.vbs "" "all files ^(*.*^)|*.*|" "Select prodinfo file" "templogs\tempvar.txt"
goto:eof

:prodinfo_input_file_empty_error
echo The prodinfo source file cannot be empty, the script will stop.
goto:eof

:nand_type_must_be_prodinfo_error
echo The dump type must contain the prodinfo partition, the process cannot continue.
goto:eof

:prod_keys_file_select_choice
echo Select the file containing the keys dumped from the console via Lockpick-RCM.
pause
%windir%\system32\wscript.exe //Nologo TOOLS\Storage\functions\open_file.vbs "" "all files ^(*.*^)|*.*|" "Select console keys file" "templogs\tempvar.txt"
goto:eof

:prod_keys_file_empty_error
echo The key file cannot be empty, the script will stop.
goto:eof

:decrypt_biskeys_not_valid_error
echo The provided key file does not allow to decrypt the PRODINFO partition, the script will stop.
goto:eof

:select_action_choice
echo What do you want to do:
echo 1: Verif hashes of the PRODINFO file?
echo 2: Recalculate and rewrite the hashes of the PRODINFO file?
echo 3: Obtain informations of the PRODINFO in a text file ^(usful for debug^)?
echo All other choices: Go back to previous menu.
echo.
set /p action_choice=Make your choice: 
goto:eof

:hashes_errors_found
echo  Hashes errors found.
goto:eof

:hashes_errors_not_found
echo No hashes error found.
goto:eof

:output_folder_choice
echo You will need to select the folder to which to create the file.
pause
%windir%\system32\wscript.exe //Nologo TOOLS\Storage\functions\select_dir.vbs "templogs\tempvar.txt" "Select folder"
goto:eof

:output_folder_empty_error
echo The output directory cannot be empty, the function will be cancelled.
goto:eof

:erase_existing_file_choice
set /p erase_output_file=This folder already contains files generated by this script, do you really want to continue overwriting the existing files ^(if so, the files will be deleted right after this choice^)? ^(%lng_yes_choice%/%lng_no_choice%^): 
goto:eof

:create_prodinfo_error
echo An error occurred during the process of  file creation.
goto:eof

:create_prodinfo_success
echo File creation procedure successfully completed.
goto:eof

:prodinfo_encrypted_usage
echo The file to restore to the console will be the encrypted version ^(filename ending with "encrypted"^).
goto:eof

:return_to_action_choice_question
choice /c %lng_yes_choice%%lng_no_choice% /n /m "Do you want to restart an action with the same source files? ^(%lng_yes_choice%/%lng_no_choice%^): "
goto:eof