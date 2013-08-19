--
-- Notion main configuration file
--
-- This file only includes some settings that are rather frequently altered.
-- The rest of the settings are in cfg_notioncore.lua and individual modules'
-- configuration files (cfg_modulename.lua).
--
-- When any binding and other customisations that you want are minor, it is
-- recommended that you include them in a copy of this file in ~/.notion/.
-- Simply create or copy the relevant settings at the end of this file (from
-- the other files), recalling that a key can be unbound by passing 'nil'
-- (without the quotes) as the callback. For more information, please see
-- the Notion configuration manual available from the Notion Web page.
--

-- Set default modifiers. Alt should usually be mapped to Mod1 on
-- XFree86-based systems. The flying window keys are probably Mod3
-- or Mod4; see the output of 'xmodmap'.
META="Mod4+"
--ALTMETA=""

-- Terminal emulator
--XTERM="xterm"

-- Some basic settings
ioncore.set{
    -- Maximum delay between clicks in milliseconds to be considered a
    -- double click.
    --dblclick_delay=250,

    -- For keyboard resize, time (in milliseconds) to wait after latest
    -- key press before automatically leaving resize mode (and doing
    -- the resize in case of non-opaque move).
    --kbresize_delay=1500,

    -- Opaque resize?
    --opaque_resize=false,

    -- Movement commands warp the pointer to frames instead of just
    -- changing focus. Enabled by default.
    --warp=true,
    
    -- Switch frames to display newly mapped windows
    --switchto=true,
    
    -- Default index for windows in frames: one of 'last', 'next' (for
    -- after current), or 'next-act' (for after current and anything with
    -- activity right after it).
    --frame_default_index='next',
    
    -- Auto-unsqueeze transients/menus/queries.
    --unsqueeze=true,
    
    -- Display notification tooltips for activity on hidden workspace.
    --screen_notify=true,
}


-- Load default settings. The file cfg_defaults loads all the files
-- commented out below, except mod_dock. If you do not want to load
-- something, comment out this line, and uncomment the lines corresponding
-- the the modules or configuration files that you want, below.
-- The modules' configuration files correspond to the names of the 
-- modules with 'mod' replaced by 'cfg'.
dopath("cfg_defaults")
dopath("not_min_tabs")

-- Load configuration of the Notion 'core'. Most bindings are here.
--dopath("cfg_notioncore")

-- Load some kludges to make apps behave better.
--dopath("cfg_kludges")

-- Define some layouts. 
--dopath("cfg_layouts")

-- Load some modules. Bindings and other configuration specific to modules
-- are in the files cfg_modulename.lua.
--dopath("mod_query")
--dopath("mod_menu")
--dopath("mod_tiling")
--dopath("mod_statusbar")
--dopath("mod_dock")
--dopath("mod_sp")

defbindings("WMPlex.toplevel", {
    bdoc("Query for manual page to be displayed."),
    kpress(ALTMETA.."F1", "mod_query.query_man(_, ':man')"),

    bdoc("Show the Notion manual page."),
    kpress(META.."F1", "ioncore.exec_on(_, ':man notion')"),

    bdoc("Run a terminal emulator."),
    kpress(META.."Return", "mod_query.exec_on_merr(_, XTERM or 'xterm')"),
    
    kpress(ALTMETA.."F3", nil),
    kpress(META.."R", nil),
    bdoc("Query for command line to execute."),
    kpress(META.."R", "mod_query.query_exec(_)"),

    bdoc("Query for Lua code to execute."),
    kpress(META.."F3", "mod_query.query_lua(_)"),

    bdoc("Query for host to connect to with SSH."),
    kpress(ALTMETA.."F4", "mod_query.query_ssh(_, ':ssh')"),

    bdoc("Query for file to edit."),
    kpress(ALTMETA.."F5", 
           "mod_query.query_editfile(_, 'run-mailcap --action=edit')"),

    bdoc("Query for file to view."),
    kpress(ALTMETA.."F6", 
           "mod_query.query_runfile(_, 'run-mailcap --action=view')"),

    bdoc("Query for workspace to go to or create a new one."),
    kpress(ALTMETA.."F9", "mod_query.query_workspace(_)"),
})


--
-- Common customisations
--

-- Uncommenting the following lines should get you plain-old-menus instead
-- of query-menus.

--defbindings("WScreen", {
--    kpress(ALTMETA.."F12", "mod_menu.menu(_, _sub, 'mainmenu', {big=true})"),
--})
--
--defbindings("WMPlex.toplevel", {
--    kpress(META.."M", "mod_menu.menu(_, _sub, 'ctxmenu')"),
--})

