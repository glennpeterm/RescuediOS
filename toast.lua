module(..., package.seeall)
local mydata=require("scripts.mydata")

-------------------------------
-- imports
-------------------------------
--local utils = require("utils")

-------------------------------
-- variables
-------------------------------
--- public

--- private

--- functions
local trueDestroy;

-------------------------------
-- private functions
-------------------------------
function trueDestroy(toast)
    toast:removeSelf();
    toast = nil;
end

-------------------------------
-- public functions
-------------------------------
function new(pText, pTime,scenegroup)
   -- local text = pText or "nil";
   if (mydata.music_status==0 and mydata.narration_status==0) then
        local text = "Sound and Narration is off" or "nil";

    end
    if (mydata.music_status==0 and mydata.narration_status==1) then
        local text = "Sound is off" or "nil";

    end
    if (mydata.music_status==1 and mydata.narration_status==0) then
        local text = "Narration is off" or "nil";

    end

    local pTime = pTime;
    local scene=scenegroup
    local toast = display.newGroup();
scene:insert(toast)
    toast.text= display.newText(toast,"runnng", 0, 0, "Averia", 20);
    toast.text:setFillColor(0,0,0)
    toast.text.alpha=.8
    toast.background = display.newRoundedRect( toast, 0, 0, toast.text.width + 24, toast.text.height + 24, 16 );
   -- toast.background.strokeWidth    = 4
    toast.background.alpha=.9
   toast.background:setFillColor(211/255,211/255,211/255)
 --   toast.background:setStrokeColor(96, 88, 96)

    toast.text:toFront();

  --s  toast:setReferencePoint(toast.width*.5, toast.height*.5)
    --utils.maintainRatio(toast);

    toast.alpha = 0;
    toast.transition = transition.to(toast, {time=250, alpha = 1});

    if pTime ~= nil then
        timer.performWithDelay(pTime, function() destroy(toast) end);
    end

    toast.x = display.contentWidth * .5
    toast.y = display.contentHeight * .5

    return toast;
end

function destroy(toast)
    toast.transition = transition.to(toast, {time=250, alpha = 0, onComplete = function() trueDestroy(toast) end});
end