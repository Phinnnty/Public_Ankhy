#Include WebView2.ahk

class ChatGPTHelper {
    static wv := ""

    __New() {
        this.InitializeWebView()
    }

    InitializeWebView() {
        main := Gui("+Resize")
        main.OnEvent("Close", (*) => ExitApp())
        main.Show(Format("w{} h{}", A_ScreenWidth * 0.6, A_ScreenHeight * 0.6))

        wvc := WebView2.create(main.Hwnd)
        this.wv := wvc.CoreWebView2
        this.wv.NewWindowRequested(this.NewWindowRequestedHandler)
    }

    NewWindowRequestedHandler(handler, wv2, arg) {
        argp := WebView2.NewWindowRequestedEventArgs(arg)
        deferral := argp.GetDeferral()
        argp.NewWindow := wv2
        deferral.Complete()
    }

    OpenChatGPTWithQuery(prompt) {
        clipText := this.CopyToClipboard()
        query := prompt . ' > ' . clipText
        encodedQuery := this.UrlEncode(query)
        this.wv.Navigate('https://chat.openai.com/chat?q=' . encodedQuery)
    }

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

    UrlEncode(str) {
        return StrReplace(str, " ", "%20")
    }

    CreateGptSubmenu() {
        GptSubmenu := Menu()

        GptSubmenu.Add("Fix Spelling & Grammar", (*) => this.OpenChatGPTWithQuery("Correct any spelling and grammatical errors in the following text. Ensure proper punctuation and sentence structure."))
        GptSubmenu.Add("Improve Clarity", (*) => this.OpenChatGPTWithQuery("Rewrite the following text to improve clarity and readability. Maintain the original meaning and highlight changes made."))
        GptSubmenu.Add("Explain Topic", (*) => this.OpenChatGPTWithQuery("Provide a detailed explanation of the following text, breaking it down for easier understanding."))
        GptSubmenu.Add()
        GptSubmenu.Add("Generate Image", (*) => this.OpenChatGPTWithQuery("Generate an image based on this prompt:"))
        GptSubmenu.Add("Debug Code", (*) => this.OpenChatGPTWithQuery("Debug the following code. Identify errors or issues and suggest corrections or improvements."))
        GptSubmenu.Add("Explain Code", (*) => this.OpenChatGPTWithQuery("Explain the following code. Identify its purpose, usage, and suggest improvements."))
        GptSubmenu.Add()
        GptSubmenu.Add("Condense Text", (*) => this.OpenChatGPTWithQuery("Condense the following text, preserving key points while reducing length."))
        GptSubmenu.Add("Expand Text", (*) => this.OpenChatGPTWithQuery("Expand on the following text, adding more details, examples, or explanations."))
        GptSubmenu.Add()
        GptSubmenu.Add("Identify Action Items", (*) => this.OpenChatGPTWithQuery("Identify and list any specific actions, tasks, or next steps mentioned or implied in the following text."))
        GptSubmenu.Add("Summarize Text", (*) => this.OpenChatGPTWithQuery("Provide a concise summary of the main points and key ideas from the following text."))
        GptSubmenu.Add()
        GptSubmenu.Add("Strengthen Argument", (*) => this.OpenChatGPTWithQuery("Strengthen the given argument with additional evidence or reasoning. Present opposing views for a comprehensive analysis."))
        GptSubmenu.Add("Polish Language", (*) => this.OpenChatGPTWithQuery("Review the following text for spelling, punctuation, and grammatical errors. Improve overall coherence and enhance sentence structure."))
        GptSubmenu.Add("Enhance Content", (*) => this.OpenChatGPTWithQuery("Enhance the following content by emphasizing crucial information. Verify accuracy using reliable sources and include supporting references."))
        GptSubmenu.Add("Optimize Length", (*) => this.OpenChatGPTWithQuery("Optimize the length of the following text. Adjust for brevity or expand with relevant details as needed."))
        GptSubmenu.Add("Refine Structure", (*) => this.OpenChatGPTWithQuery("Improve the structure of the following content. Enhance design elements and ensure logical flow with smooth transitions."))
        GptSubmenu.Add("Adjust Tone", (*) => this.OpenChatGPTWithQuery("Adjust the tone of the following text to be formal, casual, business-appropriate, etc. Modify to reflect specific company personality or values."))
        GptSubmenu.Add("Enhance Style", (*) => this.OpenChatGPTWithQuery("Enhance the style of the following text. Use active voice, improve clarity, and vary sentence length to improve rhythm and flow."))

        return GptSubmenu
    }
}

; Usage example:
chatGPTHelper := ChatGPTHelper()
gptSubmenu := chatGPTHelper.CreateGptSubmenu()

; Add the submenu to your main menu or tray menu
A_TrayMenu.Add("ChatGPT Queries", gptSubmenu)
