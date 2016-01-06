local composer = require( "composer" )
local scene = composer.newScene()
local mydata=require("scripts.mydata")

local msg = require("scripts.globals.constant")
-- local forward references should go here --
local window, hand, instructions
local back, play, right, gameNumber
local onhome=0
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:

function scene:create( event )
--Runtime:addEventListener( "key", onKeyEvent_instrctn);
    local group = self.view
    gameNumber = event.params.gameIndex
    
    --instructions.anchorY = 0
    --instructions:scale(0.5, 0.5)
    --instructions:scale(0.21, 0.21)
   

   
    if (gameNumber == 1) then
        instructions = display.newImageRect("assets/images/game1.png", display.contentWidth, display.contentHeight)
    elseif (gameNumber == 2) then
        instructions = display.newImageRect("assets/images/game2.png", display.contentWidth, display.contentHeight)
    elseif (gameNumber == 3) then
        instructions = display.newImageRect("assets/images/game3.png", display.contentWidth, display.contentHeight)
    elseif (gameNumber == 4) then
        instructions = display.newImageRect("assets/images/game4.png", display.contentWidth, display.contentHeight)
    elseif (gameNumber == 5) then
        instructions = display.newImageRect("assets/images/game5.png", display.contentWidth, display.contentHeight)
    elseif (gameNumber == 6) then
        instructions = display.newImageRect("assets/images/game6.png", display.contentWidth, display.contentHeight)
    end   

    instructions.x = display.contentCenterX
    instructions.y = display.contentCenterY 
   
    group:insert(instructions)
end

-- Called immediately after scene has moved onscreen:

function scene:show( event )
    local group = self.view
    print("Overlay show")
    local function tapHandler ( event )
        if "ended" == event.phase then 
        mydata.scene_show=true
            instructions:removeEventListener ( "touch", tapHandler )
            composer.hideOverlay( "fade", 300 )
        end
    end
    if (instructions) then
        instructions:addEventListener("touch", tapHandler )
    end
    
end
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
     -- Runtime:removeEventListener( "key", onKeyEvent_instrctn);

        if (gameNumber == 2) then
            parent:initGame()
        end    
        if (gameNumber == 6) then
            parent:onstart()
        end
        if (gameNumber == 5) then
            parent:enablebutton()
        end 
        parent:show_toast()
       -- parent:initGame()
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