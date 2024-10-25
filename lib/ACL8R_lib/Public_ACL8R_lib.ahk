#Requires AutoHotkey v2.0+


;; ---------- Google Search MENU ;; ----------
CreateGoogleSearchMenu() {
    GoogleSearch := Menu()
    GoogleSearch.Add('Google Search`tCAPSLOCK + G', (*) => PerformGoogleSearch())
    GoogleSearch.Add('Google News', (*) => Run("https://news.google.ie/search?q=" . Search_text))
    GoogleSearch.Add('Youtube', (*) => Run('https://www.youtube.com/results?search_query=' . Search_text))
    GoogleSearch.Add('Google Maps', (*) => Run('https://www.google.ie/maps/search/' . Search_text))    
    return GoogleSearch
}

;; ---------- FORMAT MENU ----------
CreateFormatMenu() {
    FormatMenu := Menu()
    FormatMenu.Add("lower case", (*) => TextFormatter.FormatText("L"))
    FormatMenu.Add("UPPER CASE", (*) => TextFormatter.FormatText("U"))
    FormatMenu.Add("Title Case", (*) => TextFormatter.FormatText("T"))
    FormatMenu.Add("Clean Lines/Space", (*) => TextFormatter.RemoveExcessSpace())
    return FormatMenu
}

;; ---------- WRAP MENU  ----------
CreateWrapMenu() {
    WrapMenu := Menu()
    WrapMenu.Add('"Double Quotes"', (*) => TextFormatter.Wrap('"', '"'))
    WrapMenu.Add("'Single Quotes'", (*) => TextFormatter.Wrap("'", "'"))
    WrapMenu.Add("(Parentheses)", (*) => TextFormatter.Wrap("(", ")"))
    WrapMenu.Add("[Square Brackets]", (*) => TextFormatter.Wrap("[", "]"))
    WrapMenu.Add("{Curly Brackets}", (*) => TextFormatter.Wrap("{","}"))
    return WrapMenu
}

;; ---------- COMMENT MENU  ----------
CreateCommentntMenu() {
    CommentMenu := Menu()
    CommentMenu.Add("AHK Comment", (*) => CommentManager.CommentWrap(";;", ""))
    CommentMenu.Add("AHK Uncomment", (*) => CommentManager.CommentUnWrap())
    CommentMenu.Add()
    CommentMenu.Add("Python Comment", (*) => CommentManager.CommentWrap("#", ""))
    CommentMenu.Add("Python Uncomment", (*) => CommentManager.CommentUnWrap())
    CommentMenu.Add()
    CommentMenu.Add("XML Comment", (*) => CommentManager.CommentWrapXML())
    CommentMenu.Add("XML Uncomment", (*) => CommentManager.CommentUnWrapXML())
    return CommentMenu
}

;; ---------- API MENU ------------
CreateAPIMenu() {
    APIMenu := Menu()
    APIMenu.Add("Generate GUID", (*) => Run("lib\ACL8R_lib\GenerateGUID.ahk"))
    APIMenu.Add("Generate UUID", (*) => Run("lib\ACL8R_lib\GenerateUUID.ahk"))
    return APIMenu
}
;; ---------- SYSTEM APPS MENU ----------
CreateSystemAppsMenu() {
    SystemApps := Menu()
    SystemApps.Add('Kill All Instances of App', (*) => Run('lib\ACL8R_lib\Kill_All_Last_App.ahk')), SystemApps.SetIcon("Kill All Instances of App", "Icons\dlongsword.png", 1)
    SystemApps.Add('List All Apps', (*) => Run('shell:appsfolder'))
    SystemApps.Add('powershell', (*) => Run('powershell'))
    SystemApps.Add()
    SystemApps.Add('Shutdown', (*) => Shutdown(1))
    SystemApps.Add('Restart', (*) => Shutdown(2))
    SystemApps.Add('Hibernate', (*) => Run("rundll32.exe powrprof.dll,SetSuspendState 0,1,0"))
    return SystemApps
}

;; ---------- ASK GPT MENU  ---------- 

CreateGPTMenu() {
    GptSubmenu := Menu()
    GptSubmenu.Add("Fix Spelling & Grammar", (*) => OpenChatGPTWithQuery("Correct any spelling and grammatical errors in the following text. Ensure proper punctuation and sentence structure."))
    GptSubmenu.Add("Improve Clarity", (*) => OpenChatGPTWithQuery("Rewrite the following text to improve clarity and readability. Maintain the original meaning and highlight changes made."))
    GptSubmenu.Add("Explain Topic", (*) => OpenChatGPTWithQuery("Provide a detailed explanation of the following text, breaking it down for easier understanding."))
    GptSubmenu.Add()
    GptSubmenu.Add("Generate Image", (*) => OpenChatGPTWithQuery("Generate an image based on this prompt:"))
    GptSubmenu.Add("Debug Code", (*) => OpenChatGPTWithQuery("Debug the following code. Identify errors or issues and suggest corrections or improvements."))
    GptSubmenu.Add("Explain Code", (*) => OpenChatGPTWithQuery("Explain the following code. Identify its purpose, usage, and suggest improvements."))
    GptSubmenu.Add()
    GptSubmenu.Add("Condense Text", (*) => OpenChatGPTWithQuery("Condense the following text, preserving key points while reducing length."))
    GptSubmenu.Add("Expand Text", (*) => OpenChatGPTWithQuery("Expand on the following text, adding more details, examples, or explanations."))
    GptSubmenu.Add()
    GptSubmenu.Add("Identify Action Items", (*) => OpenChatGPTWithQuery("Identify and list any specific actions, tasks, or next steps mentioned or implied in the following text."))
    GptSubmenu.Add("Summarize Text", (*) => OpenChatGPTWithQuery("Provide a concise summary of the main points and key ideas from the following text."))
    GptSubmenu.Add()
    GptSubmenu.Add("Strengthen Argument", (*) => OpenChatGPTWithQuery("Strengthen the given argument with additional evidence or reasoning. Present opposing views for a comprehensive analysis."))
    GptSubmenu.Add("Polish Language", (*) => OpenChatGPTWithQuery("Review the following text for spelling, punctuation, and grammatical errors. Improve overall coherence and enhance sentence structure."))
    GptSubmenu.Add("Enhance Content", (*) => OpenChatGPTWithQuery("Enhance the following content by emphasizing crucial information. Verify accuracy using reliable sources and include supporting references."))
    GptSubmenu.Add("Optimize Length", (*) => OpenChatGPTWithQuery("Optimize the length of the following text. Adjust for brevity or expand with relevant details as needed."))
    GptSubmenu.Add("Refine Structure", (*) => OpenChatGPTWithQuery("Improve the structure of the following content. Enhance design elements and ensure logical flow with smooth transitions."))
    GptSubmenu.Add("Adjust Tone", (*) => OpenChatGPTWithQuery("Adjust the tone of the following text to be formal, casual, business-appropriate, etc. Modify to reflect specific company personality or values."))
    GptSubmenu.Add("Enhance Style", (*) => OpenChatGPTWithQuery("Enhance the style of the following text. Use active voice, improve clarity, and vary sentence length to improve rhythm and flow."))
    return GptSubmenu
}
;; ---------- ASK CLAUDE MENU  ----------
CreateCluadeMenu() {
    ClaudeSubmenu := Menu()
    ClaudeSubmenu.Add("Explain Code", (*) => OpenChatClaudeWithQuery("Explain the following code, breaking it down for easier understanding."))
    ClaudeSubmenu.Add("Generate Code", (*) => OpenChatClaudeWithQuery("Generate code based on this prompt. Add comments to explain functionality and provide suggestions at the end."))
    ClaudeSubmenu.Add("Debug Code", (*) => OpenChatClaudeWithQuery("Debug the following code. Identify errors or issues and suggest corrections or improvements."))
    return ClaudeSubmenu
}

;; ---------- OCR SCREENSHOT & SEARCH ----------
CreateScreenshotMenu() {
    Screenshotsubmenu := Menu()
    Screenshotsubmenu.Add("Screnshot Snipping Tool", (*) => Run("lib\ACL8R_lib\SnippingTool.ahk"))
    Screenshotsubmenu.Add("Capture Text from Image", (*) => Run("lib\ACL8R_lib\OCR_ScreenSnip.ahk")) ; wouldn't be possible without https://github.com/Descolada/OCR
    Screenshotsubmenu.Add("Reverse Image Search", (*) => Run("lib\ACL8R_lib\SearchScreenshot.ahk")) ; same as Snipping Tool, just ensures the screenshot is pasted to Google Lens
    return Screenshotsubmenu
}

 ; Function to return to previous window 
 ActivatePrevWindow() {
    global currentWindowPID
    if (WinExist("ahk_pid " currentWindowPID)) {
        WinActivate("ahk_pid " currentWindowPID)
        if (WinWaitActive("ahk_pid " currentWindowPID)) {
            Sleep(100) ; Short delay to ensure the window is active
            return true
        } else {
            MsgBox("Failed to activate the window with PID: " currentWindowPID)
            return false
        }
    } else {
        MsgBox("The window with PID " currentWindowPID " does not exist.")
        return false
    }
}

; Function to rename the menu item
RenameMenuItem(newTitle) {
    global currentMenuItemName
    ACL8R.Rename(currentMenuItemName, newTitle)
    currentMenuItemName := newTitle
}

; Function to rename the clipboard content menu item
RenameClipboardMenuItem(newTitle) {
    global clipboardMenuItemName
    ACL8R.Rename(clipboardMenuItemName, newTitle)
    clipboardMenuItemName := newTitle
}


; Function to check if the script is running
CheckScriptStatus() {
    if (!A_IsSuspended) {
        LogError("Script checked at " . A_Now . ": Running")
    } else {
        LogError("Script checked at " . A_Now . ": Suspended, reloading...")
        Reload()
    }
}

;; ---------- UTILITY FUNCTIONS ----------

; Standardized function to copy text to clipboard
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

; Function to log errors
LogError(message) {
    try {
        FileAppend(message . "`n", LogFile)
    } catch as err {
        MsgBox("Error writing to log file: " . err.Message)
    }
}

class TextFormatter {
    static FormatText(n) {
        global tooltipBoard
        ; Function to format text case (lower, UPPER, Title)
        clipText := CopyToClipboard()
        if (clipText != "") {
            tooltipBoard.Show()
            tooltipBoard.DrawTip("Formatting text to " . n . " case")
            A_Clipboard := Format("{:" . n . "}", clipText)
            Send("^v")
            Sleep(2000)
            tooltipBoard.DrawTip("")
            tooltipBoard.Hide()
        } else {
            ToolTip("No text copied to clipboard.")
            SetTimer(() => ToolTip(), -2000)
        }
    }

    static RemoveExcessSpace() {
        global tooltipBoard
        ; Function to remove excess spaces and normalize line breaks
        clipText := CopyToClipboard()
        if (clipText != "") {
            tooltipBoard.Show()
            tooltipBoard.DrawTip("Removing excess spaces and normalizing line breaks")
            text := RegExReplace(clipText, "\R{2,}", "`r`n`r`n")
            text := RegExReplace(text, "([^\r\n]) {2,}", "$1 ")
            text := RegExReplace(text, "^ +| +$", "", , -1)
            text := Trim(text)

            A_Clipboard := text
            Send("^v")
            Sleep(2000)
            tooltipBoard.DrawTip("")
            tooltipBoard.Hide()
        } else {
            ToolTip("No text copied to clipboard.")
            SetTimer(() => ToolTip(), -2000)
        }
    }

    static Wrap(startChar, endChar) {
        global tooltipBoard
        clipText := CopyToClipboard()
        if (clipText != "") {
            tooltipBoard.Show()
            tooltipBoard.DrawTip("Wrapping text with '" . startChar . "' and '" . endChar . "'")
            A_Clipboard := startChar . clipText . endChar
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

;; Class to perform comment actions on code 
class CommentManager {
    static CommentWrap(startChar, endChar) {
        global tooltipBoard
        A_Clipboard := ""
        Send("^c")
        ClipWait(2)
        if (A_Clipboard != "") {
            tooltipBoard.Show()
            tooltipBoard.DrawTip("Commenting code with '" . startChar . "' and '" . endChar . "'")
            lines := StrSplit(A_Clipboard, "`n", "`r")
            commentedText := ""
            for index, line in lines {
                commentedText .= startChar . line . endChar . (index < lines.Length ? "`n" : "")
            }
            A_Clipboard := commentedText
            Send("^v")
            Sleep(2000)
            tooltipBoard.DrawTip("")
            tooltipBoard.Hide()
        } else {
            ToolTip("No text copied to clipboard.")
            SetTimer(() => ToolTip(), -2000)
        }
    }

    static CommentUnWrap() {
        global tooltipBoard
        A_Clipboard := ""
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

    ; XML functions still require some work... <!--
    
    static CommentWrapXML() {
        global tooltipBoard
        A_Clipboard := ""
        Send("^c")
        ClipWait(2)
        if (A_Clipboard != "") {
            tooltipBoard.Show()
            tooltipBoard.DrawTip("Commenting XML code")
            Send("<{!}--")           
            Send("{Enter}")
            Sleep(300)
            Send("^v")
            Sleep(300)
            Send("{Enter}")
            Send("-->")
            Sleep(2000)
            tooltipBoard.DrawTip("")
            tooltipBoard.Hide()
        }
    }    
    
    
    static CommentUnWrapXML() {
        global tooltipBoard
        A_Clipboard := ""
        Send("^c")
        ClipWait(2)
        if (A_Clipboard != "") {
            tooltipBoard.Show()
            tooltipBoard.DrawTip("Uncommenting XML code")
            text := A_Clipboard
            text := RegExReplace(text, "^<!--\s*\R?", "")  ; Remove opening tag from the first line
            text := RegExReplace(text, "\R\s*-->$", "")    ; Remove closing tag from the last line
            text := RegExReplace(text, "\R-->", "`n")      ; Remove closing tag from intermediate lines
            A_Clipboard := text
            Send("^v")
            Sleep(2000)
            tooltipBoard.DrawTip("")
            tooltipBoard.Hide()
        }
    }
}

GenerateChatGPTURL(prompt) {
    global Search_text
    url := "https://chat.openai.com/chat?q=" . Prompt . '>' . Search_text
    return url
}

; Creates a new tab on ChatGPT and sends your query
OpenChatGPTWithQuery(prompt) {
    global tooltipBoard, Search_text
    url := GenerateChatGPTURL(prompt)
    A_Clipboard := prompt . ' > ' . Search_text
    
    tooltipBoard.Show()
    tooltipBoard.DrawTip("Opening ChatGPT with query: '" . prompt . "'")
    Run(A_ScriptDir . "\lib\ahk2_lib-master\WebView2\WV_OpenChatGPT.ahk `"" . url . "`"")
    Sleep(3000)
    Send("{Tab}" . '^v' . "{Enter}")

    Sleep(2000)
    tooltipBoard.DrawTip("")
    tooltipBoard.Hide()
}

; Creates a new tab on Claude 3.5 and sends your query
GenerateClaudeURL(prompt) {
    global Search_text
    url := "https://claude.ai/new?q=" . Prompt . '>' . Search_text
    return url
}

OpenChatClaudeWithQuery(prompt) {
    global tooltipBoard, Search_text
    url := GenerateClaudeURL(prompt)
    
    tooltipBoard.Show()
    tooltipBoard.DrawTip("Opening Claude 3.5 with query: '" . prompt . "'")
    Run(A_ScriptDir . "\lib\ahk2_lib-master\WebView2\WV_OpenClaude.ahk `"" . url . "`"")

    Sleep(2000)
    tooltipBoard.DrawTip("")
    tooltipBoard.Hide()
}

PerformGoogleSearch() {
    global tooltipBoard, Search_text
    
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