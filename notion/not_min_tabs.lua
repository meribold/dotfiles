-- not_min_tabs.lua

-- Lua script for Notion hiding the tab bar of frames that are not using the
-- styles "floating" or "transient" and contain exacly one client window.

-- Copyright 2013 Lukas Waymann <lb.waym@gmail.com>

-- This program is free software: you can redistribute it and/or modify it under
-- the terms of the GNU Lesser General Public License as published by the Free
-- Software Foundation, either version 3 of the License, or (at your option) any
-- later version.

-- For a copy of the GNU Lesser General Public License, see
-- <http://www.gnu.org/licenses/>

-- Compared to the original min_tabs.lua script, this version does not define a
-- keybinding, works for the sratchpad and covers some problems arising when
-- exiting Notion without closing all client windows first.

-- Enable by adding dopath("not_min_tabs") to (e.g.) your cfg_notion.lua and
-- defining adapted "-alt" styles in your "look_something.lua" (usually
-- "frame-tiled-alt" with the argument "bar = "none"").

-- Uncomment entries you don't want to be handled.
local excludes = {
    --tiled = true,
    --unknown = true,
    floating = true,
    transient = true,
}

function hide_tabs(fr)  -- fr must be a WFrame.
    return function()
        fr:set_mode(string.sub(fr:mode(),
                    string.find(fr:mode(), "[^-]*")).."-alt")
    end
end

function show_tabs(fr)  -- fr must be a WFrame.
    return function()
        fr:set_mode(string.sub(fr:mode(), string.find(fr:mode(), "[^-]*")))
    end
end

function reconsider_tabs(fr)
    if excludes[fr:mode()] then
        return
    end

    if WMPlex.mx_count(fr) == 1 and not fr:mx_nth(0):is_tagged() then
        notioncore.defer(hide_tabs(fr))
    else
        notioncore.defer(show_tabs(fr))
    end
end

notioncore.get_hook("frame_managed_changed_hook"):add(
    -- See http://notion.sourceforge.net/notionconf (6.9 Hooks) for the
    -- interface of the type of the argument that will substitute table.
    function(table)
        reconsider_tabs(table.reg)
    end
)

-- Should be more reliable than changing the binding that invokes
-- WRegion.set_tagged() (META.."T")
notioncore.get_hook("region_notify_hook"):add(
    function(reg, context)
        if context == "tag" then
            reconsider_tabs(notioncore.find_manager(reg, "WFrame"))
        end
    end
)

-- WFrames that were not correctly reset to their normal syles (i.e. having
-- tabs) when exiting Notion the last time are now, at startup. This is
-- nescessary if Notion was exited while any WFrame contained exacly one client
-- window (that thus had no tab bar).
notioncore.get_hook("ioncore_post_layout_setup_hook"):add(
    function()
        notioncore.region_i(
            function(fr)
                reconsider_tabs(fr)
                return true
            end, "WFrame")
    end
)
