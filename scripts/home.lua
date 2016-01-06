----------------------------------------------------------------------------------
--
-- home.lua
--
----------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local character
local star
display.setStatusBar( display.HiddenStatusBar )
system.setIdleTimer( false )
local physics=require("physics")
physics.start()
local mydata=require("scripts.mydata")
local availableChannel1
mydata.radio_click=1
mydata.radio_click_story=1
mydata.radio_click_game=1
mydata.radio_click_fav=1
mydata.play=0

local type1=mydata.type
local sheetInfo={}
local myImageSheet={}
local character={}
mydata.ongame={"scripts.scene1","scripts.scene3","scripts.game","scripts.scene2","scripts.spider_game","scripts.scene4"}
mydata.type2={"poem","game","story","poem","game","story","poem","game","story","poem","game","story","poem","game","story","poem","game","story","story","story","story","story","poem"}
mydata.scene1={"scripts.poem","scripts.scene1","scripts.story","scripts.poem","scripts.scene3","scripts.story","scripts.poem","scripts.game","scripts.story","scripts.poem","scripts.scene2","scripts.story","scripts.poem","scripts.spider_game","scripts.story","scripts.poem","scripts.scene4","scripts.story","scripts.story","scripts.story","scripts.story","scripts.story","scripts.poem"}
mydata.currentscene=1
local n=1
local down_phase=0
local current_images={}
local current_icons={}
local current_titles={}
local fav_inactive={}
local home_lock={}
local tick={}
local notification={}
local movedX=0
local movedX=0
local nImages = 23
local locks={}
local images = {}
local images1 = {}
local image1={}
local image2={}
local title1={}
local frames={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"}
local masks={}
local click=0
local p=0
local onhome=0
local img={"scroll.png","scroll.png","scroll.png","scroll.png","scroll.png","scroll.png","scroll.png","scroll.png","scroll.png","scroll.png","scroll.png"}
local t={"The Maker of Light","Naming The Animals","The Man From Dust","The Giver of Hope","Tug of War","The Rescuer Who Commanded The Sea","The Winner of Battles","Slingshot War","The Warrior and the Giant","The Bringer of Peace","Princess Coloring Book","The Peacemaker and the King's Throne","The Answerer of Prayers","Spider in The Den","A Hero Escapes Death","The Good News","Heaven's Symphony","The Man from Heaven","The Rescuer Who Walked on the Sea","The Warrior on the Cross","A Hero Defeats Death","The Peacemaker and Heaven's Throne","God Loves You!"}
mydata.all_scenes={"The Maker of Light","Naming The Animals","The Man From Dust","The Giver of Hope","Tug of War","The Rescuer Who Commanded The Sea","The Winner of Battles","Slingshot War","The Warrior and the Giant","The Bringer of Peace","Princess Coloring Book","The Peacemaker and the King's Throne","The Answerer of Prayers","Spider in The Den","A Hero Escapes Death","The Good News","Heaven's Symphony","The Man from Heaven","The Rescuer Who Walked on the Sea","The Warrior on the Cross","A Hero Defeats Death","The Peacemaker and Heaven's Throne","God Loves You!"}

function handleButtonEvent1( event )
    if ( "ended" == event.phase ) then
		mydata.flag=0
		local options = {
						   	isModal = true,
						    effect = "fromRight",
						    time = 1000,
						    params = {
					        
					    			}
						}
		composer.showOverlay( "scripts.settings_overlay",options)
	end
end

function onSystemEvent1( event )
    if(event.type=="applicationResume" and (system.getInfo("platformName") == "Android")) then
       star.alpha = 0.1
    end
end
function scene:resume( )

end
function scene:on_radioButtonClick()
	mydata.previous=1
	if (mydata.type=="poem") then
		poem.alpha=1
		story.alpha=0
		game.alpha=0
		favorites.alpha=0
	else
		poem.alpha=0
		story.alpha=0
		game.alpha=0
		favorites.alpha=0
	end
	for i=1,nImages do
		if (current_titles[i]) then
			current_titles[i]:removeSelf( )
			current_titles[i]=nil
			current_images[i]:removeSelf( )
			current_images[i]=nil
		end
		if (current_icons[i]) then
			current_icons[i]:removeSelf( )
			current_icons[i]=nil
			home_lock[i]:removeSelf( )
			home_lock[i]=nil
		end
	end
	set_menu()
end
function scene:on_radioButtonClick1(event)
	mydata.previous=1
	if (mydata.type=="story") then
		poem.alpha=0
		story.alpha=1
		game.alpha=0
		favorites.alpha=0
	else
		poem.alpha=0
		story.alpha=0
		game.alpha=0
		favorites.alpha=0
	end
	for i=1,nImages do
		if (current_titles[i]) then
			current_titles[i]:removeSelf( )
			current_titles[i]=nil
			current_images[i]:removeSelf( )
			current_images[i]=nil
		end
		if (current_icons[i]) then
			current_icons[i]:removeSelf( )
			current_icons[i]=nil
			home_lock[i]:removeSelf( )
			home_lock[i]=nil
		end
	end
	set_menu()
end
function scene:on_radioButtonClick2(event)
	mydata.previous=1
	if (mydata.type=="game") then
		poem.alpha=0
		story.alpha=0
		game.alpha=1
		favorites.alpha=0
	else
		poem.alpha=0
		story.alpha=0
		game.alpha=0
		favorites.alpha=0
	end
	for i=1,nImages do
		if (current_titles[i]) then
			current_titles[i]:removeSelf( )
			current_titles[i]=nil
			current_images[i]:removeSelf( )
			current_images[i]=nil
		end
		if (current_icons[i]) then
			current_icons[i]:removeSelf( )
			current_icons[i]=nil
			home_lock[i]:removeSelf( )
			home_lock[i]=nil
		end
	end
	set_menu()
end
function scene:on_radioButtonClick3(event)
	mydata.previous=1
	if (mydata.type=="fav") then
		poem.alpha=0
		story.alpha=0
		game.alpha=0
		favorites.alpha=1
	else
		poem.alpha=0
		story.alpha=0
		game.alpha=0
		favorites.alpha=0
	end
	for i=1,nImages do
		if (current_titles[i]) then
			current_titles[i]:removeSelf( )
			current_titles[i]=nil
			current_images[i]:removeSelf( )
			current_images[i]=nil
		end
		if (current_icons[i]) then
			current_icons[i]:removeSelf( )
			current_icons[i]=nil
			home_lock[i]:removeSelf( )
			home_lock[i]=nil
		end
	end
	if (mydata.type=="fav") then
		set_menu_fav()
	else
		set_menu()
	end
end
function set_menu()
 	count=0
	for i=1,nImages do
		if (mydata.type==mydata.type2[i] or mydata.type=="all") then
			count=count+1
		 	rect = display.newImageRect("assets/images/scroll.png",display.contentWidth*.42,display.contentWidth*.42)
	 		if(count<mydata.previous)then
				rect.x=display.contentCenterX -((display.contentWidth/2.2)*(mydata.previous-count))
			else
				rect.x=display.contentCenterX + ((display.contentWidth/2.2)*(count-mydata.previous))
			end
			rect.y=display.contentCenterY--display.contentCenterY/10
			rect.anchorX = 0.5
			rect.anchorY = 0.5
			rect.id=i
			rect.xScale=display.contentCenterX*1.4/(rect.x)
			rect.yScale=display.contentCenterX*1.4/(rect.x)
			rect.type=mydata.type

			current_images[count]=rect
			sceneGroup:insert(current_images[count])
			if (mydata.lock[i]==1) then
			
			else
				--rect.fill.effect = "filter.grayscale"
			end
		end
	end
	count=0
	for i=1,nImages do
		if (mydata.type==mydata.type2[i] or mydata.type=="all" ) then
			count=count+1
			if (count==1) then
	 			sheetInfo111 = require("scripts.star_gold")
			 	myImageSheet111 = graphics.newImageSheet( "assets/images/star_gold.png", sheetInfo111:getSheet() )
		 		sequenceData111={
            					{ name="seq1", sheet=myImageSheet111, start=1, count=56, time=1000,loopCount=1 },
          						}
             	star=display.newSprite( myImageSheet111, sequenceData111)
             	star.x=display.contentCenterX
             	star.y=current_images[count].y
             	star.alpha=0
             	star.xScale=.5
             	star.yScale=.5
             	sceneGroup:insert(star)
             	--[[glow= display.newRect( 0, 0, 160, 160 )
	         	glow.x=display.contentCenterX
		        glow.y=current_images[count].y
	         	sceneGroup:insert(glow)--]]
			end
	 		rect1 = display.newImageRect( myImageSheet, sheetInfo:getFrameIndex(frames[i]), 100, 100 )
	 		if (count<mydata.previous)then
				rect1.x=display.contentCenterX-((display.contentWidth/2.2)*(mydata.previous-count))
			else
				rect1.x=display.contentCenterX+ ((display.contentWidth/2.2)*(count-mydata.previous))
			end
			if (display.contentHeight==320 and display.contentWidth==480) then
			   	 	rect1.xScale=current_images[count].xScale--display.contentHeight*1.6/(current_icons[i].x)
					rect1.yScale=current_images[count].xScale--display.contentHeight*1.6/(current_icons[i].x)
				elseif(display.contentHeight==360 and display.contentWidth==480)then
					rect1.xScale=current_images[count].xScale*1.1--display.contentHeight*1.6/(current_icons[i].x)
					rect1.yScale=current_images[count].xScale*1.1--display.contentHeight*1.6/(current_icons[i].x)
				else
					rect1.xScale=current_images[count].xScale*1.2--display.contentHeight*1.6/(current_icons[i].x)
					rect1.yScale=current_images[count].xScale*1.2--display.contentHeight*1.6/(current_icons[i].x)
				end
			rect1.y=display.contentCenterY-display.contentCenterY*rect1.yScale/13
			rect1.id=i
			rect1.type=mydata.type
			rect1.cnt=count
			current_icons[count]=rect1
			sceneGroup:insert(current_icons[count])
			local options = {
						   text = t[i],
						   x = rect1.x,
						   y = display.contentCenterY+display.contentCenterY/2.1,
						   width = 110,
						   font="Averia",
						   fontSize = 10,
						   align = "center",
							}
		 	ttl=display.newText(options)
			ttl.xScale=display.contentCenterX*1.4/(ttl.x)
			ttl.yScale=display.contentCenterX*1.4/(ttl.x)
			ttl.id=i
			ttl.anchorY=0.5
			ttl:setFillColor( .60784,.21568,.019607)
			ttl.type=mydata.type
			current_titles[count]=ttl
			sceneGroup:insert(current_titles[count])
			lk= display.newImageRect("assets/images/lock_icon.png",display.contentWidth*.1/2,display.contentWidth*.15/2)
			if (count<mydata.previous)then
				lk.x=display.contentCenterX-((display.contentWidth/2.2)*(mydata.previous-count))
			else
				lk.x=display.contentCenterX+ ((display.contentWidth/2.2)*(count-mydata.previous))
			end
			lk.xScale=display.contentCenterX*1.65/(lk.x)
			lk.yScale=display.contentCenterX*1.65/(lk.x)
			lk.y=display.contentCenterY-display.contentCenterY*lk.yScale/13
			lk.id=i
			lk.type=mydata.type
			lk.cnt=count
			home_lock[count]=lk
			rect1:addEventListener( "tap", onTap )
			sceneGroup:insert(home_lock[count])
			if (mydata.lock[i]==1) then
				lk.alpha=0

			else
								ttl.fill.effect = "filter.grayscale"
								rect1.fill.effect = "filter.grayscale"
								lk.alpha=1

			end
		end
	end
end
function set_menu_fav()
	count=0
	for i=1,nImages do
		if (mydata.type=="fav" or mydata.type=="all") then
			--for j=1,#mydata.fave do
				if (mydata.fave[i].id==1)then
     				count=count+1
	 				rect = display.newImageRect('assets/images/scroll.png',display.contentWidth*.42,display.contentWidth*.42)
	 				if(count<mydata.previous)then
						rect.x=display.contentCenterX -((display.contentWidth/2.2)*(mydata.previous-count))
					else
						rect.x=display.contentCenterX + ((display.contentWidth/2.2)*(count-mydata.previous))
					end
					rect.y=display.contentCenterY
					rect.anchorX = 0.5
					rect.anchorY = 0.5
					rect.id=i
					rect.xScale=display.contentCenterX*1.4/(rect.x)
					rect.yScale=display.contentCenterX*1.4/(rect.x)
					rect.type=mydata.type
					current_images[count]=rect
					sceneGroup:insert(current_images[count])
				end
			--end
		end
	end
	count=0
	for i=1,nImages do
		if (mydata.type=="fav" or mydata.type=="all" ) then
			--for j=1,#mydata.fave do
				if(mydata.fave[i].id==1)then
					count=count+1
					if (count==1) then
		 				sheetInfo111 = require("scripts.star_gold")
			 			myImageSheet111 = graphics.newImageSheet( "assets/images/star_gold.png", sheetInfo111:getSheet() )
			 			sequenceData111 = 	{
                							{ name="seq1", sheet=myImageSheet111, start=1, count=56, time=2000,loopCount=1 },
          									}
				        star=display.newSprite( myImageSheet111, sequenceData111)
				        star.x=display.contentCenterX
				        star.y=current_images[count].y
				        star.alpha=0
				        star.xScale=.5
				        star.yScale=.5
			         	sceneGroup:insert(star)
			         	--[[glow= display.newRect( preview, 0, 0, 160, 160 )
			         	glow.x=display.contentCenterX
				        glow.y=current_images[count].y
			         	sceneGroup:insert(glow)--]]
					end
	 				rect1 = display.newImageRect( myImageSheet, sheetInfo:getFrameIndex(frames[i]), 100, 100 )
 					if (count<mydata.previous)then
						rect1.x=display.contentCenterX-((display.contentWidth/2.2)*(mydata.previous-count))
					else
						rect1.x=display.contentCenterX+ ((display.contentWidth/2.2)*(count-mydata.previous))
					end	
					if (display.contentHeight==320 and display.contentWidth==480) then
			   	 	rect1.xScale=current_images[count].xScale--display.contentHeight*1.6/(current_icons[i].x)
					rect1.yScale=current_images[count].xScale--display.contentHeight*1.6/(current_icons[i].x)
				elseif(display.contentHeight==360 and display.contentWidth==480)then
					rect1.xScale=current_images[count].xScale*1.1--display.contentHeight*1.6/(current_icons[i].x)
					rect1.yScale=current_images[count].xScale*1.1--display.contentHeight*1.6/(current_icons[i].x)
				else
					rect1.xScale=current_images[count].xScale*1.2--display.contentHeight*1.6/(current_icons[i].x)
					rect1.yScale=current_images[count].xScale*1.2--display.contentHeight*1.6/(current_icons[i].x)
				end
					rect1.y=display.contentCenterY-display.contentCenterY*rect1.yScale/13
					rect1.id=i
					rect1.type=mydata.type
					rect1.cnt=count
					
					current_icons[count]=rect1
					sceneGroup:insert(current_icons[count])
					local options = {
								   text = t[i],
								   x = rect1.x,
								   y =display.contentCenterY+display.contentCenterY/2.1,
								   width = 110,
								   font="Averia",
								   fontSize = 10,
								   align = "center",
									}
					ttl=display.newText(options)
					ttl.xScale=display.contentCenterX*1.4/(ttl.x)
					ttl.yScale=display.contentCenterX*1.4/(ttl.x)
					ttl.id=i
					ttl.anchorY=0.5
					ttl:setFillColor( .60784,.21568,.019607)
					ttl.type=mydata.type
					current_titles[count]=ttl
					
					sceneGroup:insert(current_titles[count])
					lk= display.newImageRect("assets/images/lock_icon.png",display.contentWidth*.1/2,display.contentWidth*.15/2)
			if (count<mydata.previous)then
				lk.x=display.contentCenterX-((display.contentWidth/2.2)*(mydata.previous-count))
			else
				lk.x=display.contentCenterX+ ((display.contentWidth/2.2)*(count-mydata.previous))
			end
			lk.xScale=display.contentCenterX*1.65/(lk.x)
			lk.yScale=display.contentCenterX*1.65/(lk.x)
			lk.y=display.contentCenterY-display.contentCenterY*lk.yScale/13
			lk.id=i
			lk.type=mydata.type
			lk.cnt=count
			home_lock[count]=lk
			rect1:addEventListener( "tap", onTap )
			sceneGroup:insert(home_lock[count])
			if (mydata.lock[i]==1) then
				lk.alpha=0
			else
								ttl.fill.effect = "filter.grayscale"
								rect1.fill.effect = "filter.grayscale"
								lk.alpha=1


			end
     			end     
			--end
		end
	end
end
function scene:mutelistener(event)
	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=1})
	else
		audio.setVolume(0.0,{channel=1})
	end
end
local function spriteListener( event )

end
function scene:create( event )
	audio.stop()
	bgm=audio.loadStream("assets/audio/menu.mp3")
	bgm1=audio.play( bgm, { channel=1, loops=-1} )
	audio.setVolume(1.0,{channel=1})
	sceneGroup = self.view
	background=display.newImageRect("assets/images/bg2.jpg",display.contentWidth,display.contentHeight+display.contentHeight/10)
	background.anchorX = 1
	background.anchorY = 0.5
	background.x=display.contentWidth
	background.y=display.contentCenterY
	sceneGroup:insert(background) 
	story=display.newImageRect("assets/images/story_heatched.png",display.contentHeight*5.4/8,display.contentHeight/8)
	story.x=display.contentCenterX
	story.y=display.contentCenterY
	if(mydata.type=="story")then
		story.alpha=1
	else
		story.alpha=0
	end
	sceneGroup:insert(story)
	poem=display.newImageRect("assets/images/poem_heatched.png",display.contentHeight*4.43/8,display.contentHeight/8)
	poem.x=display.contentCenterX
	poem.y=display.contentCenterY
	if(mydata.type=="poem")then
		poem.alpha=1
	else
		poem.alpha=0
	end
	sceneGroup:insert(poem)
	game=display.newImageRect("assets/images/game_heatched.png",display.contentHeight*4.675/8,display.contentHeight/8)
	game.x=display.contentCenterX
	game.y=display.contentCenterY
	if(mydata.type=="game")then
		game.alpha=1
	else
		game.alpha=0
	end
	sceneGroup:insert(game)
	favorites=display.newImageRect("assets/images/favorites_heatched.png",display.contentHeight*7.98/8,display.contentHeight/8)
	favorites.x=display.contentCenterX
	favorites.y=display.contentCenterY
	if(mydata.type=="fav")then
		favorites.alpha=1
	else
		favorites.alpha=0
	end
	sceneGroup:insert(favorites)
	sheetInfo = require("scripts.menu_sprite")
 	myImageSheet = graphics.newImageSheet( "assets/images/menu_sprite.png", sheetInfo:getSheet() )
	button1 = widget.newButton
			{
			    width = display.contentHeight/10,
			    height = display.contentHeight/11,
			    defaultFile = "assets/images/button_1.png",
			    overFile = "assets/images/button_2.png",
			   	onEvent = handleButtonEvent1,
			}
	button1.x = (display.contentWidth-button1.contentWidth/2)-15
	button1.y =(button1.contentHeight/2)+15
	button1.xScale=1.8
	button1.yScale=1.8
	sheetInfo_control = require("scripts.controll_icons")
 	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
 	settings = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("menu"), 21,21)
	settings.x=button1.x
	settings.y=button1.y-5
	settings.xScale=1
	settings.yScale=1	
	sceneGroup:insert( button1 )
	sceneGroup:insert( settings )
	onhome=1
	sequenceData = {
					   name = "balls",
					   start = 3,
					   count = 8,
					}
	local counter = 1
	if (mydata.type=="fav") then
		set_menu_fav()
	else
		set_menu()
	end
	if (mydata.music_status==1) then
		audio.setVolume(1.0,{channel=1})
	else
		audio.setVolume(0.0,{channel=1})
	end
end

function play()

end

function listener1()
  	
end
local function scale(event )
	for i=1,#current_images do
		if (current_icons[i].x~=nil) then
			if (current_images[i].x>display.contentCenterX) then
				current_images[i].xScale=display.contentCenterX*1.4/(current_images[i].x)
				current_images[i].yScale=display.contentCenterX*1.4/(current_images[i].x)
				if (display.contentHeight==320 and display.contentWidth==480) then
			   	 	current_icons[i].xScale=current_images[i].xScale--display.contentHeight*1.6/(current_icons[i].x)
					current_icons[i].yScale=current_images[i].xScale--display.contentHeight*1.6/(current_icons[i].x)
				elseif(display.contentHeight==360 and display.contentWidth==480)then
					current_icons[i].xScale=current_images[i].xScale*1.1--display.contentHeight*1.6/(current_icons[i].x)
					current_icons[i].yScale=current_images[i].xScale*1.1--display.contentHeight*1.6/(current_icons[i].x)
				else
					current_icons[i].xScale=current_images[i].xScale*1.2--display.contentHeight*1.6/(current_icons[i].x)
					current_icons[i].yScale=current_images[i].xScale*1.2--display.contentHeight*1.6/(current_icons[i].x)
				end
				current_icons[i].y=display.contentCenterY-display.contentCenterY*current_icons[i].yScale/13
				home_lock[i].xScale=display.contentCenterX*1.65/(home_lock[i].x)
				home_lock[i].yScale=display.contentCenterX*1.65/(home_lock[i].x)
				home_lock[i].y=display.contentCenterY-display.contentCenterY*home_lock[i].yScale/13
				current_titles[i].xScale=display.contentCenterX*1.4/(current_images[i].x)
				current_titles[i].yScale=display.contentCenterX*1.4/(current_images[i].x)
				current_titles[i].y=display.contentCenterY+display.contentWidth*current_images[i].yScale/10
				home_lock[i].rotation=0
			else
				current_images[i].xScale=display.contentCenterX*1.4/(display.contentWidth-current_images[i].x)
				current_images[i].yScale=display.contentCenterX*1.4/(display.contentWidth-current_images[i].x)
				if (display.contentHeight==320 and display.contentWidth==480) then
			   	 	current_icons[i].xScale=current_images[i].xScale--display.contentHeight*1.6/(current_icons[i].x)
					current_icons[i].yScale=current_images[i].xScale--display.contentHeight*1.6/(current_icons[i].x)
				elseif(display.contentHeight==360 and display.contentWidth==480)then
					current_icons[i].xScale=current_images[i].xScale*1.1--display.contentHeight*1.6/(current_icons[i].x)
					current_icons[i].yScale=current_images[i].xScale*1.1--display.contentHeight*1.6/(current_icons[i].x)
				else
					current_icons[i].xScale=current_images[i].xScale*1.2--display.contentHeight*1.6/(current_icons[i].x)
					current_icons[i].yScale=current_images[i].xScale*1.2--display.contentHeight*1.6/(current_icons[i].x)
				end
				current_icons[i].y=display.contentCenterY-display.contentCenterY*current_icons[i].yScale/13--display.contentHeight/15
				home_lock[i].xScale=display.contentCenterX*1.65/(display.contentWidth-home_lock[i].x)
				home_lock[i].yScale=display.contentCenterX*1.65/(display.contentWidth-home_lock[i].x)
				home_lock[i].y=display.contentCenterY-display.contentCenterY*home_lock[i].yScale/13
				current_titles[i].xScale=display.contentCenterX*1.4/(display.contentWidth-current_images[i].x)
				current_titles[i].yScale=display.contentCenterX*1.4/(display.contentWidth-current_images[i].x)
				current_titles[i].y=display.contentCenterY+display.contentWidth*current_images[i].yScale/10--display.contentHeight/15
				home_lock[i].rotation=0
			end
		end
	
	end
end
local function onTouch(self, event)
	j=0
	if event.phase == "began" then
		for i=1,#current_images do
			--current_icons[i]:removeEventListener( "tap", onTap )
		end
		ti=event.time	
		startX = event.x
		startY= event.y
		for i=1,#current_images do
			if (current_icons[i].x~=nil) then
				image1[i]=current_images[i].x
				image2[i]=current_icons[i].x
				title1[i]=current_titles[i].x
				locks[i]=home_lock[i].x
			end
		end
	elseif event.phase == "moved" then
		movedX = event.x - event.xStart
		movedY = event.y - event.yStart
		if (movedX~=nil) then
			if (movedX>20 or movedX<-20) then
				transition.cancel( )
			end
		end
		for i=1,#current_images do
			if (movedX~=nil) then
				if (movedX>20 or movedX<-20) then
					if (current_icons[i].x~=nil and image1[i]~=nil ) then
						current_images[i].x=image1[i]+movedX*1.5
						current_icons[i].x=image2[i]+movedX*1.5
						current_titles[i].x=title1[i]+movedX*1.5
						home_lock[i].x=locks[i]+movedX*1.5
					end
				end
			end
		end
	elseif event.phase == "ended" then
		ti2=event.time
		center=0
		center1=00
		dir=2
		k=0
		ic=0
		if (movedX~=nil and movedX>20 or movedX<-20) then
			for i=1,#current_images do
				if (current_images[i].x>display.contentCenterX and movedX>0) then
					center=current_images[i].x-display.contentCenterX	
					dir=1
					k=k+1
					if (k==1) then
						center1=center
						ic=i
					end
					if (center<center1) then
						center1=center
						ic=i
					end
				end
			end
			for i=1,#current_images do
				if ( current_images[i].x<display.contentCenterX and movedX<0) then
					center=display.contentCenterX-current_images[i].x
					dir=0
					k=k+1
					if (k==1) then
						center1=center
						ic=i
					end
					if (center<center1) then
						center1=center
						ic=i
					end
				end
			end
		end
		if (ti2 and movedX and ti) then
			if (movedX>10) then
				if (ti2-ti<100 and ti2-ti>20 and ic>5 ) then
					j=1
				end
				if (ti2-ti<100 and ti2-ti>20  and ic>4 ) then
					j=1
				end
				if (ti2-ti<100 and ti2-ti>20  and ic>3 ) then
					j=1
				end
			end
			if (movedX<-10) then
				if (ti2-ti<100 and ti2-ti>20  and ic<12 ) then
					j=1
				end
				if (ti2-ti<100 and ti2-ti>20  and ic<13 ) then
					j=1
				end
				if (ti2-ti<100 and ti2-ti>20 and ic<14) then
					j=1
				end
			end
		end
		ti=0
		ti2=0
		movedX=0
		movedY=0
		if (dir==1 and ic~=0 and center1~=0) then
			for i=1,#current_images do
				if (ic~=1 ) then
					transition.to( current_images[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(ic-1-j)), transition=easing.outExpo } )
					transition.to( current_icons[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(ic-1-j)), transition=easing.outExpo } )
					transition.to( current_titles[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(ic-1-j)), transition=easing.outExpo } )
					transition.to( home_lock[i], {time=3000,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(ic-1-j)), transition=easing.outExpo } )

				else
					transition.to( current_images[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(ic)), transition=easing.outExpo } )
					transition.to( current_icons[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(ic)), transition=easing.outExpo } )
					transition.to( current_titles[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(ic)), transition=easing.outExpo } )
					transition.to( home_lock[i], {time=3000,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(ic)), transition=easing.outExpo } )
				end
			end
		end
		if (dir==0 and ic~=0 and center1~=0) then
			for i=1,#current_images do
				if (ic~=#current_images) then
					transition.to( current_images[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((ic+1+j)-i), transition=easing.outExpo } )
					transition.to( current_icons[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((ic+1+j)-i), transition=easing.outExpo } )
					transition.to(current_titles[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((ic+1+j)-i), transition=easing.outExpo } )
					transition.to( home_lock[i], {time=3000,x=display.contentCenterX-(display.contentWidth/2.2)*((ic+1+j)-i), transition=easing.outExpo } )
				else
					transition.to( current_images[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((ic)-i), transition=easing.outExpo } )
					transition.to( current_icons[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((ic)-i), transition=easing.outExpo } )
					transition.to(current_titles[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((ic)-i), transition=easing.outExpo } )
					transition.to( home_lock[i], {time=3000,x=display.contentCenterX-(display.contentWidth/2.2)*((ic)-i), transition=easing.outExpo } )
				end
			end
		end
		for i=1,#current_images do
			if (current_icons[i] and mydata.lock[current_icons[i].id]==1) then
				--current_icons[i]:addEventListener( "tap", onTap )
			end
		end
	end
end
function onTap(event)
	ic=event.target.id
	mydata.currentscene=ic
	cnt=event.target.cnt
	if(mydata.type=="fav") then
		local j=0
		mydata.cfavorite=cnt
		for i=1,#mydata.fave do
			if(mydata.fave[i].id==1)then
				j=j+1
				mydata.onfavorite_name[j]=mydata.scene1[i]
				mydata.onfavorite_type[j]=mydata.fave[i].type
				mydata.onfavorite_index[j]=mydata.fave[i].index
				mydata.favlength=j
			end
		end
	end
	mydata.previous=cnt
	if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20 and mydata.lock[ic]==1) then
		audio.stop()
		for i=1,#current_icons do
			if (current_icons[i]~=nil) then
				current_icons[i]:removeEventListener( "tap", onTap )
			end
		end
		Runtime:removeEventListener("touch",sceneGroup)
		button1:setEnabled( false )
		local function chng(sceneName)
			star:pause()
			star.alpha=0
			composer.removeHidden()
			composer.gotoScene(sceneName,{effect="fade"})
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==3) then
			mydata.cbg=1
			mydata.dir=1
			star.alpha=1
			star:play()
			mydata.story=1
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==6) then
			mydata.cbg=2
			mydata.dir=0
			mydata.story=2
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==9) then
			mydata.cbg=3
			mydata.dir=1
			mydata.story=3
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==12) then
			mydata.cbg=4
			mydata.dir=0
			mydata.story=4
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==15) then
			mydata.cbg=5
			mydata.dir=1
			mydata.story=5
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==18) then
			mydata.cbg=6
			mydata.dir=0
			mydata.story=6
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==19) then
			mydata.cbg=7
			mydata.dir=1
			mydata.story=7
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==20) then
			mydata.cbg=8
			mydata.dir=0
			mydata.story=8
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==21) then
			mydata.cbg=9
			mydata.dir=1
			mydata.story=9
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==22) then
			mydata.cbg=10
			mydata.dir=0
			mydata.story=10
			star.alpha=1
			star:play()
			change_story()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==1) then
			mydata.cbg=1
			mydata.dir=1
			mydata.poem=1
			star.alpha=1
			star:play()
			change_poem()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==4) then
			mydata.cbg=2
			mydata.dir=0
			mydata.poem=2
			star.alpha=1
			star:play()
			change_poem()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==7) then
			mydata.cbg=3
			mydata.dir=1
			mydata.poem=3
			star.alpha=1
			star:play()
			change_poem()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==10) then
			mydata.cbg=4
			mydata.dir=0
			mydata.poem=4
			star.alpha=1
			star:play()
			change_poem()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==13) then
			mydata.cbg=5
			mydata.dir=1
			mydata.poem=5
			star.alpha=1
			star:play()
			change_poem()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==16) then
			mydata.cbg=6
			mydata.dir=0
			mydata.poem=6
			star.alpha=1
			star:play()
			change_poem()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==23) then
			mydata.cbg=1
			mydata.dir=1
			mydata.poem=7
			star.alpha=1
			star:play()
			change_poem()
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==2) then
			star.alpha=1
			star:play()
			mydata.game=1
			timer.performWithDelay( 500, function() chng("scripts.scene1") end)
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==5) then
			star.alpha=1
			star:play()
			mydata.game=2
			timer.performWithDelay( 500, function() chng("scripts.scene3") end)
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==8) then
			star.alpha=1
			star:play()
			mydata.game=3
			timer.performWithDelay( 500, function() chng("scripts.game") end)
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==14) then
			star.alpha=1
			star:play()
			mydata.game=4
			timer.performWithDelay( 500, function() chng("scripts.spider_game") end)
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==11) then
			star.alpha=1
			star:play()
			mydata.game=5
			timer.performWithDelay( 500, function() chng("scripts.scene2") end)
		end
		if (event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20  and ic==17) then
			star.alpha=1
			star:play()
			mydata.game=6
			timer.performWithDelay( 500, function() chng("scripts.scene4") end)
		end
	elseif(event.target.x>display.contentCenterX-20 and event.target.x<display.contentCenterX+20 and mydata.lock[ic]==0)then
		--local listener2 = function()
			--transition.to( home_lock[cnt], { time=1000, delay=0, alpha=1.0,xScale=1.0,yScale=1.0} )
		--end
		--transition.to( home_lock[cnt], { time=1000, delay=250, alpha=1.0,xScale=3.0,yScale=3.0,onComplete=listener2} )
		trn=1
	function rotate()

		if(trn==1)then
		home_lock[cnt].rotation=-10
		trn=0
		else
		home_lock[cnt].rotation=10
		trn=1
		end
	end
	timer.performWithDelay( 30, rotate ,15)
	local options = {
					    isModal = true,
					    effect = "fade",
					    time = 500,
					    params = {
					        
					    }
					}
	composer.showOverlay("scripts.exit",options)

	end
	if (event.x>display.contentCenterX-100  ) then
		for i=1,#current_images do
			transition.to( current_images[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((cnt)-i), transition=easing.outExpo } )
			transition.to( current_icons[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((cnt)-i), transition=easing.outExpo } )
			transition.to( current_titles[i], {time=3000, alpha=1,x=display.contentCenterX-(display.contentWidth/2.2)*((cnt)-i), transition=easing.outExpo } )
			transition.to( home_lock[i], {time=3000,x=display.contentCenterX-(display.contentWidth/2.2)*((cnt)-i), transition=easing.outExpo } )
		end
	end
	if (event.x<display.contentCenterX+100) then
		for i=1,#current_images do
			transition.to(current_images[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(cnt)), transition=easing.outExpo } )
			transition.to( current_icons[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(cnt)), transition=easing.outExpo } )
			transition.to(current_titles[i], {time=3000, alpha=1,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(cnt)), transition=easing.outExpo } )
			transition.to( home_lock[i], {time=3000,x=display.contentCenterX+(display.contentWidth/2.2)*(i-(cnt)), transition=easing.outExpo } )
		end
	end
end

function change_story()
	local function change()
		star:pause()
		star.alpha=0
		composer.removeHidden()
		local storyIndex = mydata.story
		if (storyIndex ~= 1) then
			
			print ("File path ==".."story"..storyIndex.."/story"..storyIndex.."_sheet_1.png")
			local filePath = system.pathForFile("story"..storyIndex.."/story"..storyIndex.."_sheet_1.png", system.DocumentsDirectory)
			if (filePath) then
				local fileHandler = io.open( filePath )
				-- Determine if file exists
				if fileHandler then
				   print( "File exists" )
				   io.close( fileHandler )
				   composer.gotoScene("scripts.story",{effect="fade"});
				else
				   print( "File does not exist!" )
				   composer.gotoScene("scripts.download", {effect="fade", params={currentStory=storyIndex}, })
				end
				
			end
		else
			composer.gotoScene("scripts.story",{effect="fade"})
		end	
			
		
			
		--composer.gotoScene("scripts.story",{effect="fade"})
		--composer.gotoScene("scripts.download",{effect="fade"})
	end
	timer.performWithDelay( 500, change)
end
function change_poem()
	local function change()
		star:pause()
		star.alpha=0
		composer.removeHidden()
		composer.gotoScene("scripts.poem",{effect="fade"})
	end
	timer.performWithDelay( 500, change)
end
function backkey()
end
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if phase == "will" then

	elseif phase == "did" then
		mydata.scene_show=true
		sceneGroup.touch = onTouch
		Runtime:addEventListener("touch", sceneGroup)
		Runtime:addEventListener( "enterFrame", scale )
		Runtime:addEventListener( "system", onSystemEvent1 )
		playsound=timer.performWithDelay( 1, play )
	end	
end
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	if event.phase == "will" then
		mydata.scene_show=false
		Runtime:removeEventListener("touch", sceneGroup)
		Runtime:removeEventListener( "enterFrame", scale )
		Runtime:removeEventListener("system", onSystemEvent1 )
		audio.dispose( bgm)
		bgm=nil
		if (playsound) then
			timer.cancel( playsound )
		end
	elseif phase == "did" then
		transition.cancel( )
	end	
end
function scene:destroy( event )
	local sceneGroup = self.view
	-- e.g. remove display backgrounds, remove touch listeners, save state, etc.
end
---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------
return scene