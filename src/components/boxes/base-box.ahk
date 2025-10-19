#Requires AutoHotkey v2.0

class Base_Box {
    __New(title, text := "") {
        this.title := title
        this.text := text
        this.config := {
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
    }

    show() {
        this.create_window()
        this.apply_rounded_corners()
        this.fade_in()
        Sleep this.config.display_time
        this.fade_out()
        this.destroy()
    }

    create_window() {
        cfg := this.config
        this.win := Gui("+AlwaysOnTop -Caption")
        this.win.BackColor := cfg.bg_color
        this.win.MarginX := cfg.margin_x
        this.win.MarginY := cfg.margin_y

        this.win.SetFont("s" cfg.title_font_size " c" cfg.title_color, cfg.font)
        this.win.Add("Text", "Center w" cfg.width, this.title)

        if (this.text) {
            this.win.Add("Progress", "w" cfg.width " h1 c" cfg.divider_color " Background" cfg.divider_color)
            this.win.SetFont("s" cfg.font_size " c" cfg.text_color, cfg.font)
            this.win.Add("Text", "w" cfg.width " Center", this.text)
        }

        WinSetTransparent(0, this.win.Hwnd)
        this.win.Show("AutoSize Center")

        WinGetPos &x, &y, &w, &h, this.win.Hwnd
        WinMove x, A_ScreenHeight / 3 - h / 2, , , this.win.Hwnd
    }

    apply_rounded_corners() {
        WinGetPos &x, &y, &w, &h, this.win.Hwnd
        r := this.config.corner_radius
        hrgn := DllCall("CreateRoundRectRgn", "int", 0, "int", 0, "int", w, "int", h, "int", r, "int", r, "ptr")
        DllCall("SetWindowRgn", "ptr", this.win.Hwnd, "ptr", hrgn, "int", true)
    }

    fade_in() {
        loop 10 {
            WinSetTransparent(A_Index * this.config.fade_step, this.win.Hwnd)
            Sleep this.config.fade_delay
        }
    }

    fade_out() {
        loop 10 {
            WinSetTransparent(255 - A_Index * this.config.fade_step, this.win.Hwnd)
            Sleep this.config.fade_delay
        }
    }

    destroy() {
        this.win.Destroy()
    }
}

; Example usage:
^!Space:: SetTimer(() => Base_Box("Notice", "Hello, Lucas!").show(), -10)