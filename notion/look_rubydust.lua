-- look_rubydust.lua drawing engine configuration file for Notion.

if not gr.select_engine("de") then
    return
end

de.reset()

de.defstyle("*", {
    --font = "-*-proggycleanszcp-*-*-*-*-13-*-*-*-*-*-*-*",
    font = "-*-dina-medium-r-*-*-10-*-*-*-*-*-*-*",
    text_align = "left",
})

de.defstyle("frame", {
    based_on = "*",

    shadow_colour = "#000000",
    foreground_colour = "#000000",
    background_colour = "#000000",

    border_style = "elevated",
    border_sides = "all",
    highlight_pixels = 0,
    shadow_pixels = 1,
    padding_pixels = 0,
    spacing = 0,
})

de.defstyle("frame-tiled", {
    based_on = "frame",
})

de.defstyle("frame-tiled-alt", {
    based_on = "frame-tiled",
    bar = "none", -- Possible values: "none", "shaped", "inside", "outside".
})

de.defstyle("frame-floating", {
    based_on = "*",

    highlight_colour = "#000000",
    shadow_colour = "#000000",
    foreground_colour = "#000000",
    background_colour = "#000000",
    padding_colour = "#a0a0a0",

    border_style = "elevated",
    border_sides = "all",
    highlight_pixels = 1,
    shadow_pixels = 1,
    padding_pixels = 1,
    spacing = 0,

    bar = "shaped",
})

de.defstyle("frame-floating-alt", {
    based_on = "frame-floating",
    bar = "none",
})

de.defstyle("frame-transient", {
    based_on = "frame-floating",
})

de.defstyle("frame-transient-alt", {
    based_on = "frame-transient",
    bar = "none",
})

-- *scratchws*
de.defstyle("frame-unknown", {
    based_on = "frame-floating",
    bar = "outside",
})

de.defstyle("frame-unknown-alt", {
    based_on = "frame-unknown",
    bar = "none",
})

de.defstyle("tab", {
    -- All tab bars use this basic style when (re)starting Notion until their
    -- frame gets focused at least once.
    based_on = "*",

    highlight_colour = "#000000",
    shadow_colour = "#000000",
    foreground_colour = "#909090",
    background_colour = "#300000",
    padding_colour = "#303030",

    border_style = "elevated",
    border_sides = "tb",
    highlight_pixels = 1,
    shadow_pixels = 1,
    padding_pixels = 1,
    spacing = 1,

    text_align = "center",

    de.substyle("active-selected", {
        based_on = "tab",
        foreground_colour = "#b0b0b0",
        background_colour = "#300000",
        padding_colour = "#606060", -- The padding color matches the background
                                    -- rather than the generic value set for
                                    -- tabs when not explicitly specified here.
                                    -- Bug?
    }),
    de.substyle("active-unselected", {
        based_on = "tab",
        --foreground_colour = "#b0b0b0",
        background_colour = "#000000",
        padding_colour = "#303030",
    }),
    de.substyle("inactive-selected", {
        based_on = "tab",
    }),
    de.substyle("inactive-unselected", {
        based_on = "tab",
        background_colour = "#000000",
        padding_colour = "#303030",
    }),
})

de.defstyle("tab-frame", {
    based_on = "tab",
})

de.defstyle("tab-frame-tiled-*", {
    based_on = "tab-frame",
})

--de.defstyle("tab-frame-tiled-alt", {
    --based_on = "tab-frame-tiled",
--})

de.defstyle("tab-frame-floating-*", {
    based_on = "tab-frame",
})

de.defstyle("tab-frame-transient-*", {
    based_on = "tab-frame",
})

de.defstyle("tab-frame-unknown-*", {
    based_on = "tab-frame-floating",
})

--de.defstyle("tab-frame-unknown-alt", {
    --based_on = "tab-frame-unknown",
--})

de.defstyle("tab-menuentry", {
    highlight_pixels = 0,
    shadow_pixels = 0,
    padding_pixels = 1,
    spacing = 0,

    text_align = "left",

    de.substyle("*-selected", {
        foreground_colour = "#000000",
        background_colour = "#b0b0b0",
    }),

    de.substyle("*-unselected", {
        foreground_colour = "#b0b0b0",
        background_colour = "#000000",
    }),
})

de.defstyle("input", {
    highlight_colour = "#a0a0a0",
    shadow_colour = "#a0a0a0",
    foreground_colour = "#b0b0b0",
    background_colour = "#000000",

    border_style = "elevated",
    border_sides = "all",
    highlight_pixels = 1,
    shadow_pixels = 1,
    padding_pixels = 1,
    spacing = 1,

    text_align = "left",

    de.substyle("*-selection", {
        foreground_colour = "#000000",
        background_colour = "#b0b0b0",
    }),

    de.substyle("*-cursor", {
        foreground_colour = "#000000",
        background_colour = "#b0b0b0",
    }),
})

de.defstyle("input-menu", {
    highlight_pixels = 1,
    shadow_pixels = 1,
    padding_pixels = 1,
    spacing = 0,
})

de.defstyle("stdisp", {
    highlight_pixels = 0,
    shadow_pixels = 0,
    foreground_colour = "#b0b0b0",
    background_colour = "#000000",

    padding_pixels = 0,
    spacing = 0,

    --text_align = "right", -- default

    de.substyle("important", {
         foreground_colour = "#b0b000", -- yellow
    }),

    de.substyle("critical", {
        foreground_colour = "#b00000", -- red
    }),
})

de.defstyle("stdisp-statusbar", {
    bar = "none",
})

de.defstyle("moveres_display", {
    -- ...
})

de.defstyle("actnotify", {
    based_on = "input-menu",
})

gr.refresh()

-- vim: tw=80 sw=4 et
