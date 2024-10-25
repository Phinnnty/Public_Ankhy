;;; ACL8R AHK v2 Script 
;;; Performance Improvement Tool 
;;; Inspired by mxaccellerator & https://github.com/wsnh2022/AutoHotkey-V2/tree/main/OneMenu%20Project

#Requires AutoHotkey v2.0+
#SingleInstance Force
#Warn All, StdOut  ; Enable all warnings

Persistent()
SetWorkingDir(A_ScriptDir)

; Error logging
LogFile := A_ScriptDir . "\error_log.txt"

; Watchdog timer
SetTimer(CheckScriptStatus, 500000)  

;; ---------- MAIN SCRIPT ----------

try {
    ; Immediate logging
    LogError("Script started at " . A_Now)

    #Include lib\ACL8R_lib\HyperKey_newV2.ahk
    #Include lib\ACL8R_lib\Logins_newV2.ahk
    #Include lib\ACL8R_lib\GQAF_Search.ahk
    #Include lib\ACL8R_lib\MXEM_Search.ahk
    #Include lib\HotGestures-main\HotGestures.ahk
    #Include lib\ahk2_lib-master\WebView2\WebView2.ahk
    #Include lib\ACL8R_lib\ACL8R_lib.ahk


    GetWindowTitle() {
        return WinGetTitle("A")
    }

    GetWindowPID() {
        return WinGetPID("A")
    }

    ; Create the main menu
    ACL8R := Menu()

    ; Dynamic placeholder menu item to indicate the last active window to the user
    ACL8R.Add("WindowTitleItem", (*) => {}), ACL8R.SetIcon("WindowTitleItem", "Icons\ACL8R_ICON.png", 1.9)
    ; Add clipboard content placeholder item
    ACL8R.Add("ClipboardContentItem", (*) => {}), ACL8R.SetIcon("ClipboardContentItem", "Icons\Clipboard.png", 1)
    ; Add a separator
    ACL8R.Add()

    ; Add submenus to the main menu
    ACL8R.Add("Screenshot", CreateScreenshotMenu()),
    ACL8R.Add("Google Search", CreateGoogleSearchMenu()), ACL8R.SetIcon("Google Search", "Icons\Websearch.png", 1)
    ACL8R.Add(),
    ACL8R.Add("Ask ChatGPT", CreateGPTMenu()), ACL8R.SetIcon("Ask ChatGPT", "Icons\GPT.png", 1)
    ACL8R.Add("Ask Claude 3.5", CreateCluadeMenu()), ACL8R.SetIcon("Ask Claude 3.5", "Icons\Claude-3.5.png", 1)
    ACL8R.Add()
    ACL8R.Add("Atlassian Suite", CreateAttlasianMenu()), ACL8R.SetIcon("Atlassian Suite", "Icons\atlassian.png", 1.5)
    ACL8R.Add("Onyx Suite", CreateOnyxMenu()),
    ACL8R.Add("MX.3 Tools", CreateMX3Menu()),ACL8R.SetIcon("MX.3 Tools", "Icons\Murex_M.png", 1)
    ACL8R.Add("Work Management`tCAPSLOCK + J", (*) => Run("lib\ACL8R_lib\JaskManagement.ahk")),
    ACL8R.Add("Scratchpad`tCAPSLOCK + N", (*) => Run("lib\ACL8R_lib\Scratchpad.ahk")),
    ACL8R.Add()
    ACL8R.Add("Format Text", CreateFormatMenu()),
    ACL8R.Add("Wrap Text", CreateWrapMenu()),
    ACL8R.Add("Comment Code", CreateCommentntMenu()),
    ACL8R.Add("API Menu", CreateAPIMenu()),    
    ACL8R.Add()
    ACL8R.Add("System", CreateSystemAppsMenu()),
    
    TraySetIcon("Icons/ACL8R_ICON.png") 

;; ---------- GLOBAL VARIABLES ----------

    global currentMenuItemName := "WindowTitleItem"
    global currentWindowPID := GetWindowPID()
    global clipboardMenuItemName := "ClipboardContentItem"
    global clipboardContent := ""


} catch as err {
    LogError("Critical error in main script: " . err.Message . " | Stack: " . err.Stack)
    MsgBox("A critical error occurred. Check the error log for details.")
    ExitApp()
}
;; HOTKEYS TO START THE SCRIPT
#Include lib\HotGestures-main\HotGestures.ahk

global hgs := HotGestures()
CreateAndShowMenu() {
    global currentWindowPID := GetWindowPID()
    GestureHandler.HandleGesture()
}

; Create a global instance of the DrawingBoard class
global tooltipBoard := HotGestures.DrawingBoard(0xFE4F7F)  ; Pass the desired pen color as an argument

; GestureHandler class
class GestureHandler {
    static HandleGesture() {
        try {
            currentWindowTitle := GetWindowTitle()
            newWindowName := StrLen(currentWindowTitle) > 50 ? SubStr("`t" currentWindowTitle, 1, 50) . "..." : "`t" . currentWindowTitle
            RenameMenuItem(newWindowName)

            clipboardContent := CopyToClipboard()
            global Search_text := clipboardContent

            if (StrLen(clipboardContent) == 0) {
                RenameClipboardMenuItem("`t Clipboard is empty")
            } else {
                truncatedText := StrLen(clipboardContent) > 50 ? SubStr(clipboardContent, 1, 50) . "..." : clipboardContent
                RenameClipboardMenuItem("`t Clipboard: " . truncatedText)
            }

            ACL8R.Show()
        } catch as err {
            LogError("Error in GestureHandler: " . err.Message)
            MsgBox("An error occurred with GestureHandler. Check the error log for details.")
        }
    }
}

;; ---------- SET DARK MODE ----------

SetPreferredAppMode()
; Build the menu, then call FlushMenuThemes
FlushMenuThemes()

AppsUseLightTheme() {
    keyName := "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    valueName := "AppsUseLightTheme"
    return RegRead(keyName, valueName)
}

SetPreferredAppMode(option := "") {
    static options := Map()
    if (!options.Count) {
        options.CaseSense := false
        options.Set(
            "Default", 0,
            "AllowDark", 1,
            "ForceDark", 2,
            "ForceLight", 3,
            "Max", 4
        )
        options.Default := !AppsUseLightTheme()
    }
    hModule := DllCall("kernel32.dll\GetModuleHandle", "str", "uxtheme.dll", "ptr")
    ; These are undocumented functions. They must be called via ordinal.
    localSetPreferredAppMode := DllCall("kernel32.dll\GetProcAddress", "ptr", hModule, "ptr", 135, "ptr")
    DllCall(localSetPreferredAppMode, "int", options.Get(option))
    DllCall("kernel32.dll\FreeLibrary", "ptr", hModule)
}       

FlushMenuThemes() {
    hModule := DllCall("kernel32.dll\GetModuleHandle", "str", "uxtheme.dll", "ptr")
    ; Undocumented functions must be called via ordinal.
    localFlushMenuThemes := DllCall("kernel32.dll\GetProcAddress", "ptr", hModule, "ptr", 136, "ptr")
    DllCall(localFlushMenuThemes)
    DllCall("kernel32.dll\FreeLibrary", "ptr", hModule)
}

CreateAndShowMenu()
ExitApp()