-- Home scene
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local mydata=require("scripts.mydata")
local frames={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"}
local t={"The Maker of Light","Naming The Animals","The Man From Dust","The Giver of Hope","Tug of War","The Rescuer Who Commanded The Sea","The Winner of Battles","Slingshot War","The Warrior and the Giant","The Bringer of Peace","Princess Coloring Book","The Peacemaker and the King's Throne","The Answerer of Prayers","Spider in The Den","A Hero Escapes Death","The Good News","Heaven's Symphony","The Man from Heaven","The Rescuer Who Walked on the Sea","The Warrior on the Cross","A Hero Defeats Death","The Peacemaker and Heaven's Throne","God Loves You!"}
 function ontouch(event)
    print("enetr")
    if(event.phase=="ended") then
   --[[local options = {
                        
                        effect = "fade",
                        time = 500,
                        params = {
                            
                        }
                    }
    composer.hideOverlay("fade",500)--]]
            transition.to( sceneGroup_over, {alpha=0,time=500,delay=1} )
            function moveoverlay()
            composer.hideOverlay()
        end
        timer.performWithDelay( 500,moveoverlay )

end
end
function scene:create(event)
 sceneGroup_over = self.view
    rectangle=display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth,display.contentHeight)
    rectangle.alpha=0.01
    rectangle:addEventListener("touch",ontouch)
    sceneGroup_over:insert(rectangle)
	bg=display.newImageRect("assets/images/popup_scroll.png",display.contentHeight/1.5*1.66,display.contentHeight/1.5)
    bg.x=display.contentCenterX
    bg.y=display.contentCenterY
    rect.anchorX = 0.5
            rect.anchorY = 0.5
          --  bg.alpha=.7
   sceneGroup_over:insert(bg)
   local options = {
                                   text = "This "..mydata.type2[mydata.currentscene].." will be unlocked after you complete",
                                   x = display.contentCenterX,
                                   y =bg.y-bg.contentHeight/4,
                                  -- width = 210,
                                   font="Averia",
                                   fontSize = 12,
                                   align = "center",
                                    }
                    text1=display.newText(options)
                    text1:setFillColor( .60784,.21568,.019607)
                    sceneGroup_over:insert(text1)
    sheetInfo = require("scripts.menu_sprite")
    myImageSheet = graphics.newImageSheet( "assets/images/menu_sprite.png", sheetInfo:getSheet() )
    locked_item= display.newImageRect( myImageSheet, sheetInfo:getFrameIndex(frames[mydata.currentscene-1]), 100, 100 )
    locked_item.x=display.contentCenterX
    locked_item.y=bg.y
    --locked_item.fill.effect = "filter.desaturate"
    --locked_item.fill.effect.intensity = 1
    sceneGroup_over:insert(locked_item)
    local options = {
                                   text = t[mydata.currentscene-1],
                                   x = display.contentCenterX,
                                   y =bg.y+bg.contentHeight/4,
                                 --  width = 150,
                                   font="Averia",
                                   fontSize = 12,
                                   align = "center",
                                    }
                    text2=display.newText(options)
                    text2:setFillColor( .60784,.21568,.019607)
                    sceneGroup_over:insert(text2)
end
function scene:show(event)
	local sceneGroup_over = self.view
	local phase = event.phase

	
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        
    end

end
-- Hide
function scene:hide(event)
	local sceneGroup_over = self.view
	local phase = event.phase

	 if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end	
function scene:destroy(event)
	local sceneGroup_over = self.view
	-- Called prior to the removal of scene's view ("sceneGroup_over").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end	
-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene