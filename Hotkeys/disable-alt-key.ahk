#Requires AutoHotkey v2.0
#UseHook

Alt::return
; Alt::MsgBox("Alt pressed (not in Explorer)")

; #HotIf !WinActive("ahk_exe explorer.exe")
;     Alt::MsgBox("Alt pressed (not in Explorer)")
; #HotIf