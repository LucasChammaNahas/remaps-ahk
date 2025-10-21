#Requires AutoHotkey v2.0

#Include "..\components\boxes\message-box.ahk"

#Esc:: {
    config := Map(
        "title_font_size", 64,
        "width", 450,
        "margin_y", 64,
        "corner_radius", 128
    )

    Send "{Esc}"
    Message_Box("🪄 Reloaded", '', config).render()
    Reload
}
