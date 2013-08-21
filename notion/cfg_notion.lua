--
-- Notion main configuration file
--

-- Set the META modifier to the Super key.
META="Mod4+"
--ALTMETA=""

-- Use xterm as the terminal emulator.
XTERM="xterm"

ioncore.set{
    -- Consecutive clicks within 200 ms are considered double clicks.
    dblclick_delay=200,
}

-- Load configuration of the Notion 'core'. Most bindings are here.
dopath("cfg_notioncore")

-- Load some kludges to make apps behave better.
dopath("cfg_kludges")

-- Define some layouts.
dopath("cfg_layouts")

-- Load some modules. Bindings and other configuration specific to modules
-- are in the files cfg_modulename.lua.
dopath("mod_query")
dopath("mod_menu")
dopath("mod_tiling")
dopath("mod_statusbar")
--dopath("mod_dock")
dopath("mod_sp")
dopath("mod_notionflux")
dopath("mod_xrandr")

dopath("not_min_tabs")

defbindings("WMPlex.toplevel", {
    kpress(META.."L", nil),     -- Unbind lock screen.
    kpress(ALTMETA.."F3", nil),
    kpress(ALTMETA.."F4", nil), -- Unbind querying for host to SSH to.
    kpress(ALTMETA.."F5", nil), -- Unbind querying for file to edit.
    kpress(ALTMETA.."F6", nil), -- Unbind querying for file to view.
    kpress(META.."R", nil),

    bdoc("Run a terminal emulator."),
    kpress(META.."Return", "mod_query.exec_on_merr(_, XTERM or 'xterm')"),

    bdoc("Query for command line to execute."),
    kpress(META.."R", "mod_query.query_exec(_)"),
})

-- WScreen context bindings; these bindings are available all the time.
defbindings("WScreen", {
    kpress(META.."Tab", nil),
    bdoc("Go to first region demanding attention or previously active one."),
    kpress(META.."Tab", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
})

defbindings("WTiling", {
    kpress(META.."Tab", nil),
    submap(META.."K", {
        kpress("Tab", nil),
    }),

    bdoc("Go to frame above/below current frame."),
    kpress(META.."P", "ioncore.goto_next(_sub, 'up', {no_ascend=_})"),
    kpress(META.."J", "ioncore.goto_next(_sub, 'down', {no_ascend=_})"),
    bdoc("Go to frame right/left of current frame."),
    kpress(META.."L", "ioncore.goto_next(_sub, 'right')"),
    kpress(META.."H", "ioncore.goto_next(_sub, 'left')"),
})

