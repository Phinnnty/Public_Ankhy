#Requires AutoHotkey v2
#include ..\Lib\UIA.ahk
#SingleInstance Force
SetTitleMatchMode(3)
^!#M::
{
    WinWaitActive("GQAF")
    
    ; Get the root element of the GQAF window
    root := UIA.GetRootElement("GQAF ahk_exe gqafx.exe")
    
    ; Find all text elements in the UI tree
    allTextElements := root.FindAll({Type: UIA.ControlType.Text})
    
    elements := Map()
    for search in [
        {name: "File Server Host:", key: "fsHost"},
        {name: "File Server Port:", key: "fsPort"},
        {name: "Applicative Dir:", key: "appDir"}
    ] {
        for element in allTextElements {
            if (InStr(element.Name, search.name)) {
                baseId := Integer(StrReplace(element.AutomationId, "JavaFX", ""))
                valueId := "JavaFX" . (baseId + 3)
                valueElement := root.FindFirst({AutomationId: valueId})
                if (valueElement) {
                    elements[search.key] := valueElement.Value
                    break
                }
            }
        }
    }

    if (elements.Count == 3) {
        MsgBox("File Server Host: " . elements["fsHost"] . 
               "`nFile Server Port: " . elements["fsPort"] . 
               "`nApplicative Dir: " . elements["appDir"])
    } else {
        MsgBox("Failed to find all required elements")
    }
}
