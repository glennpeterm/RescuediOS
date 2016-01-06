--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a5a7de726ae8d341bd6cf6d5ea47daa2:f59e9c866835195b3b5924f13f2c3ea6:7e79e9df6c7178d298229e53c332a219$
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
            -- about
            x=2,
            y=2,
            width=76,
            height=76,

        },
        {
            -- back
            x=80,
            y=2,
            width=76,
            height=76,

        },
        {
            -- back_hand
            x=158,
            y=2,
            width=76,
            height=76,

        },
        {
            -- back_off
            x=236,
            y=2,
            width=76,
            height=76,

        },
        {
            -- close
            x=314,
            y=2,
            width=76,
            height=76,

        },
        {
            -- credits
            x=392,
            y=2,
            width=76,
            height=76,

        },
        {
            -- fav_off
            x=470,
            y=2,
            width=76,
            height=76,

        },
        {
            -- fav_on
            x=548,
            y=2,
            width=76,
            height=76,

        },
        {
            -- fwrd_off
            x=626,
            y=2,
            width=76,
            height=76,

        },
        {
            -- fwrd_on
            x=704,
            y=2,
            width=76,
            height=76,

        },
        {
            -- home
            x=782,
            y=2,
            width=76,
            height=76,

        },
        {
            -- menu
            x=860,
            y=2,
            width=76,
            height=76,

        },
        {
            -- menu_off
            x=938,
            y=2,
            width=76,
            height=76,

        },
        {
            -- music_off
            x=1016,
            y=2,
            width=76,
            height=76,

        },
        {
            -- music_on
            x=1094,
            y=2,
            width=76,
            height=76,

        },
        {
            -- next_hand
            x=1172,
            y=2,
            width=76,
            height=76,

        },
        {
            -- pause
            x=1250,
            y=2,
            width=76,
            height=76,

        },
        {
            -- play
            x=1328,
            y=2,
            width=76,
            height=76,

        },
        {
            -- reset
            x=1406,
            y=2,
            width=76,
            height=76,

        },
        {
            -- settings
            x=1484,
            y=2,
            width=76,
            height=76,

        },
        {
            -- sound_off
            x=1562,
            y=2,
            width=76,
            height=76,

        },
        {
            -- sound_on
            x=1640,
            y=2,
            width=76,
            height=76,

        },
        {
            -- tick_mark
            x=1718,
            y=2,
            width=76,
            height=76,

        },
    },
    
    sheetContentWidth = 1796,
    sheetContentHeight = 80
}

SheetInfo.frameIndex =
{

    ["about"] = 1,
    ["back"] = 2,
    ["back_hand"] = 3,
    ["back_off"] = 4,
    ["close"] = 5,
    ["credits"] = 6,
    ["fav_off"] = 7,
    ["fav_on"] = 8,
    ["fwrd_off"] = 9,
    ["fwrd_on"] = 10,
    ["home"] = 11,
    ["menu"] = 12,
    ["menu_off"] = 13,
    ["music_off"] = 14,
    ["music_on"] = 15,
    ["next_hand"] = 16,
    ["pause"] = 17,
    ["play"] = 18,
    ["reset"] = 19,
    ["settings"] = 20,
    ["sound_off"] = 21,
    ["sound_on"] = 22,
    ["tick_mark"] = 23,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
