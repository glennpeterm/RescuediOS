local composer = require( "composer" )
local scene = composer.newScene()

local msg = require("scripts.globals.constant")
-- local forward references should go here --
local window, hand
local back, play, right

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:create( event )
    local group = self.view
    local msgText = ""
    window = display.newRoundedRect ( group, display.contentCenterX, display.contentCenterY, display.contentWidth+20, display.contentHeight+20, 0 )
    window:setFillColor (0,0,0)

    window.alpha = 0.7
  
 
    hand = display.newImage("assets/images/flick_hand.png")
    hand.anchorY = 0

    hand:scale(0.21, 0.21)
    hand.x = display.contentCenterX+20
    hand.y = display.contentCenterY

    transition.to(hand, {x= hand.x+150, time=1500})
	timer.performWithDelay(1800, function() hand.x = display.contentCenterX+20 transition.to(hand, {x= hand.x+150, time=1500})end)
	timer.performWithDelay(3600, function() hand.x = display.contentCenterX+20 transition.to(hand, {x= hand.x+150, time=1500})end)
	timer.performWithDelay(5400, function() hand.x = display.contentCenterX+20 transition.to(hand, {x= hand.x+150, time=1500}) composer.hideOverlay( "fade", 200 ) end)	
	
	
    --hand.x = display.contentCenterX+20
    --transition.to(hand, {x= hand.x+150, time=1500, alpha=0})

    group:insert(hand)

end

-- Called immediately after scene has moved onscreen:
function scene:show( event )
    local group = self.view

    local function tapHandler ( event )
        if "ended" == event.phase then 
            hand:removeEventListener ( "touch", tapHandler )
            composer.hideOverlay( "fade", 400 )
        end
    end
    
    --if (hand) then
    --	hand:addEventListener("touch", tapHandler )
	--end
end
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
        parent:initGame()
    end
end

-- By some method (a "resume" button, for example), hide the overlay
scene:addEventListener( "hide", scene )
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

---------------------------------------------------------------------------------

return scene