; --------------------------------------------------------------
; notes
; --------------------------------------------------------------
; ! = alt
; ^ = ctrl
; + = shift
; # = lwin|rwin
;
#SingleInstance Force
#Requires AutoHotkey v2.0+


SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode(2)

LookUp() {
    MyClip := ClipboardAll()
    A_Clipboard := "" ; empty the clipboard
    Send("^c")
    Errorlevel := !ClipWait(2)
    if ErrorLevel  ; ClipWait timed out.
    {
        ToolTip("Clipboard capture failed. Please try again.")
        Sleep(1500) ; Display the tooltip for 1.5 seconds
        ToolTip() ; Removes the tooltip
        A_Clipboard := MyClip
        return
    }
    if RegExMatch(A_Clipboard, "^[^ ]*\.[^ ]*$")
    {
        Run("`"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe`" " A_Clipboard)
    }
    else 
    {
        ; Modify some characters that screw up the URL
        ; RFC 3986 section 2.2 Reserved Characters (January 2005):  !*'();:@&=+$,/?#[]
        ; StrReplace() is not case sensitive
        ; check for StringCaseSense in v1 source script
        ; and change the CaseSense param in StrReplace() if necessary
        A_Clipboard := StrReplace(A_Clipboard, "`r`n", A_Space)
        A_Clipboard := StrReplace(A_Clipboard, "#", "`%23")
        A_Clipboard := StrReplace(A_Clipboard, "&", "`%26")
        A_Clipboard := StrReplace(A_Clipboard, "+", "`%2b")
        A_Clipboard := StrReplace(A_Clipboard, "`"", "`%22")
        Run("https://www.google.com/search?hl=en&q=" . A_Clipboard) ; uriEncode(clipboard)
    }
    A_Clipboard := MyClip
}
