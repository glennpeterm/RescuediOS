-- scen3.lua
local toast = require("scripts.toast");

local composer = require('composer')
local scene = composer.newScene()
local widget = require('widget')
local msg = require("scripts.globals.constant")
local widget = require('widget')
local mydata=require("scripts.mydata")

-- Add timer values 
local timeSpentTimerCount = 0
local spendTimer

local onhome=0
local musicSprite
local clickCounter = 0
local instruments = {'piano', 'drum', 'horn', 'guitar', 'standUpBass', 'harp'}
local musicfiles = {'assets/audio/pianoLoop.mp3', 'assets/audio/drumLoop.mp3', 'assets/audio/hornLoop.mp3', 'assets/audio/guitarLoop.mp3', 'assets/audio/standupBassLoop.mp3', 'assets/audio/harpLoop.mp3'}
--local musicfiles = {'assets/audio/pianoLoop.wav', 'assets/audio/drumLoop.wav', 'assets/audio/hornLoop.wav', 'assets/audio/guitarLoop.wav', 'assets/audio/standupBassLoop.wav', 'assets/audio/harpLoop.wav'}
local prevIndex = 1
local index
local firstTimeVisible = false 
local pianoSound, drumSound, hornSound, guitarSound, standUpBassSound, harpSound
local soundReference
local pianoClicked, drumClicked, hornClicked, guitarClicked, standUpBassClicked, harpClicked
local pianoChannel , drumChannel, hornChannel, guitarChannel, standUpBassChannel, harpChannel

local pianoMusicSprite, drumMusicSprite, hornMusicSprite, guitarMusicSprite, standUpBassMusicSprite, harpMusicSprite 
local angel1, angel2, angel3, angel4, angel5, angel6
local down_phase=0
local isGameFinished = false




local function handleButtonEvent1( event )
	if (isGameFinished == true) then
		return 1
	end	
    if ( "ended" == event.phase ) then
        audio.stop( )
        composer.removeHidden()
        composer.removeScene("scripts.scene4", true )
        composer.gotoScene("scripts.home")
    end
end
function scene:on_back()
	if (isGameFinished == true) then
		return 1
	end	
	audio.stop( )
        composer.removeHidden()
        composer.removeScene("scripts.scene4", true )
        composer.gotoScene("scripts.home")
end

function scene:music_mute_function( )
	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0,{channel=0})	
	end
--mute1:setFrame(2)
end
function scene:narration_mute_function( )
	if (mydata.narration_status==1) then
	else
	end
end
local function onsettings(event)
	if (isGameFinished == true) then
		return 1
	end	
	if (event.phase=="ended") then
		local options = {
		    isModal = true,
		    effect = "fromRight",
		    time = 1000,
		    params = {
		        
		    }
		}
		composer.showOverlay( "scripts.settings_story",options)
	end
end
local function countTime(event)
	timeSpentTimerCount = timeSpentTimerCount + 1
	print ("Timer count=".. timeSpentTimerCount)
end
function scene:create(event)
	-- log events
	--analytics.logEvent( "Heaven symphony game started" ) 
	--analytics.logEvent( "NewGame" )

	-- local logParams = {}
	-- logParams['type'] = "Game"
	-- logParams['name'] = "Heaven's Symphony"

	-- analytics.logEvent("GAME-LAUNCHED", logParams)

	-- for i,v in pairs(logParams) do
	--  	print(i, v)
	-- end
	spendTimer = timer.performWithDelay(1000, countTime, 0)

	mydata.isgame=true
	mydata.ispoem=false
	mydata.isstory=false
	isGameFinished = false
	 sceneGroup = self.view
	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0,{channel=0})	
	end
	-- Load all soundfiles once
 	--soundReference =  {
	pianoSound = audio.loadSound(musicfiles[1]) 
	drumSound =  audio.loadSound(musicfiles[2]) 
	hornSound =  audio.loadSound(musicfiles[3]) 
	guitarSound = audio.loadSound(musicfiles[4])  
	standUpBassSound = audio.loadSound(musicfiles[5])  
	harpSound = audio.loadSound(musicfiles[6]) 
	--}



	print ("display CW".. display.contentWidth)
	print ("display CH".. display.contentHeight)
	print("CP".. display.contentCenterX)
	pianoClicked = false
	drumClicked  = false
	hornClicked = false
	guitarClicked = false
	standUpBassClicked = false
	harpClicked = false

	local bgWhite = display.newImageRect("assets/images/cloud_bg.jpg", display.contentHeight*2.49, display.contentHeight)
	bgWhite.x = display.contentCenterX
	bgWhite.y = display.contentCenterY

	sceneGroup:insert(bgWhite)
	
	-- Add new images 

	angel1 = display.newImage("assets/images/angel04.png")
	angel1.anchorX = 0
	angel1.anchorY = 1
	if (display.contentHeight==360 and display.contentWidth==480) then
		angel1.x = 0
	else
		angel1.x = 20
	end
	angel1.y = display.contentHeight-25
	angel1:scale(0.18, 0.18)
	angel1.name = "piano"


    angel2 = display.newImage("assets/images/angel01.png")
	angel2.anchorX = 0
	angel2.anchorY = 1
	angel2.x = 0 + angel1.contentWidth-20
	angel2.y = display.contentHeight-25
	angel2:scale(0.18, 0.18)
	angel2.name = "guitar"


	angel3 = display.newImage("assets/images/angel03.png")
	angel3.anchorX = 0
	angel3.anchorY = 1
	angel3.x = angel2.x + angel2.contentWidth-60
	angel3.y = display.contentHeight-25
	angel3:scale(0.18, 0.18)
	angel3.name = "standUpBass"

	angel4 = display.newImage("assets/images/angel06.png")
	angel4.anchorX = 0
	angel4.anchorY = 1
	angel4.x = angel3.x + angel3.contentWidth-30
	angel4.y = display.contentHeight-25
	angel4:scale(0.18, 0.18)
	angel4.name = "harp"

 	angel5 = display.newImage("assets/images/angel02.png")
	angel5.anchorX = 0
	angel5.anchorY = 1
	angel5.x = 25 
	angel5.y = display.contentHeight-angel1.contentHeight
	angel5:scale(0.18, 0.18)
	angel5.name = "drum"


	angel6 = display.newImage("assets/images/angel05.png")
	angel6.anchorX = 0
	angel6.anchorY = 1
	angel6.x = angel5.x + angel5.contentWidth+10
	angel6.y = display.contentHeight-angel1.contentHeight-20
	angel6:scale(0.16, 0.16)
	angel6.name = "horn"


	angel1.fill.effect = "filter.desaturate"
	angel1.fill.effect.intensity = 0.9

	angel2.fill.effect = "filter.desaturate"
	angel2.fill.effect.intensity = 0.9

	angel3.fill.effect = "filter.desaturate"
	angel3.fill.effect.intensity = 0.9

	angel4.fill.effect = "filter.desaturate"
	angel4.fill.effect.intensity = 0.9

	angel5.fill.effect = "filter.desaturate"
	angel5.fill.effect.intensity = 0.9

	angel6.fill.effect = "filter.desaturate"
	angel6.fill.effect.intensity = 0.9


	-- This method handles the each instrument play and stop. 
	local function clickOnInstrument(event)
		if (event.phase == "ended") then
			clickCounter = clickCounter + 1
			print('Click on the instrument='.. clickCounter)
		    
			if (event.target.name == 'piano') then
				index = 1 
			elseif (event.target.name == 'drum') then
				index = 2
			elseif (event.target.name == 'horn') then
				index = 3
			elseif (event.target.name == 'guitar') then
				index = 4
			elseif (event.target.name == 'standUpBass') then
				index = 5
			elseif (event.target.name == 'harp') then	
				index = 6
			end 
			local x1, y1 = event.x, event.y

			if (prevIndex == index) then
				print('Stop')
			end	
			prevIndex = index
			print("Instrument counter="..instruments[index])
			print (musicfiles[index])

			local fileToPlay = audio.loadSound(musicfiles[index])
			if (index == 1) then

				print("piano")
				if (pianoClicked == false) then
					pianoClicked = true
					--local availableChannel = audio.findFreeChannel()
					--audio.play( laserSound, { channel=availableChannel } )
					pianoChannel = audio.findFreeChannel()
					audio.play(pianoSound, {loops = -1, channel=pianoChannel})
					musicSprite:setFrame( 15 )

					musicSprite.x = event.target.x + event.target.contentWidth/3
					musicSprite.y = event.target.y - 220
					musicSprite.alpha = 1
					musicSprite:play()
					event.target.fill.effect =""

				else
					pianoClicked = false
					audio.stop(pianoChannel)
					pianoChannel = nil
					musicSprite.alpha = 0
					musicSprite:pause()	
					event.target.fill.effect = "filter.desaturate"
					event.target.fill.effect.intensity = 0.9
				end	
				
			elseif (index == 2) then
				if (drumClicked == false) then
					drumClicked = true
					drumChannel = audio.findFreeChannel()
					audio.play(drumSound, {loops = -1, channel=drumChannel})
					drumMusicSprite:setFrame( 15 )

					drumMusicSprite.x = event.target.x + event.target.contentWidth/2
					drumMusicSprite.y = event.target.y - 150

					drumMusicSprite:play()
					drumMusicSprite.alpha = 1
					event.target.fill.effect =""
				else
					drumClicked = false	
					audio.stop(drumChannel)
					drumChannel = nil
					drumMusicSprite:pause()
					drumMusicSprite.alpha = 0
					event.target.fill.effect = "filter.desaturate"
					event.target.fill.effect.intensity = 0.9
	
				end
				
			elseif (index == 3) then
				if (hornClicked == false) then
				 	hornClicked = true
				 	hornChannel = audio.findFreeChannel()
				 	audio.play(hornSound, {loops = -1, channel=hornChannel})
				 	hornMusicSprite:setFrame( 15 )
					
					hornMusicSprite.x = event.target.x + 10
					hornMusicSprite.y = event.target.y-150

				 	hornMusicSprite:play()
					hornMusicSprite.alpha = 1
					event.target.fill.effect =""
				else
					hornClicked = false
					audio.stop(hornChannel)	
					hornChannel = nil

					hornMusicSprite:pause()
					hornMusicSprite.alpha = 0
					event.target.fill.effect = "filter.desaturate"
					event.target.fill.effect.intensity = 0.9
				end 
				
			elseif (index == 4) then
				print("Guitar")
				if (guitarClicked == false) then
					guitarClicked = true
					guitarChannel = audio.findFreeChannel()
					audio.play(guitarSound, {loops = -1, channel=guitarChannel})
					guitarMusicSprite:setFrame( 15 )
					guitarMusicSprite.x = event.target.x + event.target.contentWidth/2
					guitarMusicSprite.y = event.target.y-200

					guitarMusicSprite:play()
					guitarMusicSprite.alpha = 1
					event.target.fill.effect =""
				else
					guitarClicked = false

					audio.stop(guitarChannel)
					guitarChannel = nil	
					guitarMusicSprite:pause()
					guitarMusicSprite.alpha = 0
					event.target.fill.effect = "filter.desaturate"
					event.target.fill.effect.intensity = 0.9
				end
				
			elseif (index == 5) then
				if (standUpBassClicked == false) then
					standUpBassClicked = true
					standUpBassChannel = audio.findFreeChannel()
					audio.play(standUpBassSound, {loops = -1, channel=standUpBassChannel})
					standUpBassMusicSprite:setFrame( 15 )
					standUpBassMusicSprite.x = event.target.x + event.target.contentWidth/2
					standUpBassMusicSprite.y = event.target.y -170

					standUpBassMusicSprite:play()
					standUpBassMusicSprite.alpha = 1
					event.target.fill.effect =""
				else	
					standUpBassClicked = false
					audio.stop(standUpBassChannel)	
					standUpBassChannel=nil
					standUpBassMusicSprite:pause()
					standUpBassMusicSprite.alpha = 0
					event.target.fill.effect = "filter.desaturate"
					event.target.fill.effect.intensity = 0.9
				end 
				
			elseif (index == 6) then
				if (harpClicked == false) then
					harpClicked = true
					harpChannel = audio.findFreeChannel()
					audio.play(harpSound, {loops = -1, channel=harpChannel})
					harpMusicSprite:setFrame( 15 )
					harpMusicSprite.x = event.target.x + event.target.contentWidth/3
					harpMusicSprite.y = event.target.y -170

					harpMusicSprite:play()
					harpMusicSprite.alpha = 1
					event.target.fill.effect =""
				else
					harpClicked = false	
					audio.stop(harpChannel)	
					harpChannel = nil
					harpMusicSprite:pause()
					harpMusicSprite.alpha = 0
					event.target.fill.effect = "filter.desaturate"
					event.target.fill.effect.intensity = 0.9
				end
				
			end	
		end
		return true
	end	
	local function onInstrumentTouch(event)
		if (event.phase == "ended") then
			print('Stopped animation')
			--audio.stop()
			--transition.to(musicSprite, {time = 100, alpha = 0})		
		end
	end	
    angel1:addEventListener('touch', clickOnInstrument) 
    angel2:addEventListener('touch', clickOnInstrument) 
    angel3:addEventListener('touch', clickOnInstrument) 
    angel4:addEventListener('touch', clickOnInstrument) 
    angel5:addEventListener('touch', clickOnInstrument) 
    angel6:addEventListener('touch', clickOnInstrument) 

	local seqData = {
		name = "playmusic",
		start = 25,
		count = 65,
		loopCount= 0,
		time = 4000,
		loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
	} 


	local music = require('scripts.musicnotes')
	local musicSheet = graphics.newImageSheet('assets/images/musicnotes.png', music:getSheet())


	musicSprite = display.newSprite(musicSheet, seqData)
	musicSprite.x = display.contentCenterX
	musicSprite.y = display.contentCenterY
	musicSprite:scale(0.5, 0.5)
	musicSprite.alpha = 0
	musicSprite:addEventListener('sprite', onInstrumentTouch)

	drumMusicSprite  = display.newSprite(musicSheet, seqData) 
	hornMusicSprite  = display.newSprite(musicSheet, seqData)
	guitarMusicSprite  = display.newSprite(musicSheet, seqData)
	standUpBassMusicSprite  = display.newSprite(musicSheet, seqData)
	harpMusicSprite  = display.newSprite(musicSheet, seqData)

	drumMusicSprite:scale(0.5, 0.5)
	drumMusicSprite.alpha = 0
	drumMusicSprite:setSequence("playmusic")
	drumMusicSprite:setFrame( 15 )

	hornMusicSprite:scale(0.5, 0.5)
	hornMusicSprite.alpha = 0
	hornMusicSprite:setSequence("playmusic")
	hornMusicSprite:setFrame( 15 )


	guitarMusicSprite:scale(0.5, 0.5)
	guitarMusicSprite.alpha = 0
	guitarMusicSprite:setSequence("playmusic")
	guitarMusicSprite:setFrame( 15 )


	standUpBassMusicSprite:scale(0.5, 0.5)
	standUpBassMusicSprite.alpha = 0
	standUpBassMusicSprite:setSequence("playmusic")
	standUpBassMusicSprite:setFrame( 15 )


	harpMusicSprite:scale(0.5, 0.5)
	harpMusicSprite.alpha = 0
	harpMusicSprite:setSequence("playmusic")
	harpMusicSprite:setFrame( 15 )
	-- This method will stop the game and show the overlay

	local function handleButtonEvent(event)

		if (event.phase == "ended") then
			print("button was pressed")
			msg.gameStatus = 1

			local options = {
			    isModal = true,
			    effect = "fade",
			    time = 400
			}
			musicSprite.alpha = 0
			drumMusicSprite.alpha = 0
			hornMusicSprite.alpha = 0
			guitarMusicSprite.alpha = 0
			standUpBassMusicSprite.alpha = 0
			harpMusicSprite.alpha = 0
			print('***************************************')
			audio.stop()
			print('Stop')
			mydata.currentmsg=1
			mydata.isgame=true
			isGameFinished = true

			if (spendTimer) then
				timer.cancel( spendTimer )
			end
			print("total seconds = ".. timeSpentTimerCount) 
			local logParams = {}
			logParams['type'] = "Game"
			logParams['name'] = "Heaven's Symphony"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Heaven's Symphony)", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end
			timeSpentTimerCount = 0

			composer.showOverlay( "scripts.overlay", options)
		end
	end	
	sceneGroup:insert(angel1)
	sceneGroup:insert(angel3)
	sceneGroup:insert(angel2)
	sceneGroup:insert(angel4)
	sceneGroup:insert(angel5)
	sceneGroup:insert(angel6)

	sceneGroup:insert(musicSprite)
	sceneGroup:insert(drumMusicSprite)
	sceneGroup:insert(hornMusicSprite)
	sceneGroup:insert(guitarMusicSprite)
	sceneGroup:insert(standUpBassMusicSprite)
	sceneGroup:insert(harpMusicSprite)
	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
   endButton = widget.newButton
	{
		width = display.contentHeight/10,
		height = display.contentHeight/11,
		defaultFile = "assets/images/button_1.png",
		overFile = "assets/images/button_2.png",
		-- label = "button",
		onEvent = handleButtonEvent
	}

	-- Center the button
	endButton.x = (display.contentWidth-endButton.contentWidth/2)-15
	endButton.y = display.contentHeight-(endButton.contentHeight/2)-15
	endButton.xScale=1.8
	endButton.yScale=1.8
	endButton:setEnabled( false )
	sceneGroup:insert( endButton )

	backButton = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("tick_mark"), 21,21)
	backButton.x=endButton.x
	backButton.y=endButton.y-5
	backButton.xScale=1
	backButton.yScale=1

	sceneGroup:insert(backButton)
 
	local button2 = widget.newButton
	{
		width = display.contentHeight/10,
		height = display.contentHeight/11,
		defaultFile = "assets/images/button_1.png",
		overFile = "assets/images/button_2.png",
		-- label = "button",
		onEvent = handleButtonEvent1
	}

	-- Center the button
	button2.x = (button2.contentWidth/2)+15
	button2.y = (button2.contentHeight/2)+15
	button2.xScale=1.8
	button2.yScale=1.8


	sceneGroup:insert( button2 )

	settings1 =  display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)

	settings1.x=button2.x
	settings1.y=button2.y-5
	settings1.xScale=1
	settings1.yScale=1

	sceneGroup:insert(settings1)
	button1 = widget.newButton
	{
		width = display.contentHeight/10,
		height = display.contentHeight/11,
		defaultFile = "assets/images/button_1.png",
		overFile = "assets/images/button_2.png",
		-- label = "button",
		onEvent = onsettings
	}

	-- Center the button
	button1.x = (display.contentWidth-button1.contentWidth/2)-15
	button1.y = (button1.contentHeight/2)+15
	button1.xScale=1.8
	button1.yScale=1.8
	sceneGroup:insert( button1 )

	settings2 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)

	settings2.x=button1.x
	settings2.y=button1.y-5
	settings2.xScale=1
	settings2.yScale=1

	sceneGroup:insert(settings2)

end
function scene:show(event)
	local sceneGroup = self.view	
	local phase = event.phase

    if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
  
    elseif ( phase == "did" ) then
    			

      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
		if (firstTimeVisible == false) then
			firstTimeVisible = true
			print("Inside overlay") 
			local options = {
			    isModal = true,
			    effect = "fade",
			    time=1,
			    params = {
			    	gameIndex = 5
				}
			}
			composer.showOverlay("scripts.gameInstructions", options)
		end	
    end
end	
function scene:enablebutton()
	print("called button")
		endButton:setEnabled( true )

end
-- This method will restart the game 
function scene:resume()
	print "Restart"
	pianoClicked = false
	drumClicked  = false
	hornClicked = false
	guitarClicked = false
	standUpBassClicked = false
	harpClicked = false


	isGameFinished = false

	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0,{channel=0})	
	end
	angel1.fill.effect = "filter.desaturate"
	angel1.fill.effect.intensity = 0.9

	angel2.fill.effect = "filter.desaturate"
	angel2.fill.effect.intensity = 0.9

	angel3.fill.effect = "filter.desaturate"
	angel3.fill.effect.intensity = 0.9

	angel4.fill.effect = "filter.desaturate"
	angel4.fill.effect.intensity = 0.9

	angel5.fill.effect = "filter.desaturate"
	angel5.fill.effect.intensity = 0.9

	angel6.fill.effect = "filter.desaturate"
	angel6.fill.effect.intensity = 0.9

	timeSpentTimerCount = 0
	if (spendTimer) then
		timer.cancel( spendTimer )
	end
	spendTimer = timer.performWithDelay(1000, countTime, 0)

end	
local function toast_listener()
		if (mydata.music_status==0 or mydata.narration_status==0) then
			toast.new("Sound is off",2000,sceneGroup)

		end
end
 function scene:show_toast()
 	timer.performWithDelay( 200,toast_listener )

end
function scene:next()
end
function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
    --  	 Runtime:removeEventListener( "key", onKeyEvent_game);
    		mydata.scene_show=false


   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
      -- Stop all audio 
		if (spendTimer) then
			timer.cancel( spendTimer )
		end

		--timer.cancel(spendTimer)
		--print("total seconds = ".. timeSpentTimerCount) 
		if (timeSpentTimerCount > 4) then
			local logParams = {}
			logParams['type'] = "Game"
			logParams['name'] = "Heaven's Symphony"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Heaven's Symphony)", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end
		end
		print ("Hide the Heavens")
		mydata.lastScene = "Heaven's Symphony"
   end
end	
function scene:destory(event)
	local sceneGroup = self.view
	-- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

	audio.dispose(pianoSound)
	audio.dispose(drumSound)
	audio.dispose(hornSound)
	audio.dispose(guitarSound)
	audio.dispose(standUpBassSound)
	audio.dispose(harpSound)

	pianoSound = nil
	drumSound = nil
	hornSound = nil
	guitarSound = nil
	standUpBassSound = nil
	harpSound = nil	  

end
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)	

return scene