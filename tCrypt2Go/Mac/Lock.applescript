# Part of tCrypt2Go Lock-and-Unlock Utilities by wandersick
# Description: Executes shell script, Lock_Mac.command, for hiding terminal outputs from users
# Version: 1.2
# Date: 17-Feb-2018
# Output filename: Lock.app
# Language: AppleScript

tell application "Finder"
set my_folder_path to POSIX file ((POSIX path of (path to me)) & "/..") as text
set my_folder_path to ((characters 1 thru -2 of my_folder_path) as string)
do shell script "'/Volumes/" & my_folder_path & "/.DO_NOT_DELETE/Lock_Mac.command'"
end tell