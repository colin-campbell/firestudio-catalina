## Run unsupported PreSonus FireStudio* on Mac OS Catalina 10.15

### NO SUPPORT WHATSOEVER IS PROVIDED FOR THIS! IF IT EATS YOUR FIRSTBORN, THEN IT IS ON YOU.

This script will help install the Firewire driver and Universal Control v1.7.6  
for unsupported PreSonus Firewire devices on Mac OS Catalina 10.15  

What the script does:
* Downloads and installs the new Catalina-compatible Firewire driver from UC v3.2.1-57667
* Downloads the old UC Control Panel app from v 1.7.6-5875
* Extracts the control panel and panel drivers from the old version
* Installs `Universal Control.app` and the panel drivers in the correct locations
* Fixes permissions on the installed software.

### Instructions
* Download and extract the latest [release](https://github.com/colin-campbell/firestudio-catalina/releases)
* Run the script in a terminal with: `sh presonus_catalina.sh` you will be prompted for your password.
* Reboot when finished.

To uninstall, run the PreSonus uninstaller from the **new** dmg:  
 `PreSonus_UniversalControl_v3_2_1_57677.dmg`

Mac OS Gatekeeper may complain about the new Firewire driver if you have SIP enabled, if prompted, Visit System Preferences->Security & Privacy to allow the drievr to run.  

You may need to power-cycle the interface once after the driver is installed. 



