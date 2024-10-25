#Requires AutoHotkey v2.0+
#Include WebView2.ahk
#SingleInstance Force
SetWorkingDir(A_ScriptDir)

TraySetIcon("Icons/GPT.png") 

main := Gui("+Resize", "ACL8R - ChatGPT")
main.OnEvent("Close", (*) => ExitApp())
main.Show(Format("w{} h{}", A_ScreenWidth * 0.6, A_ScreenHeight * 0.6))

wvc := WebView2.create(main.Hwnd)
wv := wvc.CoreWebView2
nwr := wv.NewWindowRequested(NewWindowRequestedHandler)
receivedURL := A_Args.Length > 0 ? A_Args[1] : 'https://chat.openai.com'
wv.Navigate(receivedURL)

NewWindowRequestedHandler(handler, wv2, arg) {
	argp := WebView2.NewWindowRequestedEventArgs(arg)
	deferral := argp.GetDeferral()
	argp.NewWindow := wv2
	deferral.Complete()
}
