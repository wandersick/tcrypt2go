# Part of tCrypt2Go Lock-and-Unlock Utilities by wandersick
# Script filename: Unlock_Mac.command
# Description: Run to unlock drive on Mac OS X for TrueCrypt partitions (primarily used on external media of a 'fixed disk' type such as USB hard disks)
# Version: 1.2
# Date: 17-Feb-2018
# Language: Shell (Mac OS X)

# ** USB Hard Drive (TrueCrypt Partition) version **
# ** Use AppleScript to run this instead of running directly to suppress terminal output **

# better than: cd `dirname "$0"` which generates errors when path contains space
dirPath=`dirname "$0"`
cd "$dirPath"

# auto-mount all encrypted drives.

# check if TrueCrypt is installed. If not, install it. Otherwise, auto mount all file systems (requires visudo and installed TrueCrypt)

if ls /Applications/TrueCrypt.app; then
	/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --auto-mount=devices --force
else
	cp -rf './TrueCrypt.pkg' "$TMPDIR"
	osascript -e 'tell app "System Events" to activate'	
	osascript -e 'tell app "System Events" to display dialog "TrueCrypt not detected. It will be installed now." buttons ("OK") default button 1 with icon 0'
	osascript -e "do shell script \"./tc_silent_setup.command\" with administrator privileges"
	/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --auto-mount=devices --force
fi

# less aggressive than killall, but requires confirmation

# close terminal if no more than 1 terminal window is open
osascript -e 'tell application "Terminal" to if not ((count windows) > 1) then quit'

# misc notes:

# do not use 'screen' as visudo fails to work
# 'screen -dmS title command', similar to 'start title command' in cmd
# e.g. screen -dmS Unlock ./.DO_NOT_DELETE/TrueCrypt.app/Contents/MacOS/TrueCrypt --auto-mount=devices --force

# sudo is required for auto-mounting/dismounting partitions
# without it, it is required to run TrueCrypt as root beforehand

# close all terminals:
# killall Terminal
# close all terminals (with confirmation):
# osascript -e 'tell app "Terminal" to quit'