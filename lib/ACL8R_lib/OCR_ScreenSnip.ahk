;;; OCR_ScreenSnip.ahk 

#Requires AutoHotkey v2.0
#include ..\OCR-main\Lib\OCR.ahk
; https://github.com/Descolada/OCR - source of OCR for Capturing Text from Images

; Add the hotkey
^!o:: StartOCR()  ; Ctrl+Alt+O to trigger OCR

; Define the OCR function
StartOCR() {
    static ScreenSnipperProcessName := "ScreenClippingHost.exe"
    SavedClip := ClipboardAll()
    A_Clipboard := "" ; Start off blank for clipboard detection
    RunWait "ms-screenclip:"
    WinWaitActive "ahk_exe " ScreenSnipperProcessName,, 2
    Loop {
        DllCall("user32.dll\GetCursorPos", "int64P", &pt64:=0)
        try {
            if WinGetProcessName(hWnd := DllCall("GetAncestor", "Ptr", DllCall("user32.dll\WindowFromPoint", "int64",  pt64, "ptr"), "UInt", 2, "ptr")) != ScreenSnipperProcessName
                break
        } catch 
            break
    }
    ClipWait(1, 1)
    Sleep 100
    if !DllCall("IsClipboardFormatAvailable", "uint", 2) ; Check for a bitmap stream
       return A_Clipboard := SavedClip ; Restore clipboard if user pressed Escape

    DllCall("OpenClipboard", "ptr", A_ScriptHwnd)
    hData := DllCall("GetClipboardData", "uint", 2, "ptr")
    hBitmap := DllCall("User32.dll\CopyImage", "UPtr", hData, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x2000, "Ptr")
    DllCall("CloseClipboard")

    result := OCR.FromBitmap(hBitmap,, 2)
    text := rearrangeOCRresult(result)

    A_Clipboard := text
    Tooltip "Clipboard set to formatted OCR result:`n" text
    SetTimer () => Tooltip(), -7000
}

; Courtesy of rommmcek https://www.autohotkey.com/boards/viewtopic.php?f=83&t=116406&p=556071#p556071
; UPW OCR groups recognized text into areas, not lines: a known issue
; this function takes an OCR result and rearranges the recognized text into the lines where they appear
; - result: an OCR result
; - diff: tolerance of the lines/words. If 0 auto setting will occur (medium height (in pixels) of the text).
; returns a string with the recognized lines, separated by linefeed
rearrangeOCRresult(result, diff:=0) {
    local arr, hm, txt, wr, ht, vt, hd, vd, ds, aInd, lw, bb2, oy, arr, i, j, k, l, ii, oy
    loop (arr:=Map(), hm:=0, txt:="", wr:= 0, ht:= 2, vt:= 1, hd:= 2, vd:= 3, ds:= .75, diff:= 0, 2) {
        for lw in (aInd:= A_Index, bb1:= "[,;gjpqyQ]", bb2:= "[A-Z0-9%bdfhkltij]", wr? result.words: result.lines) {
            if (lb:= wr? lw: OCR.WordsBoundingRect(lw.Words*), aInd=1 && !diff) {
                hm+= lb.h
            } else {
                While (diff? "": diff:= Round(ds*hm/result.lines.Length), x:= lb.x, y:= lb.y, w:= lb.w, h:= lb.h, txt:= lw.text, A_Index<=(ma:=2*diff-1)) {
                    if arr.Has(yh:= (hh:=Round(y+h-(RegExMatch(txt, bb1)? RegExMatch(txt, bb2)? h/5: h/3: 0)))-(A_Index-diff) )
                        Break
                    else A_Index=ma? yh:=hh: ""
                }  arr.Has(yh)? "": arr[yh]:= Map(), arr[yh][x]:= [x, yh, w, h, txt]
            }
        }
    }
    mf(ks, ch, it) {
        Loop (gp:="", ks*it)
            gp.= ch
        Return gp
    }
    for i, j in (text:="", oy:=0, arr) {
        for k, l in (vp:= (ii:=i-oy)>vd*diff? mf(Round(ii/vd/diff), "`n", vt): "", text.= vp, oi:= i, ok:= 0, j)
            sp:= (kk:=k-ok)>hd*diff? mf(Round(kk/hd/diff), "`s", ht): "", text.= sp l[5] " ", ok:= k+l[3], oy:= l[2]
        text .= "`n"
    }
    return text
}

StartOCR()