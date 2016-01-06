--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:6f34799289e671509ec61989ebabb24a:e936a6a33999aea803be85235a028969:e48a078b71eb74a185cb0df7d0486ff7$
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
            -- Spider/0000
            x=155,
            y=2,
            width=133,
            height=203,

            sourceX = 6,
            sourceY = 5,
            sourceWidth = 155,
            sourceHeight = 213
        },
        {
            -- Spider/0001
            x=155,
            y=2,
            width=133,
            height=203,

            sourceX = 6,
            sourceY = 5,
            sourceWidth = 155,
            sourceHeight = 213
        },
        {
            -- Spider/0002
            x=2,
            y=2,
            width=151,
            height=179,

            sourceX = 3,
            sourceY = 18,
            sourceWidth = 155,
            sourceHeight = 213
        },
        {
            -- Spider/0003
            x=2,
            y=2,
            width=151,
            height=179,

            sourceX = 3,
            sourceY = 18,
            sourceWidth = 155,
            sourceHeight = 213
        },
        {
            -- Spider/0004
            x=155,
            y=207,
            width=133,
            height=203,

            sourceX = 6,
            sourceY = 5,
            sourceWidth = 155,
            sourceHeight = 213
        },
        {
            -- Spider/0005
            x=155,
            y=207,
            width=133,
            height=203,

            sourceX = 6,
            sourceY = 5,
            sourceWidth = 155,
            sourceHeight = 213
        },
        {
            -- Spider/0006
            x=2,
            y=183,
            width=151,
            height=179,

            sourceX = 3,
            sourceY = 18,
            sourceWidth = 155,
            sourceHeight = 213
        },
        {
            -- Spider/0007
            x=2,
            y=183,
            width=151,
            height=179,

            sourceX = 3,
            sourceY = 18,
            sourceWidth = 155,
            sourceHeight = 213
        },
    },
    
    sheetContentWidth = 290,
    sheetContentHeight = 412
}

SheetInfo.frameIndex =
{

    ["Spider/0000"] = 1,
    ["Spider/0001"] = 2,
    ["Spider/0002"] = 3,
    ["Spider/0003"] = 4,
    ["Spider/0004"] = 5,
    ["Spider/0005"] = 6,
    ["Spider/0006"] = 7,
    ["Spider/0007"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
