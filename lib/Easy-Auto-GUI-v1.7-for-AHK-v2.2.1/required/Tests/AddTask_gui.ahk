
#Requires Autohotkey v2
;AutoGUI 2.5.8 creator: Alguimist autohotkey.com/boards/viewtopic.php?f=64&t=89901
;AHKv2converter creator: github.com/mmikeww/AHK-v2-script-converter
;Easy_AutoGUI_for_AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2

myGui := Gui()
myGui.Add("Text", "x24 y16 w73 h53 +0x200", "Task Name")
myGui.Add("Text", "x24 y96 w90 h23 +0x200", "Task Description")
myGui.Add("Text", "x24 y152 w89 h23 +0x200", "Priority")
myGui.Add("Text", "x24 y264 w120 h23 +0x200", "Due Date")
myGui.Add("Text", "x24 y208 w120 h23 +0x200", "Difficulty")
Edit1 := myGui.Add("Edit", "x128 y32 w120 h21", "Task Name")
Edit2 := myGui.Add("Edit", "x128 y96 w120 h21", "Task Description")
DateTime1 := myGui.Add("DateTime", "x128 y264 w100 h24")
DropDownList1 := myGui.Add("DropDownList", "x128 y208 w120", ["Easy", "Medium", "Hard"])
DropDownList2 := myGui.Add("DropDownList", "x130 y151 w120", ["Low", "Medium", "High"])
ButtonAddTask := myGui.Add("Button", "x16 y360 w80 h23", "&Add Task")
ButtonClearFields := myGui.Add("Button", "x128 y360 w80 h23", "&Clear Fields")
ButtonAddTask.OnEvent("Click", OnEventHandler)
ButtonClearFields.OnEvent("Click", OnEventHandler)
myGui.OnEvent('Close', (*) => ExitApp())
myGui.Title := "Work Management"
myGui.Show("w283 h420")

OnEventHandler(*)
{
	ToolTip("Click! This is a sample action.`n"
	. "Active GUI element values include:`n"  
	. "ButtonAddTask => " ButtonAddTask.Text "`n" 
	. "ButtonClearFields => " ButtonClearFields.Text "`n", 77, 277)
	SetTimer () => ToolTip(), -3000 ; tooltip timer
}
