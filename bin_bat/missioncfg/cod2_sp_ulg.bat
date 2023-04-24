@ECHO OFF
CLS
:start
CLS
ECHO ==========================================
ECHO CALL OF DUTY 2 ULTRA-LOW GRAPHICS LAUNCHER
ECHO ==========================================
ECHO CAMPAIGN SELECT:
ECHO 1. Soviet Campaign
ECHO 2. British Campaign
ECHO 3. American Campaign
ECHO ==========================================
ECHO (E) Exit Launcher
ECHO.

set "choiceC=%globalparam1%"
set /p choiceC="Enter Number Corresponding to Campaign: "
if not defined choiceC goto :start
if '%choiceC%'=='1' goto MissionSelect_Soviet
if '%choiceC%'=='2' goto MissionSelect_British
if '%choiceC%'=='3' goto MissionSelect_American
if '%choiceC%'=='E' goto end
if '%choiceC%'=='e' goto end
ECHO "%choiceC%" is not valid selection, please try again
ECHO.
goto start

:MissionSelect_Soviet
cls
ECHO ==========================================
ECHO SOVIET CAMPAIGN MISSION SELECT:
ECHO ==========================================
ECHO The Winter War
ECHO   1. Red Army Training
ECHO   2. Demolition
ECHO Not One Step Backwards!
ECHO   3. Repairing the Wire
ECHO   4. The Pipeline
ECHO Fortress Stalingrad
ECHO   5. Downtown Assault
ECHO   6. City Hall
ECHO   7. Comrade Sniper
ECHO ==========================================
ECHO (E) Return to Previous Menu
set "mission_R=%globalparam1%"
set /p mission_R="Enter Number Corresponding to Mission: "
if not defined mission_R goto :MissionSelect_Soviet
if '%mission_R%'=='1' goto mission_R_1
if '%mission_R%'=='2' goto mission_R_2
if '%mission_R%'=='3' goto mission_R_3
if '%mission_R%'=='4' goto mission_R_4
if '%mission_R%'=='5' goto mission_R_5
if '%mission_R%'=='6' goto mission_R_6
if '%mission_R%'=='7' goto mission_R_7
if '%mission_R%'=='E' goto start
if '%mission_R%'=='e' goto start
ECHO "%mission_R%" is not valid selection, please try again
ECHO.
goto MissionSelect_Soviet

::SOVIET MISSIONS
:mission_R_1
ECHO Ready to Launch Mission: Red Army Training
pause
"""%0""\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission1.cfg +exec autoexec.cfg
goto MissionSelect_Soviet
:mission_R_2
ECHO Ready to Launch Mission: Demolition
pause
"""%0""\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission2.cfg +exec autoexec.cfg
goto MissionSelect_Soviet

:mission_R_3
ECHO Ready to Launch Mission: Repairing the Wire
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission3.cfg +exec autoexec.cfg
goto MissionSelect_Soviet
:mission_R_4
ECHO Ready to Launch Mission: The Pipeline
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission4.cfg +exec autoexec.cfg
goto MissionSelect_Soviet

:mission_R_5
ECHO Ready to Launch Mission: Downtown Assault
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission5.cfg +exec autoexec.cfg
goto MissionSelect_Soviet
:mission_R_6
ECHO Ready to Launch Mission: City Hall
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission6.cfg +exec autoexec.cfg
goto MissionSelect_Soviet
:mission_R_7
ECHO Ready to Launch Mission: Comrade Sniper
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission7.cfg +exec autoexec.cfg
goto MissionSelect_Soviet


:MissionSelect_British
cls
ECHO ==========================================
ECHO BRITISH CAMPAIGN MISSION SELECT:
ECHO ==========================================
ECHO The Battle of El Alamein
ECHO   1. The Diversionary Raid
ECHO   2. Holding the Line
ECHO   3. Operation Supercharge
ECHO   4. The End of the Beginning
ECHO The Tank Squadrons
ECHO   5. Crusader Charge
ECHO   6. 88 Ridge
ECHO Rommel's Last Stand
ECHO   7. Outnumbered and Outgunned
ECHO   8. Retaking Lost Ground
ECHO   9. Assault on Matmata
ECHO The Battle for Caen
ECHO   10. Prisoners of War
ECHO   11. The Crossroads
ECHO   12. The Tiger
ECHO   13. The Brigade Box
ECHO ==========================================
ECHO (E) Return to Previous Menu
set "mission_B=%globalparam1%"
set /p mission_B="Enter Number Corresponding to Mission: "
if not defined mission_B goto :MissionSelect_British
if '%mission_B%'=='1' goto mission_B_1
if '%mission_B%'=='2' goto mission_B_2
if '%mission_B%'=='3' goto mission_B_3
if '%mission_B%'=='4' goto mission_B_4
if '%mission_B%'=='5' goto mission_B_5
if '%mission_B%'=='6' goto mission_B_6
if '%mission_B%'=='7' goto mission_B_7
if '%mission_B%'=='8' goto mission_B_8
if '%mission_B%'=='9' goto mission_B_9
if '%mission_B%'=='10' goto mission_B_10
if '%mission_B%'=='11' goto mission_B_11
if '%mission_B%'=='12' goto mission_B_12
if '%mission_B%'=='13' goto mission_B_13
if '%mission_B%'=='E' goto start
if '%mission_B%'=='e' goto start
ECHO "%mission_B%" is not valid selection, please try again
ECHO.
goto MissionSelect_British

::BRITISH MISSIONS
:mission_B_1
ECHO Ready to Launch Mission: The Diversionary Raid
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission8.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_2
ECHO Ready to Launch Mission: Holding the Line
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission9.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_3
ECHO Ready to Launch Mission: Operation Supercharge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission10.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_4
ECHO Ready to Launch Mission: The End of the Beginning
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission11.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_5
ECHO Ready to Launch Mission: Crusader Charge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission12.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_6
ECHO Ready to Launch Mission: 88 Ridge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission13.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_7
ECHO Ready to Launch Mission: Outnumbered and Outgunned
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission14.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_8
ECHO Ready to Launch Mission: Retaking Lost Ground
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission15.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_9
ECHO Ready to Launch Mission: Assault on Matmata
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission16.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_10
ECHO Ready to Launch Mission: Prisoners of War
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission17.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_11
ECHO Ready to Launch Mission: The Crossroads
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission18.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_12
ECHO Ready to Launch Mission: The Tiger
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission19.cfg +exec autoexec.cfg
goto MissionSelect_British
:mission_B_13
ECHO Ready to Launch Mission: The Brigade Box
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission20.cfg +exec autoexec.cfg
goto MissionSelect_British



:MissionSelect_American
cls
ECHO ==========================================
ECHO AMERICAN CAMPAIGN MISSION SELECT:
ECHO ==========================================
ECHO D-Day
ECHO   1. The Battle of Ponte Du Hoc
ECHO   2. Defending the Points
ECHO   3. The Silo
ECHO Hill 400
ECHO   5. Approaching Hill 400
ECHO   6. Rangers Lead the Way
ECHO   7. The Battle for Hill 400
ECHO Crossing the Rhine
ECHO   8. Crossing the Rhine
ECHO ==========================================
ECHO (E) Return to Previous Menu
set "mission_A=%globalparam1%"
set /p mission_A="Enter Number Corresponding to Mission: "
if not defined mission_A goto :MissionSelect_American
if '%mission_A%'=='1' goto mission_A_1
if '%mission_A%'=='2' goto mission_A_2
if '%mission_A%'=='3' goto mission_A_3
if '%mission_A%'=='4' goto mission_A_4
if '%mission_A%'=='5' goto mission_A_5
if '%mission_A%'=='6' goto mission_A_6
if '%mission_A%'=='7' goto mission_A_7
if '%mission_A%'=='8' goto mission_A_8
if '%mission_A%'=='E' goto start
if '%mission_A%'=='e' goto start
ECHO "%mission_A%" is not valid selection, please try again
ECHO.
goto MissionSelect_American

::American MISSIONS
:mission_A_1
ECHO Ready to Launch Mission: The Diversionary Raid
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission21.cfg +exec autoexec.cfg
goto MissionSelect_American
:mission_A_2
ECHO Ready to Launch Mission: Holding the Line
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission22.cfg +exec autoexec.cfg
goto MissionSelect_American
:mission_A_3
ECHO Ready to Launch Mission: Operation Supercharge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission23.cfg +exec autoexec.cfg
goto MissionSelect_American
:mission_A_4
ECHO Ready to Launch Mission: The End of the Beginning
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission24.cfg +exec autoexec.cfg
goto MissionSelect_American
:mission_A_5
ECHO Ready to Launch Mission: Crusader Charge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission25.cfg +exec autoexec.cfg
goto MissionSelect_American
:mission_A_6
ECHO Ready to Launch Mission: 88 Ridge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission26.cfg +exec autoexec.cfg
goto MissionSelect_American
:mission_A_7
ECHO Ready to Launch Mission: Outnumbered and Outgunned
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission27.cfg +exec autoexec.cfg
goto MissionSelect_American
:mission_A_8
ECHO Ready to Launch Mission: Retaking Lost Ground
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +exec mission28.cfg +exec autoexec.cfg
goto MissionSelect_American

:end
pause