----------------------------------------------------------------------------------
--
-- game.lua
--
----------------------------------------------------------------------------------
local toast = require("scripts.toast");
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

-- Add timer values 
local timeSpentTimerCount = 0
local spendTimer

display.setStatusBar( display.HiddenStatusBar )
local physics = require("physics");
physics.start();
local projectile = require("scripts.projectile");
local mydata=require("scripts.mydata")
local circleGroup=nil
local physicsData = (require "scripts.body").physicsData(.5)
local hits=0
local numhits=0
local force=0
local ball_inactive={}
local ball_active={}
local misses=5
local firstTimeVisible = false
local onhome=0
local m = {}
m.random = math.random;
local projectiles_container=nil
local force_multiplier = 2;
local velocity = m.random(50,170);
local cl=0
local sheetInfo = require("scripts.slingshotsprite") -- lua file that Texture packer published
local down_phase=0
local myImageSheet = graphics.newImageSheet( "assets/images/slingshotsprite.png", sheetInfo:getSheet() )


local function countTime(event)
	timeSpentTimerCount = timeSpentTimerCount + 1
	print ("Timer count=".. timeSpentTimerCount)
end

function onLocalCollision(self,event)
	if (event.phase=="began") then
		audio.play( hit)
		if (mydata.music_status==1) then
			audio.setVolume(1.0,{channel=0})
		else
			audio.setVolume(0.0,{channel=0})	
		end
		cl=1
		numhits=numhits+1
		if (numhits==1) then
			hits=hits+1
			num=4-hits
			shake()
			settings:setFrame( num )
			if (hits==4) then
				physics.pause()
				settings.alpha=0
				mydata.currentmsg=1
				mydata.isgame=true
				local options = {
				    isModal = true,
				    effect = "fade",
				    time = 400
				}
				if (spendTimer) then
					timer.cancel( spendTimer )
				end

				print("total seconds = ".. timeSpentTimerCount) 
				local logParams = {}
				logParams['type'] = "Game"
				logParams['name'] = "Slingshot War"
				logParams['time'] = timeSpentTimerCount

				analytics.logEvent("TIME-SPENT-IN-GAME(Slingshot War)", logParams)
				
				for i,v in pairs(logParams) do
				 	print(i, v)
				end
				timeSpentTimerCount = 0
				composer.showOverlay("scripts.overlay",options)
			end
		end
	end
end
function shake( ... )
	function rotate()
		goliath.rotation=math.random(-5,5)
	end
	timer.performWithDelay( 10, rotate ,10)
end
function scene:music_mute_function( )
	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0.0,{channel=0})	
	end
end
 function scene:narration_mute_function( )
	if (mydata.narration_status==1) then
			
	else
						
	end
end
local function onsettings(event)
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
local function handleButtonEvent( event )
    if ( "ended" == event.phase) then
       	composer.removeHidden()
        composer.gotoScene("scripts.home")
    end
end
function scene:on_back()
 	composer.removeHidden()
    composer.gotoScene("scripts.home")
end
function scene:resume()
	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0.0,{channel=0})	
	end
	settings.alpha=1
	background.x=0
	background.y=display.contentCenterY
	goliath.x=display.contentWidth+50
	goliath.y=display.contentCenterY+goliath.contentHeight/6
	slingshot_strut_back.x = 100;
	slingshot_strut_back.y =goliath.y+(goliath.y/4)
	slingshot_strut_front.x = 100;
	slingshot_strut_front.y = goliath.y+(goliath.y/4)
	gameGroup.x=0
	if (projectiles_container) then
		projectiles_container:removeSelf( )
		projectiles_container=nil
	end
	hits=0
	misses=5
	numhits=0
	display.remove( circleGroup )	
	mydata.status=4
	num=5
	settings:setFrame( num )
	physics.start( )
	for i=1,5 do
		ball_active[i].alpha=1
	end
 	gameGroup.x=-background.contentWidth/3
	function spawn()
		spawnProjectile();
	end
	timer.performWithDelay( 2500, spawn )
	
	timeSpentTimerCount = 0
	if (spendTimer) then
		timer.cancel( spendTimer )
	end

	spendTimer = timer.performWithDelay(1000, countTime, 0)
end
function scene:create( event )

	-- local logParams = {}
	-- logParams['type'] = "Game"
	-- logParams['name'] = "Slingshot War"

	-- analytics.logEvent("GAME-LAUNCHED", logParams)
	-- for i,v in pairs(logParams) do
	--  	print(i, v)
	-- end
	spendTimer = timer.performWithDelay(1000, countTime, 0)

	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=0})
	else
		audio.setVolume(0.0,{channel=0})	
	end
	mydata.isgame=true
	mydata.ispoem=false
	mydata.isstory=false
	sceneGroup=self.view
	mydata.status=4
	physics.start();
	hits=0
	numhits=0
	gameGroup = display.newGroup( )
	sceneGroup:insert( gameGroup )
	background=display.newImageRect("assets/images/slingshot_bg.jpg",display.contentHeight*3,display.contentHeight+display.contentHeight/10)
	background.anchorX=0
	background.x=0
	background.y=display.contentCenterY
	background:addEventListener( "touch", swipe)
	gameGroup:insert(background )
	projectile.ready = true;
	goliath=display.newImageRect("assets/images/goliath.png",128,200)
	goliath.myName="goliath"
	physics.addBody( goliath, "static", physicsData:get("goliath") )
	goliath.x=display.contentWidth+50
	goliath.y=display.contentCenterY+goliath.contentHeight/6
	goliath.collision = onLocalCollision
	goliath:addEventListener( "collision" )--gameGroup:insert(goliath)
	slingshot_strut_back = display.newImage( myImageSheet , sheetInfo:getFrameIndex("slink02"))
	slingshot_strut_back.x = 100;
	slingshot_strut_back.y =goliath.y+(goliath.y/4)--slingshot_strut_back.contentHeight/2
	slingshot_strut_back.xScale=.12
	slingshot_strut_back.yScale=.12
	slingshot_strut_front = display.newImage( myImageSheet , sheetInfo:getFrameIndex("slink01"))
	slingshot_strut_front.x = 100;
	slingshot_strut_front.y = goliath.y+(goliath.y/4)-- slingshot_strut_front.contentHeight/2
	slingshot_strut_front.xScale=.12
	slingshot_strut_front.yScale=.12
	shot = audio.loadSound("assets/audio/band-release.mp3");
 	band_stretch = audio.loadSound("assets/audio/stretch-1.mp3");
 	hit = audio.loadSound("assets/audio/stone_hit.mp3");
	projectile.shot = shot;
	projectile.band_stretch = band_stretch;
	gameGroup:insert(slingshot_strut_back);
	gameGroup:insert(slingshot_strut_front);
	button1 = widget.newButton
	{
	    width = display.contentHeight/10,
	    height = display.contentHeight/11,
	    defaultFile = "assets/images/button_1.png",
	    overFile = "assets/images/button_2.png",
	    onEvent = onsettings
	}
	button1.x = (display.contentWidth-button1.contentWidth/2)-15
	button1.y = (button1.contentHeight/2)+15
	button1.xScale=1.8
	button1.yScale=1.8
	sceneGroup:insert( button1 )
	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
 	settings1 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)	
	settings1.x=button1.x
	settings1.y=button1.y-5
	settings1.xScale=1
	settings1.yScale=1
	sceneGroup:insert(settings1)
	button2 = widget.newButton
	{
	    width = display.contentHeight/10,
	    height = display.contentHeight/11,
	    defaultFile = "assets/images/button_1.png",
	    overFile = "assets/images/button_2.png",
	    onEvent = handleButtonEvent
	}
	button2.name="button2"
	button2.x = (button2.contentWidth/2)+15
	button2.y = (button2.contentHeight/2)+15
	button2.xScale=1.8
	button2.yScale=1.8
	sceneGroup:insert( button2 )
 	settings2 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)	
	settings2.x=button2.x
	settings2.y=button2.y-5
	settings2.xScale=1
	settings2.yScale=1
	gameGroup.x=-background.contentWidth/3
	sceneGroup:insert(settings2)
	local options =
	{
	    width = 304,
	    height = 56,
	    numFrames = 4,
	    sheetContentWidth = 304,  
	    sheetContentHeight = 224,  
	}
	local sequenceData =
	{
	    frames= { 3,2,5,1 }, 
	    time = 240,
	    loopCount = 0       
	}
	settings = display.newSprite( myImageSheet,sequenceData)
	settings.x= button1.x- display.contentWidth/4.6
	settings.y=display.contentHeight*.1--goliath.y+goliath.contentHeight/2
	settings.xScale=.08
	settings.yScale=.07
	settings:setFrame( 4 )
 	holder = display.newImage( myImageSheet , sheetInfo:getFrameIndex("nav_holder"))
	holder.x = settings.x--100;
	holder.y =settings.y--display.contentHeight- 50--slingshot_strut_back.contentHeight/2
	holder.xScale=.2
	holder.yScale=.15
	sceneGroup:insert(holder)
	sceneGroup:insert(settings)
 	holder1 = display.newImageRect( "assets/images/goliath_icon1.png",85,85)
	holder1.x = settings.x+(settings.x/6.5)--100;
	holder1.y =settings.y--display.contentHeight- 50--slingshot_strut_back.contentHeight/2
	holder1.xScale=.5
	holder1.yScale=.5
	sceneGroup:insert(holder1)
	holder_goliath = display.newImage( myImageSheet , sheetInfo:getFrameIndex("nav_holder"))
	holder_goliath.x = button2.x + display.contentWidth/4.6-- display.contentWidth/3.5--settings.x-(settings.x/10)--100;
	holder_goliath.y =settings.y--display.contentHeight- 50--slingshot_strut_back.contentHeight/2
	holder_goliath.xScale=.2
	holder_goliath.yScale=.15
	sceneGroup:insert( holder_goliath)
 	david = display.newImageRect( "assets/images/david_icon1.png",340,404)
	david.x = holder_goliath.x/1.6--100;
	david.y =settings.y--display.contentHeight- 50--slingshot_strut_back.contentHeight/2
	david.xScale=.13
	david.yScale=.13
	sceneGroup:insert(david)	
	for i=1,5 do
		ball_inactive[i]= display.newImage( myImageSheet , sheetInfo:getFrameIndex("nav_dots_inavtive"))
		ball_inactive[i].x=holder_goliath.x/1.6+15+16*i
		ball_inactive[i].y=settings.y
		ball_inactive[i].xScale=.08
		ball_inactive[i].yScale=.08
		sceneGroup:insert(ball_inactive[i])
		ball_active[i]= display.newImage( myImageSheet , sheetInfo:getFrameIndex("nav_dots_avtive"))
		ball_active[i].x=holder_goliath.x/1.6+15+16*i
		ball_active[i].y=settings.y
		ball_active[i].xScale=.08
		ball_active[i].yScale=.08
		sceneGroup:insert(ball_active[i])
	end
	gameGroup:insert(goliath);
	rocks=display.newImageRect("assets/images/ssw_rocks_overlay.png",display.contentHeight*3,display.contentHeight*3*.0586)
	rocks.anchorX=0
	rocks.anchorY=1
	rocks.x=0
	rocks.y=display.contentHeight
	gameGroup:insert(rocks )
	
end
local function projectileTouchListener(e)
	local t = e.target;
	if(t.ready) then
		if(e.phase == "began") then
			xstart=e.x
			ystart=e.y
			audio.play(band_stretch);
			if (mydata.music_status==1) then
				audio.setVolume(1.0,{channel=0})
			else
				audio.setVolume(0.0,{channel=0})	
			end
			display.getCurrentStage():setFocus( t );
			t.isFocus = true;
			t.bodyType = "kinematic";
			local myLine = nil;
			local myLineBack = nil;
		elseif(t.isFocus) then
			if(e.phase == "moved") then
				if(myLine) then
					myLine.parent:remove(myLine); -- erase previous line
					myLineBack.parent:remove(myLineBack); -- erase previous line
					myLine = nil;
					myLineBack = nil;
				end
				if(t.x < 80 and t.y < display.contentHeight - display.contentHeight/2.8)then
					myLineBack = display.newLine(t.x-15, t.y, 110, display.contentHeight - display.contentHeight/2.8);
					myLine = display.newLine(t.x-15, t.y, 80, display.contentHeight - display.contentHeight/2.7);
				elseif(t.x > 80 and t.y < display.contentHeight - display.contentHeight/2.8)then
					myLineBack = display.newLine(t.x -5, t.y-15 , 110, display.contentHeight - display.contentHeight/2.8);
					myLine = display.newLine(t.x -5, t.y-15 , 80, display.contentHeight - display.contentHeight/2.7);
				elseif(t.x < 80 and t.y > display.contentHeight - display.contentHeight/2.8)then
					myLineBack = display.newLine(t.x - 15, t.y + 10, 110, display.contentHeight - display.contentHeight/2.8);
					myLine = display.newLine(t.x - 15, t.y + 10, 80, display.contentHeight - display.contentHeight/2.7);
				elseif(t.x > 80 and t.y > display.contentHeight - display.contentHeight/2.8)then
					myLineBack = display.newLine(t.x - 10, t.y + 15, 110, display.contentHeight - display.contentHeight/2.8);
					myLine = display.newLine(t.x - 10, t.y + 15, 80, display.contentHeight - display.contentHeight/2.7);
				else
					myLineBack = display.newLine(t.x - 15, t.y, 110, display.contentHeight - display.contentHeight/2.8);
					myLine = display.newLine(t.x - 15, t.y, 80, display.contentHeight - display.contentHeight/2.7);
				end
				myLineBack:setColor(1,1,0.7);
				myLineBack.width = 4;
				myLine:setColor(1,1,0.7);
				myLine.width = 5;
				gameGroup:insert(slingshot_strut_back);
				gameGroup:insert(myLineBack);
				gameGroup:insert(t);
				gameGroup:insert(myLine);
				gameGroup:insert(slingshot_strut_front);
				gameGroup:insert(rocks);
				local bounds = e.target.stageBounds;
				bounds.xMax = 150;
				bounds.yMax = display.contentHeight - 250;
				if(e.y > bounds.yMax) then
					t.y = e.y;
				else
				
				end
				if(e.x < bounds.xMax) then
					t.x = e.x;
				else
				end
			elseif(e.phase == "ended" or e.phase == "cancelled") then
				projectiles_container:removeEventListener("touch", projectileTouchListener);
				display.getCurrentStage():setFocus(nil);
				t.isFocus = false;
				audio.play(shot);
				if (mydata.music_status==1) then
					audio.setVolume(1.0,{channel=0})
				else
						audio.setVolume(0.0,{channel=0})	
				end
				if(myLine) then
					myLine.parent:remove(myLine); -- erase previous line
					myLineBack.parent:remove(myLineBack); -- erase previous line
					myLine = nil;
					myLineBack = nil;
				end
				t.bodyType = "dynamic";
				force=-(t.x-xstart*force_multiplier*.9)
				t:applyForce(-(t.x-xstart)*force_multiplier*1.7, -( t.y-ystart)*force_multiplier*1.6, t.x, t.y);
				t:applyTorque( 170 )
				t.isFixedRotation = false
				draw1()
			end
		end
	end
end
function spawnProjectile()
	if (misses<1 and hits<4) then
		physics.pause()
		mydata.currentmsg=2
        mydata.isgame=true
        local options = {
						    isModal = true,
						    effect = "fade",
						    time = 400
						}

		if (spendTimer) then
			timer.cancel( spendTimer )
		end
		print("total seconds = ".. timeSpentTimerCount) 
		local logParams = {}
		logParams['type'] = "Game"
		logParams['name'] = "Slingshot War"
		logParams['time'] = timeSpentTimerCount

		analytics.logEvent("TIME-SPENT-IN-GAME(Slingshot War)", logParams)

		for i,v in pairs(logParams) do
		 	print(i, v)
		end	
		timeSpentTimerCount = 0			
		composer.showOverlay("scripts.retry",options)
	end
	if(projectile.ready)then
 		if (drawtimer) then
			timer.cancel( drawtimer )
  		end
	  	if (misses>=1) then
	  	 	ball_active[misses].alpha=0
	   		misses=misses-1
		end
	  	transition.to( gameGroup, {time=2000,x=0} )
	    circleGroup=display.newGroup()
	    if (gameGroup) then
	    	gameGroup:insert(circleGroup)
	    end
		numhits=0
		projectiles_container = projectile.newProjectile();
		projectiles_container.ready = true;
		projectiles_container.remove = true;
		gameGroup:insert(slingshot_strut_back);
		gameGroup:insert(projectiles_container);
		gameGroup:insert(slingshot_strut_front);
		gameGroup:insert(rocks);
		projectiles_container:addEventListener("touch", projectileTouchListener);
	end
end
function draw1( ... )
	function crcl( ... )
		if (projectiles_container~=nil) then
			if (projectiles_container.x~=nil and projectiles_container.y~=nil) then
				circle=display.newCircle( projectiles_container.x,projectiles_container.y, 3 )
				circleGroup:insert( circle)
	    	end
	   	end
	end
	drawtimer=timer.performWithDelay( force,crcl,-1 )
end
function draw()
	if (projectiles_container) then
		if (projectiles_container.x~=nil) then
			if (projectiles_container.x > 100 and projectiles_container.x < background.contentWidth/3) then
				gameGroup.x = -projectiles_container.x + 100
			end
			if ( projectiles_container.y>display.contentHeight+60  or projectiles_container.x>background.contentWidth or projectiles_container.x<-100)then
				projectiles_container:removeSelf( )
				projectiles_container=nil
				display.remove( circleGroup )	
				spawnProjectile()
				cl=0
			end
		end
	end
end
function scene:onstart()
	spawnProjectile();
end
function swipe(event)
	if event.phase == "began" then
		xx=gameGroup.x
		print( "xx" )
		print(xx)
	elseif event.phase == "moved" then
		movedX = event.x - event.xStart
		movedY = event.y - event.yStart
		if (gameGroup.x>=-320 and gameGroup.x<=0 and xx~=nil) then
			if (xx+movedX<-320) then
				add=-320
			elseif(xx+movedX>0) then
				add=0
			else
				add=xx+movedX
			end
			gameGroup.x=add
		end
	end
end
function scene:show( event )
	local gameGroup = self.view
	local phase = event.phase
	if phase == "will" then

	elseif phase == "did" then
		if (firstTimeVisible == false) then
			firstTimeVisible = true
			local options = {
			    isModal = true,
			    effect = "fade",
			    time = 300,
			    params = {
			    gameIndex = 6
						}
				}
			composer.showOverlay("scripts.gameInstructions", options)
		end	
			Runtime:addEventListener( "enterFrame", draw )
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
function scene:next()
end
function scene:hide( event )
	local gameGroup = self.view
	local phase = event.phase
	if event.phase == "will" then
		mydata.scene_show=false
	if (projectile_timer) then
		timer.cancel( projectile_timer )
	end
	elseif phase == "did" then
		Runtime:removeEventListener( "enterFrame", draw )
		audio.dispose( shot )
		audio.dispose( band_stretch )
		audio.dispose( hit )
		shot=nil
		band_stretch=nil
		hit=nil

		if (spendTimer) then
			timer.cancel( spendTimer )
		end
		print("total seconds = ".. timeSpentTimerCount) 
		if (timeSpentTimerCount > 4) then
			print ("On home page ")
			local logParams = {}
			logParams['type'] = "Game"
			logParams['name'] = "Slingshot War"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Slingshot War)", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end
		end
		mydata.lastScene = "Slingshot War"
	end	
end
function scene:destroy( event )
	local gameGroup = self.view
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene