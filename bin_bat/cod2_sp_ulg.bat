@ECHO OFF
CLS
set "renderMethod=%globalparam1%"
set renderMethod=hw
for /f "tokens=1,2 delims==" %%a in (cod2_sp_ulg.ini) do (
	echo %%b
	if %%b==hw goto set_hw
	if %%b==sw30 goto set_sw30
	if %%b==sw32 goto set_sw32
	if %%b==wine goto set_wine
)
goto start
:set_hw
set renderMethod=hw
goto start
:set_wine
set renderMethod=wine
goto start
:set_sw30
set renderMethod=sw30
goto start
:set_sw32
set renderMethod=sw32
goto start
:start
CLS
::clean our directory of extraneous files for default
if exist "%cd%\sw-pixel.dir" del /F "%cd%\sw-pixel.dir"
if exist "%cd%\sw-setup.dir" del /F "%cd%\sw-setup.dir"
if exist "%cd%\sw-vertex.dir" del /F "%cd%\sw-vertex.dir"
if exist "%cd%\sw-pixel.dll" del /F "%cd%\sw-pixel.dll"
if exist "%cd%\sw-setup.dll" del /F "%cd%\sw-setup.dll"
if exist "%cd%\sw-vertex.dll" del /F "%cd%\sw-vertex.dll"
if exist "%cd%\wined3d.dll" del /F "%cd%\wined3d.dll"
if exist "%cd%\libwine.dll" del /F "%cd%\libwine.dll"
if exist "%cd%\d3d9.dll" del /F "%cd%\d3d9.dll"
if '%renderMethod%'=='wine' (
	copy "%cd%\cod2_sp_ulg_dlls\d3d9.wine.17.28.dll" "%cd%\d3d9.dll" 
	copy "%cd%\cod2_sp_ulg_dlls\libwine.dll" "%cd%\libwine.dll" 
	copy "%cd%\cod2_sp_ulg_dlls\wined3d.dll" "%cd%\wined3d.dll" 
	)
if '%renderMethod%'=='sw30' copy "%cd%\cod2_sp_ulg_dlls\d3d9.sw3.0.dll" "%cd%\d3d9.dll" 
if '%renderMethod%'=='sw32' copy "%cd%\cod2_sp_ulg_dlls\d3d9.sw3.2.dll" "%cd%\d3d9.dll" 
::continue with regular start screen after we've switched render methods
CLS
ECHO ==========================================
ECHO CALL OF DUTY 2 ULTRA-LOW GRAPHICS LAUNCHER
ECHO ==========================================
ECHO CAMPAIGN SELECT:
ECHO 1. Soviet Campaign
ECHO 2. British Campaign
ECHO 3. American Campaign
ECHO ==========================================
ECHO (S) Settings
ECHO (E) Exit Launcher
ECHO.

set "choiceC=%globalparam1%"
set /p choiceC="Enter Number Corresponding to Campaign: "
if not defined choiceC goto :start
if '%choiceC%'=='1' goto MissionSelect_Soviet
if '%choiceC%'=='2' goto MissionSelect_British
if '%choiceC%'=='3' goto MissionSelect_American
if '%choiceC%'=='S' goto settings
if '%choiceC%'=='s' goto settings
if '%choiceC%'=='E' goto end
if '%choiceC%'=='e' goto end
ECHO "%choiceC%" is not valid selection, please try again
ECHO.
goto start

:settings
cls
ECHO ==========================================
ECHO RENDER METHOD SELECTION:
ECHO ==========================================
ECHO 1. Hardware D3D9 (Default)
ECHO 2. Software via Swiftshader 3.0.0.5003 by MegaFox
ECHO 3. Software via Swiftshader 3.2.10.47665 by rboxeur
ECHO 4. Hardware WineD3D
ECHO ==========================================
ECHO (E) Return to Previous Menu
set "mission_R=%globalparam1%"
set /p setting_R="Enter Desired Render Method: "
if not defined setting_R goto :settings
if '%setting_R%'=='1' (
	goto :setting_default
)
if '%setting_R%'=='2' (
	goto :setting_sw30
)
if '%setting_R%'=='3' (
	goto :setting_sw32
)
if '%setting_R%'=='4' (
	goto :setting_wine
)
if '%setting_R%'=='E' goto start
if '%setting_R%'=='e' goto start
ECHO "%setting_R%" is not valid selection, please try again
ECHO.
goto settings

:ini_rewrite
::after setting variable in script, we rewrite ini file
echo renderer=%renderMethod%> cod2_sp_ulg.ini
echo :: >> cod2_sp_ulg.ini
echo Renderer Types: >> "cod2_sp_ulg.ini"
echo sw30 is software swiftshader 3.0 >> "cod2_sp_ulg.ini"
echo sw32 is software swiftshader 3.2 >> "cod2_sp_ulg.ini"
echo hw is hardware d3d9 >> "cod2_sp_ulg.ini"
echo wine is hardware wined3d >> "cod2_sp_ulg.ini"
echo :: >> "cod2_sp_ulg.ini"
ECHO Render Method Updated Successfully!
pause
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
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap moscow +exec autoexec.cfg
goto MissionSelect_Soviet
:mission_R_2
ECHO Ready to Launch Mission: Demolition
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap demolition +exec autoexec.cfg
goto MissionSelect_Soviet

:mission_R_3
ECHO Ready to Launch Mission: Repairing the Wire
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap tankhunt +exec autoexec.cfg
goto MissionSelect_Soviet
:mission_R_4
ECHO Ready to Launch Mission: The Pipeline
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap trainyard +exec autoexec.cfg
goto MissionSelect_Soviet

:mission_R_5
ECHO Ready to Launch Mission: Downtown Assault
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap downtown_assault +exec autoexec.cfg
goto MissionSelect_Soviet
:mission_R_6
ECHO Ready to Launch Mission: City Hall
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap cityhall +exec autoexec.cfg
goto MissionSelect_Soviet
:mission_R_7
ECHO Ready to Launch Mission: Comrade Sniper
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap downtown_sniper +exec autoexec.cfg
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
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap decoytrenches +exec autoexec.cfg
goto MissionSelect_British
:mission_B_2
ECHO Ready to Launch Mission: Holding the Line
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap decoytown +exec autoexec.cfg
goto MissionSelect_British
:mission_B_3
ECHO Ready to Launch Mission: Operation Supercharge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap elalamein +exec autoexec.cfg
goto MissionSelect_British
:mission_B_4
ECHO Ready to Launch Mission: The End of the Beginning
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap eldaba +exec autoexec.cfg
goto MissionSelect_British
:mission_B_5
ECHO Ready to Launch Mission: Crusader Charge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap libya +exec autoexec.cfg
goto MissionSelect_British
:mission_B_6
ECHO Ready to Launch Mission: 88 Ridge
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap 88ridge +exec autoexec.cfg
goto MissionSelect_British
:mission_B_7
ECHO Ready to Launch Mission: Outnumbered and Outgunned
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap toujane_ride +exec autoexec.cfg
goto MissionSelect_British
:mission_B_8
ECHO Ready to Launch Mission: Retaking Lost Ground
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap toujane +exec autoexec.cfg
goto MissionSelect_British
:mission_B_9
ECHO Ready to Launch Mission: Assault on Matmata
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap matmata +exec autoexec.cfg
goto MissionSelect_British
:mission_B_10
ECHO Ready to Launch Mission: Prisoners of War
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap beltot +exec autoexec.cfg
goto MissionSelect_British
:mission_B_11
ECHO Ready to Launch Mission: The Crossroads
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap crossroads +exec autoexec.cfg
goto MissionSelect_British
:mission_B_12
ECHO Ready to Launch Mission: The Tiger
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap newvillers +exec autoexec.cfg
goto MissionSelect_British
:mission_B_13
ECHO Ready to Launch Mission: The Brigade Box
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap breakout +exec autoexec.cfg
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
ECHO   4. Approaching Hill 400
ECHO   5. Rangers Lead the Way
ECHO   6. The Battle for Hill 400
ECHO Crossing the Rhine
ECHO   7. Crossing the Rhine
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
if '%mission_A%'=='E' goto start
if '%mission_A%'=='e' goto start
ECHO "%mission_A%" is not valid selection, please try again
ECHO.
goto MissionSelect_American

::American MISSIONS
:mission_A_1
ECHO Ready to Launch Mission: The Battle of Ponte Du Hoc
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap duhoc_assault +exec autoexec.cfg
goto MissionSelect_American
:mission_A_2
ECHO Ready to Launch Mission: Defending the Points
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap duhoc_defend +exec autoexec.cfg
goto MissionSelect_American
:mission_A_3
ECHO Ready to Launch Mission: The Silo
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap silotown_assault +exec autoexec.cfg
goto MissionSelect_American
:mission_A_4
ECHO Ready to Launch Mission: Approaching Hill 400
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap bergstein +exec autoexec.cfg
goto MissionSelect_American
:mission_A_5
ECHO Ready to Launch Mission: Rangers Lead the Way
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap hill400_assault +exec autoexec.cfg
goto MissionSelect_American
:mission_A_6
ECHO Ready to Launch Mission: The Battle for Hill 400
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap hill400_defend +exec autoexec.cfg
goto MissionSelect_American
:mission_A_7
ECHO Ready to Launch Mission: Crossing the Rhine
pause
""%0"\..\CoD2SP_s.exe" +set com_introplayed 1 +spdevmap rhine +exec autoexec.cfg
goto MissionSelect_American

:end
goto :endreal

:setting_default
echo old render method: %renderMethod%
set renderMethod=hw
echo new render method: %renderMethod%
goto :ini_rewrite
:setting_wine
echo old render method: %renderMethod%
set renderMethod=wine
echo new render method: %renderMethod%
goto :ini_rewrite
:setting_sw30
echo old render method: %renderMethod%
set renderMethod=sw30
echo new render method: %renderMethod%
goto :ini_rewrite
:setting_sw32
echo old render method: %renderMethod%
set renderMethod=sw32
echo new render method: %renderMethod%
goto :ini_rewrite

:endreal
pause