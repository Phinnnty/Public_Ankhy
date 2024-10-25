#Requires AutoHotkey v2.0
#SingleInstance Force

#Include lib\HotGestures-main\HotGestures.ahk ; by Tebyaki https://github.com/Tebayaki/HotGestures
#Include lib\ACL8R_lib\HyperKey_newV2.ahk 
Run("lib\ACL8R_lib\ScreenClip.ahk") ; This is a AHK v1 script that can't be #Included, it runs with WINKEY + LBUTTON 

GetWindowTitle() {
    return WinGetTitle("A")
}

GetWindowPID() {
    return WinGetPID("A")
}

TraySetIcon("Icons/ACL8R_ICON.png") 

; Create the main menu
ACL8R := Menu()

global hgs := HotGestures()

; Define the gestures
z := HotGestures.Gesture("Z:2,0|4,-1|8,0|10,0|14,0|17,-1|18,-2|18,-1|19,-1|17,-1|16,0|15,0|12,-1|11,-1|12,0|13,0|12,0|13,0|10,0|6,0|4,0|1,0|-1,1|-3,2|-5,2|-5,4|-7,5|-8,6|-10,6|-12,7|-13,9|-15,8|-14,8|-14,9|-13,7|-12,7|-12,7|-11,6|-12,7|-13,7|-13,7|-12,5|-11,5|-9,4|-8,4|-6,3|-4,2|-1,1|2,0|5,0|9,0|12,0|16,0|19,0|23,0|27,0|34,0|35,1|33,1|31,0|25,0|19,0|13,0|8,0")
l := HotGestures.Gesture("L:-1,1|0,2|0,4|0,6|0,8|0,10|0,12|0,14|0,16|1,16|2,16|3,16|4,16|5,16|6,16|7,16|8,16|9,16|10,16|11,16|12,16")

; Register gestures
hgs.Register(z, "HandleZGesture") ; Draw the letter Z when holding down the right mouse button
hgs.Register(l, "HandleLGesture") ; Draw the letter I when holding down the right mouse button

HandleZGesture() {
    Run("Public_Ahnky.ahk")
}

;;HandleLGesture() {
;;    Run("INSERT_AHK_SCRIPT_HERE") ; You can add another script to execute by drawing I with your mouse
;;}

; Hotkey for the right mouse button
$RButton:: {
    hgs.Start()
    KeyWait("RButton")
    hgs.Stop()

    if hgs.Result.Valid {
        switch hgs.Result.MatchedGesture {
            case z:
                GestureManager.HandleGesture("Z")
            case l:
                GestureManager.HandleGesture("L")
            default:
                return
        }
    } else {
        Send("{RButton}")
    }
}


; Create a global instance of the DrawingBoard class
global tooltipBoard := HotGestures.DrawingBoard(0xFE4F7F)  ; Pass the desired pen color as an argument
class GestureManager {
    static HandleGesture(gesture) {
        try {
            global tooltipBoard
            tooltipBoard.Show()

            ; Copy highlighted text
            clipboardContent := CopyToClipboard()

            switch gesture {
                case "Z":
                    tooltipBoard.DrawTip("Opening Anky menu")
                   ; tooltipBoard.Show(ACL8R_ICON.jpg)
                    Run(A_ScriptDir . "\Public_Ahnky.ahk")
            ;    case "L":
            ;       tooltipBoard.DrawTip("Opening Logins menu")
            ;       Run(A_ScriptDir . "\INSERT_AHK_SCRIPT_HERE.ahk") ; INSERT THE SCRIPT FOR I GESTURE HERE
                default:
                    tooltipBoard.DrawTip("Unrecognized gesture: " . gesture)
            }

            Sleep(1000)
            tooltipBoard.DrawTip("")
            tooltipBoard.Hide()
        } catch as err {
            MsgBox("Error in GestureManager: " . err.Message)
        }
    }
}


; Show the tooltip when the script starts
tooltipBoard.Show()
tooltipBoard.DrawTip("Anky is now active")
Sleep(2000)  ; Display the tooltip for 2 seconds
tooltipBoard.DrawTip("")
tooltipBoard.Hide()

ShowTooltip(message) {
    global tooltipBoard
    tooltipBoard.Show()
    tooltipBoard.DrawTip(message)
    Sleep(2000)  ; Display the tooltip for 2 seconds
    tooltipBoard.DrawTip("")
    tooltipBoard.Hide()
    
}

PerformGoogleSearch() {
    global tooltipBoard

    ; Get the latest clipboard content
    Search_text := CopyToClipboard()

    ; Display the tooltip
    tooltipBoard.Show()
    tooltipBoard.DrawTip("Searching Google for '" . Search_text . "'")

    ; Open the Google search URL in the default browser
    Run("https://google.ie/search?q=" . Search_text)

    ; Hide the tooltip after 2 seconds
    Sleep(2000)
    tooltipBoard.DrawTip("")
    tooltipBoard.Hide()
}

CopyToClipboard() {
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

ShowStartupNotification(tpkNumber) {
    tooltipBoard.Show()
    tooltipBoard.DrawTip("Running TPK" tpkNumber " Start Up Scripts")
    Sleep(2000)
        tooltipBoard.DrawTip("")
        tooltipBoard.Hide()
}


;; ---------- HOTKEYS TO TRIGGER SCRIPTS ----------
;; N.B. This script uses a hyperkey where CAPSLOCK is mapped to the CTRL + ALT + WIN keys. 

^!#g::PerformGoogleSearch() ; Ctrl + Alt + Win + G
^!#j::Run("lib\ACL8R_lib\JaskManagement.ahk") ; Ctrl + Alt + Win + J
^!#n::Run("lib\ACL8R_lib\Scratchpad.ahk") ; Ctrl + Alt + Win + N

; AHK Comment 
^!#A::CommenterManager.CommentWrap(";;", "")
; AHK Uncomment
^!#U::CommenterManager.CommentUnWrap()


;; Class to perform comment actions on code 
class CommenterManager {
    static CommentWrap(startChar, endChar) {
        global tooltipBoard
        
        ; Save current clipboard content
        savedClip := ClipboardAll()
        
        ; Clear clipboard and copy selected text
        A_Clipboard := ""
        Send("^c")
        if !ClipWait(2) {
            tooltipBoard.DrawTip("No text selected")
            Sleep(1000)
            tooltipBoard.Hide()
            return
        }
        
        ; Process the copied text
        clipText := A_Clipboard
        lines := StrSplit(clipText, "`n", "`r")
        commentedText := ""
        for index, line in lines {
            commentedText .= startChar . line . endChar . (index < lines.Length ? "`n" : "")
        }
        
        ; Set clipboard to commented text and paste
        A_Clipboard := commentedText
        Send("^v")
        
        ; Show tooltip
        tooltipBoard.Show()
        tooltipBoard.DrawTip("Text commented")
        Sleep(1000)
        tooltipBoard.Hide()
        
        ; Restore original clipboard
        A_Clipboard := savedClip
    }
   static CommentUnWrap() {
        global tooltipBoard
        A_Clipboard := ""
        Sleep(100)
        Send("^c")
        ClipWait(2)
        if (A_Clipboard != "") {
            tooltipBoard.Show()
            tooltipBoard.DrawTip("Uncommenting code")
            lines := StrSplit(A_Clipboard, "`n", "`r")
            uncommentedText := ""
            for index, line in lines {
                uncommentedLine := RegExReplace(line, "^\s*;;", "")
                uncommentedLine := RegExReplace(uncommentedLine, "^\s*#", "")
                uncommentedLine := RegExReplace(uncommentedLine, "^\s*<!--", "")
                uncommentedLine := RegExReplace(uncommentedLine, "-->$", "")
                uncommentedText .= uncommentedLine . (index < lines.Length ? "`n" : "")
            }
            A_Clipboard := uncommentedText
            Send("^v")
            Sleep(2000)
            tooltipBoard.DrawTip("")
            tooltipBoard.Hide()
        } else {
            ToolTip("No text copied to clipboard.")
            SetTimer(() => ToolTip(), -2000)
        }
    }
}