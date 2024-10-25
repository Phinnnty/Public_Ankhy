#Requires AutoHotkey v2.0+
#SingleInstance Force

; Global variables
global NoteEdit
global MainGui

; Create and show the GUI
ShowNoteGui() {
    global NoteEdit, MainGui
    MainGui := Gui()
    MainGui.BackColor := "0x1E1E1E"
    NoteEdit := MainGui.Add("Edit", "r20 w400 -E0x200 +Border Background0x2D2D2D c0xE0E0E0")
    NoteEdit.SetFont("s10", "Consolas")
    NoteEdit.Focus()
    DllCall("dwmapi\DwmSetWindowAttribute", "Ptr", MainGui.Hwnd, "Int", 20, "Int*", 1, "Int", 4)
    DllCall("uxtheme\SetWindowTheme", "Ptr", NoteEdit.Hwnd, "Str", "DarkMode_Explorer", "Ptr", 0)
    SendMessage(0x20C, 0, 0x2D2D2D,, "ahk_id " NoteEdit.Hwnd)  ; Set scrollbar color
    MainGui.OnEvent("Escape", SaveAndHideGui)
    MainGui.Title := "Quick Note Taker"
    
    ; Load existing notes or create a new file
    if FileExist("QuickNote.txt") {
        FileContent := FileRead("QuickNote.txt")
        NoteEdit.Value := FileContent
    } else {
        FileAppend("", "QuickNote.txt")  ; Create an empty file
    }
    
    MainGui.Show()
    

}

; Save the note and hide the GUI
SaveAndHideGui(*) {
    global NoteEdit
    Note := NoteEdit.Value
    FileDelete("QuickNote.txt")
    FileAppend(Note, "QuickNote.txt")
    MainGui.Hide()
}

; Call the ShowNoteGui() function to create and show the GUI
ShowNoteGui()
