#Requires AutoHotkey v2.0+
#SingleInstance Force
#NoTrayIcon
Persistent()
SetWorkingDir(A_ScriptDir)

; Function to get the window title
GetWindowTitle() {
    return WinGetTitle("A")
}

; Function to get the window PID
GetWindowPID() {
    return WinGetPID("A")
}

; Function to kill all applications related to the last active window
KillRelatedApps() {
    global currentWindowPID
    killedCount := 0

    ; Get the process name of the last active window
    processName := GetProcessName(currentWindowPID)

    ; Get a list of all processes with the same name
    processes := GetProcessList(processName)

    ; Get the number of processes to be killed
    numProcesses := processes.Length

    ; Get the window title, ahk_class, and ahk_exe before killing processes
    windowTitle := GetWindowTitle()
    ahkClass := WinGetClass("A")
    ahkExe := WinGetProcessName("A")

    ; Prompt for confirmation
    confirmationMessage := "This will kill " numProcesses " instances related to:`n`nWindow Title: " windowTitle "`nahk_class: " ahkClass "`nahk_exe: " ahkExe "`n`nAre you sure?"
    if (MsgBox(confirmationMessage, "Confirm Kill", 4) == "No")
        return 0

    ; Kill each process in the list
    for process in processes {
        process.Terminate()
        killedCount++
    }

    ; Display message box with stored window title, ahk_class, and ahk_exe
    if (killedCount > 0) {
        MsgBox("Killed " killedCount " instances related to:`n`nWindow Title: " windowTitle "`nahk_class: " ahkClass "`nahk_exe: " ahkExe, "Process Killer")
    }

    return killedCount
}


; Helper function to get the process name from a PID
GetProcessName(pid) {
    process := ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process WHERE ProcessId=" pid)
    if (process.Count > 0) {
        return process.ItemIndex(0).Name
    } else {
        return ""
    }
}


; Helper function to get a list of processes with a given name
GetProcessList(processName) {
    processList := []
    for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process WHERE Name='" processName "'") {
        processList.Push(process)
    }
    return processList
}

; Main script
global currentWindowPID := GetWindowPID()
killedCount := KillRelatedApps()