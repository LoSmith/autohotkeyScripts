#SingleInstance, Force
#KeyHistory, 0
SetBatchLines, -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
SetTitleMatchMode, 3 ; A window's title must exactly match WinTitle to be a match.
SetWorkingDir, %A_ScriptDir%
SplitPath, A_ScriptName, , , , thisscriptname
#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling
; DetectHiddenWindows, On
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
; SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ===========================================================================
; Run a program or switch to it if already running.
;    Target - Program to run. E.g. Calc.exe or C:\Progs\Bobo.exe
;    WinTitle - Optional title of the window to activate.  Programs like
;    MS Outlook might have multiple windows open (main window and email
;    windows).  This parm allows activating a specific window.
; Use RunOrActivateMultiParam() for applications that have multiple execution
; parameters when RunOrActivate() doesn't work
; ===========================================================================
; change this to your home directory path
SetWorkingDir = "C:\Users\schmida"

RunOrActivate(Target, WinTitle = "", Parameters = "")
{
     ; Get the filename without a path
     SplitPath, Target, TargetNameOnly
     
     Process, Exist, %TargetNameOnly%
     If ErrorLevel > 0
     PID = %ErrorLevel%
     Else
     Run, %Target% "%Parameters%", , , PID
     
     ; At least one app (Seapine TestTrack wouldn't always become the active
     ; window after using Run), so we always force a window activate.
     ; Activate by title if given, otherwise use PID.
     If WinTitle <> 
     {
          SetTitleMatchMode, 2
          WinWait, %WinTitle%, , 3
          TrayTip, , Activating Window Title "%WinTitle%" (%TargetNameOnly%)
          WinActivate, %WinTitle%
     }
     Else
     {
          WinWait, ahk_pid %PID%, , 3
          TrayTip, , Activating PID %PID% (%TargetNameOnly%)
          WinActivate, ahk_pid %PID%
     }
     
     
     SetTimer, RunOrActivateTrayTipOff, 1
}

RunOrActivateMultiParam(Target, WinTitle = "", Param1 = "", Param2 = "", Param3 = "")
{
     ; Get the filename without a path
     SplitPath, Target, TargetNameOnly
     
     Process, Exist, %TargetNameOnly%
     If ErrorLevel > 0
     PID = %ErrorLevel%
     Else
     Run, %Target% "%Param1%" "%Param2%" "%Param3%", , , PID
     
     ; At least one app (Seapine TestTrack wouldn't always become the active
     ; window after using Run), so we always force a window activate.
     ; Activate by title if given, otherwise use PID.
     If WinTitle <> 
     {
          SetTitleMatchMode, 2
          WinWait, %WinTitle%, , 3
          TrayTip, , Activating Window Title "%WinTitle%" (%TargetNameOnly%)
          WinActivate, %WinTitle%
     }
     Else
     {
          WinWait, ahk_pid %PID%, , 3
          TrayTip, , Activating PID %PID% (%TargetNameOnly%)
          WinActivate, ahk_pid %PID%
     }
     
     
    SetTimer, RunOrActivateTrayTipOff, 1
}

; Turn off the tray tip
RunOrActivateTrayTipOff:
SetTimer, RunOrActivateTrayTipOff, off
TrayTip
Return

;Keybinds
;F12::RunOrActivateMultiParam("C:\Users\colin\AppData\Local\wsltty\bin\mintty.exe","", "--WSL=WLinux", "--configdir=C:\Users\colin\AppData\Roaming\wsltty'", "-~")
#c::RunOrActivate("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",,"www.google.de")
#e::RunOrActivate("C:\Program Files (x86)\FreeCommander XE\FreeCommander.exe")
#d::Run "C:\Program Files\ConEmu\ConEmu64.exe"
Capslock::Esc

; Example uses...
;F12::RunOrActivate("C:\cygwin64\bin\mintty.exe","","-")
;^F11::RunOrActivate("C:\Program Files\Mozilla Firefox\firefox.exe")
;NumpadDown::RunOrActivate("C:\Program Files\Internet Explorer\iexplore.exe") 
;NumpadPgDn::RunOrActivate("C:\Program Files\Notepad++\notepad++.exe")
;NumpadRight::RunOrActivate("C:\Program Files\Pidgin\pidgin.exe", "cevista") 
; Outlook can have multiple child windows, so specify which window to activate 
;NumpadClear::RunOrActivate("C:\Program Files\Microsoft Office\OFFICE12\OUTLOOK.EXE","Microsoft Outlook")
;Minimize/maximize active window
;^Down::WinMinimize, A
;^Up::WinRestore, A
;^+Up::WinMaximize, A
;!.::Send {Volume_Mute}
;^+Insert::Send {Media_Play_Pause}
;^+Up::Send {Volume_Up}
;^+Down::Send {Volume_Down}
;^+Left::Send {Media_Prev}
;^+Right::Send {Media_Next}
