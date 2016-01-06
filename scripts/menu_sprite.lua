--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:4168c2d4cda5c1c12f2363ead934c93a:c52445cd2cd3bdb8e8bc2988ceacfcf4:9e85f647d89ec5de178839411c570b8f$
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
            -- 1
            x=2,
            y=2,
            width=380,
            height=366,

        },
        {
            -- 10
            x=2,
            y=370,
            width=380,
            height=366,

        },
        {
            -- 11
            x=2,
            y=738,
            width=380,
            height=366,

        },
        {
            -- 12
            x=2,
            y=1106,
            width=380,
            height=366,

        },
        {
            -- 13
            x=2,
            y=1474,
            width=380,
            height=366,

        },
        {
            -- 14
            x=384,
            y=2,
            width=380,
            height=366,

        },
        {
            -- 15
            x=766,
            y=2,
            width=380,
            height=366,

        },
        {
            -- 16
            x=1148,
            y=2,
            width=380,
            height=366,

        },
        {
            -- 17
            x=1530,
            y=2,
            width=380,
            height=366,

        },
        {
            -- 18
            x=384,
            y=370,
            width=380,
            height=366,

        },
        {
            -- 19
            x=384,
            y=738,
            width=380,
            height=366,

        },
        {
            -- 2
            x=384,
            y=1106,
            width=380,
            height=366,

        },
        {
            -- 20
            x=384,
            y=1474,
            width=380,
            height=366,

        },
        {
            -- 21
            x=766,
            y=370,
            width=380,
            height=366,

        },
        {
            -- 22
            x=1148,
            y=370,
            width=380,
            height=366,

        },
        {
            -- 23
            x=1530,
            y=370,
            width=380,
            height=366,

        },
        {
            -- 3
            x=766,
            y=738,
            width=380,
            height=366,

        },
        {
            -- 4
            x=766,
            y=1106,
            width=380,
            height=366,

        },
        {
            -- 5
            x=766,
            y=1474,
            width=380,
            height=366,

        },
        {
            -- 6
            x=1148,
            y=738,
            width=380,
            height=366,

        },
        {
            -- 7
            x=1530,
            y=738,
            width=380,
            height=366,

        },
        {
            -- 8
            x=1148,
            y=1106,
            width=380,
            height=366,

        },
        {
            -- 9
            x=1530,
            y=1106,
            width=380,
            height=366,

        },
    },
    
    sheetContentWidth = 1912,
    sheetContentHeight = 1842
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["10"] = 2,
    ["11"] = 3,
    ["12"] = 4,
    ["13"] = 5,
    ["14"] = 6,
    ["15"] = 7,
    ["16"] = 8,
    ["17"] = 9,
    ["18"] = 10,
    ["19"] = 11,
    ["2"] = 12,
    ["20"] = 13,
    ["21"] = 14,
    ["22"] = 15,
    ["23"] = 16,
    ["3"] = 17,
    ["4"] = 18,
    ["5"] = 19,
    ["6"] = 20,
    ["7"] = 21,
    ["8"] = 22,
    ["9"] = 23,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
