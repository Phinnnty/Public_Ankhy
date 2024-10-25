#Requires AutoHotkey v2.0

; Win + 1: Maximize current window
#1::
{
    WinMaximize "A"
}

; Win + 2: Last 2 active windows take up half the screen each
#2::
{
    ArrangeWindows(2)
}

; Win + 3: Last 3 active windows take up a third of the screen each
#3::
{
    ArrangeWindows(3)
}

; Win + 4: Last 4 active windows take up a quarter of the screen each
#4::
{
    ArrangeWindows(4)
}

ArrangeWindows(numWindows) {
    windowList := WinGetList()
    screenWidth := A_ScreenWidth
    screenHeight := A_ScreenHeight
    
    width := screenWidth // numWindows
    
    Loop numWindows {
        if (A_Index <= windowList.Length) {
            hwnd := windowList[A_Index]
            WinRestore hwnd
            WinMove (A_Index - 1) * width, 0, width, screenHeight, hwnd
        }
    }
}
