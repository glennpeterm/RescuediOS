-- scen3.lua
local composer = require('composer')
local scene = composer.newScene()
local widget = require('widget')
local msg = require("scripts.globals.constant")
local mydata = require("scripts.mydata")
local widget = require("widget")
local toast = require("scripts.toast");


-- Add timer values 
local timeSpentTimerCount = 0
local spendTimer

local tapCounter = 0
local seqcounter = 1
local manseqCounter = 1
local sequenceNames = {'lionMove1', 'lionMove2', 'lionMove3', 'lionMove4', 'lionMove5', 'lionMove6', 'lionMove7', 'lionMove8', 'lionMove9', 'lionMove10'}
local manSeqNames =   {'manStand', 'manMove1','manMove2', 'manMove3', 'manMove4', 'manMove4', 'manMove5', 'manMove6', 'manMove6', 'manMove7', 'manMove8', 'manMove9' }
local timerId, isTimerstarted = false, timerNew
local xCenter = display.contentCenterX
local onhome=0
local lionAnim, lazyMan, flagElement, dustAnim, rope
local meterControl, bg, statusIndicationBar

local isGroupMoved = false
-- Swipe functionality
local swipeCount, swipeCountCalc
local manFinishPoint, lionFinishPoint

local desertbottom, desertMiddle, skybg, gameStatusBar, indicator, cactus, tree, cactusnear, tumbleweed 

local cactus1, tree1, cactusnear1
local cactus2, tree2, cactusnear2
local cactus3, tree3, cactusnear3
local cactus4, tree4, cactusnear4
local cactus5, tree5, cactusnear5

local gameActive = false
local birdMoveRight = false, swipeCounterBar, levelindicationBar, totalSwipeCounter, birdSprite

local desertMiddlebg, desertbottombg
local down_phase=0

local tPrevious=0
local firstTimeVisible = false 
local desertbgMusic, desertbgMusicChannel  
local manTugofwarSound, manTugofwarSoundChannel
local lionTugofwarSound, lionTugofwarSoundChannel  

local function handleButtonEvent1( event )

	if (gameActive == false) then
		return 1
	end	
    if ( "ended" == event.phase ) then
       --audio.stop(desertbgMusicChannel)
       audio.stop()
       composer.removeHidden()
       composer.removeScene("scripts.scene3", true)
       composer.gotoScene("scripts.home")
    end
end
function scene:on_back()
	if (gameActive == false) then
		return 1
	end
	 audio.stop()
       composer.removeHidden()
       composer.removeScene("scripts.scene3", true)
       composer.gotoScene("scripts.home")
end

local function onsettings(event)

	if (gameActive == false) then
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
local function countTime(event)
	timeSpentTimerCount = timeSpentTimerCount + 1
	print ("Timer count=".. timeSpentTimerCount)
end
function scene:create(event)
	    --	Runtime:addEventListener( "key", onKeyEvent_game );

	mydata.isgame=true
	mydata.ispoem=false
	mydata.isstory=false
	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0,{channel=0})	
	end
	sceneGroup = self.view
	myGr = display.newGroup()
	print ("display CW".. display.contentWidth)
	print ("display CH".. display.contentHeight)
	print("CP".. display.contentCenterX)
	--print("Max texture units"..system.getInfo("maxTextureUnits"))
	swipeCount = 0
	swipeCountCalc = 1
	totalSwipeCounter = 0	
	local bgGradient = {
	    type = "gradient1",
	    color1 = { 0.47, 0.69, 1 },
	    color2 = { 0.61, 0.83, 0.96 },
	    direction = "down"
	}
	local bgGradient = {0.61, 0.83, 0.96}

	desertbottom = display.newImageRect("assets/images/dunes.png", display.contentWidth, display.contentHeight)
	desertbottom.anchorY = 1
	desertbottom.anchorX = 0
	desertbottom:scale(8.327, 0.15)
	desertbottom.x = 0
	desertbottom.y = display.contentHeight
	desertbottom.isVisible = true

	desertbottom1 = display.newImageRect("assets/images/dunes.png", display.contentWidth, display.contentHeight)
	desertbottom1.anchorY = 0
	desertbottom1.anchorX = 0
	desertbottom1:scale(8.327, 0.15)
	desertbottom1.x = desertbottom.contentWidth-4
	desertbottom1.y = display.contentHeight-(display.contentWidth/10)
	desertbottom1.isVisible = true

	desertMiddle = display.newImageRect("assets/images/desert.png", display.contentWidth, display.contentHeight)
	desertMiddle.x = 0
	desertMiddle:scale(8.327, 1)
	desertMiddle.isVisible = true
	desertMiddle.anchorY = 1
	desertMiddle.anchorX = 0
	desertMiddle.y = display.contentHeight+60 


	desertMiddle1 = display.newImageRect("assets/images/desert.png", display.contentWidth, display.contentHeight)
	desertMiddle1.x = desertMiddle.contentWidth-4
	desertMiddle1:scale(8.327, 1)
	desertMiddle1.isVisible = true
	desertMiddle1.anchorY = 1
	desertMiddle1.anchorX = 0
	desertMiddle1.y = display.contentHeight+60 

	skybg = display.newImage("assets/images/sky2.png", display.contentWidth, display.contentHeight)
	skybg.x = display.contentCenterX
	skybg.y = display.contentCenterY 
	skybg.isVisible = true

	gameStatusBar = display.newImage("assets/images/powerbar_2.png")
	gameStatusBar:scale(0.75, 0.75)
	gameStatusBar.x = display.contentCenterX
	gameStatusBar.y = display.contentHeight/7

-- Movement indicator
	indicator = display.newImage("assets/images/powerbar_meter.png")
	indicator:scale(0.5, 0.5)
	indicator.x = display.contentCenterX
	indicator.y = display.contentHeight/7 

	manFinishPoint = indicator.x-90
	lionFinishPoint= indicator.x+90



	cactus = display.newImage("assets/images/cactus.png")
	cactus.anchorX = 0
	cactus:scale(0.5, 0.5)
	cactus.x = display.contentWidth/20
	cactus.y = display.contentCenterY

	cactus1 = display.newImage("assets/images/cactus.png")
	cactus1.anchorX = 0
	cactus1:scale(0.5, 0.5)
	cactus1.x = display.contentWidth*2 + display.contentWidth/20+5
	cactus1.y = display.contentCenterY

	cactus2 = display.newImage("assets/images/cactus.png")
	cactus2.anchorX = 0
	cactus2:scale(0.5, 0.5)
	cactus2.x = display.contentWidth*4 + display.contentWidth/20+8
	cactus2.y = display.contentCenterY

--  SECOND LEVEL OF  TREES  added 
	cactus3 = display.newImage("assets/images/cactus.png")
	cactus3.anchorX = 0
	cactus3:scale(0.5, 0.5)
	cactus3.x = desertMiddle.contentWidth + display.contentWidth/20+8
	cactus3.y = display.contentCenterY

	cactus4 = display.newImage("assets/images/cactus.png")
	cactus4.anchorX = 0
	cactus4:scale(0.5, 0.5)
	cactus4.x = desertMiddle.contentWidth + display.contentWidth*2 + display.contentWidth/20+8
	cactus4.y = display.contentCenterY

	cactus5 = display.newImage("assets/images/cactus.png")
	cactus5.anchorX = 0
	cactus5:scale(0.5, 0.5)
	cactus5.x = desertMiddle.contentWidth + display.contentWidth*4+ display.contentWidth/20+8
	cactus5.y = display.contentCenterY

	tree = display.newImage("assets/images/tree2_2.png")
	--tree:scale(0.5, 0.5)
	tree.anchorY = 1
	tree.y = display.contentCenterY + display.contentHeight/8
	tree.x = display.contentWidth-display.contentWidth/8

	tree1 = display.newImage("assets/images/tree2_2.png")
	--tree:scale(0.5, 0.5)
	tree1.anchorY = 1
	tree1.y = display.contentCenterY + display.contentHeight/8
	tree1.x = display.contentWidth*2 + display.contentWidth-display.contentWidth/8

	tree2 = display.newImage("assets/images/tree2_2.png")
	--tree:scale(0.5, 0.5)
	tree2.anchorY = 1
	tree2.y = display.contentCenterY + display.contentHeight/8
	tree2.x = display.contentWidth*4 + display.contentWidth-display.contentWidth/8

-- THIRD LEVEL OF TREES one added

	tree3 = display.newImage("assets/images/tree2_2.png")
	tree3.anchorY = 1
	tree3.y = display.contentCenterY + display.contentHeight/8
	tree3.x = desertMiddle.contentWidth + display.contentWidth-display.contentWidth/8

	tree4 = display.newImage("assets/images/tree2_2.png")
	tree4.anchorY = 1
	tree4.y = display.contentCenterY + display.contentHeight/8
	tree4.x = desertMiddle.contentWidth + display.contentWidth*2 + display.contentWidth-display.contentWidth/8

	tree5 = display.newImage("assets/images/tree2_2.png")
	tree5.anchorY = 1
	tree5.y = display.contentCenterY + display.contentHeight/8
	tree5.x = desertMiddle.contentWidth + display.contentWidth*4 + display.contentWidth-display.contentWidth/8

	cactusnear = display.newImage("assets/images/cactus.png")
	cactusnear:scale(0.5, 0.5)
	--cactusnear.yScale = -1
	cactusnear.anchorY = 1
	cactusnear.y = display.contentCenterY + display.contentHeight/3
	cactusnear.x = display.contentWidth-display.contentWidth/12

	cactusnear1 = display.newImage("assets/images/cactus.png")
	cactusnear1:scale(0.5, 0.5)
	--cactusnear.yScale = -1
	cactusnear1.anchorY = 1
	cactusnear1.y = display.contentCenterY + display.contentHeight/3
	cactusnear1.x = display.contentWidth*2 + display.contentWidth-display.contentWidth/12

	cactusnear2 = display.newImage("assets/images/cactus.png")
	cactusnear2:scale(0.5, 0.5)
	cactusnear2.anchorY = 1
	cactusnear2.y = display.contentCenterY + display.contentHeight/3
	cactusnear2.x = display.contentWidth*4 + display.contentWidth-display.contentWidth/12

-- Cactus new added 
	
	cactusnear3 = display.newImage("assets/images/cactus.png")
	cactusnear3:scale(0.5, 0.5)
	cactusnear3.anchorY = 1
	cactusnear3.y = display.contentCenterY + display.contentHeight/3
	cactusnear3.x = desertMiddle.contentWidth +  display.contentWidth-display.contentWidth/12

	cactusnear4 = display.newImage("assets/images/cactus.png")
	cactusnear4:scale(0.5, 0.5)
	cactusnear4.anchorY = 1
	cactusnear4.y = display.contentCenterY + display.contentHeight/3
	cactusnear4.x = desertMiddle.contentWidth + display.contentWidth*2 + display.contentWidth-display.contentWidth/12

	cactusnear5 = display.newImage("assets/images/cactus.png")
	cactusnear5:scale(0.5, 0.5)
	cactusnear5.anchorY = 1
	cactusnear5.y = display.contentCenterY + display.contentHeight/3
	cactusnear5.x = desertMiddle.contentWidth + display.contentWidth*4 + display.contentWidth-display.contentWidth/12

	tumbleweed = display.newImage("assets/images/tumbleweed_2.png")
	tumbleweed.anchorX = 0
	tumbleweed.rotation = 360
	tumbleweed.x = display.contentWidth/12
	tumbleweed.y = display.contentHeight-display.contentHeight/4


	swipeCounterBar = display.newRect(display.contentWidth-30, display.contentHeight, 20, 100)
	swipeCounterBar.anchorX = 0
	swipeCounterBar.anchorY = 1
	swipeCounterBar.strokeWidth = 2
	swipeCounterBar:setStrokeColor(0.4, 0, 0)

	levelindicationBar = display.newRect(display.contentWidth-30, display.contentHeight, 20, 100)
	levelindicationBar.anchorX = 0
	levelindicationBar.anchorY = 1
	levelindicationBar:setFillColor(0,0,1)
	levelindicationBar.height = 0

	levelindicationBar.isVisible = false
	swipeCounterBar.isVisible =false

	local paint = {
	    type = "gradient",
	    color1 = { 1, 0, 0.4 },
	    color2 = { 1, 0, 0, 0.2 },
	    direction = "down"
	}
	local paint1 = { 1, 0, 0.5 }
	levelindicationBar.fill = paint
   
    local lion = require('scripts.tugofwar_lion')
    local sequenceData = {
		{ name = "lionStand", start=1, count=2, time=600, loopCount = 1 },
	    { name = "lionMove1", start=1, count=4, time=700, loopCount = 1 },
	    { name = "lionMove2", start=4, count=2, time=600, loopCount = 1 },
	    { name = "lionMove3", start=6, count=2, time=600, loopCount = 1 },
	    { name = "lionMove4", start=8, count=2, time=600, loopCount = 1 },
	    { name = "lionMove5", start=10, count=2, time=600, loopCount = 1 },
	    { name = "lionMove6", start=12, count=2, time=600, loopCount = 1 },
	    { name = "lionMove7", start=14, count=2, time=600, loopCount = 1 },
	    { name = "lionMove8", start=16, count=2, time=600, loopCount = 1 },
	    { name = "lionMove9", start=17, count=2, time=600, loopCount = 1 },
	}
	local lionsequenceData = {
	    { name = "lionMove1", start=1, count=40, time=2000, loopCount = 1 },
	}
	local flagsequenceData = {
		{ name = "flying", start=1, count=2, time=600, loopCount = 1 },
	}
	local lazyMansequenceData = {
		{ name = "manStand", start=1, count=1, time=600, loopCount = 1 },
	    { name = "manMove1", start=1, count=4, time=600, loopCount = 1 },
	    { name = "manMove2", start=3, count=4, time=600, loopCount = 1 },
	    { name = "manMove3", start=5, count=4, time=600, loopCount = 1 },
	    { name = "manMove4", start=7, count=4, time=600, loopCount = 1 },
	    { name = "manMove5", start=9, count=4, time=600, loopCount = 1 },
	    { name = "manMove6", start=11, count=4, time=600, loopCount = 1 },
	    { name = "manMove7", start=13, count=4, time=600, loopCount = 1 },
	    { name = "manMove8", start=15, count=4, time=600, loopCount = 1 },
	    { name = "manMove9", start=17, count=3, time=600, loopCount = 1 },
	    { name = "manSweep", start=20, count=1, time=1000, loopCount = 1 },
	}

 	local sheet1 = graphics.newImageSheet( "assets/images/tugofwar_lion.png", lion:getSheet() )
   
	local sequenceBackData = {
    	name="backmoving",
	    start=2,
	    count=4,
	    time=1000,
	    loopCount = 1,   -- Optional ; default is 0 (loop indefinitely)
	    loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
	}
	local sequenceSweepData = {
    	name="sweep",
	    start=1,
	    count=1,
	    time=1000,
	    loopCount = 1,   -- Optional ; default is 0 (loop indefinitely)
	    loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
	}
	local sequenceflagData = {
 	    start=1,
	    count=20,
	    time=1000,
	    loopCount = 0,   -- Optional ; default is 0 (loop indefinitely)
	    loopDirection = "bounce"    -- Optional ; values include "forward" or "bounce"
	} 
	local man = require("scripts.tow_lazyman")
 
	local manImageSheet = graphics.newImageSheet("assets/images/tow_lazyman.png", man:getSheet())
	lazyMan = display.newSprite(manImageSheet, lazyMansequenceData)
	lazyMan.x =  display.contentWidth/4
	lazyMan.y =  display.contentCenterY + display.contentCenterY/2 * 0.30

	lazyMan:scale(0.75, 0.75)
	lazyMan:setSequence('manStand')
	lazyMan:play()

	local flag = require('scripts.flag')
	local flagSheet = graphics.newImageSheet("assets/images/flag.png", flag:getSheet())
	flagElement = display.newSprite(flagSheet, sequenceflagData) 
	flagElement.x = display.contentCenterX
	flagElement.y = display.contentCenterY
	flagElement:scale(0.15, 0.15)
	flagElement.anchorY = 0
	flagElement.y = display.contentCenterY + display.contentCenterY/2 * 0.40
	flagElement:play()


	rope = display.newImage("assets/images/rope_2.png")
	rope.x = display.contentCenterX
	rope:scale(0.5, 0.75)
	rope.anchorX = 0
	rope.anchorY = 0
	rope.x = lazyMan.x 
	rope.y = display.contentCenterY + display.contentCenterY/2 * 0.40
	--rope.rotation = -0.9

  
  	lionAnim = display.newSprite( sheet1, sequenceData )
    lionAnim.x = rope.x + rope.contentWidth-display.contentWidth/20
    lionAnim.y = rope.y - display.contentHeight/8.3 
    lionAnim.anchorX = 0
    lionAnim.anchorY = 0

    lionAnim:scale(0.70, 0.70)
    lionAnim:setSequence("lionStand")
    --lionAnim:setSequence(sequenceNames[seqcounter])
	lionAnim:play()


	local dustSequencedata = {
		start=1,
	    count=20,
	    time=600,
	    loopCount = 1,   -- Optional ; default is 0 (loop indefinitely)
	    loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
	}

	local dust = require('scripts.dust1')
	local dustSheet = graphics.newImageSheet('assets/images/dust1.png', dust:getSheet())
	dustAnim = display.newSprite(dustSheet, dustSequencedata) 
	

	local bird = require('scripts.bird')
	local birdSheet = graphics.newImageSheet("assets/images/bird.png", bird:getSheet())

	birdSprite = display.newSprite(birdSheet,{start=1, count=16, time=1100, loop=0} )
	birdSprite:scale(0.65, 0.65)
	dustAnim.xScale = -1
	dustAnim.x = rope.x
	dustAnim.y = rope.y + 70
	dustAnim.isVisible = false


	-- Load all sound files
	desertbgMusic = audio.loadStream("assets/audio/desert_bgm.mp3") 
	lionTugofwarSound = audio.loadSound("assets/audio/spider_walk.mp3")
	manTugofwarSound = audio.loadSound("assets/audio/spider_walk.mp3")

	sceneGroup:insert(skybg)
	sceneGroup:insert(desertMiddle)
	sceneGroup:insert(desertMiddle1)
	sceneGroup:insert(cactus)
	sceneGroup:insert(birdSprite)
	sceneGroup:insert(tree)
	sceneGroup:insert(cactusnear)

	sceneGroup:insert(cactus1)
	sceneGroup:insert(cactus2)
	sceneGroup:insert(cactus3)
	sceneGroup:insert(cactus4)
	sceneGroup:insert(cactus5)

	sceneGroup:insert(tree1)
	sceneGroup:insert(tree2)
	sceneGroup:insert(tree3)
	sceneGroup:insert(tree4)
	sceneGroup:insert(tree5)

	sceneGroup:insert(cactusnear1)
	sceneGroup:insert(cactusnear2)
	sceneGroup:insert(cactusnear3)
	sceneGroup:insert(cactusnear4)
	sceneGroup:insert(cactusnear5)

	sceneGroup:insert(tumbleweed)
	
	sceneGroup:insert(gameStatusBar)
	sceneGroup:insert(indicator)
	sceneGroup:insert(rope)
	sceneGroup:insert(lionAnim)
	sceneGroup:insert(lazyMan)
	sceneGroup:insert(dustAnim)
	sceneGroup:insert(flagElement)
	sceneGroup:insert(desertbottom)
	sceneGroup:insert(desertbottom1)
	--sceneGroup:insert(desertbottom2)
	sceneGroup:insert(swipeCounterBar)
	sceneGroup:insert(levelindicationBar)
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

	birdSprite.x = display.contentWidth-display.contentWidth/10
	birdSprite:scale(0.65, 0.65)
	birdSprite.anchorX = 0.5
	birdSprite.y = display.contentHeight/9
	
 	local function dustAnimationEvent(event)
 		if (event.phase == "ended") then
 			--dustAnim.isVisible = false
 			transition.to( dustAnim, { time=100, alpha=0 } )
 		end
 	
 	end

 	local function gameMovement()
 		
 		

 		if (swipeCount > 0) then
 			swipeCount = swipeCount-1
 			lionAnim:setSequence("lionMove1")
        	lionAnim:play()
        	lazyMan:setSequence('manSweep')
        	lazyMan:play()
        	dustAnim.isVisible = true
        	transition.to( dustAnim, { time=50, alpha=1 } )
        	dustAnim:play()

 			if (swipeCountCalc) then
 				levelindicationBar.height = ((swipeCountCalc-swipeCount)/swipeCountCalc)*100
 			end	
  		else	
  			swipeCountCalc = swipeCountCalc + 1
  			swipeCount = swipeCountCalc 
  			print("Count==".. swipeCount)	
  			print('Indicator moved')

  			transition.to(indicator, {x = indicator.x + 10})
  			audio.play(lionTugofwarSound, {loops = 0})
 			levelindicationBar.height = ((swipeCountCalc-swipeCount)/swipeCountCalc)*100

	        if (timerId) then
				timer.cancel(timerId)
				timerId = timer.performWithDelay(3000, listener, 0)	       
	      	else
	         	timerId = timer.performWithDelay(3000, listener, 0)
	     	end
	        if (indicator.x > (lionFinishPoint-20)) then	
	        	msg.gameStatus = 1
	        	-- Show overlay 
	        	mydata.currentmsg=1
				mydata.isgame=true
	        	local options = {
				    isModal = true,
				    effect = "fade",
				    time = 100,
				    params = {
				        
				    }
				}
				-- Set the point correctly
				indicator.x = lionFinishPoint
				gameActive = false

				timer.cancel(spendTimer)
				print("total seconds = ".. timeSpentTimerCount) 
				local logParams = {}
				logParams['type'] = "Game"
				logParams['name'] = "Tug of War"
				logParams['time'] = timeSpentTimerCount

				analytics.logEvent("TIME-SPENT-IN-GAME(Tug of War)", logParams)

				for i,v in pairs(logParams) do
				 	print(i, v)
				end
				timeSpentTimerCount = 0

				composer.showOverlay( "scripts.overlay", options)
				timer.cancel(timerId)
				flagElement:pause()
				birdSprite:pause()
				--gameActive = false
				audio.stop(desertbgMusicChannel)
	        end
 		end	
	 	transition.to(desertMiddle, {x = desertMiddle.x - 15}) 
		transition.to(desertMiddle1, {x = desertMiddle1.x - 15})
		transition.to(desertbottom, {x = desertbottom.x - 15})
		transition.to(desertbottom1, {x = desertbottom1.x - 15})

		transition.to(cactus, {x = cactus.x - 15})
		transition.to(cactusnear, {x = cactusnear.x - 15})
		transition.to(tree, {x = tree.x - 15})

		transition.to(cactus1, {x = cactus1.x - 15})
		transition.to(cactusnear1, {x = cactusnear1.x - 15})
		transition.to(tree1, {x = tree1.x - 15})

		transition.to(cactus2, {x = cactus2.x - 15})
		transition.to(cactusnear2, {x = cactusnear2.x - 15})
		transition.to(tree2, {x = tree2.x - 15})

		transition.to(cactus3, {x = cactus3.x - 15})
		transition.to(cactusnear3, {x = cactusnear3.x - 15})
		transition.to(tree3, {x = tree3.x - 15})

		transition.to(cactus4, {x = cactus4.x - 15})
		transition.to(cactusnear4, {x = cactusnear4.x - 15})
		transition.to(tree4, {x = tree4.x - 15})

		transition.to(cactus5, {x = cactus5.x - 15})
		transition.to(cactusnear5, {x = cactusnear5.x - 15})
		transition.to(tree5, {x = tree5.x - 15})

 		print("SWIPE COUNT=".. swipeCount..",TOTAL COUNT".. swipeCountCalc)
 	end	

    local widgetButton = widget.newButton{
        width = 353,
	    height = 317,
	    defaultFile = "assets/images/tug_button_inactive.png",
	    overFile = "assets/images/tug_button_active.png",
	    label = ""
	  --  onEvent = handleButtonEvent
	}
	sceneGroup:insert(widgetButton)
	-- Camera follows bolder automatically
	
	dustAnim:addEventListener('sprite', dustAnimationEvent)
	
	widgetButton:scale(0.65, 0.65)
    widgetButton.x = display.contentCenterX + display.contentCenterX/2 * 1.5 
    widgetButton.y = display.contentCenterY + display.contentCenterY/2 * 1.35      	
    -- Swipe functionality 
    local swipeLayer = display.newRect(0, 0, display.contentWidth, display.contentHeight )
    swipeLayer.x = display.contentCenterX
    swipeLayer.y = display.contentCenterY
	swipeLayer.alpha = 0.0 --make it transparent
	swipeLayer:setFillColor(1, 0, 0)
	swipeLayer.isHitTestable = true
		
	local function startDrag(event)
		local swipeLength = math.abs(event.x - event.xStart) 
		print(event.phase, swipeLength)
		local t = event.target
		local phase = event.phase
		if "began" == phase then
			return true
		elseif "moved" == phase then
		elseif "ended" == phase or "cancelled" == phase then
	        if event.xStart < event.x and swipeLength > 50 then 
	            print( "Swiped Right" )
	            gameMovement()
			end	
		end
	end
	swipeLayer:addEventListener("touch", startDrag)
	sceneGroup:insert(swipeLayer)
	widgetButton.isVisible = false
end
function listener( event )
	print("Timer reached . ")
	if (indicator.x~=nil) then
       	transition.to(indicator, {x = indicator.x - 12})
    end

	transition.to(desertMiddle, {x = desertMiddle.x + 15}) 
	transition.to(desertMiddle1, {x = desertMiddle1.x + 15})
	--transition.to(desertMiddle2, {x = desertMiddle2.x + 10})

	transition.to(desertbottom, {x = desertbottom.x + 15})
	transition.to(desertbottom1, {x = desertbottom1.x + 15})
	--transition.to(desertbottom2, {x = desertbottom2.x + 10})

	transition.to(cactus, {x = cactus.x + 15})
	transition.to(cactusnear, {x = cactusnear.x + 15})
	transition.to(tree, {x = tree.x + 15})

	transition.to(cactus1, {x = cactus1.x + 15})
	transition.to(cactusnear1, {x = cactusnear1.x + 15})
	transition.to(tree1, {x = tree1.x + 15})

	transition.to(cactus2, {x = cactus2.x + 15})
	transition.to(cactusnear2, {x = cactusnear2.x + 15})
	transition.to(tree2, {x = tree2.x + 15})

	transition.to(cactus3, {x = cactus3.x + 15})
	transition.to(cactusnear3, {x = cactusnear3.x + 15})
	transition.to(tree3, {x = tree3.x + 15})

	transition.to(cactus4, {x = cactus4.x + 15})
	transition.to(cactusnear4, {x = cactusnear4.x + 15})
	transition.to(tree4, {x = tree4.x + 15})

	transition.to(cactus5, {x = cactus5.x + 15})
	transition.to(cactusnear5, {x = cactusnear5.x + 15})
	transition.to(tree5, {x = tree5.x + 15})
	
	if (indicator.x < (manFinishPoint+20)) then	
		print ("Man won")
		msg.gameStatus = 0
		-- Show overlay 
		mydata.currentmsg=2
		mydata.isgame=true
		local options = {
		    isModal = true,
		    effect = "fade",
		    time = 100,
		    params = {
		        
		    }
		}
		indicator.x = manFinishPoint
		gameActive = false

		timer.cancel(spendTimer)
		print("total seconds = ".. timeSpentTimerCount) 
		local logParams = {}
		logParams['type'] = "Game"
		logParams['name'] = "Tug of War"
		logParams['time'] = timeSpentTimerCount

		analytics.logEvent("TIME-SPENT-IN-GAME(Tug of War)", logParams)

		for i,v in pairs(logParams) do
		 	print(i, v)
		end
		-- Clear it
		timeSpentTimerCount = 0
		composer.showOverlay( "scripts.retry", options)
		timer.cancel(timerId)
		flagElement:pause()
		birdSprite:pause()
		gameActive = false
		audio.stop(desertbgMusicChannel)

	else	
		lazyMan:setSequence("manMove1")
		lazyMan:play()
		audio.play(manTugofwarSound, {loops = 0})
		if (swipeCountCalc > 0) then
			swipeCountCalc = swipeCountCalc - 1
			swipeCount = swipeCountCalc
		end
		if (swipeCountCalc) then
			levelindicationBar.height = ((swipeCountCalc-swipeCount)/swipeCountCalc)*100
		end
	end
end
-- This method handles camera like movement 
function moveCamera(event)
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )
	
	--print ("Game active ==".. tostring(gameActive))	
	if (desertMiddle.x ~=nil and desertMiddle.contentWidth ~=nil) then
		if (desertMiddle.x + desertMiddle.contentWidth) < 0 then
		 	desertMiddle:translate((desertMiddle.contentWidth*2)-4, 0)
		end
		if (desertMiddle1.x + desertMiddle1.contentWidth) < 0 then
		 	desertMiddle1:translate( (desertMiddle1.contentWidth*2)-4, 0)
		end
		if (desertbottom.x + desertbottom.contentWidth) < 0 then
		 	desertbottom:translate((desertbottom.contentWidth*2)-4, 0)
		end
		if (desertbottom1.x + desertbottom1.contentWidth) < 0 then
		 	desertbottom1:translate((desertbottom1.contentWidth*2)-4, 0)
		end
	end	

	if (gameActive == false) then
		return 1
	end	

	print ("Point =" ..myGr.x..",Point".. math.abs(myGr.x + myGr.contentWidth), "DisWid".. display.contentWidth)
	print("My group width=".. myGr.contentWidth)
	

	if (tumbleweed.x~=nil) then
		tumbleweed.rotation = tumbleweed.rotation-2
		tumbleweed.x = tumbleweed.x + 0.5
	end
	
	--if (birdSprite.x~=nil) then
		if (birdMoveRight == false) then
			if (birdSprite.x > -50) then
				birdSprite.x = birdSprite.x-1 
			else
				--birdSprite:scale(0.75, 0.75)
				birdSprite.xScale = -0.65
				birdMoveRight = true
			end
		else
			if (birdSprite.x < (display.contentWidth+50)) then
				birdSprite.x = birdSprite.x+1 
			else
				--birdSprite:scale(0.75, 0.75)
				birdSprite.xScale = 0.65
				birdMoveRight = false
			end	
		end	
	--end
	if (tumbleweed.x~=nil) then
		if (tumbleweed.x > display.contentWidth+50) then
			tumbleweed.x = 0
		end	
	end

end

function scene:show(event)
	local sceneGroup = self.view	
	local phase = event.phase

    if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      	
        desertMiddle.x = desertMiddle.x - 170
		desertbottom.x = desertbottom.x - 170
		desertMiddle1.x = desertMiddle1.x - 170
		desertbottom1.x = desertbottom1.x - 170
		-- implement logical part
		if (firstTimeVisible == false) then
			firstTimeVisible = true
			print("Inside overlay") 
			local options = {
			    isModal = true,
			    effect = "fade",
			    time=1,
			    params = {
			    	gameIndex = 2
				}
			}
			composer.showOverlay("scripts.gameInstructions", options)
		end	
    end
end	
local function toast_listener()
		if (mydata.music_status==0 or mydata.narration_status==0) then
			toast.new("Sound is off",2000,sceneGroup)

		end
end
 function scene:show_toast()
 	timer.performWithDelay( 200,toast_listener )

end
-- This method initialise all variables and start the game 
function scene:initGame()
	birdSprite:play()
	birdMoveRight = false
	gameActive = true
	-- Repeat the background music 
	desertbgMusicChannel = audio.play(desertbgMusic, {loops=-1})
	Runtime:addEventListener( "enterFrame", moveCamera )
	print ("Game started="..tostring(gameActive))

	spendTimer = timer.performWithDelay(1000, countTime, 0)
end	
function scene:resume()
	print "Restart"
	-- initialise variables 
	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0,{channel=0})	
	end
	tapCounter = 0
	seqcounter = 1
 	manseqCounter = 1

 	swipeCount = 0
	swipeCountCalc = 0
 	lionAnim:setSequence(sequenceNames[seqcounter])
 	lionAnim:play()

 	lazyMan:setSequence(manSeqNames[manseqCounter])
	lazyMan:play()
    
    indicator.x = display.contentCenterX
	indicator.y = display.contentHeight/7 
	levelindicationBar.height = 0
	birdSprite:play()
	gameActive = true

	desertMiddle.x = desertMiddle.x - 170
	desertbottom.x = desertbottom.x - 170
	desertMiddle1.x = desertMiddle1.x - 170
	desertbottom1.x = desertbottom1.x - 170

	cactus.x = display.contentWidth/20
	cactus.y = display.contentCenterY

	cactus1.x = display.contentWidth*2 + display.contentWidth/20+5
	cactus1.y = display.contentCenterY

	cactus2.x = display.contentWidth*4 + display.contentWidth/20+8
	cactus2.y = display.contentCenterY
	
-- New one added 
	cactus3.x = desertMiddle.contentWidth + display.contentWidth/20+8
	cactus3.y = display.contentCenterY

	cactus4.x = desertMiddle.contentWidth + display.contentWidth*2 + display.contentWidth/20+8
	cactus4.y = display.contentCenterY

	cactus5.x = desertMiddle.contentWidth + display.contentWidth*4+ display.contentWidth/20+8
	cactus5.y = display.contentCenterY

	tree.y = display.contentCenterY + display.contentHeight/8
	tree.x = display.contentWidth-display.contentWidth/8

	tree1.y = display.contentCenterY + display.contentHeight/8
	tree1.x = display.contentWidth*2 + display.contentWidth-display.contentWidth/8

	tree2.y = display.contentCenterY + display.contentHeight/8
	tree2.x = display.contentWidth*4 + display.contentWidth-display.contentWidth/8

-- New one added

	tree3.y = display.contentCenterY + display.contentHeight/8
	tree3.x = desertMiddle.contentWidth + display.contentWidth-display.contentWidth/8

	tree4.y = display.contentCenterY + display.contentHeight/8
	tree4.x = desertMiddle.contentWidth + display.contentWidth*2 + display.contentWidth-display.contentWidth/8

	tree5.y = display.contentCenterY + display.contentHeight/8
	tree5.x = desertMiddle.contentWidth + display.contentWidth*4 + display.contentWidth-display.contentWidth/8

	cactusnear.y = display.contentCenterY + display.contentHeight/3
	cactusnear.x = display.contentWidth-display.contentWidth/12

	cactusnear1.y = display.contentCenterY + display.contentHeight/3
	cactusnear1.x = display.contentWidth*2 + display.contentWidth-display.contentWidth/12

	cactusnear2.y = display.contentCenterY + display.contentHeight/3
	cactusnear2.x = display.contentWidth*4 + display.contentWidth-display.contentWidth/12
	
	cactusnear3.y = display.contentCenterY + display.contentHeight/3
	cactusnear3.x = desertMiddle.contentWidth +  display.contentWidth-display.contentWidth/12

	cactusnear4.y = display.contentCenterY + display.contentHeight/3
	cactusnear4.x = desertMiddle.contentWidth + display.contentWidth*2 + display.contentWidth-display.contentWidth/12

	cactusnear5.y = display.contentCenterY + display.contentHeight/3
	cactusnear5.x = desertMiddle.contentWidth + display.contentWidth*4 + display.contentWidth-display.contentWidth/12
	desertbgMusicChannel = audio.play(desertbgMusic, {loops=-1})

	timeSpentTimerCount = 0
	if (spendTimer) then
		timer.cancel( spendTimer )
	end
	spendTimer = timer.performWithDelay(1000, countTime, 0)
end	
function scene:next()
end
function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
   			mydata.scene_show=false

      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
      --Runtime:removeEventListener( "enterFrame", moveCamera )
                Runtime:removeEventListener( "key", onKeyEvent_game );

   elseif ( phase == "did" ) then
		-- Called immediately after scene goes off screen.
		--audio.stop()
		--if (timerId) then
		--	timer.cancel( timerId )
		--end
		print("Inside HIDE WINDOW - 1")
		if (timerId) then
			timer.cancel( timerId )
		end
		if (spendTimer) then
			timer.cancel( spendTimer )
		end

		--timer.cancel(spendTimer)
		--print("total seconds = ".. timeSpentTimerCount) 
		if (timeSpentTimerCount > 4) then

			print ("On home page ")
			local logParams = {}
			logParams['type'] = "Game"
			logParams['name'] = "Tug of War"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Tug of War)", logParams)
			for i,v in pairs(logParams) do
		 		print(i, v)
			end
		end
		
		Runtime:removeEventListener( "enterFrame", moveCamera )
		print("Inside HIDE WINDOW - 2")
		mydata.lastScene = "Tug of War"
   end
end	
function scene:destory(event)
	local sceneGroup = self.view
	--audio.stop(desertbgMusicChannel)
	
	-- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
    print("STOPPED-----------------")
  --  Runtime:removeEventListener( "enterFrame", moveCamera )
    
    audio.dispose(desertbgMusic)
	audio.dispose(lionTugofwarSound)
	audio.dispose(manTugofwarSound)

	desertbgMusic = nil
	lionTugofwarSound = nil
	manTugofwarSound = nil	

	if (timerId) then
    	timer.cancel( timerId )
    end
    -- For security added here also 

    Runtime:removeEventListener( "enterFrame", moveCamera )
  --  Runtime:removeEventListener( "key", onKeyEvent_game );
	

end
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)	

return scene