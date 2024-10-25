#Requires AutoHotkey v2.0
#SingleInstance Force
; https://github.com/jNizM/ahk-scripts-v2/blob/main/src/Others/CreateUUID.ahk


UUIDSnatchClipboard() {
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

CreateUUID() {
    static RPC_S_OK := 0, UUID := ""
    pUUID := Buffer(16)
    if (DllCall("rpcrt4\UuidCreate", "Ptr", pUUID) = RPC_S_OK) {
        if (DllCall("rpcrt4\UuidToStringW", "Ptr", pUUID, "Ptr*", &StringUuid := 0) = RPC_S_OK) {
            UUID := StrGet(StringUuid)
            DllCall("rpcrt4\RpcStringFreeW", "Ptr*", StringUuid)
        }
    }
    return UUID
}

; Generate UUID and add it to clipboard
generatedUUID := CreateUUID()
A_Clipboard := generatedUUID

ToolTip("Generated UUID: " . generatedUUID . " and added it to the clipboard")
SetTimer(() => ToolTip(), -5000)  ; Remove tooltip after 5 seconds
