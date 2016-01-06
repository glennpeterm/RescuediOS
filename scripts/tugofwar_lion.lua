--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:5481f9f4a35dd7cf965c446f30287a2b:4af834f36c410d577db6c40823aec53c:4ded079761bbe16aef41f458bd1e5a02$
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
            -- new walk/0000
            x=2,
            y=2,
            width=168,
            height=176,

            sourceX = 65,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0001
            x=172,
            y=2,
            width=166,
            height=176,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0002
            x=340,
            y=2,
            width=164,
            height=176,

            sourceX = 66,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0003
            x=506,
            y=2,
            width=166,
            height=172,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0004
            x=2,
            y=2,
            width=168,
            height=176,

            sourceX = 65,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0005
            x=172,
            y=2,
            width=166,
            height=176,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0006
            x=340,
            y=2,
            width=164,
            height=176,

            sourceX = 66,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0007
            x=506,
            y=2,
            width=166,
            height=172,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0008
            x=2,
            y=2,
            width=168,
            height=176,

            sourceX = 65,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0009
            x=172,
            y=2,
            width=166,
            height=176,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0010
            x=340,
            y=2,
            width=164,
            height=176,

            sourceX = 66,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0011
            x=506,
            y=2,
            width=166,
            height=172,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0012
            x=2,
            y=2,
            width=168,
            height=176,

            sourceX = 65,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0013
            x=172,
            y=2,
            width=166,
            height=176,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0014
            x=340,
            y=2,
            width=164,
            height=176,

            sourceX = 66,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0015
            x=506,
            y=2,
            width=166,
            height=172,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0016
            x=2,
            y=2,
            width=168,
            height=176,

            sourceX = 65,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0017
            x=172,
            y=2,
            width=166,
            height=176,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0018
            x=340,
            y=2,
            width=164,
            height=176,

            sourceX = 66,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0019
            x=506,
            y=2,
            width=166,
            height=172,

            sourceX = 64,
            sourceY = 22,
            sourceWidth = 300,
            sourceHeight = 200
        },
        {
            -- new walk/0020
            x=674,
            y=2,
            width=166,
            height=170,

            sourceX = 64,
            sourceY = 28,
            sourceWidth = 300,
            sourceHeight = 200
        },
    },
    
    sheetContentWidth = 842,
    sheetContentHeight = 180
}

SheetInfo.frameIndex =
{

    ["new walk/0000"] = 1,
    ["new walk/0001"] = 2,
    ["new walk/0002"] = 3,
    ["new walk/0003"] = 4,
    ["new walk/0004"] = 5,
    ["new walk/0005"] = 6,
    ["new walk/0006"] = 7,
    ["new walk/0007"] = 8,
    ["new walk/0008"] = 9,
    ["new walk/0009"] = 10,
    ["new walk/0010"] = 11,
    ["new walk/0011"] = 12,
    ["new walk/0012"] = 13,
    ["new walk/0013"] = 14,
    ["new walk/0014"] = 15,
    ["new walk/0015"] = 16,
    ["new walk/0016"] = 17,
    ["new walk/0017"] = 18,
    ["new walk/0018"] = 19,
    ["new walk/0019"] = 20,
    ["new walk/0020"] = 21,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
