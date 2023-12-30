If you find my work useful, please feel free to buy me some coffees at [https://www.buymeacoffee.com/steenh](https://www.buymeacoffee.com/steenh)

## Run unsupported PreSonus FireStudio* on Mac OS Catalina 10.15 and Big Sur 11, Monterey 12 and Ventura 13 (Intel Only)

### THIS WILL NEVER WORK ON APPLE SILICON (M1) MACS

### NO SUPPORT WHATSOEVER IS PROVIDED FOR THIS! IF IT EATS YOUR FIRSTBORN, THEN IT IS ON YOU.

This Application will help install the Firewire driver and Universal Control v1.7.6  
for unsupported PreSonus Firewire devices on Mac OS Catalina 10.15 and above 

### Note: The driver will seemingly only run properly on pre 2012 Macs up to Catalina. Later than Catalina require a VT-D capable motherboard. This information comes from OpenCore forum and appears to be a MacOS limitation, not a problem with the driver itself.

What the app does:
* Downloads and installs the new 10.15+ compatible Firewire driver from UC v3.4.2-63992
* Downloads the old UC Control Panel app from v 1.7.6-5875
* Extracts the control panel and panel drivers from the old version
* Installs `Universal Control.app` and the panel drivers in the correct locations
* Fixes permissions on the installed software.

See (Silent) Video of it in operation here:  


[![Driver in action on Mac OS Big Sur](https://img.youtube.com/vi/GeoG24QyTWg/0.jpg)](https://www.youtube.com/watch?v=GeoG24QyTWg)

### Instructions
* Download the latest DMG [release](https://github.com/colin-campbell/firestudio-catalina/releases/latest)
* Open the DMG file and double-click the "Firestudio Catalina" app
* Reboot when finished.

To uninstall, run the PreSonus uninstaller from the **new** dmg:  
 `PreSonus_UniversalControl_v3_4_2_63992.dmg`

Mac OS Gatekeeper may ask for permission to run the new Firewire driver if you have SIP enabled, if prompted, Visit System Preferences->Security & Privacy to allow the driver to run.  

You may need to power-cycle the interface once after the driver is installed. 



