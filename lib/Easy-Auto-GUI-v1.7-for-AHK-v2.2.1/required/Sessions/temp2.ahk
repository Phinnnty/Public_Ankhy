#Warn All, Off

#Requires Autohotkey v2
;AutoGUI 2.5.8 creator: Alguimist autohotkey.com/boards/viewtopic.php?f=64&t=89901
;AHKv2converter creator: github.com/mmikeww/AHK-v2-script-converter
;Easy_AutoGUI_for_AHKv2 github.com/samfisherirl/Easy-Auto-GUI-for-AHK-v2

myGui := Gui()
ButtonEditTask := myGui.Add("Button", "x16 y464 w80 h23", "&Edit Task")
ButtonDeleteTask := myGui.Add("Button", "x112 y464 w80 h23", "&Delete Task")
ButtonSaveTasks := myGui.Add("Button", "x248 y464 w80 h23", "&Save Tasks")
ButtonLoadTasks := myGui.Add("Button", "x344 y464 w80 h23", "&Load Tasks")
ButtonCompleteTask := myGui.Add("Button", "x496 y464 w90 h23", "&Complete Task")
Tab.UseTab(1)
Tab := myGui.Add("Tab3", "x16 y8 w592 h404", ["Active Tasks", "Completed Tasks"])
Tab.UseTab()
ButtonEditTask.OnEvent("Click", OnEventHandler)
ButtonDeleteTask.OnEvent("Click", OnEventHandler)
ButtonSaveTasks.OnEvent("Click", OnEventHandler)
ButtonLoadTasks.OnEvent("Click", OnEventHandler)
ButtonCompleteTask.OnEvent("Click", OnEventHandler)
SB := myGui.Add("StatusBar", , "Status Bar")
myGui.OnEvent('Close', (*) => ExitApp())
myGui.Title := "Delete Task"
myGui.Show("w634 h558")

OnEventHandler(*)
{
	ToolTip("Click! This is a sample action.`n"
	. "Active GUI element values include:`n"  
	. "ButtonEditTask => " ButtonEditTask.Text "`n" 
	. "ButtonDeleteTask => " ButtonDeleteTask.Text "`n" 
	. "ButtonSaveTasks => " ButtonSaveTasks.Text "`n" 
	. "ButtonLoadTasks => " ButtonLoadTasks.Text "`n" 
	. "ButtonCompleteTask => " ButtonCompleteTask.Text "`n", 77, 277)
	SetTimer () => ToolTip(), -3000 ; tooltip timer
}
