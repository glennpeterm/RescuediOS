--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:11c7bd72f0905c0719ed42519e9a6b41:93b9a35be7cf05eab67b16ee5311f23b:14f82cc5b898890b3b1e4e5c837de0ef$
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
            -- flag anim/0000
            x=890,
            y=1358,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0001
            x=890,
            y=906,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0002
            x=668,
            y=1358,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0003
            x=668,
            y=906,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0004
            x=446,
            y=1358,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0005
            x=446,
            y=906,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0006
            x=224,
            y=1358,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0007
            x=224,
            y=906,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0008
            x=890,
            y=454,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0009
            x=668,
            y=454,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0010
            x=446,
            y=454,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0011
            x=224,
            y=454,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0012
            x=2,
            y=1358,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0013
            x=2,
            y=906,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0014
            x=2,
            y=454,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 30,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0015
            x=890,
            y=2,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 30,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0016
            x=668,
            y=2,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0017
            x=446,
            y=2,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0018
            x=224,
            y=2,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
        {
            -- flag anim/0019
            x=2,
            y=2,
            width=220,
            height=450,

            sourceX = 40,
            sourceY = 31,
            sourceWidth = 300,
            sourceHeight = 500
        },
    },
    
    sheetContentWidth = 1112,
    sheetContentHeight = 1810
}

SheetInfo.frameIndex =
{

    ["flag anim/0000"] = 1,
    ["flag anim/0001"] = 2,
    ["flag anim/0002"] = 3,
    ["flag anim/0003"] = 4,
    ["flag anim/0004"] = 5,
    ["flag anim/0005"] = 6,
    ["flag anim/0006"] = 7,
    ["flag anim/0007"] = 8,
    ["flag anim/0008"] = 9,
    ["flag anim/0009"] = 10,
    ["flag anim/0010"] = 11,
    ["flag anim/0011"] = 12,
    ["flag anim/0012"] = 13,
    ["flag anim/0013"] = 14,
    ["flag anim/0014"] = 15,
    ["flag anim/0015"] = 16,
    ["flag anim/0016"] = 17,
    ["flag anim/0017"] = 18,
    ["flag anim/0018"] = 19,
    ["flag anim/0019"] = 20,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
