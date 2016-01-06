--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b152a1edc7ba74684e21305de9ccceb1:7eef11a47de3a7f79e10fd72f47c0ad0:1e8e9155d70c6e12bd008217dc1a8b4b$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- energy_green
            x=2,
            y=710,
            width=1126,
            height=123,

            sourceX = 37,
            sourceY = 33,
            sourceWidth = 1200,
            sourceHeight = 191
        },
        {
            -- energy_orange
            x=848,
            y=835,
            width=562,
            height=123,

            sourceX = 37,
            sourceY = 33,
            sourceWidth = 1200,
            sourceHeight = 191
        },
        {
            -- energy_red
            x=686,
            y=2,
            width=282,
            height=123,

            sourceX = 36,
            sourceY = 33,
            sourceWidth = 1200,
            sourceHeight = 191
        },
        {
            -- energy_round
            x=2,
            y=2,
            width=682,
            height=706,

        },
        {
            -- energy_yellow
            x=2,
            y=835,
            width=844,
            height=123,

            sourceX = 37,
            sourceY = 33,
            sourceWidth = 1200,
            sourceHeight = 191
        },
        {
            -- nav_dots_avtive
            x=970,
            y=2,
            width=145,
            height=138,

        },
        {
            -- nav_dots_inavtive
            x=1130,
            y=692,
            width=145,
            height=138,

        },
        {
            -- nav_holder
            x=686,
            y=578,
            width=500,
            height=112,

        },
        {
            -- slink01
            x=1412,
            y=2,
            width=426,
            height=950,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 500,
            sourceHeight = 950
        },
        {
            -- slink02
            x=1130,
            y=2,
            width=172,
            height=574,

            sourceX = 328,
            sourceY = 46,
            sourceWidth = 500,
            sourceHeight = 950
        },
    },
    
    sheetContentWidth = 1840,
    sheetContentHeight = 960
}

SheetInfo.frameIndex =
{

    ["energy_green"] = 1,
    ["energy_orange"] = 2,
    ["energy_red"] = 3,
    ["energy_round"] = 4,
    ["energy_yellow"] = 5,
    ["nav_dots_avtive"] = 6,
    ["nav_dots_inavtive"] = 7,
    ["nav_holder"] = 8,
    ["slink01"] = 9,
    ["slink02"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
