#Requires AutoHotkey v2.0

global is_caps_down := false
global caps_down_tick := 0
global caps_used := false

send_without_esc(keys) {
    global caps_used
    caps_used := true
    Send(keys)
}

$CapsLock:: {
    global is_caps_down, caps_down_tick, caps_used
    is_caps_down := true
    caps_down_tick := A_TickCount
    caps_used := false
}

$CapsLock Up:: {
    global is_caps_down, caps_down_tick, caps_used
    if (A_TickCount - caps_down_tick) < 250 && !caps_used
        Send "{Esc}"
    is_caps_down := false
}

#HotIf is_caps_down
    ; Space to Right
    Space::send_without_esc("{Space}{Left}")

    ; Scroll
    Up::send_without_esc("{WheelUp}")
    Down::send_without_esc("{WheelDown}")
    Left::send_without_esc("+{WheelUp}")
    Right::send_without_esc("+{WheelDown}")

    ; Movement
    i::send_without_esc("{Up}")
    k::send_without_esc("{Down}")
    j::send_without_esc("{Left}")
    l::send_without_esc("{Right}")

    ; Utils
    y::send_without_esc("^{z}")
    h::send_without_esc("{Home}")
    `;::send_without_esc("{End}")
    u::send_without_esc("{Backspace}")
    n::send_without_esc("{Backspace}")
    o::send_without_esc("{Del}")
    Delete::send_without_esc("+{End}{Backspace}")
    Backspace::send_without_esc("+{Home}{Backspace}")

    ; Default
    a::send_without_esc("^{a}")
    b::send_without_esc("^{b}")
    c::send_without_esc("^{c}")
    d::send_without_esc("^{d}")
    e::send_without_esc("^{e}")
    f::send_without_esc("^{f}")
    g::send_without_esc("^{g}")
    m::send_without_esc("^{m}")
    p::send_without_esc("^{p}")
    s::send_without_esc("^{s}")
    v::send_without_esc("^{v}")
    w::send_without_esc("^{w}")
    x::send_without_esc("^{x}")
    z::send_without_esc("^{z}")

    1::send_without_esc("^{1}")
    2::send_without_esc("^{2}")
    3::send_without_esc("^{3}")
    4::send_without_esc("^{4}")
    5::send_without_esc("^{5}")
    6::send_without_esc("^{6}")
    7::send_without_esc("^{7}")
    8::send_without_esc("^{8}")
    9::send_without_esc("^{9}")
    0::send_without_esc("^{0}")

    -::send_without_esc("^{-}")
    =::send_without_esc("^{=}")
    [::send_without_esc("^{[}")
    ]::send_without_esc("^{]}")
    \::send_without_esc("^{\}")
    '::send_without_esc("^{' }")
    ,::send_without_esc("^{,}")
    .::send_without_esc("^{.}")
    /::send_without_esc("^/{ }")
#HotIf
