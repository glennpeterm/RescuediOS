system.setIdleTimer( false )
local physics = require "physics"

-- Add timer values 
local timeSpentTimerCount = 0
local spendTimer

physics.start()
physics.setGravity( 0, 0)
local toast = require("scripts.toast");
local physicsData = (require "scripts.lion_body").physicsData(.3)
local physicsData1 = (require "scripts.spider_body").physicsData(.2)
local spider=require("scripts.spider")
local composer = require( "composer" )
local scene = composer.newScene()
local mydata = require( "scripts.mydata" )
local widget = require( "widget" )
local holeShift =128
local hole =104
local screenW, screenH, halfW, halfH = display.contentWidth, display.contentHeight, display.contentWidth*0.5 , display.contentHeight*0.5 
local blocks= {}
local blocks1= {}
local blocks2= {}
local ctheme=math.random(1,3)
local point=1
local speed1=6
local firstTimeVisible = false
local onhome=0
mydata.logerror=1
mydata.scene=2
mydata.score = 0
local speedVector=-1
mydata.flag=0
mydata.errorstatus=0
local down_phase=0


local function countTime(event)
	timeSpentTimerCount = timeSpentTimerCount + 1
	print ("Timer count=".. timeSpentTimerCount)
end

local function handleButtonEvent1( event )
    if ( "ended" == event.phase ) then
   			Runtime:removeEventListener("touch", tap)
			Runtime:removeEventListener("touch", flyUp)
        	composer.removeHidden()
        	composer.gotoScene("scripts.home")
    end
end
function scene:on_back()
	Runtime:removeEventListener("touch", tap)
	Runtime:removeEventListener("touch", flyUp)
	composer.removeHidden()
	composer.gotoScene("scripts.home")
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
local function onKeyEvent( event )
    if (event.keyName=="back") then
     	if ( event.keyName == "back" and event.phase=="down") then
     		down_phase=1
       		return true
       	end
   		if ( event.keyName == "back" and event.phase=="up" and down_phase==1) then
    		down_phase=0
         	function rmv()
	    	 	Runtime:removeEventListener("touch", tap)
				Runtime:removeEventListener("touch", flyUp)
			end
			timer.performWithDelay( 1,rmv )
	        composer.removeHidden()
	        composer.gotoScene("scripts.home")
            return true
        end
		return true
	end
	return true
end
function scene:change()
  	composer.removeHidden( false )
	composer.gotoScene( "scripts.home" )
end
function scene:resume( )
	physics.setDrawMode( "normal" )
	mydata.score=0
	scoreText.text=mydata.score
	scoreText1.text=mydata.score
	background1.anchorX = 0
	background1.anchorY = 0
	background1.x = 0
	background1.y = -10
	background1_2.anchorX = 0
	background1_2.anchorY = 0
	background1_2.x = background1.contentWidth
	background1_2.y = -10
	for i = 1, 2, 1 do
	    blocks[i*2].x = halfW +150 + 400* i
	   	blocks[i*2].y = 100
	   	blocks[1 + i*2].anchorY=1
	    blocks[1 + i*2].anchorX=0.5
	    blocks[1 + i*2].speed = 3
	    blocks[1 + i*2].x =  blocks[i*2].x+200
	    blocks[1 + i*2].y = display.contentHeight
	end	
	character.x= display.contentCenterX -100
	character.y= display.contentCenterY
	character.bodyType="static"
	physics.start( )
	character.rotation=0
	Runtime:addEventListener("touch", tap)
	Runtime:addEventListener("touch", flyUp)
	Runtime:addEventListener("enterFrame", background1)
	Runtime:addEventListener("enterFrame", background1_2)
	Runtime:addEventListener("enterFrame", shape4)
	Runtime:addEventListener("enterFrame", shape3)
	Runtime:addEventListener("enterFrame", shape1)
	Runtime:addEventListener("enterFrame", shape)
	Runtime:addEventListener("enterFrame", shadow1)
	Runtime:addEventListener("enterFrame", shadow2)
	Runtime:addEventListener("enterFrame", shadow3)
	Runtime:addEventListener("enterFrame", shadow4)
	speed1=6

	timeSpentTimerCount = 0
	if (spendTimer) then
		timer.cancel(spendTimer)	
	end
	spendTimer = timer.performWithDelay(1000, countTime, 0)
end
function scene:create( event )
	-- local logParams = {}
	-- logParams['type'] = "Game"
	-- logParams['name'] = "Spider in The Den"

	-- analytics.logEvent("GAME-LAUNCHED", logParams)
	-- for i,v in pairs(logParams) do
	--  	print(i, v)
	-- end
	spendTimer = timer.performWithDelay(1000, countTime, 0)

	mydata.isgame=true
	mydata.ispoem=false
	mydata.isstory=false
 	sceneGroup = self.view
	physics.setDrawMode( "normal" )
 	sheetInfo_zzz = require("scripts.lion_zzz")
	myImageSheet_zzz = graphics.newImageSheet( "assets/images/lion_zzz.png", sheetInfo_zzz:getSheet() )
 	sequenceData_zzz = {
                { name="seq1", sheet=myImageSheet, start=1, count=50, time=10000,},
                }
	background1 = display.newImageRect('assets/images/bg1.jpg',display.contentHeight*3,display.contentHeight+20)
	background1.anchorX = 0
	background1.anchorY = 0
	background1.y = -10
	background1.speed = 7
	sceneGroup:insert(background1)
	background1_2 = display.newImageRect('assets/images/bg1.jpg',display.contentHeight*3,display.contentHeight+20)
	background1_2.anchorX = 0
	background1_2.anchorY = 0
	background1_2.x = background1.contentWidth
	background1_2.y = -10
	background1_2.speed = 7
	sceneGroup:insert(background1_2)
	background1.link=background1_2
	background1_2.link=background1
	for i = 1, 2, 1 do
		height = math.random(190- 80, 190 + 80)
		local line = display.newImageRect("assets/images/male_lion.png",75,140)
		line.speed = 3
	    line.x = halfW +150 + 400* i
	   	line.y = 100
	    line.cross = false
	    physics.addBody(line, "static", physicsData:get("male_lion"))
	    sceneGroup:insert(line)		
		blocks[i*2] = line
		local lineTop = display.newImageRect("assets/images/female_lion.png",75,140)
	    lineTop.anchorY=1
	    lineTop.anchorX=0.5
	    lineTop.speed = 3
	    lineTop.x = line.x+200
	    lineTop.y = display.contentHeight
	    physics.addBody(lineTop, "static",  physicsData:get("female_lion"))
	    sceneGroup:insert(lineTop)		
		blocks[1 + i*2] = lineTop
	end	
    elements = display.newGroup()
	elements.anchorChildren = true
	elements.anchorX = 0
	elements.anchorY = 1
	elements.x = 0
	elements.y = 0
	sceneGroup:insert(elements)
	shape = display.newImageRect("assets/images/rock1.png",display.contentWidth*1.5,75)
	shape.anchorX=0
	shape.anchorY=0
	shadow1 = display.newImageRect("assets/images/rock1_shadow.png",display.contentWidth*1.5,75)
	shadow1.anchorX=0
	shadow1.anchorY=0
	shape1 = display.newImageRect("assets/images/rock1.png",display.contentWidth*1.5,75)
	shape1.anchorX=0
	shape1.anchorY=0
	shape1.x=shape.contentWidth
	shadow2 = display.newImageRect("assets/images/rock1_shadow.png",display.contentWidth*1.5,75)
	shadow2.anchorX=0
	shadow2.anchorY=0
	shadow2.x=shadow1.contentWidth
	shape3 = display.newImageRect("assets/images/rock2.png",display.contentWidth*1.5,75)
	shape3.anchorX=0
	shape3.anchorY=1
	shape3.y=display.contentHeight
	shadow3 = display.newImageRect("assets/images/rock2_shadow.png",display.contentWidth*1.5,75)
	shadow3.anchorX=0
	shadow3.anchorY=1
	shadow3.y=display.contentHeight
	shape4 = display.newImageRect("assets/images/rock2.png",display.contentWidth*1.5,75)
	shape4.anchorX=0
	shape4.anchorY=1
	shape4.x=shape3.contentWidth
	shape4.y=display.contentHeight
	shadow4 = display.newImageRect("assets/images/rock2_shadow.png",display.contentWidth*1.5,75)
	shadow4.anchorX=0
	shadow4.anchorY=1
	shadow4.x=shadow3.contentWidth
	shadow4.y=display.contentHeight
	platform2 = display.newRect( -45, -30, 570, 1 )
	sheetInfo = require("scripts.spider")
	myImageSheet = graphics.newImageSheet( "assets/images/spider.png", sheetInfo:getSheet() )
	sequenceData = {
	                  { name="seq1", sheet=myImageSheet, start=1, count=7, time=2000 },
	              }
    character = display.newSprite( myImageSheet, sequenceData)
	character.x= display.contentCenterX -100
	character.y= display.contentCenterY
	character.xScale=.3
	character.yScale=.3
	physics.addBody(character, "static",physicsData1:get("spider"))
	sceneGroup:insert(character)
	character:play()
	sceneGroup:insert(shadow1)
	sceneGroup:insert(shadow2)
	sceneGroup:insert(shadow3)
	sceneGroup:insert(shadow4)
	sceneGroup:insert(shape)
	sceneGroup:insert(shape1)
	sceneGroup:insert(shape3)
	sceneGroup:insert(shape4)
	scoreText1 = display.newText(mydata.score,display.contentCenterX,30, "Comix Loud", 24)
	scoreText1:setFillColor(0,0,0)
	scoreText1.alpha = 0
	sceneGroup:insert(scoreText1)
	scoreText = display.newText(mydata.score,display.contentCenterX,30, "Comix Loud", 20)
	scoreText:setStrokeColor( 0, 0, 0 )
	scoreText.alpha = 0
	sceneGroup:insert(scoreText)
	platform2 = display.newRect( -45, 379, 570, 1 )
	physics.addBody(platform2, "static", {density=1, bounce=0.1, friction=1})
	sceneGroup:insert(platform2)
	platform2 = display.newRect( -45, -30, 570, 1 )
	physics.addBody(platform2, "static", {density=1, bounce=0.1, friction=1})
	sceneGroup:insert(platform2)
	local button2 = widget.newButton
	{
	    width = display.contentHeight/10,
	    height = display.contentHeight/11,
	    defaultFile = "assets/images/button_1.png",
	    overFile = "assets/images/button_2.png",
	    onEvent = handleButtonEvent1
	}
	button2.x = (button2.contentWidth/2)+15
	button2.y = (button2.contentHeight/2)+15
	button2.xScale=1.8
	button2.yScale=1.8
	sceneGroup:insert( button2 )
	sheetInfo_control = require("scripts.controll_icons")
 	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
 	settings1 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)
	settings1.x=button2.x
	settings1.y=button2.y-5
	settings1.xScale=1
	settings1.yScale=1
	sceneGroup:insert(settings1)
	lion_icon=display.newImageRect( "assets/images/lion_icon.png",85,85)
	lion_icon.x=display.contentWidth-lion_icon.contentWidth*1.2
	lion_icon.y=lion_icon.contentWidth/2-10
	lion_icon.xScale=.6
	lion_icon.yScale=.6
	sceneGroup:insert(lion_icon)
    character_zzz= display.newSprite( myImageSheet_zzz, sequenceData_zzz)
	character_zzz.x=lion_icon.x-lion_icon.x/20
	character_zzz.y=lion_icon.y-lion_icon.y/.5
	character_zzz.xScale=.5
	character_zzz.yScale=.5
	character_zzz:play()
	sceneGroup:insert(character_zzz)
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
 	settings2 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)
	settings2.x=button1.x
	settings2.y=button1.y-5
	settings2.xScale=1
	settings2.yScale=1
	sceneGroup:insert(settings2)
end
function tap( ... )
	Runtime:removeEventListener("touch", tap)
	timer1=timer.performWithDelay( 100, fready  )
end
function speed( ... )
	speed1=speed1+1
end
function fready( ... )
	ready = display.newImageRect( "assets/images/ready.png", 200, 50 )
	ready.x=display.contentCenterX
	ready.y=display.contentCenterY
	sceneGroup:insert(ready)
	transition.fadeOut( ready, { time=1000 } )
	timer2=timer.performWithDelay( 1000, fsteady,1 )
end
function fsteady( ... )
	steady = display.newImageRect( "assets/images/steady.png", 200, 50 )
	steady.x=display.contentCenterX
	steady.y=display.contentCenterY
	sceneGroup:insert(steady)
	transition.fadeOut( steady, { time=1000 } )
	timer3=timer.performWithDelay( 1000, fgo,1 )
end
function fgo( ... )
	go = display.newImageRect( "assets/images/go.png", 200, 50 )
	go.x=display.contentCenterX
	go.y=display.contentCenterY
	sceneGroup:insert(go)
	transition.fadeOut( go, { time=1000 } )
	function goup(  )
		character.enterFrame = rotateBird
		Runtime:addEventListener("enterFrame", character)
	 	Runtime:addEventListener("collision", onCollision)
	 	applytimer=timer.performWithDelay( 15000,speed,-1 )
		character.bodyType = "dynamic"
	 	scoreText.alpha = 1
	 	scoreText1.alpha = 1
	 	gameStarted = true
	 	physics.setGravity( 0, 0)
	 	character:setLinearVelocity( 0, -350 )
		physics.setGravity( 0, 40)
	end
	timer4=timer.performWithDelay( 1000, goup,1 )	
end
function fready1( ... )
	ready1 = display.newImageRect( "assets/images/gameover.png", 260, 75 )
	ready1.x=display.contentCenterX
	ready1.y=display.contentCenterY
	sceneGroup:insert(ready1)
	transition.fadeOut( ready1, { time=1000 } )
	timer5=timer.performWithDelay( 1000, fready2,1 )
end
function fready2( ... )
	ready11 = display.newImageRect( "assets/images/startagain.png", 260, 75 )
	ready11.x=display.contentCenterX
	ready11.y=display.contentCenterY
	sceneGroup:insert(ready11)
	transition.fadeOut( ready11, { time=1000 } )
	timer6=timer.performWithDelay( 1000, changescene,1 )
end
function changescene()
	mydata.currentmsg=2
	mydata.isgame=true
	local options = {
				    isModal = true,
				    effect = "fade",
				    time = 400,
				    params = {
				        
				    }
					}
	if (spendTimer) then
		timer.cancel(spendTimer)	
	end					
	
	print("total seconds = ".. timeSpentTimerCount) 
	local logParams = {}
	logParams['type'] = "Game"
	logParams['name'] = "Spider in The Den"
	logParams['time'] = timeSpentTimerCount

	analytics.logEvent("TIME-SPENT-IN-GAME(Spider in The Den)", logParams)

	for i,v in pairs(logParams) do
	 	print(i, v)
	end	
	timeSpentTimerCount = 0			
	composer.showOverlay( "scripts.overlay",options)
end
function rotateBird(self ,event)
	if speedVector==-1 then
		speedVector = self.y
	else	
		local deltaSpeed = speedVector-self.y;
		speedVector = self.y		
		self.rotation = - deltaSpeed*3
		if self.rotation>1 then 
			self.rotation = 1
		end
		if self.rotation<-15 then 
			self.rotation = -15
		end		
	end
	for i = 1, 2, 1 do
		if (blocks[i*2].x < display.contentCenterX - 120 ) then
			if (blocks[i*2].cross == false ) then
				mydata.score = mydata.score + point
				scoreText.text = mydata.score
				scoreText1.text = mydata.score
				blocks[i*2].cross =true
			end
		end
		height = math.random(190-80, 190+80)
		gap=math.random(35,45)
		blocks[i*2].x = blocks[i*2].x - speed1--blocks[i*2].speed
		blocks[1+i*2].x = blocks[i*2].x+200
		if blocks[i*2].x <= -74*1*3 then
			blocks[i*2].cross=false
		   	blocks[i*2].x = halfW + 400* 1
		    blocks[1+i*2].x =  blocks[i*2].x+200
		end
	end	
end
function onCollision( event )
	if ( event.phase == "began" ) then
		spider_splash=audio.loadSound("assets/audio/spider_splash.mp3")
		audio.play(spider_splash)
		if (mydata.music_status==1) then
			audio.setVolume(1.0,{channel=0})
		else
			audio.setVolume(0,{channel=0})	
		end
		speed1=6
		if (applytimer) then
		timer.cancel( applytimer )
		end
		physics.pause( )
		Runtime:removeEventListener("touch", flyUp)
		Runtime:removeEventListener("enterFrame", platform)
		Runtime:removeEventListener("enterFrame", background1)
		Runtime:removeEventListener("enterFrame", platform2)
		Runtime:removeEventListener("enterFrame", character)
		Runtime:removeEventListener("collision", onCollision)
		Runtime:removeEventListener("enterFrame", background1_2)
		Runtime:removeEventListener("enterFrame", shape4)
		Runtime:removeEventListener("enterFrame", shape3)
		Runtime:removeEventListener("enterFrame", shape1)
		Runtime:removeEventListener("enterFrame", shape)
		Runtime:removeEventListener("enterFrame", shadow1)
		Runtime:removeEventListener("enterFrame", shadow2)
		Runtime:removeEventListener("enterFrame", shadow3)
		Runtime:removeEventListener("enterFrame", shadow4)
		if (timer1) then
			timer.cancel( timer1 )
		end
		if (timer2) then
			timer.cancel( timer2 )
		end
		if (timer3) then
			timer.cancel( timer3 )
		end
		if (timer4) then
			timer.cancel( timer4 )
		end
		if (timer5) then
			timer.cancel( timer5 )
		end
		if (timer6) then
			timer.cancel( timer6)
		end
		if (timer7) then
			timer.cancel( timer7 )
		end
		if (timer8) then
			timer.cancel( timer8 )
		end
		function spriteshow( )
			timer8=timer.performWithDelay( 600,fready1,1)
		end
		timer7=timer.performWithDelay( 0,spriteshow,1)	
	end
end
function bgScroller(self,event)
	if self.x <= 0-self.contentWidth then
		xx=-self.contentWidth+speed1-(self.x)
    	self.x =self.contentWidth-xx
 	else
 		self.x = self.x - speed1
 	end
end
function rockscroller(self,event)
	if self.x <= 0-self.contentWidth then
		xx=-self.contentWidth+speed1-(self.x)
    	self.x =self.contentWidth-xx
	else
	 	self.x = self.x - speed1
	end
end
local gameStarted = false
function flyUp(event)
	physics.setGravity( 0, 0)
   	if event.phase == "began" then
	  	character:setLinearVelocity( 0, -183)
	end
	physics.setGravity( 0, 23)
end
local function toast_listener()
	if (mydata.music_status==0 or mydata.narration_status==0) then
		toast.new("Sound is off",2000,sceneGroup)
	end
end
function scene:show_toast()
 	timer.performWithDelay( 200,toast_listener )
end
local function checkMemory()
	   collectgarbage( "collect" )
	   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
	   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		if (firstTimeVisible == false) then
			firstTimeVisible = true
			print("Inside overlay") 
			local options = {
			    isModal = true,
			    effect = "fade",
			    time = 300,
			    params = {
			    	gameIndex = 4
				}
			}
			composer.showOverlay("scripts.gameInstructions", options)
			Runtime:addEventListener("touch", flyUp)
			background1.enterFrame = rockscroller
			Runtime:addEventListener("enterFrame", background1)
    		background1_2.enterFrame = rockscroller
    		Runtime:addEventListener("enterFrame", background1_2)
  		 	shape.enterFrame=rockscroller
   			Runtime:addEventListener("enterFrame",shape)
			shape1.enterFrame=rockscroller
   			Runtime:addEventListener("enterFrame",shape1)
    		shape3.enterFrame=rockscroller
   			Runtime:addEventListener("enterFrame",shape3)
    		shape4.enterFrame=rockscroller
   			Runtime:addEventListener("enterFrame",shape4)
     		shadow1.enterFrame=rockscroller
   			Runtime:addEventListener("enterFrame",shadow1)
      		shadow2.enterFrame=rockscroller
   			Runtime:addEventListener("enterFrame",shadow2)
      		shadow3.enterFrame=rockscroller
   			Runtime:addEventListener("enterFrame",shadow3)
       		shadow4.enterFrame=rockscroller
   			Runtime:addEventListener("enterFrame",shadow4)
    		Runtime:addEventListener("touch",tap)
   			memTimer = timer.performWithDelay( 1000, checkMemory, 0 )
		end	
	end	
end
function scene:next()
end
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		mydata.scene_show=false

	elseif phase == "did" then
		-- Called when the scene is now off screen
		Runtime:removeEventListener("touch", flyUp)
		Runtime:removeEventListener("enterFrame", platform)
		Runtime:removeEventListener("enterFrame", platform2)
		Runtime:removeEventListener("collision", onCollision)
		if (memTimer) then
			timer.cancel(memTimer)
		end
		if (applytimer) then
				timer.cancel( applytimer )
		end
		if (timer1) then
    		timer.cancel( timer1 )
    	end
    	if (timer2) then
    		timer.cancel( timer2 )
    	end
    	if (timer3) then
    		timer.cancel( timer3 )
    	end
    	if (timer4) then
    		timer.cancel( timer4 )
    	end
    	if (timer5) then
    		timer.cancel( timer5 )
    	end
    	if (timer6) then
    		timer.cancel( timer6)
    	end
    	if (timer7) then
    		timer.cancel( timer7 )
    	end
    	if (timer8) then
    		timer.cancel( timer8 )
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
			logParams['name'] = "Spider in The Den"
			logParams['time'] = timeSpentTimerCount

			analytics.logEvent("TIME-SPENT-IN-GAME(Spider in The Den)", logParams)

			for i,v in pairs(logParams) do
			 	print(i, v)
			end
		end
		mydata.lastScene = "Spider in The Den"
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