#notrayicon
#singleinstance force
settitlematchmode, 2

Rel = 0005FLA 
wTitle = Counterparty Wallet Manager

ReleaseDir = %appdata%\Boottle000\%Rel%

EnvSet, path, %path%;%ReleaseDir%\`%System`%;%ReleaseDir%\Python33

ifWinExist, %wTitle%
 {
 Winrestore
 exitapp
 }

ifNOTexist %APPDATA%\CounterParty\Counterpartyd
 filecreatedir, %APPDATA%\CounterParty\Counterpartyd
 
ifNOTexist, %ReleaseDir%
{

FileCreateDir, %ReleaseDir%

Gui, Add, text,, Please wait while unpacking modules to your 'AppData' directory...
Gui, Add, Progress, vlvl  -Smooth p0 w350 h12 ; PBS_MARQUEE = 0x8

Gui, -MinimizeBox -Sysmenu
Gui, Show, , BoottleXCP ; PyBuilder
SetTimer, Push, 61

sleep 450
 
 FileInstall, setup.tmp, %ReleaseDir%\setup.tmp, 1
 runwait, %ReleaseDir%\setup.tmp -y -o"%ReleaseDir%\..\.." ,, hide  
 
} 

  Setworkingdir, %ReleaseDir%\Python33\BoottleXCP
  EnvSet, prompt, $d$s$t$G$S
  EnvSet, dircmd, /b
  
DetectHiddenWindows, On
Gui, Destroy
FileDelete, %ReleaseDir%\setup.tmp
goto chstart   
 
exitapp

Push:
GuiControl, , lvl, +2
Return

chstart:

GetKeyState, state, Shift
if state = D
{
 
  EnvSet, prompt, $d$s$t$G$S
  EnvSet, dircmd, /b
 
  run, cmd /k title Console && python -i -c "import sys`, math `; print(sys.version)" 
exitapp
}    

Gui, Destroy 
HourGlassON()
run, ..\python.exe boottlexcp.py ,, hide
  
winwait, %wTitle%
 
winactivate
Gui, Destroy
HourGlassOFF()
winshow, %wTitle% ; nb_%Rel%

exitapp
return 

HourGlassON()
{
   CursorHandle := DllCall( "LoadCursor", Uint,0, Int, 32650 )
   DllCall( "SetSystemCursor", Uint,CursorHandle, Int, 32512)
}

HourGlassOFF() 
{
   DllCall( "SystemParametersInfo", UInt, 0x57, UInt,0, UInt,0, UInt,0 )
}
