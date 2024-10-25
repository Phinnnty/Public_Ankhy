#Requires AutoHotkey v2.0
; https://github.com/jNizM/ahk-scripts-v2/blob/main/src/Others/CreateGUID.ahk
#SingleInstance Force

{
GUIDSnatchClipboard() {
    savedClipboard := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    if (!ClipWait(2)) {
        A_Clipboard := savedClipboard
        return ""
    }
    clipText := A_Clipboard
    A_Clipboard := savedClipboard
    return clipText
}

CreateGUID() {
    static S_OK := 0, GUID := ""

    pGUID := Buffer(16)
    if (DllCall("ole32\CoCreateGuid", "Ptr", pGUID) = S_OK) {
        Size := VarSetStrCapacity(&GUID, 38)
        if (DllCall("ole32\StringFromGUID2", "Ptr", pGUID, "Str", GUID, "Int", Size + 1)) {
            return GUID
        }
    }
    return
}

; Generate GUID and add it to clipboard
generatedGUID := CreateGUID()
A_Clipboard := generatedGUID

ToolTip("Created GUID:" . generatedGUID . " and added it to the clipboard")
SetTimer(() => ToolTip(), -5000)  ; Remove tooltip after 3 seconds
}
