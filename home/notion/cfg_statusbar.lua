-- Notion statusbar module configuration file

local ws_broken = {false, false, false, false, false, false, false, false, false, false}
local sb_dead, sb, workspace = true, nil, 1

-- for debugging purposes only
local function print_debug_information()
    io.write("\nion3 statusbar status: the following worksspaces are broken: ")
    for i = 1, 10 do
        if ws_broken[i] then
            io.write(i .. "... ")
        end
    end
    print("\nthe currently active workspace is: " .. workspace .. "...")
    if sb_dead then
        print("the statusbar is currently NOT active...")
    else
        print("the statusbar is currently active...")
    end
end

function toggle_statusbar()
    if sb_dead then
        sb_dead = false
        sb = mod_statusbar.create {
            screen = 0,
            pos = "br",
            fullsize = false,
            systray = false,

            template = "%date | %load_1min %load_5min %load_15min | %charge",
        }
        mod_statusbar.update()
    else
        sb_dead = true
        ws_broken[workspace] = false
        sb:rqclose(true)
        sb = nil
    end
end

defbindings("WMPlex.toplevel", {
    bdoc("Toggle statusbar."),
    kpress(ALTMETA .. "F7", "toggle_statusbar()"),
})

local function fix_ws(n)
    if not ws_broken[workspace] and not sb_dead then
        ws_broken[workspace] = true
    elseif ws_broken[n] and sb_dead then
        mod_statusbar.create{}:rqclose(true) -- creates then kills the statusbar
	ws_broken[n] = false
    end
end

function switch_nth_save(mplex, n)
    mplex:switch_nth(n)
    fix_ws(n + 1)
    workspace = n + 1
end

function switch_prev_save(mplex)
    WScreen.switch_prev(mplex)
    fix_ws(workspace - 1)
    workspace = workspace - 1
end

function switch_next_save(mplex)
    WScreen.switch_next(mplex)
    fix_ws(workspace + 1)
    workspace = workspace + 1
end

defbindings("WScreen", {
    bdoc("Switch to n:th object (workspace, full screen client window) within current " ..
         "screen."),
    kpress(META .. "1", "switch_nth_save(_, 0)"),
    kpress(META .. "2", "switch_nth_save(_, 1)"),
    kpress(META .. "3", "switch_nth_save(_, 2)"),
    kpress(META .. "4", "switch_nth_save(_, 3)"),
    kpress(META .. "5", "switch_nth_save(_, 4)"),
    kpress(META .. "6", "switch_nth_save(_, 5)"),
    kpress(META .. "7", "switch_nth_save(_, 6)"),
    kpress(META .. "8", "switch_nth_save(_, 7)"),
    kpress(META .. "9", "switch_nth_save(_, 8)"),
    kpress(META .. "0", "switch_nth_save(_, 9)"),

    bdoc("Switch to next/previous object within current screen."),
    kpress(META .."comma", "switch_prev_save(_)"),
    kpress(META .."period", "switch_next_save(_)"),

    --submap(META .."K", {
        --bdoc("Go to first region demanding attention or previously active one."),
        --kpress("K", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
    --}),
})

sb = mod_statusbar.create {
    screen = 0,
    pos = "br",
    fullsize = false,
    systray = false,

    template = "%date | %load_1min %load_5min %load_15min | %charge",
}

sb:rqclose(true)
sb = nil

-- alternative approach with floating statusbar

--local floatsb

--floatsb=ioncore.find_screen_id(0):attach_new{
--    type="WStatusBar",
--    unnumbered=true,
--    sizepolicy='southeast',
--    template='%date | %load_1min %load_5min %load_15min | %charge',
--    passive=true,
--    level=2
--}

--function test()
--    ioncore.find_screen_id(0):set_hidden(floatsb, 'toggle')
--end

--ioncore.defbindings("WScreen", {
--    kpress(ALTMETA.."F7", "test()")
--})

--function test()
--    ioncore.find_screen_id(0):set_stdisp{
--        action='remove'
--}
--end

mod_statusbar.launch_statusd {
    date = {
        date_format = '%H:%M %Z',
    },

    load = {
        update_interval = 5000,
        important_threshold = 2.0,
        critical_threshold = 4.0,
    },
}

-- vim: tw=90 sts=-1 sw=4 et
