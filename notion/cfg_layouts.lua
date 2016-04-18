--
-- Layouts for Notion
--

--
-- Helper routines and structures
--

-- Tiled frame template for the layouts below
local a_frame = {
    type="WSplitRegion",
    regparams = {
        type = "WFrame",
        frame_style = "frame-tiled"
    }
}

-- Helper function for generating splits for layouts
local function mksplit(dir, tl, br, float)
    return {
        type = (float and "WSplitFloat" or "WSplitSplit"),
        dir = dir,
        tls = 1,
        brs = 1,
        tl = tl,
        br = br,
    }
end

local function mktiling(split_tree)
    return {
        managed = {
            {
                type = "WTiling",
                bottom = true, -- Make it the bottom of the group
                split_tree = split_tree,
            }
        }
    }
end

--
-- The layouts
--

-- Tiling with single 1:1 horizontal split
local tmp=mktiling(mksplit("horizontal", a_frame, a_frame))
ioncore.deflayout("hsplit", tmp)
ioncore.deflayout("default", tmp)

-- Tiling with single 1:1 vertical split
ioncore.deflayout("vsplit",
    mktiling(mksplit("vertical", a_frame, a_frame))
)

-- Tiling with single 1:1 floating horizontal split
ioncore.deflayout("hfloat",
    mktiling(mksplit("horizontal", a_frame, a_frame, true))
)

-- Tiling with single 1:1 floating vertical split
ioncore.deflayout("vfloat",
    mktiling(mksplit("vertical", a_frame, a_frame, true))
)

-- Tiling with horizontal and then vertical splits
ioncore.deflayout("2x2",
    mktiling(mksplit("horizontal",
                     mksplit("vertical", a_frame, a_frame),
                     mksplit("vertical", a_frame, a_frame))
    )
)

-- Tiling with single full screen frame.
ioncore.deflayout("full", mktiling(a_frame))

-- Workspace for Firefox.
ioncore.deflayout("FirefoxLayout", {
    name = "FirefoxWS",
    managed = {
        {
            type = "WTiling",
            bottom = true,
            split_tree = {
                type="WSplitRegion",
                regparams = {
                    type = "WFrame",
                    name = "FirefoxFrame",
                    frame_style = "frame-tiled"
                },
            },
        },
    },
})

-- Workspace for Chromium.
ioncore.deflayout("ChromiumLayout", {
    name = "ChromiumWS",
    managed = {
        {
            type = "WTiling",
            bottom = true,
            split_tree = {
                type="WSplitRegion",
                regparams = {
                    type = "WFrame",
                    name = "ChromiumFrame",
                    frame_style = "frame-tiled"
                },
            },
        },
    },
})

-- vim: tw=90 sts=-1 sw=4 et
