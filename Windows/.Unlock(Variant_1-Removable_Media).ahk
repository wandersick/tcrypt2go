/*
 * * * Compile_AHK SETTINGS BEGIN * * *

[AHK2EXE]
Exe_File=%In_Dir%\.Unlock.exe
Execution_Level=3
[VERSION]
Set_Version_Info=1
Company_Name=a wandersick
File_Description=Open Protected Drive (TrueCrypt Container)
File_Version=1.2.0.0
Inc_File_Version=0
Internal_Name=Unlock
Legal_Copyright=Copyright (c) 2012-2018 a wandersick production (http://wandersick.blogspot.com)
Original_Filename=Unlock
Product_Name=Unlock
Product_Version=1.2.0.0
[ICONS]
Icon_1=%In_Dir%\UnLock.ico

* * * Compile_AHK SETTINGS END * * *
*/

; Part of tCrypt2Go Lock-and-Unlock Utilities by wandersick
; Script filename: .Unlock.ahk
; Output filename: .Unlock.exe
; Description: Run to unlock drive on Windows for TrueCrypt containers (primarily used on removable media such as USB thumb drives)
; Version: 1.2
; Date: 17-Feb-2018
; Language: AutoHotkey

; TrueCrypt Portable requires either admin rights or an installed copy of TrueCrypt 7.1/7.1a for standard users.

; If admin right is unavailable, TrueCrypt Portable would not be run, so it checks for an installed TrueCrypt program or driver.
; If one is found, it will run TrueCrypt Portable; if not found, it prompts TrueCrypt setup with Windows Explorer.

; (Note that for Mac, TrueCrypt Portable would not work. An installed copy must be available.)

; ** USB Flash Drive (Container) version **

#NoTrayIcon

If A_IsAdmin
{
Run, "%A_ScriptDir%\.DO_NOT_DELETE\tc.exe" /w /c n /v "%A_ScriptDir%\.DO_NOT_DELETE\tc-container.tc" /a /q /e, %A_ScriptDir%, min
ExitApp
}

If ProgramW6432
Gosub, x64
Else
Gosub, x86
ExitApp

x64:
RegRead, ProgramVersion, HKEY_LOCAL_MACHINE, software\wow6432node\microsoft\windows\currentversion\uninstall\truecrypt, DisplayVersion
RegRead, DriverVersion, HKEY_LOCAL_MACHINE, software\wow6432node\microsoft\windows\currentversion\uninstall\{9E202A30-16DB-4A3A-A0CF-2DB1EF08B7E5}, DisplayVersion
If (ProgramVersion > 7.0 OR DriverVersion = "7.1.0.0")
{
Run, "%A_ScriptDir%\.DO_NOT_DELETE\tc.exe" /w /c n /v "%A_ScriptDir%\.DO_NOT_DELETE\tc-container.tc" /a /q /e, %A_ScriptDir%, min
}
Else
{
MsgBox, TrueCrypt not installed or version too old. Please install it first.
Run, %Windir%\explorer.exe "%A_ScriptDir%\.DO_NOT_DELETE\TrueCrypt for Windows"
}
return

x86:
RegRead, ProgramVersion, HKEY_LOCAL_MACHINE, software\microsoft\windows\currentversion\uninstall\truecrypt, DisplayVersion
RegRead, DriverVersion, HKEY_LOCAL_MACHINE, software\microsoft\windows\currentversion\uninstall\{845ADC23-6704-4650-8E92-BA0D9858B740}, DisplayVersion
If (ProgramVersion > 7.0 OR DriverVersion = "7.1.0.0")
{
Run, "%A_ScriptDir%\.DO_NOT_DELETE\tc.exe" /w /c n /v "%A_ScriptDir%\.DO_NOT_DELETE\tc-container.tc" /a /q /e, %A_ScriptDir%, min
}
Else
{
MsgBox, TrueCrypt not installed or version too old. Please install it first.
Run, %Windir%\explorer.exe "%A_ScriptDir%\.DO_NOT_DELETE\TrueCrypt for Windows"
}
return
