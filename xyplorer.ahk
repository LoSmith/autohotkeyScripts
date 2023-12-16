#Requires AutoHotkey v2.0

#e::
{
   xyplorerPath := "C:\apps\xyplorer\XYplorer.exe"
   xyplorerId := "ahk_exe XYplorer.exe"   

   if (WinExist(xyplorerId))
   {
      WinActivate(xyplorerId)
      WinMaximize(xyplorerId)
   }
   else
   {
      Run xyplorerPath
      Sleep 250
      WinActivate(xyplorerId)
      WinMaximize(xyplorerId)
   }
}