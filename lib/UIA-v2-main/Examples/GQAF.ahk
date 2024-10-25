#Requires AutoHotkey v2
#include ..\Lib\UIA.ahk
#SingleInstance Force
SetTitleMatchMode(3)

^!#M::
{
    WinWaitActive("GQAF")
    gqafxEl := UIA.ElementFromHandle("GQAF ahk_exe gqafx.exe")

    fsHostElement := gqafxEl.ElementFromPath("IYqIY/KuuK")
    fsPortElement := gqafxEl.ElementFromPath("IYqIY/KwuK")
    appDirElement := gqafxEl.ElementFromPath("IYqIY/Kqv")

    fsHostElement.Highlight()

    fsHost := fsHostElement.Name
    fsPort := fsPortElement.Name
    appDir := appDirElement.Name

    MsgBox("File Server Host: " fsHost "`nFile Server Port: " fsPort "`nApplicative Dir: " appDir)

}

 
;; #include UIA.ahk

;;onyxEl := UIA.ElementFromHandle("MXEM PROD ahk_exe onyx.exe")
;; onyxEl.ElementFromPath("YE/S").Click("left")
Sleep(200)
;; onyxEl.ElementFromPath("9B").Click("left") ;; Doesn't work for some reason? 

;; Type: 50011 (MenuItem) Name: "Add environment" LocalizedType: "menu item" AutomationId: "JavaFX24529"

;; on the Add Environment Dialogue Box
;; onyxEl := UIA.ElementFromHandle("Add environment ahk_exe onyx.exe")
;; Click on the FS host
;; onyxEl.ElementFromPath("Y34").Click("left")
;; Paste the fs host 

;; Click te Port edit box 
;; onyxEl.ElementFromPath("Y4").Click("left")
;; paste the fs port number

;; Click the Register using App Dir
;; onyxEl.ElementFromPath("Y2").Click("left")

;; Click on the app dir edit box
;; onyxEl.ElementFromPath("Y4/").Click("left")
;; Paste the app dir 
