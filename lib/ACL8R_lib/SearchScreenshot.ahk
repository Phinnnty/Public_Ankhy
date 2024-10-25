;;; SearchScreenshot.ahk 

#Requires AutoHotkey v2.0+

StartImageSearch() {
    static ScreenSnipperProcessName := "ScreenClippingHost.exe"
    SavedClip := ClipboardAll()
    A_Clipboard := "" ; Start off blank for clipboard detection
    RunWait("ms-screenclip:")
    WinWaitActive("ahk_exe " ScreenSnipperProcessName,, 2)
    Loop {
        DllCall("user32.dll\GetCursorPos", "int64P", &pt64:=0)
        try {
            if WinGetProcessName(hWnd := DllCall("GetAncestor", "Ptr", DllCall("user32.dll\WindowFromPoint", "int64",  pt64, "ptr"), "UInt", 2, "ptr")) != ScreenSnipperProcessName
                break
        } catch 
            break
    }
    ClipWait(1, 1)
    Sleep(100)
    if !DllCall("IsClipboardFormatAvailable", "uint", 2) ; Check for a bitmap stream
       return A_Clipboard := SavedClip ; Restore clipboard if user pressed Escape

    DllCall("OpenClipboard", "ptr", A_ScriptHwnd)
    hData := DllCall("GetClipboardData", "uint", 2, "ptr")
    hBitmap := DllCall("User32.dll\CopyImage", "UPtr", hData, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x2000, "Ptr")
    DllCall("CloseClipboard")


    ; Open Google Image Search and upload the image
    Run("https://www.google.com/imghp")
    WinWaitActive("Google Images")
    Sleep(1000)
    Send("{Tab 2}{Enter}")
    Sleep(800)
    Send("^v") ; Paste the image
    Sleep(800)
    Send("{Enter}")
}

; Ensure GDI+ library is loaded for saving the image
DllCall("LoadLibrary", "Str", "GdiPlus.dll")

StartImageSearch()