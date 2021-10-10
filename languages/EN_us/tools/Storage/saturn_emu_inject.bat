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
title Sega Saturn game inject %this_script_version% - Shadow256 Ultimate Switch Hack Script %ushs_version%
goto:eof

:main_menu
echo.
echo 		************      ************   ************                         
echo   	    	 *************    ************    ******************                       
echo   	      	  ***********    ************    *********************                     
echo   	       	   ********   ************    Markus95    *************                    
echo   	       	    ******  *************        ^&         **************                  
echo   	       	     ***  ************          Red-J         ************                 
echo   	       	     ***  ************        shadow256         ************                 
echo   	       	         *************                         ************                
echo   	       	        *************         Presents:        ***********               
echo   	       	          ************                        **********   ***               
echo   	       	           *************     NS Saturn Game Injector    *************   ****           
echo   	       	              *************     v1.0   *************    *********        
echo   	       	               *********************  *************   ************       
echo   	       	                 ******************  *************    *************      
echo   	       	                  ***************  *************       *************    
echo   	       	                   ***********   *************          *************   
echo.
echo 	-=======================================================================================================-
echo							What do you want to do:
echo							1: Display help
echo							2: Start injection
echo							All other choices: Go back to menu.
echo 	-=======================================================================================================-
set /p begin=Make your choice: 
goto:eof

:nsp_source_choice
echo Please choose the Saturn nsp source file in the following window.
echo If you close the window you will return to the menu.
pause
%windir%\system32\wscript.exe //Nologo "%ushs_base_path%TOOLS\Storage\functions\open_file.vbs" "" "Nintendo Switch nsp files^(*.nsp^)|*.nsp|" "Select the Saturn nsp source file" "%ushs_base_path%templogs\tempvar.txt"
goto:eof

:set_gamemaker_game_source
echo Please choose the Saturn game folder to inject ^(.cue and.bin format only^) in the following window.
echo If you close the window you will return to the menu.
pause
%windir%\system32\wscript.exe //Nologo "%ushs_base_path%TOOLS\Storage\functions\select_dir.vbs" "%ushs_base_path%templogs\tempvar.txt" "Select the Saturn game folder to inject"
goto:eof

:set_keys_path
echo Please choose the prod.keys file in the following window.
echo If you close the window you will return to the menu.
pause
%windir%\system32\wscript.exe //Nologo "%ushs_base_path%TOOLS\Storage\functions\open_file.vbs" "" "Switch keys list files^(*.*^)|*.*|" "Select the prod.keys file" "%ushs_base_path%templogs\tempvar.txt"
goto:eof

:set_title_keys_path
echo Please choose the title.keys file in the following window.
echo If you close the window you will return to the menu.
pause
%windir%\system32\wscript.exe //Nologo "%ushs_base_path%TOOLS\Storage\functions\open_file.vbs" "" "Switch keys list files^(*.*^)|*.*|" "Select the title.keys file" "%ushs_base_path%templogs\tempvar.txt"
goto:eof

:set_icon_type_choice
set /p bs=Do you want to choose your own icon file for the game? ^(%lng_yes_choice%/%lng_no_choice%^): 
goto:eof

:set_icon_path
echo Please choose the icon file in the following window.
echo If you close the window you will return to the icon type choice.
pause
%windir%\system32\wscript.exe //Nologo "%ushs_base_path%TOOLS\Storage\functions\open_file.vbs" "" "jpg and png files^(*.jpg;*.png^)|*.jpg;*.png|" "Select the icon file" "%ushs_base_path%templogs\tempvar.txt"
goto:eof

:set_custom_ini_choice
set /p custom_ini_choice=Do you want to choose your own ini config file for the emulator for the game? ^(%lng_yes_choice%/%lng_no_choice%^): 
goto:eof

:set_custom_ini_path
echo Please choose the ini file in the following window.
echo If you close the window you will return to the ini type choice.
pause
%windir%\system32\wscript.exe //Nologo "%ushs_base_path%TOOLS\Storage\functions\open_file.vbs" "" "ini files^(*.ini^)|*.ini|" "Select the custom ini file" "%ushs_base_path%templogs\tempvar.txt"
goto:eof

:set_id
echo Enter the content ID ^(must be unique on the console it is installed on and must be 16 hexadecimal characters long ^(0-9, A-F^)^), leave blank to generate a random ID.
set /p id=ID: 
goto:eof

:id_too_small_error
echo Error, the ID must start from "01".
goto:eof

:id_length_error
echo Error, the ID must be 16 chars long.
goto:eof

:bad_char_error
echo An unauthorized character has been entered.
goto:eof

:set_name
set /p name=Enter the game name to display ^(128 chars max^): 
goto:eof

:could_not_be_empty_error
echo This value couldn't be empty.
goto:eof

:name_length_error
echo Error, the name must be maximum 128 chars long.
goto:eof

:set_author
set /p author=Enter the author name to display ^(64 chars max^): 
goto:eof

:author_length_error
echo Error, the author must be maximum 64 chars long.
goto:eof

:set_version
set /p version=Enter the version to display ^(4 chars max^): 
goto:eof

:version_length_error
echo Error, the version must be maximum 4 chars long.
goto:eof

:set_nsp_path
echo Please choose the folder where to create the game nsp in the following window.
echo If you close the window you will return to the menu.
pause
%windir%\system32\wscript.exe //Nologo "%ushs_base_path%TOOLS\Storage\functions\select_dir.vbs" "%ushs_base_path%templogs\tempvar.txt" "Select the folder where to create the game nsp"
goto:eof

:set_confirm_nsp_duplicated_deletion
choice /c %lng_yes_choice%%lng_no_choice% /n /m "The file ^"%nsp_path%%name%_%id%.nsp^" already exist, do you want to erase the file ^(if yes the file will be deleted just after this choice, if no the script will finish without doing anything^)? ^(%lng_yes_choice%/%lng_no_choice%^): "
goto:eof

:set_confirm_nsp_creation
echo Informations on the Saturn game to create:
echo Saturn game NSP source path: %br%
echo Folder path containing  the Saturn game to inject: %gamemaker_source%
echo ID: %id%
echo Game name: %name%
IF /i "%bs%"=="o" (
	echo Custom icon path: %bz%
) else (
	echo Default icon.
)
echo Author: %author%
echo Version: %version%
echo prod.keys path: %keys_path%
echo title.keys path: %title.keys_path%
echo NSP output path: %nsp_path%
echo.
choice /c %lng_yes_choice%%lng_no_choice% /n /m "Do you want to continue with theses settings? ^(%lng_yes_choice%/%lng_no_choice%^): "
goto:eof

:extract_nsp_step
ECHO 	=========================================================================================================
ECHO.
ECHO	 		        			 Step 1:  Extract Saturn game NSP source...
ECHO.
ECHO 	=========================================================================================================
goto:eof

:conversion_error
echo An error occurred during the process, check your source files and the remaining space on the hard drives.
goto:eof

:nca_step
ECHO.
ECHO 	=========================================================================================================
ECHO.
ECHO	 		        			 Step 2:   Extract Decrypted NCA...
Echo.
ECHO 	=========================================================================================================
goto:eof

:nsp_source_not_allowed
echo The source NSP chosen is not compatible with this script.
goto:eof

:icon_step
ECHO 	=========================================================================================================
ECHO.
ECHO	 		        			 Step 3:   Icon Changing...
echo.
ECHO 	=========================================================================================================
goto:eof

:icon_copy_error
echo The selected file is not a png or jpg file, a generic icon will be used.
goto:eof

:create_game_step
ECHO 	=========================================================================================================
ECHO.
ECHO	 		        			 Step 4:   Creating game...
echo.
ECHO 	=========================================================================================================
goto:eof

:end_process
echo 			Enjoy your game, you can now install your "%nsp_path%%td%" generated file on your console.
goto:eof

:howtouse_text
ECHO.
ECHO 	=========================================================================================================
ECHO.
ECHO	 		        			 How to use this software:
Echo.
ECHO 	=========================================================================================================
Echo 	-Indicate a NSP from retail Saturn Game for sourcing
Echo 	-Indicate your Saturn Game folder to inject
Echo 	-Indicate your prod.keys file
Echo 	-Indicate your title.keys file containing the title key of the NSP source.
Echo 	-Icon can be JPG or PNG and will be resized at good size by the process
Echo 	-Indicate an output folder for your NSP
Echo.
Echo.
Echo 	Greetings:
Echo 			https://gbatemp.net/threads/saturn-emulation-using-cotton-guardian-force-testing-and-debug.600756/
Echo 			The-4n for Hacpack tool, Thealexbarney for Hactoolnet
Echo 			You know who you are!
Echo. 	           
goto:eof