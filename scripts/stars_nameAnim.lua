--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:f47a8dca84f99cf5fa51ac4b80b5f560:b9b4cf0c15828cbf17a1159d86027b69:13e5c8af5f6e034ece09e9f2075e4d39$
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
            -- Naming the animals stars/0000
            x=2,
            y=2,
            width=168,
            height=130,

            sourceX = 25,
            sourceY = 35,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0001
            x=172,
            y=2,
            width=170,
            height=132,

            sourceX = 24,
            sourceY = 34,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0002
            x=344,
            y=2,
            width=174,
            height=136,

            sourceX = 22,
            sourceY = 32,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0003
            x=696,
            y=2,
            width=176,
            height=140,

            sourceX = 21,
            sourceY = 30,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0004
            x=182,
            y=140,
            width=180,
            height=142,

            sourceX = 18,
            sourceY = 29,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0005
            x=548,
            y=144,
            width=184,
            height=146,

            sourceX = 16,
            sourceY = 27,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0006
            x=2,
            y=284,
            width=186,
            height=150,

            sourceX = 15,
            sourceY = 25,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0007
            x=380,
            y=292,
            width=188,
            height=152,

            sourceX = 15,
            sourceY = 25,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0008
            x=762,
            y=292,
            width=192,
            height=156,

            sourceX = 12,
            sourceY = 22,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0009
            x=198,
            y=446,
            width=196,
            height=160,

            sourceX = 10,
            sourceY = 20,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0010
            x=594,
            y=450,
            width=198,
            height=162,

            sourceX = 9,
            sourceY = 20,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0011
            x=520,
            y=2,
            width=174,
            height=136,

            sourceX = 22,
            sourceY = 32,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0012
            x=2,
            y=136,
            width=178,
            height=140,

            sourceX = 20,
            sourceY = 30,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0013
            x=364,
            y=140,
            width=182,
            height=142,

            sourceX = 17,
            sourceY = 29,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0014
            x=734,
            y=144,
            width=184,
            height=146,

            sourceX = 16,
            sourceY = 27,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0015
            x=190,
            y=284,
            width=188,
            height=150,

            sourceX = 14,
            sourceY = 25,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0016
            x=570,
            y=292,
            width=190,
            height=152,

            sourceX = 13,
            sourceY = 24,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0017
            x=2,
            y=436,
            width=194,
            height=156,

            sourceX = 11,
            sourceY = 22,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0018
            x=396,
            y=446,
            width=196,
            height=160,

            sourceX = 10,
            sourceY = 20,
            sourceWidth = 220,
            sourceHeight = 200
        },
        {
            -- Naming the animals stars/0019
            x=794,
            y=450,
            width=200,
            height=162,

            sourceX = 8,
            sourceY = 19,
            sourceWidth = 220,
            sourceHeight = 200
        },
    },
    
    sheetContentWidth = 996,
    sheetContentHeight = 614
}

SheetInfo.frameIndex =
{

    ["Naming the animals stars/0000"] = 1,
    ["Naming the animals stars/0001"] = 2,
    ["Naming the animals stars/0002"] = 3,
    ["Naming the animals stars/0003"] = 4,
    ["Naming the animals stars/0004"] = 5,
    ["Naming the animals stars/0005"] = 6,
    ["Naming the animals stars/0006"] = 7,
    ["Naming the animals stars/0007"] = 8,
    ["Naming the animals stars/0008"] = 9,
    ["Naming the animals stars/0009"] = 10,
    ["Naming the animals stars/0010"] = 11,
    ["Naming the animals stars/0011"] = 12,
    ["Naming the animals stars/0012"] = 13,
    ["Naming the animals stars/0013"] = 14,
    ["Naming the animals stars/0014"] = 15,
    ["Naming the animals stars/0015"] = 16,
    ["Naming the animals stars/0016"] = 17,
    ["Naming the animals stars/0017"] = 18,
    ["Naming the animals stars/0018"] = 19,
    ["Naming the animals stars/0019"] = 20,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
