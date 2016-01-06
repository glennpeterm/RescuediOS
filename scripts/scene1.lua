-----------------------------------------------------------------------------------------
--
-- main.lua 
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local msg = require("scripts.globals.constant")
local media = require("media")
local mydata=require("scripts.mydata")
local widget=require("widget")
local physics = require("physics")
-- Add timer values 
local timeSpentTimerCount = 0
local spendTimer
local onhome=0
local toast = require("scripts.toast");
local window
local newGr
local objCounter = 0
local matchCounter = 0
local statusMsg = ""
local text1, text2, text3, text4, text5, text6
local dinosaurBox, rabbitBox, tigerBox, goatBox, birdBox,elephantBox 
local background
local showStatusmsgBox 
local starAnimation, starSprite
local firstTimeVisible = false 
local down_phase=0
physics.start()
--
local isGameFinished = false
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
-- Called when the scene's view does not exist:
function scene:music_mute_function( )
	if (mydata.music_status==1) then
				
	else

	end
end
function scene:narration_mute_function( )
	
	if (mydata.narration_status==1) then
		media.setSoundVolume( 1.0 )
	else
		media.setSoundVolume(0)				
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
local function handleButtonEvent1( event )
	if (isGameFinished == true) then
		return 1
	end	
    if ( "ended" == event.phase ) then
    	media.stopSound()
        composer.removeHidden()
        composer.removeScene("scripts.scene1", true )
        composer.gotoScene("scripts.home")
    end
end
function scene:on_back()
	if (isGameFinished == true) then
		return 1
	end	
	media.stopSound()
        composer.removeHidden()
        composer.removeScene("scripts.scene1", true )
        composer.gotoScene("scripts.home")
end
local function countTime(event)
	timeSpentTimerCount = timeSpentTimerCount + 1
	print ("Timer count=".. timeSpentTimerCount)
end
function scene:create( event )
				--	Runtime:addEventListener( "key", onKeyEvent_game );
	-- local logParams = {}
	-- logParams['type'] = "Game"
	-- logParams['name'] = "Naming The Animals"

	-- analytics.logEvent("GAME-LAUNCHED", logParams)
	-- for i,v in pairs(logParams) do
	--  	print(i, v)
	-- end	
 --  	print (logParams)
  	spendTimer = timer.performWithDelay(1000, countTime, 0)
    group = self.view
	mydata.isgame=true
	mydata.ispoem=false
	mydata.isstory=false
	isGameFinished = false
	animbg = display.newImageRect("assets/images/animal_bg.png", display.contentHeight*1.83, display.contentHeight) 
	animbg.x = display.contentCenterX
	animbg.y = display.contentCenterY
    group:insert(animbg)
    background = display.newImageRect('assets/images/animals.png', display.contentHeight*2.16, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY+30
    background:scale(0.60, 0.60)
	-- Drag and drop objects 
	group:insert(background)
	cardbg1 = display.newImageRect("assets/images/name_card.png", display.contentWidth/12*2.17, display.contentWidth/12)
	cardbg2 = display.newImageRect("assets/images/name_card.png", display.contentWidth/12*2.17, display.contentWidth/12)
	cardbg3 = display.newImageRect("assets/images/name_card.png", display.contentWidth/12*2.17, display.contentWidth/12)
	cardbg4 = display.newImageRect("assets/images/name_card.png", display.contentWidth/12*2.17, display.contentWidth/12)
	cardbg5 = display.newImageRect("assets/images/name_card.png", display.contentWidth/12*2.17, display.contentWidth/12)
	cardbg6 = display.newImageRect("assets/images/name_card.png", display.contentWidth/12*2.17, display.contentWidth/12)
	cardbg1:scale(0.75, 0.75)
	cardbg2:scale(0.75, 0.75)
	cardbg3:scale(0.75, 0.75)
	cardbg4:scale(0.75, 0.75)
	cardbg5:scale(0.75, 0.75)
	cardbg6:scale(0.75, 0.75)
	group:insert(cardbg1)
	group:insert(cardbg2)
	group:insert(cardbg3)
	group:insert(cardbg4)
	group:insert(cardbg5)
	group:insert(cardbg6)
	text1 = display.newImageRect('assets/images/bird_main_card.png', display.contentWidth/12*1.64, display.contentWidth/12)
	text2 = display.newImageRect('assets/images/goat_main_card.png', display.contentWidth/12*1.53, display.contentWidth/12)
	text3 = display.newImageRect('assets/images/tiger_main_card.png', display.contentWidth/12*1.78, display.contentWidth/12)
	text4 = display.newImageRect('assets/images/elephant_main_card.png', display.contentWidth/12*2.48, display.contentWidth/12)
	text5 = display.newImageRect('assets/images/rabbit_main_card.png', display.contentWidth/12*2.47, display.contentWidth/12)
	text6 = display.newImageRect('assets/images/dinosaur_main_card.png', display.contentWidth/12*3, display.contentWidth/12)
	text1.text = "Bird"
	text2.text = "Goat"
	text3.text = "Tiger"
	text4.text = "Elephant"
	text5.text = "Rabbit"
	text6.text = "Dinosaur"
	text1:scale(0.60, 0.60)
	text2:scale(0.60, 0.60)
	text3:scale(0.60, 0.60)
	text4:scale(0.60, 0.60)
	text5:scale(0.60, 0.60)
	text6:scale(0.52, 0.52)
	group:insert(text1)
	group:insert(text2)
	group:insert(text3)
	group:insert(text4)
	group:insert(text5)
	group:insert(text6)
	newGr = display.newGroup()
	showStatusmsgBox =  display.newText("No match found", display.contentCenterX, display.contentCenterY, 'BLKCHCRY', 22)
	showStatusmsgBox:setFillColor(1, 0, 0)
	newGr:insert(showStatusmsgBox)
	newGr.alpha = 0
	showStatusmsgBox.isVisible = false
	local button2 = widget.newButton
	{
	    width = display.contentHeight/10,
	    height = display.contentHeight/11,
	    defaultFile = "assets/images/button_1.png",
	    overFile = "assets/images/button_2.png",
	    onEvent = handleButtonEvent1
	}
	-- Center the button
	button2.x = (button2.contentWidth/2)+15
	button2.y = (button2.contentHeight/2)+15
	button2.xScale=1.8
	button2.yScale=1.8
	group:insert( button2 )
	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
	settings1 =  display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)
	settings1.x=button2.x
	settings1.y=button2.y-5
	settings1.xScale=1
	settings1.yScale=1
	group:insert(settings1)
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
	group:insert( button1 )
	settings2 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)
	settings2.x=button1.x
	settings2.y=button1.y-5
	settings2.xScale=1
	settings2.yScale=1
	group:insert(settings2)
	--text5:setFillColor(0, 0, 0)
	cardbg1.x = display.contentWidth/2-cardbg1.contentWidth/1.9
    cardbg1.y = button1.y+cardbg1.contentHeight+10
	--text1:setFillColor(0, 0, 0)


	cardbg2.x = display.contentWidth/2+cardbg1.contentWidth/1.9
    cardbg2.y = button1.y+cardbg1.contentHeight+10
	--text2:setFillColor(0, 0, 0)

	cardbg3.x =cardbg1.x-cardbg1.contentWidth-(cardbg2.x-cardbg1.x-cardbg1.contentWidth)
    cardbg3.y = button1.y+cardbg1.contentHeight+10
	--text3:setFillColor(0, 0, 0)

    cardbg4.x =cardbg2.x+cardbg2.contentWidth+(cardbg2.x-cardbg1.x-cardbg1.contentWidth)
    cardbg4.y = button1.y+cardbg1.contentHeight+10
	--text4:setFillColor(0, 0, 0)

	cardbg5.x = cardbg3.x-cardbg3.contentWidth-(cardbg2.x-cardbg1.x-cardbg1.contentWidth)
    cardbg5.y = button1.y+cardbg1.contentHeight+10
  	
	cardbg6.x = cardbg4.x+cardbg4.contentWidth+(cardbg2.x-cardbg1.x-cardbg1.contentWidth)
    cardbg6.y = button1.y+cardbg1.contentHeight+10
	--text6:setFillColor(0, 0, 0)
	text1.x = cardbg1.x
	text1.y = cardbg1.y
	text2.x = cardbg2.x
	text2.y = cardbg2.y
	text3.x = cardbg4.x
	text3.y = cardbg4.y
	text4.x = cardbg5.x
	text4.y = cardbg5.y
	text5.x = cardbg3.x
	text5.y = cardbg3.y
	text6.x = cardbg6.x
	text6.y = cardbg6.y
	-- Animal Boxes to place the animal  

	dinosaurBox = display.newRect(display.contentCenterX, display.contentCenterY, 75, 50)
	dinosaurBox.anchorX = 0
	dinosaurBox.anchorY = 0
	dinosaurBox.name = 'dinosaurBox'
	if (display.contentHeight==360 and display.contentWidth==480) then
		dinosaurBox.x = display.contentCenterX-2.7*dinosaurBox.contentWidth
	else
		dinosaurBox.x = display.contentCenterX-2.5*dinosaurBox.contentWidth
	end
		dinosaurBox.y = display.contentCenterY+30
		dinosaurBox:setFillColor( 1, 1, 1)
		dinosaurBox.isContainerOpen = false 
		dinosaurBox.alpha = 0

	goatBox = display.newRect(display.contentCenterX, display.contentCenterY, 40, 40)
	goatBox.anchorX = 0
	goatBox.anchorY = 0
	goatBox.name = 'goatBox'
	if (display.contentHeight==360 and display.contentWidth==480) then
			goatBox.x = display.contentCenterX-goatBox.contentWidth-20
	else
	goatBox.x = display.contentCenterX-goatBox.contentWidth-15
	end
	goatBox.y = display.contentCenterY+goatBox.contentWidth-05
	goatBox:setFillColor(1, 1, 1)
	goatBox.isContainerOpen = false 
	goatBox.alpha = 0

	rabbitBox = display.newRect(display.contentCenterX, display.contentCenterY, 40, 40)
	rabbitBox.anchorX = 0
	rabbitBox.anchorY = 0
	rabbitBox.name = 'rabbitBox'
	if (display.contentHeight==360 and display.contentWidth==480) then
	rabbitBox.x = display.contentCenterX
	else
	rabbitBox.x = display.contentCenterX
	end
	rabbitBox.y = display.contentCenterY+rabbitBox.contentWidth-10
	rabbitBox:setFillColor(1, 1, 1)
	rabbitBox.isContainerOpen = false 
	rabbitBox.alpha = 0

	tigerBox = display.newRect(display.contentCenterX, display.contentCenterY, 50, 40)
	tigerBox.anchorX = 0
	tigerBox.anchorY = 0
	tigerBox.name = 'tigerBox'
	if (display.contentHeight==360 and display.contentWidth==480) then
	tigerBox.x = display.contentCenterX+60
	else
	tigerBox.x = display.contentCenterX+50
	end
	tigerBox.y = display.contentCenterY+ tigerBox.contentWidth
	tigerBox:setFillColor(1, 1, 1)
	tigerBox.isContainerOpen = false 
	tigerBox.alpha = 0

	elephantBox = display.newRect(display.contentCenterX, display.contentCenterY, 60, 50)
	elephantBox.anchorX = 0
	elephantBox.anchorY = 0
	elephantBox.name = 'elephantBox'
	if (display.contentHeight==360 and display.contentWidth==480) then
	elephantBox.x = display.contentCenterX+elephantBox.contentWidth*2.42
	else
	elephantBox.x = display.contentCenterX+elephantBox.contentWidth*2.1
	end
	elephantBox.y = display.contentCenterY+elephantBox.contentWidth*.8
	elephantBox:setFillColor(1, 1, 1)
	elephantBox.isContainerOpen = false 
	elephantBox.alpha = 0

	birdBox = display.newRect(display.contentCenterX, display.contentCenterY, 40, 40)
	birdBox.anchorX = 0
	birdBox.anchorY = 0
	birdBox.name = 'birdBox'
	if (display.contentHeight==360 and display.contentWidth==480) then
	birdBox.x = display.contentCenterX+birdBox.contentWidth*4
	else
	birdBox.x = display.contentCenterX+birdBox.contentWidth*3.5
	end
	birdBox.y = display.contentCenterY/4+ birdBox.contentWidth+35
	birdBox:setFillColor(1, 1, 1)
	birdBox.isContainerOpen = false 
	birdBox.alpha = 0

	local function animationEvent(event)
		if (event.phase == "ended") then
			print('Animation ended')
			starSprite.alpha = 0
		end	
	end	
	local seqData = {
		name = "playmusic",
		start = 1,
		count = 20,
		loopCount = 1,
		time = 1100,
		loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
	} 

	local stars = require('scripts.stars_nameAnim')
	local starSheet = graphics.newImageSheet('assets/images/stars_nta.png', stars:getSheet())
	starSprite = display.newSprite(starSheet, seqData)
	starSprite.x = display.contentCenterX
	starSprite.y = display.contentCenterY
	starSprite.alpha = 0
	starSprite:scale(0.5, 0.5)
	starSprite:addEventListener('sprite', animationEvent)


	-- Insert The Boxes into SceneGroup

	group:insert(birdBox)
	group:insert(elephantBox)
	group:insert(tigerBox)
	group:insert(dinosaurBox)
	group:insert(rabbitBox)
	group:insert(goatBox)
	group:insert(starSprite)



	


	
	function drag(event)
		local object = event.target


		if event.phase == "began" then
			if (object.isInTransition == true) then
				return 1
			end	
			print ('initial stage')
	        self.markX1 = object.x    -- store x location of object
	        self.markY1 = object.y    -- store y location of object
			display.getCurrentStage():setFocus(event.target)
			self.isFocus = true

			if (object.text == "Bird") then
				media.playSound("assets/audio/bird_voice_male.mp3")
			elseif (object.text == "Goat") then
				media.playSound("assets/audio/goat_voice_male.mp3")
			elseif (object.text == "Tiger") then
				media.playSound("assets/audio/tiger_voice_male.mp3")
			elseif (object.text == "Elephant") then
				media.playSound("assets/audio/elephant_voice_male.mp3")
			elseif (object.text == "Rabbit") then
				media.playSound("assets/audio/rabbit_voice_male.mp3")
			elseif (object.text == "Dinosaur") then
				media.playSound("assets/audio/dinosaur_voice_male.mp3")	
			end
			if (mydata.narration_status==1) then
				media.setSoundVolume( 1.0 )
			else
				media.setSoundVolume(0)				
			end
		elseif self.isFocus then
			if event.phase == "moved" then
		
		        print ("Moving")
		        --checkBoundary(event, contBox, object)
		        local x = (event.x - event.xStart) + self.markX1
			    local y = (event.y - event.yStart) + self.markY1
			        
			    --object.x, object.y = event.x, event.y    -- move object based on calculations above
			    object.x, object.y = x, y 
	        
	    	elseif event.phase == "ended" then
		    	print ("End stage")
		    	
		    	print (event.target)
		    	--checkObjContainerEmpty(dinosaurBox)
		    	object.placeMentOutside = true
		    	checkObjContainerEmpty(event, dinosaurBox, object)
		        checkObjContainerEmpty(event, birdBox, object)
		        checkObjContainerEmpty(event, elephantBox, object)
		        checkObjContainerEmpty(event, tigerBox, object)
		        checkObjContainerEmpty(event, rabbitBox, object)
		        checkObjContainerEmpty(event, goatBox, object)
		        print(event.target.placeMentOutside)
		        if object.placeMentOutside == true then
		        	-- Move to initial position
		 		    object.isInTransition = true
		 			transition.to( object, { time=500, alpha=1, x=(self.markX1), y=(self.markY1), onComplete=transitionCompEvt } )
		        end	
		        display.getCurrentStage():setFocus( nil )
				self.isFocus = false 
	    	end
		end	
	    
	    return true
	end
	text1:addEventListener('touch', drag)
	text2:addEventListener('touch', drag)
	text3:addEventListener('touch', drag)
	text4:addEventListener('touch', drag)
	text5:addEventListener('touch', drag)
	text6:addEventListener('touch', drag)
end
function transitionCompEvt(obj)
	--print("Transition complete")
	print (tostring(event))
	obj.isInTransition = false	
end	
-- Called immediately after scene has moved onscreen:
function scene:show( event )
    local group = self.view

	if (firstTimeVisible == false) then
		firstTimeVisible = true
		print("Inside overlay") 
		local options = {
			    isModal = true,
			    effect = "fade",
			    time=1,
			    params = {
			    	gameIndex = 1
				}
			}
		composer.showOverlay("scripts.gameInstructions", options)

	end	
    if (phase == "will") then
		-- Add timers, audio

	elseif (phase == "did") then
		-- Add objects
				

	end	
end
function positionMove(object, isMove )
	-- Reset to original position after 2 seconds 
		object.isInTransition = false
		print ("inside the data")
		--transition.to( newGr, { time=500, alpha=0} )
	if (isMove == false) then
		if matchCounter == 6 then -- compeleted game
			--print ("Match Counter =" ..  matchCounter)
			media.stopSound()

			statusMsg  = msg.success
			msg.gameStatus = 1
			mydata.currentmsg=1
			mydata.isgame=true
			local options = {
			    isModal = true,
			    effect = "fade",
			    time = 200,
			    params = {
			        status = statusMsg 
			    }
			}
			--spendTimer timeSpentTimerCount
			timer.cancel(spendTimer)
			print("total seconds = ".. timeSpentTimerCount) 
			local logParams = {}
			logParams['type'] = "Game"
			logParams['name'] = "Naming The Animals"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Naming The Animals)", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end	
			timeSpentTimerCount = 0
			composer.showOverlay( "scripts.overlay", options)
		end  
		
		return  
	end	
	if object.text == 'Dinosaur' then
		
	text6.x = cardbg6.x
	text6.y = cardbg6.y
		text6.xScale = 0.52
		text6.yScale = 0.52
	end	
	if object.text == 'Goat' then

	text2.x = cardbg2.x
	text2.y = cardbg2.y
	
		text2.xScale = 0.6
		text2.yScale = 0.6
	end
	if object.text == 'Rabbit' then
		
	text5.x = cardbg3.x
	text5.y = cardbg3.y
		text5.xScale = 0.6
		text5.yScale = 0.6
	end
	if object.text == 'Tiger' then
		
		text3.x = cardbg4.x
	text3.y = cardbg4.y
		text3.xScale = 0.6
		text3.yScale = 0.6
	end
	if object.text == 'Bird' then
		text1.x=cardbg1.x
		text1.y = cardbg1.y
		text1.xScale = 0.6
		text1.yScale = 0.6
	end
	if object.text == 'Elephant' then
	text4.x = cardbg5.x
	text4.y = cardbg5.y
	
		text4.xScale = 0.6
		text4.yScale = 0.6
	end	
	
end
 

function checkObjContainerEmpty(event, contBox, object)
	

	if event.x < contBox.contentBounds.xMin or
	    event.x > contBox.contentBounds.xMax or
	    event.y < contBox.contentBounds.yMin or
	    event.y > contBox.contentBounds.yMax then
	    print("Its out of box ")
	else
	    print ("Inside box")   
	    object.placeMentOutside = false
	    --local x = (event.x - event.xStart) + self.markX1
	    --local y = (event.y - event.yStart) + self.markY1
	    if contBox.isContainerOpen == false then    
			objCounter = objCounter+1

			-- action performed based on the container Box  

			if contBox.name == 'dinosaurBox' then
				object.xScale = 0.40
				object.yScale = 0.40
			
				if object.text == 'Dinosaur' then
					print ('match din found')
					contBox.isContainerOpen = true
					showStatusmsgBox.text = "Match found"
			    	 -- Remove event listener
	        		object:removeEventListener('touch', drag)
	 				matchCounter = matchCounter + 1
	 				-- Additional checking added
	 				if matchCounter == 6 then
	 					isGameFinished = true
	 				end 

	 				media.playSound("assets/audio/dinosaur_roar.mp3")
	 				if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
	 				timer.performWithDelay(800 , function() positionMove(object, false)  end , 1)
	 				starSprite.alpha = 1
	 				starSprite.xScale = 0.5
	 				starSprite.yScale = 0.5
	 				starSprite.x = contBox.x + contBox.contentWidth/2
	 				starSprite.y = contBox.y + contBox.contentHeight/3
	 				starSprite:play()
				else
					object.isInTransition = true
					timer.performWithDelay( 1000 , function() positionMove(object, true)  end , 1)
					showStatusmsgBox.text = "No match found"
					media.playSound("assets/audio/try_again_2.mp3")
					if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
				end	
				object.anchorY = 0.5
	        	object.anchorX = 0.5
	        	if (display.contentHeight==360 and display.contentWidth==480) then
					object.xScale = 0.4
					object.yScale = 0.4
					object.x=contBox.x + contBox.contentWidth / 2.1
					object.y=contBox.y + contBox.contentHeight / 2.5
				else
					object.xScale = 0.35
					object.yScale = 0.35
					object.x=((contBox.x + contBox.contentWidth / 2))+2 
					object.y=((contBox.y + contBox.contentHeight / 4))+5
				end
			end 
			-- Goat Box drop functionalities
			if contBox.name == 'goatBox' then
				object.xScale = 0.35
				object.yScale = 0.35
				if object.text == 'Goat' then
					print ('match goat found')
					contBox.isContainerOpen = true
					showStatusmsgBox.text = "Match found"
			    	 -- Remove event listener
	        		object:removeEventListener('touch', drag)
	        		-- central align the Text inside Box	
	 				matchCounter = matchCounter + 1
	 				-- Additional checking added
	 				if matchCounter == 6 then
	 					isGameFinished = true
	 				end 
	 				media.playSound("assets/audio/sheep_bleat.mp3")
	 				if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
	 				timer.performWithDelay( 800 , function() positionMove(object, false)  end , 1)

	 				starSprite.xScale = 0.35
	 				starSprite.yScale = 0.35
	 				starSprite.alpha = 1
	 				starSprite.x = contBox.x + contBox.contentWidth/2
	 				starSprite.y = contBox.y + contBox.contentHeight/4
	 				starSprite:play()
				else
					object.isInTransition = true
					timer.performWithDelay( 1000 , function() positionMove(object, true)  end , 1)
					showStatusmsgBox.text = "No match found"
					media.playSound("assets/audio/try_again_2.mp3")
					if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
		
				end	
				object.anchorY = 0.5
	        	object.anchorX = 0.5
	        	if (display.contentHeight==360 and display.contentWidth==480) then
					object.xScale = 0.29
					object.yScale = 0.29
					object.x=((contBox.x + contBox.contentWidth / 2)) 
					object.y=((contBox.y + contBox.contentHeight / 3.2))
				else
					object.xScale = 0.2
					object.yScale = 0.2
					object.x=((contBox.x + contBox.contentWidth / 2.2)) 
					object.y=((contBox.y + contBox.contentHeight / 4))
				end
				
				
			end
			-- Rabbit Box drop functionalities
			if contBox.name == 'rabbitBox'  then
				object.xScale = 0.22
				object.yScale = 0.22
				if object.text == 'Rabbit' then
					print ('match rabbit found')
					contBox.isContainerOpen = true
					showStatusmsgBox.text = "Match found"
			    	 -- Remove event listener
	        		object:removeEventListener('touch', drag)
	 				matchCounter = matchCounter + 1
	 				-- Additional checking added
	 				if matchCounter == 6 then
	 					isGameFinished = true
	 				end 
	 				media.playSound("assets/audio/rabbit_sound.mp3")
	 				if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
	 				timer.performWithDelay( 800 , function() positionMove(object, false)  end , 1)
	 				starSprite.xScale = 0.35
	 				starSprite.yScale = 0.35
	 				starSprite.alpha = 1
	 				starSprite.x = contBox.x + contBox.contentWidth/2
	 				starSprite.y = contBox.y + contBox.contentHeight/2
	 				starSprite:play()
				else
					object.isInTransition = true
					timer.performWithDelay( 1000 , function() positionMove(object, true) end , 1)
					showStatusmsgBox.text = "No match found"
					media.playSound("assets/audio/try_again_2.mp3")
					if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
				end	
				object.anchorY = 0.5
	        	object.anchorX = 0.5
	        	if (display.contentHeight==360 and display.contentWidth==480) then
					object.xScale = 0.22
					object.yScale = 0.22
					object.x=((contBox.x + contBox.contentWidth / 2)) 
					object.y=contBox.y + contBox.contentHeight / 2.3
				else
					object.xScale = 0.16
					object.yScale = 0.16
					object.x=((contBox.x + contBox.contentWidth / 2.1)) 
					object.y=contBox.y + contBox.contentHeight /2.7
				end
				
			end
			-- Tiger Box drop functionalities
			if contBox.name == 'tigerBox'  then
				object.xScale = 0.35
				object.yScale = 0.35
				if object.text == 'Tiger' then
					print ('match tiger found')
					contBox.isContainerOpen = true
					showStatusmsgBox.text = "Match found"
			    	 -- Remove event listener
	        		object:removeEventListener('touch', drag)
	 				matchCounter = matchCounter + 1
	 				-- Additional checking added
	 				if matchCounter == 6 then
	 					isGameFinished = true
	 				end 
	 				media.playSound("assets/audio/tiger_growl.mp3")
	 				if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
	 				timer.performWithDelay( 800 , function() positionMove(object, false)  end , 1)

	 				starSprite.xScale = 0.5
	 				starSprite.yScale = 0.5
	 				starSprite.alpha = 1
	 				starSprite.x = contBox.x + contBox.contentWidth/2
	 				starSprite.y = contBox.y + contBox.contentHeight/2
	 				starSprite:play()
				else
					object.isInTransition = true
					timer.performWithDelay( 1000 , function() positionMove(object, true)  end , 1)
					showStatusmsgBox.text = "No match found"
					media.playSound("assets/audio/try_again_2.mp3")
					if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
				end	
				object.anchorY = 0.5
	        	object.anchorX = 0.5
	        	if (display.contentHeight==360 and display.contentWidth==480) then
					object.xScale = 0.35
					object.yScale = 0.35
					object.x=((contBox.x + contBox.contentWidth / 2)) 
					object.y=contBox.y + contBox.contentHeight / 1.8
				else
					object.xScale = 0.3
					object.yScale = 0.3
					object.x=((contBox.x + contBox.contentWidth / 2)) 
					object.y=contBox.y + contBox.contentHeight / 2.1
				end
				
			end
			-- Bird Box drop functionalities
			if contBox.name == 'birdBox'  then
				object.xScale = 0.28
				object.yScale = 0.28
				if object.text == 'Bird' then
					print ('match bird found')
					contBox.isContainerOpen = true
			    	 -- Remove event listener
	        		object:removeEventListener('touch', drag)
	        		showStatusmsgBox.text = "Match found"
	 				matchCounter = matchCounter + 1
	 				-- Additional checking added
	 				if matchCounter == 6 then
	 					isGameFinished = true
	 				end 
	 				media.playSound("assets/audio/parrot_sound.mp3")
	 				if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
	 				timer.performWithDelay( 800 , function() positionMove(object, false)  end , 1)
	 				starSprite.xScale = 0.25
	 				starSprite.yScale = 0.25
	 				starSprite.alpha = 1
	 				starSprite.x = contBox.x + contBox.contentWidth/2
	 				starSprite.y = contBox.y + contBox.contentHeight/8
	 				starSprite:play()
				else
					object.isInTransition = true
					timer.performWithDelay( 1000 , function() positionMove(object, true)  end , 1)
					showStatusmsgBox.text = "No match found"
					media.playSound("assets/audio/try_again_2.mp3")
					if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
				end	
				object.anchorY = 0.5
	        	object.anchorX = 0.5
	        	if (display.contentHeight==360 and display.contentWidth==480) then
					object.xScale = 0.25
					object.yScale = 0.25
					object.x=((contBox.x + contBox.contentWidth / 2)) 
				object.y=contBox.y + contBox.contentHeight / 2.6
				else
					object.xScale = 0.2
					object.yScale = 0.2
					object.x=((contBox.x + contBox.contentWidth / 2)) 
				object.y=contBox.y + contBox.contentHeight / 5
				end
				
			end
			-- Elephant Box drop functionalities
			if contBox.name == 'elephantBox'  then
			if (display.contentHeight==360 and display.contentWidth==480) then
				object.xScale = 0.40
				object.yScale = 0.40
			else
				object.xScale = 0.3
				object.yScale = 0.3
			end
				if object.text == 'Elephant' then
					print ('match ele found')
					contBox.isContainerOpen = true
					showStatusmsgBox.text = "Match found"
			    	 -- Remove event listener
	        		object:removeEventListener('touch', drag)
	 				matchCounter = matchCounter + 1
	 				-- Additional checking added
	 				if matchCounter == 6 then
	 					isGameFinished = true
	 				end 
	 				media.playSound("assets/audio/elephant_attack.mp3")
	 				if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
	 				timer.performWithDelay( 800 , function() positionMove(object, false)  end , 1)

	 				starSprite.xScale = 0.5
	 				starSprite.yScale = 0.5
	 				starSprite.alpha = 1
	 				starSprite.x = contBox.x + contBox.contentWidth/2
	 				starSprite.y = contBox.y + contBox.contentHeight/4
	 				starSprite:play()
				else
					object.isInTransition = true
					timer.performWithDelay( 1000 , function() positionMove(object, true)  end , 1)
					showStatusmsgBox.text = "No match found"
					media.playSound("assets/audio/try_again_2.mp3")
					if (mydata.narration_status==1) then
						media.setSoundVolume( 1.0 )
					else
						media.setSoundVolume( 0.0 )
					end
				end	
				object.anchorY = 0.5
	        	object.anchorX = 0.5
	        	if (display.contentHeight==360 and display.contentWidth==480) then
	        						object.x=contBox.x+contBox.contentWidth/1.7
	        										object.y=contBox.y+contBox.contentWidth/2.3


	        	else
	        		object.xScale = 0.3
				object.yScale = 0.3
				object.x=contBox.x+contBox.contentWidth/1.8
								object.y=contBox.y+contBox.contentWidth/2.7

				end
			end
			print (matchCounter)
	    else
			positionMove(object)	
		end
	end
end
-- Restart the game
-- Initialise the variables and settings to start the game from begin   
function scene:resume()
    --code to resume game
	objCounter = 0
	matchCounter = 0
	matchCounter = 0
	dinosaurBox.isContainerOpen = false
	goatBox.isContainerOpen = false
	tigerBox.isContainerOpen = false
	elephantBox.isContainerOpen = false
	rabbitBox.isContainerOpen = false
	birdBox.isContainerOpen = false 

	isGameFinished = false
	-- Text Events 
	text1:addEventListener('touch', drag)
	text2:addEventListener('touch', drag)
	text3:addEventListener('touch', drag)
	text4:addEventListener('touch', drag)
	text5:addEventListener('touch', drag)
	text6:addEventListener('touch', drag)

	-- Text Boxes
	text6.xScale = 0.52
	text6.yScale = 0.52
	text2.xScale = 0.6
	text2.yScale = 0.6
	text5.xScale = 0.6
	text5.yScale = 0.6
	text3.xScale = 0.6
	text3.yScale = 0.6
	text1.xScale = 0.6
	text1.yScale = 0.6
	text4.xScale = 0.6
	text4.yScale = 0.6
	text1.x = cardbg1.x
	text1.y = cardbg1.y
	text2.x = cardbg2.x
	text2.y = cardbg2.y
	text3.x = cardbg4.x
	text3.y = cardbg4.y
	text4.x = cardbg5.x
	text4.y = cardbg5.y
	text5.x = cardbg3.x
	text5.y = cardbg3.y
	text6.x = cardbg6.x
	text6.y = cardbg6.y

	timeSpentTimerCount = 0
	if (spendTimer) then
		timer.cancel( spendTimer )
	end
	spendTimer = timer.performWithDelay(1000, countTime, 0)
end
-- "scene:hide()"
local function toast_listener()
		if (mydata.music_status==0 or mydata.narration_status==0) then
			toast.new("Sound is off",2000,group)

		end
end
 function scene:show_toast()
 	timer.performWithDelay( 200,toast_listener )

end
function scene:next()
end
function scene:hide( event )

   local group = self.view
   local phase = event.phase
   -- objCounter = 0
   --matchCounter = 0
   if ( phase == "will" ) then
   			mydata.scene_show=false

   	      --  Runtime:removeEventListener( "key", onKeyEvent_game);

      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
      media.stopSound()

   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
      	if (spendTimer) then
			timer.cancel( spendTimer )
		end
		--timer.cancel(spendTimer)
		--print("total seconds = ".. timeSpentTimerCount) 
		if (timeSpentTimerCount > 4) then
			local logParams = {}
			logParams['type'] = "Game"
			logParams['name'] = "Naming The Animals"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Naming The Animals)", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end	
		end
		mydata.lastScene = "Naming The Animals"
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local group = self.view

   -- Called prior to the removal of scene's view ("group").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.

   media.stopSound()

end
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )




---------------------------------------------------------------------------------

return scene

