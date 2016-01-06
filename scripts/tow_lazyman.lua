--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a665d4ad9891844763326fe418489851:be1b47bee8457ddff38e74110100fa7c:336fb76d99b0e79f2f535dc55b725492$
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
            -- lazy man/0000
            x=2,
            y=2,
            width=158,
            height=240,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0001
            x=320,
            y=2,
            width=180,
            height=238,

            sourceX = 13,
            sourceY = 4,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0002
            x=320,
            y=2,
            width=180,
            height=238,

            sourceX = 13,
            sourceY = 4,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0003
            x=2,
            y=2,
            width=158,
            height=240,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0004
            x=502,
            y=2,
            width=164,
            height=238,

            sourceX = 13,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0005
            x=834,
            y=2,
            width=170,
            height=236,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0006
            x=668,
            y=2,
            width=164,
            height=238,

            sourceX = 13,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0007
            x=2,
            y=2,
            width=158,
            height=240,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0008
            x=320,
            y=2,
            width=180,
            height=238,

            sourceX = 13,
            sourceY = 4,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0009
            x=320,
            y=2,
            width=180,
            height=238,

            sourceX = 13,
            sourceY = 4,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0010
            x=2,
            y=2,
            width=158,
            height=240,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0011
            x=502,
            y=2,
            width=164,
            height=238,

            sourceX = 13,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0012
            x=834,
            y=2,
            width=170,
            height=236,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0013
            x=668,
            y=2,
            width=164,
            height=238,

            sourceX = 13,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0014
            x=2,
            y=2,
            width=158,
            height=240,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0015
            x=320,
            y=2,
            width=180,
            height=238,

            sourceX = 13,
            sourceY = 4,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0016
            x=320,
            y=2,
            width=180,
            height=238,

            sourceX = 13,
            sourceY = 4,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0017
            x=2,
            y=2,
            width=158,
            height=240,

            sourceX = 15,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0018
            x=502,
            y=2,
            width=164,
            height=238,

            sourceX = 13,
            sourceY = 5,
            sourceWidth = 236,
            sourceHeight = 250
        },
        {
            -- lazy man/0019
            x=162,
            y=2,
            width=156,
            height=240,

            sourceX = 25,
            sourceY = 7,
            sourceWidth = 236,
            sourceHeight = 250
        },
    },
    
    sheetContentWidth = 1006,
    sheetContentHeight = 244
}

SheetInfo.frameIndex =
{

    ["lazy man/0000"] = 1,
    ["lazy man/0001"] = 2,
    ["lazy man/0002"] = 3,
    ["lazy man/0003"] = 4,
    ["lazy man/0004"] = 5,
    ["lazy man/0005"] = 6,
    ["lazy man/0006"] = 7,
    ["lazy man/0007"] = 8,
    ["lazy man/0008"] = 9,
    ["lazy man/0009"] = 10,
    ["lazy man/0010"] = 11,
    ["lazy man/0011"] = 12,
    ["lazy man/0012"] = 13,
    ["lazy man/0013"] = 14,
    ["lazy man/0014"] = 15,
    ["lazy man/0015"] = 16,
    ["lazy man/0016"] = 17,
    ["lazy man/0017"] = 18,
    ["lazy man/0018"] = 19,
    ["lazy man/0019"] = 20,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
