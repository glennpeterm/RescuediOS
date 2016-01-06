----------------------------------------------------------------------------------
--
-- splash.lua
--
----------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
display.setStatusBar( display.HiddenStatusBar )
system.setIdleTimer( false )
local listener10 = function( obj )
	composer.gotoScene("scripts.home",{effect="fade",time=500})
end
local listener9 = function( obj )
	transition.to( scroll, { time=900, alpha=1,delay=1,x=(display.contentCenterX-display.contentWidth/35), y=(-display.contentHeight/4),transition=easing.inExpo,onComplete=listener10 } )
end
local listener8 = function( obj )
	 transition.to( scroll, { time=250, alpha=1,delay=2, x=(display.contentCenterX-display.contentWidth/35), y=(display.contentCenterY+display.contentCenterY/30),transition=easing.outExpo,onComplete=listener9} )
end
local listener7 = function( obj )
	transition.to( logo_rescued, { time=500, alpha=0,delay=1000, x=(display.contentCenterX), y=(display.contentCenterY),onComplete=listener8} )
end
local listener6 = function( obj )
	transition.to( logo_rescued, { time=500, alpha=1,delay=1000, x=(display.contentCenterX), y=(display.contentCenterY),onComplete=listener7} )
end
local listener5 = function( obj )
	transition.to( logo, { time=500, alpha=0,delay=1000, x=(display.contentCenterX), y=(display.contentCenterY),onComplete=listener6} )
end
local listener4 = function( obj )
	transition.to( logo, { time=500, alpha=1,delay=1000, x=(display.contentCenterX), y=(display.contentCenterY),onComplete=listener5} )
end
local listener3 = function( obj )
	transition.to( loadingtext, { time=500, alpha=0,delay=1000, x=(display.contentCenterX), y=(display.contentCenterY),onComplete=listener4} )
end
local listener2 = function( obj )
	transition.to( loadingtext, { time=250, alpha=1,delay=2, x=(display.contentCenterX), y=(display.contentCenterY),onComplete=listener3} )
end
local listener1 = function( obj )
  transition.to( scroll, { time=250, alpha=1, delay=1,x=(display.contentCenterX-display.contentWidth/35), y=(display.contentCenterY), transition=easing.inExpo,onComplete=listener2 } )
end

function scene:create( event )
	local sceneGroup = self.view
	background=display.newImageRect("assets/images/bg2.jpg",display.contentHeight*2,display.contentHeight+display.contentHeight/10)
	background.anchorX = 1
	background.anchorY = 0.5
	background.x=display.contentWidth
	background.y=display.contentCenterY
	sceneGroup:insert(background)
	scroll=display.newImageRect("assets/images/scroll_wh.png",display.contentWidth+display.contentWidth/3,display.contentHeight/2)
	scroll.anchorX = .5
	scroll.anchorY = 0.5
	scroll.x=display.contentCenterX-display.contentWidth/35
	scroll.y=display.contentHeight+display.contentHeight/5
	sceneGroup:insert(scroll)
	loadingtext=display.newText("Loading...",display.contentCenterX,display.contentCenterY,"Averia",25)
	loadingtext:setFillColor( .60784,.21568,.019607)
	loadingtext.alpha=0
	sceneGroup:insert(loadingtext)
	transition.to( scroll, { time=900, alpha=1,delay=1000, x=(display.contentCenterX-display.contentWidth/35), y=(display.contentCenterY-display.contentCenterY/30),transition=easing.outExpo, onComplete=listener1 } )
	logo=display.newImageRect("assets/images/logo.png",166,62 )
	logo.x=display.contentCenterX
	logo.y=display.contentCenterY
	logo.alpha=0
	logo_rescued=display.newImageRect("assets/images/rescued.png",265,50 )
	logo_rescued.x=display.contentCenterX
	logo_rescued.y=display.contentCenterY
	logo_rescued.alpha=0
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene