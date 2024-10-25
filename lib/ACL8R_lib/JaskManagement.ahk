#Include ..\jsongo_AHKv2-main\src\jsongo.v2.ahk

#SingleInstance Force
#Requires AutoHotkey v2.0+

; Define default file path
DefaultFilePath := "NewTaskList.json"

; Initialize Main GUI
Main := Gui("+Resize +Theme", "Work Management")
Main.BackColor := "0x1E1E1E"
Main.SetFont("c0xE0E0E0")  ; Set text color for all controls
Main.Opt("+Theme")  ; Enable visual styles
Main.MarginX := 20
Main.MarginY := 20


; Define Controls
Main.Add("Text", "xm ym w120 c0xE0E0E0", "Task Name:")
TaskNameEdit := Main.Add("Edit", "x+10 yp w200 vTaskName Background0x2D2D2D c0xE0E0E0")

Main.Add("Text", "x+20 w120 c0xE0E0E0", "Task Description:")
TaskDescriptionEdit := Main.Add("Edit", "x+10 yp w200 vTaskDescription Background0x2D2D2D c0xE0E0E0")

Main.Add("Text", "xm y+30 w120 c0xE0E0E0" , "Priority:")
PriorityDropdown := Main.Add("DropDownList", "x+10 yp w200 vTaskPriority Background0x2D2D2D c0xE0E0E0", ["Low", "Medium", "High"])

Main.Add("Text", "x+20 w120 c0xE0E0E0", "Difficulty:")
DifficultyDropdown := Main.Add("DropDownList", "x+10 yp w200 vTaskDifficulty Background0x2D2D2D c0xE0E0E0", ["Easy", "Moderate", "Hard"])

Main.Add("Text", "xm y+30 w120 c0xE0E0E0", "Due Date (DD/MM/YYYY):")
DueDateEdit := Main.Add("Edit", "x+10 yp w200 vTaskDueDate Background0x2D2D2D c0xE0E0E0")

Main.Add("Text", "x+20 w120 c0xE0E0E0", "Status:")
StatusDropdown := Main.Add("DropDownList", "x+10 yp w200 vTaskStatus Background0x2D2D2D c0xE0E0E0", ["Not Started", "In Progress", "Completed"])

; Buttons for Task Controls
AddTaskButton := Main.Add("Button", "xm y+30 w100 Background0x3D3D3D c0xE0E0E0", "Add Task")
ClearFieldsButton := Main.Add("Button", "x+10 w100 Background0x3D3D3D c0xE0E0E0", "Clear Fields")

; Task management buttons
ButtonY := "y+30"
ButtonW := "w120"
ButtonSpacing := "x+10"
Main.Add("Text", "xm y+10 w600 0x10")  ; Horizontal line as a separator 
EditTaskButton := Main.Add("Button", "xm " ButtonY " " ButtonW " Background0x3D3D3D c0xE0E0E0", "Edit Task")
DeleteTaskButton := Main.Add("Button", ButtonSpacing " " ButtonW " Background0x3D3D3D c0xE0E0E0", "Delete Task")
SaveButton := Main.Add("Button", ButtonSpacing " " ButtonW " Background0x3D3D3D c0xE0E0E0", "Save Tasks")
LoadButton := Main.Add("Button", ButtonSpacing " " ButtonW " Background0x3D3D3D c0xE0E0E0", "Load Tasks")
Main.Add("Text", "xm y+10 w600 0x10")  ; Horizontal line as a separator
TaskListView := Main.Add("ListView", "xm y+30 w600 h280 Background0x2D2D2D c0xE0E0E0", ["Task Name", "Task Description", "Priority", "Difficulty", "Due Date", "Status"])
SendMessage(0x1033, 0, 0x2D2D2D, TaskListView.Hwnd)  ; Set header background color
SendMessage(0x1034, 0, 0xE0E0E0, TaskListView.Hwnd)  ; Set header text color
TaskListView.Opt("-Grid")
SendMessage(0x101E, 0, DllCall("GetSysColorBrush", "Int", 15, "Ptr"), TaskListView.Hwnd)
TaskListView.OnEvent("ItemSelect", TaskSelected)
TaskListView.OnEvent("DoubleClick", TaskSelected)

; Calendar sync buttons at the bottom
CalendarButtonY := "y+20"
CalendarButtonW := "w150"

CreateCalendarItemButton := Main.Add("Button", "xm " CalendarButtonY " " CalendarButtonW, "Create Calendar Item")
SyncAllButton := Main.Add("Button", ButtonSpacing " " CalendarButtonW, "Sync All with Outlook")

; Status bar
StatusBar := Main.Add("Text", "xm y+20 w600 h20 vStatusBar", "")

SetButtonDarkMode(AddTaskButton.Hwnd)
SetButtonDarkMode(ClearFieldsButton.Hwnd)
SetButtonDarkMode(EditTaskButton.Hwnd)
SetButtonDarkMode(DeleteTaskButton.Hwnd)
SetButtonDarkMode(SaveButton.Hwnd)
SetButtonDarkMode(LoadButton.Hwnd)
SetButtonDarkMode(CreateCalendarItemButton.Hwnd)
SetButtonDarkMode(SyncAllButton.Hwnd)
SendMessage(0x101E, 0, DllCall("GetSysColorBrush", "Int", 15, "Ptr"), TaskListView.Hwnd)


; Event Handlers
AddTaskButton.OnEvent("Click", AddTask)
ClearFieldsButton.OnEvent("Click", ClearFields)
EditTaskButton.OnEvent("Click", EditTask)
DeleteTaskButton.OnEvent("Click", DeleteTask)
SaveButton.OnEvent("Click", SaveTasks)
LoadButton.OnEvent("Click", LoadTasks)
CreateCalendarItemButton.OnEvent("Click", CreateCalendarItem)
SyncAllButton.OnEvent("Click", SyncAllTasksWithOutlook)


; Hotkey to show the GUI
^!#w::Main.Show()

; Close the GUI with ESC
Main.OnEvent("Escape", GuiClose)

; Show GUI
Main.Show()
DllCall("uxtheme\SetWindowTheme", "Ptr", Main.Hwnd, "Str", "DarkMode_Explorer", "Ptr", 0)

; Automatically load tasks from TaskList if it exists
SetTimer(LoadDefaultTasks, -100)

return

; Functions and Handlers

; Add a new task to the ListView
AddTask(*) {
    Global TaskNameEdit, TaskDescriptionEdit, PriorityDropdown, DifficultyDropdown, DueDateEdit, StatusDropdown, TaskListView, StatusBar

    if !ValidateTask(TaskNameEdit.Value, TaskDescriptionEdit.Value, DueDateEdit.Value) {
        return
    }

    AddTaskToListView(TaskNameEdit.Value, TaskDescriptionEdit.Value, PriorityDropdown.Text, DifficultyDropdown.Text, DueDateEdit.Value, StatusDropdown.Text)
    StatusBar.Text := "Task added: " TaskNameEdit.Value
    ClearFields()
}

; Clear all input fields
ClearFields(*) {
    Global TaskNameEdit, TaskDescriptionEdit, PriorityDropdown, DifficultyDropdown, DueDateEdit, StatusDropdown
    TaskNameEdit.Value := ""
    TaskDescriptionEdit.Value := ""
    PriorityDropdown.Text := "Low"
    DifficultyDropdown.Text := "Easy"
    DueDateEdit.Value := ""
    StatusDropdown.Text := "Not Started"
}

; Edit the selected task in the ListView
EditTask(*) {
    Global TaskNameEdit, TaskDescriptionEdit, PriorityDropdown, DifficultyDropdown, DueDateEdit, StatusDropdown, TaskListView, StatusBar

    Row := TaskListView.GetNext()
    if (Row = 0) {
        StatusBar.Text := "Error: Please select a task to edit."
        return
    }

    if !ValidateTask(TaskNameEdit.Value, TaskDescriptionEdit.Value, DueDateEdit.Value) {
        return
    }

    TaskListView.Modify(Row, "", TaskNameEdit.Value, TaskDescriptionEdit.Value, PriorityDropdown.Text, DifficultyDropdown.Text, DueDateEdit.Value, StatusDropdown.Text)
    StatusBar.Text := "Task edited: " TaskNameEdit.Value
    ClearFields()
}

; Delete the selected task from the ListView
DeleteTask(*) {
    Global TaskListView, StatusBar

    Row := TaskListView.GetNext()
    if (Row = 0) {
        StatusBar.Text := "Error: Please select a task to delete."
        return
    }

    TaskName := TaskListView.GetText(Row, 1)
    TaskListView.Delete(Row)
    StatusBar.Text := "Task deleted: " TaskName
    ClearFields()
}

; Populate input fields when a task is selected from the ListView
TaskSelected(*) {
    Global TaskListView, TaskNameEdit, TaskDescriptionEdit, PriorityDropdown, DifficultyDropdown, DueDateEdit, StatusDropdown

    Row := TaskListView.GetNext()
    if (Row > 0) {
        PopulateFieldsFromListView(Row)
    }
}

; Save tasks to a JSON file
SaveTasks(*) {
    Global TaskListView, DefaultFilePath, StatusBar

    Tasks := GetTasksFromListView()

    File := FileOpen(DefaultFilePath, "w")
    if File {
        json := jsongo.Stringify(Tasks)
        File.Write(json)
        File.Close()
        StatusBar.Text := "Tasks saved successfully to " DefaultFilePath
    } else {
        StatusBar.Text := "Error: Failed to save tasks."
    }
}

; Load tasks from a selected JSON file
LoadTasks(*) {
    Global TaskListView, StatusBar

    LoadPath := FileSelect("Open", DefaultFilePath, "Load Task List", "*.json")
    if (!LoadPath) {
        return
    }

    BackupTasks := GetTasksFromListView()
    LoadFromFile(LoadPath, BackupTasks)
    StatusBar.Text := "Tasks loaded successfully from " LoadPath
}

; Load tasks from the default JSON file if it exists
LoadDefaultTasks(*) {
    Global DefaultFilePath
    if FileExist(DefaultFilePath) {
        LoadFromFile(DefaultFilePath)
    }
}

; Load tasks from a JSON file and restore backup if loading fails
LoadFromFile(FilePath, BackupTasks := []) {
    Global TaskListView, StatusBar

    File := FileOpen(FilePath, "r")
    if (!File) {
        MsgBox("Failed to open file: " FilePath)
        return
    }

    Data := File.Read()
    File.Close()

    Tasks := jsongo.Parse(Data)
    if !IsObject(Tasks) {
        MsgBox("Failed to parse JSON data: " FilePath)
        RestoreBackupTasks(BackupTasks)
        return
    }

    TaskListView.Delete()
    for Task in Tasks {
        AddTaskToListView(Task["TaskName"], Task["TaskDescription"], Task["TaskPriority"], Task["TaskDifficulty"], Task["TaskDueDate"], Task["TaskStatus"])
    }

    StatusBar.Text := "Tasks loaded from file: " FilePath
}

; Hide the GUI on ESC key press
GuiClose(*) {
    Main.Hide()
}

; Validate task inputs
ValidateTask(TaskName, TaskDescription, TaskDueDate) {
    Global StatusBar

    if (TaskName = "") {
        StatusBar.Text := "Error: Task Name cannot be empty."
        return false
    }

    if !IsValidDate(TaskDueDate) {
        StatusBar.Text := "Error: Invalid date format. Use DD/MM/YYYY."
        return false
    }

    if (StrLen(TaskDescription) > 255) {
        StatusBar.Text := "Error: Task Description is too long. Maximum 255 characters allowed."
        return false
    }

    return true
}

; Check if the date is in the format DD/MM/YYYY
IsValidDate(date) {
    return RegExMatch(date, "^\d{2}/\d{2}/\d{4}$")
}

; Add a task to the ListView
AddTaskToListView(TaskName, TaskDescription, TaskPriority, TaskDifficulty, TaskDueDate, TaskStatus) {
    Global TaskListView
    TaskListView.Add("", TaskName, TaskDescription, TaskPriority, TaskDifficulty, TaskDueDate, TaskStatus)
}

; Get tasks from the ListView as an array of maps
GetTasksFromListView() {
    Global TaskListView
    Tasks := []

    Loop (TaskListView.GetCount()) {
        Row := A_Index
        Task := Map(
            "TaskName", TaskListView.GetText(Row, 1),
            "TaskDescription", TaskListView.GetText(Row, 2),
            "TaskPriority", TaskListView.GetText(Row, 3),
            "TaskDifficulty", TaskListView.GetText(Row, 4),
            "TaskDueDate", TaskListView.GetText(Row, 5),
            "TaskStatus", TaskListView.GetText(Row, 6)
        )
        Tasks.Push(Task)
    }

    return Tasks
}

; Populate input fields from a selected ListView row
PopulateFieldsFromListView(Row) {
    Global TaskListView, TaskNameEdit, TaskDescriptionEdit, PriorityDropdown, DifficultyDropdown, DueDateEdit, StatusDropdown
    TaskNameEdit.Value := TaskListView.GetText(Row, 1)
    TaskDescriptionEdit.Value := TaskListView.GetText(Row, 2)
    PriorityDropdown.Text := TaskListView.GetText(Row, 3)
    DifficultyDropdown.Text := TaskListView.GetText(Row, 4)
    DueDateEdit.Value := TaskListView.GetText(Row, 5)
    StatusDropdown.Text := TaskListView.GetText(Row, 6)
}

; Restore backup tasks to the ListView
RestoreBackupTasks(BackupTasks) {
    Global TaskListView, StatusBar
    TaskListView.Delete()
    for Task in BackupTasks {
        AddTaskToListView(Task["TaskName"], Task["TaskDescription"], Task["TaskPriority"], Task["TaskDifficulty"], Task["TaskDueDate"], Task["TaskStatus"])
    }
    StatusBar.Text := "Failed to load tasks. Restored previous tasks."
}

CreateCalendarItem(*) {
    Global TaskListView, StatusBar
    Row := TaskListView.GetNext()
    if (Row = 0) {
        StatusBar.Text := "Error: Please select a task to create a calendar item."
        return
    }
    
    TaskName := TaskListView.GetText(Row, 1)
    TaskDescription := TaskListView.GetText(Row, 2)
    TaskPriority := TaskListView.GetText(Row, 3)
    TaskDueDate := TaskListView.GetText(Row, 5)
    
    CreateOutlookItem(TaskName, TaskDescription, TaskDueDate, TaskPriority)
    StatusBar.Text := "Calendar item created for: " TaskName
}

CreateOutlookItem(TaskName, TaskDescription, TaskDueDate, TaskPriority) {
    olApp := ComObject("Outlook.Application")
    olAppoint := olApp.CreateItem(1)

    ; Parse the date from TaskDueDate and set a fixed time of 8:30 AM
    dueDate := StrSplit(TaskDueDate, "/")
    startDateTime := FormatTime(A_Now, "yyyy-MM-dd 08:30:00")
    startDateTime := FormatTime(dueDate[3] . dueDate[2] . dueDate[1] . "083000", "yyyy-MM-dd HH:mm:ss")

    olAppoint.Subject := TaskName
    olAppoint.Body := TaskDescription
    olAppoint.Start := startDateTime
    olAppoint.Sensitivity := 2  ; Private
    
    ; Set priority
    if (TaskPriority == "High")
        olAppoint.Importance := 2  ; High importance
    else if (TaskPriority == "Low")
        olAppoint.Importance := 0  ; Low importance
    else
        olAppoint.Importance := 1  ; Normal importance

    ; Add yellow category
    olAppoint.Categories := "Yellow Category"

    ; olAppoint.Display() ; Uncomment to display the appointment before saving
    olAppoint.Save()  ; Comment to stop automatic save
    return olAppoint
}

UpdateOutlookItem(olAppoint, TaskName, TaskDescription, TaskDueDate, TaskPriority) {
    ; Parse the date from TaskDueDate and set a fixed time of 8:30 AM
    dueDate := StrSplit(TaskDueDate, "/")
    startDateTime := FormatTime(dueDate[3] . dueDate[2] . dueDate[1] . "083000", "yyyy-MM-dd HH:mm:ss")

    olAppoint.Subject := TaskName
    olAppoint.Body := TaskDescription
    olAppoint.Start := startDateTime
    olAppoint.Sensitivity := 2  ; Private
    
    ; Set priority
    if (TaskPriority == "High")
        olAppoint.Importance := 2  ; High importance
    else if (TaskPriority == "Low")
        olAppoint.Importance := 0  ; Low importance
    else
        olAppoint.Importance := 1  ; Normal importance

    ; Add yellow category
    olAppoint.Categories := "Yellow Category"

    olAppoint.Save()
}

SyncAllTasksWithOutlook(*) {
    global TaskListView, StatusBar
    
    olApp := ComObject("Outlook.Application")
    olNamespace := olApp.GetNamespace("MAPI")
    olFolder := olNamespace.GetDefaultFolder(9) ; 9 is the Calendar folder
    
    Loop TaskListView.GetCount() {
        TaskName := TaskListView.GetText(A_Index, 1)
        TaskDescription := TaskListView.GetText(A_Index, 2)
        TaskPriority := TaskListView.GetText(A_Index, 3)
        TaskDueDate := TaskListView.GetText(A_Index, 5)
        
        ; Check if event already exists
        existingAppt := olFolder.Items.Find("[Subject] = '" TaskName "'")
        
        if (existingAppt) {
            ; Update existing appointment
            UpdateOutlookItem(existingAppt, TaskName, TaskDescription, TaskDueDate, TaskPriority)
        } else {
            ; Create new appointment
            CreateOutlookItem(TaskName, TaskDescription, TaskDueDate, TaskPriority)
        }
    }
    
    StatusBar.Text := "All tasks synced with Outlook Calendar"
}

Escape::ExitApp()


SetButtonDarkMode(hBtn) {
    DllCall("uxtheme\SetWindowTheme", "Ptr", hBtn, "Str", "DarkMode_Explorer", "Ptr", 0)
    SendMessage(0x2001, 0, DllCall("GetSysColorBrush", "Int", 15, "Ptr"), hBtn)
}
