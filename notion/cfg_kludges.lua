-- Options to get some programs work more nicely (or at all).
--
-- ~/.notion/cfg_kludges.lua

-- Firefox
--
-- Everything's floating and Notion should prefer using supplied window positions.
defwinprop {
    class = "Firefox",
    target = "FirefoxWS",
    float = true,
    userpos = true,
}

-- Don't ignore the _NET_ACTIVE_WINDOW Extended Window Manager Hint for xterms.  This
-- makes it possible to activate an xterm window using wmctrl.
-- https://en.wikipedia.org/wiki/Extended_Window_Manager_Hints
-- http://standards.freedesktop.org/wm-spec/latest/
-- https://sites.google.com/site/tstyblo/wmctrl/
-- http://notion.sf.net/notionconf/node4.html#SECTION00450000000000000000
-- man 1 wmctrl
defwinprop {
    class = "XTerm",
    instance = "xterm",
    ignore_net_active_window = false,
}

-- Actually, the main window isn't floating and it should be placed in a frame called
-- "FirefoxFrame". Create a new workspace using "FirefoxLayout" (defined in
-- cfg_layouts.lua) if no such frame exists.
defwinprop {
    class = "Firefox",
    role = "browser",
    instance = "Navigator",
    target = "FirefoxFrame",
    new_group = "FirefoxLayout",
}

-- The window showing all bookmarks doesn't float either.
defwinprop {
    class = "Firefox",
    role = "Organizer",
    instance = "Places",
}

-- Thunderbird
--
-- Kinda like Firefox.
defwinprop {
    class = "Thunderbird",
    float = true,
    userpos = true,
}

defwinprop {
    class = "Pinentry-gtk-2",
    instance = "pinentry-gtk-2",
    float = true,
    userpos = true,
    max_size = { w = 454, h = 190 },
    -- min_size = { w = 454, h = 176 },
    -- ignore_max_size = true,
    -- ignore_min_size = true,
    -- ignore_cfgrq = true,
    -- ignore_resizeinc = true,
    -- resizeinc = { w = 454, h = 176 },
    -- acrobatic = true,
    -- transient_mode = "current",
    -- ignore_net_active_window = false,
    -- jumpto = true,
    -- lazy_resize = true,
    -- transparent = true,
}

defwinprop {
    class = "Pinentry",
    instance = "pinentry",
    float = true,
    userpos = true,
}

defwinprop {
    class = "Thunderbird",
    role = "3pane",
    instance = "Mail",
}

defwinprop {
    class = "Thunderbird",
    role = "addressbook",
    instance = "Mail",
}

defwinprop {
    class = "Thunderbird",
    role = "Msgcompose",
    instance = "Msgcompose",
}

-- Chromium
--
defwinprop {
    class = "Chromium",
    role = "browser",
    instance = "chromium",
    target = "ChromiumFrame",
    new_group = "ChromiumLayout",
}

-- Conky
--[[
defwinprop {
    class = "Conky",
    instance = "Conky",
    target = "WScreen",
}--]]

-- Gmrun
--
defwinprop {
    class = "Gmrun",
    instance = "gmrun",
    float = true,
    userpos = true,
    jumpto = true,
}

-- Put all dockapps in the statusbar's systray, also adding the missing size hints
-- necessary for this to work.
defwinprop {
    is_dockapp = true,
    statusbar = "systray",
    max_size = { w = 64, h = 64},
    min_size = { w = 64, h = 64},
}

-- Make an exception for Docker, which sets correct size hints.
defwinprop {
    is_dockapp = true,
    class = "Docker",
    statusbar = "systray",
}

defwinprop{
    class = "Gimp",
    acrobatic = true,
    float = true,
} -- http://sourceforge.net/p/notion/bugs/32/

defwinprop{
    class = "Gimp",
    role = "gimp-image-window",
}

-- Define some additional title shortening rules to use when the full title doesn't fit in
-- the available space. The first-defined matching rule that succeeds in making the title
-- short enough is used.
ioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*) - Mozilla", "$1$|$1$<...")
ioncore.defshortening("XMMS - (.*)", "$1$|...$>$1")
ioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("[^:]+: (.*)", "$1$|$1$<...")
ioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*)", "$1$|$1$<...")

-- vim: tw=90 sts=-1 sw=4 et
