#!/usr/bin/env bash

## Some jolly, happy  colours

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' #No Colour

DRIVER_DMG="PreSonus_UniversalControl_v3_2_1_57677.dmg"
UC_DMG="PreSonus_Universal_Control-5875.dmg"


REMOTE_DRIVER="https://pae-web.presonusmusic.com/downloads/products/dmg/${DRIVER_DMG}"
REMOTE_UC="https://pae-web.presonusmusic.com/downloads/products/dmg/${UC_DMG}"
SUBDIR="Presonus Universal Control"
FW_DRIVER="${SUBDIR}/PreSonus FireWire Driver.pkg"

resetTerm() {
  printf"${RED}Exiting due to error${NC}"
}

trap 'resetTerm' ERR

printf "\n${GREEN}Downloading Firewire driver.\n"
[ ! -f "$DRIVER_DMG" ] && curl -O -# "${REMOTE_DRIVER}"


printf "\nDownloading Control Panel\n"
[ ! -f "$UC_DMG" ] && curl -O -# "{$REMOTE_UC}"


printf "\nMounting Firewire driver dmg"
MOUNT_DRIVE=$(hdiutil attach -noverify -mountroot ./ ${DRIVER_DMG} | awk 'FNR==1{print $1; exit}')


printf "\nInstalling Firewire driver\n\n"
sudo installer -pkg "$FW_DRIVER" -target /


printf "\nEjecting Firewire driver dmg\n"
hdiutil detach "${MOUNT_DRIVE}"

printf "\nMounting Control panel dmg\n"
MOUNT_DRIVE=$(hdiutil attach -noverify -mountroot ./ ${UC_DMG} | awk 'FNR==1{print $1; exit}')

printf "\nExpanding Control panel Package\n"
pkgutil --expand-full "${SUBDIR}/PreSonus Universal Control.pkg" tmp

printf "\nEjecting Control panel dmg\n"
hdiutil detach "${MOUNT_DRIVE}"

printf "\nRemoving Universal Control.app if it exists.\n"
sudo rm -rf "/Applications/Universal Control.app"

printf "\nCopying Universal Control.app to /Applications\n"
sudo cp -a "tmp/UCInstaller.pkg/Payload/Applications/Universal Control.app" /Applications/

printf "\nFixing permissions on Universal Control.app\n"
sudo chown -R root:admin "/Applications/Universal Control.app"

printf "\nEnsure Devices directory exists.\n"
sudo mkdir -p "/Library/Application Support/Presonus/Devices"

printf "\nCopying device drivers to correct location\n"
sudo cp -a  "tmp/UCInstaller.pkg/Payload/Library/Application Support/Presonus/Devices" "/Library/Application Support/Presonus/" 

printf "\nFixing permissions on device drivers\n"
sudo chown -R root:wheel "/Library/Application Support/Presonus"

printf "\nRemoving temporary files\n"
rm -rf tmp

printf "\n\nAll done! reboot your computer to load the new software.${NC}"
