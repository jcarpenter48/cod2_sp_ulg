# Call of Duty 2 SP Ultra Low Graphics Launcher
[insert image later]
## Call of Duty 2 SP Ultra Low Graphics Launcher

Demolish the graphical appearance of Call of Duty 2 for maximal performance!

### Description:
This is a launcher for Call of Duty 2 Singleplayer that allows the user to launch into any singleplayer mission with Ultra Low Graphics settings applied, even lower than the regular settings menu and configuration files normally allow. 

Additionally, the user can select from one of a handful of different renderer options, such as Software Rendering through Swiftshader or wrapping with wined3d.  

Comes in both a GUI Form and a .bat launcher variant, allowing users to choose either a streamlined experience or a simple command line window.

### Installation (gui launcher):
  This version is the one you likely want, and works on **Windows XP SP3 and up**.
  1. Download this repo (Code > Download .zip)
  2. Extract the archive and open the 'bin_gui' folder
  3. Copy these files to your Call of Duty 2 folder where the executable is located (e.g. cod2sp.exe). 
  4. Launch using the provided shortcut to the cod2_sp_ulg_launcher.exe or create your own shortcut on your Desktop or wherever you like.
  5. To play on an unsupported video card:

      a. **Software Rendering:** select either SwiftShader 3.2 (compiled by rboxeur on the ReactOS forums) or Swiftshader 3.0 (compiled by MegaFox on Vogons)
      
      b. **wineD3D:** select the wineD3D 17.28 (by fdossena) option in the drop down menu
      
  6. Select your preferred campaign, mission, and click to launch!

### Installation (.bat variant):
  If this is your preference, it has been tested on **Windows XP SP3 and up**.
  1. Download this repo (Code > Download .zip)
  2. Extract the archive and open the 'bin_bat' folder
  3. Copy these files to your Call of Duty 2 folder where the executable is located (e.g. cod2sp.exe). 
  4. Launch using the cod2_sp_ulg.bat directly or create your own shortcut on your Desktop or wherever you like.
  5. To play on an unsupported video card:
     
     a. **Software Rendering:** select either SwiftShader 3.2 (compiled by rboxeur on the ReactOS forums) or Swiftshader 3.0 (compiled by MegaFox on Vogons)
     
     b. **wineD3D:** select the wineD3D 17.28 (by fdossena) option in the drop down menu
  6. Select your preferred campaign, mission, and enter to launch!

### Building:
  This project was built using Visual Studio 16.0.33328.57 on Windows 10 22H2 and targets .NET 4.0 for XP SP3 compatibility
  1. Minimum Required VS version: 10.0.40219.1
  2. Update me!
