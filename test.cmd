@ECHO OFF
setlocal enabledelayedexpansion

SET "ModPath=!CD!"

ECHO "%ModPath%"

ECHO Looping through files...
:: Loop through all CQUI folders


FOR /D %%D in (*) DO (
  ECHO %%D
  
)