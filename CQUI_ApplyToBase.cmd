:: !!! CAUTION !!!
:: This script installs the CQUI files overtop of your base game files.
:: USAGE: For those who wish to play Multiplayer with others who do not have CQUI enabled.
::
:: WARNING: This is an unsupported configuration and may have unexpected results if you run other mods at the same time.
@ECHO OFF
:: Set delayed variable expansion so that loops will work as expected. Use !var! instead of %var%
setlocal ENABLEDELAYEDEXPANSION

:: Define default locations
SET CallingPath="%CD%"
SET "GamePath=C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization VI\Base\Assets\UI\"
CD %~dp0..
SET "ModPath=!CD!"
SET TempDir="!ModPath!"\Temp
SET ThisFile=%0

:ChckPath
:: Check if the default steam folder exists
SET Try=N
IF NOT EXIST "!GamePath!" (
  ECHO Could not find Civ6 at location: "!GamePath!"
  SET /P "Try= Try another path?(Y/N):"
  :: /I for case insensitive
  IF /I "!Try!"=="Y" (
    SET /P "GamePath= Please enter path to the Civ6 UI folder:"
    Goto ChckPath
  ) ELSE (
    ECHO Execution cancelled.
    Goto Exit
  )
)

:: Echo the parameters for the install
ECHO Starting CQUI installation with parameters:
ECHO   GamePath="!GamePath!"
ECHO   ModPath="%ModPath%"
ECHO   CallingPath=%CallingPath%
ECHO.

CALL :PrepFilesToCopy





:Exit
ECHO Exiting...
:: Return to the originating path before exiting
CD %CallingPath%
GOTO :EOF



:PrepFilesToCopy
:: This function creates a temp folder in the mod root directory and copies in all mod files into a flat structure ready to overwrite the base game UI files.
IF EXIST !TempDir! (
  RMDIR /s /q "!ModPath!"\Temp
)

MKDIR "!ModPath!"\Temp

ECHO Looping through files...
:: Loop through all CQUI folders
FOR /R "%ModPath%" %%F in (*) DO (
  SET File=%%F
  SET File=!File:.git=!
  SET File=!file:\Temp=!
  :: Match means it did NOT contain '.git' see http://stackoverflow.com/a/7006016 for more explanation
  IF %%F==!File! (
    ECHO %%F
  )
)

EXIT /B

