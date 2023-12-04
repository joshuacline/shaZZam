::Windows Deployment Image Customization Kit (C) Joshua Cline - All rights reserved
::Build, administrate and backup your Windows in a native WinPE recovery environment.
@ECHO OFF&&SETLOCAL ENABLEDELAYEDEXPANSION&&CHCP 437>NUL&&SET "$VER_CUR=1131"&&SET "ORIG_CD=%CD%"&&CD /D "%~DP0"&&Reg.exe query "HKU\S-1-5-19\Environment">NUL
IF NOT "%ERRORLEVEL%" EQU "0" ECHO Right-Click ^& Run As Administrator&&PAUSE&&GOTO:CLEAN_EXIT
FOR %%1 in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) DO (SET "A%%1="&&SET "ARG%%1=")
SET "ARGUE=%*"&&SET "DELIMS= "&&CALL:ARGUE&&FOR %%a in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) DO (IF DEFINED A%%a CALL SET "ARG%%a=%%A%%a%%")
FOR /F "TOKENS=*" %%a in ('ECHO %CD%') DO (SET "PROG_FOLDER=%%a")
FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "PROG_FOLDER=%%PROG_FOLDER:%%G=%%G%%")
FOR /F "DELIMS=" %%G in ('CMD.EXE /D /U /C ECHO %PROG_FOLDER%^| FIND /V ""') do (IF "%%G"==" " ECHO Remove the space from the folder's name, then launch again&&PAUSE&&GOTO:CLEAN_EXIT)
IF DEFINED ARG1 FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (FOR %%1 in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) DO (IF DEFINED ARG%%1 CALL SET "ARG%%1=%%ARG%%1:%%G=%%G%%"))
CALL:MOUNT_INT&&IF DEFINED ARG1 SET "PROG_MODE=COMMAND"&&GOTO:COMMAND_MODE
FOR /F "TOKENS=1 DELIMS=: " %%a IN ('DISM') DO (IF "%%a"=="Examples" SET "LANG_PASS=1")
IF NOT DEFINED LANG_PASS ECHO Non-english host language/locale. - Untested - proceed with extreme caution.&&PAUSE
IF NOT "%PROG_FOLDER%"=="X:\$" SET "PROG_MODE=PORTABLE"&&COLOR 0A&&CALL:TITLECARD&&GOTO:PROG_MAIN
IF "%PROG_FOLDER%"=="X:\$" IF "%SystemDrive%"=="X:" SET "PROG_MODE=RAMDISK"&&COLOR 0B&&CALL:TITLECARD
CALL:HOME_AUTO&&CALL:SETS_HANDLER&&REG.EXE DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\MiniNT" /f>NUL 2>&1
IF "%AUTOBOOT%"=="ENABLED" SET "BOOT_TARGET=VHDX"&&CALL:BOOT_TOGGLE&&CALL:AUTOBOOT_COUNT
IF "%AUTOBOOT%"=="ENABLED" GOTO:CLEAN_EXIT
REM PROG_MAIN_PROG_MAIN_PROG_MAIN_PROG_MAIN_PROG_MAIN_PROG_MAIN_PROG_MAIN_
:PROG_MAIN
REM PROG_MAIN_PROG_MAIN_PROG_MAIN_PROG_MAIN_PROG_MAIN_PROG_MAIN_PROG_MAIN_
SET "MOUNT="&&IF "%PROG_MODE%"=="RAMDISK" IF "%PROG_SOURCE%"=="X:\$" CALL:HOME_AUTO
@ECHO OFF&&CLS&&CALL:SETS_HANDLER&&CALL:TITLE_GNC&&CALL:CLEAN&&CALL:COLOR_LAY&&CALL:PAD_LINE
ECHO               Windows Deployment Image Customization Kit&&CALL:PAD_LINE
ECHO.&&ECHO  (%##%1%#$%) Image Processor&&ECHO  (%##%2%#$%) Image Management&&ECHO  (%##%3%#$%) Package Creator&&ECHO  (%##%4%#$%) File Management
ECHO  (%##%5%#$%) Disk Management&&ECHO  (%##%6%#$%) Tasks&&ECHO  (%##%.%#$%) Settings
ECHO.&&CALL:PAD_LINE&&IF DEFINED HOME_TARGET IF "%PROG_SOURCE%"=="%PROG_FOLDER%" ECHO  [%#@%Disk%#$%[%#@%Error%#$% (%##%@%#$%) Attempt Temp. Home-ReAssign [ID[%#@%%HOME_TARGET%%#$%]&&CALL:PAD_LINE
IF DEFINED HOME_TARGET IF "%HOME_MOUNT%"=="YES" IF "%PROG_SOURCE%"=="S:\$" ECHO  [Disk[%#@%%HOME_NUMBER%%#$%] [ID[%#@%%HOME_TARGET%%#$%]&&CALL:PAD_LINE
IF "%SHORTCUTS%"=="ENABLED" ECHO  (%##%Q%#$%)uit (%##%%HOTKEY_1%%#$%) (%##%%HOTKEY_2%%#$%) (%##%%HOTKEY_3%%#$%) (%##%%HOTKEY_4%%#$%) (%##%%HOTKEY_5%%#$%)&&CALL:PAD_LINE
IF NOT "%SHORTCUTS%"=="ENABLED" ECHO  (%##%Q%#$%)uit (%##%?%#$%)                                           [%#@%%PROG_MODE% MODE%#$%]&&CALL:PAD_LINE
CALL:MENU_SELECT
IF "%SELECT%"=="1" GOTO:IMAGEPROC_START
IF "%SELECT%"=="2" GOTO:IMAGEMGR_START
IF "%SELECT%"=="3" GOTO:MAKER_START
IF "%SELECT%"=="4" GOTO:FILEMGR_START
IF "%SELECT%"=="5" IF NOT DEFINED DISCLAIMER CALL:DISCLAIMER
IF "%SELECT%"=="5" IF DEFINED DISCLAIMER GOTO:DISKMGR_START
IF "%SELECT%"=="6" SET "PACK_MODE=INSTANT"&&CALL:PACKEX_MENU_START
IF "%SELECT%"=="@" IF "%PROG_MODE%"=="RAMDISK" CALL:HOME_MANUAL
IF "%SELECT%"=="Q" GOTO:QUIT
IF "%SELECT%"=="~" SET&&CALL:PAUSED
IF "%SELECT%"=="." GOTO:SETTINGS_START
IF "%SELECT%"=="?" CALL:PROG_MAIN_HELP
IF "%SELECT%"=="RESTART" GOTO:RESTART
IF "%SHORTCUTS%"=="ENABLED" CALL:SHORT_RUN
GOTO:PROG_MAIN
:PAD_LINE
IF NOT DEFINED PAD_TYPE SET "PAD_TYPE=1"
IF NOT DEFINED PAD_SIZE SET "PAD_SIZE=7"
IF NOT DEFINED COLOR_ACC SET "COLOR_ACC=6"
IF NOT DEFINED COLOR_BTN SET "COLOR_BTN=7"
IF NOT DEFINED COLOR_TXT SET "COLOR_TXT=0"
IF NOT DEFINED COLOR_SIZ SET "COLOR_SIZ=SMALL"
IF NOT DEFINED COLOR_LAY SET "COLOR_LAY=CHESS"
IF NOT DEFINED COLOR_SEQ SET "RND_SET=XLRX"&&CALL:RANDOM
IF NOT DEFINED COLOR_SEQ IF "%XLRX%"=="0" SET "COLOR_SEQ=1%XLRX%1%XLRX%1%XLRX%1%XLRX%1%XLRX%"
IF NOT DEFINED COLOR_SEQ IF NOT "%XLRX%"=="0" SET "COLOR_SEQ=%XLRX%0%XLRX%0%XLRX%0%XLRX%0%XLRX%0"
SET "COLOR_SEQX=%COLOR_SEQ%"&&IF NOT "%COLOR_SEQ%X"=="%COLOR_SEQX%X" SET "XNTX=0"&&SET "XLRX="&&FOR /F "DELIMS=" %%G IN ('CMD.EXE /D /U /C ECHO %COLOR_SEQ%^| FIND /V ""') do (CALL SET "XLRX=%%G"&&CALL:COLOR_ASSIGN&&CALL SET /A XNTX+=1)
SET "XLRX=%COLOR_TXT%"&&SET "#Z=%#$%"&&SET "XNTX=$"&&CALL:COLOR_ASSIGN
SET "XLRX=%COLOR_BTN%"&&SET "XLRZ=%#$%"&&SET "XNTX=#"&&CALL:COLOR_ASSIGN
SET "XLRX=%COLOR_ACC%"&&SET "XLRZ=%#$%"&&SET "XNTX=@"&&CALL:COLOR_ASSIGN
IF NOT DEFINED CHCP_OLD FOR /F "TOKENS=2 DELIMS=:" %%a IN ('CHCP') DO SET "CHCP_OLD=%%a"
FOR %%a in (1 2 3 4) DO (IF "%PAD_TYPE%"=="%%a" CHCP 65001 >NUL)
IF "%PAD_TYPE%"=="1" IF "%COLOR_SIZ%"=="LARGE" SET "PAD_BLK=□□□□□□□□□□%#$%"
IF "%PAD_TYPE%"=="2" IF "%COLOR_SIZ%"=="LARGE" SET "PAD_BLK=■■■■■■■■■■%#$%"
IF "%PAD_TYPE%"=="3" IF "%COLOR_SIZ%"=="LARGE" SET "PAD_BLK=▒▒▒▒▒▒▒▒▒▒%#$%"
IF "%PAD_TYPE%"=="4" IF "%COLOR_SIZ%"=="LARGE" SET "PAD_BLK=▓▓▓▓▓▓▓▓▓▓%#$%"
IF "%PAD_TYPE%"=="5" IF "%COLOR_SIZ%"=="LARGE" SET "PAD_BLK=~~~~~~~~~~%#$%"
IF "%PAD_TYPE%"=="6" IF "%COLOR_SIZ%"=="LARGE" SET "PAD_BLK===========%#$%"
IF "%PAD_TYPE%"=="7" IF "%COLOR_SIZ%"=="LARGE" SET "PAD_BLK=##########%#$%"
IF "%PAD_TYPE%"=="1" IF "%COLOR_SIZ%"=="SMALL" SET "PAD_BLK=%#0%□%#1%□%#2%□%#3%□%#4%□%#5%□%#6%□%#7%□%#8%□%#9%□%#$%"
IF "%PAD_TYPE%"=="2" IF "%COLOR_SIZ%"=="SMALL" SET "PAD_BLK=%#0%■%#1%■%#2%■%#3%■%#4%■%#5%■%#6%■%#7%■%#8%■%#9%■%#$%"
IF "%PAD_TYPE%"=="3" IF "%COLOR_SIZ%"=="SMALL" SET "PAD_BLK=%#0%▒%#1%▒%#2%▒%#3%▒%#4%▒%#5%▒%#6%▒%#7%▒%#8%▒%#9%▒%#$%"
IF "%PAD_TYPE%"=="4" IF "%COLOR_SIZ%"=="SMALL" SET "PAD_BLK=%#0%▓%#1%▓%#2%▓%#3%▓%#4%▓%#5%▓%#6%▓%#7%▓%#8%▓%#9%▓%#$%"
IF "%PAD_TYPE%"=="5" IF "%COLOR_SIZ%"=="SMALL" SET "PAD_BLK=%#0%~%#1%~%#2%~%#3%~%#4%~%#5%~%#6%~%#7%~%#8%~%#9%~%#$%"
IF "%PAD_TYPE%"=="6" IF "%COLOR_SIZ%"=="SMALL" SET "PAD_BLK=%#0%=%#1%=%#2%=%#3%=%#4%=%#5%=%#6%=%#7%=%#8%=%#9%=%#$%"
IF "%PAD_TYPE%"=="7" IF "%COLOR_SIZ%"=="SMALL" SET "PAD_BLK=%#0%#%#1%#%#2%#%#3%#%#4%#%#5%#%#6%#%#7%#%#8%#%#9%#%#$%"
IF "%PAD_SIZE%"=="10" IF "%COLOR_SIZ%"=="LARGE" ECHO;%#0%%PAD_BLK%%#1%%PAD_BLK%%#2%%PAD_BLK%%#3%%PAD_BLK%%#4%%PAD_BLK%%#5%%PAD_BLK%%#6%%PAD_BLK%%#7%%PAD_BLK%%#8%%PAD_BLK%%#9%%PAD_BLK%
IF "%PAD_SIZE%"=="7" IF "%COLOR_SIZ%"=="LARGE" ECHO;%#0%%PAD_BLK%%#1%%PAD_BLK%%#2%%PAD_BLK%%#3%%PAD_BLK%%#4%%PAD_BLK%%#5%%PAD_BLK%%#6%%PAD_BLK%
IF "%PAD_SIZE%"=="4" IF "%COLOR_SIZ%"=="LARGE" ECHO;%#0%%PAD_BLK%%#1%%PAD_BLK%%#2%%PAD_BLK%%#3%%PAD_BLK%
IF "%PAD_SIZE%"=="3" IF "%COLOR_SIZ%"=="LARGE" ECHO;%#0%%PAD_BLK%%#1%%PAD_BLK%%#2%%PAD_BLK%
IF "%PAD_SIZE%"=="2" IF "%COLOR_SIZ%"=="LARGE" ECHO;%#0%%PAD_BLK%%#1%%PAD_BLK%
IF "%PAD_SIZE%"=="10" IF "%COLOR_SIZ%"=="SMALL" ECHO;%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%
IF "%PAD_SIZE%"=="7" IF "%COLOR_SIZ%"=="SMALL" ECHO;%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%
IF "%PAD_SIZE%"=="4" IF "%COLOR_SIZ%"=="SMALL" ECHO;%PAD_BLK%%PAD_BLK%%PAD_BLK%%PAD_BLK%
IF "%PAD_SIZE%"=="3" IF "%COLOR_SIZ%"=="SMALL" ECHO;%PAD_BLK%%PAD_BLK%%PAD_BLK%
IF "%PAD_SIZE%"=="2" IF "%COLOR_SIZ%"=="SMALL" ECHO;%PAD_BLK%%PAD_BLK%
IF NOT "%COLOR_LAY%"=="STATIC" SET "#0=%#1%"&SET "#1=%#2%"&SET "#2=%#3%"&SET "#3=%#4%"&SET "#4=%#5%"&SET "#5=%#6%"&SET "#6=%#7%"&SET "#7=%#8%"&SET "#8=%#9%"&SET "#9=%#0%"
SET "PAD_SIZE="&&FOR %%a in (1 2 3 4) DO (IF "%PAD_TYPE%"=="%%a" CHCP %CHCP_OLD% >NUL)
EXIT /B
:COLOR_ASSIGN
IF DEFINED XNTX CALL SET "#%XNTX%=%%XLR%XLRX%%%"
EXIT /B
:COLOR_LAY
IF "%COLOR_LAY%"=="RANDOM" SET "COLOR_SEQ="&&EXIT /B
EXIT /B
:ARG_VIEW
IF "%TEST%"=="-ARG" FOR %%a in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) DO (IF DEFINED ARG%%a CALL ECHO [ARG%%a]=[%%ARG%%a%%])
EXIT /B
:ARGUE
IF NOT DEFINED ARGUE EXIT /B
IF NOT DEFINED DELIMS SET "DELIMS= "
IF DEFINED FOR_REF FOR /F "TOKENS=1-9 DELIMS=<>()" %%A IN ("%ARGUE%") DO (CALL SET "ARGUE=%%A%%B%%C%%D%%E%%F%%G"&&CALL ECHO *REF* [%%A])
FOR %%1 in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) DO (CALL SET "C%%1="&&CALL SET "A%%1=")
SET "C="&&IF NOT "%DELIMS%"==" " FOR /F "DELIMS=" %%G IN ('CMD.EXE /D /U /C ECHO %DELIMS%^| FIND /V ""') do (CALL SET /A "C+=1"&&SET "V=%%G"&&CALL:DELIMS)
SET "X="&&SET "A=1"&&FOR /F "DELIMS=" %%1 in ('CMD.EXE /D /U /C ECHO %ARGUE%^| FIND /V ""') DO (CALL SET "V=%%1"&&CALL:ARGUEX)
CALL SET /A "ROW+=1"&&IF DEFINED ARG_ONE CALL:ARG_SHIFT
IF DEFINED GET_ROW IF DEFINED ROW_EXT IF "%ROW%"=="%ROW_TGT%" CALL SET "ROW_DSP={1A{%A1%}-{2B{%A2%}-{3C{%A3%}-{4D{%A4%}-{5E{%A5%}-{6F{%A6%}-{7G{%A7%}-{8H{%A8%}-{9I{%A9%}-{10J{%A10%}-{11K{%A11%}-{12L{%A12%}-{13M{%A13%}-{14N{%A14%}-{15O{%A15%}-{16P{%A16%}-{17Q{%A17%}-{18R{%A18%}-{19S{%A19%}-{20T{%A20%}"
IF DEFINED GET_ROW IF DEFINED ROW_EXT IF DEFINED ROW CALL ECHO  {%ROW%} {1A{%A1%}-{2B{%A2%}-{3C{%A3%}-{4D{%A4%}-{5E{%A5%}-{6F{%A6%}-{7G{%A7%}-{8H{%A8%}-{9I{%A9%}-{10J{%A10%}-{11K{%A11%}-{12L{%A12%}-{13M{%A13%}-{14N{%A14%}-{15O{%A15%}-{16P{%A16%}-{17Q{%A17%}-{18R{%A18%}-{19S{%A19%}-{20T{%A20%}&&CALL:PAD_LINE
IF DEFINED GET_ROW IF NOT DEFINED ROW_EXT IF "%ROW%"=="%ROW_TGT%" CALL SET "ROW_DSP={1A{%A1%}-{2B{%A2%}-{3C{%A3%}-{4D{%A4%}-{5E{%A5%}-{6F{%A6%}-{7G{%A7%}-{8H{%A8%}-{9I{%A9%}"
IF DEFINED GET_ROW IF NOT DEFINED ROW_EXT IF DEFINED ROW CALL ECHO  {%ROW%} {1A{%A1%}-{2B{%A2%}-{3C{%A3%}-{4D{%A4%}-{5E{%A5%}-{6F{%A6%}-{7G{%A7%}-{8H{%A8%}-{9I{%A9%}&&CALL:PAD_LINE
IF DEFINED MARK IF "%ROW%"=="%ROW_TGT%" IF "%FOR_SAV%"=="FRESH" IF EXIST FOR.CMD DEL /F FOR.CMD>NUL
IF DEFINED MARK IF "%ROW%"=="%ROW_TGT%" CALL SET CLM_DAT=%%A%CLM_TGT%%%&&IF NOT EXIST FOR.CMD ECHO @ECHO OFF>FOR.CMD
IF DEFINED MARK IF "%ROW%"=="%ROW_TGT%" CALL SET FS_Z=[SKIP[%SKIPPER%] [DELIM[%DELIMS%] [IN[CMD] [IF[%%%%%CLM_TGT%]==[%CLM_DAT%]
IF DEFINED MARK IF "%ROW%"=="%ROW_TGT%" ECHO FOR /F "TOKENS=1-9 %SKIPPER% DELIMS=<>()%DELIMS%" %%%%1 IN ('%CUR_CMD%') DO (IF "%%%%%CLM_TGT%"=="%CLM_DAT%" ECHO [%CLM_DAT%] FOUND^&PAUSE)>>FOR.CMD
SET "ARGUE="&&SET "ARG_ONE="&&EXIT /B
:DELIMS
CALL SET "C%C%=%V%"&&EXIT /B
:ARGUEX
IF "%DELIMS%"==" " SET "C1= "
IF "%V%"=="%C1%" IF DEFINED X IF DEFINED C1 CALL SET "A%A%=%X%"&&CALL SET /A "A+=1"&&CALL SET "X="
IF "%V%"=="%C2%" IF DEFINED X IF DEFINED C2 CALL SET "A%A%=%X%"&&CALL SET /A "A+=1"&&CALL SET "X="
IF "%V%"=="%C3%" IF DEFINED X IF DEFINED C3 CALL SET "A%A%=%X%"&&CALL SET /A "A+=1"&&CALL SET "X="
IF "%V%"=="%C4%" IF DEFINED X IF DEFINED C4 CALL SET "A%A%=%X%"&&CALL SET /A "A+=1"&&CALL SET "X="
IF "%V%"=="%C5%" IF DEFINED X IF DEFINED C5 CALL SET "A%A%=%X%"&&CALL SET /A "A+=1"&&CALL SET "X="
IF NOT "%V%"=="%C1%" IF NOT "%V%"=="%C2%" IF NOT "%V%"=="%C3%" IF NOT "%V%"=="%C4%" IF NOT "%V%"=="%C5%" CALL SET "X=%X%%V%"
IF DEFINED X SET "A%A%=%X%"
EXIT /B
:ARG_SHIFT
IF NOT DEFINED ARG_ONE EXIT /B
SET "SHIFT="&&FOR /F "TOKENS=1-9 DELIMS= " %%a IN ("%ARG_ONE%") DO (
IF "%%a"=="%A1%" SET A1=%A1%&&SET A2=%A2%&&SET A3=%A3%&&SET A4=%A4%&&SET A5=%A5%&&SET A6=%A6%&&SET A7=%A7%&&SET A8=%A8%&&SET A9=%A9%&&SET "SHIFT=0"
IF "%%a"=="%A2%" SET A1=%A2%&&SET A2=%A3%&&SET A3=%A4%&&SET A4=%A5%&&SET A5=%A6%&&SET A6=%A7%&&SET A7=%A8%&&SET A8=%A9%&&SET A9=%A10%&&SET "SHIFT=1"
IF "%%a"=="%A3%" SET A1=%A3%&&SET A2=%A4%&&SET A3=%A5%&&SET A4=%A6%&&SET A5=%A7%&&SET A6=%A8%&&SET A7=%A9%&&SET A8=%A10%&&SET A9=%A11%&&SET "SHIFT=2"
IF "%%a"=="%A4%" SET A1=%A4%&&SET A2=%A5%&&SET A3=%A6%&&SET A4=%A7%&&SET A5=%A8%&&SET A6=%A9%&&SET A7=%A10%&&SET A8=%A11%&&SET A9=%A12%&&SET "SHIFT=3"
IF "%%a"=="%A5%" SET A1=%A5%&&SET A2=%A6%&&SET A3=%A7%&&SET A4=%A8%&&SET A5=%A9%&&SET A6=%A10%&&SET A7=%A11%&&SET A8=%A12%&&SET A9=%A13%&&SET "SHIFT=4"
IF "%%a"=="%A6%" SET A1=%A6%&&SET A2=%A7%&&SET A3=%A8%&&SET A4=%A9%&&SET A5=%A10%&&SET A6=%A11%&&SET A7=%A12%&&SET A8=%A13%&&SET A9=%A14%&&SET "SHIFT=5"
IF "%%a"=="%A7%" SET A1=%A7%&&SET A2=%A8%&&SET A3=%A9%&&SET A4=%A10%&&SET A5=%A11%&&SET A6=%A12%&&SET A7=%A13%&&SET A8=%A14%&&SET A9=%A15%&&SET "SHIFT=6"
IF "%%a"=="%A8%" SET A1=%A8%&&SET A2=%A9%&&SET A3=%A10%&&SET A4=%A11%&&SET A5=%A12%&&SET A6=%A13%&&SET A7=%A14%&&SET A8=%A15%&&SET A9=%A16%&&SET "SHIFT=7"
IF "%%a"=="%A9%" SET A1=%A9%&&SET A2=%A10%&&SET A3=%A11%&&SET A4=%A12%&&SET A5=%A13%&&SET A6=%A14%&&SET A7=%A15%&&SET A8=%A16%&&SET A9=%A17%&&SET "SHIFT=8")
FOR %%1 in (A10 A11 A12 A13 A14 A15 A16 A17) DO (CALL SET %%1=)
EXIT /B
REM COMMAND_MODE_COMMAND_MODE_COMMAND_MODE_COMMAND_MODE_COMMAND_MODE
:COMMAND_MODE
REM COMMAND_MODE_COMMAND_MODE_COMMAND_MODE_COMMAND_MODE_COMMAND_MODE
SET "CAME_FROM=COMMAND"&&SET "BRUTE_FORCE="&&SET "PROG_SOURCE=%PROG_FOLDER%"&&SET "PROG_TARGET=%PROG_FOLDER%"&&CALL:FOLDER_LOCATE&&SET "EXIT_FLAG="&&CALL:COMMAND_ERROR
IF "%EXIT_FLAG%"=="1" GOTO:CLEAN_EXIT
IF "%ARG1%"=="-HELP" CALL:COMMAND_HELP
IF "%ARG1%"=="-FILEMGR" IF "%ARG2%"=="-GRANT" IF DEFINED ARG3 IF EXIST "%ARG3%" SET "$PICK=%ARG3%"&&SET "NO_PAUSE=1"&&CALL:FMGR_OWN
IF "%ARG1%"=="-NEXTBOOT" FOR %%a in (VHDX RECOVERY) DO (IF "%ARG2%"=="-%%a" SET "BOOT_TARGET=%%a"&&CALL:BOOT_TOGGLE)
IF "%ARG1%"=="-NEXTBOOT" IF DEFINED NEXT_BOOT CALL ECHO Next boot is [%NEXT_BOOT%]
IF "%ARG1%"=="-NEXTBOOT" IF NOT DEFINED NEXT_BOOT CALL ECHO Error: WINDICK boot environment not installed on this pc.
IF "%ARG1%"=="-BOOTMAKER" IF DEFINED ARG2 IF "%ARG3%"=="-DISKID" IF DEFINED ARG4 SET "DISK_TARGET=%ARG4%"&&CALL:DISK_QUERY>NUL
IF "%ARG1%"=="-BOOTMAKER" IF DEFINED ARG2 IF "%ARG3%"=="-DISKID" IF DEFINED ARG4 SET "ARG3=-DISK"&&SET "ARG4=%DISK_NUMBER%"
IF "%ARG1%"=="-DISKMGR" IF DEFINED ARG2 IF "%ARG3%"=="-DISKID" IF DEFINED ARG4 SET "DISK_TARGET=%ARG4%"&&CALL:DISK_QUERY>NUL
IF "%ARG1%"=="-DISKMGR" IF DEFINED ARG2 IF "%ARG3%"=="-DISKID" IF DEFINED ARG4 SET "ARG3=-DISK"&&SET "ARG4=%DISK_NUMBER%"
IF "%ARG1%"=="-AUTOBOOT" IF "%ARG2%"=="-REMOVE" SET "BOOTSVC=REMOVE"&&CALL:AUTOBOOT_TOGGLE&ECHO AutoBoot service is removed
IF "%ARG1%"=="-AUTOBOOT" IF "%ARG2%"=="-INSTALL" SET "BOOTSVC=INSTALL"&&CALL:AUTOBOOT_TOGGLE&ECHO AutoBoot service is installed
IF "%ARG1%"=="-IMAGEPROC" IF "%ARG2%"=="-WIM" IF DEFINED ARG3 IF EXIST "%IMAGE_FOLDER%\%ARG3%" IF "%ARG4%"=="-INDEX" IF DEFINED ARG5 IF "%ARG6%"=="-VHDX" IF DEFINED ARG7 IF "%ARG8%"=="-SIZE" IF DEFINED ARG9 SET "SOURCE_TYPE=WIM"&&SET "TARGET_TYPE=VHDX"&&SET "WIM_SOURCE=%ARG3%"&&SET "WIM_INDEX=%ARG5%"&&SET "VHDX_TARGET=%ARG7%"&&SET "VHDX_SIZE=%ARG9%"&&CALL:IMAGEPROC
IF "%ARG1%"=="-IMAGEPROC" IF "%ARG2%"=="-WIM" IF DEFINED ARG3 IF EXIST "%IMAGE_FOLDER%\%ARG3%" IF "%ARG4%"=="-INDEX" IF DEFINED ARG5 IF "%ARG6%"=="-WIM" IF DEFINED ARG7 IF "%ARG8%"=="-XLVL" IF DEFINED ARG9 SET "SOURCE_TYPE=WIM"&&SET "TARGET_TYPE=WIM"&&SET "WIM_SOURCE=%ARG3%"&&SET "WIM_INDEX=%ARG5%"&&SET "WIM_TARGET=%ARG7%"&&SET "WIM_XLVL=%ARG9%"&&CALL:IMAGEPROC
IF "%ARG1%"=="-IMAGEPROC" IF "%ARG2%"=="-VHDX" IF DEFINED ARG3 IF EXIST "%IMAGE_FOLDER%\%ARG3%" IF "%ARG4%"=="-INDEX" IF DEFINED ARG5 IF "%ARG6%"=="-WIM" IF DEFINED ARG7 IF "%ARG8%"=="-XLVL" IF DEFINED ARG9 SET "SOURCE_TYPE=VHDX"&&SET "TARGET_TYPE=WIM"&&SET "VHDX_SOURCE=%ARG3%"&&SET "WIM_INDEX=%ARG5%"&&SET "WIM_TARGET=%ARG7%"&&SET "WIM_XLVL=%ARG9%"&&CALL:IMAGEPROC
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUN" IF "%ARG3%"=="-LST" IF DEFINED ARG4 IF EXIST "%CACHE_FOLDER%\%ARG4%" SET "$LST1=%CACHE_FOLDER%\%ARG4%"&&IF "%ARG5%"=="-LIVE" SET "LIVE_APPLY=1"&&CALL:IMAGEMGR_RUN_LIST
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUN" IF "%ARG3%"=="-LST" IF DEFINED ARG4 IF EXIST "%CACHE_FOLDER%\%ARG4%" SET "$LST1=%CACHE_FOLDER%\%ARG4%"&&IF "%ARG5%"=="-VHDX" SET "LIVE_APPLY="&&IF DEFINED ARG6 IF EXIST "%IMAGE_FOLDER%\%ARG6%" SET "VDISK=%IMAGE_FOLDER%\%ARG6%"&&CALL:IMAGEMGR_RUN_LIST
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUNBRUTE" IF "%ARG3%"=="-LST" IF DEFINED ARG4 IF EXIST "%CACHE_FOLDER%\%ARG4%" SET "$LST1=%CACHE_FOLDER%\%ARG4%"&&IF "%ARG5%"=="-LIVE" SET "LIVE_APPLY=1"&&SET "BRUTE_FORCE=ENABLED"&&CALL:IMAGEMGR_RUN_LIST
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUNBRUTE" IF "%ARG3%"=="-LST" IF DEFINED ARG4 IF EXIST "%CACHE_FOLDER%\%ARG4%" SET "$LST1=%CACHE_FOLDER%\%ARG4%"&&IF "%ARG5%"=="-VHDX" SET "LIVE_APPLY="&&IF DEFINED ARG6 IF EXIST "%IMAGE_FOLDER%\%ARG6%" SET "VDISK=%IMAGE_FOLDER%\%ARG6%"&&SET "BRUTE_FORCE=ENABLED"&&CALL:IMAGEMGR_RUN_LIST
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUN" IF "%ARG3%"=="-PKX" IF DEFINED ARG4 IF EXIST "%PACK_FOLDER%\%ARG4%" SET "PKX_PACK=%PACK_FOLDER%\%ARG4%"&&IF "%ARG5%"=="-LIVE" SET "LIVE_APPLY=1"&&CALL:AIO_PARSE
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUN" IF "%ARG3%"=="-PKX" IF DEFINED ARG4 IF EXIST "%PACK_FOLDER%\%ARG4%" SET "PKX_PACK=%PACK_FOLDER%\%ARG4%"&&IF "%ARG5%"=="-VHDX" SET "LIVE_APPLY="&&IF DEFINED ARG6 IF EXIST "%IMAGE_FOLDER%\%ARG6%" SET "VDISK=%IMAGE_FOLDER%\%ARG6%"&&CALL:AIO_PARSE
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUNBRUTE" IF "%ARG3%"=="-PKX" IF DEFINED ARG4 IF EXIST "%PACK_FOLDER%\%ARG4%" SET "PKX_PACK=%PACK_FOLDER%\%ARG4%"&&IF "%ARG5%"=="-LIVE" SET "LIVE_APPLY=1"&&SET "BRUTE_FORCE=ENABLED"&&CALL:AIO_PARSE
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUNBRUTE" IF "%ARG3%"=="-PKX" IF DEFINED ARG4 IF EXIST "%PACK_FOLDER%\%ARG4%" SET "PKX_PACK=%PACK_FOLDER%\%ARG4%"&&IF "%ARG5%"=="-VHDX" SET "LIVE_APPLY="&&IF DEFINED ARG6 IF EXIST "%IMAGE_FOLDER%\%ARG6%" SET "VDISK=%IMAGE_FOLDER%\%ARG6%"&&SET "BRUTE_FORCE=ENABLED"&&CALL:AIO_PARSE
IF "%ARG1%"=="-BOOTMAKER" IF "%ARG2%"=="-CREATE" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 IF "%ARG5%"=="-SRC" IF DEFINED ARG6 IF EXIST "%PROG_SOURCE%\%ARG6%" SET "DISK_NUMBER=%ARG4%"&&CALL:DISK_QUERY>NUL 2>&1
IF "%ARG1%"=="-BOOTMAKER" IF "%ARG2%"=="-CREATE" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 IF "%ARG5%"=="-SRC" IF DEFINED ARG6 IF EXIST "%PROG_SOURCE%\%ARG6%" SET "DISK_NUMBER=%ARG4%"&&FOR %%a in (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) DO (IF "%ARG4%"=="%%a" CALL SET "DISK_TARGET=%%DISKID_%%a%%"&&CALL ECHO.%%DISKID_%%a%%>"%TEMP%\DISK_TARGET")
IF "%ARG1%"=="-BOOTMAKER" IF "%ARG2%"=="-CREATE" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 IF "%ARG5%"=="-SRC" IF DEFINED ARG6 IF EXIST "%PROG_SOURCE%\%ARG6%" SET "BOOT_IMAGE=%PROG_SOURCE%\%ARG6%"&&SET "VHDX_$ETUP=%ARG8%"&&CALL:BOOT_MAKER
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-LIST" CALL:DISK_QUERY
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-INSPECT" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&CALL:DISKMGR_INSPECT
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-GETDISK" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&CALL:DISK_QUERY>NUL
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-GETDISK" IF "%ARG3%"=="-DISK" IF DEFINED DISKID_%DISK_NUMBER% CALL ECHO [DISK [%DISK_NUMBER%] [DISK ID[%%DISKID_%DISK_NUMBER%%%]
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-GETDISK" IF "%ARG3%"=="-DISK" IF NOT DEFINED DISKID_%DISK_NUMBER% CALL ECHO DISK #/ID DOES NOT EXIST
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-ERASE" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 CALL:DISK_QUERY>NUL
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-ERASE" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&FOR %%a in (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) DO (IF "%ARG4%"=="%%a" CALL SET "DISK_TARGET=%%DISKID_%%a%%"&&CALL:DISKMGR_ERASE)
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-CHANGEID" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&SET "GET_DISK_ID=%ARG5%"&&CALL:DISKMGR_CHANGEID
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-CREATE" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&IF "%ARG5%"=="-SIZE"  SET "PART_SIZE=%ARG6%"&&CALL:DISKMGR_CREATE
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-FORMAT" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&IF "%ARG5%"=="-PART" SET "PART_NUMBER=%ARG6%"&&CALL:DISKMGR_FORMAT
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-DELETE" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&IF "%ARG5%"=="-PART" SET "PART_NUMBER=%ARG6%"&&CALL:DISKMGR_DELETE
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-LOCK" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&IF "%ARG5%"=="-PART" SET "PART_NUMBER=%ARG6%"&&CALL:DISKMGR_LOCK
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-MOUNT" IF "%ARG3%"=="-DISK" IF DEFINED ARG4 SET "DISK_NUMBER=%ARG4%"&&IF "%ARG5%"=="-PART" SET "PART_NUMBER=%ARG6%"&&IF "%ARG7%"=="-LETTER" SET "DISK_LETTER=%ARG8%"&&CALL:DISKMGR_MOUNT
IF "%ARG1%"=="-DISKMGR" IF "%ARG2%"=="-UNMOUNT" IF "%ARG3%"=="-LETTER" IF DEFINED ARG4 SET "DISK_LETTER=%ARG4%"&&CALL:DISKMGR_UNMOUNT
CALL:SCRATCH_PACK_DELETE&&CALL:SCRATCH_DELETE&&IF EXIST "%TEMP%\DISK_TARGET" DEL /Q /F "%TEMP%\DISK_TARGET">NUL 2>&1
GOTO:CLEAN_EXIT
:COMMAND_ERROR
SET "TEST="&&FOR %%a in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) DO (CALL SET "TEST=%%ARG%%a%%"&&CALL:ARG_VIEW)
ECHO.&&IF DEFINED ARG1 IF NOT "%ARG1%"=="-HELP" IF NOT "%ARG1%"=="-AUTOBOOT" IF NOT "%ARG1%"=="-NEXTBOOT" IF NOT "%ARG1%"=="-BOOTMAKER" IF NOT "%ARG1%"=="-DISKMGR" IF NOT "%ARG1%"=="-FILEMGR" IF NOT "%ARG1%"=="-IMAGEPROC" IF NOT "%ARG1%"=="-IMAGEMGR" ECHO Type windick.cmd -help for more options.&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-FILEMGR" IF NOT "%ARG2%"=="-GRANT" ECHO Valid options are -grant&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-FILEMGR" IF "%ARG2%"=="-GRANT" IF NOT EXIST "%ARG3%" ECHO %ARG3% does not exist&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-NEXTBOOT" IF NOT "%ARG2%"=="-RECOVERY" IF NOT "%ARG2%"=="-VHDX" ECHO Valid options are -recovery and -vhdx&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-AUTOBOOT" IF NOT "%ARG2%"=="-INSTALL" IF NOT "%ARG2%"=="-REMOVE" ECHO Valid options are -install and -remove&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-BOOTMAKER" IF "%ARG2%"=="-CREATE" IF DEFINED ARG6 IF NOT EXIST "%PROG_SOURCE%\%ARG6%" ECHO BOOT-MEDIA %PROG_SOURCE%\%ARG6% is missing&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-BOOTMAKER" IF "%ARG2%"=="-CREATE" IF DEFINED ARG8 IF NOT EXIST "%IMAGE_FOLDER%\%ARG8%" ECHO VHDX %IMAGE_FOLDER%\%ARG8% is missing&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-IMAGEPROC" IF "%ARG2%"=="-WIM" IF DEFINED ARG3 IF NOT EXIST "%IMAGE_FOLDER%\%ARG3%" ECHO WIM %IMAGE_FOLDER%\%ARG3% is missing&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-IMAGEPROC" IF "%ARG2%"=="-VHDX" IF DEFINED ARG3 IF NOT EXIST "%IMAGE_FOLDER%\%ARG3%" ECHO VHDX %IMAGE_FOLDER%\%ARG3% is missing&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-MOUNT" IF "%ARG3%"=="-ISO" IF DEFINED ARG4 IF NOT EXIST "%IMAGE_FOLDER%\%ARG4%" ECHO ISO %IMAGE_FOLDER%\%ARG4% is missing&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUN" IF "%ARG3%"=="-LST" IF DEFINED ARG4 IF NOT EXIST "%CACHE_FOLDER%\%ARG4%" ECHO List %CACHE_FOLDER%\%ARG4% is missing&&SET "EXIT_FLAG=1"
IF "%ARG1%"=="-IMAGEMGR" IF "%ARG2%"=="-RUN" IF "%ARG5%"=="-VHDX" IF DEFINED ARG6 IF NOT EXIST "%IMAGE_FOLDER%\%ARG6%" ECHO VHDX %IMAGE_FOLDER%\%ARG6% is missing&&SET "EXIT_FLAG=1"
EXIT /B
:COMMAND_HELP
ECHO  Command Line Parameters:
ECHO.&&ECHO          [MISC]
ECHO    -help                                                          (This menu)
ECHO    -arg                                                           (1st arg=arg-test. Last arg=exec+test)
ECHO    -nextboot -vhdx                                                (Schedule next boot to vhdx)
ECHO    -nextboot -recovery                                            (Schedule next boot to recovery)
ECHO    -autoboot -install                                             (Install reboot to recovery service)
ECHO    -autoboot -remove                                              (Remove reboot to recovery service)
ECHO.&&ECHO          [BOOT CREATOR]
ECHO    -bootmaker -create -disk (#) / -diskid (id) -src (boot.wim)    (Erase + Create Boot-Media on specified disk)
ECHO  Examples:
ECHO    -bootmaker -create -disk 0 -src boot.wim -vhdx z.vhdx
ECHO    -bootmaker -create -diskid 12345678-1234-1234-1234-123456781234 -src boot.sav -vhdx z.vhdx
ECHO.&&ECHO          [IMAGE PROCESSOR]
ECHO    -imageproc -wim (wim) -index (#) -wim (wim) -xlvl (fast/max)   (WIM index isolation)
ECHO    -imageproc -wim (wim) -index (#) -vhdx (vhdx) -size (MB)       (WIM to VHDX Conversion)
ECHO    -imageproc -vhdx (vhdx) -index (#) -wim (wim) -xlvl (fast/max) (VHDX to WIM Conversion)
ECHO  Examples:
ECHO    -imageproc -wim x.wim -index 1 -vhdx z.vhdx -size 25600
ECHO    -imageproc -wim x.wim -index 1 -wim z.wim -xlvl fast
ECHO    -imageproc -vhdx z.vhdx -index 1 -wim x.wim -xlvl fast
ECHO.&&ECHO          [IMAGE MANAGEMENT]
ECHO    -imagemgr -run -lst (x.lst) -live /or/ -vhdx (z.vhdx)          (Run list)
ECHO    -imagemgr -run -pkx (x.pkx) -live /or/ -vhdx (z.vhdx)          (Run AIO Package w/integrated list)
ECHO    -imagemgr -runbrute -lst (x.lst) -live /or/ -vhdx (z.vhdx)     (Run list with brute force enabled)
ECHO  Examples:
ECHO    -imagemgr -run -lst x.lst -live
ECHO    -imagemgr -run -pkx x.pkx -vhdx z.vhdx
ECHO    -imagemgr -runbrute -lst x.lst -vhdx z.vhdx
ECHO.&&ECHO          [FILE MANAGEMENT]
ECHO    -filemgr -grant (file/folder)                                  (Take ownership + Grant Permissions)
ECHO  Examples:
ECHO    -filemgr -grant c:\x.txt
ECHO.&&ECHO          [DISK MANAGEMENT]
ECHO    -diskmgr -list                                                 (Condensed list of disks)
ECHO    -diskmgr -getdisk -disk (#) /or/ -diskid (id)                  (Query disk # / disk id)
ECHO    -diskmgr -inspect -disk (#) /or/ -diskid (id)                  (DiskPart inquiry on specified disk)
ECHO    -diskmgr -erase -disk (#) /or/ -diskid (id)                    (Delete ALL partitions on specified disk)
ECHO    -diskmgr -changeid -disk (#) /or/ -diskid (id) (new id)        (Change disk id of specified disk)
ECHO    -diskmgr -create -disk (#) /or/ -diskid (id) -size (MB)        (Create NTFS partition on specified disk)
ECHO    -diskmgr -format -disk (#) /or/ -diskid (id) -part (#)         (Format partition w/NTFS on specified disk)
ECHO    -diskmgr -delete -disk (#) /or/ -diskid (id) -part (#)         (Delete partition on specified disk)
ECHO    -diskmgr -unmount -letter (ltr)                                (Remove drive letter)
ECHO    -diskmgr -mount -disk (#) /or/ -diskid (id) -part (#) -letter (ltr) (Assign drive letter)
ECHO  Examples:
ECHO    -diskmgr -create -disk 0 -size 25600
ECHO    -diskmgr -mount -disk 0 -part 1 -letter e
ECHO    -diskmgr -mount -diskid 12345678-1234-1234-1234-123456781234 -part 1 -letter e
ECHO.&&ECHO Specified images, lists, or boot media must be in their respective folders or the operation will fail.
ECHO Note when using command-mode: images, lists, nor boot media can have a space in the file name.
EXIT /B
:TITLECARD
SET "RND_SET=TITLE"&&CALL:RANDOM
IF "%TITLE%"=="1" TITLE  When finished, backup by converting to WIM.
IF "%TITLE%"=="2" TITLE  Boot-media can be imported in Image Management using "-".
IF "%TITLE%"=="3" TITLE  Rebuild the BCD store in boot-creator while in recovery mode.
IF "%TITLE%"=="4" TITLE  Export/import all current drivers, combine into a driver-pack.
IF "%TITLE%"=="5" TITLE  Generate a base-list (Appx/Comp/Feat/Serv/Task) in image management.
IF "%TITLE%"=="6" TITLE  DISM can thrash disks pretty hard, poor quality drives can freeze up.
IF "%TITLE%"=="7" TITLE  Difference base-lists to compare editions or to match the configuration.
IF "%TITLE%"=="8" TITLE  In Slot-Mode VHDX's named between 0.vhdx and 9.vhdx are detected at boot.
IF "%TITLE%"=="9" TITLE  SetupComplete/RunOnce lists apply to Current-Environment, but are simply delayed.
IF "%TITLE%"=="0" TITLE  Build, administrate and backup your Windows in a native WinPE recovery environment.
IF "%TITLE%"=="" GOTO:TITLECARD
EXIT /B
:PROG_MAIN_HELP
CLS&&CALL:PAD_LINE&&ECHO                              Main Menu Help  &&CALL:PAD_LINE&&ECHO.&&ECHO   (%##%1%#$%)Image Processor      [%#@%Convert/isolate WIM/VHDX images%#$%]&&ECHO   (%##%2%#$%)Image Management     [%#@%Perform image related tasks%#$%]&&ECHO   (%##%3%#$%)Package Creator      [%#@%Create driver/scripted packages%#$%]&&ECHO   (%##%4%#$%)File Management      [%#@%Simple file manager, file-picker%#$%]&&ECHO   (%##%5%#$%)Disk Management      [%#@%Basic disk partitioning%#$%]&&ECHO    *(%##%B%#$%)oot                [%#@%Create bootable deployment environment%#$%]&&ECHO   (%##%6%#$%)Tasks                [%#@%Miscellaneous tasks%#$%]&&ECHO   (%##%.%#$%)Settings             [%#@%Settings backup, etc%#$%]&&ECHO.&&ECHO       *Appears once boot-media is imported via Image Processing&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:DISCLAIMER
CLS&&CALL:PAD_LINE&&ECHO %XLR2%
ECHO    -------------------------- %#$%DISCLAIMER%XLR2% --------------------------
ECHO     IT'S RECOMMENDED TO BACKUP YOUR DATA BEFORE MAKING ANY CHANGES
ECHO    ----------------------------------------------------------------
ECHO       By using this tool: You assume full liability for any loss 
ECHO     that occurs resulting from or relating to the use of this tool.
ECHO.&&CALL:PAD_LINE&&ECHO                           Do You Agree? (%##%Y%#$%/%##%N%#$%)
CALL:PAD_LINE&&SET "PROMPT_SET=ACCEPTX"&&CALL:PROMPT_SET
IF "%ACCEPTX%"=="Y" SET "DISCLAIMER=ACCEPTED"
CALL:PAD_LINE&&ECHO      The [ %##%@%#$% ]\[%##%Current-Environment%#$%] option ^& disk management area
ECHO          are the 'caution zones' and can be avoided if unsure.&&CALL:COLOR_LAY&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:PROMPT_SET_ANY
IF NOT DEFINED PROMPT_SET SET "PROMPT_SET=SELECT"
SET "PROMPT_VAR="&&SET /P "PROMPT_VAR=$>>"
CALL SET "%PROMPT_SET%=%PROMPT_VAR%"&&SET "PROMPT_SET="&&SET "PROMPT_VAR="
EXIT /B
:PROMPT_SET
IF NOT DEFINED PROMPT_SET SET "PROMPT_SET=SELECT"
SET "PROMPT_VAR="&&SET /P "PROMPT_VAR=$>>"&&FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "PROMPT_VAR=%%PROMPT_VAR:%%G=%%G%%")
CALL SET "%PROMPT_SET%=%PROMPT_VAR%"&&SET "PROMPT_SET="&&SET "PROMPT_VAR="
EXIT /B
:MENU_SELECT
SET "SELECT="&&SET /P "SELECT=$>>"&&FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "SELECT=%%SELECT:%%G=%%G%%")
CALL SET "$ELECTMP=%%$ITEM%SELECT%%%"&&IF DEFINED SELECT CALL SET "$ELECT=%SELECT%"
IF DEFINED SELECT IF DEFINED $ELECTMP CALL SET "$ELECT$=%$ELECTMP%"
EXIT /B
:CHAR_CHK
FOR %%a in (CHAR_STR CHAR_CHK) DO (IF NOT DEFINED %%a EXIT /B)
SET "CHAR_FLG="&&FOR /F "DELIMS=" %%$ in ('CMD.EXE /D /U /C ECHO %CHAR_STR%^| FIND /V ""') do (IF "%%$"=="%CHAR_CHK%" SET "CHAR_FLG=1")
EXIT /B
:PAD_PREV
ECHO                Press (%##%Enter%#$%) to return to previous menu
EXIT /B
:PAUSED
SET /P "PAUSED=.                      Press (%##%Enter%#$%) to continue..."
EXIT /B
:TITLE_GNC
TITLE Windows Deployment Image Customization Kit v%$VER_CUR%   (%PROG_FOLDER%)
EXIT /B
:RANDOM
IF NOT DEFINED RND_TYPE SET RND_TYPE=1
CALL:RND%RND_TYPE% >NUL 2>&1
IF NOT DEFINED RND1 GOTO:RANDOM
IF "%RND2%"=="%RND1%" GOTO:RANDOM
SET "RND2=%RND1%"&&CALL SET "%RND_SET%=%RND1%"&&SET "RND_TYPE="&&SET "RND_SET="&&SET "RND1="
EXIT /B
:RND1
FOR /F "TOKENS=1-9 DELIMS=:." %%a in ("%TIME%") DO (FOR /F "DELIMS=" %%G IN ('CMD.EXE /D /U /C CALL ECHO %%d') DO (CALL SET "RND1=%%G"))
EXIT /B
:RND2
SET "RND1=%RANDOM%%RANDOM%"&&SET "RND1=!RND1:~5,5!"&&SET "RND1=!RND1:~1,1!"
EXIT /B
:CLEAN
FOR %%G in (XS HZ REG TMP LST DSK PAK DRVR DISM) DO (IF EXIST "$%%G*" DEL /F "$%%G*">NUL)
IF EXIST "%TEMP%\DISK_TARGET" DEL /Q /F "%TEMP%\DISK_TARGET">NUL 2>&1
IF EXIST "%PROG_SOURCE%\PROJECT_TMP" DEL /F "%PROG_SOURCE%\PROJECT_TMP">NUL
EXIT /B
:CHECK
SET "ERROR="
IF "%SELECT%"=="" SET "ERROR=1"
IF "%SELECT%"==" " SET "ERROR=1"
IF "%SELECT%"=="  " SET "ERROR=1"
IF "%CHECK%"=="NUM" IF "%SELECT%" LSS "0" SET "ERROR=1"
IF "%CHECK%"=="NUM" IF "%SELECT%" GTR "9999999" SET "ERROR=1"
SET "CHECK="
EXIT /B
:SETS_CREATE
(ECHO.WINDICK Configuration File&&ECHO.PAD_TYPE=&&ECHO.COLOR_TXT=&&ECHO.COLOR_ACC=&&ECHO.COLOR_BTN=&&ECHO.COLOR_SIZ=&&ECHO.COLOR_LAY=&&ECHO.COLOR_SEQ=1234567889&&ECHO.ACTIVE_BAY=&&ECHO.BOOT_BAYS=&&ECHO.VHDX_$ETUP=&&ECHO.SOURCE_TYPE=&&ECHO.WIM_SOURCE=&&ECHO.VHDX_SOURCE=&&ECHO.TARGET_TYPE=&&ECHO.WIM_TARGET=&&ECHO.VHDX_TARGET=&&ECHO.WIM_XLVL=&&ECHO.VHDX_XLVL=&&ECHO.VHDX_SIZE=&&ECHO.WIM_INDEX=&&ECHO.PACK_XLVL=&&ECHO.APPLY_COPY=&&ECHO.BRUTE_FORCE=&&ECHO.SAFE_EXCLUDE=&&ECHO.SVC_SKIP=&&ECHO.COMP_SKIP=&&ECHO.SHORTCUTS=&&ECHO.HOTKEY_1=CMD&&ECHO.SHORT_1=START CMD.EXE&&ECHO.HOTKEY_2=NOTE&&ECHO.SHORT_2=START NOTEPAD.EXE&&ECHO.HOTKEY_3=REG&&ECHO.SHORT_3=START REGEDIT.EXE&&ECHO.HOTKEY_4=&&ECHO.SHORT_4=&&ECHO.HOTKEY_5=&&ECHO.SHORT_5=&&ECHO.DISCLAIMER=&&ECHO.$VER_SET=%$VER_CUR%&&ECHO.SETTINGS=LOADED)>"%PROG_SOURCE%\settings.pro"&&CALL:SETS_LOAD>NUL 2>&1
EXIT /B
:SETS_LOAD
COPY /Y "%PROG_SOURCE%\settings.pro" "$ET">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($ET) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
IF EXIST "$ET" DEL /Q /F "$ET">NUL 2>&1
EXIT /B
:SETS_HANDLER
IF NOT EXIST "%PROG_SOURCE%" SET "PROG_SOURCE=%PROG_FOLDER%"
IF NOT EXIST "%PROG_TARGET%" SET "PROG_TARGET=%PROG_FOLDER%"
IF EXIST "%PROG_SOURCE%\settings.pro" IF DEFINED $VER_SET IF "%$VER_SET%" LSS "%$VER_CUR%" DEL /Q /F "%PROG_SOURCE%\settings.pro"
IF NOT EXIST "%PROG_SOURCE%\settings.pro" IF EXIST "%PROG_SOURCE%\windick.cmd" CALL:SETS_CREATE
MOVE /Y "%PROG_SOURCE%\settings.pro" "$ET">NUL&&IF NOT "%SETTINGS%"=="LOADED" FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($ET) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($ET) DO (CALL ECHO %%a=%%%%a%%>>"%PROG_SOURCE%\settings.pro")
IF EXIST "$ET" DEL /Q /F "$ET">NUL 2>&1
FOR %%a in (PACK_XLVL WIM_XLVL) DO (IF NOT DEFINED %%a SET "%%a=FAST")
FOR %%a in (ACTIVE_BAY BOOT_BAYS MAKER_SLOT SHORT_SLOT WIM_XXX PAK_XXX IMAGEPROC_SLOT) DO (IF NOT DEFINED %%a SET "%%a=1")
FOR %%a in (SAFE_EXCLUDE) DO (IF NOT DEFINED %%a SET "%%a=ENABLED")
FOR %%a in (BRUTE_FORCE SHORTCUTS VHDX_XLVL FMGR_DUAL) DO (IF NOT DEFINED %%a SET "%%a=DISABLED")
IF NOT DEFINED SVC_SKIP SET "SVC_SKIP=EDGEUPDATE EDGEUPDATEM WDNISSVC WINDEFEND WMPNETWORKSVC"
IF NOT DEFINED SOURCE_TYPE SET "SOURCE_TYPE=WIM"&&SET "TARGET_TYPE=VHDX"
IF NOT DEFINED NEXT_BOOT SET "NEXT_BOOT=NULL"
IF NOT DEFINED BCD_SYSTEM SET "BCD_SYSTEM=NAME"
IF NOT DEFINED VHDX_SIZE SET "VHDX_SIZE=25600"
IF NOT DEFINED APPLY_COPY SET "APPLY_COPY=ORIG"
:FOLDER_LOCATE
SET "MAKER_FOLDER=%PROG_SOURCE%\Project%MAKER_SLOT%"
IF EXIST "%PROG_SOURCE%\AutoBoot.cmd" (SET "AUTOBOOT=ENABLED") ELSE (SET "AUTOBOOT=DISABLED")
SET "FOLDER_MODE=UNIFIED"&&IF EXIST "%PROG_SOURCE%\IMAGE" IF EXIST "%PROG_SOURCE%\PACK" IF EXIST "%PROG_SOURCE%\CACHE" SET "FOLDER_MODE=ISOLATED"
IF "%FOLDER_MODE%"=="ISOLATED" FOR %%a in (IMAGE PACK CACHE) DO (SET "%%a_FOLDER=%PROG_SOURCE%\%%a")
IF "%FOLDER_MODE%"=="UNIFIED" FOR %%a in (IMAGE PACK CACHE) DO (SET "%%a_FOLDER=%PROG_SOURCE%")
IF NOT DEFINED S1 SET "S1= "&&SET "S2=  "&&SET "S3=   "&&SET "S4=    "&&SET "S5=     "&&SET "S6=      "&&SET "S7=       "&&SET "S8=        "&&SET "S9=         "&&SET "S10=          "
SET "XLR0=[97m"&&SET "XLR1=[31m"&&SET "XLR2=[91m"&&SET "XLR3=[33m"&&SET "XLR4=[93m"&&SET "XLR5=[92m"&&SET "XLR6=[96m"&&SET "XLR7=[94m"&&SET "XLR8=[34m"&&SET "XLR9=[95m"
IF "%PROG_MODE%"=="COMMAND" EXIT /B
FOR %%a in (VHDX_$ETUP VHDX_SOURCE WIM_SOURCE) DO (SET "OBJ_FLD=%IMAGE_FOLDER%"&&CALL SET "OBJ_CHK=%%a"&&CALL:OBJ_CLEAR)
FOR %%a in (VHDX_$ETUP VHDX_SOURCE WIM_SOURCE WIM_TARGET VHDX_TARGET) DO (IF NOT DEFINED %%a SET "%%a=SELECT")
IF "%WIM_SOURCE%"=="SELECT" SET "WIM_DESC=NULL"&&SET "WIM_INDEX=1"
SET "SOURCE_LOCATION="&&FOR %%a in (A B C D E F G H I J K L N O P Q R S T U W Y Z) DO (IF EXIST "%%a:\sources" SET "SOURCE_LOCATION=%%a:\sources")
IF NOT "%PROG_MODE%"=="RAMDISK" IF NOT EXIST "%PROG_SOURCE%\boot.sav" SET "BOOT_IMAGE=NONE"
IF NOT "%PROG_MODE%"=="RAMDISK" IF EXIST "%PROG_SOURCE%\boot.sav" SET "BOOT_IMAGE=%PROG_SOURCE%\boot.sav"
IF EXIST "%TEMP%\$WIM.TMP" DEL /Q /F "\\?\%TEMP%\$WIM.TMP">NUL 2>&1
IF "%PROG_MODE%"=="RAMDISK" SET "BOOT_IMAGE=U:\$.WIM"
EXIT /B
:OBJ_CLEAR
CALL SET "OBJ_CHKX=%%%OBJ_CHK%%%"
IF NOT EXIST "%OBJ_FLD%\%OBJ_CHKX%" CALL SET "%OBJ_CHK%=SELECT"
EXIT /B
:FOLDER_MODE
CALL:PAD_LINE&&ECHO.       The folder structure will be regenerated. If a file is 
ECHO.     open/mounted and cannot be moved it's possible to lose data.&&CALL:PAD_LINE
ECHO.                         Press (%##%X%#$%) to proceed&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT "%SELECT%"=="X" EXIT /B
IF "%FOLDER_MODE%"=="UNIFIED" SET "FOLDER_MODE=ISOLATED"&&GOTO:FOLDER_ISOLATED
IF "%FOLDER_MODE%"=="ISOLATED" SET "FOLDER_MODE=UNIFIED"&&GOTO:FOLDER_UNIFIED
:FOLDER_UNIFIED
FOR %%a in (IMAGE PACK CACHE) DO (IF EXIST "%PROG_SOURCE%\%%a" MOVE /Y "%PROG_SOURCE%\%%a\*.*" "%PROG_SOURCE%">NUL 2>&1)
FOR %%a in (IMAGE PACK CACHE) DO (IF EXIST "%PROG_SOURCE%\%%a" XCOPY /S /C /Y "%PROG_SOURCE%\%%a" "%PROG_SOURCE%">NUL 2>&1)
FOR %%a in (IMAGE PACK CACHE) DO (IF EXIST "%PROG_SOURCE%\%%a" RD /Q /S "\\?\%PROG_SOURCE%\%%a">NUL 2>&1)
EXIT /B
:FOLDER_ISOLATED
FOR %%a in (IMAGE PACK CACHE) DO (IF NOT EXIST "%PROG_SOURCE%\%%a" MD "%PROG_SOURCE%\%%a">NUL 2>&1)
FOR %%a in (APPX PKG PKX CAB MSU) DO (IF EXIST "%PROG_SOURCE%\*.%%a" MOVE /Y "%PROG_SOURCE%\*.%%a" "%PROG_SOURCE%\PACK">NUL 2>&1)
FOR %%a in (ISO VHDX WIM) DO (IF EXIST "%PROG_SOURCE%\*.%%a" MOVE /Y "%PROG_SOURCE%\*.%%a" "%PROG_SOURCE%\IMAGE">NUL 2>&1)
FOR %%a in (SBK LST MST) DO (IF EXIST "%PROG_SOURCE%\*.%%a" MOVE /Y "%PROG_SOURCE%\*.%%a" "%PROG_SOURCE%\CACHE">NUL 2>&1)
EXIT /B
:FILE_PICK
IF NOT DEFINED PICK GOTO:PICK_ERROR
CLS&&CALL:PAD_LINE&&ECHO                              File Picker&&CALL:PAD_LINE
ECHO   AVAILABLE %PICK%'S:&&IF "%PICK%"=="LST" SET "NOECHO1=1"&&ECHO.&&ECHO  [ %##%0%#$% ]\[%##%Create New List%#$%]
SET "NLIST=%PICK%"&&CALL:FILE_LIST&&CALL:PAD_LINE&&ECHO                              Select a (%##%#%#$%)&&CALL:PAD_LINE&&CALL:PAD_PREV
FOR %%a in (ERROR SELECT LIST_NAME $MAKE $PICK $ELECT $ELECT$) DO (SET "%%a=")
SET /P "SELECT=$>>"&&FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "SELECT=%%SELECT:%%G=%%G%%")
IF "%SELECT%"=="@" IF "%PICK%"=="VHDX" SET "LIVE_APPLY=1"&&GOTO:PICK_ERROR
IF "%SELECT%"=="0" IF NOT "%PICK%"=="LST" SET "ERROR=1"
IF "%SELECT%" GTR "9999999" SET "ERROR=1"
IF "%SELECT%" LSS "0" SET "ERROR=1"
IF DEFINED ERROR GOTO:PICK_ERROR
IF "%SELECT%"=="0" IF "%PICK%"=="LST" SET "$MAKE=1"
CALL SET "$ELECT=%SELECT%"&&CALL SET "$ELECT$=%%$ITEM%SELECT%%%"
IF NOT "%SELECT%"=="0" IF NOT DEFINED $ELECT$ SET "ERROR=1"&&GOTO:PICK_ERROR
SET "$FOLD="&&FOR %%a in (ISO VHDX WIM) DO (IF "%PICK%"=="%%a" SET "$FOLD=%IMAGE_FOLDER%")
FOR %%a in (APPX PKG PKX CAB MSU) DO (IF "%PICK%"=="%%a" SET "$FOLD=%PACK_FOLDER%")
FOR %%a in (SBK LST MST) DO (IF "%PICK%"=="%%a" SET "$FOLD=%CACHE_FOLDER%")
IF "%PICK%"=="BOOT" SET "$FOLD=%PROG_SOURCE%"
IF "%PICK%"=="FMGS" SET "$FOLD=%FMGR_SOURCE%"
IF NOT DEFINED $FOLD SET "ERROR=1"&&GOTO:PICK_ERROR
IF NOT EXIST "%$FOLD%\%$ELECT$%" SET "ERROR=1"&&GOTO:PICK_ERROR
IF DEFINED $MAKE CALL:PAD_LINE&&ECHO                           Name of the List?&&CALL:PAD_LINE
IF DEFINED $MAKE SET /P "LIST_NAME=$>>"
IF DEFINED $MAKE IF NOT DEFINED LIST_NAME SET "ERROR=1"&&GOTO:PICK_ERROR
IF DEFINED $MAKE SET "$ELECT$=%LIST_NAME%.LST"&&ECHO EXEC-LIST>"%$FOLD%\%LIST_NAME%.lst"
IF EXIST "%$FOLD%\%$ELECT$%" SET "$PICK=%$FOLD%\%$ELECT$%"
SET "$HEAD="&&FOR %%a in (LST MST) DO (IF "%PICK%"=="%%a" SET /P $HEAD=<"%$PICK%")
IF "%PICK%"=="LST" IF NOT "%$HEAD%"=="EXEC-LIST" SET "ERROR=1"
IF "%PICK%"=="MST" IF NOT "%$HEAD%"=="BASE-LIST" SET "ERROR=1"
IF DEFINED ERROR CALL:PAD_LINE&&ECHO                       Bad file-header, check file&&CALL:PAD_LINE&&CALL:PAUSED
:PICK_ERROR
SET "PICK="&&IF DEFINED ERROR SET "$PICK="
EXIT /B
:FILE_LIST
FOR %%a in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30) DO (IF DEFINED $ITEM%%a SET "$ITEM%%a=")
IF NOT DEFINED BLIST IF NOT DEFINED NLIST GOTO:FILE_ERROR
IF DEFINED BLIST SET "$MENU=BAS"&&SET "EXT=%BLIST%"
IF DEFINED NLIST SET "$MENU=NUM"&&SET "EXT=%NLIST%"
SET "$FOLD="&&FOR %%a in (ISO VHDX WIM) DO (IF "%EXT%"=="%%a" SET "$FOLD=%IMAGE_FOLDER%\*.%EXT%")
FOR %%a in (APPX PKG PKX CAB MSU) DO (IF "%EXT%"=="%%a" SET "$FOLD=%PACK_FOLDER%\*.%EXT%")
FOR %%a in (SBK LST MST) DO (IF "%EXT%"=="%%a" SET "$FOLD=%CACHE_FOLDER%\*.%EXT%")
IF "%EXT%"=="BOOT" SET "$FOLD=%PROG_SOURCE%\*.VHDX"
IF "%EXT%"=="FMGS" SET "$FOLD=%FMGR_SOURCE%\*.*"
IF "%EXT%"=="FMGT" SET "$FOLD=%FMGR_TARGET%\*.*"
IF "%EXT%"=="MAK" SET "$FOLD=%MAKER_FOLDER%\*.*"
IF "%EXT%"=="SRC" SET "$FOLD=%PROG_SOURCE%\*.*"
IF NOT DEFINED $FOLD GOTO:FILE_ERROR
IF NOT DEFINED CRICKETS SET "CRICKETS=EMPTY.."
IF NOT DEFINED NOECHO1 IF NOT DEFINED MENU_INSERTA ECHO.
IF DEFINED MENU_INSERTA ECHO.&&ECHO.%MENU_INSERTA%
IF NOT EXIST "%$FOLD%" ECHO  [%#@%%CRICKETS%%#$%]
IF EXIST "%$FOLD%" SET "$XNT="&&DIR "%$FOLD%" /A: /B /O:GN>$HZ&&FOR /F "TOKENS=*" %%a in ($HZ) DO (IF NOT "%%a"=="$HZ" CALL SET /A "$XNT+=1"&&CALL SET "$CLM$=%%a"&&CALL:FILE_LISTX)
IF NOT DEFINED NOECHO2 ECHO.
IF EXIST "$HZ" DEL /F "$HZ">NUL 2>&1
:FILE_ERROR
FOR %%a in (EXT BLIST NLIST CRICKETS NOECHO1 NOECHO2 MENU_INSERTA $MENU $FOLD) DO (SET "%%a=")
EXIT /B
:FILE_LISTX
CALL SET "$ITEM%$XNT%=%$CLM$%"
IF "%$MENU%"=="NUM" ECHO  [ %##%%$XNT%%#$% ]\[%#@%%$CLM$%%#$%]
IF "%$MENU%"=="BAS" ECHO  [%#@%%EXT%%#$%]\[%#@%%$CLM$%%#$%]
EXIT /B
:LIST_FILE
SET "ERROR="&&FOR %%a in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30) DO (IF DEFINED $ITEM%%a SET "$ITEM%%a=")
IF NOT DEFINED BLIST IF NOT DEFINED NLIST GOTO:LIST_ERROR
IF NOT EXIST "%$LIST%" GOTO:LIST_ERROR
IF DEFINED BLIST SET "$MENU=BAS"&&SET "EXT=%BLIST%"
IF DEFINED NLIST SET "$MENU=NUM"&&SET "EXT=%NLIST%"
SET "$HEAD="&&FOR %%a in (LST MST) DO (IF "%EXT%"=="%%a" SET /P $HEAD=<"%$LIST%")
IF "%EXT%"=="LST" IF NOT "%$HEAD%"=="EXEC-LIST" SET "ERROR=1"
IF "%EXT%"=="MST" IF NOT "%$HEAD%"=="BASE-LIST" SET "ERROR=1"
IF DEFINED ERROR CALL:PAD_LINE&&ECHO                       Bad file-header, check file&&CALL:PAD_LINE&&CALL:PAUSED&&GOTO:LIST_ERROR
COPY /Y "%$LIST%" "$HZ">NUL
IF NOT DEFINED NOECHO1 ECHO.
IF "%EXT%"=="MST" SET "$XNT="&&FOR /F "TOKENS=1-9 SKIP=1 DELIMS=[]" %%1 in ($HZ) DO (IF NOT "%%1"=="" CALL SET "$CLM1=%%1"&&CALL SET "$CLM2=%%2"&&CALL SET "$CLM3=%%3"&&CALL:LIST_FILEX)
IF NOT DEFINED NOECHO2 ECHO.
IF EXIST "$HZ" DEL /F "$HZ">NUL 2>&1
:LIST_ERROR
FOR %%a in (EXT BLIST NLIST ONLY1 ONLY2 ONLY3 $MENU $LIST $HEAD) DO (SET "%%a=")
EXIT /B
:LIST_FILEX
IF DEFINED ONLY1 IF NOT "%$CLM1%"=="%ONLY1%" EXIT /B
CALL SET /A "$XNT+=1"
CALL SET "$ITEM%$XNT%=[%$CLM1%][%$CLM2%][%$CLM3%]"
IF "%$MENU%"=="NUM" ECHO  [ %##%%$XNT%%#$% ]\[%#@%%$CLM1%%#$%][%#@%%$CLM2%%#$%]
IF "%$MENU%"=="BAS" ECHO  [%#@%%$CLM1%%#$%]\[%#@%%$CLM2%%#$%]
EXIT /B
REM SETTINGS_SETTINGS_SETTINGS_SETTINGS_SETTINGS_SETTINGS_SETTINGS_SETTINGS
:SETTINGS_START
REM SETTINGS_SETTINGS_SETTINGS_SETTINGS_SETTINGS_SETTINGS_SETTINGS_SETTINGS 
CLS&&CALL:SETS_HANDLER&&CALL:COLOR_LAY&&CALL:PAD_LINE&&ECHO                         Settings Configuration&&CALL:PAD_LINE&&ECHO.
ECHO  (%##%1%#$%)Padding Style    [%#@%%PAD_TYPE%%#$%]&&ECHO  (%##%2%#$%)Color Text       [%#@%%COLOR_TXT%%#$%]&&ECHO  (%##%3%#$%)Color Accent     [%#@%%COLOR_ACC%%#$%]
ECHO  (%##%4%#$%)Color Button     [%#@%%COLOR_BTN%%#$%]&&ECHO  (%##%5%#$%)Color Size       [%#@%%COLOR_SIZ%%#$%]&&ECHO  (%##%6%#$%)Color Layout     [%#@%%COLOR_LAY%%#$%]
ECHO  (%##%7%#$%)Color Sequence   [%#@%%COLOR_SEQ%%#$%](%##%-%#$%)&&ECHO  (%##%S%#$%)afe Exclude      [%#@%%SAFE_EXCLUDE%%#$%]
ECHO  (%##%B%#$%)rute TSK/SVC     [%#@%%BRUTE_FORCE%%#$%]&&ECHO  (%##%F%#$%)older Layout     [%#@%%FOLDER_MODE%%#$%]
IF "%SHORTCUTS%"=="DISABLED" ECHO  (%##%M%#$%)enu Shortcuts    [%#@%%SHORTCUTS%%#$%]
IF "%AUTOBOOT%"=="DISABLED" ECHO  (%##%$%#$%)AutoBoot         [%#@%%AUTOBOOT%%#$%]
ECHO.&&CALL:PAD_LINE&&ECHO  [%#@%Settings%#$%]  (%##%C%#$%)reate (%##%R%#$%)estore (%##%#%#$%)Clear Settings (%##%@%#$%)Clear Shortcuts&&CALL:PAD_LINE
IF "%SHORTCUTS%"=="ENABLED" CALL ECHO  [%#@%Shortcut%#$%] (%##%M%#$%)Disable (%##%X%#$%)Slot[%#@%%SHORT_SLOT%%#$%] (%##%A%#$%)ssign [%#@%%%SHORT_%SHORT_SLOT%%%%#$%] (%##%H%#$%)otKey [%#@%%%HOTKEY_%SHORT_SLOT%%%%#$%]&&CALL:PAD_LINE
IF "%AUTOBOOT%"=="ENABLED" ECHO  [%#@%AutoBoot%#$%] (%##%$%#$%)Delete AutoBoot.cmd (%##%V%#$%)iew (%##%*I%#$%)nstall SVC(%##%*R%#$%)emove SVC&&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:PROG_MAIN
IF "%SELECT%"=="-" SET "COLOR_SEQ="&&SET "SELECT="
IF "%SELECT%"=="#" CALL:SETS_CREATE&&SET "SELECT="
IF "%SELECT%"=="F" CALL:FOLDER_MODE&&SET "SELECT="
IF "%SELECT%"=="C" CALL:CREATE_PRO&&SET "SELECT="
IF "%SELECT%"=="V" CALL:AUTOBOOT_VIEW&&SET "SELECT="
IF "%SELECT%"=="5" IF "%COLOR_SIZ%"=="LARGE" SET "COLOR_SIZ=SMALL"&&SET "SELECT="
IF "%SELECT%"=="5" IF "%COLOR_SIZ%"=="SMALL" SET "COLOR_SIZ=LARGE"&&SET "SELECT="
IF "%SELECT%"=="R" SET "PICK=SBK"&&CALL:FILE_PICK&&CALL:RESTORE_PRO&&SET "SELECT="
IF "%SELECT%"=="6" IF "%COLOR_LAY%"=="STATIC" SET "COLOR_LAY=CHESS"&&SET "SELECT="
IF "%SELECT%"=="6" IF "%COLOR_LAY%"=="CHESS" SET "COLOR_LAY=RANDOM"&&SET "SELECT="
IF "%SELECT%"=="6" IF "%COLOR_LAY%"=="RANDOM" SET "COLOR_LAY=STATIC"&&SET "SELECT="
IF "%SELECT%"=="B" IF "%BRUTE_FORCE%"=="ENABLED" SET "BRUTE_FORCE=DISABLED"&&SET "SELECT="
IF "%SELECT%"=="B" IF "%BRUTE_FORCE%"=="DISABLED" SET "BRUTE_FORCE=ENABLED"&&SET "SELECT="
IF "%SELECT%"=="M" IF "%SHORTCUTS%"=="DISABLED" SET "SHORTCUTS=ENABLED"&&SET "SELECT="
IF "%SELECT%"=="M" IF "%SHORTCUTS%"=="ENABLED" SET "SHORTCUTS=DISABLED"&&SET "SELECT="
IF "%SELECT%"=="S" IF "%SAFE_EXCLUDE%"=="DISABLED" SET "SAFE_EXCLUDE=ENABLED"&&SET "SELECT="
IF "%SELECT%"=="S" IF "%SAFE_EXCLUDE%"=="ENABLED" SET "SAFE_EXCLUDE=DISABLED"&&SET "SELECT="
IF "%SELECT%"=="1" SET /A "PAD_TYPE+=1"&&IF "%PAD_TYPE%"=="7" SET "PAD_TYPE=1"&&SET "SELECT="
IF "%SELECT%"=="2" SET /A "COLOR_TXT+=1"&&IF "%COLOR_TXT%"=="9" SET "COLOR_TXT=0"&&SET "SELECT="
IF "%SELECT%"=="3" SET /A "COLOR_ACC+=1"&&IF "%COLOR_ACC%"=="9" SET "COLOR_ACC=0"&&SET "SELECT="
IF "%SELECT%"=="4" SET /A "COLOR_BTN+=1"&&IF "%COLOR_BTN%"=="9" SET "COLOR_BTN=0"&&SET "SELECT="
IF "%SELECT%"=="X" SET /A "SHORT_SLOT+=1"&&IF "%SHORT_SLOT%"=="5" SET "SHORT_SLOT=1"&&SET "SELECT="
IF "%SELECT%"=="*R" SET "BOOTSVC=REMOVE"&&CALL:AUTOBOOT_TOGGLE&&CALL:PAD_LINE&&ECHO AutoBoot service is removed&&CALL:PAD_LINE&&CALL:PAUSED
IF "%SELECT%"=="*I" SET "BOOTSVC=INSTALL"&&CALL:AUTOBOOT_TOGGLE&&CALL:PAD_LINE&&ECHO AutoBoot service is installed&&CALL:PAD_LINE&&CALL:PAUSED
IF "%SELECT%"=="$" IF EXIST "%PROG_SOURCE%\AutoBoot.cmd" MOVE /Y "%PROG_SOURCE%\AutoBoot.cmd" "%PROG_SOURCE%\AutoBoot.txt">NUL&&SET "SELECT="
IF "%SELECT%"=="@" SET "SHORTCUTS=DISABLED"&&FOR %%a in (1 2 3 4 5 6 7 8 9) DO (SET "HOTKEY_%%a="&&SET "SHORT_%%a=")
IF "%SELECT%"=="A" IF "%SHORTCUTS%"=="ENABLED" SET "PROMPT_SET=SHORT_%SHORT_SLOT%"&&CALL:PAD_LINE&&ECHO                              Type Command&&CALL:PAD_LINE&&CALL:PROMPT_SET
IF "%SELECT%"=="H" IF "%SHORTCUTS%"=="ENABLED" CALL:PAD_LINE&&ECHO                          Type 2+ Digit Hotkey&&CALL:PAD_LINE&&SET "PROMPT_SET=HOTKEY_%SHORT_SLOT%"&&CALL:PROMPT_SET
IF "%SELECT%"=="7" CALL:PAD_LINE&&ECHO                         Type 10 Digit Sequence&&CALL:PAD_LINE&&SET "PROMPT_SET=COLOR_XXX"&&CALL:PROMPT_SET
IF "%SELECT%"=="7" SET "XNTX="&&FOR /F "DELIMS=" %%G IN ('CMD.EXE /D /U /C ECHO %COLOR_XXX%^| FIND /V ""') do (CALL SET /A XNTX+=1)
IF "%SELECT%"=="7" IF "%XNTX%"=="10" SET "COLOR_SEQ=%COLOR_XXX%"
IF "%SELECT%"=="$" IF NOT EXIST "%PROG_SOURCE%\AutoBoot.txt" CALL:PAD_LINE&&ECHO      This will generate AutoBoot.cmd. This is an advanced feature.&&SET "AUTOMSG=                 Are your sure? Press (X) to confirm."
IF "%SELECT%"=="$" IF EXIST "%PROG_SOURCE%\AutoBoot.txt" CALL:PAD_LINE&&ECHO              AutoBoot.txt found. Restore or generate new?&&SET "AUTOMSG=                      Restore (%#@%R%#$%/%#@%X%#$%) Generate New."
IF "%SELECT%"=="$" ECHO.%AUTOMSG%&&SET "AUTOMSG="&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=CONFIRM"&&CALL:PROMPT_SET
IF "%SELECT%"=="$" IF "%CONFIRM%"=="R" MOVE /Y "%PROG_SOURCE%\AutoBoot.txt" "%PROG_SOURCE%\AutoBoot.cmd">NUL&&SET "SELECT="
IF "%SELECT%"=="$" IF "%CONFIRM%"=="X" CALL:AUTOBOOT_EXAMPLE>"%PROG_SOURCE%\AutoBoot.cmd"&&START NOTEPAD.EXE "%PROG_SOURCE%\AutoBoot.cmd"
GOTO:SETTINGS_START
:AUTOBOOT_VIEW
IF NOT EXIST "%PROG_SOURCE%\AutoBoot.cmd" EXIT /B
START NOTEPAD.EXE "%PROG_SOURCE%\AutoBoot.cmd"
EXIT /B
:AUTOBOOT_TOGGLE
CALL:BOOT_QUERY
IF NOT DEFINED BOOT_OK EXIT /B
IF "%BOOTSVC%"=="INSTALL" SET "BOOTSVC="&&SC CREATE AutoBoot binpath="%WinDir%\SYSTEM32\CMD.EXE /C BCDEDIT.EXE /displayorder %GUID_TMP% /addfirst" start=auto>NUL 2>&1
IF "%BOOTSVC%"=="REMOVE" SET "BOOTSVC="&&SC DELETE AutoBoot>NUL 2>&1
EXIT /B
:RESTORE_PRO
IF NOT DEFINED $PICK EXIT /B
DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%$PICK%" /INDEX:1 /APPLYDIR:"%PROG_SOURCE%">NUL 2>&1
CALL:SETS_LOAD>NUL 2>&1
EXIT /B
:CREATE_PRO
CALL:PAD_LINE&&ECHO                            New Profile-Name?&&CALL:PAD_LINE&&SET "PROMPT_SET=NEW_NAME"&&CALL:PROMPT_SET
IF NOT DEFINED NEW_NAME EXIT /B
CALL:SETS_HANDLER>NUL 2>&1
RD /Q /S "\\?\%PROG_SOURCE%\SETTINGS_SAVE">NUL 2>&1
MD "%PROG_SOURCE%\SETTINGS_SAVE\CACHE">NUL 2>&1
FOR %%a in (settings.pro AutoBoot.cmd AutoBoot.txt) DO (IF EXIST "%PROG_SOURCE%\%%a" COPY /Y "%PROG_SOURCE%\%%a" "%PROG_SOURCE%\SETTINGS_SAVE">NUL 2>&1)
DISM /ENGLISH /CAPTURE-IMAGE /CAPTUREDIR:"%PROG_SOURCE%\SETTINGS_SAVE" /IMAGEFILE:"%CACHE_FOLDER%\%NEW_NAME%.sbk" /COMPRESS:FAST /NAME:"%NEW_NAME%" /CheckIntegrity /Verify>NUL 2>&1
RD /Q /S "\\?\%PROG_SOURCE%\SETTINGS_SAVE">NUL 2>&1
EXIT /B
:AUTOBOOT_EXAMPLE
ECHO.::=======================================================================
ECHO.::    Script cannot have an EXIT otherwise it goes into the main menu. 
ECHO.::Autoboot service must be installed within host OS to switch upon boot.
ECHO.::=======================================================================
ECHO.::      ~ Example of a VHDX backup/Restore - Home Folder = S:\$ ~
ECHO.REM windick.cmd -diskmgr -mount -diskid 12345678-1234-1234-1234-123456781234 -part 1 -letter z
ECHO.REM copy /y s:\$\active.vhdx z:\Backups\last_power_off.vhdx
ECHO.REM windick.cmd -diskmgr -unmount -letter z
ECHO.REM windick.cmd -imageproc -wim 22h2_ready2go.wim -index 1 -vhdx active.vhdx -size 25600
ECHO.REM del S:\$\active.vhdx
ECHO.REM move /y s:\$\image\active.vhdx s:\$
ECHO.::==========================START OF AUTOBOOT============================
ECHO.ECHO - AutoBoot - Example - Your Script - Goes here -
ECHO.PAUSE
ECHO.::===========================END OF AUTOBOOT=============================
ECHO.::=======================================================================
EXIT /B
:AUTOBOOT_COUNT
IF EXIST "S:\$\ERR.TXT" SET "AUTOBOOT=DISABLED"&&DEL "S:\$\ERR.TXT"&&MOVE /Y "S:\$\AutoBoot.cmd" "S:\$\AutoBoot.txt">NUL&EXIT /B
ECHO;@ECHO OFF>X:\COUNT.CMD
ECHO;FOR %%%%a in (20 19 18 17 16 15 14 13 13 12 11 10 9 8 7 6 5 4 3 2 1 0) DO (CLS^&^&ECHO AutoBoot starts in %%%%a seconds...^&^&PING -n 2 127.0.0.1^>NUL)>>X:\COUNT.CMD
ECHO;CD /D S:\$>>X:\COUNT.CMD
ECHO;CALL S:\$\AutoBoot.cmd>>X:\COUNT.CMD
ECHO;ECHO AutoBoot Finished. Restarting in 5 Seconds>>X:\COUNT.CMD
ECHO;PING -n 6 127.0.0.1^>NUL >>X:\COUNT.CMD
ECHO;DEL /Q /F S:\$\ERR.TXT>>X:\COUNT.CMD
ECHO;EXIT^&^&EXIT>>X:\COUNT.CMD	
CALL:PAD_LINE&&ECHO              To cancel AutoBoot close countdown window.
ECHO    Press (N) to return to recovery. Press (Y) for command prompt.&&CALL:PAD_LINE
ECHO AUTOBOOT>S:\$\ERR.TXT
START /WAIT X:\COUNT.CMD
IF EXIST "S:\$\ERR.TXT" SET "AUTOBOOT=DISABLED"&&DEL "S:\$\ERR.TXT"&&MOVE /Y "S:\$\AutoBoot.cmd" "S:\$\AutoBoot.txt">NUL
EXIT /B
:SHORT_RUN
SET "SHORT_RUN="&&CALL:CHECK
IF DEFINED ERROR EXIT /B
IF "%SELECT%"=="%HOTKEY_1%" SET "SHORT_RUN=%SHORT_1%"
IF "%SELECT%"=="%HOTKEY_2%" SET "SHORT_RUN=%SHORT_2%"
IF "%SELECT%"=="%HOTKEY_3%" SET "SHORT_RUN=%SHORT_3%"
IF "%SELECT%"=="%HOTKEY_4%" SET "SHORT_RUN=%SHORT_4%"
IF "%SELECT%"=="%HOTKEY_5%" SET "SHORT_RUN=%SHORT_5%"
IF NOT DEFINED SHORT_RUN EXIT /B
ECHO;@ECHO OFF >OUTER.BAT
ECHO;SET CRASHED=>>OUTER.BAT
ECHO;CMD /C INNER.BAT >>OUTER.BAT
ECHO;IF EXIST INNER.BAT SET CRASHED=1 >>OUTER.BAT
ECHO;IF EXIST INNER.BAT WINDICK.CMD >>OUTER.BAT
ECHO;@ECHO OFF >INNER.BAT
ECHO;%SHORT_RUN% >>INNER.BAT
ECHO;DEL /Q /F %%0 >>INNER.BAT
CMD /C OUTER.BAT>NUL 2>&1
DEL /Q /F OUTER.BAT>NUL 2>&1
EXIT /B
REM IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_
:IMAGEPROC_START
REM IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_
@ECHO OFF&&CLS&&CALL:SETS_HANDLER&&CALL:COLOR_LAY&&CALL:TITLE_GNC&&CALL:CLEAN&&CALL:PAD_LINE&&ECHO                            Image Processing&&CALL:PAD_LINE
IF DEFINED SOURCE_LOCATION ECHO  [%#@%Windows Installation Media Detected%#$%]  (%##%+%#$%)Import WIM  (%##%-%#$%)Import Boot&&CALL:PAD_LINE
IF NOT DEFINED SOURCE_LOCATION IF NOT EXIST "%IMAGE_FOLDER%\*.WIM" ECHO    Insert a Windows Disc/ISO/USB to Import Installation/Boot Media&&CALL:PAD_LINE
IF "%SOURCE_TYPE%"=="WIM" IF NOT "%WIM_SOURCE%"=="SELECT" CALL:WIM_INDEX_QUERY
IF NOT DEFINED WIM_DESC SET "WIM_DESC=NULL"&&SET "WIM_INDEX=1"
IF "%SOURCE_TYPE%"=="WIM" IF "%TARGET_TYPE%"=="VHDX" ECHO                              WIM (%##%X%#$%) VHDX&&CALL:PAD_LINE
IF "%SOURCE_TYPE%"=="WIM" IF "%TARGET_TYPE%"=="WIM" ECHO                              WIM (%##%X%#$%) WIM&&CALL:PAD_LINE
IF "%SOURCE_TYPE%"=="VHDX" IF "%TARGET_TYPE%"=="WIM" ECHO                             VHDX (%##%X%#$%) WIM&&CALL:PAD_LINE
IF "%SOURCE_TYPE%"=="VHDX" ECHO   AVAILABLE VHDX'S:&&SET "BLIST=VHDX"&&CALL:FILE_LIST&&CALL:PAD_LINE&&ECHO. (%##%S%#$%)ource[%#@%VHDX%#$%] [%#@%%VHDX_SOURCE%%#$%]&&CALL:PAD_LINE
IF "%SOURCE_TYPE%"=="WIM" ECHO   AVAILABLE WIM'S:&&SET "BLIST=WIM"&&CALL:FILE_LIST&&CALL:PAD_LINE&&ECHO. (%##%S%#$%)ource[%#@%WIM%#$%] [%#@%%WIM_SOURCE%%#$%] (%##%I%#$%)ndex[%#@%%WIM_INDEX%%#$%] [Edition[%#@%%WIM_DESC%%#$%]&&CALL:PAD_LINE
IF "%TARGET_TYPE%"=="VHDX" ECHO   EXISTING VHDX'S:&&SET "BLIST=VHDX"&&CALL:FILE_LIST&&CALL:PAD_LINE&&ECHO. (%##%T%#$%)arget[%#@%VHDX%#$%] [%#@%%VHDX_TARGET%%#$%]      (%##%G%#$%)o^^!  (%##%V%#$%)Size[%#@%%VHDX_SIZE%MB%#$%] (%##%Z%#$%)[%#@%%VHDX_XLVL%%#$%]&&CALL:PAD_LINE
IF "%TARGET_TYPE%"=="WIM" ECHO   EXISTING WIM'S:&&SET "BLIST=WIM"&&CALL:FILE_LIST&&CALL:PAD_LINE&&ECHO. (%##%T%#$%)arget[%#@%WIM%#$%] [%#@%%WIM_TARGET%%#$%]      (%##%G%#$%)o^^!     (%##%Z%#$%)[X-Lvl[%#@%%WIM_XLVL%%#$%]&&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:PROG_MAIN
IF "%SELECT%"=="X" CALL:IMAGEPROC_SLOT
IF "%SELECT%"=="T" CALL:IMAGEPROC_PROMPT
IF "%SELECT%"=="Z" CALL:IMAGEPROC_XLVL
IF "%SELECT%"=="S" CALL:IMAGEPROC_PICK&&SET "SELECT="
IF "%SELECT%"=="V" CALL:IMAGEPROC_VSIZE&&SET "SELECT="
IF "%SELECT%"=="I" IF "%SOURCE_TYPE%"=="WIM" IF NOT "%WIM_SOURCE%"=="SELECT" CALL:WIM_INDEX
IF "%SELECT%"=="G" SET "CAME_FROM=IMAGE"&&CALL:IMAGEPROC&&CALL:PAUSED
IF "%SELECT%"=="+" IF DEFINED SOURCE_LOCATION CALL:SOURCE_IMPORT&&SET "SELECT="
IF "%SELECT%"=="-" IF DEFINED SOURCE_LOCATION CALL:BOOT_IMPORT&&SET "SELECT="
GOTO:IMAGEPROC_START
:IMAGEPROC_XLVL
IF "%TARGET_TYPE%"=="WIM" CALL:WIM_XLVL
IF "%TARGET_TYPE%"=="VHDX" IF "%VHDX_XLVL%"=="COMPACT" SET "VHDX_XLVL=DISABLED"&&EXIT /B
IF "%TARGET_TYPE%"=="VHDX" IF "%VHDX_XLVL%"=="DISABLED" SET "VHDX_XLVL=COMPACT"&&EXIT /B
EXIT /B
:IMAGEPROC_VSIZE
SET "PROMPT_SET=VHDX_SIZE"&&CALL:PAD_LINE&&ECHO                               VHDX size?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:PROMPT_SET
SET "SELECT=%VHDX_SIZE%"&&SET "CHECK=NUM"&&CALL:CHECK
IF DEFINED ERROR SET "VHDX_SIZE=25600"
EXIT /B
:IMAGEPROC_PROMPT
IF "%TARGET_TYPE%"=="WIM" CALL:PAD_LINE&&ECHO                              Name of WIM?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL SET "PROMPT_SET=WIM_TARGET"&&CALL:PROMPT_SET_ANY
IF "%TARGET_TYPE%"=="WIM" IF DEFINED WIM_TARGET CALL SET "WIM_TARGET=%WIM_TARGET%.wim"
IF "%TARGET_TYPE%"=="VHDX" CALL:PAD_LINE&&ECHO                             Name of VHDX?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL SET "PROMPT_SET=VHDX_TARGET"&&CALL:PROMPT_SET_ANY
IF "%TARGET_TYPE%"=="VHDX" IF DEFINED VHDX_TARGET CALL SET "VHDX_TARGET=%VHDX_TARGET%.vhdx"
EXIT /B
:IMAGEPROC_PICK
IF "%SOURCE_TYPE%"=="WIM" SET "PICK=WIM"&&CALL:FILE_PICK
IF "%SOURCE_TYPE%"=="VHDX" SET "PICK=VHDX"&&CALL:FILE_PICK
CALL SET "%SOURCE_TYPE%_SOURCE=%$ELECT$%"
EXIT /B
:IMAGEPROC_SLOT
SET /A "IMAGEPROC_SLOT+=1"
IF "%IMAGEPROC_SLOT%" GTR "3" SET "IMAGEPROC_SLOT=1"
IF "%IMAGEPROC_SLOT%"=="1" SET "SOURCE_TYPE=WIM"&&SET "TARGET_TYPE=VHDX"
IF "%IMAGEPROC_SLOT%"=="2" SET "SOURCE_TYPE=VHDX"&&SET "TARGET_TYPE=WIM"
IF "%IMAGEPROC_SLOT%"=="3" SET "SOURCE_TYPE=WIM"&&SET "TARGET_TYPE=WIM"
EXIT /B
:WIM_XLVL
SET /A "WIM_XXX+=1"
IF "%WIM_XXX%" GTR "3" SET "WIM_XXX=1"
IF "%WIM_XXX%"=="1" SET "WIM_XLVL=FAST"
IF "%WIM_XXX%"=="2" SET "WIM_XLVL=MAX"
IF "%WIM_XXX%"=="3" SET "WIM_XLVL=NONE"
EXIT /B
:WIM_INDEX
SET /A "WIM_INDEX+=1"
IF "%WIM_INDEX%"=="20" SET "WIM_INDEX=1"
CALL:WIM_INDEX_QUERY
EXIT /B
:WIM_INDEX_QUERY
SET "WIM_DESC="&&DISM /ENGLISH /Get-ImageInfo /ImageFile:"%IMAGE_FOLDER%\%WIM_SOURCE%" /Index:%WIM_INDEX% >"$DISM"
FOR /F "TOKENS=1-5 DELIMS=<> " %%a in ($DISM) DO (IF "%%a"=="Edition" SET "WIM_DESC=%%c")
FOR /F "TOKENS=1-5 DELIMS=<> " %%a in ($DISM) DO (IF "%%a"=="Languages" IF NOT "%%c"=="" SET "WIM_SOURCE=SELECT")
IF NOT DEFINED WIM_DESC SET "WIM_DESC=NULL"&&SET "WIM_INDEX=1"
IF EXIST "$DISM" DEL /Q /F "$DISM">NUL
EXIT /B
REM IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_
:IMAGEPROC
REM IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_IMAGEPROC_
CALL:PAD_LINE&&ECHO                         Image Processing Start&&CALL:PAD_LINE&&SET "ERR_MSG="&&SET "APPLYDIR_MASTER=V:"&&SET "CAPTUREDIR_MASTER=V:"&&SET "VHDX_MB=%VHDX_SIZE%"
IF "%TARGET_TYPE%"=="VHDX" IF EXIST "%IMAGE_FOLDER%\%VHDX_TARGET%" SET "ERR_MSG=%##%Target %VHDX_TARGET% exists. Try another name or rename the existing file.%#$%"&&GOTO:IMAGEPROC_CLEANUP
IF "%TARGET_TYPE%"=="WIM" IF EXIST "%IMAGE_FOLDER%\%WIM_TARGET%" SET "ERR_MSG=%##%Target %WIM_TARGET% exists. Try another name or rename the existing file.%#$%"&&GOTO:IMAGEPROC_CLEANUP
IF "%SOURCE_TYPE%"=="VHDX" IF "%VHDX_SOURCE%"=="SELECT" SET "ERR_MSG=%##%Source %SOURCE_TYPE% not set.%#$%"&&GOTO:IMAGEPROC_CLEANUP
IF "%TARGET_TYPE%"=="VHDX" IF "%VHDX_TARGET%"=="SELECT" SET "ERR_MSG=%##%Target %TARGET_TYPE% not set.%#$%"&&GOTO:IMAGEPROC_CLEANUP
IF "%SOURCE_TYPE%"=="WIM" IF "%WIM_SOURCE%"=="SELECT" SET "ERR_MSG=%##%Source %SOURCE_TYPE% not set.%#$%"&&GOTO:IMAGEPROC_CLEANUP
IF "%TARGET_TYPE%"=="WIM" IF "%WIM_TARGET%"=="SELECT" SET "ERR_MSG=%##%Target %TARGET_TYPE% not set.%#$%"&&GOTO:IMAGEPROC_CLEANUP
IF EXIST "V:\" SET "ERR_MSG=%##%Drive letter V:\ can NOT be in use. Unmount the Vdisk in use.%#$%"&&GOTO:IMAGEPROC_CLEANUP
IF NOT DEFINED WIM_INDEX SET "WIM_INDEX=1"
IF NOT DEFINED WIM_XLVL SET "WIM_XLVL=FAST"
IF NOT "%VHDX_XLVL%"=="COMPACT" SET "COMPACTX="
IF "%VHDX_XLVL%"=="COMPACT" SET "COMPACTX= /COMPACT"
CALL:VDISK_DETACH&&CALL:SCRATCH_CREATE
IF "%SOURCE_TYPE%"=="VHDX" SET "VDISK=%IMAGE_FOLDER%\%VHDX_SOURCE%"
IF "%TARGET_TYPE%"=="VHDX" SET "VDISK=%IMAGE_FOLDER%\%VHDX_TARGET%"
IF "%SOURCE_TYPE%"=="WIM" SET "IMAGE_SRC=%IMAGE_FOLDER%\%WIM_SOURCE%"
IF "%TARGET_TYPE%"=="WIM" SET "IMAGE_TGT=%IMAGE_FOLDER%\%WIM_TARGET%"
IF "%SOURCE_TYPE%"=="VHDX" IF "%TARGET_TYPE%"=="WIM" CALL:VDISK_ATTACH
IF "%SOURCE_TYPE%"=="WIM" IF "%TARGET_TYPE%"=="VHDX" CALL:VDISK_CREATE
IF "%SOURCE_TYPE%"=="WIM" IF "%TARGET_TYPE%"=="WIM" SET "VDISK=%SCRATCHDIR%\SCRATCH.VHDX"&&SET "VHDX_MB=20000"&&CALL:VDISK_CREATE
IF NOT EXIST "V:\" SET "ERR_MSG=%##%Virtual Disk Error. If VHDX refuses mounting, reboot and try again.%#$%"&&CALL:VDISK_DETACH&&GOTO:IMAGEPROC_CLEANUP
CALL:TITLECARD&&IF NOT DEFINED WIM_DESC SET "WIM_DESC=WINDICK"
IF "%SOURCE_TYPE%"=="WIM" IF "%TARGET_TYPE%"=="VHDX" DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%IMAGE_SRC%" /INDEX:%WIM_INDEX% /APPLYDIR:"%APPLYDIR_MASTER%"%COMPACTX%
IF "%SOURCE_TYPE%"=="WIM" IF "%TARGET_TYPE%"=="WIM" DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%IMAGE_SRC%" /INDEX:%WIM_INDEX% /APPLYDIR:"%APPLYDIR_MASTER%"
IF "%TARGET_TYPE%"=="WIM" IF NOT EXIST "%APPLYDIR_MASTER%\*" CALL:VDISK_DETACH&&DEL /F /Q "%IMAGE_FOLDER%\%WIM_TARGET%">NUL 2>&1
IF "%TARGET_TYPE%"=="VHDX" IF NOT EXIST "%APPLYDIR_MASTER%\*" CALL:VDISK_DETACH&&DEL /F /Q "%IMAGE_FOLDER%\%VHDX_TARGET%">NUL 2>&1
IF NOT EXIST "%APPLYDIR_MASTER%\*" CALL:PAD_LINE&&SET "ERR_MSG=%##%Source Extraction Error. If source refuses to extract, reboot and try again.%#$%"&&GOTO:IMAGEPROC_CLEANUP
IF "%TARGET_TYPE%"=="WIM" DISM /ENGLISH /CAPTURE-IMAGE /CAPTUREDIR:"%CAPTUREDIR_MASTER%" /IMAGEFILE:"%IMAGE_TGT%" /COMPRESS:%WIM_XLVL% /NAME:%WIM_DESC%
CALL:VDISK_DETACH>NUL 2>&1
:IMAGEPROC_CLEANUP
IF "%CAME_FROM%"=="IMAGE" SET "CAME_FROM="&&ECHO 
IF DEFINED ERR_MSG ECHO  %ERR_MSG%&&ECHO.
CALL:SCRATCH_DELETE&&CALL:PAD_LINE&&ECHO                        Image Processing Complete&&CALL:PAD_LINE
EXIT /B
REM IMAGEMGR_IMAGEMGR_IMAGEMGR_IMAGEMGR_IMAGEMGR_IMAGEMGR_IMAGEMGR_
:IMAGEMGR_START
REM IMAGEMGR_IMAGEMGR_IMAGEMGR_IMAGEMGR_IMAGEMGR_IMAGEMGR_IMAGEMGR_
@ECHO OFF&&CLS&&CALL:SETS_HANDLER&&CALL:COLOR_LAY&&CALL:TITLE_GNC&&CALL:CLEAN&&SET "LIVE_APPLY="&&CALL:PAD_LINE&&ECHO                            Image Management&&CALL:PAD_LINE
ECHO   AVAILABLE VHDX'S:&&SET "BLIST=VHDX"&&CALL:FILE_LIST&&CALL:PAD_LINE
ECHO  [%#@%VHDX%#$%]  (%##%I%#$%)nspect   (%##%D%#$%)ISM   (%##%M%#$%)ount/Unmount   (%##%N%#$%)ew(empty)  (%##%X%#$%)ISO&&CALL:PAD_LINE
ECHO   AVAILABLE ALL-IN-ONE'S:&&SET "BLIST=PKX"&&CALL:FILE_LIST&&CALL:PAD_LINE&&ECHO   AVAILABLE EXEC-LIST'S:&&SET "BLIST=LST"&&CALL:FILE_LIST&&CALL:PAD_LINE
ECHO  [%#@%LIST%#$%]    (%##%C%#$%)reate    (%##%V%#$%)iew    (%##%G%#$%)o^^!          (%##%A%#$%)pply to[%#@%%APPLY_COPY%-VHDX%#$%] &&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:PROG_MAIN
IF "%SELECT%"=="N" CALL:VHDX_NEW&&SET "SELECT="
IF "%SELECT%"=="G" CALL:IMAGEMGR_CHOICE&&SET "SELECT="
IF "%SELECT%"=="I" CALL:IMAGEMGR_INSPECT&&SET "SELECT="
IF "%SELECT%"=="D" CALL:IMAGEMGR_DISM_MENU&&SET "SELECT="
IF "%SELECT%"=="C" CALL:IMAGEMGR_LIST_MAIN&&SET "SELECT="
IF "%SELECT%"=="A" IF "%APPLY_COPY%"=="COPY" SET "APPLY_COPY=ORIG"&&SET "SELECT="
IF "%SELECT%"=="A" IF "%APPLY_COPY%"=="ORIG" SET "APPLY_COPY=COPY"&&SET "SELECT="
IF "%SELECT%"=="V" SET "PICK=LST"&&CALL:FILE_PICK&&CALL:LIST_VIEW&&SET "SELECT="
IF "%SELECT%"=="X" SET "PICK=ISO"&&CALL:FILE_PICK&&CALL:ISO_MOUNT&&SET "SELECT="
IF "%SELECT%"=="M" IF NOT EXIST "V:\" SET "PICK=VHDX"&&CALL:FILE_PICK&&CALL:VHDX_MOUNT&&SET "SELECT="
IF "%SELECT%"=="M" IF EXIST "V:\" CALL:VDISK_BRUTE&&SET "SELECT="
GOTO:IMAGEMGR_START
:IMAGEMGR_CHOICE
CLS&&CALL:PAD_LINE&&ECHO                              Run which type&&CALL:PAD_LINE&&ECHO.&&ECHO  (%##%1%#$%)Exec-List   [%#@%LST%#$%]&&ECHO  (%##%2%#$%)AIO Package [%#@%PKX%#$%]&&ECHO.&&SET "PROMPT_SET=IMAGEMGR_CHOICE"&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:PROMPT_SET
IF NOT "%IMAGEMGR_CHOICE%"=="1" IF NOT "%IMAGEMGR_CHOICE%"=="2" EXIT /B
IF "%IMAGEMGR_CHOICE%"=="1" SET "PICK=LST"&&CALL:FILE_PICK
IF "%IMAGEMGR_CHOICE%"=="2" SET "PICK=PKX"&&CALL:FILE_PICK
IF NOT DEFINED $PICK EXIT /B
IF "%IMAGEMGR_CHOICE%"=="1" SET "$LST1=%$PICK%"
IF "%IMAGEMGR_CHOICE%"=="2" SET "PKX_PACK=%$PICK%"
SET "MENU_INSERTA= [ %##%@%#$% ]\[%##%Current-Environment%#$%]"&&SET "PICK=VHDX"&&CALL:FILE_PICK
IF "%LIVE_APPLY%"=="1" IF NOT DEFINED DISCLAIMER CALL:DISCLAIMER&EXIT /B
IF NOT "%LIVE_APPLY%"=="1" IF NOT DEFINED $PICK EXIT /B
SET "VDISK=%$PICK%"&&IF "%APPLY_COPY%"=="COPY" ECHO.&&ECHO Copying %$PICK%...&&COPY /Y "%$PICK%" "%IMAGE_FOLDER%\Copy_%$ELECT$%"&&SET "VDISK=%IMAGE_FOLDER%\Copy_%$ELECT$%"&&ECHO.&&CALL:PAD_LINE
IF "%IMAGEMGR_CHOICE%"=="1" CALL:IMAGEMGR_RUN_LIST
IF "%IMAGEMGR_CHOICE%"=="2" CALL:AIO_PARSE
EXIT /B
:AIO_PARSE
SET "SCRATCH_AIO=%PROG_SOURCE%\ScratchAIO"&&CALL:AIO_DELETE&&MD "%PROG_SOURCE%\ScratchAIO">NUL 2>&1
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=")
DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%PKX_PACK%" /INDEX:2 /APPLYDIR:"%SCRATCH_AIO%" >NUL 2>&1
COPY /Y "%SCRATCH_AIO%\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
IF NOT "%PackType%"=="AIOPACK" ECHO Error&&CALL:AIO_DELETE&&EXIT /B
SET "$LST1=%PROG_SOURCE%\ScratchAIO\PACKAGE.LST"&&CALL:PAD_LINE&&ECHO Extracting [%#@%%PKX_PACK%%#$%]..
SET "CACHE_FOLDERX=%CACHE_FOLDER%"&&SET "PACK_FOLDERX=%PACK_FOLDER%"&&DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%PKX_PACK%" /INDEX:1 /APPLYDIR:"%SCRATCH_AIO%">NUL 2>&1
SET "CACHE_FOLDER=%SCRATCH_AIO%"&&SET "PACK_FOLDER=%SCRATCH_AIO%"&&CALL:IMAGEMGR_RUN_LIST
SET "CACHE_FOLDER=%CACHE_FOLDERX%"&&SET "PACK_FOLDER=%PACK_FOLDERX%"
SET "CACHE_FOLDERX="&&SET "PACK_FOLDERX="
EXIT /B
:LIST_VIEW
IF NOT DEFINED $PICK EXIT /B
START NOTEPAD "%$PICK%"
EXIT /B
:ISO_MOUNT
IF NOT DEFINED $PICK EXIT /B
"%$PICK%"&&CALL:SETS_HANDLER
EXIT /B
:ISO_UNMOUNT
CALL:PAD_LINE&&ECHO                    Remove which ISO Drive Letter?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL SET "PROMPT_SET=ISO_LETTER"&&CALL:PROMPT_SET
IF NOT DEFINED ISO_LETTER EXIT /B
(ECHO.select VOLUME %ISO_LETTER%&&ECHO.Remove letter=%ISO_LETTER% noerr&&ECHO.Exit)>"$DSK"&&CALL:PAD_LINE&&DISKPART /s "$DSK"&&ECHO Drive letter %ISO_LETTER% removed&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:VHDX_NEW
SET "PROMPT_SET=NEW_NAME"&&CALL:PAD_LINE&&ECHO                             New VHDX name?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:PROMPT_SET_ANY
IF NOT DEFINED NEW_NAME EXIT /B
SET "PROMPT_SET=VHDX_MB"&&CALL:PAD_LINE&&ECHO                               VHDX size?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:PROMPT_SET
IF NOT DEFINED VHDX_MB EXIT /B
SET "VDISK=%IMAGE_FOLDER%\%NEW_NAME%.vhdx"&&SET VHDX_LABEL=%NEW_NAME%
CALL:PAD_LINE&&ECHO  CREATING [%VDISK%]&&CALL:PAD_LINE&&CALL:VDISK_CREATE&&CALL:VDISK_DETACH&&ECHO 
EXIT /B
:VHDX_MOUNT
IF NOT DEFINED $PICK EXIT /B
SET "VDISK=%$PICK%"&&CALL:PAD_LINE&&ECHO  Attaching [%$PICK%]&&CALL:PAD_LINE&&CALL:VDISK_ATTACH
IF NOT EXIST "V:\" ECHO  Error mounting [%$PICK%]&&CALL:PAD_LINE&&CALL:VDISK_DETACH
EXIT /B
:IMAGEMGR_LIST_MAIN
CLS&&CALL:CLEAN&&CALL:PAD_LINE&&ECHO                              List Creator&&CALL:PAD_LINE&&ECHO.&&SET "ERROR="&&SET "LIST_CREATE="&&SET "LIST_ACTN="&&SET "LIST_ITEM="&&SET "NLIST="&&SET "$HEAD="&&SET "EXXT="
ECHO  [ %##%P%#$% ]\[%#@%External Package%#$%]&&ECHO  [ %##%D%#$% ]\[%#@%DISM Operation]%#$%&&ECHO.&&SET "PAD_SIZE=3"&&CALL:PAD_LINE&&ECHO.&&ECHO  [ %##%*%#$% ]\[%#@%Create Base List%#$%]&&ECHO  [ %##%-%#$% ]\[%#@%Difference Base List%#$%]&&ECHO  [ %##%+%#$% ]\[%#@%Combine Exec List%#$%]&&ECHO.&&SET "PAD_SIZE=3"&&CALL:PAD_LINE&&ECHO   AVAILABLE BASE LIST'S:&&SET "NLIST=MST"&&CALL:FILE_LIST&&CALL:PAD_LINE&&ECHO                    Select a (%##%#%#$%) To choose an action&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "$ELECT$="&&CALL:MENU_SELECT
IF "%SELECT%"=="*" SET "LIST_CREATE=BASE-LIST"&&CALL:LIST_BASE_CREATE
IF "%SELECT%"=="+" SET "LIST_CREATE=SANDWICH"&&CALL:LIST_COMBINATOR
IF "%SELECT%"=="-" SET "LIST_CREATE=DIFF-LIST"&&SET "LIST_PASS=1"&&CALL:LIST_DIFFERENCER
IF "%SELECT%"=="D" SET "LIST_CREATE=DISM"&&SET "LIST_ITEM=DISM"&&SET "LIST_ACTN=EXECUTE"&&CALL:LIST_DISM_CREATE
IF "%SELECT%"=="P" CALL:IMAGEMGR_LIST_PACK
IF DEFINED LIST_CREATE EXIT /B
IF NOT DEFINED $ELECT$ EXIT /B
IF "%SELECT%" GEQ "99" EXIT /B
IF NOT "%SELECT%" GEQ "1" EXIT /B
SET /P $HEAD=<"%CACHE_FOLDER%\%$ELECT$%"
IF NOT "%$HEAD%"=="BASE-LIST" CALL:PAD_LINE&&ECHO                       Bad file-header, check file&&CALL:PAD_LINE&&CALL:PAUSED
IF "%$HEAD%"=="BASE-LIST" CALL:LIST_UNIFIED_CREATE
EXIT /B
:IMAGEMGR_LIST_PACK
CLS&&CALL:CLEAN&&CALL:PAD_LINE&&ECHO                              List Creator&&CALL:PAD_LINE&&ECHO.&&ECHO  [ %##%1%#$% ]\[%#@%Package%#$%[APPX]&&ECHO  [ %##%2%#$% ]\[%#@%Package%#$%[CAB]&&ECHO  [ %##%3%#$% ]\[%#@%Package%#$%[MSU]&&ECHO  [ %##%4%#$% ]\[%#@%Package%#$%[PKG]&&ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=SELECTX"&&CALL:PROMPT_SET
IF "%SELECTX%"=="1" SET "LIST_CREATE=APPX"&&SET "LIST_ITEM=EXTPACKAGE"&&SET "LIST_ACTN=INSTALL"&&SET "NLIST=APPX"&&SET "EXXT=APPX"&&CALL:LIST_PACK_CREATE
IF "%SELECTX%"=="2" SET "LIST_CREATE=CAB"&&SET "LIST_ITEM=EXTPACKAGE"&&SET "LIST_ACTN=INSTALL"&&SET "NLIST=CAB"&&SET "EXXT=CAB"&&CALL:LIST_PACK_CREATE
IF "%SELECTX%"=="3" SET "LIST_CREATE=MSU"&&SET "LIST_ITEM=EXTPACKAGE"&&SET "LIST_ACTN=INSTALL"&&SET "NLIST=MSU"&&SET "EXXT=MSU"&&CALL:LIST_PACK_CREATE
IF "%SELECTX%"=="4" SET "LIST_CREATE=PKG"&&SET "LIST_ITEM=EXTPACKAGE"&&SET "LIST_ACTN=INSTALL"&&SET "NLIST=PKG"&&SET "EXXT=PKG"&&CALL:LIST_PACK_CREATE
EXIT /B
:LIST_UNIFIED_CREATE
CLS&&SET "LIST_ACTN="&&SET "LIST_ITEM="&&SET "LIST_TIME="&&CALL:PAD_LINE&&ECHO                              Type of List?&&CALL:PAD_LINE
ECHO.&&ECHO  (%##%1%#$%)AppX&&ECHO  (%##%2%#$%)Component&&ECHO  (%##%3%#$%)Feature&&ECHO  (%##%4%#$%)Service&&ECHO  (%##%5%#$%)Task&&ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=SELECTX"&&CALL:PROMPT_SET
IF NOT "%SELECTX%"=="1" IF NOT "%SELECTX%"=="2" IF NOT "%SELECTX%"=="3" IF NOT "%SELECTX%"=="4" IF NOT "%SELECTX%"=="5" EXIT /B
CLS&&CALL:PAD_LINE&&ECHO                             Type of Action?&&CALL:PAD_LINE&&ECHO.
IF "%SELECTX%"=="1" SET "LIST_ITEM=APPX"&&ECHO  (%##%1%#$%)Delete&&ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=SELECTY"&&CALL:PROMPT_SET
IF "%SELECTX%"=="2" SET "LIST_ITEM=COMPONENT"&&ECHO  (%##%1%#$%)Delete&&ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=SELECTY"&&CALL:PROMPT_SET
IF "%SELECTX%"=="3" SET "LIST_ITEM=FEATURE"&&ECHO  (%##%1%#$%)Disable&&ECHO  (%##%2%#$%)Enable&&ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=SELECTY"&&CALL:PROMPT_SET
IF "%SELECTX%"=="4" SET "LIST_ITEM=SERVICE"&&ECHO  (%##%1%#$%)Delete&&ECHO  (%##%2%#$%)Automatic&&ECHO  (%##%3%#$%)Manual&&ECHO  (%##%4%#$%)Disable&&ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=SELECTY"&&CALL:PROMPT_SET
IF "%SELECTX%"=="5" SET "LIST_ITEM=TASK"&&ECHO  (%##%1%#$%)Delete&&ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=SELECTY"&&CALL:PROMPT_SET
IF "%LIST_ITEM%"=="APPX" IF "%SELECTY%"=="1" SET "LIST_ACTN=DELETE"
IF "%LIST_ITEM%"=="COMPONENT" IF "%SELECTY%"=="1" SET "LIST_ACTN=DELETE"
IF "%LIST_ITEM%"=="FEATURE" IF "%SELECTY%"=="1" SET "LIST_ACTN=DISABLE"
IF "%LIST_ITEM%"=="FEATURE" IF "%SELECTY%"=="2" SET "LIST_ACTN=ENABLE"
IF "%LIST_ITEM%"=="SERVICE" IF "%SELECTY%"=="1" SET "LIST_ACTN=DELETE"
IF "%LIST_ITEM%"=="SERVICE" IF "%SELECTY%"=="2" SET "LIST_ACTN=AUTO"
IF "%LIST_ITEM%"=="SERVICE" IF "%SELECTY%"=="3" SET "LIST_ACTN=MANUAL"
IF "%LIST_ITEM%"=="SERVICE" IF "%SELECTY%"=="4" SET "LIST_ACTN=DISABLE"
IF "%LIST_ITEM%"=="TASK" IF "%SELECTY%"=="1" SET "LIST_ACTN=DELETE"
IF NOT DEFINED LIST_ACTN EXIT /B
CALL:PAD_LINE&&ECHO   GETTING LISTING...&&SET "$LIST=%CACHE_FOLDER%\%$ELECT$%"&&SET "ONLY1=%LIST_ITEM%"&&SET "NLIST=MST"&&CALL:LIST_FILE
IF DEFINED ERROR EXIT /B
CALL:PAD_MULT&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT EXIT /B
CALL:LIST_TIME
IF NOT DEFINED LIST_TIME EXIT /B
CALL:LIST_WRITE&&SET "PICK=LST"&&CALL:FILE_PICK
IF NOT DEFINED $PICK EXIT /B
CALL:PAD_ADD&&SET "$LST1=%$PICK%"&&CALL:LIST_COMBINE
CALL:PAD_END&&CALL:TITLECARD&&CALL:PAUSED
EXIT /B
:LIST_TIME
SET "LIST_TIME="&&CLS&&CALL:PAD_LINE&&ECHO                             Time of Action?&&CALL:PAD_LINE&&ECHO.&&ECHO  (%##%I%#$%)mage-Apply&&ECHO  (%##%S%#$%)etupComplete&&ECHO  (%##%R%#$%)unOnce&&ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=SELECTX"&&CALL:PROMPT_SET
IF "%SELECTX%"=="I" SET "LIST_TIME=IMAGE-APPLY"
IF "%SELECTX%"=="S" SET "LIST_TIME=SETUP-COMPLETE"
IF "%SELECTX%"=="R" SET "LIST_TIME=RUN-ONCE"
EXIT /B
:LIST_PACK_CREATE
CLS&&CALL:PAD_LINE&&ECHO                               File Picker&&CALL:PAD_LINE&&SET "NLIST=%EXXT%"&&CALL:FILE_LIST
CALL:PAD_MULT&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT EXIT /B
CALL:LIST_TIME
IF NOT DEFINED LIST_TIME EXIT /B
CALL:LIST_WRITE&&SET "PICK=LST"&&CALL:FILE_PICK
IF NOT DEFINED $PICK EXIT /B
CALL:PAD_ADD&&SET "$LST1=%$PICK%"&&CALL:LIST_COMBINE
CALL:PAD_END&&CALL:TITLECARD&&CALL:PAUSED
EXIT /B
:LIST_DISM_CREATE
CLS&&SET "DISM_OPER="&&CALL:PAD_LINE&&ECHO                        DISM Image Maintainence&&CALL:PAD_LINE&&CALL:DISM_CHOICE
IF NOT DEFINED DISM_OPER EXIT /B
CALL:LIST_TIME
IF NOT DEFINED LIST_TIME EXIT /B
SET "PICK=LST"&&CALL:FILE_PICK
IF NOT DEFINED $PICK EXIT /B
CALL:PAD_ADD&&ECHO.&&ECHO  [DISM][%DISM_OPER%][EXECUTE][%LIST_TIME%]&&ECHO [DISM][%DISM_OPER%][EXECUTE][%LIST_TIME%]>>"%$PICK%"
ECHO.&&CALL:PAD_END&&CALL:TITLECARD&&CALL:PAUSED
EXIT /B
:LIST_COMBINATOR
SET "PICK=LST"&&CALL:FILE_PICK
IF NOT DEFINED $PICK EXIT /B
SET "$LST1=%$PICK%"&&SET "PICK=LST"&&CALL:FILE_PICK
IF NOT DEFINED $PICK EXIT /B
SET "$LST2=%$PICK%"&&CALL:PAD_SAME
IF "%$LST1%"=="%$LST2%" EXIT /B
CALL:PAD_LINE&&ECHO                            Name of new list?&&CALL:PAD_LINE&&ECHO.&&SET "PROMPT_SET=NEW_NAME"&&CALL:PROMPT_SET_ANY
IF NOT DEFINED NEW_NAME EXIT /B
COPY /Y "%$LST1%" "%CACHE_FOLDER%\%NEW_NAME%.LST">NUL
SET "$LST1=%CACHE_FOLDER%\%NEW_NAME%.LST"
CALL:PAD_ADD&&IF EXIST "%$LST1%" IF DEFINED $LST1 ECHO.&&ECHO  LIST 1&&ECHO.&&FOR /F "TOKENS=1-9 DELIMS=[]" %%a in (%$LST1%) DO (IF NOT "%%a"=="" IF NOT "%%a"=="BASE-LIST" IF NOT "%%a"=="EXEC-LIST" IF NOT "%%a"=="VERSION" CALL ECHO  [%#@%%%a%#$%][%#@%%%b%#$%][%#@%%%c%#$%][%#@%%%d%#$%])
ECHO.&&ECHO  LIST 2&&CALL:LIST_COMBINE&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:LIST_DIFFERENCER
SET "PICK=MST"&&CALL:FILE_PICK
IF NOT DEFINED $PICK EXIT /B
SET "$LST1=%$PICK%"&&SET "PICK=MST"&&CALL:FILE_PICK
IF NOT DEFINED $PICK EXIT /B
SET "$LST2=%$PICK%"&&CALL:PAD_SAME
IF "%$LST1%"=="%$LST2%" EXIT /B
CALL:PAD_LINE&&ECHO                            Name of the list?&&CALL:PAD_LINE&&ECHO.&&SET "PROMPT_SET=NEW_NAME"&&CALL:PROMPT_SET_ANY
IF NOT DEFINED NEW_NAME EXIT /B
CALL:PAD_LINE&&ECHO Differencing [%$LST1%] and [%$LST2%]...&&CALL:PAD_LINE
COPY /Y "%$LST1%" "$LST2">NUL
COPY /Y "%$LST2%" "$LST1">NUL
ECHO EXEC-LIST>"%CACHE_FOLDER%\%NEW_NAME%.LST"
FOR /F "TOKENS=1-9 SKIP=1 DELIMS=[]" %%a in ($LST1) DO (SET "$X0$="&&FOR /F "TOKENS=1-9 SKIP=1 DELIMS=[]" %%1 in ($LST2) DO (IF "[%%1:%%2]"=="[%%a:%%b]" SET "$X0$=1")
IF "%%a"=="APPX" IF NOT DEFINED $X0$ CALL ECHO.[%%a][%%b][DELETE][IMAGE-APPLY]>>"%CACHE_FOLDER%\%NEW_NAME%.LST"
IF "%%a"=="COMPONENT" IF NOT DEFINED $X0$ CALL ECHO.[%%a][%%b][DELETE][IMAGE-APPLY]>>"%CACHE_FOLDER%\%NEW_NAME%.LST"
IF "%%a"=="FEATURE" IF DEFINED $X0$ CALL ECHO.[%%a][%%b][DISABLE][IMAGE-APPLY]>>"%CACHE_FOLDER%\%NEW_NAME%.LST"
IF "%%a"=="FEATURE" IF NOT DEFINED $X0$ CALL ECHO.[%%a][%%b][ABSENT]>>"%CACHE_FOLDER%\%NEW_NAME%.LST"
IF "%%a"=="SERVICE" IF DEFINED $X0$ CALL ECHO.[%%a][%%b][%%c][IMAGE-APPLY]>>"%CACHE_FOLDER%\%NEW_NAME%.LST"
IF "%%a"=="SERVICE" IF NOT DEFINED $X0$ CALL ECHO.[%%a][%%b][DELETE][IMAGE-APPLY]>>"%CACHE_FOLDER%\%NEW_NAME%.LST"
IF "%%a"=="TASK" IF NOT DEFINED $X0$ CALL ECHO.[%%a][%%b][DELETE][IMAGE-APPLY]>>"%CACHE_FOLDER%\%NEW_NAME%.LST")
IF EXIST "$LST*" DEL /F $LST*>NUL
CALL:PAUSED
EXIT /B
:LIST_BASE_CREATE
SET "ERR_MSG="&&SET "MENU_INSERTA= [ %##%@%#$% ]\[%##%Current-Environment%#$%]"&&SET "PICK=VHDX"&&CALL:FILE_PICK
IF "%LIVE_APPLY%"=="1" IF NOT DEFINED DISCLAIMER CALL:DISCLAIMER&EXIT /B
IF NOT "%LIVE_APPLY%"=="1" IF NOT DEFINED $PICK EXIT /B
CALL:PAD_LINE&&ECHO                         Name of the Base-List?&&CALL:PAD_LINE&&ECHO.&&SET "PROMPT_SET=NEW_NAME"&&CALL:PROMPT_SET_ANY
IF NOT DEFINED NEW_NAME EXIT /B
IF "%LIVE_APPLY%"=="1" GOTO:LIVE_APPLY_BASE_SKIP
IF EXIST "V:\" SET "ERR_MSG=%##%Drive letter V:\ can NOT be in use. Unmount the Vdisk in use.%#$%"&&GOTO:LIST_BASE_CLEANUP
SET "VDISK=%$PICK%"&&CALL:VDISK_ATTACH
IF NOT EXIST "V:\Windows" SET "ERR_MSG=             %##%Vdisk error or Windows not installed on Vdisk.%#$%"&&CALL:VDISK_DETACH&&GOTO:LIST_BASE_CLEANUP
:LIVE_APPLY_BASE_SKIP
CLS&&CALL:PAD_LINE&&ECHO                          Base List Creation&&CALL:PAD_LINE
IF EXIST "%CACHE_FOLDER%\%NEW_NAME%.MST" DEL /F "%CACHE_FOLDER%\%NEW_NAME%.MST">NUL
CALL:IF_LIVE2
ECHO BASE-LIST>"%CACHE_FOLDER%\%NEW_NAME%.mst"
DISM /ENGLISH /%APPLY_TARGET% /GET-CURRENTEDITION>"$DISM"
SET "INFO_E="&&SET "INFO_V="&&FOR /F "TOKENS=1-9 DELIMS=: " %%a in ($DISM) DO (IF "%%a %%b"=="Image Version" CALL SET "INFO_V=%%c"
IF "%%a %%b"=="Current Edition" IF NOT "%%c"=="is" CALL SET "INFO_E=%%c")
ECHO Version[%INFO_V%] Edition[%INFO_E%]&&ECHO [%INFO_E%][%INFO_V%]>>"%CACHE_FOLDER%\%NEW_NAME%.MST"
CALL:PAD_LINE&&ECHO Getting appx listing..&&CALL:PAD_LINE&&IF EXIST "$DISM" DEL /F "$DISM">NUL 2>&1
SET "LIST_ITEM=APPX"&&SET "LIST_ACTN=PRESENT"&&CALL:IF_LIVE1
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications">$REG1 2>&1
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications">$REG2 2>&1
SET "LIST_ACTN=STANDARD"&&FOR /F "TOKENS=9* DELIMS=\" %%a in ($REG1) DO (FOR /F "TOKENS=1-1* DELIMS=_" %%1 in ("%%a") DO (CALL SET "BASECAP=%%1"&&CALL:BASECAP))
SET "LIST_ACTN=INBOXED"&&FOR /F "TOKENS=9* DELIMS=\" %%a in ($REG2) DO (FOR /F "TOKENS=1-1* DELIMS=_" %%1 in ("%%a") DO (CALL SET "BASECAP=%%1"&&CALL:BASECAP))
CALL:IF_LIVE2
CALL:PAD_LINE&&ECHO Getting feature listing..&&CALL:PAD_LINE&&SET "LIST_ITEM=FEATURE"&&DISM /ENGLISH /%APPLY_TARGET% /GET-FEATURES>"$LST"
SET "LIST_ACTN=PRESENT"&&FOR /F "TOKENS=1-9 DELIMS=: " %%a in ($LST) DO (IF "%%a %%b"=="Feature Name" CALL SET "BASECAP=%%c%%d%%e%%f%%g%%h%%i"&&CALL:BASECAP)
CALL:IF_LIVE1
CALL:PAD_LINE&&ECHO Getting service listing..&&CALL:PAD_LINE&&SET "LIST_ITEM=SERVICE"&&REG QUERY "%HIVE_SYSTEM%\ControlSet001\Services">$LST 2>&1
FOR /F "TOKENS=1-4* DELIMS=\" %%a in ($LST) DO (FOR /F "TOKENS=1-9 DELIMS= " %%1 in ('REG QUERY "%HIVE_SYSTEM%\ControlSet001\Services\%%e"') DO (CALL SET "BASECAP=%%e"
IF "%%1"=="Start" IF "%%3"=="0x2" CALL SET "LIST_ACTN=AUTO"
IF "%%1"=="Start" IF "%%3"=="0x3" CALL SET "LIST_ACTN=MANUAL"
IF "%%1"=="Start" IF "%%3"=="0x4" CALL SET "LIST_ACTN=DISABLED"
IF "%%1"=="Type" IF "%%3"=="0x10" CALL:BASECAP
IF "%%1"=="Type" IF "%%3"=="0x20" CALL:BASECAP
IF "%%1"=="Type" IF "%%3"=="0x60" CALL:BASECAP))
CALL:PAD_LINE&&ECHO Getting task listing..&&CALL:PAD_LINE&&REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks" /f Path /c /e /s>$LST 2>&1
SET "LIST_ITEM=TASK"&&SET "LIST_ACTN=PRESENT"&&FOR /F "TOKENS=1* DELIMS=\" %%a in ($LST) DO (IF "%%a"=="    Path    REG_SZ    " CALL SET "BASECAP=%%b"&&CALL:BASECAP)
CALL:PAD_LINE&&ECHO Getting component listing....&&CALL:PAD_LINE&&REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages">$LST 2>&1
SET "LIST_ITEM=COMPONENT"&&SET "LIST_ACTN=PRESENT"&&FOR /F "TOKENS=8* DELIMS=\" %%a in ($LST) DO (FOR /F "TOKENS=1-1* DELIMS=~" %%1 in ("%%a") DO (CALL SET "BASEPRE=%%1"&&CALL SET "BASECAP=%%1"&&CALL:BASECAP))
CALL:MOUNT_INT
CALL:VDISK_DETACH&&CALL:TITLECARD
:LIST_BASE_CLEANUP
IF DEFINED ERR_MSG CALL:PAD_LINE&&ECHO %ERR_MSG%
CALL:SCRATCH_DELETE&&CALL:PAD_LINE&&ECHO                        End of Base-List Creation&&CALL:PAD_LINE&&CALL:CLEAN&&CALL:TITLECARD&&CALL:PAUSED
EXIT /B
:BASECAP
IF "%BASEPRELST%"=="%BASEPRE%" IF "%LIST_ITEM%"=="COMPONENT" EXIT /B
CALL SET "BASEPRELST=%BASEPRE%"&&FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "BASECAP=%%BASECAP:%%G=%%G%%")
CALL ECHO  [%#@%%LIST_ITEM%%#$%][%#@%%BASECAP%%#$%][%#@%%LIST_ACTN%%#$%]&&CALL ECHO [%LIST_ITEM%][%BASECAP%][%LIST_ACTN%]>>"%CACHE_FOLDER%\%NEW_NAME%.MST"
EXIT /B
:LIST_COMBINE
IF DEFINED $LST1 COPY /Y "%$LST1%" "$LST1">NUL
IF DEFINED $LST2 COPY /Y "%$LST2%" "$LST2">NUL
ECHO EXEC-LIST>"$LST3"
IF EXIST "$LST1" FOR /F "TOKENS=1-9 DELIMS=[]" %%a in ($LST1) DO (IF NOT "%%a"=="" IF NOT "%%a"=="BASE-LIST" IF NOT "%%a"=="EXEC-LIST" IF NOT "%%a"=="VERSION" CALL ECHO [%%a][%%b][%%c][%%d]>>"$LST3")
IF EXIST "$LST2" ECHO.&&FOR /F "TOKENS=1-9 DELIMS=[]" %%a in ($LST2) DO (IF NOT "%%a"=="" IF NOT "%%a"=="BASE-LIST" IF NOT "%%a"=="EXEC-LIST" IF NOT "%%a"=="VERSION" CALL ECHO  [%#@%%%a%#$%][%#@%%%b%#$%][%#@%%%c%#$%][%#@%%%d%#$%]&&CALL ECHO [%%a][%%b][%%c][%%d]>>"$LST3")
IF EXIST "$LST2" ECHO.
COPY /Y "$LST3" "%$LST1%">NUL
SET "$LST1="&&SET "$LST2="&&SET "$LST3="&&IF EXIST "$LST*" DEL /F "$LST*">NUL
EXIT /B
:LIST_WRITE
IF NOT DEFINED $ELECT EXIT /B
IF EXIST "$LST*" DEL /F "$LST*">NUL
FOR %%a in (%$ELECT%) DO (IF NOT "%%a"=="" CALL SET "LIST_WRITE=[%%$ITEM%%a%%]"&&CALL:LIST_WRITEX)
EXIT /B
:LIST_WRITEX
IF NOT "%LIST_ITEM%"=="EXTPACKAGE" FOR /F "TOKENS=1-9 DELIMS=[]" %%1 IN ("%LIST_WRITE%") DO (IF "%%1"=="%LIST_ITEM%" CALL ECHO [%%1][%%2][%LIST_ACTN%][%LIST_TIME%]>>"$LST2")
IF "%LIST_ITEM%"=="EXTPACKAGE" FOR /F "TOKENS=1-9 DELIMS=[]" %%1 IN ("%LIST_WRITE%") DO (CALL ECHO [EXTPACKAGE][%%1][%LIST_ACTN%][%LIST_TIME%]>>"$LST2")
EXIT /B
:PAD_SAME
IF "%$LST1%"=="%$PICK%" CALL:PAD_LINE&&ECHO [%#@%%$LST1%%#$%] and [%#@%%$PICK%%#$%] are the same...&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:PAD_MULT
CALL:PAD_LINE&&ECHO             Enter File (%##%#%#$%) To Build List, Multiples OK(%##%1 2 3%#$%)&&CALL:PAD_LINE
EXIT /B
:PAD_ADD
CLS&&CALL:PAD_LINE&&ECHO                The Following Items Were Added/Combined:&&CALL:PAD_LINE
EXIT /B
:PAD_END
CALL:PAD_LINE&&ECHO                           End of List Creation&&CALL:PAD_LINE
EXIT /B
:NULL
EXIT /B
:IF_LIVE1
IF DEFINED LIVE_APPLY CALL:MOUNT_INT
IF NOT DEFINED LIVE_APPLY CALL:MOUNT_EXT
EXIT /B
:IF_LIVE2
IF DEFINED LIVE_APPLY CALL:MOUNT_INT
IF NOT DEFINED LIVE_APPLY CALL:MOUNT_MIX
EXIT /B
REM IMAGEMGR_RUN_LIST_IMAGEMGR_RUN_LIST_IMAGEMGR_RUN_LIST_IMAGEMGR_RUN_LIST
:IMAGEMGR_RUN_LIST
REM IMAGEMGR_RUN_LIST_IMAGEMGR_RUN_LIST_IMAGEMGR_RUN_LIST_IMAGEMGR_RUN_LIST
SET "ERR_MSG="&&IF "%CAME_FROM%"=="COMMAND" SET "APPLY_COPY=ORIG"
IF NOT DEFINED APPLY_COPY SET "APPLY_COPY=ORIG"
:IMAGEMGR_JUMP
IF "%LIVE_APPLY%"=="1" GOTO:THE_ACTION
IF EXIST "V:\" SET "ERR_MSG=%##%Drive letter V:\ can NOT be in use. Unmount the Vdisk in use.%#$%"&&GOTO:THE_ACTION_CLEANUP
CALL:VDISK_ATTACH
IF NOT EXIST "V:\Windows" SET "ERR_MSG=             %##%Vdisk error or Windows not installed on Vdisk.%#$%"&&CALL:VDISK_DETACH&&GOTO:THE_ACTION_CLEANUP
:THE_ACTION
CALL:UNIFIED_LIST_RUN
CALL:MOUNT_INT
IF NOT DEFINED LIVE_APPLY CALL:VDISK_DETACH
:THE_ACTION_CLEANUP
IF DEFINED ERR_MSG CALL:PAD_LINE&&ECHO %ERR_MSG%
CALL:SCRATCH_DELETE&&CALL:AIO_DELETE&&CALL:PAD_LINE&&ECHO                       Imaging operations complete&&CALL:PAD_LINE&&CALL:TITLECARD&&IF NOT "%CAME_FROM%"=="COMMAND" CALL:PAUSED
EXIT /B
:UNIFIED_LIST_RUN
IF NOT DEFINED $LST1 EXIT /B
CALL:PAD_LINE&&ECHO [%#@%EXEC-LIST START%#$%] [%#@%%DATE%%#$%] [%#@%%TIME%%#$%]&&CALL:PAD_LINE&&CALL:COLOR_LAY
IF "%PROG_MODE%"=="RAMDISK" IF "%BRUTE_FORCE%"=="ENABLED" SET "BRUTE_FORCE="&&SET "BRUTE_FLG=1"
IF "%BRUTE_FORCE%"=="ENABLED" SC DELETE $BRUTE>NUL 2>&1
SET "SC_PREPARE="&&SET "RO_PREPARE="&&SET "BRUTE1="&&COPY /Y "%$LST1%" "$LST">NUL 2>&1
FOR /F "TOKENS=1-9 SKIP=1 DELIMS=[]" %%a in ($LST) DO (
IF "%%a"=="SERVICE" IF "%BRUTE_FORCE%"=="ENABLED" IF NOT DEFINED BRUTE1 SET "BRUTE1=1"&&SC CREATE $BRUTE BINPATH="CMD /C START "%PROG_SOURCE%\$BRUTE.CMD"" START=DEMAND>NUL 2>&1
IF "%%a"=="TASK" IF "%BRUTE_FORCE%"=="ENABLED" IF NOT DEFINED BRUTE1 SET "BRUTE1=1"&&SC CREATE $BRUTE BINPATH="CMD /C START "%PROG_SOURCE%\$BRUTE.CMD"" START=DEMAND>NUL 2>&1
FOR %%1 in (# @ APPX COMPONENT DISM FEATURE EXTPACKAGE SERVICE TASK) DO (IF "%%1"=="%%a" CALL SET "LIST_ITEM=%%a"&&CALL SET "BASE_MEAT=%%b"&&CALL SET "LIST_ACTN=%%c"&&CALL SET "LIST_TIME=%%d"&&CALL:UNIFIED_PARSE))
IF "%BRUTE_FORCE%"=="ENABLED" SC DELETE $BRUTE>NUL 2>&1
IF DEFINED BRUTE_FLG SET "BRUTE_FORCE=1"
CALL:SCRATCH_PACK_DELETE&&ECHO [%#@%EXEC-LIST END%#$%] [%#@%%DATE%%#$%] [%#@%%TIME%%#$%]&&SET "$LST1="&&IF EXIST "$LST" DEL /F "$LST">NUL 2>&1
EXIT /B
:UNIFIED_PARSE
SET "NORESTART="&&SET "ENDQ=End of search"&&IF DEFINED LIVE_APPLY SET "NORESTART=/NORESTART "
IF "%LIST_ITEM%"=="#" CALL:PAD_LINE
IF "%LIST_ITEM%"=="@" ECHO %#@%%BASE_MEAT%%#$%
IF "%LIST_TIME%"=="RUN-ONCE" CALL:RO_CREATE
IF "%LIST_TIME%"=="SETUP-COMPLETE" CALL:SC_CREATE
IF "%LIST_ITEM%:%LIST_TIME%"=="FEATURE:IMAGE-APPLY" CALL:FEAT_HUNT
IF "%LIST_ITEM%:%LIST_TIME%"=="SERVICE:IMAGE-APPLY" CALL:SVC_HUNT
IF "%LIST_ITEM%:%LIST_ACTN%:%LIST_TIME%"=="APPX:DELETE:IMAGE-APPLY" CALL:APPX_HUNT
IF "%LIST_ITEM%:%LIST_ACTN%:%LIST_TIME%"=="TASK:DELETE:IMAGE-APPLY" CALL:TASK_HUNT
IF "%LIST_ITEM%:%LIST_ACTN%:%LIST_TIME%"=="COMPONENT:DELETE:IMAGE-APPLY" CALL:COMP_HUNT
IF "%LIST_ITEM%:%LIST_TIME%"=="DISM:IMAGE-APPLY" IF NOT "%BASE_MEAT%"=="" IF NOT "%LIST_ACTN%"=="" CALL:IF_LIVE2
IF "%LIST_ITEM%:%LIST_TIME%"=="DISM:IMAGE-APPLY" IF NOT "%BASE_MEAT%"=="" IF NOT "%LIST_ACTN%"=="" SET "DISM_OPER=%BASE_MEAT%"&&CALL:IMAGEMGR_DISM_OPER
IF "%LIST_ITEM%:%LIST_TIME%"=="EXTPACKAGE:IMAGE-APPLY" CALL SET "IMAGE_PACK=%PACK_FOLDER%\%BASE_MEAT%"&&CALL:PACK_INSTALL
CALL:CLEAN
EXIT /B
:SVC_HUNT
CALL:IF_LIVE1
IF "%LIST_ITEM%:%LIST_ACTN%"=="SERVICE:DELETE" ECHO Removing Service [%#@%%BASE_MEAT%%#$%]...&&CALL:PAD_LINE
IF NOT "%LIST_ITEM%:%LIST_ACTN%"=="SERVICE:DELETE" ECHO Changing start to [%#@%%LIST_ACTN%%#$%] for Service [%#@%%BASE_MEAT%%#$%]...&&CALL:PAD_LINE
REG QUERY "%HIVE_SYSTEM%\ControlSet001\Services\%BASE_MEAT%" /F ImagePath /c /e /s>$REG1 2>&1
SET "SVC_GO="&&SET "SVC_XNT="&&FOR /F "TOKENS=1-9* DELIMS=: " %%a IN ($REG1) DO (IF "%%a"=="ImagePath" IF NOT "%%c"=="NUL" CALL SET "SVC_GO=1")
IF NOT DEFINED SVC_GO SET "REGMSG=Service [%##%%BASE_MEAT%%#$%] doesn't exist"&&GOTO:SVC_SKIP
IF "%LIST_ITEM%:%LIST_ACTN%"=="SERVICE:AUTO" REG ADD "%HIVE_SYSTEM%\ControlSet001\Services\%BASE_MEAT%" /V "Start" /T REG_DWORD /D "2" /F>NUL&&ECHO                 [%#@%The operation completed successfully%#$%]&&CALL:PAD_LINE&&EXIT /B
IF "%LIST_ITEM%:%LIST_ACTN%"=="SERVICE:MANUAL" REG ADD "%HIVE_SYSTEM%\ControlSet001\Services\%BASE_MEAT%" /V "Start" /T REG_DWORD /D "3" /F>NUL&&ECHO                 [%#@%The operation completed successfully%#$%]&&CALL:PAD_LINE&&EXIT /B
IF "%LIST_ITEM%:%LIST_ACTN%"=="SERVICE:DISABLE" REG ADD "%HIVE_SYSTEM%\ControlSet001\Services\%BASE_MEAT%" /V "Start" /T REG_DWORD /D "4" /F>NUL&&ECHO                 [%#@%The operation completed successfully%#$%]&&CALL:PAD_LINE&&EXIT /B
FOR %%1 in (%SVC_SKIP%) DO (IF "%BASE_MEAT%"=="%%1" CALL ECHO Deleting Service [%#@%%BASE_MEAT%%#$%]...&&CALL:PAD_LINE&&CALL ECHO             [%##%The operation did NOT complete successfully%#$%]&&CALL:PAD_LINE&&EXIT /B)
IF EXIST "%PROG_SOURCE%\$BRUTE.CMD" DEL /F "%PROG_SOURCE%\$BRUTE.CMD">NUL
SET "SVC_XNT="&&CALL SET "X0Z="&&FOR /F "TOKENS=1-9* DELIMS={}:" %%a IN ($REG1) DO (IF NOT "%%a"=="" CALL SET /A "SVC_XNT+=1"&&CALL SET "X1=%%a"&&CALL SET "X2=%%b"&&CALL:SVCBBQ&&CALL:NULL)
REG QUERY "%HIVE_SYSTEM%\ControlSet001\Services\%BASE_MEAT%" /F ImagePath /c /e /s>$REG2 2>&1
SET "REGMSG="&&FOR /F "TOKENS=1-9 DELIMS= " %%a IN ($REG2) DO (IF "%%a"=="ImagePath" IF NOT "%%c"=="NUL" CALL SET "REGMSG=            [%##%The operation did NOT complete successfully%#$%]")
:SVC_SKIP
IF NOT DEFINED REGMSG ECHO                 [%#@%The operation completed successfully%#$%]&&CALL:PAD_LINE
IF DEFINED REGMSG ECHO %REGMSG%&&CALL:PAD_LINE
IF EXIST "%PROG_SOURCE%\$BRUTE.CMD" DEL /F "%PROG_SOURCE%\$BRUTE.CMD">NUL
IF EXIST "$REG1" DEL /F "$REG1">NUL
IF EXIST "$REG2" DEL /F "$REG2">NUL
EXIT /B
:SVCBBQ
IF "%X1%"=="%ENDQ%" EXIT /B
IF "%BASE_MEAT%"=="%X0Z%" EXIT /B
SET "X0Z=%BASE_MEAT%"&&SET "REGMSG="
IF "%SVC_XNT%"=="1" IF "%X1%"=="ERROR" SET "REGMSG=Service [%##%%BASE_MEAT%%#$%] doesn't exist"&&CALL:PAD_LINE
IF "%SVC_XNT%"=="1" IF "%X1%"=="%ENDQ%" SET "REGMSG=Service [%##%%BASE_MEAT%%#$%] doesn't exist"&&CALL:PAD_LINE
IF DEFINED REGMSG EXIT /B
SET SVC_CMD1=REG DELETE "%X1%" /F&&SET SVC_CMD2=REG ADD "%X1%" /V "ImagePath" /T REG_EXPAND_SZ /D "NUL" /F
IF NOT "%BRUTE_FORCE%"=="ENABLED" %SVC_CMD1%>NUL 2>&1
IF NOT "%BRUTE_FORCE%"=="ENABLED" %SVC_CMD2%>NUL 2>&1
IF "%BRUTE_FORCE%"=="ENABLED" ECHO %SVC_CMD1%>"%PROG_SOURCE%\$BRUTE.CMD"
IF "%BRUTE_FORCE%"=="ENABLED" ECHO %SVC_CMD2%>>"%PROG_SOURCE%\$BRUTE.CMD"
IF "%BRUTE_FORCE%"=="ENABLED" ECHO EXIT>>"%PROG_SOURCE%\$BRUTE.CMD"
IF "%BRUTE_FORCE%"=="ENABLED" SC START $BRUTE>NUL 2>&1
IF EXIST "$REG1" DEL /F "$REG1">NUL
EXIT /B
:TASK_HUNT
ECHO Removing Task [%#@%%BASE_MEAT%%#$%]...&&CALL:PAD_LINE&&CALL:IF_LIVE1
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\%BASE_MEAT%" /F Id /c /e /s>$REG1 2>&1
IF EXIST "%PROG_SOURCE%\$BRUTE.CMD" DEL /F "%PROG_SOURCE%\$BRUTE.CMD">NUL
SET "TASK_GO="&&SET "TASK_XNT="&&FOR /F "TOKENS=1-9* DELIMS={}:" %%a IN ($REG1) DO (IF "%%a"=="    Id    REG_SZ    " SET "TASK_GO=1")
IF NOT DEFINED TASK_GO SET "REGMSG=Task [%##%%BASE_MEAT%%#$%] doesn't exist"&&GOTO:TASK_SKIP
SET "TASK_XNT="&&CALL SET "X0Z="&&FOR /F "TOKENS=1-9* DELIMS={}:" %%a IN ($REG1) DO (IF NOT "%%a"=="" CALL SET /A "TASK_XNT+=1"&&CALL SET "X1=%%a"&&CALL SET "X2=%%b"&&CALL:TASKBBQ&&CALL:TASK_CHK)
:TASK_SKIP
IF NOT DEFINED REGMSG ECHO                 [%#@%The operation completed successfully%#$%]&&CALL:PAD_LINE
IF DEFINED REGMSG ECHO %REGMSG%&&CALL:PAD_LINE
IF EXIST "%PROG_SOURCE%\$BRUTE.CMD" DEL /F "%PROG_SOURCE%\$BRUTE.CMD">NUL
IF EXIST "$REG1" DEL /F "$REG1">NUL
IF EXIST "$REG2" DEL /F "$REG2">NUL
EXIT /B
:TASK_CHK
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\%BASE_MEAT%" /F Id /c /e /s>$REG2 2>&1
SET "REGMSG="&&SET "TASK_XNT="&&FOR /F "TOKENS=1-9* DELIMS={}:" %%a IN ($REG2) DO (IF "%%a"=="    Id    REG_SZ    " CALL SET "REGMSG=            [%##%The operation did NOT complete successfully%#$%]")
EXIT /B
:TASKBBQ
IF "%X1%"=="%ENDQ%" EXIT /B
IF "%BASE_MEAT%"=="%X0Z%" EXIT /B
SET "REGMSG="&&IF NOT "%BASE_MEAT%"=="%X0Z%" SET "X0Z=%BASE_MEAT%"
IF "%TASK_XNT%"=="1" IF "%X1%"=="ERROR" SET "REGMSG=Task [%##%%BASE_MEAT%%#$%] doesn't exist"&&CALL:PAD_LINE
IF "%TASK_XNT%"=="1" IF "%X1%"=="%ENDQ%" SET "REGMSG=Task [%##%%BASE_MEAT%%#$%] doesn't exist"&&CALL:PAD_LINE
IF DEFINED REGMSG EXIT /B
SET TASK_CMD1=REG DELETE "%X1%" /F&&SET TASK_CMD2=REG DELETE "%HIVE_SOFTWARE%\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{%X2%}" /F
IF NOT "%BRUTE_FORCE%"=="ENABLED" IF NOT "%X1%"=="    Id    REG_SZ    " %TASK_CMD1%>NUL 2>&1
IF NOT "%BRUTE_FORCE%"=="ENABLED" IF "%X1%"=="    Id    REG_SZ    " %TASK_CMD2%>NUL 2>&1
IF NOT "%BRUTE_FORCE%"=="ENABLED" DEL /F "%WINTAR%\System32\Tasks\%BASE_MEAT%">NUL 2>&1
IF "%BRUTE_FORCE%"=="ENABLED" IF NOT "%X1%"=="    Id    REG_SZ    " ECHO %TASK_CMD1%>"%PROG_SOURCE%\$BRUTE.CMD"
IF "%BRUTE_FORCE%"=="ENABLED" IF "%X1%"=="    Id    REG_SZ    " ECHO %TASK_CMD2%>>"%PROG_SOURCE%\$BRUTE.CMD"
IF "%BRUTE_FORCE%"=="ENABLED" ECHO DEL /F "%WINTAR%\System32\Tasks\%BASE_MEAT%">>"%PROG_SOURCE%\$BRUTE.CMD"
IF "%BRUTE_FORCE%"=="ENABLED" ECHO EXIT>>"%PROG_SOURCE%\$BRUTE.CMD"
IF "%BRUTE_FORCE%"=="ENABLED" SC START $BRUTE>NUL 2>&1
IF EXIST "$REG1" DEL /F "$REG1">NUL
EXIT /B
:APPX_HUNT
SET "APPX_SKIP="&&SET "APPX_DONE="&&SET "APPX_ERR="&&SET "APPX_ABT="&&SET "DISMSG="&&CALL:IF_LIVE1
ECHO Removing AppX [%#@%%BASE_MEAT%%#$%]...&&CALL:PAD_LINE
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications" /F "%BASE_MEAT%">"$REG1"
SET "APPX_XNT="&&FOR /F "TOKENS=3* DELIMS=_" %%a IN ($REG1) DO (IF NOT "%%a"=="" CALL SET /A "APPX_XNT+=1"&&CALL SET "TX1=%%a"&&CALL SET "TX2=%%b"&&CALL:APPX_IBX)
IF NOT DEFINED APPX_SKIP REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications" /F "%BASE_MEAT%">"$REG1"
IF NOT DEFINED APPX_SKIP SET "APPX_XNT="&&FOR /F "TOKENS=3* DELIMS=_" %%a IN ($REG1) DO (IF NOT "%%a"=="" CALL SET /A "APPX_XNT+=1"&&CALL SET "TX1=%%a"&&CALL SET "TX2=%%b"&&CALL:APPX_NML)
IF DEFINED APPX_ERR ECHO AppX [%##%%BASE_MEAT%%#$%] is a stub or unable to remove&&CALL:PAD_LINE
IF NOT DEFINED APPX_DONE IF NOT DEFINED APPX_ERR ECHO AppX [%##%%BASE_MEAT%%#$%] doesn't exist&&CALL:PAD_LINE
IF DEFINED APPX_DONE ECHO                 [%#@%%DISMSG%%#$%]&&CALL:PAD_LINE
IF EXIST "$REG*" DEL /F "$REG*">NUL
EXIT /B
:APPX_IBX
IF "%TX1%"=="%ENDQ%" EXIT /B
CALL:IF_LIVE1
FOR /F "TOKENS=1-9* DELIMS={}:" %%a IN ($REG1) DO (IF NOT "%%a"=="" IF "%%a"=="ERROR" SET "APPX_ABT=1")
IF DEFINED APPX_ABT EXIT /B
REG DELETE "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%BASE_MEAT%_%TX2%" /F>NUL 2>&1
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications" /F "%BASE_MEAT%">"$REG3"
FOR /F "TOKENS=1-9* DELIMS=: " %%a IN ($REG3) DO (IF NOT "%%a"=="" IF "%%d"=="0" SET "APPX_SKIP=1"&&SET "APPX_DONE=1"&&SET "DISMSG=The operation completed successfully")
IF DEFINED APPX_DONE REG ADD "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\%BASE_MEAT%_%TX2%">NUL 2>&1
IF NOT DEFINED APPX_DONE SET "APPX_SKIP=1"&&SET "APPX_ERR=1"
IF EXIST "$REG3" DEL /F "$REG3">NUL
EXIT /B
:APPX_NML
IF "%TX1%"=="%ENDQ%" EXIT /B
CALL:IF_LIVE2
DISM /ENGLISH /%APPLY_TARGET% /REMOVE-Provisionedappxpackage /PACKAGENAME:"%BASE_MEAT%_%TX2%" >"$DISM1"
FOR /F "TOKENS=1 DELIMS=." %%1 in ($DISM1) DO (SET "DISMSG="&&IF "%%1"=="The operation completed successfully" CALL SET "DISMSG=%%1")
IF NOT DEFINED DISMSG SET "APPX_ERR=1"
IF DEFINED DISMSG SET "APPX_DONE=1"
IF EXIST "$DISM1" DEL /F "$DISM1">NUL
CALL:IF_LIVE1
IF DEFINED APPX_DONE REG ADD "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\%BASE_MEAT%_%TX2%">NUL 2>&1
EXIT /B
:COMP_HUNT
ECHO Removing Component [%#@%%BASE_MEAT%%#$%]...&&CALL:PAD_LINE&&CALL:IF_LIVE1
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /F "%BASE_MEAT%">"$REG1"
SET "X0Z="&&SET "COMP_XNT="&&SET "FNL_XNT="&&FOR /F "TOKENS=1* DELIMS=:~" %%a IN ($REG1) DO (IF NOT "%%a"=="" CALL SET /A "COMP_XNT+=1"&&CALL SET /A "FNL_XNT+=1"&&CALL SET "TX1=%%a"&&CALL SET "TX2=%%b"&&CALL:COMP_HUNT2)
EXIT /B
:COMP_HUNT2
IF "%X0Z%"=="%TX1%" EXIT /B
IF "%COMP_XNT%" GTR "1" EXIT /B
IF "%TX1%"=="%ENDQ%" ECHO Component [%##%%BASE_MEAT%%#$%] doesn't exist&&CALL:PAD_LINE&&EXIT /B
IF NOT DEFINED LIVE_APPLY CALL:MOUNT_EXT
FOR %%a in (1 2 3 4 5 6 7 8 9) DO (CALL SET "COMP_Z%%a=")
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /F "%BASE_MEAT%">"$REG2"
SET "X0Z="&&SET "SUB_XNT="&&SET "COMP_FLAG="&&FOR /F "TOKENS=1* DELIMS=:~" %%1 IN ($REG2) DO (IF NOT "%%1"=="" CALL SET /A "SUB_XNT+=1"&&CALL SET "X1=%%1"&&CALL SET "X2=%%2"&&CALL:COMPBBQ)
IF EXIST "$REG2" DEL /F "$REG2">NUL
EXIT /B
:COMP_AVOID
IF "%BASE_MEAT%~%X2%"=="%COMPX%" SET "COMP_AVD=1"
EXIT /B
:COMPBBQ
IF "%X1%"=="%ENDQ%" EXIT /B
IF "%FNL_XNT%" GTR "9" EXIT /B
IF "%SUB_XNT%" GTR "9" EXIT /B
IF "%X0Z%"=="%BASE_MEAT%~%X2%" EXIT /B
SET "COMP_AVD="&&FOR %%a in (1 2 3 4 5 6 7 8 9) DO (CALL SET "COMPX=%%COMP_Z%%a%%"&&CALL:COMP_AVOID)
IF DEFINED COMP_AVD EXIT /B
SET "COMP_ABT=X"&&SET "COMP_ABT1="&&IF "%SAFE_EXCLUDE%"=="ENABLED" FOR /F "TOKENS=1-9 DELIMS=-" %%1 IN ("%BASE_MEAT%") DO (IF "%%4"=="FEATURES" SET "COMP_ABT1=1")
SET "COMP_ABT2="&&IF "%SAFE_EXCLUDE%"=="ENABLED" FOR /F "TOKENS=1-9 DELIMS=-" %%1 IN ("%BASE_MEAT%") DO (IF "%%5"=="REQUIRED" SET "COMP_ABT2=1")
SET "COMP_Z%FNL_XNT%=%BASE_MEAT%~%X2%"&&SET "COMP_ABT3="&&FOR %%1 in (%COMP_SKIP%) DO (IF "%BASE_MEAT%"=="%%1" SET "COMP_ABT3=1")
IF NOT DEFINED COMP_ABT1 IF NOT DEFINED COMP_ABT2 IF NOT DEFINED COMP_ABT3 SET "COMP_ABT="
SET /A "FNL_XNT+=1"&&SET "X0Z=%BASE_MEAT%~%X2%"&&IF NOT DEFINED COMP_FLAG ECHO Removing Subcomp [%#@%%BASE_MEAT%~%X2%%#$%]...&&CALL:PAD_LINE
IF DEFINED COMP_ABT IF "%FNL_XNT%"=="2" SET "COMP_FLAG=1"&&ECHO Component [%##%%BASE_MEAT%%#$%] is required or unable to remove&&CALL:PAD_LINE
IF DEFINED COMP_ABT EXIT /B
IF NOT DEFINED LIVE_APPLY CALL:MOUNT_EXT
REG ADD "%X1%~%X2%" /V "Visibility" /T REG_DWORD /D "1" /F>NUL 2>&1
REG DELETE "%X1%~%X2%\Owners" /F>NUL 2>&1
IF NOT DEFINED LIVE_APPLY CALL:MOUNT_MIX
DISM /ENGLISH /%APPLY_TARGET% %NORESTART%/REMOVE-PACKAGE /PACKAGENAME:"%BASE_MEAT%~%X2%" >"$DISM1"
SET "DISMSG="&&FOR /F "TOKENS=1 DELIMS=." %%1 in ($DISM1) DO (SET "DISMSG="&&IF "%%1"=="The operation completed successfully" CALL SET "DISMSG=%%1")
IF NOT DEFINED DISMSG ECHO Component [%##%%BASE_MEAT%%#$%] is a stub or unable to remove&&CALL:PAD_LINE
IF DEFINED DISMSG ECHO                 [%#@%%DISMSG%%#$%]&&CALL:PAD_LINE
IF EXIST "$DISM1" DEL /F "$DISM1">NUL
EXIT /B
:FEAT_HUNT
CALL:IF_LIVE2
IF "%LIST_ITEM%:%LIST_ACTN%"=="FEATURE:ENABLE" ECHO Enabling Feature [%#@%%BASE_MEAT%%#$%]...&&CALL:PAD_LINE&&DISM /ENGLISH /%APPLY_TARGET% %NORESTART%/ENABLE-FEATURE /FEATURENAME:"%BASE_MEAT%" /ALL>"$DISM1"
IF "%LIST_ITEM%:%LIST_ACTN%"=="FEATURE:ENABLE" SET "DISMSG="&&FOR /F "TOKENS=1 DELIMS=." %%a in ($DISM1) DO (SET "DISMSG="&&IF "%%a"=="The operation completed successfully" CALL SET "DISMSG=%%a"&&CALL ECHO                 [%#@%%%a%#$%]&&CALL:PAD_LINE)
IF "%LIST_ITEM%:%LIST_ACTN%"=="FEATURE:DISABLE" ECHO Disabling Feature [%#@%%BASE_MEAT%%#$%]...&&CALL:PAD_LINE&&DISM /ENGLISH /%APPLY_TARGET% %NORESTART%/DISABLE-FEATURE /FEATURENAME:"%BASE_MEAT%" /REMOVE>"$DISM1"
IF "%LIST_ITEM%:%LIST_ACTN%"=="FEATURE:DISABLE" SET "DISMSG="&&FOR /F "TOKENS=1 DELIMS=." %%a in ($DISM1) DO (SET "DISMSG="&&IF "%%a"=="The operation completed successfully" CALL SET "DISMSG=%%a"&&CALL ECHO                 [%#@%%%a%#$%]&&CALL:PAD_LINE)
IF "%LIST_ITEM%:%LIST_ACTN%"=="FEATURE:ENABLE" IF NOT DEFINED DISMSG CALL ECHO Feature [%##%%BASE_MEAT%%#$%] is a stub or unable to remove&&CALL:PAD_LINE
IF "%LIST_ITEM%:%LIST_ACTN%"=="FEATURE:DISABLE" IF NOT DEFINED DISMSG CALL ECHO Feature [%##%%BASE_MEAT%%#$%] is a stub or unable to remove&&CALL:PAD_LINE
EXIT /B
:SC_CREATE
SET "SCRO=SetupComplete"&&CALL:IF_LIVE1
IF NOT DEFINED SC_PREPARE SET "SPC3="&&SET "SC_PREPARE=1"&&CALL:SC_RO_PREPARE
IF NOT DEFINED BASE_MEAT EXIT /B
CALL:SC_RO_COPY
EXIT /B
:RO_CREATE
SET "SCRO=RunOnce"&&CALL:IF_LIVE1
IF NOT DEFINED RO_PREPARE SET "SPC3=   "&&SET "RO_PREPARE=1"&&CALL:SC_RO_PREPARE
IF NOT DEFINED BASE_MEAT EXIT /B
CALL:SC_RO_COPY
EXIT /B
:SC_RO_COPY
IF "%LIST_ITEM%"=="EXTPACKAGE" ECHO Copying Package [%#@%%BASE_MEAT%%#$%] for %LIST_TIME%...&&CALL:PAD_LINE
IF "%LIST_ITEM%"=="EXTPACKAGE" IF NOT EXIST "%PACK_FOLDER%\%BASE_MEAT%" ECHO [%##%%PACK_FOLDER%\%BASE_MEAT%%#$%] is missing&&CALL:PAD_LINE
IF "%LIST_ITEM%"=="EXTPACKAGE" IF EXIST "%PACK_FOLDER%\%BASE_MEAT%" COPY /Y "%PACK_FOLDER%\%BASE_MEAT%" "%APPLYDIR_MASTER%\$">NUL
IF "%LIST_ITEM%"=="EXTPACKAGE" IF EXIST "%PACK_FOLDER%\%BASE_MEAT%" ECHO [EXTPACKAGE][%BASE_MEAT%][INSTALL][IMAGE-APPLY]>>"%APPLYDIR_MASTER%\$\%SCRO%.LST"
IF NOT "%LIST_ITEM%"=="EXTPACKAGE" ECHO Scheduling %LIST_ITEM% %LIST_ACTN% of [%#@%%BASE_MEAT%%#$%] for %LIST_TIME%...&&CALL:PAD_LINE&&ECHO [%LIST_ITEM%][%BASE_MEAT%][%LIST_ACTN%][IMAGE-APPLY]>>"%APPLYDIR_MASTER%\$\%SCRO%.LST"
EXIT /B
:SC_RO_PREPARE
IF NOT EXIST "%APPLYDIR_MASTER%\$" MD "%APPLYDIR_MASTER%\$">NUL 2>&1
COPY /Y "%PROG_FOLDER%\windick.cmd" "%APPLYDIR_MASTER%\$">NUL 2>&1
IF EXIST "%APPLYDIR_MASTER%\$\%SCRO%.LST" ECHO %SCRO%.LST already exists. %SCRO%.LST replaced.&&CALL:PAD_LINE
ECHO EXEC-LIST>"%APPLYDIR_MASTER%\$\%SCRO%.LST"
IF "%SCRO%"=="RunOnce" Reg.exe add "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\RunOnce" /v "Runonce" /t REG_EXPAND_SZ /d "%%WINDIR%%\Setup\Scripts\RunOnce.cmd" /f>NUL 2>&1
IF NOT EXIST "%WINTAR%\Setup\Scripts" MD "%WINTAR%\Setup\Scripts">NUL 2>&1
ECHO;%%SYSTEMDRIVE%%\$\windick.cmd -imagemgr -runbrute -lst %SCRO%.lst -live>"%WINTAR%\Setup\Scripts\%SCRO%.cmd"
ECHO;EXIT 0 >>"%WINTAR%\Setup\Scripts\%SCRO%.cmd"
CALL ECHO                        %SPC3%%SCRO% Preparation&&CALL:PAD_LINE
EXIT /B
:PACK_INSTALL
ECHO.                         Package Manager Start&&CALL:PAD_LINE
IF NOT EXIST "%IMAGE_PACK%" CALL:PAD_LINE&&ECHO [%##%%IMAGE_PACK%%#$%] is missing&&CALL:PAD_LINE&&GOTO:PACK_INSTALL_FINISH
SET "PACK_GOOD=The operation completed successfully"&&SET "PACK_BAD=The operation did NOT complete successfully"&&CALL:SCRATCH_PACK_CREATE
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=")
FOR %%G in ("%IMAGE_PACK%") DO SET "PackExt=%%~xG"
FOR %%G in (M A B U S C K I P X L) DO (CALL SET "PackExt=%%PackExt:%%G=%%G%%")
IF "%PackExt%"==".APPX" SET "PackType=DRIVER"&&SET "PackName=%IMAGE_PACK%"
IF "%PackExt%"==".CAB" SET "PackType=DRIVER"&&SET "PackName=%IMAGE_PACK%"
IF "%PackExt%"==".MSU" SET "PackType=DRIVER"&&SET "PackName=%IMAGE_PACK%"
IF NOT "%PackExt%"==".PKG" GOTO:PACK_JUMP
DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%IMAGE_PACK%" /INDEX:2 /APPLYDIR:"%SCRATCH_PACK%" >NUL 2>&1
COPY /Y "%SCRATCH_PACK%\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
CALL:PACK_PERM
IF DEFINED PACK_PERM IF NOT DEFINED PACK_PASS ECHO PACK DENIED&&CALL:PAD_LINE&&GOTO:PACK_INSTALL_FINISH
IF "%GET_WIM_INFO%"=="1" GOTO:PACK_INSTALL_FINISH
ECHO Extracting [%#@%%IMAGE_PACK%%#$%]..&&CALL:PAD_LINE
DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%IMAGE_PACK%" /INDEX:1 /APPLYDIR:"%SCRATCH_PACK%">NUL
:PACK_JUMP
IF DEFINED LIVE_APPLY IF "%PackType%"=="DRIVER" CALL:MOUNT_INT
IF DEFINED LIVE_APPLY IF "%PackType%"=="SCRIPTED" CALL:MOUNT_INT
IF NOT DEFINED LIVE_APPLY IF "%PackType%"=="DRIVER" CALL:MOUNT_MIX
IF NOT DEFINED LIVE_APPLY IF "%PackType%"=="SCRIPTED" CALL:MOUNT_EXT
IF NOT DEFINED LIVE_APPLY IF "%PackTag%"=="APPX" CALL:MOUNT_MIX
IF NOT DEFINED LIVE_APPLY IF "%PackTag%"=="DISM" CALL:MOUNT_MIX
ECHO Running [NAME[%#@%%PackName%%#$%] [EXT[%#@%%PackExt%%#$%] [DESC[%#@%%PackDesc%%#$%]&&CALL:PAD_LINE
IF "%PackExt%"==".CAB" EXPAND "%IMAGE_PACK%" -F:* "%SCRATCH_PACK%" >NUL 2>&1
IF "%PackExt%"==".APPX" DISM /ENGLISH /%APPLY_TARGET% /ADD-PROVISIONEDAPPXPACKAGE /PACKAGEPATH:"%IMAGE_PACK%" >"$DRVR"
IF "%PackExt%"==".APPX" CALL:PACK_CHECK
IF "%PackExt%"==".APPX" IF NOT DEFINED DISMSG DISM /ENGLISH /%APPLY_TARGET% /ADD-PROVISIONEDAPPXPACKAGE /PACKAGEPATH:"%IMAGE_PACK%" /SKIPLICENSE>"$DRVR"
IF "%PackExt%"==".APPX" IF NOT DEFINED DISMSG CALL:PACK_CHECK
IF "%PackExt%"==".APPX" IF DEFINED DISMSG CALL ECHO                 [%#@%%PACK_GOOD%%#$%]
IF "%PackExt%"==".APPX" IF NOT DEFINED DISMSG CALL ECHO              [%##%%PACK_BAD%%#$%]
IF "%PackExt%"==".APPX" CALL:PAD_LINE&GOTO:PACK_INSTALL_FINISH
IF "%PackExt%"==".MSU" DISM /ENGLISH /%APPLY_TARGET% /ADD-PACKAGE /PACKAGEPATH:"%IMAGE_PACK%" >"$DRVR"
IF "%PackExt%"==".MSU" CALL:PACK_CHECK
IF "%PackExt%"==".MSU" IF DEFINED DISMSG CALL ECHO                 [%#@%%PACK_GOOD%%#$%]
IF "%PackExt%"==".MSU" IF NOT DEFINED DISMSG CALL ECHO              [%##%%PACK_BAD%%#$%]
IF "%PackExt%"==".MSU" CALL:PAD_LINE&GOTO:PACK_INSTALL_FINISH
IF "%PackType%"=="SCRIPTED" CD /D "%SCRATCH_PACK%"&&CMD /C "%SCRATCH_PACK%\PACKAGE.CMD"
IF "%PackType%"=="SCRIPTED" CD /D "%~DP0"&&ECHO.&&CALL:PAD_LINE
IF "%PackType%"=="DRIVER" FOR /F "TOKENS=*" %%a in ('DIR/S/B "%SCRATCH_PACK%\*.INF"') DO (
IF NOT EXIST "%%a\*" CALL:TITLECARD&&CALL ECHO INF [%#@%%%a%#$%]&&CALL:PAD_LINE
IF NOT EXIST "%%a\*" IF NOT DEFINED LIVE_APPLY DISM /ENGLISH /%APPLY_TARGET% /ADD-DRIVER /DRIVER:"%%a" /ForceUnsigned>"$DRVR"
IF NOT EXIST "%%a\*" IF DEFINED LIVE_APPLY pnputil.exe /add-driver "%%a" /install>"$DRVR"
IF NOT EXIST "%%a\*" SET "DISMSG="&&FOR /F "TOKENS=1 DELIMS=." %%1 in ($DRVR) DO (
IF "%%1"=="Driver package added successfully" CALL SET "DISMSG=1"
IF "%%1"=="%PACK_GOOD%" CALL SET "DISMSG=1")
IF NOT EXIST "%%a\*" IF DEFINED DISMSG CALL ECHO                 [%#@%%PACK_GOOD%%#$%]&&CALL:PAD_LINE
IF NOT EXIST "%%a\*" IF NOT DEFINED DISMSG CALL ECHO              [%##%%PACK_BAD%%#$%]&&CALL:PAD_LINE)
:PACK_INSTALL_FINISH
CALL:MOUNT_INT>NUL 2>&1
FOR %%a in (DRVR PAK) DO (IF EXIST "$%%a" DEL /F "$%%a">NUL)
CALL:SCRATCH_PACK_DELETE&&SET "GET_WIM_INFO="&&ECHO.                          Package Manager End&&CALL:PAD_LINE
EXIT /B
:PACK_CHECK
SET "DISMSG="&&FOR /F "TOKENS=1 DELIMS=." %%1 in ($DRVR) DO (IF "%%1"=="%PACK_GOOD%" CALL SET "DISMSG=1")
EXIT /B
:PACK_PERM
SET "PACK_PERM="
IF NOT "%REG_KEY%"=="NULL" IF NOT "%REG_VAL%"=="NULL" IF NOT "%RUN_MOD%"=="NULL" IF NOT "%REG_DAT%"=="NULL" IF DEFINED REG_KEY IF DEFINED REG_VAL IF DEFINED RUN_MOD IF DEFINED REG_DAT SET "PACK_PERM=1"
IF NOT DEFINED PACK_PERM EXIT /B
IF DEFINED RUN_MOD IF NOT "%RUN_MOD%"=="NULL" IF NOT "%RUN_MOD%"=="EQU" IF NOT "%RUN_MOD%"=="NEQ" EXIT /B
CALL:IF_LIVE1
IF DEFINED PACK_PERM CALL REG QUERY "%REG_KEY%" /v "%REG_VAL%" >"$HZ"
SET "COL1="&&IF DEFINED PACK_PERM IF EXIST "$HZ" FOR /F "TOKENS=* DELIMS=" %%1 in ($HZ) DO (SET "COL1=%%1")
IF DEFINED PACK_PERM IF EXIST "$HZ" DEL /F "$HZ">NUL 2>&1
IF "%RUN_MOD%"=="NULL" SET "RUN_MOD=EQU"
IF NOT DEFINED RUN_MOD SET "RUN_MOD=EQU"
SET "PACK_PASS="&&IF DEFINED PACK_PERM FOR %%a in (REG_SZ REG_DWORD REG_BINARY REG_EXPAND_SZ REG_MULTI_SZ REG_NONE) DO (IF "%COL1%" %RUN_MOD% "    %REG_VAL%    %%a    %REG_DAT%" SET "PACK_PASS=1")
EXIT /B
:DISM_CHOICE
SET "DISM_OPER="&&ECHO.&&ECHO  (%##%1%#$%)RestoreHealth&&ECHO  (%##%2%#$%)Cleanup&&ECHO  (%##%3%#$%)ResetBase&&ECHO  (%##%4%#$%)SPSuperseded&&ECHO  (%##%5%#$%)CheckHealth
ECHO  (%##%6%#$%)AnalyzeComponentStore&&ECHO  (%##%7%#$%)WinRE Remove&&ECHO  (%##%8%#$%)WinSxS Remove&&ECHO.&&SET "PROMPT_SET=DISM_MENU"&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:PROMPT_SET
IF "%DISM_MENU%"=="1" SET "DISM_OPER=RESTOREHEALTH"
IF "%DISM_MENU%"=="2" SET "DISM_OPER=CLEANUP"
IF "%DISM_MENU%"=="3" SET "DISM_OPER=RESETBASE"
IF "%DISM_MENU%"=="4" SET "DISM_OPER=SPSUPERSEDED"
IF "%DISM_MENU%"=="5" SET "DISM_OPER=CHECKHEALTH"
IF "%DISM_MENU%"=="6" SET "DISM_OPER=ANALYZE"
IF "%DISM_MENU%"=="7" SET "DISM_OPER=WINRE"
IF "%DISM_MENU%"=="8" SET "DISM_OPER=WINSXS"
EXIT /B
:IMAGEMGR_DISM_MENU
CLS&&SET "ERR_MSG="&&CALL:PAD_LINE&&ECHO                        DISM Image Maintainence&&CALL:PAD_LINE&&CALL:DISM_CHOICE
IF NOT DEFINED DISM_OPER EXIT /B
SET "MENU_INSERTA= [ %##%@%#$% ]\[%##%Current-Environment%#$%]"&&SET "PICK=VHDX"&&CALL:FILE_PICK
IF NOT "%LIVE_APPLY%"=="1" IF NOT DEFINED $PICK EXIT /B
IF "%LIVE_APPLY%"=="1" IF NOT DEFINED DISCLAIMER CALL:DISCLAIMER&EXIT /B
IF "%LIVE_APPLY%"=="1" SET "APPLY_TARGET=ONLINE"&&GOTO:IMAGEMGR_DISM_OPER_JUMP
IF NOT DEFINED $PICK EXIT /B
IF EXIST "V:\" SET "ERR_MSG=%##%Drive letter V:\ can NOT be in use. Unmount the Vdisk in use.%#$%"&&GOTO:DISM_OPER_CLEANUP
SET "APPLY_TARGET=IMAGE:V:"&&SET "VDISK=%$PICK%"&&CALL:VDISK_ATTACH
IF NOT EXIST "V:\Windows" SET "ERR_MSG=             %##%Vdisk error or Windows not installed on Vdisk.%#$%"&&CALL:VDISK_DETACH&&GOTO:DISM_OPER_CLEANUP
:IMAGEMGR_DISM_OPER_JUMP
CALL:PAD_LINE&&CALL:IMAGEMGR_DISM_OPER
IF NOT DEFINED LIVE_APPLY CALL:VDISK_DETACH
:DISM_OPER_CLEANUP
IF DEFINED ERR_MSG CALL:PAD_LINE&&ECHO %ERR_MSG%&&CALL:PAD_LINE
CALL:SCRATCH_DELETE&&ECHO                         End of DISM-Operations&&CALL:PAD_LINE&&CALL:TITLECARD&&CALL:COLOR_LAY&&CALL:PAUSED
EXIT /B
:IMAGEMGR_DISM_OPER
CALL:IF_LIVE2
IF "%DISM_OPER%"=="RESTOREHEALTH" ECHO                      Executing DISM Restorehealth...&&CALL:PAD_LINE&&DISM /ENGLISH /%APPLY_TARGET% /CLEANUP-IMAGE /Restorehealth
IF "%DISM_OPER%"=="CLEANUP" ECHO                  Executing DISM StartComponentCleanup.....&&CALL:PAD_LINE&&DISM /ENGLISH /%APPLY_TARGET% /CLEANUP-IMAGE /StartComponentCleanup
IF "%DISM_OPER%"=="RESETBASE" ECHO                       Executing DISM ResetBase....&&CALL:PAD_LINE&&DISM /ENGLISH /%APPLY_TARGET% /CLEANUP-IMAGE /StartComponentCleanup /ResetBase
IF "%DISM_OPER%"=="SPSUPERSEDED" ECHO                      Executing DISM SPSuperseded...&&CALL:PAD_LINE&&DISM /ENGLISH /%APPLY_TARGET% /CLEANUP-IMAGE /SPSuperseded
IF "%DISM_OPER%"=="CHECKHEALTH" ECHO                      Executing DISM CheckHealth...&&CALL:PAD_LINE&&DISM /ENGLISH /%APPLY_TARGET% /CLEANUP-IMAGE /CHECKHEALTH
IF "%DISM_OPER%"=="ANALYZE" ECHO                  Executing DISM AnalyzeComponentStore...&&CALL:PAD_LINE&&DISM /ENGLISH /%APPLY_TARGET% /CLEANUP-IMAGE /AnalyzeComponentStore
IF "%DISM_OPER%"=="WINRE" ECHO                    Executing WindowsRecovery Remove...&&CALL:PAD_LINE&&CALL:WINRE_REMOVE
IF "%DISM_OPER%"=="WINSXS" ECHO                        Executing WinSxS Remove...&&CALL:PAD_LINE&&CALL:WINSXS_REMOVE
ECHO.&&CALL:PAD_LINE&&CALL:TITLECARD&&CALL:COLOR_LAY
EXIT /B
:WINRE_REMOVE
ECHO.&&IF NOT EXIST "%WINTAR%\SYSTEM32\Recovery" ECHO %#@%Recovery%#$% folder doesn't exist...
IF EXIST "%WINTAR%\SYSTEM32\Recovery" ECHO Deleting %#@%Recovery%#$% folder...&&RD /Q /S "\\?\%WINTAR%\SYSTEM32\Recovery">NUL 2>&1
EXIT /B
:WINSXS_REMOVE
SET "WinSxS=WinSxS"&&SET "STRINGX=amd64_microsoft-windows-s..cingstack.resources amd64_microsoft-windows-servicingstack amd64_microsoft.vc80.crt amd64_microsoft.vc90.crt amd64_microsoft.windows.c..-controls.resources amd64_microsoft.windows.common-controls amd64_microsoft.windows.gdiplus x86_microsoft.vc80.crt x86_microsoft.vc90.crt x86_microsoft.windows.c..-controls.resources x86_microsoft.windows.common-controls x86_microsoft.windows.gdiplus"
ECHO.&&ECHO Removing %#@%WinSxS%#$% folder...&&DIR "%WINTAR%\%WinSxS%" /A: /B /O:GN>"$XS"&&SET "SUBZ="&&SET "SUBXNT="&&FOR /F "TOKENS=1-2* DELIMS=_" %%a IN ($XS) DO (IF NOT "%%a"=="" SET "QUERYX=%%a_%%b"&&SET "SUBX=%%c"&&SET /A "SUBXNT+=1"&&CALL:LATERS_WINSXS)
FOR %%$ in (NULL) DO (TAKEOWN /F "%WINTAR%\%WinSxS%\%%$" /R /D Y>NUL 2>&1
ICACLS "%WINTAR%\%WinSxS%\%%$" /grant %USERNAME%:F /T>NUL 2>&1
RD /Q /S "\\?\%WINTAR%\%WinSxS%\%%$">NUL 2>&1)
SET "WinSxS="&&DEL /F "$XS">NUL
EXIT /B
:LATERS_WINSXS
IF "%QUERYX%_%SUBX%"=="%SUBZ%" EXIT /B
FOR %%1 in (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20) DO (IF %SUBXNT% EQU %%1500 CALL ECHO WinSxS folder queue item [%##%%%1500%#$%]...
IF "%SUBXNT%"=="%%1000" CALL ECHO WinSxS folder queue item [%##%%%1000%#$%]...)
SET "DNTX="&&FOR %%a in (%STRINGX%) DO (IF "%QUERYX%"=="%%a" SET "DNTX=1")
SET "SUBZ=%QUERYX%_%SUBX%"&&SET "DNTX="&&FOR %%a in (%STRINGX%) DO (IF "%QUERYX%"=="%%a" SET "DNTX=1")
IF NOT DEFINED DNTX (TAKEOWN /F "%WINTAR%\%WinSxS%\%QUERYX%_%SUBX%" /R /D Y>NUL 2>&1
ICACLS "%WINTAR%\%WinSxS%\%QUERYX%_%SUBX%" /grant %USERNAME%:F /T>NUL 2>&1
RD /Q /S "\\?\%WINTAR%\%WinSxS%\%QUERYX%_%SUBX%" >NUL 2>&1) ELSE (ECHO Keeping [%#@%%QUERYX%_%SUBX%%#$%])
EXIT /B
:IMAGEMGR_INSPECT
SET "ERR_MSG="&&SET "REPORT_IMAGE="&&SET "LIVE_APPLY="&&SET "MENU_INSERTA= [ %##%@%#$% ]\[%##%Current-Environment%#$%]"&&SET "NOECHO1=1"&&SET "PICK=VHDX"&&CALL:FILE_PICK
IF NOT "%LIVE_APPLY%"=="1" IF NOT DEFINED $PICK EXIT /B
IF "%LIVE_APPLY%"=="1" IF NOT DEFINED DISCLAIMER CALL:DISCLAIMER&EXIT /B
IF "%LIVE_APPLY%"=="1" SET "REPORT_IMAGE=LIVE"&&GOTO:INSPECT_JUMP_LIVE
IF EXIST "V:\" SET "ERR_MSG=%##%Drive letter V:\ can NOT be in use. Unmount the Vdisk in use.%#$%"&&CALL:PAD_LINE&&ECHO.&&GOTO:INSPECT_CLEANUP
SET "REPORT_IMAGE=%$ELECT$%"&&CALL:SCRATCH_CREATE&&SET "VDISK=%IMAGE_FOLDER%\%$ELECT$%"&&CALL:VDISK_ATTACH&&CALL:MOUNT_EXT
IF NOT EXIST "V:\Windows" SET "ERR_MSG=             %##%Vdisk error or Windows not installed on Vdisk.%#$%"&&CALL:VDISK_DETACH&&GOTO:INSPECT_CLEANUP
:INSPECT_JUMP_LIVE
CALL:PAD_LINE&&ECHO                             Performing scan...&&CALL:PAD_LINE&&CALL:TITLECARD&&CALL:IF_LIVE1
CALL:PAD_WRITE>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
ECHO STARTUP ITEMS REPORT>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
CALL:PAD_WRITE>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
IF EXIST "%APPLYDIR_MASTER%\WINDOWS\Setup\Scripts\SETUPCOMPLETE.CMD" ECHO.SetupComplete.cmd located in \WINDOWS\Setup\Scripts>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
IF NOT EXIST "%APPLYDIR_MASTER%\WINDOWS\Setup\Scripts\SETUPCOMPLETE.CMD" ECHO.No SetupComplete.cmd exists in image>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
IF EXIST "%APPLYDIR_MASTER%\WINDOWS\PANTHER\UNATTEND.XML" ECHO.Unattend.xml located in \WINDOWS\PANTHER>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
IF NOT EXIST "%APPLYDIR_MASTER%\WINDOWS\PANTHER\UNATTEND.XML" ECHO.No Unattend.xml exists in image>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
CALL:PAD_WRITE>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
ECHO Searching: [%HIVE_USER%\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
REG QUERY "%HIVE_USER%\Software\Microsoft\Windows\CurrentVersion\Run">>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT" 2>&1
ECHO Searching: [%HIVE_USER%\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce]>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
REG QUERY "%HIVE_USER%\Software\Microsoft\Windows\CurrentVersion\RunOnce">>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT" 2>&1
ECHO Searching: [%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Run]>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\Run">>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT" 2>&1
ECHO Searching: [%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\RunOnce]>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\RunOnce">>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT" 2>&1
ECHO Searching: [%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\RunOnceEx]>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows\CurrentVersion\RunOnceEx">>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT" 2>&1
ECHO Searching: [%HIVE_SOFTWARE%\Wow6432Node\Microsoft\Windows\CurrentVersion\Run]>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
REG QUERY "%HIVE_SOFTWARE%\Wow6432Node\Microsoft\Windows\CurrentVersion\Run">>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT" 2>&1
ECHO Searching: [%HIVE_SOFTWARE%\Microsoft\Windows NT\CurrentVersion\Winlogon]>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows NT\CurrentVersion\Winlogon" /f Userinit /c /e /s>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT" 2>&1
CALL:MOUNT_INT
IF NOT DEFINED LIVE_APPLY CALL:VDISK_DETACH
CALL:PAD_WRITE>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
ECHO  Inspection Complete [%REPORT_IMAGE%] %DATE% %TIME% >>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
CALL:PAD_WRITE>>"%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
START NOTEPAD.EXE "%PROG_SOURCE%\%REPORT_IMAGE%_REPORT.TXT"
:INSPECT_CLEANUP
IF DEFINED ERR_MSG CALL:PAD_LINE&&ECHO %ERR_MSG%
CALL:SCRATCH_DELETE&&CALL:PAD_LINE&&ECHO                           Inspection Complete&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:PAD_WRITE
IF NOT DEFINED CHCP_TMP FOR /F "TOKENS=2 DELIMS=:" %%a IN ('CHCP') DO SET "CHCP_TMP=%%a"
CHCP 65001 >NUL&&ECHO;■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■&&CHCP %CHCP_TMP% >NUL
EXIT /B
:SCRATCH_CREATE
SET "SCRATCHDIR=%PROG_SOURCE%\Scratch"
IF EXIST "%SCRATCHDIR%" DISM /cleanup-MountPoints>NUL 2>&1
IF EXIST "%SCRATCHDIR%" RD /S /Q "%SCRATCHDIR%">NUL 2>&1
IF NOT EXIST "%SCRATCHDIR%" MD "%SCRATCHDIR%">NUL 2>&1
EXIT /B
:SCRATCH_DELETE
SET "SCRATCHDIR=%PROG_SOURCE%\Scratch"
IF EXIST "%SCRATCHDIR%" DISM /cleanup-MountPoints>NUL 2>&1
IF EXIST "%SCRATCHDIR%" ATTRIB -R -S -H "%SCRATCHDIR%" /S /D /L>NUL 2>&1
IF EXIST "%SCRATCHDIR%" RD /S /Q "%SCRATCHDIR%">NUL 2>&1
EXIT /B
:AIO_DELETE
IF EXIST "%PROG_SOURCE%\ScratchAIO" DISM /cleanup-MountPoints>NUL 2>&1
IF EXIST "%PROG_SOURCE%\ScratchAIO" ATTRIB -R -S -H "%PROG_SOURCE%\ScratchAIO" /S /D /L>NUL 2>&1
IF EXIST "%PROG_SOURCE%\ScratchAIO" RD /S /Q "\\?\%PROG_SOURCE%\ScratchAIO">NUL 2>&1
EXIT /B
:BOOT_IMPORT
IF EXIST "%SOURCE_LOCATION%\boot.wim" ECHO Importing %#@%BOOT.WIM%#$%...&&COPY /Y "%SOURCE_LOCATION%\boot.wim" "%PROG_SOURCE%\boot.sav"&&ECHO 
EXIT /B
:SOURCE_IMPORT
IF EXIST "%SOURCE_LOCATION%\install.wim" ECHO.&&CALL:PAD_LINE&&ECHO                              Name of WIM?&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=NEW_NAME"&&CALL:PROMPT_SET_ANY
IF DEFINED NEW_NAME ECHO Copying %#@%%NEW_NAME%.WIM%#$%...&&COPY /Y "%SOURCE_LOCATION%\install.wim" "%IMAGE_FOLDER%\%NEW_NAME%.WIM"&&SET "NEW_NAME="&&ECHO 
EXIT /B
:MOUNT_INT
IF "%MOUNT%"=="INT" EXIT /B
SET "HIVE_USER=HKCU"&&REG UNLOAD HKU\$ALLUSER>NUL 2>&1
SET "HIVE_SOFTWARE=HKLM\SOFTWARE"&&REG UNLOAD HKLM\$SOFTWARE>NUL 2>&1
SET "HIVE_SYSTEM=HKLM\SYSTEM"&&REG UNLOAD HKLM\$SYSTEM>NUL 2>&1
SET "MOUNT=INT"&&SET "APPLYDIR_MASTER=%SYSTEMDRIVE%"&&SET "CAPTUREDIR_MASTER=%SYSTEMDRIVE%"
SET "APPLY_TARGET=ONLINE"&&SET "DRVTAR=%SYSTEMDRIVE%"&&SET "WINTAR=%WINDIR%"&&SET "USRTAR=%USERPROFILE%"
EXIT /B
:MOUNT_EXT
IF "%MOUNT%"=="EXT" EXIT /B
SET "MOUNT=EXT"&&REG UNLOAD HKU\$ALLUSER>NUL 2>&1
SET "APPLYDIR_MASTER=V:"&&REG UNLOAD HKLM\$SOFTWARE>NUL 2>&1
SET "CAPTUREDIR_MASTER=V:"&&REG UNLOAD HKLM\$SYSTEM>NUL 2>&1
SET "APPLY_TARGET=IMAGE:V:"&&SET "DRVTAR=V:"&&SET "WINTAR=V:\Windows"&&SET "USRTAR=V:\Users\Default"
SET "HIVE_USER=HKU\$ALLUSER"&&REG LOAD HKU\$ALLUSER "V:\Users\Default\Ntuser.dat">NUL 2>&1
SET "HIVE_SOFTWARE=HKLM\$SOFTWARE"&&REG LOAD HKLM\$SOFTWARE "V:\WINDOWS\SYSTEM32\Config\SOFTWARE">NUL 2>&1
SET "HIVE_SYSTEM=HKLM\$SYSTEM"&&REG LOAD HKLM\$SYSTEM "V:\WINDOWS\SYSTEM32\Config\SYSTEM">NUL 2>&1
EXIT /B
:MOUNT_MIX
IF "%MOUNT%"=="MIX" EXIT /B
SET "HIVE_USER=HKCU"&&REG UNLOAD HKU\$ALLUSER>NUL 2>&1
SET "HIVE_SOFTWARE=HKLM\SOFTWARE"&&REG UNLOAD HKLM\$SOFTWARE>NUL 2>&1
SET "HIVE_SYSTEM=HKLM\SYSTEM"&&REG UNLOAD HKLM\$SYSTEM>NUL 2>&1
SET "MOUNT=MIX"&&SET "APPLYDIR_MASTER=V:"&&SET "CAPTUREDIR_MASTER=V:"
SET "APPLY_TARGET=IMAGE:V:"&&SET "DRVTAR=V:"&&SET "WINTAR=V:\Windows"&&SET "USRTAR=V:\Users\Default"
EXIT /B
REM DISKMGR_DISKMGR_DISKMGR_DISKMGR_DISKMGR_DISKMGR_DISKMGR_
:DISKMGR_START
REM DISKMGR_DISKMGR_DISKMGR_DISKMGR_DISKMGR_DISKMGR_DISKMGR_
@ECHO OFF&&CLS&&CALL:SETS_HANDLER&&CALL:COLOR_LAY&&CALL:TITLE_GNC&&CALL:CLEAN&&SET "DISK_LETTER="&&SET "DISK_MSG="&&SET "MENUX="&&SET "ERROR="
CALL:PAD_LINE&&ECHO                             Disk Management&&CALL:PAD_LINE&&CALL:DISK_QUERY&&CALL:PAD_LINE
IF NOT "%BOOT_IMAGE%"=="NONE" ECHO  [%#@%DISK%#$%] (%##%B%#$%)oot (%##%I%#$%)nspect (%##%E%#$%)rase (%##%#%#$%)ChangeUID (%##%U%#$%)SB (%##%*%#$%)NextBoot[%#@%%NEXT_BOOT%%#$%]&&CALL:PAD_LINE
IF "%BOOT_IMAGE%"=="NONE" ECHO  [%#@%DISK%#$%]  (%##%I%#$%)nspect  (%##%E%#$%)rase  (%##%#%#$%)Change UID  (%##%U%#$%)SB (%##%*%#$%)NextBoot[%#@%%NEXT_BOOT%%#$%]&&CALL:PAD_LINE
ECHO  [%#@%PART%#$%]    (%##%C%#$%)reate    (%##%D%#$%)elete    (%##%F%#$%)ormat    (%##%M%#$%)ount/Unmount&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:PROG_MAIN
IF "%SELECT%"=="*" CALL:NEXT_BOOT
IF "%SELECT%"=="U" RunDll32.exe shell32.dll,Control_RunDLL hotplug.dll
IF "%SELECT%"=="M" CALL:LETTER_GET&&CALL:DISKMGR_MOUNT_PROMPT&&SET "SELECT="
FOR %%a in ($ B) DO (IF "%SELECT%"=="%%a" IF NOT "%BOOT_IMAGE%"=="NONE" GOTO:$ETUP_START)
IF "%SELECT%"=="I" CALL:DISK_MENU&&CALL:DISKMGR_INSPECT&&CALL:DISK_PART_END&&SET "SELECT="
IF "%SELECT%"=="E" SET "MENUX=1"&&CALL:DISKMGR_ERASE&&CALL:DISK_PART_END&&SET "SELECT="
IF "%SELECT%"=="C" SET "MENUX=1"&&CALL:DISK_MENU&&CALL:DISKMGR_CREATE&&CALL:DISK_PART_END&&SET "SELECT="
IF "%SELECT%"=="#" SET "MENUX=1"&&CALL:DISK_MENU&&CALL:DISKMGR_CHANGEID&&CALL:DISK_PART_END&&SET "SELECT="
IF "%SELECT%"=="D" SET "MENUX=1"&&CALL:DISK_MENU&&CALL:PART_GET&&CALL:DISKMGR_DELETE&&CALL:DISK_PART_END&&SET "SELECT="
IF "%SELECT%"=="F" SET "MENUX=1"&&CALL:DISK_MENU&&CALL:PART_GET&&CALL:DISKMGR_FORMAT&&CALL:DISK_PART_END&&SET "SELECT="
GOTO:DISKMGR_START
:NEXT_BOOT
IF "%NEXT_BOOT%"=="NULL" SET "BOOT_TARGET=GET"&&CALL:BOOT_TOGGLE&EXIT /B
IF "%NEXT_BOOT%"=="RECOVERY" SET "BOOT_TARGET=VHDX"&&CALL:BOOT_TOGGLE&EXIT /B
IF "%NEXT_BOOT%"=="VHDX" SET "BOOT_TARGET=RECOVERY"&&CALL:BOOT_TOGGLE&EXIT /B
EXIT /B
:DISK_PART_END
IF DEFINED ERROR EXIT /B
IF DEFINED DISK_MSG CALL:PAD_LINE&&ECHO %DISK_MSG%
CALL:PAD_LINE&&ECHO	                      End of Disk-Part Operation&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:LETTER_GET
CALL:PAD_LINE&&ECHO                           Which Drive Letter?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL SET "PROMPT_SET=DISK_LETTER"&&CALL:PROMPT_SET
EXIT /B
:PART_GET
IF DEFINED ERROR EXIT /B
CALL:PAD_LINE&&ECHO                           Which Partition (%##%#%#$%)?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
SET "CHECK=NUM"&&CALL:CHECK&&SET "PART_NUMBER=%SELECT%"
EXIT /B
:PART_CREATE
IF EXIST "U:\" CALL:EFI_UNMOUNT
IF EXIST "S:\" CALL:REASSIGN_LETTER
SET "PART_ERR="&&CALL:DISKMGR_ERASE
(ECHO.select disk %DISK_NUMBER%&&ECHO.create partition EFI size=1500&&ECHO.format quick fs=fat32 label="ESP"&&ECHO.assign letter=U noerr&&ECHO.create partition primary&&ECHO.format quick fs=ntfs&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 2&&ECHO.assign letter=S noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF EXIST "U:\" IF EXIST "S:\" EXIT /B
CALL:DISKMGR_ERASE
(ECHO.select disk %DISK_NUMBER%&&ECHO.create partition primary size=1500&&ECHO.format quick fs=fat32 label="ESP"&&ECHO.create partition primary&&ECHO.format quick fs=ntfs&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.assign letter=U noerr&&ECHO.select partition 2&&ECHO.assign letter=S noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b override&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF EXIST "U:\" IF EXIST "S:\" EXIT /B
SET "PART_ERR=1"&&ECHO             The drive is currently in use, or incompatible.&&ECHO  Malfunctioning disks or those of poor quality also raise this error.
ECHO      Unplug any USB disks and reboot if this continues to occur.&&ECHO                        (%##%X%#$%)Try again (%##%Enter%#$%)Abort&&CALL:PAD_LINE&&CALL SET "PROMPT_SET=CONFIRM"&&CALL:PROMPT_SET
IF "%CONFIRM%"=="X" GOTO:PART_CREATE
EXIT /B
:DISKMGR_ERASE
IF "%MENUX%"=="1" CALL:PAD_LINE&&ECHO                            Which Disk (%##%#%#$%)?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF "%MENUX%"=="1" SET "MENUX="&&SET "CHECK=NUM"&&CALL:CHECK&&SET "DISK_NUMBER=%SELECT%"
IF DEFINED ERROR EXIT /B
IF NOT DEFINED DISK_NUMBER EXIT /B
FOR %%a in (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) DO (IF "%DISK_NUMBER%"=="%%a" CALL SET "GET_DISK_ID=%%DISKID_%%a%%")
(ECHO.select disk %DISK_NUMBER%&&ECHO.clean&&ECHO.convert gpt&&ECHO.select partition 1&&ECHO.delete partition override&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.Assign letter=T noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF EXIST "T:\" (ECHO.select disk %DISK_NUMBER%&&ECHO.clean&&ECHO.convert gpt&&ECHO.select partition 1&&ECHO.delete partition override&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL
CALL:DISKMGR_CHANGEID>NUL 2>&1
IF NOT EXIST "T:\" SET "DISK_MSG=All partitions on Disk %DISK_NUMBER% have been erased."
IF EXIST "T:\" SET "DISK_MSG=%##%Disk %DISK_NUMBER% is currently in use - unplug disk - reboot into Windows - replug and try again.%#$%"
IF EXIST "T:\" (ECHO.select VOLUME T&&ECHO.Remove letter=T noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
EXIT /B
:DISKMGR_INSPECT
IF DEFINED ERROR EXIT /B
IF NOT DEFINED DISK_NUMBER EXIT /B
(ECHO.select disk %DISK_NUMBER%&&ECHO.detail disk&&ECHO.list partition&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK"&&ECHO 
EXIT /B
:DISKMGR_MOUNT_PROMPT
IF NOT DEFINED DISK_LETTER EXIT /B
IF EXIST "%DISK_LETTER%:\" CALL:PAD_LINE&&ECHO  UNMOUNTING [%DISK_LETTER%:\]&&CALL:PAD_LINE&&CALL:DISKMGR_UNMOUNT&EXIT /B
IF NOT EXIST "%DISK_LETTER%:\" CALL:DISK_MENU
IF DEFINED DISK_NUMBER CALL:PART_GET
IF NOT DEFINED ERROR CALL:PAD_LINE&&ECHO  MOUNTING [%DISK_LETTER%:\]&&CALL:PAD_LINE&&CALL:DISKMGR_MOUNT
EXIT /B
:DISKMGR_MOUNT
FOR %%a in (DISK_NUMBER DISK_LETTER PART_NUMBER) DO (IF NOT DEFINED %%a EXIT /B)
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition %PART_NUMBER%&&ECHO.Assign letter=%DISK_LETTER% noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF NOT EXIST "%DISK_LETTER%:\" (ECHO.select disk %DISK_NUMBER%&&ECHO.select partition %PART_NUMBER%&&ECHO.Assign letter=%DISK_LETTER% noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF EXIST "%DISK_LETTER%:\" SET "DISK_MSG=Partition %PART_NUMBER% on Disk %DISK_NUMBER% has been assigned letter %DISK_LETTER%."
IF NOT EXIST "%DISK_LETTER%:\" SET "DISK_MSG=ERROR: Partition %PART_NUMBER% on Disk %DISK_NUMBER% was not assigned letter %DISK_LETTER%."
ECHO 
EXIT /B
:DISKMGR_UNMOUNT
IF NOT DEFINED DISK_LETTER EXIT /B
(ECHO.select VOLUME %DISK_LETTER%&&ECHO.Remove letter=%DISK_LETTER% noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK"&&ECHO 
EXIT /B
:DISKMGR_CREATE
IF DEFINED ERROR EXIT /B
IF NOT DEFINED DISK_NUMBER EXIT /B
IF "%MENUX%"=="1" CALL:PAD_LINE&&ECHO             Enter a partition size. (0) Remainder of space &&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL SET "PROMPT_SET=PART_SIZE"&&CALL:PROMPT_SET
IF "%MENUX%"=="1" SET "MENUX="&&SET "CHECK=NUM"&&SET "SELECT=%PART_SIZE%"&&CALL:CHECK
IF DEFINED ERROR EXIT /B
IF "%PART_SIZE%"=="0" SET "PART_SIZE="
IF NOT DEFINED PART_SIZE (ECHO.select disk %DISK_NUMBER%&&ECHO.create partition primary&&ECHO.format quick fs=ntfs&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK"&&ECHO 
IF DEFINED PART_SIZE (ECHO.select disk %DISK_NUMBER%&&ECHO.create partition primary size=%PART_SIZE%&&ECHO.format quick fs=ntfs&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK"&&ECHO 
EXIT /B
:DISKMGR_DELETE
IF DEFINED ERROR EXIT /B
FOR %%a in (DISK_NUMBER PART_NUMBER) DO (IF NOT DEFINED %%a EXIT /B)
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition %PART_NUMBER%&&ECHO.delete partition override&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK"&&ECHO 
EXIT /B
:DISKMGR_CHANGEID
IF NOT DEFINED DISK_NUMBER EXIT /B
IF "%MENUX%"=="1" SET "MENUX="&&CALL:PAD_LINE&&ECHO                        Enter a new disk-UID (%##%#%#$%) &&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL SET "PROMPT_SET=GET_DISK_ID"&&CALL:PROMPT_SET
SET "UID_XNT="&&FOR /F "DELIMS=" %%G in ('CMD.EXE /D /U /C ECHO %GET_DISK_ID%^| FIND /V ""') do (CALL SET /A "UID_XNT+=1")
IF NOT "%UID_XNT%"=="36" SET "GET_DISK_ID=00000000-0000-0000-0000-000000000000"
(ECHO.select disk %DISK_NUMBER%&&ECHO.uniqueid disk id=%GET_DISK_ID%&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK"&&ECHO 
EXIT /B
:DISKMGR_FORMAT
IF DEFINED ERROR EXIT /B
FOR %%a in (DISK_NUMBER PART_NUMBER) DO (IF NOT DEFINED %%a EXIT /B)
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition %PART_NUMBER%&&ECHO.format quick fs=ntfs override&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK"&&ECHO 
EXIT /B
:DISK_MENU
CLS&&SET "ERROR="&&SET "DISK_CONFLICT="&&SET "DISK_TARGET="&&SET "DISK_NUMBER="&&CALL:PAD_LINE&&ECHO               Windows Deployment Image Customization Kit&&CALL:PAD_LINE&&CALL:DISK_QUERY
CALL:PAD_LINE&&ECHO                            Choose a Disk (%##%#%#$%)&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF "%SELECT%" GTR "9999999" GOTO:DISK_MENU
IF "%SELECT%" LSS "0" SET "ERROR=1"&&EXIT /B
FOR %%a in (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) DO (IF "%SELECT%"=="%%a" CALL SET "DISK_TARGET=%%DISKID_%%a%%"&&CALL SET "DISK_TYPE=%%DISKTYPE_%%a%%")
IF "%DISK_TARGET%"=="%HOME_TARGET%" GOTO:DISK_MENU
IF "%DISK_TARGET%"=="00000000" SET "DISK_CONFLICT=1"
IF "%DISK_TARGET%"=="0000-0000" SET "DISK_CONFLICT=1"
IF DEFINED DISK_CONFLICT CALL:PAD_LINE&&ECHO Erase Disk first&&CALL:PAD_LINE&&CALL:PAUSED
IF DEFINED DISK_CONFLICT GOTO:DISK_MENU
IF "%DISK_TARGET%"=="" GOTO:DISK_MENU
CALL:DISK_QUERY>NUL
IF "%DISK_NUMBER%"=="" GOTO:DISK_MENU
ECHO.%DISK_TARGET%>"%TEMP%\DISK_TARGET"
CALL:PAD_LINE&&ECHO [DISK[%#@%%DISK_NUMBER%%#$%] [UID[%#@%%DISK_TARGET%%#$%] is the target disk&&CALL:PAD_LINE
EXIT /B
:DISK_QUERY
(ECHO.LIST DISK&&ECHO.Exit)>"$DSK1"&&DISKPART /s "$DSK1">"$DSK2"
FOR /F "TOKENS=2,4 SKIP=8 DELIMS= " %%a in ($DSK2) DO ((ECHO.SELECT DISK %%a&&ECHO.DETAIL DISK&&ECHO.Exit)>"$DSK3"&&DISKPART /s "$DSK3">"$DSK4"
IF NOT "%%a"=="DiskPart..." FOR /F "TOKENS=1-5 SKIP=7 DELIMS={}: " %%1 in ($DSK4) DO (IF "%%1"=="Type" IF "%%2"=="File" SET "VSKIP%%a=%%a"))
FOR /F "TOKENS=2,4 SKIP=8 DELIMS= " %%a in ($DSK2) DO (SET "DISK%%a="&&SET "DISKVENDOR_%%a="
IF NOT DEFINED VSKIP%%a (ECHO.select disk %%a&&ECHO.detail disk&&ECHO.list partition&&ECHO.Exit)>"$DSK3"&&DISKPART /s "$DSK3">"$DSK4"&&SET "PAD_SIZE=4"&&CALL:PAD_LINE
IF NOT DEFINED VSKIP%%a IF NOT "%%a"=="DiskPart..." FOR /F "TOKENS=1-9 SKIP=7 DELIMS={}: " %%1 in ($DSK4) DO (
IF NOT DEFINED DISK%%a SET "DISK%%a=%%a"&&ECHO   Disk [%#@%%%a%#$%]
IF NOT DEFINED DISKVENDOR_%%a SET "DISKVENDOR_%%a=%%1 %%2 %%3"&&ECHO  Vendor = %#@%%%1 %%2 %%3%#$%
IF "%%1"=="Type" SET "DISKTYPE_%%a=%%2"&&ECHO   Type  = %#@%%%2%#$%
IF "%%1 %%2"=="Disk ID" SET "DISKID_%%a=%%3"&&ECHO   UID   = %#@%%%3%#$%&&IF "%%3"=="%DISK_TARGET%" SET "DISK_NUMBER=%%a"
IF "%%1 %%2 %%3"=="Pagefile Disk Yes" ECHO %##%*Active Pagefile*%#$%
IF "%%1"=="Partition" IF NOT "%%2"=="###" ECHO P%%2 Size = %#@%%%4 %%5%#$%
IF "%%3"=="S" SET "CURRENT_HOME=%%2"))
SET "PAD_SIZE=4"&&CALL:PAD_LINE&&DEL /Q /F "$DSK*">NUL 2>&1
EXIT /B
:EFI_MOUNT
IF NOT DEFINED DISK_TARGET ECHO DISK ID ERROR&&EXIT /B
IF EXIST "U:\" (ECHO.select VOLUME U&&ECHO.Remove letter=U noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF EXIST "U:\" (ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.Remove letter=U noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.gpt attributes=0x8000000000000000&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.Assign letter=U noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF NOT EXIST "U:\" (ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7 override&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF NOT EXIST "U:\" (ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.Assign letter=U noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
DEL /Q /F "$DSK">NUL 2>&1
EXIT /B
:EFI_UNMOUNT
(ECHO.select VOLUME U&&ECHO.Remove letter=U noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.Remove letter=U noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.gpt attributes=0x4000000000000001&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
DEL /Q /F "$DSK">NUL 2>&1
IF NOT EXIST "U:\" EXIT /B
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7 override&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.gpt attributes=0x8000000000000000&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select VOLUME U&&ECHO.Remove letter=U noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.Remove letter=U noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.set id=c12a7328-f81f-11d2-ba4b-00a0c93ec93b override&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 1&&ECHO.gpt attributes=0x4000000000000001&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
DEL /Q /F "$DSK">NUL 2>&1
EXIT /B
:HOME_AUTO
SET "HOME_MOUNT="&&CLS&&ECHO Querying disks...&&SET /P DISK_TARGET=<"%PROG_FOLDER%\DISK_TARGET"
SET "HOME_TARGET=%DISK_TARGET%"&&IF EXIST "S:\" CALL:REASSIGN_LETTER&&SET /P DISK_TARGET=<"%PROG_FOLDER%\DISK_TARGET"
CALL:DISK_QUERY>NUL 2>&1
IF NOT EXIST "S:\" (ECHO.select disk %DISK_NUMBER%&&ECHO.select partition 2&&ECHO.Assign letter=S noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
DEL /Q /F "$DSK">NUL 2>&1
IF EXIST "S:\" IF NOT EXIST "S:\$" MD "S:\$">NUL 2>&1
IF EXIST "S:\$" IF NOT EXIST "S:\$\windick.cmd" IF EXIST "X:\$\windick.cmd" COPY "X:\$\windick.cmd" "S:\$">NUL 2>&1
IF NOT EXIST "S:\$" IF NOT DEFINED ARBIT_FLAG SET "ARBIT_FLAG=1"&&GOTO:HOME_AUTO
SET "PROG_SOURCE=S:\$"&&SET "PROG_TARGET=S:\$"&&SET "HOME_MOUNT=YES"&&SET "ARBIT_FLAG="&&SET "HOME_NUMBER=%DISK_NUMBER%"
IF EXIST "S:\$" CALL:SETS_LOAD>NUL 2>&1
EXIT /B
:HOME_MANUAL
CALL:DISK_MENU
ECHO %DISK_TARGET%>"%PROG_FOLDER%\DISK_TARGET"
CALL:HOME_AUTO>NUL 2>&1
EXIT /B
:REASSIGN_LETTER
CALL:DISK_QUERY>NUL 2>&1
FOR %%G in (Q P O N M L K J I H G F E D) DO (IF NOT EXIST "%%G:\" SET "NXT_LETTER=%%G")
(ECHO.select VOLUME S&&ECHO.Remove letter=S noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
(ECHO.select VOLUME %CURRENT_HOME%&&ECHO.assign letter=%NXT_LETTER% noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
DEL /Q /F "$DSK">NUL 2>&1
EXIT /B
:BOOT_QUERY
SET "BOOT_OK="&&SET "GUID_TMP="&&SET "GUID_CUR="&&FOR /F "TOKENS=1-5 DELIMS= " %%a in ('BCDEDIT.EXE /V') do (
IF "%%a"=="displayorder" SET "GUID_CUR=%%b"
IF "%%a"=="identifier" SET "GUID_TMP=%%b"
IF "%%a"=="description" IF "%%b"=="WINDICK" SET "BOOT_OK=1"&&GOTO:BOOT_QUERYX)
:BOOT_QUERYX
IF "%GUID_TMP%"=="%GUID_CUR%" SET "NEXT_BOOT=RECOVERY"
IF NOT "%GUID_TMP%"=="%GUID_CUR%" SET "NEXT_BOOT=VHDX"
EXIT /B
:BOOT_TOGGLE
CALL:BOOT_QUERY
IF NOT DEFINED BOOT_OK EXIT /B
IF NOT "%BOOT_TARGET%"=="VHDX" IF NOT "%BOOT_TARGET%"=="RECOVERY" EXIT /B
IF "%BOOT_TARGET%"=="VHDX" SET "NEXT_BOOT=VHDX"&&BCDEDIT.EXE /displayorder %GUID_TMP% /addlast>NUL 2>&1
IF "%BOOT_TARGET%"=="RECOVERY" SET "NEXT_BOOT=RECOVERY"&&BCDEDIT.EXE /displayorder %GUID_TMP% /addfirst>NUL 2>&1
CALL:BOOT_QUERY&&SET "BOOT_TARGET="
EXIT /B
:VDISK_CREATE
CALL:VDISK_DETACH>NUL 2>&1
IF DEFINED NEW_VDISK SET "VHDX_LABEL=%NEW_VDISK%"
IF NOT DEFINED VHDX_MB SET "VHDX_MB=25600"
IF NOT DEFINED VHDX_LABEL SET "VHDX_LABEL=VHDX%VHDX_SLOT%"
IF EXIST "%VDISK%" DEL /Q /F "%VDISK%">NUL 2>&1
(ECHO.create vdisk file="%VDISK%" maximum=%VHDX_MB% type=expandable&&ECHO.Select vdisk file="%VDISK%"&&ECHO.Attach vdisk&&ECHO.create partition primary&&ECHO.select partition 1&&ECHO.format fs=ntfs quick label="%VHDX_LABEL%"&&ECHO.Assign letter=V noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
DEL /F "$DSK">NUL 2>&1
EXIT /B
:VDISK_ATTACH
CALL:VDISK_DETACH>NUL 2>&1
(ECHO.Select vdisk file="%VDISK%"&&ECHO.Attach vdisk&&ECHO.select partition 1&&ECHO.Assign letter=V noerr&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
DEL /F "$DSK">NUL 2>&1
EXIT /B
:VDISK_DETACH
(ECHO.Select vdisk file="%VDISK%"&&ECHO.Detach vdisk&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK">NUL 2>&1
IF EXIST "V:\" CALL:VDISK_BRUTE
DEL /F "$DSK">NUL 2>&1
EXIT /B
:VDISK_BRUTE
(ECHO.List Volume&&ECHO.Exit)>"$DSK1"&&DISKPART /s "$DSK1">"$DSK2"
SET "DISK_TMP="&&FOR /F "TOKENS=1-9 DELIMS= " %%a IN ($DSK2) DO (IF "%%c"=="V" CALL SET "DISK_TMP=%%b")
(ECHO.Select Volume %DISK_TMP%&&ECHO.Detail Volume&&ECHO.Exit)>"$DSK1"&&DISKPART /s "$DSK1">"$DSK2"
SET "DISK_TMP="&&FOR /F "TOKENS=1-9 DELIMS= " %%a IN ($DSK2) DO (
IF "%%a"=="Disk" IF NOT "%%b"=="###" SET "DISK_TMP=%%b"
IF "%%a"=="*" IF "%%b"=="Disk" SET "DISK_TMP=%%c")
(ECHO.List Vdisk&&ECHO.Exit)>"$DSK1"&&DISKPART /s "$DSK1">"$DSK2"
SET "VDISK_TMP="&&FOR /F "TOKENS=1-9* DELIMS= " %%a IN ($DSK2) DO (IF "%%a"=="VDisk" IF "%%d"=="%DISK_TMP%" IF EXIST "%%i" SET "VDISK_TMP=%%i")
CALL:PAD_LINE&&CALL ECHO  Detaching [%VDISK_TMP%]&&CALL:PAD_LINE
(ECHO.Select vdisk file="%VDISK_TMP%"&&ECHO.Detach vdisk&&ECHO.Exit)>"$DSK1"&&DISKPART /s "$DSK1" >NUL 2>&1
DEL /F "$DSK*">NUL 2>&1
EXIT /B
:VDISK_COMPACT
(ECHO.Select vdisk file="%$PICK%"&&ECHO.Attach vdisk readonly&&ECHO.compact vdisk&&ECHO.detach vdisk&&ECHO.Exit)>"$DSK"&&DISKPART /s "$DSK"&&DEL "$DSK">NUL 2>&1
EXIT /B
REM FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_
:FILEMGR_START
REM FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_FILEMGR_
@ECHO OFF&&CLS&&CALL:COLOR_LAY&&CALL:TITLE_GNC&&CALL:PAD_LINE
IF NOT DEFINED FMGR_SOURCE SET "FMGR_SOURCE=%PROG_SOURCE%"&&SET "FMGR_TARGET=%PROG_TARGET%"
IF NOT EXIST "%FMGR_SOURCE%\*" SET "FMGR_SOURCE=%PROG_SOURCE%"&&SET "FMGR_TARGET=%PROG_TARGET%"
ECHO                             File Management&&CALL:PAD_LINE&&ECHO                               SRC (%##%%##%X%#$%) TGT&&CALL:PAD_LINE
IF "%FMGR_DUAL%"=="ENABLED" ECHO   TARGET FOLDER [%#@%%FMGR_TARGET%%#$%]&&SET "BLIST=FMGT"&&CALL:FILE_LIST&&CALL:PAD_LINE
ECHO   SOURCE FOLDER [%#@%%FMGR_SOURCE%%#$%]&&SET "MENU_INSERTA= [%##%FMGS%#$%]\[%##%..%#$%]"&&SET "BLIST=FMGS"&&CALL:FILE_LIST&&CALL:PAD_LINE
ECHO  (%##%E%#$%)xplore (%##%N%#$%)ew (%##%O%#$%)pen (%##%C%#$%)opy (%##%M%#$%)ove (%##%R%#$%)en (%##%D%#$%)el (%##%V%#$%)iew (%##%#%#$%)Own (%##%*%#$%)Sym&&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:PROG_MAIN
IF "%SELECT%"=="X" CALL:FMGR_SWAP
IF "%SELECT%"=="N" CALL:FMGR_NEW&&SET "SELECT="
IF "%SELECT%"=="E" CALL:FMGR_EXPLORE&&SET "SELECT="
IF "%SELECT%"=="C" SET "PICK=FMGS"&&CALL:FILE_PICK&&CALL:FMGR_COPY&&SET "SELECT="
IF "%SELECT%"=="O" SET "PICK=FMGS"&&CALL:FILE_PICK&&CALL:FMGR_OPEN&&SET "SELECT="
IF "%SELECT%"=="M" SET "PICK=FMGS"&&CALL:FILE_PICK&&CALL:FMGR_MOVE&&SET "SELECT="
IF "%SELECT%"=="R" SET "PICK=FMGS"&&CALL:FILE_PICK&&CALL:FMGR_REN&&SET "SELECT="
IF "%SELECT%"=="*" SET "PICK=FMGS"&&CALL:FILE_PICK&&CALL:FMGR_SYM&&SET "SELECT="
IF "%SELECT%"=="#" SET "PICK=FMGS"&&CALL:FILE_PICK&&CALL:FMGR_OWN&&SET "SELECT="
IF "%SELECT%"=="D" SET "PICK=FMGS"&&CALL:FILE_PICK&&CALL:FMGR_DEL&&SET "SELECT="
IF "%SELECT%"=="V" IF "%FMGR_DUAL%"=="DISABLED" SET "FMGR_DUAL=ENABLED"&&SET "SELECT="
IF "%SELECT%"=="V" IF "%FMGR_DUAL%"=="ENABLED" SET "FMGR_DUAL=DISABLED"&&SET "SELECT="
IF "%SELECT%"==".." CALL SET "FMGR_SOURCE=%%FMGR_SOURCE_%FMS#%%%"&&CALL SET /A "FMS#-=1"
GOTO:FILEMGR_START
:FMGR_NEW
CALL:PAD_LINE&&ECHO.                       (%##%1%#$%)Folder      (%##%2%#$%)File&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=NEW_TYPE"&&CALL:PROMPT_SET
IF NOT "%NEW_TYPE%"=="1" IF NOT "%NEW_TYPE%"=="2" EXIT /B
IF "%NEW_TYPE%"=="1" CALL:PAD_LINE&&ECHO.                           New Folder Name?&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=NEW_NAME"&&CALL:PROMPT_SET_ANY
IF "%NEW_TYPE%"=="1" IF NOT DEFINED NEW_NAME EXIT /B
IF "%NEW_TYPE%"=="1" SET "NEW_TYPE="&&MD "%FMGR_SOURCE%\%NEW_NAME%">NUL 2>&1
IF "%NEW_TYPE%"=="2" CALL:PAD_LINE&&ECHO.                            New File Name?&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=NEW_NAME"&&CALL:PROMPT_SET_ANY
IF "%NEW_TYPE%"=="2" IF NOT DEFINED NEW_NAME EXIT /B
IF "%NEW_TYPE%"=="2" SET "NEW_TYPE="&&ECHO.>"%FMGR_SOURCE%\%NEW_NAME%"
EXIT /B
:FMGR_REN
IF NOT DEFINED $PICK EXIT /B
CALL:PAD_LINE&&ECHO.                               New name?&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=NEW_NAME"&&CALL:PROMPT_SET_ANY
IF NOT DEFINED NEW_NAME EXIT /B
CALL:PAD_LINE&&REN "%$PICK%" "%NEW_NAME%"
IF NOT EXIST "%FMGR_SOURCE%\%NEW_NAME%\*" ECHO Renaming [%$PICK%]to[%FMGR_SOURCE%\%NEW_NAME%]
IF EXIST "%FMGR_SOURCE%\%NEW_NAME%\*" ECHO Renaming [%$PICK%]to[%FMGR_SOURCE%\%NEW_NAME%]
CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:FMGR_DEL
IF NOT DEFINED $PICK EXIT /B
CALL:PAD_LINE&&IF NOT EXIST "%$PICK%\*" DEL /Q /F "\\?\%$PICK%"
IF EXIST "%$PICK%\*" RD /S /Q "\\?\%$PICK%"
IF NOT EXIST "%$PICK%\*" IF NOT EXIST "%$PICK%" ECHO Deleted [%$PICK%]..
CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:FMGR_OPEN
IF NOT DEFINED $PICK EXIT /B
IF NOT EXIST "%$PICK%\*" "%$PICK%"&EXIT /B
IF EXIST "%$PICK%\*" CALL SET /A "FMS#+=1"
CALL SET "FMGR_SOURCE_%FMS#%=%FMGR_SOURCE%"&&CALL SET "FMGR_SOURCE=%$PICK%"
EXIT /B
:FMGR_COPY
IF NOT DEFINED $PICK EXIT /B
IF "%FMGR_SOURCE%"=="%FMGR_TARGET%" CALL:FMGR_SAME&EXIT /B
CALL:PAD_LINE&&IF NOT EXIST "%$PICK%\*" ECHO Copying [%#@%%$PICK%%#$%]to[%#@%%FMGR_TARGET%%#$%]...&&XCOPY "%$PICK%" "%FMGR_TARGET%\" /C /Y>NUL 2>&1
IF EXIST "%$PICK%\*" ECHO Copying [%#@%%$PICK%%#$%]to[%#@%%FMGR_TARGET%%#$%]...&&XCOPY "%$PICK%" "%FMGR_TARGET%\%$ELECT$%\" /E /C /I /Y>NUL 2>&1
CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:FMGR_SYM
IF NOT DEFINED $PICK EXIT /B
IF "%FMGR_SOURCE%"=="%FMGR_TARGET%" CALL:FMGR_SAME&EXIT /B
CALL:PAD_LINE&&IF EXIST "%$PICK%\*" MKLINK /J "%FMGR_TARGET%\%$ELECT$%" "%$PICK%"
IF NOT EXIST "%$PICK%\*" MKLINK "%FMGR_TARGET%\%$ELECT$%" "%$PICK%"
CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:FMGR_MOVE
IF NOT DEFINED $PICK EXIT /B
IF "%FMGR_SOURCE%"=="%FMGR_TARGET%" CALL:FMGR_SAME&EXIT /B
CALL:PAD_LINE&&IF NOT EXIST "%$PICK%\*" ECHO Moving [%#@%%$PICK%%#$%]to[%#@%%FMGR_TARGET%%#$%]...&&MOVE /Y "%$PICK%" "%FMGR_TARGET%\">NUL 2>&1
IF EXIST "%$PICK%\*" ECHO Moving [%#@%%$PICK%%#$%]to[%#@%%FMGR_TARGET%%#$%]...&&XCOPY "%$PICK%" "%FMGR_TARGET%\%$ELECT$%\" /E /C /I /Y>NUL 2>&1
IF EXIST "%$PICK%\*" RD /S /Q "\\?\%$PICK%">NUL 2>&1
CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:FMGR_OWN
IF NOT DEFINED $PICK EXIT /B
IF NOT DEFINED NO_PAUSE CALL:PAD_LINE
IF EXIST "%$PICK%\*" TAKEOWN /F "%$PICK%" /R /D Y
IF EXIST "%$PICK%\*" ICACLS "%$PICK%\*" /grant %USERNAME%:F /T >NUL 2>&1
IF NOT EXIST "%$PICK%\*" TAKEOWN /F "%$PICK%"
IF NOT EXIST "%$PICK%\*" ICACLS "%$PICK%" /grant %USERNAME%:F >NUL 2>&1
ECHO.&&IF NOT DEFINED NO_PAUSE CALL:PAD_LINE&&CALL:PAUSED
SET "NO_PAUSE="
EXIT /B
:FMGR_EXPLORE
CALL:PAD_LINE&&ECHO.                             Enter a path&&CALL:PAD_LINE&&ECHO   AVAILABLE DRIVES:&&ECHO.&&FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (IF EXIST "%%G:\" ECHO [%%G:\])
ECHO.&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
SET "SLASHER="&&IF DEFINED SELECT FOR /F "DELIMS=" %%G in ('CMD.EXE /D /U /C ECHO %SELECT%^| FIND /V ""') do (SET "SLASHX=%%G"&&CALL:REMOVE_SLASH)
IF NOT "%SLASHX%"=="\" IF EXIST "%SELECT%\*" SET "FMGR_SOURCE=%SELECT%"
IF "%SLASHX%"=="\" IF EXIST "%SELECT%*" SET "FMGR_SOURCE=%SLASHZ%"
EXIT /B
:REMOVE_SLASH
SET "SLASHZ=%SLASHER%"&&SET "SLASHER=%SLASHER%%SLASHX%"
EXIT /B
:FMGR_SAME
CALL:PAD_LINE&&ECHO                        Source/Target are the same..&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:FMGR_SWAP
IF NOT EXIST "%FMGR_SOURCE%" EXIT /B
IF NOT EXIST "%FMGR_TARGET%" EXIT /B
SET "FMGR_SOURCE=%FMGR_TARGET%"&&SET "FMGR_TARGET=%FMGR_SOURCE%"
EXIT /B
REM $ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP
:$ETUP_START
REM $ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP_$ETUP 
CLS&&CALL:SETS_HANDLER&&CALL:TITLE_GNC&&CALL:COLOR_LAY&&CALL:CLEAN&&SET "BTMP=%WINDIR%\System32\config\ELAM"&&SET "MENUX="&&SET "CAME_FROM="&&CALL:PAD_LINE
ECHO                              Boot Creator&&CALL:PAD_LINE&&ECHO          ~ Erase target disk ^& create native VHDX-Boot disk ~&&CALL:PAD_LINE
IF "%FOLDER_MODE%"=="UNIFIED" ECHO   AVAILABLE VHDX'S:&&SET "BLIST=VHDX"&&CALL:FILE_LIST&&CALL:PAD_LINE
IF "%FOLDER_MODE%"=="UNIFIED" IF "%PROG_MODE%"=="RAMDISK" ECHO                     ~ (%##%R%#$%)ebuild as [%#@%%BCD_SYSTEM%-MODE%#$%] ~&&CALL:PAD_LINE
IF "%FOLDER_MODE%"=="ISOLATED" ECHO   BOOT FOLDER:&&SET "BLIST=BOOT"&&CALL:FILE_LIST&&CALL:PAD_LINE
IF "%FOLDER_MODE%"=="ISOLATED" IF NOT "%PROG_MODE%"=="RAMDISK" ECHO                            (%##%-%#$%)Boot/Image(%##%+%#$%)&&CALL:PAD_LINE
IF "%FOLDER_MODE%"=="ISOLATED" IF "%PROG_MODE%"=="RAMDISK" ECHO     (%##%-%#$%)BOOT/IMAGE(%##%+%#$%)                 ~ (%##%R%#$%)ebuild as [%#@%%BCD_SYSTEM%-MODE%#$%] ~&&CALL:PAD_LINE
IF "%FOLDER_MODE%"=="ISOLATED" ECHO   IMAGE FOLDER:&&SET "BLIST=VHDX"&&CALL:FILE_LIST&&CALL:PAD_LINE
IF "%VHDX_$ETUP%"=="SELECT" ECHO                                  (%##%G%#$%)o^^!      ~ (%##%V%#$%) Choose VHDX %#$%) ~&&CALL:PAD_LINE
IF NOT "%VHDX_$ETUP%"=="SELECT" IF "%BCD_SYSTEM%"=="NAME" ECHO     (%##%M%#$%)ode[%#@%%BCD_SYSTEM%%#$%]                 (%##%G%#$%)o^^!  ~ (%##%V%#$%) Current[%#@%%VHDX_$ETUP%%#$%] ~ &&CALL:PAD_LINE
IF NOT "%VHDX_$ETUP%"=="SELECT" IF "%BCD_SYSTEM%"=="SLOT" ECHO     (%##%M%#$%)ode  (%##%Q%#$%)ty[%#@%%BOOT_BAYS%%#$%]  (%##%S%#$%)lot[%#@%%ACTIVE_BAY%%#$%]  (%##%G%#$%)o^^!  ~ (%##%V%#$%) Current[%#@%%VHDX_$ETUP%%#$%] ~ &&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:DISKMGR_START
IF "%SELECT%"=="S" SET /A "ACTIVE_BAY+=1"&&IF "%ACTIVE_BAY%" EQU "9" SET "ACTIVE_BAY=0"
IF "%SELECT%"=="S" IF "%ACTIVE_BAY%" GTR "%BOOT_BAYS%" SET "ACTIVE_BAY=0"
IF "%SELECT%"=="Q" SET /A "BOOT_BAYS+=1"&&IF "%BOOT_BAYS%" EQU "9" SET "BOOT_BAYS=0"
IF "%SELECT%"=="Q" IF "%BOOT_BAYS%" LSS "%ACTIVE_BAY%" SET "ACTIVE_BAY=%BOOT_BAYS%"
IF "%SELECT%"=="-" IF "%FOLDER_MODE%"=="ISOLATED" SET "MENUX=I2B"&&SET "PICK=VHDX"&&CALL:FILE_PICK
IF "%MENUX%"=="I2B" IF DEFINED $PICK CALL:PAD_LINE&&ECHO  Moving [%#@%%$PICK%%#$%]to[%#@%%PROG_SOURCE%%#$%]...&&CALL:PAD_LINE&&MOVE /Y "%$PICK%" "%PROG_SOURCE%\">NUL
IF "%SELECT%"=="+" IF "%FOLDER_MODE%"=="ISOLATED" SET "MENUX=B2I"&&SET "PICK=BOOT"&&CALL:FILE_PICK
IF "%MENUX%"=="B2I" IF DEFINED $PICK CALL:PAD_LINE&&ECHO  Moving [%#@%%$PICK%%#$%]to[%#@%%IMAGE_FOLDER%%#$%]...&&CALL:PAD_LINE&&MOVE /Y "%$PICK%" "%IMAGE_FOLDER%\">NUL
IF "%SELECT%"=="M" IF NOT "%VHDX_$ETUP%"=="SELECT" IF "%BCD_SYSTEM%"=="SLOT" SET "BCD_SYSTEM=NAME"&&SET "SELECT="
IF "%SELECT%"=="M" IF NOT "%VHDX_$ETUP%"=="SELECT" IF "%BCD_SYSTEM%"=="NAME" SET "BCD_SYSTEM=SLOT"&&SET "SELECT="
IF "%SELECT%"=="R" IF "%PROG_MODE%"=="RAMDISK" IF NOT "%VHDX_$ETUP%"=="SELECT" SET "CAME_FROM=$ETUP"&&CALL:BCD_REBUILD&&CALL:PAUSED
IF "%SELECT%"=="G" IF NOT "%VHDX_$ETUP%"=="SELECT" SET "CAME_FROM=$ETUP"&&CALL:BOOT_MAKER&&CALL:PAUSED
IF "%SELECT%"=="V" SET "MENUX=PVHDX"&&SET "PICK=VHDX"&&CALL:FILE_PICK
IF "%MENUX%"=="PVHDX" SET "VHDX_$ETUP=%$ELECT$%"&&SET "SELECT="
GOTO:$ETUP_START
:BCD_REBUILD
IF "%BCD_SYSTEM%"=="NAME" CALL:PAD_LINE&&ECHO  Rebuilding BCD [%#@%%BCD_SYSTEM%-MODE%#$%] [VHDX[%#@%%VHDX_$ETUP%%#$%]&&CALL:PAD_LINE
IF "%BCD_SYSTEM%"=="SLOT" CALL:PAD_LINE&&ECHO  Rebuilding BCD [%#@%%BCD_SYSTEM%-MODE%#$%] [Qty[%#@%%BOOT_BAYS%%#$%] [VHDX[%#@%%VHDX_$ETUP%%#$%]to[Slot[%#@%%ACTIVE_BAY%%#$%]&&CALL:PAD_LINE
CALL:EFI_MOUNT>NUL 2>&1
CALL:BCD_CREATE>NUL 2>&1
CALL:EFI_UNMOUNT>NUL 2>&1
IF "%BCD_SYSTEM%"=="NAME" IF EXIST "S:\$\%VHDX_$ETUP%" ECHO  [%#@%%VHDX_$ETUP%%#$%] exists in target location [%#@%S:\$%#$%]&&CALL:PAD_LINE
IF "%BCD_SYSTEM%"=="SLOT" IF EXIST "S:\$\%ACTIVE_BAY%.VHDX" ECHO  [%#@%%ACTIVE_BAY%.VHDX%#$%] exists in target location [%#@%S:\$%#$%]&&CALL:PAD_LINE
IF "%BCD_SYSTEM%"=="NAME" IF NOT EXIST "S:\$\%VHDX_$ETUP%" ECHO  Relocating [%#@%%IMAGE_FOLDER%\%VHDX_$ETUP%%#$%]to[%#@%S:\$\%VHDX_$ETUP%%#$%]&&CALL:PAD_LINE&&MOVE /Y "\\?\%IMAGE_FOLDER%\%VHDX_$ETUP%" "S:\$">NUL 2>&1
IF "%BCD_SYSTEM%"=="SLOT" IF NOT EXIST "S:\$\%ACTIVE_BAY%.VHDX" ECHO  Relocating [%#@%%IMAGE_FOLDER%\%VHDX_$ETUP%%#$%]to[%#@%S:\$\%ACTIVE_BAY%.VHDX%#$%]&&CALL:PAD_LINE&&MOVE /Y "\\?\%IMAGE_FOLDER%\%VHDX_$ETUP%" "S:\$\%ACTIVE_BAY%.vhdx">NUL 2>&1
ECHO  Done^^!&&CALL:PAD_LINE
EXIT /B
:BOOT_MAKER
SET "BOOT_MSG="&&SET "DISK_MSG="&&SET "PART_XNT="&&SET "PART_ERR="&&SET "BOOT_ABT="&&SET "BOOT_GO="&&DISM /cleanup-MountPoints>NUL 2>&1
IF NOT "%PROG_MODE%"=="RAMDISK" IF NOT EXIST "S:\" IF NOT EXIST "T:\" IF NOT EXIST "U:\" IF NOT EXIST "V:\" SET "BOOT_GO=1"
IF NOT "%PROG_MODE%"=="RAMDISK" IF NOT DEFINED BOOT_GO SET "BOOT_MSG=%##%Drive letters S:\,T:\,U:\,V:\ can NOT be in use. Reassign/Unmount the letter in use.%#$%"&&GOTO:BOOT_ABT
IF "%CAME_FROM%"=="$ETUP" IF NOT "%VHDX_$ETUP%"=="SELECT" IF NOT EXIST "%IMAGE_FOLDER%\%VHDX_$ETUP%" SET "BOOT_MSG=%##%Source VHDX not selected.%#$%"&&GOTO:BOOT_ABT
IF "%CAME_FROM%"=="$ETUP" CALL:DISK_MENU
IF "%CAME_FROM%"=="$ETUP" IF DEFINED ERROR EXIT /B
CALL:PAD_LINE&&ECHO                           Boot Creator Start&&CALL:PAD_LINE
IF "%PROG_MODE%"=="RAMDISK" SET /P DISK_TARGET=<"%PROG_FOLDER%\DISK_TARGET"&&CALL:DISK_QUERY>NUL 2>&1
IF "%PROG_MODE%"=="RAMDISK" SET "BOOT_IMAGE=U:\$.WIM"&&CALL:EFI_MOUNT>NUL 2>&1
IF "%PROG_MODE%"=="RAMDISK" IF NOT EXIST "%BOOT_IMAGE%" SET "BOOT_MSG=%##%No boot-media detected.%#$%"&&GOTO:BOOT_CLEANUP
COPY /Y "%BOOT_IMAGE%" "%TEMP%\$WIM.TMP">NUL 2>&1
IF "%PROG_MODE%"=="RAMDISK" CALL:EFI_UNMOUNT
IF EXIST "%TEMP%\WINDICK" RD /Q /S "\\?\%TEMP%\WINDICK">NUL 2>&1
IF NOT EXIST "%TEMP%\WINDICK" MD "%TEMP%\WINDICK">NUL 2>&1
SET /P DISK_TARGET=<"%TEMP%\DISK_TARGET"&&CALL:DISK_QUERY>NUL 2>&1
COPY /Y "\\?\%PROG_FOLDER%\windick.cmd" "%TEMP%\WINDICK">NUL 2>&1
ECHO                           Creating partitions...&&CALL:PAD_LINE
IF DEFINED DISK_NUMBER CALL:PART_CREATE
IF DEFINED UID_FAIL SET "DISK_TARGET=%GET_DISK_ID%"&&CALL:DISK_QUERY>NUL 2>&1
ECHO.%DISK_TARGET%>"%TEMP%\WINDICK\DISK_TARGET"
SET "BOOT_MSG0=%##%Disk is currently in use - unplug disk - reboot into Windows - replug and try again.%#$%"
IF DEFINED PART_ERR SET "BOOT_MSG=%BOOT_MSG0%"&&SET "BOOT_ABT=1"
IF NOT EXIST "U:\" SET "BOOT_MSG=%BOOT_MSG0%"&&SET "BOOT_ABT=1"
IF NOT EXIST "S:\" SET "BOOT_MSG=%BOOT_MSG0%"&&SET "BOOT_ABT=1"
IF DEFINED BOOT_ABT GOTO:BOOT_CLEANUP
:BOOT_CREATE
SET "SCRATCH_BOOT=S:\$\Scratch"
IF EXIST "%SCRATCH_BOOT%" RD /S /Q "\\?\%SCRATCH_BOOT%">NUL 2>&1
IF NOT EXIST "%SCRATCH_BOOT%" MD "%SCRATCH_BOOT%">NUL 2>&1
MOVE /Y "%TEMP%\$WIM.TMP" "%SCRATCH_BOOT%\$.WIM">NUL 2>&1
SET "VDISK=%SCRATCH_BOOT%\SCRATCH.VHDX"&&SET "VHDX_MB=20000"&&CALL:VDISK_CREATE>NUL 2>&1
SET "IMAGE_BOOT=%SCRATCH_BOOT%\$.WIM"&&SET "BOOT_X=Setup"&&CALL:BOOT_INDEX>NUL 2>&1
SET "APPLYDIR_BOOT=V:"&&SET "CAPTUREDIR_BOOT=V:"
ECHO                          Extracting boot-media...&&CALL:PAD_LINE&&CALL:TITLECARD
DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%IMAGE_BOOT%" /INDEX:%BOOT_INDEX% /APPLYDIR:"%APPLYDIR_BOOT%"
IF NOT EXIST "%APPLYDIR_BOOT%\Windows" SET "BOOT_MSG=%##%Mount failure, Index %BOOT_INDEX%%#$%" &&GOTO:BOOT_CLEANUP
DEL /Q /F "\\?\%IMAGE_BOOT%">NUL 2>&1
MD "%APPLYDIR_BOOT%\$">NUL 2>&1
COPY /Y "%TEMP%\WINDICK\*.*" "%APPLYDIR_BOOT%\$">NUL 2>&1
MD "U:\EFI\Microsoft\Boot">NUL 2>&1
MD "U:\Boot">NUL 2>&1
MD "U:\EFI\Boot">NUL 2>&1
COPY /Y "%APPLYDIR_BOOT%\Windows\Boot\DVD\EFI\boot.sdi" "U:\Boot">NUL 2>&1
COPY /Y "%APPLYDIR_BOOT%\Windows\Boot\EFI\bootmgfw.efi" "U:\EFI\Boot\bootx64.efi">NUL 2>&1
COPY /Y "%APPLYDIR_BOOT%\Windows\System32\config\ELAM" "%TEMP%\BCD">NUL 2>&1
::ECHO "%%SYSTEMDRIVE%%\$\WINDICK.CMD">"%APPLYDIR_BOOT%\WINDOWS\SYSTEM32\STARTNET.CMD"
(ECHO.[LaunchApp]&&ECHO.AppPath=X:\$\windick.cmd)>"%APPLYDIR_BOOT%\Windows\System32\winpeshl.ini"
IF NOT EXIST "%APPLYDIR_BOOT%\Windows\System32\Setup.dat" DEL /Q /F "\\?\%APPLYDIR_BOOT%\setup.exe">NUL 2>&1
IF NOT EXIST "%APPLYDIR_BOOT%\Windows\Boot\DVD\EFI\boot.sdi" COPY /Y "%WinDir%\Boot\DVD\EFI\boot.sdi" "U:\Boot">NUL 2>&1
IF NOT EXIST "%APPLYDIR_BOOT%\Windows\Boot\EFI\bootmgfw.efi" COPY /Y "%WinDir%\Boot\EFI\bootmgfw.efi" "U:\EFI\Boot\bootx64.efi">NUL 2>&1
IF NOT EXIST "U:\EFI\Boot\bootx64.efi" SET "BOOT_MSG=%##%EFI missing%#$%"&&GOTO:BOOT_CLEANUP
CALL:BCD_CREATE>NUL 2>&1
IF NOT EXIST "U:\EFI\Microsoft\Boot\BCD" SET "BOOT_MSG=%##%BCD missing%#$%"&&GOTO:BOOT_CLEANUP
ECHO.&&CALL:PAD_LINE&&ECHO                            Saving boot-media...&&CALL:PAD_LINE&&CALL:TITLECARD
DISM /ENGLISH /CAPTURE-IMAGE /IMAGEFILE:"U:\$.WIM" /CAPTUREDIR:"%CAPTUREDIR_BOOT%" /NAME:NAME /CheckIntegrity /Verify /Bootable
COPY /Y "%PROG_FOLDER%\settings.pro" "\\?\S:\$">NUL 2>&1
COPY /Y "%PROG_FOLDER%\windick.cmd" "\\?\S:\$">NUL 2>&1
:BOOT_CLEANUP
ECHO.&&CALL:PAD_LINE&&ECHO                             Unmounting EFI...&&CALL:PAD_LINE&&CALL:TITLECARD&&CALL:VDISK_DETACH>NUL 2>&1
CALL:EFI_UNMOUNT
IF EXIST "%TEMP%\$WIM.TMP" DEL /Q /F "\\?\%TEMP%\$WIM.TMP">NUL 2>&1
IF EXIST "%TEMP%\WINDICK" RD /S /Q "\\?\%TEMP%\WINDICK">NUL 2>&1
IF EXIST "$DSK" DEL /Q /F "$DSK">NUL 2>&1
IF EXIST "%TEMP%\DISK_TARGET" DEL /Q /F "%TEMP%\DISK_TARGET">NUL 2>&1
IF EXIST "%SCRATCH_BOOT%" DISM /cleanup-MountPoints>NUL 2>&1
IF EXIST "%SCRATCH_BOOT%" RD /S /Q "\\?\%SCRATCH_BOOT%">NUL 2>&1
IF "%PROG_MODE%"=="RAMDISK" CALL:HOME_AUTO>NUL 2>&1
IF NOT "%PROG_MODE%"=="RAMDISK" CALL:REASSIGN_LETTER>NUL 2>&1
IF EXIST "U:\" ECHO %#@%EFI partition still mounted, unplug disk to dismount EFI partition.%#$%&&CALL:PAD_LINE
IF DEFINED BOOT_ABT GOTO:BOOT_ABT
IF "%PROG_MODE%"=="COMMAND" ECHO Copying %#@%%VHDX_$ETUP%...%#$%&&COPY /Y "\\?\%IMAGE_FOLDER%\%VHDX_$ETUP%" "%NXT_LETTER%:\$">NUL 2>&1
IF "%CAME_FROM%"=="$ETUP" IF "%BCD_SYSTEM%"=="NAME" IF NOT "%VHDX_$ETUP%"=="SELECT" ECHO  Copying %#@%%VHDX_$ETUP%...%#$%&&COPY /Y "\\?\%IMAGE_FOLDER%\%VHDX_$ETUP%" "%NXT_LETTER%:\$">NUL 2>&1
IF "%CAME_FROM%"=="$ETUP" IF "%BCD_SYSTEM%"=="SLOT" IF NOT "%VHDX_$ETUP%"=="SELECT" ECHO  Copying %#@%%VHDX_$ETUP%...%#$%&&COPY /Y "\\?\%IMAGE_FOLDER%\%VHDX_$ETUP%" "%NXT_LETTER%:\$\%ACTIVE_BAY%.vhdx">NUL 2>&1
IF "%CAME_FROM%"=="$ETUP" IF NOT "%VHDX_$ETUP%"=="SELECT" IF NOT EXIST "%NXT_LETTER%:\$\*.VHDX" SET "BOOT_MSG=ERROR Copying VHDX."
:BOOT_ABT
IF DEFINED BOOT_MSG CALL:PAD_LINE&&ECHO %BOOT_MSG%&&SET "BOOT_MSG="
CALL:PAD_LINE&&ECHO                           Boot Creator Finish&&CALL:PAD_LINE&&IF "%CAME_FROM%"=="$ETUP" SET "CAME_FROM="&&ECHO 
EXIT /B
:BOOT_INDEX
SET "BOOT_INDEX="&&SET /A "BOOT_TMP+=1"
DISM /ENGLISH /Get-ImageInfo /ImageFile:"%IMAGE_BOOT%" /Index:%BOOT_TMP%>$DISM
FOR /F "TOKENS=5 SKIP=5 DELIMS=<> " %%a in ($DISM) DO (IF "%%a"=="%BOOT_X%" SET "BOOT_INDEX=%BOOT_TMP%")
IF NOT DEFINED BOOT_INDEX SET "BOOT_INDEX=1"&&IF NOT "%BOOT_TMP%" EQU "4" GOTO:BOOT_INDEX
SET "BOOT_TMP="&&SET "BOOT_X="&&DEL /Q /F "$DISM">NUL 2>&1
EXIT /B
:BCD_CREATE
IF "%CAME_FROM%"=="$ETUP" IF "%VHDX_$ETUP%"=="SELECT" SET "BCD_SYSTEM=SLOT"&&SET "BCD_SYSTEM_TEMP=1"
IF "%PROG_MODE%"=="COMMAND" IF NOT DEFINED BCD_SYSTEM IF DEFINED VHDX_$ETUP SET "BCD_SYSTEM=NAME"&&SET "BCD_SYSTEM_TEMP=1"
IF "%PROG_MODE%"=="COMMAND" IF NOT DEFINED BCD_SYSTEM IF NOT DEFINED VHDX_$ETUP SET "BCD_SYSTEM=SLOT"&&SET "BCD_SYSTEM_TEMP=1"
SET "BCD_KEY=BCD00000001"&&SET "BCD_FILE=%TEMP%\0020"&&IF EXIST "%TEMP%\BCD1" DEL /F "%TEMP%\BCD1">NUL
IF NOT DEFINED BOOT_BAYS SET "BOOT_BAYS=2"&&SET "ACTIVE_BAY=1"
IF NOT DEFINED ACTIVE_BAY SET "BOOT_BAYS=2"&&SET "ACTIVE_BAY=1"
IF "%ACTIVE_BAY%" GTR "%BOOT_BAYS%" SET "ACTIVE_BAY=%BOOT_BAYS%"
DEL /Q /F "%BCD_FILE%">NUL 2>&1
BCDEDIT.EXE /createstore "%BCD_FILE%"
BCDEDIT.EXE /STORE "%BCD_FILE%" /create {bootmgr}
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET {bootmgr} description "Boot Manager"
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET {bootmgr} device boot
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET {bootmgr} timeout 3
FOR /f "TOKENS=2 DELIMS={}" %%a in ('BCDEDIT.EXE /STORE "%BCD_FILE%" /create /device') do SET "RAMDISK={%%a}"
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %RAMDISK% ramdisksdidevice boot
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %RAMDISK% ramdisksdipath \boot\boot.sdi
FOR /f "TOKENS=2 DELIMS={}" %%a in ('BCDEDIT.EXE /STORE "%BCD_FILE%" /create /application osloader') do SET "BCD_GUID={%%a}"
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% systemroot \Windows
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% detecthal Yes
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% winpe Yes
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% osdevice ramdisk=[boot]\$.WIM,%RAMDISK%
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% device ramdisk=[boot]\$.WIM,%RAMDISK%
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% path \windows\system32\winload.efi
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% description "WINDICK"
BCDEDIT.EXE /STORE "%BCD_FILE%" /displayorder %BCD_GUID% /addlast
IF NOT DEFINED DEPLOY_MODE IF "%BCD_SYSTEM%"=="NAME" SET "BCD_XNT="&&CALL:BCD_VHDX
IF NOT DEFINED DEPLOY_MODE IF "%BCD_SYSTEM%"=="SLOT" FOR %%a in (9 8 7 6 5 4 3 2 1 0) DO (IF "%%a" LEQ "%BOOT_BAYS%" CALL SET "BCD_XNT=%%a"&&CALL:BCD_VHDX)
REG UNLOAD HKLM\%BCD_KEY%>NUL 2>&1
REG LOAD HKLM\%BCD_KEY% "%BCD_FILE%">NUL 2>&1
REG EXPORT HKLM\%BCD_KEY% "%TEMP%\BCD1"
REG UNLOAD HKLM\%BCD_KEY%>NUL 2>&1
SET "BCD_FILE=%TEMP%\BCD"
IF NOT EXIST "%BCD_FILE%" COPY /Y "%BTMP%" "%BCD_FILE%">NUL 2>&1
REG LOAD HKLM\%BCD_KEY% "%BCD_FILE%">NUL 2>&1
REG IMPORT "%TEMP%\BCD1" >NUL 2>&1
REG.exe add "HKLM\%BCD_KEY%\Description" /v "KeyName" /t REG_SZ /d "%BCD_KEY%" /f
REG.exe add "HKLM\%BCD_KEY%\Description" /v "System" /t REG_DWORD /d "1" /f
REG.exe add "HKLM\%BCD_KEY%\Description" /v "TreatAsSystem" /t REG_DWORD /d "1" /f
REG.exe delete "HKLM\%BCD_KEY%" /v "FirmwareModified" /f
REG UNLOAD HKLM\%BCD_KEY%>NUL 2>&1
FOR %%a in (COMMAND $ETUP DISKMGR) DO (IF "%CAME_FROM%"=="%%a" COPY /Y "%BCD_FILE%" "U:\EFI\Microsoft\Boot\BCD">NUL 2>&1)
DEL /Q /F "%TEMP%\BCD1"&&DEL /Q /F "%TEMP%\0020"&&DEL /Q /F "%BCD_FILE%"
IF DEFINED BCD_SYSTEM_TEMP SET "BCD_SYSTEM_TEMP="&&SET "BCD_SYSTEM="
EXIT /B
:BCD_VHDX
IF "%BCD_SYSTEM%"=="NAME" SET "BCD_NAME=%VHDX_$ETUP%"
IF "%BCD_SYSTEM%"=="SLOT" SET "BCD_NAME=%BCD_XNT%.vhdx"
FOR /f "TOKENS=3" %%a in ('BCDEDIT.EXE /STORE "%BCD_FILE%" /create /application osloader') do SET "BCD_GUID=%%a"
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% device vhd=[locate]\$\%BCD_NAME%
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% path \Windows\SYSTEM32\winload.efi
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% osdevice vhd=[locate]\$\%BCD_NAME%
BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% systemroot \Windows
IF "%BCD_SYSTEM%"=="NAME" BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% description "%BCD_NAME%"
IF "%BCD_SYSTEM%"=="SLOT" BCDEDIT.EXE /STORE "%BCD_FILE%" /SET %BCD_GUID% description "Slot %BCD_XNT%"
BCDEDIT.EXE /STORE "%BCD_FILE%" /displayorder %BCD_GUID% /addfirst
EXIT /B
REM MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_
:MAKER_START
REM MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_MAKER_
@ECHO OFF&&CLS&&CALL:SETS_HANDLER&&CALL:COLOR_LAY&&CALL:TITLE_GNC&&CALL:SCRATCH_PACK_DELETE&&CALL:PAD_LINE&&ECHO                             Package Creator&&CALL:PAD_LINE
FOR %%a in (PackName PackType PackTag PackDesc REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=NULL")
IF EXIST "%MAKER_FOLDER%\PACKAGE.MAN" COPY /Y "%MAKER_FOLDER%\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
SET "PACK_CHK="&&IF NOT "%REG_KEY%"=="NULL" IF NOT "%REG_VAL%"=="NULL" IF NOT "%RUN_MOD%"=="NULL" IF NOT "%REG_DAT%"=="NULL" SET "PACK_CHK=1"
IF DEFINED PACK_CHK FOR %%a in (REG_KEY REG_VAL RUN_MOD REG_DAT) DO (IF NOT DEFINED %%a SET "PACK_CHK=")
IF "%PACK_CHK%"=="1" (SET "PACK_COND=ENABLED") ELSE (SET "PACK_COND=DISABLED")
IF EXIST "$PAK" DEL /F "$PAK">NUL
IF "%PACK_COND%"=="ENABLED" ECHO  [Name[%#@%%PackName%%#$%] [Type[%#@%%PackType%%#$%] [Tag[%#@%%PackTag%%#$%] [X-Lvl[%#@%%PACK_XLVL%%#$%] [PMT[%#@%%PACK_COND%%#$%]&&CALL:PAD_LINE
IF "%PACK_COND%"=="DISABLED" ECHO  [Name[%#@%%PackName%%#$%] [Type[%#@%%PackType%%#$%] [Tag[%#@%%PackTag%%#$%] [X-Lvl[%#@%%PACK_XLVL%%#$%]&&CALL:PAD_LINE
ECHO  [Desc]: %#@%%PackDesc%%#$%&&CALL:PAD_LINE
IF "%PACK_COND%"=="ENABLED" ECHO  [Permit IF]: [%#@%%REG_KEY% %REG_VAL%%#$%] [%#@%%RUN_MOD%%#$%] [%#@%%REG_DAT%%#$%]&&CALL:PAD_LINE
ECHO   PACKAGE CONTENTS:&&SET "BLIST=MAK"&&CALL:FILE_LIST&&CALL:PAD_LINE
IF "%PackType%"=="NULL" ECHO  (%##%X%#$%)Project[%#@%%MAKER_SLOT%%#$%]  (%##%R%#$%)estore  (%##%N%#$%)ew  (%##%E%#$%)xport-Drivers  (%##%I%#$%)nspect-System&&CALL:PAD_LINE
IF "%PackType%"=="DRIVER" ECHO  (%##%X%#$%)Project[%#@%%MAKER_SLOT%%#$%] (%##%C%#$%)reate (%##%R%#$%)estore (%##%N%#$%)ew (%##%V%#$%)iew (%##%Z%#$%)Lvl (%##%P%#$%)ermit (%##%E%#$%)xport&&CALL:PAD_LINE
IF "%PackType%"=="SCRIPTED" ECHO  (%##%X%#$%)Project[%#@%%MAKER_SLOT%%#$%]  (%##%C%#$%)reate  (%##%R%#$%)estore  (%##%N%#$%)ew  (%##%V%#$%)iew  (%##%Z%#$%)Lvl  (%##%P%#$%)ermit&&CALL:PAD_LINE
IF "%PackType%"=="AIOPACK" ECHO  (%##%X%#$%)Project[%#@%%MAKER_SLOT%%#$%]  (%##%C%#$%)reate  (%##%R%#$%)estore  (%##%N%#$%)ew  (%##%V%#$%)iew  (%##%Z%#$%)Lvl  (%##%P%#$%)ermit&&CALL:PAD_LINE
IF NOT "%PackType%"=="NULL" IF NOT "%PackType%"=="DRIVER" IF NOT "%PackType%"=="SCRIPTED" IF NOT "%PackType%"=="AIOPACK" ECHO  (%##%X%#$%)Project[%MAKER_SLOT%]  [%##%PackType error%#$%] (%##%R%#$%)estore  (%##%N%#$%)ew  (%##%V%#$%)iew&&CALL:PAD_LINE
CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:PROG_MAIN
IF "%SELECT%"=="P" CALL:PACK_COND
IF "%SELECT%"=="Z" CALL:PACK_XLVL
IF "%SELECT%"=="N" SET "PACK_MODE=CREATE"&&CALL:PACKEX_MENU_START&&SET "SELECT="
IF "%SELECT%"=="R" CALL:MAKER_RESTORE_CHOICE&&SET "SELECT="
IF "%SELECT%"=="C" IF NOT "%PackType%"=="NULL" SET "PACK_MODE=CREATE"&&CALL:MAKER_CREATE&&SET "SELECT="
IF "%SELECT%"=="E" IF NOT "%PackType%"=="SCRIPTED" IF NOT "%PackType%"=="AIOPACK" CALL:MAKER_EXPORT&&SET "SELECT="
IF "%SELECT%"=="I" IF NOT "%PackType%"=="SCRIPTED" IF NOT "%PackType%"=="AIOPACK" CALL:MAKER_INSPECT&&SET "SELECT="
IF "%SELECT%"=="V" SET "EDIT_SETUP=1"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_README=1"&&SET "EDIT_LIST=1"&&SET "EDIT_CUSTOM="&&CALL:MAKER_EDITOR
IF "%SELECT%"=="X" SET /A "MAKER_SLOT+=1"&&IF "%MAKER_SLOT%" GEQ "5" SET "MAKER_SLOT=1"
IF "%SELECT%"=="X" SET "MAKER_FOLDER=%PROG_SOURCE%\Project%MAKER_SLOT%"
GOTO:MAKER_START
:MAKER_RESTORE_CHOICE
CLS&&CALL:PAD_LINE&&ECHO %S26%Restore which type&&CALL:PAD_LINE&&ECHO.&&ECHO  (%##%1%#$%)PKG Package [%#@%Driver/Scripted%#$%]&&ECHO  (%##%2%#$%)PKX Package [%#@%AIO Package%#$%]&&ECHO.&&SET "PROMPT_SET=MAKER_RESTORE"&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:PROMPT_SET
IF "%MAKER_RESTORE%"=="1" SET "PICK=PKG"
IF "%MAKER_RESTORE%"=="2" SET "PICK=PKX"
CALL:FILE_PICK&&CALL:MAKER_RESTORE
EXIT /B
:MAKER_INSPECT
CALL:PAD_LINE&&ECHO                          Driver Inspect Start&&CALL:PAD_LINE&&DISM /ENGLISH /ONLINE /GET-DRIVERS&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:MAKER_EXPORT
SET "PackType=DRIVER"&&IF "%PackName%"=="NULL" SET "PackName=DRIVER_%RANDOM%"
IF NOT EXIST "%MAKER_FOLDER%" MD "%MAKER_FOLDER%">NUL 2>&1
CALL:PAD_LINE&&ECHO                        Exporting System Drivers&&CALL:PAD_LINE&&DISM /ENGLISH /ONLINE /EXPORT-DRIVER /destination:"%MAKER_FOLDER%"&&CALL:PACK_MANIFEST
CALL:PAD_LINE&&ECHO                            Driver Export End&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:MAKER_RESTORE
IF NOT DEFINED $PICK EXIT /B
CALL:PAD_LINE&&ECHO                   Project[%#@%%MAKER_SLOT%%#$%] folder will be cleared&&CALL:PAD_LINE&&ECHO.                         Press (%##%X%#$%) to proceed
CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=CONFIRM"&&CALL:PROMPT_SET
IF NOT "%CONFIRM%"=="X" EXIT /B
CALL:PAD_LINE&&ECHO.                          Package Restore Start&&CALL:PAD_LINE&&ECHO.                            Restoring Package
CALL:SCRATCH_PACK_CREATE&&DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%$PICK%" /INDEX:2 /APPLYDIR:"%PROG_SOURCE%\ScratchPack">NUL 2>&1
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=NULL")
IF EXIST "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" COPY /Y "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (IF NOT DEFINED %%a CALL SET "%%a=NULL")
IF EXIST "$PAK" DEL /F "$PAK">NUL
IF NOT EXIST "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" CALL:PAD_LINE&&ECHO Package %##%%PackName%%#$% is defunct.&&CALL:PAD_LINE&&SET "PACK_DEFUNCT=1"&&CALL:PAUSED
IF EXIST "%MAKER_FOLDER%" RD /S /Q "%MAKER_FOLDER%">NUL 2>&1
IF NOT EXIST "%MAKER_FOLDER%" MD "%MAKER_FOLDER%">NUL 2>&1
MOVE /Y "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" "%MAKER_FOLDER%">NUL 2>&1
DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%$PICK%" /INDEX:1 /APPLYDIR:"%MAKER_FOLDER%"
ECHO.&&CALL:PAD_LINE&&ECHO.                          Package Restore End&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:MAKER_CREATE
SET "PACK_FAIL="&&CALL:PAD_LINE&&ECHO.                         Package Create Start&&CALL:PAD_LINE&&ECHO.                           Creating Package&&CALL:SCRATCH_PACK_DELETE
IF NOT EXIST "%MAKER_FOLDER%\*.*" SET "PACK_FAIL=1"&&CALL:PAD_LINE&&ECHO.%#@%Project%MAKER_SLOT% is empty%#$%&&CALL:PAD_LINE&&CALL:PAUSED
IF NOT DEFINED PackName SET "PACK_FAIL=1"&&CALL:PAD_LINE&&ECHO.PackName is Empty&&CALL:PAD_LINE&&CALL:PAUSED
IF NOT DEFINED PackType SET "PACK_FAIL=1"&&CALL:PAD_LINE&&ECHO.PackType is Empty&&CALL:PAD_LINE&&CALL:PAUSED
IF DEFINED PACK_FAIL EXIT /B
CALL:SCRATCH_PACK_CREATE&&MOVE /Y "%MAKER_FOLDER%\PACKAGE.MAN" "%PROG_SOURCE%\ScratchPack">NUL 2>&1
IF "%PackType%"=="AIOPACK" (SET "GX=x") ELSE (SET "GX=g")
DISM /ENGLISH /CAPTURE-IMAGE /CAPTUREDIR:"%MAKER_FOLDER%" /IMAGEFILE:"%PACK_FOLDER%\%PackName%.pk%GX%" /COMPRESS:%PACK_XLVL% /NAME:"%PackName%" /CheckIntegrity /Verify
DISM /ENGLISH /APPEND-IMAGE /IMAGEFILE:"%PACK_FOLDER%\%PackName%.pk%GX%" /CAPTUREDIR:"%PROG_SOURCE%\ScratchPack" /NAME:"%PackName%" /Description:WINDICK /CheckIntegrity /Verify>NUL 2>&1
MOVE /Y "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" "%MAKER_FOLDER%">NUL 2>&1
CALL:SCRATCH_PACK_DELETE&&ECHO.&&CALL:PAD_LINE&&ECHO.                           Package Create End&&CALL:PAD_LINE&&IF NOT "%PACK_MODE%"=="INSTANT" CALL:PAUSED
EXIT /B
:PACK_XLVL
SET /A "PAK_XXX+=1"
IF "%PAK_XXX%" GTR "3" SET "PAK_XXX=1"
IF "%PAK_XXX%"=="1" SET "PACK_XLVL=FAST"
IF "%PAK_XXX%"=="2" SET "PACK_XLVL=MAX"
IF "%PAK_XXX%"=="3" SET "PACK_XLVL=NONE"
EXIT /B
:PACK_COND
CALL ECHO Input REG-KEY&&ECHO (Case sensitive^^!)&&CALL:PROMPT_SET_ANY
CALL SET "REG_KEY=%SELECT%"
IF NOT DEFINED REG_KEY SET "REG_VAL="&&SET "RUN_MOD="&&SET "REG_DAT="&&CALL:PACK_MANIFEST&&EXIT /B
CALL ECHO Input REG-VALUE&&ECHO (Case sensitive^^!)&&CALL:PROMPT_SET_ANY
CALL SET "REG_VAL=%SELECT%"
IF NOT DEFINED REG_VAL EXIT /B
CALL REG QUERY "%REG_KEY%" /V "%REG_VAL%" >"$HZ"
SET "COL1="&&IF EXIST $HZ FOR /F "TOKENS=* DELIMS=" %%1 in ($HZ) DO (SET "COL1=%%1")
CALL ECHO [%COL1%]&&DEL "$HZ">NUL 2>&1
CALL ECHO Input REG-VALUE target data&&ECHO (Case sensitive^^!)&&CALL:PROMPT_SET_ANY
CALL SET "REG_DAT=%SELECT%"
ECHO Permit install if data&&ECHO (%##%1%#$%)Match&&ECHO (%##%2%#$%)Does NOT match&&CALL:MENU_SELECT
IF NOT DEFINED SELECT SET "RUN_MOD=EQU"
IF "%SELECT%"=="1" SET "RUN_MOD=EQU"
IF "%SELECT%"=="2" SET "RUN_MOD=NEQ"
CALL:PACK_MANIFEST
EXIT /B
:MAKER_EDITOR
IF DEFINED EDIT_MANIFEST IF EXIST "%MAKER_FOLDER%\PACKAGE.MAN" START NOTEPAD.EXE "%MAKER_FOLDER%\PACKAGE.MAN"
IF DEFINED EDIT_LIST IF EXIST "%MAKER_FOLDER%\PACKAGE.LST" START NOTEPAD.EXE "%MAKER_FOLDER%\PACKAGE.LST"
IF DEFINED EDIT_SETUP IF EXIST "%MAKER_FOLDER%\PACKAGE.CMD" START NOTEPAD.EXE "%MAKER_FOLDER%\PACKAGE.CMD"
IF DEFINED EDIT_README IF EXIST "%MAKER_FOLDER%\README.TXT" START NOTEPAD.EXE "%MAKER_FOLDER%\README.TXT"
IF DEFINED EDIT_CUSTOM IF EXIST "%MAKER_FOLDER%\%EDIT_CUSTOM%" START NOTEPAD.EXE "%MAKER_FOLDER%\%EDIT_CUSTOM%"
SET "EDIT_SETUP="&&SET "EDIT_MANIFEST="&&SET "EDIT_README="&&SET "EDIT_CUSTOM="&&SET "EDIT_LIST="
EXIT /B
:PAK_LOAD
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=NULL")
IF EXIST "%MAKER_FOLDER%\PACKAGE.MAN" COPY /Y "%MAKER_FOLDER%\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
DEL /Q /F "$PAK">NUL 2>&1
EXIT /B
:PACK_SAVE
MOVE /Y "%MAKER_FOLDER%\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (CALL ECHO %%a=%%%%a%%>>"%MAKER_FOLDER%\PACKAGE.MAN")
DEL /Q /F "$PAK">NUL 2>&1
EXIT /B
:PACK_MANIFEST
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (IF NOT DEFINED %%a CALL SET "%%a=NULL")
(ECHO ----------[Package Manifest]---------=&&ECHO.PackName=%PackName%&&ECHO.PackType=%PackType%&&ECHO.PackDesc=%PackDesc%&&ECHO.PackTag=%PackTag%&&ECHO.REG_KEY=%REG_KEY%&&ECHO.REG_VAL=%REG_VAL%&&ECHO.RUN_MOD=%RUN_MOD%&&ECHO.REG_DAT=%REG_DAT%&&ECHO.Created=%date% %time%&&ECHO ------------[END OF FILE]------------=)>"%MAKER_FOLDER%\PACKAGE.MAN"
EXIT /B
:PACK_STRT
(ECHO.::================================================&&ECHO.::File and registry locations are normal during&&ECHO.::SetupComplete, RunOnce, and Current-Environment.&&ECHO.::During ImageApply they are externally mounted.&&ECHO.::================================================&&ECHO.::These variables are built in and can help&&ECHO.::keep a script consistant throughout the entire&&ECHO.::process, whether applying to a vhdx or live.&&ECHO.::================================================&&ECHO.::Windows folder :    %%WINTAR%%&&ECHO.::Drive root :        %%DRVTAR%%&&ECHO.::User or defuser :   %%USRTAR%%&&ECHO.::HKLM\SOFTWARE :     %%HIVE_SOFTWARE%%&&ECHO.::HKLM\SYSTEM :       %%HIVE_SYSTEM%%&&ECHO.::HKCU\ or defuser :  %%HIVE_USER%%&&ECHO.::================================================&&ECHO.::==================START OF PACK=================&&ECHO.)>"%NEW_PACK%"
EXIT /B
:PACK_END
(ECHO.&&ECHO.::===================END OF PACK==================&&ECHO.::================================================)>>"%NEW_PACK%"
EXIT /B
:PACK_CONFIG
SET "PACK_ENT="&&FOR /F "DELIMS=" %%G in ('CMD.EXE /D /U /C ECHO %PACK_CONFIG%^| FIND /V ""') do (CALL SET /A "PACK_ENT+=1"&&SET "PACK_CFG=%%G"&&CALL:PACK_CONFIG_XNT)
EXIT /B
:PACK_CONFIG_XNT
SET "PACK_ENT_%PACK_ENT%=%PACK_CFG%"
EXIT /B
:PACKEX_MENU_START
FOR %%a in (0 1 2 3 4 5 6 7 8 9) DO (CALL SET "S1%%a=%S10%%%S%%a%%"&&CALL SET "S2%%a=%S10%%S10%%%S%%a%%"&&CALL SET "S3%%a=%S10%%S10%%S10%%%S%%a%%"&&CALL SET "S4%%a=%S10%%S10%%S10%%S10%%%S%%a%%")
@ECHO OFF&&CLS&&CALL:COLOR_LAY&&CALL:TITLE_GNC&&IF "%PACK_MODE%"=="INSTANT" CALL:PAD_LINE&&ECHO %S31%(Tasks)&&CALL:PAD_LINE&&ECHO.&&ECHO  (%##%T01%#$%) Create Local User-Account%S29%(%#@%INSTANT%#$%)&&ECHO  (%##%T02%#$%) Create Local Admin-Account%S28%(%#@%INSTANT%#$%)&&ECHO  (%##%T03%#$%) End Task%S46%(%#@%INSTANT%#$%)&&ECHO  (%##%T04%#$%) Start/Stop Service%S36%(%#@%INSTANT%#$%)&&ECHO  (%##%T05%#$%) List Accounts%S41%(%#@%INSTANT%#$%)&&ECHO  (%##%T06%#$%) FOR-Sight%S45%(%#@%INSTANT%#$%)&&ECHO.&&GOTO:PACKEX_JUMP
CALL:PAD_LINE&&ECHO %S24%(New Package Template)&&CALL:PAD_LINE&&ECHO  (%##%N01%#$%) New Driver Package%S34%(%#@%DRIVER%#$%)&&ECHO  (%##%N02%#$%) New Scripted Package%S32%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N03%#$%) New AIO Package%S37%(%#@%AIOPACK%#$%)&&CALL:PAD_LINE&&ECHO %S26%(Time: ImageApply)&&CALL:PAD_LINE&&ECHO  (%##%N10%#$%) Setup+ Disable Hello%S32%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N11%#$%) Setup+ Unattended Answer-File%S23%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N12%#$%) Setup+ Initial RunOnce/Async Delay Desktop%S10%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N13%#$%) Quicker Preparing Desktop...%S24%(%#@%SCRIPTED%#$%)&&CALL:PAD_LINE&&ECHO %S30%(Any Time)&&CALL:PAD_LINE&&ECHO  (%##%N14%#$%) WinLogon Verbose%S36%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N15%#$%) LSA Strict Rules%S36%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N16%#$%) Local Accounts Only%S33%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N17%#$%) Store Disable%S39%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N18%#$%) OneDrive Disable%S36%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N19%#$%) Cloud Content Disable%S31%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N20%#$%) UAC Prompt Always/Never%S29%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N21%#$%) NotificationCenter Disable%S26%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N22%#$%) Net Discovery Enable/Disable%S24%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N23%#$%) Bluetooth Advertising Enable/Disable%S16%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N24%#$%) Virtualization Based Security Enable/Disable%S8%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N25%#$%) Disable Explorer URL Access%S25%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N26%#$%) Background Apps Disable%S29%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N27%#$%) DCOM Enable/Disable (Breaks Stuff)%S18%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N28%#$%) Prioritize Ethernet%S33%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N29%#$%) Prioritize WiFi%S37%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N30%#$%) Wakelocks General Disable%S27%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N31%#$%) Wakelocks Network Disable%S27%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N32%#$%) VB-Script Execution Disable%S25%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N33%#$%) Feature Updates Threshold%S27%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N34%#$%) Driver Updates Enable/Disable%S23%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N35%#$%) Dark/Light Theme%S36%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N36%#$%) Run Program Every Boot%S30%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N37%#$%) Custom Wallpaper%S36%(%#@%SCRIPTED%#$%)&&CALL:PAD_LINE&&ECHO %S20%(Time: SetupComplete/RunOnce)&&CALL:PAD_LINE&&ECHO  (%##%T01%#$%) Create Local User-Account%S27%(%#@%SCRIPTED%#$%)&&ECHO  (%##%T02%#$%) Create Local Admin-Account%S26%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N40%#$%) Pagefile Disable%S36%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N41%#$%) Import Firewall Rules.XML%S27%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N42%#$%) Taskmgr Prefs%S39%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N43%#$%) Boot Timeout%S40%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N44%#$%) Computer Name%S39%(%#@%SCRIPTED%#$%)&&CALL:PAD_LINE&&ECHO%S33%(Misc)&&CALL:PAD_LINE&&ECHO  (%##%N50%#$%) Pack-Permit Demo%S36%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N51%#$%) MSI Installer Example%S31%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N52%#$%) DISM Special%S40%(%#@%SCRIPTED%#$%)&&ECHO  (%##%N53%#$%) AutoBoot Service install%S28%(%#@%SCRIPTED%#$%)&&ECHO  (%##%DBG%#$%) Debug Pause/Echo ON/Echo OFF%S24%(%#@%SCRIPTED%#$%)
:PACKEX_JUMP
CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT EXIT /B
SET "EXAMPLE=%SELECT%"&&SET "PASS="&&FOR %%a in (T01 T02 T03 T04 T05 T06 N01 N02 N03 N10 N11 N12 N13 N14 N15 N16 N17 N18 N19 N20 N21 N22 N23 N24 N25 N26 N27 N28 N29 N30 N31 N32 N33 N34 N35 N36 N37 N40 N41 N42 N43 N44 N50 N51 N52 N53 DBG) DO (IF "%%a"=="%SELECT%" SET "PASS=1")
IF NOT "%PASS%"=="1" EXIT /B
IF "%PACK_MODE%"=="INSTANT" SET "MAKER_FOLDER=%PROG_SOURCE%\PROJECT_TMP"
IF "%PACK_MODE%"=="CREATE" CALL:PAD_LINE&&ECHO                   Project[%#@%%MAKER_SLOT%%#$%] folder will be cleared&&CALL:PAD_LINE&&ECHO.                         Press (%##%X%#$%) to proceed&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=CONFIRM"&&CALL:PROMPT_SET
IF "%PACK_MODE%"=="CREATE" IF NOT "%CONFIRM%"=="X" EXIT /B
IF EXIST "%MAKER_FOLDER%" RD /S /Q "\\?\%MAKER_FOLDER%">NUL 2>&1
IF NOT EXIST "%MAKER_FOLDER%" MD "%MAKER_FOLDER%">NUL 2>&1
SET "NEW_PACK=%MAKER_FOLDER%\PACKAGE.CMD"&&CALL:SCRATCH_PACK_DELETE&&CALL:MOUNT_INT
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=NULL")
CALL:%EXAMPLE%
CALL:PACK_MANIFEST>NUL 2>&1
IF "%PackType%"=="SCRIPTED" CALL:PACK_END
IF "%PACK_MODE%"=="INSTANT" SET "PackName=%PackName%_TMP"&&SET "PackNameX=%PackName%_TMP"&&CALL:MAKER_CREATE>NUL 2>&1
IF "%PACK_MODE%"=="INSTANT" SET "IMAGE_PACK=%PACK_FOLDER%\%PackName%.PKG"&&CALL:PACK_INSTALL>NUL 2>&1
IF "%PACK_MODE%"=="INSTANT" SET "MAKER_FOLDER=%PROG_SOURCE%\Project%MAKER_SLOT%"&&DEL /Q /F "%PACK_FOLDER%\%PackNameX%.PKG">NUL 2>&1
IF "%PACK_MODE%"=="INSTANT" RD /S /Q "%PROG_SOURCE%\PROJECT_TMP">NUL 2>&1
IF "%PACK_MODE%"=="CREATE" IF DEFINED EXAMPLE CALL:MAKER_EDITOR
IF "%PackType%"=="AIOPACK" IF EXIST "%NEW_PACK%" DEL /F "%NEW_PACK%">NUL 2>&1
IF "%PackType%"=="DRIVER" IF EXIST "%NEW_PACK%" DEL /F "%NEW_PACK%">NUL 2>&1
SET "PACK_MODE="&&SET "SELECT="&&CALL:SCRATCH_PACK_DELETE
EXIT /B
:SCRATCH_PACK_DELETE
SET "SCRATCH_PACK=%PROG_SOURCE%\ScratchPack"&&IF EXIST "%PROG_SOURCE%\ScratchPack" DISM /cleanup-MountPoints>NUL 2>&1
IF EXIST "%PROG_SOURCE%\ScratchPack" ATTRIB -R -S -H "%PROG_SOURCE%\ScratchPack" /S /D /L>NUL 2>&1
IF EXIST "%PROG_SOURCE%\ScratchPack" RD /S /Q "\\?\%PROG_SOURCE%\ScratchPack">NUL 2>&1
EXIT /B
:SCRATCH_PACK_CREATE
SET "SCRATCH_PACK=%PROG_SOURCE%\ScratchPack"&&IF EXIST "%PROG_SOURCE%\ScratchPack" CALL:SCRATCH_PACK_DELETE 
IF NOT EXIST "%PROG_SOURCE%\ScratchPack" MD "%PROG_SOURCE%\ScratchPack">NUL 2>&1
EXIT /B
:TIME_WARN1
ECHO;::Time mandatory: Needs to be applied during ImageApply>>"%NEW_PACK%"
EXIT /B
:TIME_WARN2
ECHO;::Live Command: Needs to be applied during SetupComplete or RunOnce>>"%NEW_PACK%"
EXIT /B
:T01
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Add_User"&&SET "PackDesc=Creates Local User-Account"
ECHO       - Username? -&&ECHO     - Enter username -&&ECHO   - 0-9 A-Z - no spaces -&&SET "PROMPT_SET=NEWUSER"&&CALL:PROMPT_SET_ANY
SET "CHAR_STR=%NEWUSER%"&&SET "CHAR_CHK= "&&CALL:CHAR_CHK
IF "%PACK_MODE%"=="CREATE" CALL:TIME_WARN2
IF DEFINED CHAR_FLG SET "NEWUSER="
IF NOT DEFINED NEWUSER SET "NEWUSER=UserName"
ECHO;Net User %NEWUSER% /add>>"%NEW_PACK%"
ECHO;Net User %NEWUSER% /passwordreq:No>>"%NEW_PACK%"
ECHO;Net User %NEWUSER% /passwordchg:No>>"%NEW_PACK%"
ECHO;Net Accounts /maxpwage:unlimited>>"%NEW_PACK%"
ECHO;WMIC USERACCOUNT WHERE Name="%NEWUSER%" SET PasswordExpires=FALSE>>"%NEW_PACK%"
EXIT /B
:T02
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Add_Admin"&&SET "PackDesc=Creates Local Admin-Account"
ECHO       - Username? -&&ECHO     - Enter username -&&ECHO   - 0-9 A-Z - no spaces -&&SET "PROMPT_SET=NEWUSER"&&CALL:PROMPT_SET_ANY
SET "CHAR_STR=%NEWUSER%"&&SET "CHAR_CHK= "&&CALL:CHAR_CHK
IF "%PACK_MODE%"=="CREATE" CALL:TIME_WARN2
IF DEFINED CHAR_FLG SET "NEWUSER="
IF NOT DEFINED NEWUSER SET "NEWUSER=UserName"
ECHO;Net User %NEWUSER% /add>>"%NEW_PACK%"
ECHO;Net User %NEWUSER% /passwordreq:No>>"%NEW_PACK%"
ECHO;Net User %NEWUSER% /passwordchg:No>>"%NEW_PACK%"
ECHO;Net Accounts /maxpwage:unlimited>>"%NEW_PACK%"
ECHO;Net localgroup Administrators %NEWUSER% /add>>"%NEW_PACK%"
ECHO;WMIC USERACCOUNT WHERE Name="%NEWUSER%" SET PasswordExpires=FALSE>>"%NEW_PACK%"
EXIT /B
:T03
CLS&&ECHO.&&CALL:PAD_LINE&&ECHO                            The Task Reaper&&CALL:PAD_LINE&&TASKLIST /FO LIST>"$TSK"
SET "TSK_XNT="&&FOR /F "TOKENS=1-9 DELIMS=: " %%a in ($TSK) DO (
IF "%%a"=="Image" CALL SET "TSK_NAME=%%c%%d%%e%%f%%g"
IF "%%a"=="PID" CALL SET "TSK_PID=%%b"
IF "%%a"=="Mem" CALL SET "TSK_MEM=%%c"&&CALL:TASK_QUERY)
IF EXIST "$TSK" DEL "$TSK">NUL
CALL:PAD_LINE&&ECHO                            End Which Task(%##%#%#$%)?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
SET "CHECK=NUM"&&CALL:CHECK
IF DEFINED ERROR EXIT /B
CALL TASKKILL /F /IM "%%TSK_XNT_%SELECT%%%"
CALL:PAD_LINE&&CALL:PAUSED
GOTO:PACKEX_TASKMGR_APP
:TASK_QUERY
CALL SET /A "TSK_XNT+=1"
CALL ECHO  [%#@%%TSK_XNT%%#$%] 	[PID[%#@%%TSK_PID%%#$%] 	[%#@%%TSK_NAME%%#$%]   	[MEM[%#@%%TSK_MEM%%#$%] KB&&CALL SET "TSK_XNT_%TSK_XNT%=%TSK_NAME%"
EXIT /B
:T04
CLS&&ECHO.&&CALL:PAD_LINE&&ECHO                           The Service Reaper&&CALL:PAD_LINE
SET "SVC_MODE="&&REG QUERY "%HIVE_SYSTEM%\ControlSet001\Services" /f Type /c /e /s>"$SVC"
SET "SVC_XNT="&&FOR /F "TOKENS=1-9 DELIMS=\ " %%a in ($SVC) DO (
IF "%%a"=="HKEY_LOCAL_MACHINE" IF NOT "%%e"=="" CALL SET "SVC_NAME=%%e%%f%%g%%h%%i"
IF "%%a"=="Type" IF "%%c"=="0x10" CALL:SVC_QUERY
IF "%%a"=="Type" IF "%%c"=="0x20" CALL:SVC_QUERY)
IF EXIST "$SVC" DEL "$SVC">NUL
CALL:PAD_LINE&&ECHO                     (%##%1%#$%)Start Service (%##%2%#$%)Stop Service&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT "%SELECT%"=="1" IF NOT "%SELECT%"=="2"  EXIT /B
IF "%SELECT%"=="1" SET "SVC_MODE=START"
IF "%SELECT%"=="2" SET "SVC_MODE=STOP"
CALL:PAD_LINE&&ECHO                    %SVC_MODE% Which SVC(%##%#%#$%)?&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
SET "CHECK=NUM"&&CALL:CHECK
IF DEFINED ERROR EXIT /B
IF "%SVC_MODE%"=="START" CALL SC START %%SVC_XNT_%SELECT%%%
IF "%SVC_MODE%"=="STOP" CALL SC STOP %%SVC_XNT_%SELECT%%%
SET "SVC_MODE="&&CALL:PAD_LINE&&CALL:PAUSED
GOTO:PACKEX_SVCMGR_APP
:SVC_QUERY
CALL SET /A "SVC_XNT+=1"
FOR /F "TOKENS=1-9 DELIMS= " %%1 in ('SC QUERY %SVC_NAME%') DO (IF "%%1"=="STATE" CALL SET "SVC_STATE=%%4")
CALL ECHO  [%#@%%SVC_XNT%%#$%] 	[State[%#@%%SVC_STATE%%#$%] 	[%#@%%SVC_NAME%%#$%]&&CALL SET SVC_XNT_%SVC_XNT%=%SVC_NAME%
EXIT /B
:T05
CLS&&CALL:PAD_LINE&&ECHO                       User account enumeration&&CALL:PAD_LINE
NET USER>"$USR"
FOR /F "TOKENS=1-9 SKIP=4 DELIMS= " %%a IN ($USR) DO (
IF NOT "%%a"=="The" IF NOT "%%a"=="" NET USER %%a&&CALL:PAD_LINE
IF NOT "%%a"=="The" IF NOT "%%b"=="" NET USER %%b&&CALL:PAD_LINE
IF NOT "%%a"=="The" IF NOT "%%c"=="" NET USER %%c&&CALL:PAD_LINE
IF NOT "%%a"=="The" IF NOT "%%d"=="" NET USER %%d&&CALL:PAD_LINE
IF NOT "%%a"=="The" IF NOT "%%e"=="" NET USER %%e&&CALL:PAD_LINE
IF NOT "%%a"=="The" IF NOT "%%f"=="" NET USER %%f&&CALL:PAD_LINE
IF NOT "%%a"=="The" IF NOT "%%g"=="" NET USER %%g&&CALL:PAD_LINE
IF NOT "%%a"=="The" IF NOT "%%h"=="" NET USER %%h&&CALL:PAD_LINE
IF NOT "%%a"=="The" IF NOT "%%i"=="" NET USER %%i&&CALL:PAD_LINE)
DEL /Q /F "$USR">NUL
ECHO                     End of user account enumeration&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:T06
@ECHO OFF&&CLS&&CALL:PAD_LINE&&ECHO  FOR~SIGHT&&CALL:PAD_LINE
IF NOT DEFINED FOR_SAV SET "FOR_SAV=FRESH"&&SET "CLM_TGT=1"&&SET "CMD_MODE=INT"&&SET "GET_ROW=1"
IF EXIST EXT.CMD SET /P CUR_CMD=<EXT.CMD
IF NOT DEFINED CUR_CMD SET "CUR_CMD=VER"
IF DEFINED CUR_CMD %CUR_CMD% >$FOR
SET "ROW="&&IF EXIST "$FOR" FOR /F "TOKENS=1-9 DELIMS=<>()" %%A IN ($FOR) DO (SET "ARGUE=%%A%%B%%C%%D%%E%%F%%G%%H"&&CALL:ARGUE)
IF EXIST "$FOR" SET "MARK="&&DEL /F $FOR>NUL 2>&1
IF DEFINED FS_Z ECHO  (FOR) %FS_Z%
CALL:PAD_LINE&&ECHO  (T)CLM[%CLM_TGT%] (F)ull  (R)ef          (G)o  (V)iew  (M)ode[%FOR_SAV%]  (Q)uit&&CALL:PAD_LINE
ECHO  (D)ELIMS[%DELIMS%]  (C)MD [%CUR_CMD%]&&CALL:PAD_LINE&&ECHO                  Press (Enter) to reparse FOR results&&CALL:MENU_SELECT
IF "%SELECT%"=="Q" EXIT /B
IF "%SELECT%"=="G" START CMD /C FOR.CMD
IF "%SELECT%"=="V" START NOTEPAD.EXE FOR.CMD
IF "%SELECT%"=="T" IF NOT DEFINED ROW_EXT SET "SELECT="&&SET /A "CLM_TGT+=1"&&IF "%CLM_TGT%"=="9" SET "CLM_TGT=1"
IF "%SELECT%"=="T" IF DEFINED ROW_EXT SET "SELECT="&&SET /A "CLM_TGT+=1"&&IF "%CLM_TGT%"=="20" SET "CLM_TGT=1"
IF "%SELECT%"=="M" IF "%FOR_SAV%"=="FRESH" SET "FOR_SAV=REUSE"&&SET "SELECT="&&GOTO:FOR_SIGHT
IF "%SELECT%"=="M" IF "%FOR_SAV%"=="REUSE" SET "FOR_SAV=FRESH"&&SET "SELECT="&&GOTO:FOR_SIGHT
IF "%SELECT%"=="F" IF NOT DEFINED ROW_EXT SET "ROW_EXT=1"&&SET "SELECT="&&GOTO:FOR_SIGHT
IF "%SELECT%"=="F" IF DEFINED ROW_EXT SET "ROW_EXT="&&SET "SELECT="&&SET "CLM_TGT=1"&&GOTO:FOR_SIGHT
IF "%SELECT%"=="R" IF NOT DEFINED FOR_REF SET "FOR_REF=1"&&SET "SELECT="&&GOTO:FOR_SIGHT
IF "%SELECT%"=="R" IF DEFINED FOR_REF SET "FOR_REF="&&SET "SELECT="&&GOTO:FOR_SIGHT
IF "%SELECT%"=="C" IF NOT EXIST EXT.CMD ECHO;VER.EXE>EXT.CMD
IF "%SELECT%"=="C" SET "SELECT="&&CALL:PAD_LINE&&START NOTEPAD.EXE EXT.CMD&&GOTO:FOR_SIGHT
IF "%SELECT%"=="D" SET "SELECT="&&SET "PROMPT_SET=DELIMS"&&CALL:PROMPT_SET_ANY
IF "%SELECT%" GTR "0" SET "SKIP_XNT=%SELECT%"&&SET "ROW_TGT=%SELECT%"
IF "%SELECT%" GTR "0" SET "MARK=1"&&SET /A "SKIP_XNT-=1"
IF "%SELECT%" GTR "0" CALL SET "SKIPPER=SKIP=%SKIP_XNT%"
IF "%SELECT%"=="1" SET "SKIPPER="
GOTO:FOR_SIGHT
:N01
SET "PackType=DRIVER"&&CALL:PAD_LINE&&ECHO                     - New Driver Pack (PKG) Name -&&CALL:PAD_LINE&&SET "PROMPT_SET=PackName"&&CALL:PROMPT_SET_ANY
IF NOT DEFINED PackName SET PackName=Driver_%RANDOM%
EXIT /B
:N02
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:PAD_LINE&&ECHO                    - New Scripted Pack (PKG) Name -&&CALL:PAD_LINE&&SET "PROMPT_SET=PackName"&&CALL:PROMPT_SET_ANY
IF NOT DEFINED PackName SET PackName=Scripted_%RANDOM%
EXIT /B
:N03
SET "PackType=AIOPACK"&&CALL:PAD_LINE&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO                        - New AIO Pack (PKX) Name -&&CALL:PAD_LINE&&SET "PROMPT_SET=PackName"&&CALL:PROMPT_SET_ANY
IF NOT DEFINED PackName SET PackName=AIOPACK_%RANDOM%
ECHO EXEC-LIST>"%MAKER_FOLDER%\PACKAGE.LST"
ECHO Manually add/copy/paste items or replace the PACKAGE.LST (this) with an existing list.>>"%MAKER_FOLDER%\PACKAGE.LST"
ECHO Copy all listed packages to ADD (APPX/CAB/MSU/PKG) into project folder before package creation.>>"%MAKER_FOLDER%\PACKAGE.LST"
EXIT /B
:N10
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Hello_Disable"&&SET "PackDesc=Disable hello"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN1
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Policies\SYSTEM" /v "EnableFirstLogonAnimation" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
EXIT /B
:N12
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Desktop_Delay_1stBoot"&&SET "PackDesc=Delay explorer until RunOnce"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN1
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Explorer" /v "AsyncRunOnce" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
EXIT /B
:N13
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Quicker_Preparing"&&SET "PackDesc=Shortens time of Preparing..."&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN1
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Policies\SYSTEM" /v "DelayedDesktopSwitchTimeout" /t REG_DWORD /d 0 /f>>"%NEW_PACK%"
EXIT /B
:N14
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=1"&&SET "PACK_CFG_2=0"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO          - WinLogon Full Verbosity -&&ECHO (1)Enable&&ECHO (2)Disable&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=WinLogonVerbose_Enable"&&SET "PackDesc=WinLogonVerbose Enable"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=WinLogonVerbose_Disable"&&SET "PackDesc=WinLogonVerbose Disable"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Policies\SYSTEM" /v "VerboseStatus" /t REG_DWORD /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
EXIT /B
:N15
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=LSA_Strict"&&SET "PackDesc=Strict Ruleset For LSA"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "LimitBlankPasswordUse" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\LSA" /v "LsaCfgFlags " /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "LsaPid" /t REG_DWORD /d "632" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "ProductType" /t REG_DWORD /d "125" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "RunAsPPL" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "SubmitControl" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "disabledomaincreds" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "everyoneincludesanonymous" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "forceguest" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "NoLmHash" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "restrictanonymous" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "restrictanonymoussam" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa" /v "RestrictRemoteSAM" /t REG_SZ /d "O:BAG:BAD:(A;;RC;;;BA)" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Lsa\MSV1_0" /v "allownullsessionfallback" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
EXIT /B
:N16
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Online_Accounts_Disabled"&&SET "PackDesc=Only allow local accounts to login"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Policies\SYSTEM" /v "NoConnectedUser" /t REG_DWORD /d "3" /f>>"%NEW_PACK%"
EXIT /B
:N17
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Store_Disable"&&SET "PackDesc=Disable Store"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_USER%%\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
EXIT /B
:N18
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=OneDrive_Disable"&&SET "PackDesc=Disable OneDrive"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_USER%%\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "SYSTEM.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
ECHO;Reg.exe delete "%%HIVE_SYSTEM%%\ControlSet001\Services\OneSyncSvc" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Services\OneSyncSvc" /v "ImagePath" /t REG_EXPAND_SZ /d "NUL" /f>>"%NEW_PACK%"
EXIT /B
:N19
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Cloud_Disable"&&SET "PackDesc=Disable Cloud-Content"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\CloudContent" /ve /t REG_SZ /d "" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
EXIT /B
:N20
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=111"&&SET "PACK_CFG_2=000"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO     - UAC Prompt -&&ECHO (1)Enable&&ECHO (2)Disable&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=UAC_Prompt_Always_On"&&SET "PackDesc=UAC Always Prompt"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=UAC_Prompt_Always_Off"&&SET "PackDesc=UAC Never Prompt"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Policies\SYSTEM" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Policies\SYSTEM" /v "ConsentPromptBehaviorUser" /t REG_DWORD /d "%PACK_ENT_2%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Policies\SYSTEM" /v "FilterAdministratorToken" /t REG_DWORD /d "%PACK_ENT_3%" /f>>"%NEW_PACK%"
EXIT /B
:N21
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=0"&&SET "PACK_CFG_2=1"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO   - Notification Center -&&ECHO (1)Enable&&ECHO (2)Disable&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=Notification_Center_Enable"&&SET "PackDesc=Enable Notification Center"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=Notification_Center_Diable"&&SET "PackDesc=Disable Notification Center"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_USER%%\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
EXIT /B
:N22
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=1110"&&SET "PACK_CFG_2=0001"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO  - Link-Layer-Topology Discovery Responder Driver -&&ECHO (1)Enable&&ECHO (2)Disable&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=LLT_Enable"&&SET "PackDesc=Enable Link-Layer-Topology Discovery Responder Driver"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=LLT_Disable"&&SET "PackDesc=Disable Link-Layer-Topology Discovery Responder Driver"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\LLTD" /v "EnableRspndr" /t REG_DWORD /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\LLTD" /v "AllowRspndrOnDomain" /t REG_DWORD /d "%PACK_ENT_2%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\LLTD" /v "AllowRspndrOnPublicNet" /t REG_DWORD /d "%PACK_ENT_3%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\LLTD" /v "ProhibitRspndrOnPrivateNet" /t REG_DWORD /d "%PACK_ENT_4%" /f>>"%NEW_PACK%"
EXIT /B
:N23
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=1111"&&SET "PACK_CFG_2=0000"&&ECHO   - Bluetooth Advertising -&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO (1)Enable&&ECHO (2)Disable&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=BT_Visibility_On"&&SET "PackDesc=Enable Bluetooth Advertising"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=BT_Visibility_Off"&&SET "PackDesc=Disable Bluetooth Advertising"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\PolicyManager\current\device\Bluetooth" /v "AllowAdvertising" /t REG_DWORD /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\PolicyManager\current\device\Browser" /v "AllowAddressBarDropdown" /t REG_DWORD /d "%PACK_ENT_2%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\PolicyManager\current\device\SYSTEM" /v "AllowExperimentation" /t REG_DWORD /d "%PACK_ENT_3%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\SmartGlass" /v "BluetoothPolicy" /t REG_DWORD /d "%PACK_ENT_4%" /f>>"%NEW_PACK%"
EXIT /B
:N24
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=110101"&&SET "PACK_CFG_2=000002"&&ECHO  - Virtualization Based Security -&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO (1)Enable&&ECHO (2)Disable&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=VBS_Enable"&&SET "PackDesc=Enable Virtualization Based Security"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=VBS_Disable"&&SET "PackDesc=Disable Virtualization Based Security"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d "%PACK_ENT_2%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\DeviceGuard" /v "Locked" /t REG_DWORD /d "%PACK_ENT_3%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "%PACK_ENT_4%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Locked" /t REG_DWORD /d "%PACK_ENT_5%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\LSA" /v "LsaCfgFlags " /t REG_DWORD /d "%PACK_ENT_6%" /f>>"%NEW_PACK%"
EXIT /B
:N25
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=ExplorerRestrictNet"&&SET "PackDesc=No internet For explorer.exe/driver updates"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_USER%%\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_USER%%\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoOnlineAssist" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
EXIT /B
:N26
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=BackgroundApps_Disable"&&SET "PackDesc=Disable Background Applications"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_USER%%\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
EXIT /B
:N27
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=Y"&&SET "PACK_CFG_2=N"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO         - DCOM -&&ECHO (1)Enable&&ECHO (2)Disable&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=DCOM_Enable"&&SET "PackDesc=Enable DCOM"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=DCOM_Disable"&&SET "PackDesc=Disable DCOM"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Ole" /v "EnableDCOM" /t REG_SZ /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
EXIT /B
:N28
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Prioritize_Ethernet"&&SET "PackDesc=Prioritize Ethernet Traffic"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
ECHO;NETSH interface ipv4 SET interface "Wi-Fi" metric=5 >>"%NEW_PACK%"
ECHO;NETSH interface ipv4 SET interface "Ethernet" metric=10 >>"%NEW_PACK%"
EXIT /B
:N29
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Prioritize_WiFi"&&SET "PackDesc=Prioritize Wi-Fi Traffic"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
ECHO;NETSH interface ipv4 SET interface "Wi-Fi" metric=10 >>"%NEW_PACK%"
ECHO;NETSH interface ipv4 SET interface "Ethernet" metric=5 >>"%NEW_PACK%"
EXIT /B
:N30
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Wake_Disable"&&SET "PackDesc=Disable Wakelocks"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "AcSettingIndex" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "DcSettingIndex" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
EXIT /B
:N31
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Wake_Net_Disable"&&SET "PackDesc=Disable Network Adapter Wakelocks"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Power\PowerSettings\F15576E8-98B7-4186-B944-EAFA664402D9\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "AcSettingIndex" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Power\PowerSettings\F15576E8-98B7-4186-B944-EAFA664402D9\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "DcSettingIndex" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
EXIT /B
:N32
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=VBS_Exec_Disable"&&SET "PackDesc=Disable visual basic script execution"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d "0" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Classes\PROTOCOLS\Handler\vbscript" /v "DISABLED_CLSID" /t REG_SZ /d "{3050F3B2-98B5-11CF-BB82-00AA00BDCE0B}" /f>>"%NEW_PACK%"
EXIT /B
:N33
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Feature_Threshold"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
SET "GET_VER="&&FOR /F "TOKENS=1-9 DELIMS= " %%a IN ('REG QUERY "%HIVE_SOFTWARE%\Microsoft\Windows NT\CurrentVersion" /f "DisplayVersion" /c /e') DO (IF "%%a"=="DisplayVersion" SET "GET_VER=%%c")
IF NOT DEFINED GET_VER SET "GET_VER=22H2"
SET "PackDesc=Stop Updates at Release Threshold %GET_VER%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersion" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersionInfo" /t REG_SZ /d "%GET_VER%" /f>>"%NEW_PACK%"
EXIT /B
:N34
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=10"&&SET "PACK_CFG_2=01"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO - Driver Updates -&&ECHO (1)Enable (2)Disable&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=Driver_Update_Enable"&&SET "PackDesc=Driver Update Enable"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=Driver_Update_Disable"&&SET "PackDesc=Driver Update Disable"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\DriverSearching" /v "DriverUpdateWizardWuSearchEnabled" /t REG_DWORD /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "%PACK_ENT_2%" /f>>"%NEW_PACK%"
EXIT /B
:N35
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PACK_CFG_1=11"&&SET "PACK_CFG_2=00"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO (1)Light (2)Dark&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PACK_CONFIG=%PACK_CFG_1%"&&SET "PackName=Color_Light"&&SET "PackDesc=Use Light Mode"
IF "%SELECT%"=="2" SET "PACK_CONFIG=%PACK_CFG_2%"&&SET "PackName=Color_Dark"&&SET "PackDesc=Use Dark Mode"
CALL:PACK_CONFIG
ECHO;Reg.exe add "%%HIVE_USER%%\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "%PACK_ENT_1%" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_USER%%\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SYSTEMUsesLightTheme" /t REG_DWORD /d "%PACK_ENT_2%" /f>>"%NEW_PACK%"
EXIT /B
:N36
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=UserLogon_Run"&&SET "PackDesc=Run a Program or batch at User Login"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;Reg.exe add "%%HIVE_SOFTWARE%%\Microsoft\Windows\CurrentVersion\Run" /v "RunUser" /t REG_EXPAND_SZ /d "%%PROGRAMDATA%%\USERLOGON.CMD" /f>>"%NEW_PACK%"
ECHO;ECHO;EXPLORER.EXE C:\WINDOWS\SYSTEM32\NOTEPAD.EXE^>"%%PROGRAMDATA%%\USERLOGON.CMD">>"%NEW_PACK%"
EXIT /B
:N37
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Wallpaper"&&SET "PackDesc=Replace stock wallpaper"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO.>"%MAKER_FOLDER%\wallpaper.jpg"
ECHO;::Replace wallpaper.jpg with custom wallpaper before creating pack>>"%NEW_PACK%"
ECHO;TAKEOWN /F "%%WINTAR%%\web\wallpaper\Spotlight\img14.jpg">>"%NEW_PACK%"
ECHO;ICACLS "%%WINTAR%%\web\wallpaper\Spotlight\img14.jpg" /grant %USERNAME%:F>>"%NEW_PACK%"
ECHO;COPY /Y "%%~DP0wallpaper.jpg" "%%WINTAR%%\web\wallpaper\Spotlight\img14.jpg">>"%NEW_PACK%"
ECHO;TAKEOWN /F "%%WINTAR%%\Web\4K\Wallpaper\Windows\img0_1920x1200.jpg">>"%NEW_PACK%"
ECHO;ICACLS "%%WINTAR%%\Web\4K\Wallpaper\Windows\img0_1920x1200.jpg" /grant %USERNAME%:F>>"%NEW_PACK%"
ECHO;COPY /Y "%%~DP0wallpaper.jpg" "%%WINTAR%%\web\4K\Wallpaper\Windows\img0_1920x1200.jpg">>"%NEW_PACK%"
ECHO;TAKEOWN /F "%%WINTAR%%\web\wallpaper\Windows\img0.jpg">>"%NEW_PACK%"
ECHO;ICACLS "%%WINTAR%%\web\wallpaper\Windows\img0.jpg" /grant %USERNAME%:F>>"%NEW_PACK%"
ECHO;COPY /Y "%%~DP0wallpaper.jpg" "%%WINTAR%%\web\wallpaper\Windows\img0.jpg">>"%NEW_PACK%"
EXIT /B
:N40
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Pagefile_Disable"&&SET "PackDesc=Disable Pagefile"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "" /f>>"%NEW_PACK%"
ECHO;Reg.exe add "%%HIVE_SYSTEM%%\ControlSet001\Control\Session Manager\Memory Management" /v "ExistingPageFiles" /t REG_MULTI_SZ /d "" /f>>"%NEW_PACK%"
ECHO;powercfg.exe -h off>>"%NEW_PACK%"
ECHO;wmic computersystem where name="%%computername%%" set AutomaticManagedPagefile=False>>"%NEW_PACK%"
FOR %%a in (C D E F G H) DO (ECHO;wmic pagefileset where name="%%a:\\pagefile.sys" delete>>"%NEW_PACK%")
EXIT /B
:N41
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Firewall_Import"&&SET "PackDesc=Import Windows Firewall.XML"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
NETSH advfirewall EXPORT "%MAKER_FOLDER%\FirewallPolicy.wfw"
ECHO;NETSH advfirewall IMPORT "FirewallPolicy.wfw">>"%NEW_PACK%"
EXIT /B
:N42
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=TaskManager_Prefs"&&SET "PackDesc=TaskManager Prefs"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
Reg.exe EXPORT "%HIVE_USER%\Software\Microsoft\Windows\CurrentVersion\TaskManager" "%MAKER_FOLDER%\TASKMGR_PREF.REG"
ECHO;Reg.exe IMPORT TASK_PREF.REG>>"%NEW_PACK%"
EXIT /B
:N43
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Boot_Timeout"&&SET "PackDesc=Change Boot Timeout"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
ECHO   - Enter boot timeout in seconds -&&SET "PROMPT_SET=BOOT_TIMEOUT"&&CALL:PROMPT_SET
IF NOT DEFINED BOOT_TIMEOUT SET "BOOT_TIMEOUT=5"
ECHO;BCDEDIT /TIMEOUT %BOOT_TIMEOUT% >>"%NEW_PACK%"
EXIT /B
:N44
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=PC_Name"&&SET "PackDesc=Renames the PC"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
ECHO       - Computer Name? -&&ECHO     - ENTER NAME -&&ECHO   - 0-9 A-Z - NO SPACES -&&SET "PROMPT_SET=PC_NAME"&&CALL:PROMPT_SET_ANY
SET "CHAR_STR=%PC_NAME%"&&SET "CHAR_CHK= "&&CALL:CHAR_CHK
IF DEFINED CHAR_FLG SET "PC_NAME="
IF NOT DEFINED PC_NAME SET "PC_NAME=Computer"
ECHO;WMIC COMPUTERSYSTEM WHERE Name="Present Name" CALL RENAME Name="%PC_NAME%">>"%NEW_PACK%"
EXIT /B
:N50
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=PACK_PERMIT_DEMO"&&SET "PackDesc=PACK PERMIT DEMO"&&SET "REG_KEY=%%HIVE_USER%%\TEST_KEY"&&SET "REG_VAL=TEST_VAL"&&SET "RUN_MOD=EQU"&&SET "REG_DAT=1"
CALL:PAD_LINE&&ECHO Close Regedit if already open. Press enter, Regedit will reopen @ KEY:HKCU\TEST_KEY.
CALL:PAD_LINE&&ECHO.                         Press (X) to proceed&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=CONFIRM"&&CALL:PROMPT_SET
IF "%CONFIRM%"=="X" Reg.exe add "%HIVE_USER%\TEST_KEY" /v "TEST_VAL" /t REG_SZ /d "1" /f>NUL 2>&1
IF "%CONFIRM%"=="X" Reg.exe add "%HIVE_USER%\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /t REG_SZ /d "Computer\%HIVE_USER%\TEST_KEY" /f>NUL 2>&1
IF "%CONFIRM%"=="X" START REGEDIT.EXE
ECHO   Change or delete TEST_VAL DATA(1), the pack is denied and test key remains.
ECHO     Leave TEST_VAL DATA(1), pack is permitted and test key will be deleted.
ECHO       Next, press (C) to create the pack and put in a package list to test.
IF "%CONFIRM%"=="X" CALL:PAUSED
ECHO;@ECHO OFF>>"%NEW_PACK%"
ECHO;Reg.exe delete "%%HIVE_USER%%\TEST_KEY" /f^>NUL >>"%NEW_PACK%"
ECHO;START REGEDIT.EXE>>"%NEW_PACK%"
ECHO;ECHO Pack was permitted, TEST_KEY deleted^&PAUSE>>"%NEW_PACK%"
ECHO;::Must use extra set of percents in permit REG-KEY field (ex. %%%%HIVE_USER%%%%\XYZ)>>%NEW_PACK%"
EXIT /B
:N51
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=MSI_INSTALLER_EXAMPLE"&&SET "PackDesc=Scripted Pack MSI Installer Example"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
ECHO;::Put MSI in pack folder.>>%NEW_PACK%"
ECHO;"EXAMPLE.msi" /qn>>"%NEW_PACK%"
EXIT /B
:N52
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=DISM_Special"&&SET "PackDesc=DISM special pack"&&SET "PackTag=DISM"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"
ECHO;DISM /%%APPLY_TARGET%% /ABC:DEF /123:456>>"%NEW_PACK%"
EXIT /B
:N53
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=AUTOBOOT_ENABLE"&&SET "PackDesc=Commands to enable AutoBoot and boot into recovery"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:TIME_WARN2
ECHO;::Needs AutoBoot.cmd in package folder>>"%NEW_PACK%"
ECHO;COPY /Y AutoBoot.cmd "%%~DP0.." >>"%NEW_PACK%"
ECHO;START CMD /C "%%~DP0..\windick.cmd" -autoboot -install>>"%NEW_PACK%"
ECHO;START CMD /C "%%~DP0..\windick.cmd" -nextboot -recovery>>"%NEW_PACK%"
EXIT /B
:DBG
CALL:PACK_STRT&&ECHO  - DEBUG -&&ECHO (1)Pause (2)Echo On (3)Echo Off&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:MENU_SELECT
IF "%SELECT%"=="1" SET "PackType=SCRIPTED"&&SET "PackName=Pause"&&SET "PackDesc=Place in PackageList, PAUSES EXECUTION"&&ECHO;PAUSE>>"%NEW_PACK%"
IF "%SELECT%"=="2" SET "PackType=SCRIPTED"&&SET "PackName=Echo_on"&&SET "PackDesc=Place in PackageList, Turns ECHO ON"&&ECHO;@ECHO ON>>"%NEW_PACK%"
IF "%SELECT%"=="3" SET "PackType=SCRIPTED"&&SET "PackName=Echo_off"&&SET "PackDesc=Place in PackageList, Turns ECHO OFF"&&ECHO;@ECHO OFF>>"%NEW_PACK%"
EXIT /B
:N11
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "PackName=Unattended"&&SET "PackDesc=Generate Unattended Answer File"&&SET "EDIT_CUSTOM=unattend.xml"&&SET "PackTag=DISM"&&SET "EDIT_MANIFEST=1"&&CALL:TIME_WARN1
ECHO        - Username? -&&ECHO     - Enter Username -&&ECHO   - 0-9 A-Z - No Spaces -&&ECHO      (Enter) for default&&SET "PROMPT_SET=NEWUSER"&&CALL:PROMPT_SET_ANY
SET "CHAR_STR=%NEWUSER%"&&SET "CHAR_CHK= "&&CALL:CHAR_CHK
IF DEFINED CHAR_FLG SET "NEWUSER="
IF NOT DEFINED NEWUSER SET "NEWUSER=UserName"
ECHO.&&ECHO       - Product key? -&&ECHO XXXXX-XXXXX-XXXXX-XXXXX-XXXXX&&ECHO      (Enter) for default
IF "%PACK_MODE%"=="CREATE" SET "PROMPT_SET=PRODUCT_KEY"&&CALL:PROMPT_SET_ANY
IF NOT DEFINED PRODUCT_KEY SET "PRODUCT_KEY=92NFX-8DJQP-P6BBQ-THF9C-7CG2H"
ECHO;::DISM /%%APPLY_TARGET%% /APPLY-UNATTEND:"%%CD%%\UNATTEND.XML">>"%NEW_PACK%"
ECHO;MD "%%WINTAR%%\PANTHER">>"%NEW_PACK%"
ECHO;COPY /Y "%%~DP0unattend.xml" "%%WINTAR%%\PANTHER">>"%NEW_PACK%"
CALL:ANSWER_FILE>"%MAKER_FOLDER%\unattend.xml"
EXIT /B
:ANSWER_FILE
ECHO;^<?xml version="1.0" encoding="utf-8"?^>
ECHO;^<unattend xmlns="urn:schemas-microsoft-com:unattend"^>
ECHO;	^<settings pass="oobeSystem"^>
ECHO;		^<component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
ECHO;			^<InputLocale^>0409:00000409^</InputLocale^>
ECHO;			^<SystemLocale^>en-US^</SystemLocale^>
ECHO;			^<UILanguage^>en-US^</UILanguage^>
ECHO;			^<UILanguageFallback^>en-US^</UILanguageFallback^>
ECHO;			^<UserLocale^>en-US^</UserLocale^>
ECHO;		^</component^>
ECHO;		^<component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
ECHO;			^<TimeZone^>Mountain Standard Time^</TimeZone^>
ECHO;			^<AutoLogon^>
ECHO;				^<Enabled^>true^</Enabled^>
ECHO;				^<LogonCount^>9999999^</LogonCount^>
ECHO;				^<Username^>%NEWUSER%^</Username^>
ECHO;				^<Password^>
ECHO;					^<PlainText^>true^</PlainText^>
ECHO;					^<Value^>^</Value^>
ECHO;				^</Password^>
ECHO;			^</AutoLogon^>
ECHO;			^<OOBE^>
ECHO;				^<HideEULAPage^>true^</HideEULAPage^>
ECHO;				^<HideLocalAccountScreen^>true^</HideLocalAccountScreen^>
ECHO;				^<HideOnlineAccountScreens^>true^</HideOnlineAccountScreens^>
ECHO;				^<HideWirelessSetupInOOBE^>true^</HideWirelessSetupInOOBE^>
ECHO;				^<NetworkLocation^>Other^</NetworkLocation^>
ECHO;				^<ProtectYourPC^>3^</ProtectYourPC^>
ECHO;				^<SkipMachineOOBE^>true^</SkipMachineOOBE^>
ECHO;				^<SkipUserOOBE^>true^</SkipUserOOBE^>
ECHO;			^</OOBE^>
ECHO;			^<UserAccounts^>
ECHO;				^<LocalAccounts^>
ECHO;					^<LocalAccount wcm:action="add"^>
ECHO;						^<Group^>Administrators^</Group^>
ECHO;						^<Name^>%NEWUSER%^</Name^>
ECHO;						^<Password^>
ECHO;							^<PlainText^>true^</PlainText^>
ECHO;							^<Value^>^</Value^>
ECHO;						^</Password^>
ECHO;					^</LocalAccount^>
ECHO;				^</LocalAccounts^>
ECHO;			^</UserAccounts^>
ECHO;		^</component^>
ECHO;	^</settings^>
ECHO;	^<settings pass="specialize"^>
ECHO;		^<component name="Microsoft-Windows-Security-SPP-UX" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
ECHO;			^<SkipAutoActivation^>true^</SkipAutoActivation^>
ECHO;		^</component^>
ECHO;		^<component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
ECHO;			^<ComputerName^>Computer^</ComputerName^>
ECHO;			^<CopyProfile^>false^</CopyProfile^>
ECHO;			^<ProductKey^>%PRODUCT_KEY%^</ProductKey^>
ECHO;		^</component^>
ECHO;	^</settings^>
ECHO;	^<settings pass="windowsPE"^>
ECHO;		^<component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
ECHO;			^<InputLocale^>0409:00000409^</InputLocale^>
ECHO;			^<SystemLocale^>en-US^</SystemLocale^>
ECHO;			^<UILanguage^>en-US^</UILanguage^>
ECHO;			^<UILanguageFallback^>en-US^</UILanguageFallback^>
ECHO;			^<UserLocale^>en-US^</UserLocale^>
ECHO;			^<SetupUILanguage^>
ECHO;				^<UILanguage^>en-US^</UILanguage^>
ECHO;			^</SetupUILanguage^>
ECHO;		^</component^>
ECHO;		^<component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
ECHO;			^<Diagnostics^>
ECHO;				^<OptIn^>false^</OptIn^>
ECHO;			^</Diagnostics^>
ECHO;			^<DynamicUpdate^>
ECHO;				^<Enable^>false^</Enable^>
ECHO;				^<WillShowUI^>OnError^</WillShowUI^>
ECHO;			^</DynamicUpdate^>
ECHO;			^<ImageInstall^>
ECHO;				^<OSImage^>
ECHO;					^<Compact^>true^</Compact^>
ECHO;					^<WillShowUI^>OnError^</WillShowUI^>
ECHO;					^<InstallFrom^>
ECHO;						^<MetaData wcm:action="add"^>
ECHO;							^<Key^>/IMAGE/INDEX^</Key^>
ECHO;							^<Value^>1^</Value^>
ECHO;						^</MetaData^>
ECHO;					^</InstallFrom^>
ECHO;				^</OSImage^>
ECHO;			^</ImageInstall^>
ECHO;			^<UserData^>
ECHO;				^<AcceptEula^>true^</AcceptEula^>
ECHO;				^<ProductKey^>
ECHO;					^<Key^>%PRODUCT_KEY%^</Key^>
ECHO;					^<WillShowUI^>OnError^</WillShowUI^>
ECHO;				^</ProductKey^>
ECHO;			^</UserData^>
ECHO;		^</component^>
ECHO;	^</settings^>
ECHO;^</unattend^>
EXIT /B
:RESTART
"shutdown.exe" -r -f -t 0
:QUIT
CALL:SETS_HANDLER>NUL 2>&1
IF EXIST "U:\EFI" CALL:EFI_UNMOUNT>NUL 2>&1
IF EXIST "V:\" CALL:VDISK_DETACH>NUL 2>&1
:CLEAN_EXIT
COLOR 07&&TITLE C:\Windows\system32\CMD.exe&&CD /D "%ORIG_CD%"
IF "%PROG_MODE%"=="RAMDISK" EXIT 0&&EXIT 0
