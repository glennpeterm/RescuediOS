--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e3dfaa07dff1a50f34fd7c3f1df59b85:b1853a47c4fd62ae85d013bd9cdbf719:ca779cd82e5b7335e8f11dd2897b2ce9$
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
            -- bird_slow/0000
            x=104,
            y=68,
            width=96,
            height=72,

            sourceX = 0,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0001
            x=104,
            y=68,
            width=96,
            height=72,

            sourceX = 0,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0002
            x=2,
            y=64,
            width=100,
            height=64,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0003
            x=2,
            y=64,
            width=100,
            height=64,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0004
            x=98,
            y=2,
            width=94,
            height=60,

            sourceX = 0,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0005
            x=98,
            y=2,
            width=94,
            height=60,

            sourceX = 0,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0006
            x=2,
            y=130,
            width=94,
            height=74,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0007
            x=2,
            y=130,
            width=94,
            height=74,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0008
            x=194,
            y=142,
            width=94,
            height=78,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0009
            x=194,
            y=142,
            width=94,
            height=78,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0010
            x=98,
            y=142,
            width=94,
            height=74,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0011
            x=98,
            y=142,
            width=94,
            height=74,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0012
            x=2,
            y=2,
            width=94,
            height=58,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0013
            x=2,
            y=2,
            width=94,
            height=58,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0014
            x=194,
            y=2,
            width=94,
            height=64,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {
            -- bird_slow/0015
            x=194,
            y=2,
            width=94,
            height=64,

            sourceX = 0,
            sourceY = 11,
            sourceWidth = 100,
            sourceHeight = 100
        },
    },
    
    sheetContentWidth = 290,
    sheetContentHeight = 222
}

SheetInfo.frameIndex =
{

    ["bird_slow/0000"] = 1,
    ["bird_slow/0001"] = 2,
    ["bird_slow/0002"] = 3,
    ["bird_slow/0003"] = 4,
    ["bird_slow/0004"] = 5,
    ["bird_slow/0005"] = 6,
    ["bird_slow/0006"] = 7,
    ["bird_slow/0007"] = 8,
    ["bird_slow/0008"] = 9,
    ["bird_slow/0009"] = 10,
    ["bird_slow/0010"] = 11,
    ["bird_slow/0011"] = 12,
    ["bird_slow/0012"] = 13,
    ["bird_slow/0013"] = 14,
    ["bird_slow/0014"] = 15,
    ["bird_slow/0015"] = 16,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
