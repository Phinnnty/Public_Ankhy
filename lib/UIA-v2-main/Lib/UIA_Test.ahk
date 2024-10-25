#Requires AutoHotkey v2.0
#Include UIA.ahk

^!#2::
{
; Activate the GQAF window (adjust the window title as needed)
if !WinExist("GQAF")
    MsgBox("GQAF window not found!")

; Create a UIA element for the GQAF window
gqafWindow := UIA.ElementFromHandle("GQAF")

; Retrieve the File Server Host
fsHost := gqafWindow.FindFirst("AutomationId=JavaFX1544")
if fsHost
    MsgBox("File Server Host: " fsHost.Name)

; Retrieve the File Server Port
fsPort := gqafWindow.FindFirst("AutomationId=JavaFX1555")
if fsPort
    MsgBox("File Server Port: " fsPort.Name)

; Retrieve the Applicative Dir
appDir := gqafWindow.FindFirst("AutomationId=JavaFX1579")
if appDir
    MsgBox("Applicative Dir: " appDir.Name)
}