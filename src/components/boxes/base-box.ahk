#Requires AutoHotkey v2.0

class Base_Box {
    __New(config_overrides := {}) {
        base_config := {
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

        this.config := base_config

        a := {a: 1}
        b := {b: 10}
        this.potato := Utils.merge_objects(a,b)
    }

    render() {
        this.create_gui()
        this.style_gui()
        this.add_content()
        this.show_gui()
        this.position_gui()
        this.apply_rounded_corners()
        this.fade_in()
        Sleep this.config.display_time
        this.fade_out()
        this.destroy()
    }

    create_gui() {
        this.gui := Gui("+AlwaysOnTop -Caption")
    }

    style_gui() {
        c := this.config
        this.gui.BackColor := c.bg_color
        this.gui.MarginX := c.margin_x
        this.gui.MarginY := c.margin_y
        WinSetTransparent(0, this.gui.Hwnd)

    }

    add_content() {

    }

    show_gui() {
        this.gui.Show("AutoSize Center")
    }

    position_gui() {
        WinGetPos &x, &y, &w, &h, this.gui.Hwnd
        WinMove x, A_ScreenHeight / 3 - h / 2, , , this.gui.Hwnd

    }

    apply_rounded_corners() {
        WinGetPos &x, &y, &w, &h, this.gui.Hwnd
        r := this.config.corner_radius
        hrgn := DllCall("CreateRoundRectRgn", "int", 0, "int", 0, "int", w, "int", h, "int", r, "int", r, "ptr")
        DllCall("SetWindowRgn", "ptr", this.gui.Hwnd, "ptr", hrgn, "int", true)
    }

    fade_in() {
        loop 10 {
            WinSetTransparent(A_Index * this.config.fade_step, this.gui.Hwnd)
            Sleep this.config.fade_delay
        }
    }

    fade_out() {
        loop 10 {
            WinSetTransparent(255 - A_Index * this.config.fade_step, this.gui.Hwnd)
            Sleep this.config.fade_delay
        }
    }

    destroy() {
        this.gui.Destroy()
    }
}

class Styled_Box extends Base_Box {
    __New(title, text) {
        super.__New()
        this.title := title
        this.text := text
    }

    add_content() {
        c := this.config

        this.gui.SetFont("s" c.title_font_size " c" c.title_color, c.font)
        this.gui.Add("Text", "Center w" c.width, this.title)

        if (this.text) {
            this.gui.Add(
                "Progress",
                "w" c.width " h1 c" c.divider_color " Background" c.divider_color
            )
            this.gui.SetFont(
                "s" c.font_size " c" c.text_color,
                c.font
            )
            this.gui.Add(
                "Text",
                "w" c.width " Center",
                this.text
            )
        }
    }
}

; Example usage:
^!Space:: SetTimer(() => Styled_Box("batata", "Hello, Lucas!").render(), -10)
; ^!Space:: SetTimer(() => Base_Box("potato", "Hello, Lucas!").render(), -10)
