#Requires AutoHotkey v2.0

Message_Box(title, text:='') {
    ; === Configuration ===
    config := {
        bg_color: "1e1e1e",
        text_color: "86d486",
        title_color: "ff8e47",
        divider_color: "555555",
        font: "Courier New",
        font_size: 12,
        title_font_size: 24,
        width: 400,
        margin_x: 32,
        margin_y: 32,
        corner_radius: 64,
        fade_step: 25,
        fade_delay: 15,
        display_time: 1000
    }

    ; === Create and style window ===
    win := Gui("+AlwaysOnTop -Caption")
    win.BackColor := config.bg_color
    win.MarginX := config.margin_x
    win.MarginY := config.margin_y

    ; === Add content ===
    win.SetFont("s" config.title_font_size " c" config.title_color, config.font)
    win.Add("Text", "Center w" config.width, title)
    if (text) {
        win.Add("Progress", "w" config.width " h1 c" config.divider_color " Background" config.divider_color)
        win.SetFont("s" config.font_size " c" config.text_color, config.font)
        win.Add("Text", "w" config.width " Center", text)
    }

    ; === Show initially transparent window ===
    WinSetTransparent(0, win.Hwnd)
    win.Show("AutoSize Center")

    ; === Apply rounded corners ===
    WinGetPos &x, &y, &w, &h, win.Hwnd
    hrgn := DllCall(
        "CreateRoundRectRgn",
        "int", 0, "int", 0, "int", w, "int", h,
        "int", config.corner_radius, "int", config.corner_radius,
        "ptr"
    )
    DllCall("SetWindowRgn", "ptr", win.Hwnd, "ptr", hrgn, "int", true)

    ; === Fade in ===
    loop 10 {
        WinSetTransparent(A_Index * config.fade_step, win.Hwnd)
        Sleep config.fade_delay
    }

    ; === Display duration ===
    Sleep config.display_time

    ; === Fade out ===
    loop 10 {
        WinSetTransparent(255 - A_Index * config.fade_step, win.Hwnd)
        Sleep config.fade_delay
    }

    ; === Destroy window ===
    win.Destroy()
}
