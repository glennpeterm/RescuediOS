-- scene2.lua
local composer = require('composer')
local widget = require('widget')
local scene = composer.newScene()
local msg = require("scripts.globals.constant")
local media = require('media')
local mydata=require("scripts.mydata")
local toast = require("scripts.toast");

-- Add timer values 
local timeSpentTimerCount = 0
local spendTimer


local princess, visiblebg, maskImage, screenShot
local previousX, previousY
local threshold = 10
local thresholdSq = 100
local brush, spongeChip
local paintbrush, paintbrushbg
local brushSelect = false
local circleCounter = 0
local drawpointX, drawpointY, successfullImg, successText
-- Message counter
local levelMessage 
local nextLabel
local princessSelectiontCont

local princessImages = {'assets/images/p1.png', 'assets/images/p2.png', 'assets/images/p3.png','assets/images/p4.png','assets/images/p5.png',}
local princessMasks = {'assets/images/p1dmask.png', 'assets/images/p2dmask.png', 'assets/images/p3dmask.png', 'assets/images/p4dmask.png', 'assets/images/p5dmask.png'}
local princessBlackWhite = {'assets/images/p1d.png', 'assets/images/p2d.png', 'assets/images/p3d.png', 'assets/images/p4d.png', 'assets/images/p5d.png'}
local onhome=0
local princessCounter = 1
local drawCompleted = false
local drawMaxPixelCounter = 120
local allPrincessTogether
local firstInactive, secondInactive, thirdInactive, fourthInactive, fifthInactive 
local firstActive, secondActive, thirdActive, fourthActive, fifthActive
local insideImageArea = false
local lg
local pointCheckX, pointCheckY
local percentagevalue
local brushText
local starSprite
local starBlink, openCloseFlag
local roundedCircle, boundaryObject

local isBrushOutOfControl = false
local confirmCounter = 25
local firstTimeVisible = false 
local board
local down_phase=0

local function onsettings(event)
	if (drawCompleted == true) then
       	return 1
    end	
	if (event.phase=="ended") then
		local options = {
		    isModal = true,
		    effect = "fromRight",
		    time = 1000,
		    params = {}
		        
		   
		}
		composer.showOverlay( "scripts.settings_story",options)
	end
end

function scene:music_mute_function( )
if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0,{channel=0})	
    end
end
function scene:narration_mute_function( )
	if (mydata.narration_status==1) then
	else
	end
end
local function handleButtonEvent1( event )

    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
        if (drawCompleted == true) then
        	return 1
        end	
     	media.stopSound( )
        composer.removeHidden()
        composer.removeScene("scripts.scene2", true )
        composer.gotoScene("scripts.home")
    end
end
function scene:on_back()
	if (drawCompleted == true) then
        	return 1
        end	
     	media.stopSound( )
        composer.removeHidden()
        composer.removeScene("scripts.scene2", true )
        composer.gotoScene("scripts.home")
end
local function onKeyEvent_game( event )
    -- Print which key was pressed down/up to the log.
    
  if (event.keyName=="back") then
     if ( event.keyName == "back" and event.phase=="down") then
     	down_phase=1
       	return true
       end
   if ( event.keyName == "back" and event.phase=="up" and down_phase==1) then
        --Here the key was pressed      
    down_phase=0
    
  
             	    	 
     media.stopSound( )
		composer.removeHidden()
		composer.removeScene("scripts.scene2", true )
		composer.gotoScene("scripts.home")

	     --  

            return true
        end
   

            return true  
        end
        return true

end
local function countTime(event)
	timeSpentTimerCount = timeSpentTimerCount + 1
	print ("Timer count=".. timeSpentTimerCount)
end
function scene:create(event)
					--Runtime:addEventListener( "key", onKeyEvent_game );

	-- local logParams = {}
	-- logParams['type'] = "Game"
	-- logParams['name'] = "Princess Coloring Book"

	-- analytics.logEvent("GAME-LAUNCHED", logParams)
	-- for i,v in pairs(logParams) do
	--  	print(i, v)
	-- end
	spendTimer = timer.performWithDelay(1000, countTime, 0)

	mydata.isgame=true
	mydata.ispoem=false
	mydata.isstory=false

 sceneGroup = self.view


	drawCompleted = false
	
	physics = require('physics')
	physics.start()

	local background = display.newImageRect("assets/images/bg2.jpg", display.contentHeight*1.977, display.contentHeight) 

	board = display.newImageRect("assets/images/place-holder1.png", display.contentHeight*0.82, display.contentHeight)
	board.x = display.contentCenterX-20
	board.y = display.contentCenterY

	background.x =  display.contentCenterX
	background.y =  display.contentCenterY

	

	successfullImg = display.newImageRect("assets/images/sucessfull.png", display.contentHeight/2.5 * 0.869, display.contentHeight/2.5)	
	successfullImg.x = display.contentCenterX +  display.contentCenterX/2 * 1.4 - successfullImg.contentWidth /2 
	successfullImg.y = display.contentCenterY - successfullImg.contentHeight/2
	successfullImg.anchorX = 0
	successfullImg.anchorY = 0
	successfullImg.isVisible = false

	sceneGroup.visibleItem = "One"


	princessSelectiontCont = display.newImageRect("assets/images/nav_holder.png", display.contentHeight/15 * 4.46, display.contentHeight/15) 
	princessSelectiontCont.x = display.contentCenterX -20
	princessSelectiontCont.y = display.contentCenterY+display.contentCenterY/2*1.50


	firstActive = display.newImageRect("assets/images/nav_dots_avtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	firstActive.x = princessSelectiontCont.x - 35
	firstActive.y = princessSelectiontCont.y
	

	secondActive = display.newImageRect("assets/images/nav_dots_avtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	secondActive.x = firstActive.x + 17
	secondActive.y = firstActive.y
	

	thirdActive= display.newImageRect("assets/images/nav_dots_avtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	thirdActive.x = secondActive.x + 17
	thirdActive.y = secondActive.y
	

	fourthActive = display.newImageRect("assets/images/nav_dots_avtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	fourthActive.x = thirdActive.x + 17
	fourthActive.y = thirdActive.y
	

	fifthActive = display.newImageRect("assets/images/nav_dots_avtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	fifthActive.x = fourthActive.x + 17
	fifthActive.y = fourthActive.y
	
-- Inactive dots

	firstInactive = display.newImageRect("assets/images/nav_dots_inavtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	firstInactive.x = princessSelectiontCont.x - 35
	firstInactive.y = princessSelectiontCont.y
	
	

	secondInactive = display.newImageRect("assets/images/nav_dots_inavtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	secondInactive.x = firstActive.x + 17
	secondInactive.y = firstActive.y
	

	thirdInactive = display.newImageRect("assets/images/nav_dots_inavtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	thirdInactive.x = secondActive.x + 17
	thirdInactive.y = secondActive.y
	

	fourthInactive = display.newImageRect("assets/images/nav_dots_inavtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	fourthInactive.x = thirdActive.x + 17
	fourthInactive.y = thirdActive.y
	


	fifthInactive = display.newImageRect("assets/images/nav_dots_inavtive.png", display.contentHeight/25* 1.05, display.contentHeight/25) 
	fifthInactive.x = fourthActive.x + 17
	fifthInactive.y = fourthActive.y
	
	
	firstInactive.isVisible = false
	secondInactive.isVisible = true
	thirdInactive.isVisible = true
	fourthInactive.isVisible = true
	fifthInactive.isVisible = true

	firstActive.isVisible = true
	secondActive.isVisible = false
	thirdActive.isVisible = false
	fourthActive.isVisible = false
	fifthActive.isVisible = false


 function onSystemEvent( event )
	    --if(event.type=="applicationSuspend" and (system.getInfo("platformName") == "Android")) then
	       -- display.save(snapshot,"temp.png", system.TemporaryDirectory)
	       
	    --else
	    if(event.type=="applicationResume" and (system.getInfo("platformName") == "Android")) then
	        --print("resume code here - THIS IS WHERE THE BLANK SCREEN HAPPENS, or maybe even on suspend")
	        --media.stopSound( )
        	--composer.removeHidden()
        	--composer.removeScene("scene2", true )
        	--composer.gotoScene("home")

        	circleCounter = 0
			percentagevalue = 0
			starSprite.alpha = 0

			princess:removeSelf()
			princess = nil
			visiblebg:removeSelf()
			visiblebg = nil
			assignImages()
			
			screenShot:removeSelf()
			screenShot = nil
			--screenShot = display.newSnapshot(visiblebg.contentWidth, visiblebg.contentHeight)
			screenShot = display.newSnapshot(display.contentWidth, display.contentHeight)
			screenShot:translate( display.contentCenterX-20, display.contentCenterY )
			screenShot.canvas:insert(visiblebg)
			screenShot:invalidate("canvas")
			print ("Inside counter")
			successText.isVisible = false
			successfullImg.isVisible = false
			nextLabel.isVisible = false
			drawpointX = display.contentWidth
			drawpointY = display.contentHeight
			-- adjust the paint position
			drawCompleted = false

			if (princessCounter == 1) then
				firstActive.isVisible = true
				firstInactive.isVisible = false
				--drawMaxPixelCounter = 340
				drawMaxPixelCounter = 120
			elseif 	(princessCounter == 2) then
				secondActive.isVisible = true
				secondInactive.isVisible = false
				--drawMaxPixelCounter = 250
				drawMaxPixelCounter = 120

			elseif (princessCounter == 3) then
				thirdActive.isVisible = true
				 thirdInactive.isVisible = false
				 --drawMaxPixelCounter = 150
				 drawMaxPixelCounter = 55
			elseif (princessCounter == 4) then
				fourthActive.isVisible = true
				fourthInactive.isVisible = false
				--drawMaxPixelCounter = 300
				drawMaxPixelCounter = 110
			elseif (princessCounter == 5) then
				fifthActive.isVisible = true
				fifthInactive.isVisible = false
				--drawMaxPixelCounter = 280
				drawMaxPixelCounter = 85
			end
			lg:removeSelf()
			lg = nil
			lg = display.newGroup()
			local testvar = 1
			local rows = {}
			local cols = {}
			local testX = math.ceil(princess.contentWidth/10)
			while (testvar < testX) do
				rows[testvar] = testvar 
				testvar = testvar+1
			end
			rows[testvar] = testvar 
			testvar = testvar+1

			testvar = 1
			local testY = math.ceil(princess.contentHeight/10)
			while (testvar < testY) do
				cols[testvar] = testvar 
				testvar = testvar+1
			end	
			-- Add one pint on top
			cols[testvar] = testvar 
			testvar = testvar+1
			print(table.getn(cols))
			--local columns = 

			for i=1, #cols do
				for k=1 , #rows do
					local prevx = (princess.x-princess.contentWidth/2)+(k-1)*10
					local prevy = (princess.y-princess.contentHeight/2)+(i-1)*10 

					local rectObj = display.newCircle(lg, prevx, prevy, 10)
					--local rectObj = display.newCircle(prevx, prevy, 10)
					rectObj.alpha = 0
					rectObj.isHitTestable = true
					--rectObj:setFillColor(1,1,1)
					rectObj:addEventListener('touch', touchRect)
				end
			end
	    end
end




	
	function paint(event)
	print('--------------------------TOUCHED-------------------------------------')
	paintbrush:toFront()
	local object = event.target

	local x1,y1 = event.x - screenShot.x, event.y - screenShot.y
		
	print("Phase = ".. event.phase)
	if event.phase == "ended" then
        
		previousX,previousY = x1,y1
		if brushSelect == false then
			print 'inside selection'
			paintbrush.fill.effect = ""
			brushText.isVisible = false
			brushSelect = true
		else
			brushSelect = false
			brushText.isVisible = true
			paintbrush.fill.effect = "filter.desaturate"
			paintbrush.fill.effect.intensity = 0.9
			object.x = display.contentWidth/2 + display.contentWidth/4 *1.5 - paintbrush.contentWidth /2
			object.y = display.contentHeight/2 - paintbrush.contentHeight/2
			
		end
	end	
end
function touchRect(event)
	if (event.phase == "moved" or event.phase == "ended") then
		print ("Inside small Rect object")


		--if (pointCheckX == drawpointX and  
		--	pointCheckY = drawpointX, drawpointY
		print("Flag = ".. tostring(insideImageArea))
		print("Target = ".. tostring(event.target))
		print ("Point x, y="..pointCheckX..",".. pointCheckY.."(Draw)="..drawpointX..","..drawpointY)

		if (insideImageArea == true) then
			--print (event.target)

			local obj = event.target
			-- Change color 
			if (pointCheckX == drawpointX) then
				if (pointCheckY == drawpointY) then
					obj:setFillColor(1,0,0)
					obj:removeEventListener('touch', touchRect)
					circleCounter = circleCounter + 1	
				end	
			end 
				
			
			insideImageArea = false
			--print ("COUNTER==>>>>>>>>>".. circleCounter)
		end

		print ("COUNTER Increment function value=".. circleCounter..", Max Counter=".. drawMaxPixelCounter)
	end
end	
local function showNextPrincess(event)

	if (event.phase == "ended") then
		print ('Stop')
		if (princessCounter < 5) then
			princessCounter = princessCounter + 1
			circleCounter = 0
			percentagevalue = 0
			starSprite.alpha = 0

			princess:removeSelf()
			princess = nil
			visiblebg:removeSelf()
			visiblebg = nil
			assignImages()
			
			screenShot:removeSelf()
			screenShot = nil
			--screenShot = display.newSnapshot(visiblebg.contentWidth, visiblebg.contentHeight)
			screenShot = display.newSnapshot(display.contentWidth, display.contentHeight)
			screenShot:translate( display.contentCenterX-20, display.contentCenterY )
			screenShot.canvas:insert(visiblebg)
			screenShot:invalidate("canvas")
			print ("Inside counter")
			successText.isVisible = false
			successfullImg.isVisible = false
			nextLabel.isVisible = false
			drawpointX = display.contentWidth
			drawpointY = display.contentHeight
			-- adjust the paint position
			drawCompleted = false

			if (princessCounter == 1) then
				firstActive.isVisible = true
				firstInactive.isVisible = false
				--drawMaxPixelCounter = 340
				drawMaxPixelCounter = 120
			elseif 	(princessCounter == 2) then
				secondActive.isVisible = true
				secondInactive.isVisible = false
				--drawMaxPixelCounter = 250
				drawMaxPixelCounter = 120

			elseif (princessCounter == 3) then
				thirdActive.isVisible = true
				 thirdInactive.isVisible = false
				 --drawMaxPixelCounter = 150
				 drawMaxPixelCounter = 55
			elseif (princessCounter == 4) then
				fourthActive.isVisible = true
				fourthInactive.isVisible = false
				--drawMaxPixelCounter = 300
				drawMaxPixelCounter = 110
			elseif (princessCounter == 5) then
				fifthActive.isVisible = true
				fifthInactive.isVisible = false
				--drawMaxPixelCounter = 280
				drawMaxPixelCounter = 85
			end
	

			lg:removeSelf()
			lg = nil
			--display.remove(lg)
			lg = display.newGroup()
			local testvar = 1
			local rows = {}
			local cols = {}
			local testX = math.ceil(princess.contentWidth/10)
			while (testvar < testX) do
				rows[testvar] = testvar 
				testvar = testvar+1
			end
			rows[testvar] = testvar 
			testvar = testvar+1

			testvar = 1
			local testY = math.ceil(princess.contentHeight/10)
			while (testvar < testY) do
				cols[testvar] = testvar 
				testvar = testvar+1
			end	
			-- Add one pint on top
			cols[testvar] = testvar 
			testvar = testvar+1
			print(table.getn(cols))
			--local columns = 

			for i=1, #cols do
				for k=1 , #rows do
					local prevx = (princess.x-princess.contentWidth/2)+(k-1)*10
					local prevy = (princess.y-princess.contentHeight/2)+(i-1)*10 
					local rectObj = display.newCircle(lg, prevx, prevy, 10)
					rectObj.alpha = 0
					rectObj.isHitTestable = true
					rectObj:addEventListener('touch', touchRect)
				end
			end	
			--sceneGroup:insert(lg)
			-- Last point
		else
			-- Show overlay and play the game
			starSprite.alpha = 0
			print ('Completed')	
			msg.gameStatus = 1

			-- Options table for the overlay scene "pause.lua"
			local options = {
			    isModal = true,
			    effect = "fade",
			    time = 400,
			    params = {
			        status = statusMsg 
			    }
			}
			
			allPrincessTogether.isVisible = true
			board.isVisible = false
			princessSelectiontCont.isVisible = false
			brushText.isVisible = false

			firstInactive.isVisible = false
			secondInactive.isVisible = false
			thirdInactive.isVisible = false
			fourthInactive.isVisible = false
			fifthInactive.isVisible = false


			firstActive.isVisible = false
			secondActive.isVisible = false
			thirdActive.isVisible = false
			fourthActive.isVisible = false
			fifthActive.isVisible = false


			starSprite.alpha = 1
			starSprite.x = display.contentCenterX
			starSprite.y = display.contentCenterY
			starSprite.xScale = 1.25
			starSprite.yScale = 1.25
			media.playSound("assets/audio/starsound2.mp3")
			if (mydata.music_status==1) then
				media.setSoundVolume( 1.0 )
			else
				media.setSoundVolume(0)				
			end
			--starSprite:scale(1.25, 1.25)
			-- By some method (a pause button, for example), show the overlay
			mydata.currentmsg=1
			mydata.isgame=true
			drawCompleted = true

			timer.cancel(spendTimer)
			print("total seconds = ".. timeSpentTimerCount) 
			local logParams = {}
			logParams['type'] = "Game"
			logParams['name'] = "Princess Coloring Book"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Princess Coloring Book)", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end	
			timeSpentTimerCount = 0
			timer.performWithDelay(3000, function() composer.showOverlay( "scripts.overlay", options) end )
			
			paintbrush.isVisible = false
			visiblebg.isVisible = false
			princess.isVisible = false
			princess:toBack()
			screenShot.isVisible = false
			nextLabel.isVisible = false
			isBrushOutOfControl = false
			confirmCounter  = 25
	end	
end
	
	
end	
	function draw( x, y )

		print("-------------------------------------------------------------------------")
		local w = display.viewableContentWidth
		local h = display.viewableContentHeight
		
		percentagevalue = (circleCounter/drawMaxPixelCounter)*100

		if (percentagevalue > 72) then
			
			brushText.isVisible = false
		
			if (nextLabel.isVisible == false) then
				media.playSound("assets/audio/starsound.mp3")
				if (mydata.music_status==1) then
					media.setSoundVolume( 1.0 )
				else
					media.setSoundVolume(0)				
				end
				starSprite.alpha = 1
				starSprite.x = nextLabel.x
				starSprite.y = nextLabel.y
				starSprite:play()
				nextLabel.isVisible = true
				nextLabel:toFront()
			end
		end
			local o = display.newCircle( x, y, 10 )
			o.fill.blendMode = { srcColor = "zero", dstColor="oneMinusSrcAlpha" }
			screenShot.canvas:insert( o )
			--screenShot.canvas:insert( r )
			screenShot.canvasMode = 'append'
			screenShot:invalidate( "canvas" ) -- accumulate changes w/o clearing	



	end
	local function clickOnImage1(event)
		if (brushSelect == true) then
			draw(drawpointX, drawpointY)
			pointCheckX, pointCheckY = drawpointX, drawpointY
			insideImageArea = true
			print('Clicked  on non transparent in princess') 
		end
	end		

	brushText = display.newText("Select The Brush", display.contentCenterX, display.contentCenterY, 'Averia', 16) 
	brushText.anchorX = 0
	brushText:setFillColor(1,0.84,0.36)
	
	--brushText.x = display.contentCenterX + display.contentCenterX/2 + brushText.contentWidth/2+10
	if (display.contentHeight==360 and display.contentWidth==480) then
		brushText.xScale=.85
		brushTextyScale=.85
		brushText.x = display.contentCenterX + display.contentCenterX/2+10
	else
		brushText.x = display.contentCenterX + display.contentCenterX/2 - 10
	end
	brushText.y = display.contentCenterY + display.contentCenterY/2 + brushText.contentHeight/2+ 20

	successText = display.newText("Successful", display.contentCenterX, display.contentCenterY, 'BLKCHCRY', 20) 
	successText.x = display.contentCenterX + display.contentCenterX/2 + brushText.contentWidth/2
	successText.y = display.contentCenterY + display.contentCenterY/2 + brushText.contentHeight/2-20
	successText.isVisible = false 
	

	nextLabel = widget.newButton({
	    fontSize = 30,
	    top = 0,
	    labelYOffset = -8,
	    labelAlign = "center",
	    font = 'Averia',
	    labelColor = { default = { 0.281, 0.238, 0.196 }, over = { 0.28, 0.238, 0.148} },
	    width = 215, 
	    height = 75,
	    cornerRadius = 2,
		label="Next",
		defaultFile = "assets/images/next_buton.png",
		onEvent = showNextPrincess
	})


	nextLabel:scale(0.50, 0.50)
	nextLabel.x = princessSelectiontCont.x-5
	nextLabel.y = princessSelectiontCont.y+5
	nextLabel.isVisible = false
	
	function assignImages()
		princess = display.newImage(princessImages[princessCounter])
		princess.x = display.contentCenterX-20
		princess.y = display.contentCenterY

		
		princess.isHittestMasked = true
		princess:addEventListener('touch', clickOnImage1)
		
		local maskImage1 = graphics.newMask(princessMasks[princessCounter])
		princess:setMask( maskImage1 )

		visiblebg = display.newImage(princessBlackWhite[princessCounter])
			
		if (princessCounter == 5) then
			princess:scale(0.23, 0.23)
			visiblebg:scale(0.23, 0.23)
		else
			princess:scale(0.25, 0.25)	
			visiblebg:scale(0.25, 0.25)		
		end	
		board.isVisible = true
		princessSelectiontCont.isVisible = true
	end

	assignImages()

	paintbrush = display.newImage("assets/images/brush.png")
	paintbrush.anchorX = 0
	paintbrush.anchorY = 0
	paintbrush.isHittestMasked = true
	paintbrush:addEventListener('touch', paint)	
	paintbrush:scale(0.9, 0.9)
	paintbrush.x = display.contentWidth/2 + display.contentWidth/4 *1.5 - paintbrush.contentWidth /2

	paintbrush.y = display.contentHeight/2 - paintbrush.contentHeight/2
	local maskImage = graphics.newMask("assets/images/brush-mask.png")
	paintbrush:setMask(maskImage)


	paintbrush.fill.effect = "filter.desaturate"
	paintbrush.fill.effect.intensity = 0.9

	
	screenShot = display.newSnapshot(display.contentWidth, display.contentHeight)
	--screenShot = display.newSnapshot(visiblebg.contentWidth, visiblebg.contentHeight)

	screenShot:translate( display.contentCenterX-20, display.contentCenterY )
	screenShot.canvas:insert(visiblebg)
	screenShot:invalidate("canvas")

	print ("Princess width".. princess.contentWidth)
	print ("Princess Height"..princess.contentHeight)
	
	lg = display.newGroup()
	local testvar = 1
	local rows = {}
	local cols = {}
	local testX = math.ceil(princess.contentWidth/10)
	while (testvar < testX) do
		rows[testvar] = testvar 
		testvar = testvar+1
	end
	rows[testvar] = testvar 
	testvar = testvar+1
	testvar = 1
	local testY = math.ceil(princess.contentHeight/10)
	while (testvar < testY) do
		cols[testvar] = testvar 
		testvar = testvar+1
	end	
	-- Add one pint on top
	cols[testvar] = testvar 
	testvar = testvar+1
	print(table.getn(cols))
	--local columns = 

	for i=1, #cols do
		for k=1 , #rows do
			local prevx = (princess.x-princess.contentWidth/2)+(k-1)*10
			local prevy = (princess.y-princess.contentHeight/2)+(i-1)*10 

			local rectObj = display.newCircle(lg, prevx, prevy, 10)

			rectObj.alpha = 0
			rectObj.isHitTestable = true
			rectObj:addEventListener('touch', touchRect)
		end
	end	

	sceneGroup:insert(background)
	sceneGroup:insert(board)
	--sceneGroup:insert(frame)
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
	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
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
	sceneGroup:insert(lg)
	sceneGroup:insert(princess)
	sceneGroup:insert(brushText)
	sceneGroup:insert(princessSelectiontCont)
	sceneGroup:insert(screenShot)
	sceneGroup:insert(successfullImg)
	
	sceneGroup:insert(princessSelectiontCont)
	sceneGroup:insert(firstInactive)
	sceneGroup:insert(secondInactive)
	sceneGroup:insert(thirdInactive)
	sceneGroup:insert(fourthInactive)
	sceneGroup:insert(fifthInactive)

	sceneGroup:insert(firstActive)
	sceneGroup:insert(secondActive)
	sceneGroup:insert(thirdActive)
	sceneGroup:insert(fourthActive)
	sceneGroup:insert(fifthActive)
	
	sceneGroup:insert(successfullImg)
	sceneGroup:insert(successText)
	sceneGroup:insert(paintbrush)

	
	allPrincessTogether = display.newImage("assets/images/whole_princess.png")
	allPrincessTogether.x = display.contentCenterX
	allPrincessTogether.y = display.contentCenterY
	allPrincessTogether:scale(0.40, 0.40)
	allPrincessTogether.isVisible = false

	
	local seqData = {
		name = "playmusic",
		start = 1,
		count = 20,
		loopCount = 0,
		time = 1000,
		loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
	} 
	local stars = require('scripts.stars_nameAnim')
	local starSheet = graphics.newImageSheet('assets/images/stars_nta.png', stars:getSheet())
	starSprite = display.newSprite(starSheet, seqData)
	starSprite.x = nextLabel.contentWidth/2
	starSprite.y = nextLabel.contentHeight/2
	starSprite.alpha = 0
	starSprite.xScale = 0.55
	starSprite.yScale = 0.55
	--starSprite:scale(0.65, 0.65)
	sceneGroup:insert(starSprite)
	--sceneGroup:insert(levelMessage)
	sceneGroup:insert(allPrincessTogether)
	sceneGroup:insert(nextLabel)
	
	--listener function for enterFrame event
	
	function onTouchEver(event)

		-- Avoid fast dragging on the Brush
		-- Drawing part impelemented  here
			--local object = event.target
		local x1,y1 = event.x - screenShot.x, event.y - screenShot.y
		
		if event.phase == "began" then
	       -- self.markX1 = object.x    -- store x location of object
	       -- self.markY1 = object.y    -- store y location of object
			self.isFocus1 = true
			previousX,previousY = x1,y1
			drawpointX, drawpointY = x1, y1
			-- additional code added
			pointCheckX, pointCheckY = drawpointX, drawpointY
		elseif event.phase == "moved" then
	        local x = (event.x - event.xStart)
		    local y = (event.y - event.yStart)
		    --object.x, object.y = x, y
        	local dx = x1 - previousX
		 	local dy = y1 - previousY
		 	local deltaSq = dx*dx + dy*dy
		 	if ( deltaSq > thresholdSq ) then
		 		drawpointX, drawpointY = x1, y1
		 		previousX,previousY = x1,y1
		 		pointCheckX, pointCheckY = drawpointX, drawpointY
		 	end
		end	
		print ("Touch Phase="..(event.phase) ..", COUNTER=".. circleCounter..", Max Counter=".. drawMaxPixelCounter)
		print ("Draw point(X,Y)="..drawpointX..","..drawpointY)
		return false

	end	
	-- assign the above function as an "enterFrame" listener
	
	Runtime:addEventListener( "touch", onTouchEver )

	
	
end


function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Add timers, audio
		--transition.to(roundedCircle.path, {time=1000, radius=5, onComplete=listener1 })
		-- On android code functioinality 
	
		Runtime:addEventListener( "system", onSystemEvent )

	elseif (phase == "did") then
		--Runtime:addEventListener( "system", onSystemEvent )     
		-- Add objects
		if (firstTimeVisible == false) then
			firstTimeVisible = true
			print("Inside overlay") 
			local options = {
			    isModal = true,
			    effect = "fade",
			    time=1,
			    params = {
			    	gameIndex = 3
				}
			}
			composer.showOverlay("scripts.gameInstructions", options)

		end	
	end	
end

function scene:resume()

	timeSpentTimerCount = 0
	if (spendTimer) then
		timer.cancel( spendTimer )
	end
	spendTimer = timer.performWithDelay(1000, countTime, 0)
	
	firstInactive.isVisible = false
	secondInactive.isVisible = true
	thirdInactive.isVisible = true
	fourthInactive.isVisible = true
	fifthInactive.isVisible = true

	firstActive.isVisible = true
	secondActive.isVisible = false
	thirdActive.isVisible = false
	fourthActive.isVisible = false
	fifthActive.isVisible = false

	allPrincessTogether.isVisible = false

	princessCounter = 1
	circleCounter = 0
	
	princess:removeSelf()
	princess = nil

	visiblebg:removeSelf()
	visiblebg = nil

	assignImages()

	screenShot:removeSelf()
	screenShot = nil
	starSprite.alpha = 0
	starSprite.xScale = 0.65
	starSprite.yScale = 0.65
	screenShot = display.newSnapshot(display.contentWidth, display.contentHeight)
	screenShot:translate( display.contentCenterX-20, display.contentCenterY )
	screenShot.canvas:insert(visiblebg)
	screenShot:invalidate("canvas")
	successText.isVisible = false
	successfullImg.isVisible = false
	brushText.isVisible = true

	-- adjust the paint position
	brushSelect = false
	paintbrush.x = display.contentCenterX + display.contentCenterX/2 *1.5 - paintbrush.contentWidth /2
	paintbrush.y = display.contentCenterY - paintbrush.contentHeight/2
	paintbrush.isVisible = true
	paintbrush.fill.effect = "filter.desaturate"
	paintbrush.fill.effect.intensity = 0.9

	drawCompleted = false

	if (princessCounter == 1) then
		firstActive.isVisible = true
		firstInactive.isVisible = false
		--drawMaxPixelCounter = 340
		drawMaxPixelCounter = 120
	elseif 	(princessCounter == 2) then
		secondActive.isVisible = true
		secondInactive.isVisible = false
		--drawMaxPixelCounter = 250
		drawMaxPixelCounter = 120

	elseif (princessCounter == 3) then
		thirdActive.isVisible = true
		 thirdInactive.isVisible = false
		 --drawMaxPixelCounter = 150
		 drawMaxPixelCounter = 55
	elseif (princessCounter == 4) then
		fourthActive.isVisible = true
		fourthInactive.isVisible = false
		--drawMaxPixelCounter = 300
		drawMaxPixelCounter = 110
	elseif (princessCounter == 5) then
		fifthActive.isVisible = true
		fifthInactive.isVisible = false
		--drawMaxPixelCounter = 280
		drawMaxPixelCounter = 85
	end
	lg:removeSelf()
	lg = nil
	lg = display.newGroup()
	local testvar = 1
	local rows = {}
	local cols = {}
	local testX = math.ceil(princess.contentWidth/10)
	while (testvar < testX) do
		rows[testvar] = testvar 
		testvar = testvar+1
	end
	rows[testvar] = testvar 
	testvar = testvar+1

	testvar = 1
	local testY = math.ceil(princess.contentHeight/10)
	while (testvar < testY) do
		cols[testvar] = testvar 
		testvar = testvar+1
	end	
	-- Add one pint on top
	cols[testvar] = testvar 
	testvar = testvar+1
	print(table.getn(cols))
	--local columns = 

	for i=1, #cols do
		for k=1 , #rows do
			local prevx = (princess.x-princess.contentWidth/2)+(k-1)*10
			local prevy = (princess.y-princess.contentHeight/2)+(i-1)*10 

			local rectObj = display.newCircle(lg, prevx, prevy, 10)
			--local rectObj = display.newCircle(prevx, prevy, 10)
			rectObj.alpha = 0
			rectObj.isHitTestable = true
			--rectObj:setFillColor(1,1,1)
			rectObj:addEventListener('touch', touchRect)
		end
	end	

		--sceneGroup:insert(lg)
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

	if (phase == "will") then
	-- Remove timers, audio , video etc  	
		--Runtime:removeEventListener("system", onSystemEvent )
					--Runtime:removeEventListener( "key", onKeyEvent_game);
							mydata.scene_show=false


	elseif (phase == "did") then
		if (spendTimer) then
			timer.cancel( spendTimer )
		end

		--timer.cancel(spendTimer)
		--print("total seconds = ".. timeSpentTimerCount) 
		if (timeSpentTimerCount > 4) then
			local logParams = {}
			logParams['type'] = "Game"
			logParams['name'] = "Princess Coloring Book"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Princess Coloring Book)", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end	
		end
		mydata.lastScene = "Princess Coloring Book"
	end
end	
function scene:destroy(event)

	local sceneGroup = self.view

	print("Destroy scene------------------")

	princess:removeSelf()
	princess = nil
	
	visiblebg:removeSelf()
	visiblebg = nil

	screenShot:removeSelf()
	screenShot = nil

 -- Remove the Group rectangle container
	lg:removeSelf()
	lg = nil
	-- Remove all event Listeners

	
	Runtime:removeEventListener("touch", onTouchEver )
	Runtime:removeEventListener("system", onSystemEvent )
end
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene