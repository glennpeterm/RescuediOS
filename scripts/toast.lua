module(..., package.seeall)
local mydata=require("scripts.mydata")
local trueDestroy;
function trueDestroy(toast)
    toast:removeSelf();
    toast = nil;
end
function new(pText, pTime,scenegroup)
    local text = pText
    local pTime = 1200
    local scene=scenegroup
    local toast = display.newGroup();
    scene:insert(toast)
    toast.text= display.newText(toast,text, 0, 0, "Averia", 20);
    toast.text:setFillColor(0,0,0)
    toast.text.alpha=.8
    toast.background = display.newRoundedRect( toast, 0, 0, toast.text.width + 24, toast.text.height + 24, 16 );
    toast.background.alpha=.9
    toast.background:setFillColor(211/255,211/255,211/255)
    toast.text:toFront();
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