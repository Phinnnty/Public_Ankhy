﻿Global g_Version := "2.5.8"
, g_AppName := "AutoGUI"
, hAutoWnd
, hMainToolbar
, hTab := 0
, TabEx
, Sci := []
, SciLexer := A_ScriptDir . (A_PtrSize == 8 ? "\SciLexer64.dll" : "\SciLexer32.dll")
, g_SciFontName
, g_SciFontSize
, IniFile
, IconLib := A_ScriptDir . "\Icons\AutoGUI.icl"
, RecentFiles := []
, hChildWnd := 0
, Child := 1
, hSelWnd := 0
, hGUIToolbar
, hChildToolbar := 0
, TB_CHECKBUTTON := 0x402
, hFindReplaceDlg := 0
, SearchString
, g_ChkMatchCase
, g_ChkWholeWord
, g_ChkRegExFind
, g_ChkBackslash
, g_RadStartingPos
, g_ChkWrapAround
, hCbxFind1
, hCbxReplace
, hFontDlg
, hCloneDlg
, hToolbarEditor := 0
, m := New MenuBar
, hMenuEditor := 0
, hAddMenuItemDlg := 0
, g
, g_X := 0
, g_Y := 0
, g_Control := 0
, g_TabIndex := 1
, g_OpenDir
, g_SaveDir
, Indent
, g_TabSize
, g_Insert := True
, g_DesignMode
, g_ShowGrid
, g_SnapToGrid
, g_GridSize
, g_WordWrap
, g_SyntaxHighlighting
, g_LineNumbers
, g_AutoBrackets
, g_SysTrayIcon
, hLVToolbox
, hPropWnd := 0
, hCbxClassNN := 0
, hTabStyles
, g_oStyles
, g_PropX
, g_PropY
, hBitmapTile
, hCursorCross
, hCursorDragMove
, g_Cross := False
, g_Parameters
, g_BackupOnSave
, g_BackupDir
, g_BackupDays
, g_AutoSaveInterval
, g_AutoSaveInLoco
, g_AutoSaveInBkpDir
, CRLF := "`r`n"
, g_Signature := "; Generated by " . g_AppName . " " . g_Version . CRLF
, g_Resizers := []
, hResizer1
, hResizer2
, hResizer3
, hResizer4
, hResizer5
, hResizer6
, hResizer7
, hResizer8
, hReszdCtl
, g_ResizerSize := 6
, g_ResizerColor
, g_ResizerBrush
, g_Cursors := {}
, g_Adding := False
, g_NT6orLater := DllCall("Kernel32.dll\GetVersion") & 0xFF > 5
, g_IconPath := "shell32.dll"
, g_PicturePath := A_MyDocuments
, g_GuiTab := 0
, g_GuiVis := False
, g_AltAhkPath
, g_ShowWhiteSpaces := False
, g_AutoCList
, g_AutoCEnabled
, g_AutoCMinLength
, g_AutoCMaxItems
, g_AutoCXMLObj
, g_Calltips
, g_CalltipParams
, g_CalltipParamsIndex := 1
, g_HighlightActiveLine
, g_HelpMenuXMLObj
, g_IndentGuides
, g_HighlightIdenticalText
, g_CheckTimestamp
, g_CodeFolding
, g_IndentWithSpaces
, g_AutoIndent
, g_TabCounter := 1
, g_IniTools
, g_AhkPath3264
, g_LButtonDown := 0
, g_SessionsDir
, g_LoadLastSession
, g_RememberSession
, g_DbgPort
, g_DbgStatus := 0
, g_DbgSession
, g_DbgSocket
, g_DbgStack
, g_DbgLocalVariables
, g_DbgGlobalVariables
, g_Breakpoints := []
, g_SymbolMargin
, g_InitialX
, g_InitialY
, g_InitialW
, g_InitialH
, g_ToolbarH := 50
, g_hStatusBar
, g_StatusBarH
, g_TabBarPos
, g_TabBarStyle
, g_SplitterW := 4
, g_MouseCapture := 0
, g_AskToSaveOnExit
, g_MarkerBookmark := 0
, g_MarkerBreakpoint := 1
, g_MarkerDebugStep := 2
, g_MarkerError := 3
, hVarListWnd := 0
, g_ReloadVarListOnEveryStep := 1
, g_ShowIndexedVariables := 1
, g_ShowObjectMembers := 1
, g_HideReservedClassMembers := 1
, g_DbgCaptureStderr := True
, g_AttachDebugger := False
, g_HelpFile
, g_ShowAllFonts
, g_FontList
, g_hHiddenEdit
, g_DarkTheme
, g_MenuFuncs
, g_MenuHandler
, g_CaptureStdErr
, g_ShowErrorSign
, g_TempFile := A_Temp . "\Temp.ahk"
