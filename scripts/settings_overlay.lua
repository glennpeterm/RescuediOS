local composer = require( "composer" )
local scene = composer.newScene()
local parent1 
local mydata=require("scripts.mydata")
local click_indicator=0
local json = require("json")
local jsn=require("scripts.jsn")
local widget=require("widget")
local about_bg, credit_bg
local musicOnBg, narrationOnBg
local  moreHoldTimer=0
local onscroll=0
function closeWindow(event)
	if (event.phase=="began") then
		--rect:addEventListener("touch", close_function)

	end
	if (event.phase=="ended") then
		--if (scrollView.alpha == 1) then
			scrollView.alpha=0
			closeButton.alpha=0
		creditbg.alpha=0
		headertext.alpha=0
		headertext1.alpha=0
		narrationOnBg:addEventListener( "touch",narrationcontrol )
		musicOnBg:addEventListener("touch", soundcontrol)
		Rate_bg:addEventListener( "touch", on_rate_click )
		all_ntf:addEventListener( "touch", on_radioButtonClick4 )
		favorite_ntf:addEventListener( "touch", on_radioButtonClick3 )
		game_ntf:addEventListener( "touch", on_radioButtonClick2 )
		poem_ntf:addEventListener( "touch", on_radioButtonClick )
 		story_ntf:addEventListener( "touch", on_radioButtonClick1 )
		--end	
		
		
	end
	--return true
end	
function onbgtouch( event)
	return false
end
function close_rate(event)
	if (event.phase=="ended") then
		onscroll=1
	end
	
	end
function on_rate_click(event)
	local t=event.target
	if (event.phase=="began") then
		 --   rect:removeEventListener( "touch", close_function )
	narrationOnBg:removeEventListener( "touch",narrationcontrol )
	musicOnBg:removeEventListener("touch", soundcontrol)
	about_bg:removeEventListener( "touch", on_aboutclick )
	all_ntf:removeEventListener( "touch", on_radioButtonClick4 )
	favorite_ntf:removeEventListener( "touch", on_radioButtonClick3 )
	game_ntf:removeEventListener( "touch", on_radioButtonClick2 )
	poem_ntf:removeEventListener( "touch", on_radioButtonClick )
 	story_ntf:removeEventListener( "touch", on_radioButtonClick1 )
 	--Rate_bg:removeEventListener( "touch", on_rate_click )

	end
	--t.active = true
		if (event.phase=="ended") then

	--	local options =
	--{
   	--iOSAppId = "935644787",
   --	supportedAndroidStores = { "google","amazon"},
	--}
	--native.showPopup("rateApp", options)
	--t.active = false
		popupgroup.alpha=1
		onscroll=1
		-- circle:addEventListener("touch",Rate_bgListener)

	end
end
function Rate_bgListener1(event) 
	if (three) then
	timer.cancel(three)		
	end
end
function Rate_bgListener(event) 
    local t = event.target
    --if button is being held show hold 3 sec message 
    --and start 3 sec timer
    if event.phase == "began" then
    	
    	rect:removeEventListener( "touch", close_function )
       -- threeSeconds.alpha = 1
        t.active = true
        --Runtime:addEventListener( "enterFrame", Rate_bgCount )
    --if finger moves while holding button check to see if finger
     --is inside button bounds
    function pop()
    	--system.openURL( "itms-apps://itunes.com/apps/eggrollgames" )
     	   local options =
		{
	   	iOSAppId = "935644787",
	   	supportedAndroidStores = { "google","amazon"},
		}
		native.showPopup("rateApp", options)
	end
     three=timer.performWithDelay( 3000, pop )
    elseif event.phase == "moved" and t.active then
        --very specific bounds for my button, these bounds will 
        --vary with different shaped and sized buttons
      --  if event.x > Rate_bg.x – Rate_bg.width/2 + 6 and event.x < Rate_bg.width + 22 and event.y > Rate_bg.y – 22 and event.y < Rate_bg.y + Rate_bg.height/2 – 6 then
        --do nothing because the user is still within button bounds
      --  else
        --remove 3 sec timer, hide hold 3 sec message
        --and reset timer count to 0
       -- Runtime:removeEventListener( "enterFrame", Rate_bgCount )
      --  threeSeconds.alpha = 0
       moreHoldTimer = 0
      -- timer.cancel( three )
       -- end
    end 
    --if button is released or interrupted remove 3 sec timer,
    --hide hold 3 sec message and reset timer count to 0
    if event.phase == "ended" or event.phase == "cancelled" and t.active then
        t.active = false
        --Runtime:removeEventListener( "enterFrame", Rate_bgCount )
       -- threeSeconds.alpha = 0
        moreHoldTimer = 0
        timer.cancel( three )
          rect:addEventListener( "touch", close_function )

    end
end
 
-- 3 sec timer
function Rate_bgCount(event)
    --count up by 1 every frame 

    moreHoldTimer = moreHoldTimer + 1
    --if you have counted to 100 (roughly 3 seconds) without interruption
    --then you can perform the action
    if moreHoldTimer > 100 then
        --going to eggroll page, hide hold 3 sec message and reset timer
       -- system.openURL( "itms-apps://itunes.com/apps/eggrollgames" )
        ---threeSeconds= 0

        moreHoldTimer = 0
       local options =
	{
   	iOSAppId = "935644787",
   	supportedAndroidStores = { "google","amazon"},
	}
	native.showPopup("rateApp", options)
    end
end
function on_creditclick(event)
	if (event.phase=="ended") then
		multiText.alpha=0
		multiText1.alpha=1
		scrollView.alpha=0
		scrollView1.alpha=1
		scrollView1:scrollToPosition({ x = 0, y = 0, time = 10})
		closeButton.alpha=1
		creditbg.alpha=1
		headertext1.alpha=1
		headertext.alpha=1
	end
	return true
end
function on_aboutclick(event)
	if (event.phase=="began") then
		--rect:removeEventListener( "touch", close_function )
		narrationOnBg:removeEventListener( "touch",narrationcontrol )
		musicOnBg:removeEventListener("touch", soundcontrol)
		Rate_bg:removeEventListener( "touch", on_rate_click )
		all_ntf:removeEventListener( "touch", on_radioButtonClick4 )
		favorite_ntf:removeEventListener( "touch", on_radioButtonClick3 )
		game_ntf:removeEventListener( "touch", on_radioButtonClick2 )
		poem_ntf:removeEventListener( "touch", on_radioButtonClick )
 		story_ntf:removeEventListener( "touch", on_radioButtonClick1 )
 		--about_bg:removeEventListener( "touch", on_aboutclick )

	end
	if (event.phase=="ended") then
		scrollView.alpha=1
		scrollView:scrollToPosition({ x = 0, y = 0, time = 10})
		creditbg.alpha=1
		headertext1.alpha=1
		multiText1.alpha=1
				headertext.alpha=1
						closeButton.alpha=1


	end
	return true
end
function soundcontrol(event)
	if (event.phase=="ended") then
		if (mydata.music_status==1) then
			mydata.music_status=0
			parent1:mutelistener()
			transition.to( sound_control_stone, {x=sound_control.x+15,time=300})
		else
			mydata.music_status=1
			parent1:mutelistener()
			transition.to( sound_control_stone, {x=sound_control.x-15,time=300})
		end
		mydata.config[1]=mydata.music_status
		jsn.saveTable(mydata.config,"config.json")
	end
	return true
end
function narrationcontrol(event)
	if (event.phase=="ended") then
		if (mydata.narration_status==1) then
			mydata.narration_status=0
			transition.to( narration_control_stone, {x=narration_control.x+15,time=300})
		else
			mydata.narration_status=1
			transition.to( narration_control_stone, {x=narration_control.x-15,time=300})
		end
			mydata.config[2]=mydata.narration_status
			jsn.saveTable(mydata.config,"config.json")
	end
	return true
end
function close_function(event)
	if (event.phase=="began") then

	end
	if (event.phase=="ended") then
	if (onscroll==1) then
		popupgroup.alpha=0
		onscroll=0
		if (scrollView.alpha == 1) then
			scrollView.alpha=0
		end	
		
	narrationOnBg:addEventListener( "touch",narrationcontrol )
	musicOnBg:addEventListener("touch", soundcontrol)
	about_bg:addEventListener( "touch", on_aboutclick )
	all_ntf:addEventListener( "touch", on_radioButtonClick4 )
	favorite_ntf:addEventListener( "touch", on_radioButtonClick3 )
	game_ntf:addEventListener( "touch", on_radioButtonClick2 )
	poem_ntf:addEventListener( "touch", on_radioButtonClick )
 	story_ntf:addEventListener( "touch", on_radioButtonClick1 )
		

	else
		popupgroup.alpha=0
		transition.to( overlay_group, {x=display.contentWidth+bg.contentWidth,time=3000,delay=1} )
		function moveoverlay()
			composer.hideOverlay()
		end
		timer.performWithDelay( 800,moveoverlay )
 
	end
end
end
function on_radioButtonClick(event )
	if (event.phase=="ended") then
		mydata.clicktype=event.target.type
		story_ntf.fill.effect = "filter.desaturate"
       	story_ntf.fill.effect.intensity = 1
       	filter_story.fill.effect = "filter.desaturate"
		filter_story.fill.effect.intensity = 1
		filter_story.alpha=0
		game_ntf.fill.effect = "filter.desaturate"
		game_ntf.fill.effect.intensity = 1
		filter_game.fill.effect = "filter.desaturate"
		filter_game.fill.effect.intensity = 1
		filter_game.alpha=0
		favorite_ntf.fill.effect = "filter.desaturate"
		favorite_ntf.fill.effect.intensity = 1
		filter_fav.fill.effect = "filter.desaturate"
		filter_fav.fill.effect.intensity = 1
		filter_fav.alpha=0
		if (mydata.radio_click==1 ) then
			mydata.type=mydata.clicktype
			mydata.radio_click=0
			mydata.radio_click_story=1
			mydata.radio_click_game=1
			click_indicator=0
			poem_ntf.fill.effect = "filter.desaturate"
			poem_ntf.fill.effect.intensity = 0
			filter_poem.fill.effect = "filter.desaturate"
			filter_poem.fill.effect.intensity = 0
			filter_poem.alpha=1
			all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 1
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 1
		filter_all.alpha=0
		else
			mydata.type="all"
			mydata.radio_click=1
			mydata.radio_click_story=1
			mydata.radio_click_game=1
			click_indicator=1
			poem_ntf.fill.effect = "filter.desaturate"
			poem_ntf.fill.effect.intensity = 1
			filter_poem.fill.effect = "filter.desaturate"
			filter_poem.fill.effect.intensity = 1
			filter_poem.alpha=0
			all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 0
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 0
		filter_all.alpha=1
		end
		parent1:on_radioButtonClick()
	end
	return true
end
function on_radioButtonClick1(event )
	if (event.phase=="ended") then
		mydata.clicktype=event.target.type
		poem_ntf.fill.effect = "filter.desaturate"
		poem_ntf.fill.effect.intensity = 1
		filter_poem.fill.effect = "filter.desaturate"
		filter_poem.fill.effect.intensity = 1
		filter_poem.alpha=0
		game_ntf.fill.effect = "filter.desaturate"
		game_ntf.fill.effect.intensity = 1
		filter_game.fill.effect = "filter.desaturate"
		filter_game.fill.effect.intensity = 1
		filter_game.alpha=0
		favorite_ntf.fill.effect = "filter.desaturate"
		favorite_ntf.fill.effect.intensity = 1
		filter_fav.fill.effect = "filter.desaturate"
		filter_fav.fill.effect.intensity = 1
		filter_fav.alpha=0
		if (mydata.radio_click_story==1 ) then
			mydata.type=mydata.clicktype
			mydata.radio_click=1
			mydata.radio_click_story=0
			mydata.radio_click_game=1
			mydata.radio_click_fav=1
			click_indicator=0
			story_ntf.fill.effect = "filter.desaturate"
			story_ntf.fill.effect.intensity = 0
			filter_story.fill.effect = "filter.desaturate"
			filter_story.fill.effect.intensity = 0
			filter_story.alpha=1
			all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 1
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 1
		filter_all.alpha=0
		else
			mydata.type="all"
			click_indicator=1
			mydata.radio_click=1
			mydata.radio_click_story=1
			mydata.radio_click_game=1
			mydata.radio_click_fav=1
			story_ntf.fill.effect = "filter.desaturate"
			story_ntf.fill.effect.intensity = 1
			filter_story.fill.effect = "filter.desaturate"
			filter_story.fill.effect.intensity = 1
			filter_story.alpha=0
			all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 0
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 0
		filter_all.alpha=1
		end
		parent1:on_radioButtonClick1()
	end
	return true
end
function on_radioButtonClick2(event )
	if (event.phase=="ended") then
		mydata.clicktype=event.target.type
		story_ntf.fill.effect = "filter.desaturate"
		story_ntf.fill.effect.intensity = 1
		filter_story.fill.effect = "filter.desaturate"
		filter_story.fill.effect.intensity = 1
		filter_story.alpha=0
		favorite_ntf.fill.effect = "filter.desaturate"
		favorite_ntf.fill.effect.intensity = 1
		filter_fav.fill.effect = "filter.desaturate"
		filter_fav.fill.effect.intensity = 1
		filter_fav.alpha=0
		if (mydata.radio_click_game==1) then
			mydata.type=mydata.clicktype
			mydata.radio_click=1
			mydata.radio_click_story=1
			mydata.radio_click_game=0
			mydata.radio_click_fav=1
			click_indicator=0
			game_ntf.fill.effect = "filter.desaturate"
			game_ntf.fill.effect.intensity = 0
			filter_game.fill.effect = "filter.desaturate"
			filter_game.fill.effect.intensity = 0
			filter_game.alpha=1
			all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 1
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 1
		filter_all.alpha=0
		else
			mydata.type="all"
			click_indicator=1
			mydata.radio_click=1
			mydata.radio_click_story=1
			mydata.radio_click_game=1
			mydata.radio_click_fav=1
			game_ntf.fill.effect = "filter.desaturate"
			game_ntf.fill.effect.intensity = 1
			filter_game.fill.effect = "filter.desaturate"
			filter_game.fill.effect.intensity = 1
			filter_game.alpha=0
			all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 0
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 0
		filter_all.alpha=1
		end
		poem_ntf.fill.effect = "filter.desaturate"
		poem_ntf.fill.effect.intensity = 1
		filter_poem.fill.effect = "filter.desaturate"
		filter_poem.fill.effect.intensity = 1
		filter_poem.alpha=0
		parent1:on_radioButtonClick2()
	end
	return true
end
function on_radioButtonClick4(event )
	if (event.phase=="ended") then
		mydata.clicktype=event.target.type
		story_ntf.fill.effect = "filter.desaturate"
		story_ntf.fill.effect.intensity = 1
		filter_story.fill.effect = "filter.desaturate"
		filter_story.fill.effect.intensity = 1
		filter_story.alpha=0
		mydata.type="all"
		mydata.radio_click=1
		mydata.radio_click_story=1
		mydata.radio_click_fav=1
		mydata.radio_click_game=1
		click_indicator=0
		all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 0
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 0
		filter_all.alpha=1
		poem_ntf.fill.effect = "filter.desaturate"
		poem_ntf.fill.effect.intensity = 1
		filter_poem.fill.effect = "filter.desaturate"
		filter_poem.fill.effect.intensity = 1
		filter_poem.alpha=0
		game_ntf.fill.effect = "filter.desaturate"
		game_ntf.fill.effect.intensity = 1
		filter_game.fill.effect = "filter.desaturate"
		filter_game.fill.effect.intensity = 1
		filter_game.alpha=0
		favorite_ntf.fill.effect = "filter.desaturate"
		favorite_ntf.fill.effect.intensity = 1
		filter_fav.fill.effect = "filter.desaturate"
		filter_fav.fill.effect.intensity = 1
		filter_fav.alpha=0
		parent1:on_radioButtonClick3()
	end
	return true
end
function on_radioButtonClick3(event )
	if (event.phase=="ended") then
		mydata.clicktype=event.target.type
		story_ntf.fill.effect = "filter.desaturate"
		story_ntf.fill.effect.intensity = 1
		filter_story.fill.effect = "filter.desaturate"
		filter_story.fill.effect.intensity = 1
		filter_story.alpha=0
		
		if (mydata.radio_click_fav==1) then
			mydata.type=mydata.clicktype
			mydata.radio_click=1
			mydata.radio_click_story=1
			mydata.radio_click_fav=0
			mydata.radio_click_game=1
			click_indicator=0
			favorite_ntf.fill.effect = "filter.desaturate"
			favorite_ntf.fill.effect.intensity = 0
			filter_fav.fill.effect = "filter.desaturate"
			filter_fav.fill.effect.intensity = 0
			filter_fav.alpha=1
			all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 1
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 1
		filter_all.alpha=0
		else
			mydata.type="all"
			click_indicator=1
			mydata.radio_click=1
			mydata.radio_click_story=1
			mydata.radio_click_game=1
			mydata.radio_click_fav=1
			favorite_ntf.fill.effect = "filter.desaturate"
			favorite_ntf.fill.effect.intensity = 1
			filter_fav.fill.effect = "filter.desaturate"
			filter_fav.fill.effect.intensity = 1
			filter_fav.alpha=0
			all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 0
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 0
		filter_all.alpha=1
		end
		poem_ntf.fill.effect = "filter.desaturate"
		poem_ntf.fill.effect.intensity = 1
		filter_poem.fill.effect = "filter.desaturate"
		filter_poem.fill.effect.intensity = 1
		filter_poem.alpha=0
		game_ntf.fill.effect = "filter.desaturate"
		game_ntf.fill.effect.intensity = 1
		filter_game.fill.effect = "filter.desaturate"
		filter_game.fill.effect.intensity = 1
		filter_game.alpha=0
		parent1:on_radioButtonClick3()
	end
	return true
end
function scene:create( event )
    sceneGroup_settings_home=self.view
    overlay_group=display.newGroup( )
    sheetInfo_control = require("scripts.controll_icons")
    myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
    sceneGroup_settings_home:insert(overlay_group)
    parent = event.parent  --reference to the parent scene object
    rect=display.newRect(0,0,display.contentWidth-display.contentHeight/2,display.contentHeight)
    rect:addEventListener( "touch", close_function )
    rect.anchorX=0
   	rect.anchorY=0
  	rect.alpha=0.01
    bg=display.newImageRect("assets/images/overlay_settings.png",display.contentHeight/2,display.contentHeight)
    bg.x=display.contentWidth-bg.contentWidth
    bg.anchorX=0
    bg.anchorY=0
    overlay_group:insert(bg)
    overlay_group:insert(rect)
    seperation=display.newImageRect("assets/images/divition.png",display.contentHeight/2,7)
   	seperation.anchorX=0
   	seperation.anchorY=0
   	seperation.x=display.contentWidth-bg.contentWidth*3.5/4
   	seperation.y=display.contentHeight/4
   	overlay_group:insert(seperation)
    seperation1=display.newImageRect("assets/images/divition.png",display.contentHeight/2,7)
   	seperation1.anchorX=0
   	seperation1.anchorY=0
    seperation1.x=display.contentWidth-bg.contentWidth*3.5/4
   	seperation1.y=display.contentHeight*3/4
  	overlay_group:insert(seperation1)
    options={
		text="Stories",
		x=display.contentWidth-display.contentHeight/5,
		y=display.contentCenterY-display.contentHeight/12,
		width=100,
		font="Averia",
		fontSize=17,
		align="Right",
	}
 	story_ntf= display.newText(options)
	story_ntf:setFillColor( .60784,.21568,.019607)
	story_ntf.xScale=1.2	
	story_ntf.yScale=1.2	
	story_ntf.type="story"
	overlay_group:insert(story_ntf)
	filter_story= display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("tick_mark"), 21,21)
	filter_story.x=display.contentWidth-filter_story.contentWidth/1.5--story_ntf.x+story_ntf.contentWidth/3
	filter_story.y=story_ntf.y
	overlay_group:insert(filter_story)
	if (mydata.type==story_ntf.type) then
		story_ntf.fill.effect = "filter.desaturate"
		story_ntf.fill.effect.intensity = 0
		filter_story.fill.effect = "filter.desaturate"
		filter_story.fill.effect.intensity = 0
		filter_story.alpha=1
		mydata.radio_click_story=0
	else
		story_ntf.fill.effect = "filter.desaturate"
		story_ntf.fill.effect.intensity = 1
		filter_story.fill.effect = "filter.desaturate"
		filter_story.fill.effect.intensity = 1
		filter_story.alpha=0
		mydata.radio_click_story=1
	end
 	story_ntf:addEventListener( "touch", on_radioButtonClick1 )
	options={
		text="Poems",
		x=display.contentWidth-display.contentHeight/5,
		y=display.contentCenterY,
		width=100,
		font="Averia",
		fontSize=17,
		align="left",
	}
    poem_ntf= display.newText(options)
	poem_ntf:setFillColor( .60784,.21568,.019607)
	poem_ntf.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	poem_ntf.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	poem_ntf.type="poem"
	filter_poem= display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("tick_mark"), 21,21)
	filter_poem.x=filter_story.x
	filter_poem.y=poem_ntf.y
	overlay_group:insert(poem_ntf)
	overlay_group:insert(filter_poem)
	if (mydata.type==poem_ntf.type) then
		poem_ntf.fill.effect = "filter.desaturate"
		poem_ntf.fill.effect.intensity = 0
		filter_poem.fill.effect = "filter.desaturate"
		filter_poem.fill.effect.intensity = 0
		filter_poem.alpha=1
		mydata.radio_click=0
	else
		poem_ntf.fill.effect = "filter.desaturate"
		poem_ntf.fill.effect.intensity = 1
		filter_poem.fill.effect = "filter.desaturate"
		filter_poem.fill.effect.intensity = 1
		filter_poem.alpha=0
		mydata.radio_click=1
	end
	poem_ntf:addEventListener( "touch", on_radioButtonClick )
	options={
		text="Games",
		x=display.contentWidth-display.contentHeight/5,
		y=display.contentCenterY+display.contentHeight/12,
		width=100,
		font="Averia",
		fontSize=17,
		align="left",
	}
    game_ntf= display.newText(options)
	game_ntf:setFillColor( .60784,.21568,.019607)
	game_ntf.xScale=1.2
	game_ntf.yScale=1.2
	game_ntf.type="game"
	filter_game=display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("tick_mark"), 21,21)
	filter_game.x=filter_story.x
	filter_game.y=game_ntf.y
	overlay_group:insert(game_ntf)
	overlay_group:insert(filter_game)
	if (mydata.type==game_ntf.type) then
		game_ntf.fill.effect = "filter.desaturate"
		game_ntf.fill.effect.intensity = 0
		filter_game.fill.effect = "filter.desaturate"
		filter_game.fill.effect.intensity = 0
		filter_game.alpha=1
		mydata.radio_click_game=0
	else
		game_ntf.fill.effect = "filter.desaturate"
		game_ntf.fill.effect.intensity = 1
		filter_game.fill.effect = "filter.desaturate"
		filter_game.fill.effect.intensity = 1
		filter_game.alpha=0
		mydata.radio_click_game=1
	end
	game_ntf:addEventListener( "touch", on_radioButtonClick2 )
	options={
		text="Favorites",
		x=display.contentWidth-display.contentHeight/5,
		y=display.contentCenterY+display.contentHeight/6,
		width=100,
		font="Averia",
		fontSize=17,
		align="left",
	}
	 favorite_ntf= display.newText(options)
	favorite_ntf:setFillColor( .60784,.21568,.019607)
	favorite_ntf.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	favorite_ntf.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	favorite_ntf.type="fav"
	filter_fav=display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("tick_mark"), 21,21)
	filter_fav.x=filter_story.x
	filter_fav.y=favorite_ntf.y
	overlay_group:insert(favorite_ntf)
	overlay_group:insert(filter_fav)
	if (mydata.type==favorite_ntf.type) then
		favorite_ntf.fill.effect = "filter.desaturate"
		favorite_ntf.fill.effect.intensity = 0
		filter_fav.fill.effect = "filter.desaturate"
		filter_fav.fill.effect.intensity = 0
		filter_fav.alpha=1
		mydata.radio_click_fav=0
	else
		favorite_ntf.fill.effect = "filter.desaturate"
		favorite_ntf.fill.effect.intensity = 1
		filter_fav.fill.effect = "filter.desaturate"
		filter_fav.fill.effect.intensity = 1
		filter_fav.alpha=0
		mydata.radio_click_fav=1
	end
	favorite_ntf:addEventListener( "touch", on_radioButtonClick3 )
	options={
		text="All",
		x=display.contentWidth-display.contentHeight/5,
		y=display.contentCenterY-display.contentHeight/6,
		width=100,
		font="Averia",
		fontSize=17,
		align="left",
	}
	all_ntf= display.newText(options)
	all_ntf:setFillColor( .60784,.21568,.019607)
	all_ntf.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	all_ntf.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	all_ntf.type="all"
	filter_all=display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("tick_mark"), 21,21)
	filter_all.x=filter_story.x
	filter_all.y=all_ntf.y
	overlay_group:insert(all_ntf)
	overlay_group:insert(filter_all)
	if (mydata.type==all_ntf.type) then
		all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 0
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 0
		filter_all.alpha=1
		mydata.radio_click_all=0
	else
		all_ntf.fill.effect = "filter.desaturate"
		all_ntf.fill.effect.intensity = 1
		filter_all.fill.effect = "filter.desaturate"
		filter_all.fill.effect.intensity = 1
		filter_all.alpha=0
		mydata.radio_click_all=1
	end
	all_ntf:addEventListener( "touch", on_radioButtonClick4 )
	options={
		text="About Rescued",
		x=display.contentWidth-display.contentHeight/5,
		y=seperation1.y+60,
		width=100,
		font="Averia",
		fontSize=10,
		align="left",
	}
	about=display.newText(options)
	about:setFillColor( .60784,.21568,.019607)
	about.xScale=1.2
	about.yScale=1.2
	about_bg = display.newRect(0, 0, 100, 30)
	about_bg.anchorX = 0
	about_bg.alpha = 0
	about_bg.isHitTestable = true
	about_bg.x = about.x - about.contentWidth/2-5
	about_bg.y = about.y
	about_bg:addEventListener( "touch", on_aboutclick )
	overlay_group:insert(about_bg)
	overlay_group:insert(about )
	options={
		text="Credits",
		x=display.contentWidth-display.contentHeight/5,
		y=seperation1.y+60,
		width=100,
		font="Averia",
		fontSize=10,
		align="left",
	}
 	credit=display.newText(options)
	credit:setFillColor( .60784,.21568,.019607)
	credit.alpha=0
	credit.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	credit.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	credit_bg = display.newRect(0, 0, 75, 25)
	credit_bg.anchorX = 0
	credit_bg.alpha = 0
	credit_bg.isHitTestable = true
	credit_bg.x = credit.x - credit.contentWidth/2-5
	credit_bg.y = credit.y
	--credit_bg:addEventListener( "touch", on_creditclick )
	overlay_group:insert(credit_bg)
	overlay_group:insert(credit )
	options={
		text="Music",
		x=display.contentWidth-display.contentHeight/5,
		y=seperation.y-60,
		width=100,
		font="Averia",
		fontSize=10,
		align="left",
	}
 	sound_text=display.newText(options)
	sound_text:setFillColor( .60784,.21568,.019607)
	sound_text.xScale=1.2
	sound_text.yScale=1.2
	musicOnBg = display.newRect(0, 0, 125, 30)
	musicOnBg.anchorX = 0
	musicOnBg.alpha = 0
	musicOnBg.isHitTestable = true
	musicOnBg.x = sound_text.x-10
	musicOnBg.y = sound_text.y
	overlay_group:insert(sound_text )
	options={
		text="Narration",
		x=display.contentWidth-display.contentHeight/5,
		y=seperation.y-30,
		width=100,
		font="Averia",
		fontSize=10,
		align="left",
	}
	narration_text=display.newText(options)
	narration_text:setFillColor( .60784,.21568,.019607)
	narration_text.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	narration_text.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	overlay_group:insert(narration_text )
	sound_control=display.newImage("assets/images/sound_controll.png")
	sound_control.x=sound_text.x+30
	sound_control.y=sound_text.y
	sound_control.xScale=.25
	sound_control.yScale=.25
	overlay_group:insert(sound_control )
	narration_control=display.newImage("assets/images/sound_controll.png")
	narration_control.x=narration_text.x+30
	narration_control.y=narration_text.y
	narration_control.xScale=.25
	narration_control.yScale=.25
	overlay_group:insert(narration_control )
	narrationOnBg = display.newRect(0, 0, 125, 30)
	narrationOnBg.anchorX = 0
	narrationOnBg.anchorY = 0
	narrationOnBg.alpha = 0
	narrationOnBg.isHitTestable = true
	narrationOnBg.x = narration_text.x-10
	narrationOnBg.y = (narration_text.y - narration_text.contentHeight/2)-6
	sound_control_stone=display.newImage("assets/images/sound_controll_stone.png")
	if (mydata.music_status==1) then
		sound_control_stone.x=sound_text.x+15
	else
		sound_control_stone.x=sound_text.x+45
	end
	sound_control_stone.y=sound_text.y
	sound_control_stone.xScale=.1
	sound_control_stone.yScale=.1
	overlay_group:insert(sound_control_stone )
	overlay_group:insert(musicOnBg)
	musicOnBg:addEventListener("touch", soundcontrol)
	narration_control_stone=display.newImage("assets/images/sound_controll_stone.png")
	if(mydata.narration_status==1) then
		narration_control_stone.x=sound_text.x+15
	else
	narration_control_stone.x=sound_text.x+45
	end
	narration_control_stone.y=narration_text.y
	narration_control_stone.xScale=.1
	narration_control_stone.yScale=.1
	overlay_group:insert(narration_control_stone )
	overlay_group:insert(narrationOnBg )
	narrationOnBg:addEventListener( "touch",narrationcontrol )
	creditbg = display.newImageRect("assets/images/about app_bg.png", display.contentHeight*1.655, display.contentHeight)
	creditbg.x = display.contentCenterX
	creditbg.y = display.contentCenterY
	creditbg.alpha=0
	sceneGroup_settings_home:insert(creditbg)
	headertext = display.newText( "ABOUT", 0, 0, "Averia", 25 ) 
	headertext.x = display.contentCenterX-headertext.contentWidth*1.1
	headertext.y = display.contentCenterY/8
	headertext:setFillColor(89/255, 51/255, 44/255)
	headertext.alpha=0
	headertext1 = display.newText( "CREDITS", 0, 0, "Averia", 25 ) 
	headertext1.x = display.contentCenterX-headertext1.contentWidth*1
	headertext1.y = display.contentCenterY
	headertext1:setFillColor(89/255, 51/255, 44/255)
	headertext1.alpha=0
	sceneGroup_settings_home:insert(headertext1)
	sceneGroup_settings_home:insert(headertext)
	scrollView = widget.newScrollView
	{
		width = display.contentWidth-(display.contentWidth/3),
		height = display.contentHeight-106,
		bottomPadding = 0,
		topPadding = 0,
		id = "onBottom",
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false,
		listener = scrollListener,
		hideBackground = true
	}
	scrollView.x = display.contentCenterX
	scrollView.alpha=0
	scrollView.y = display.contentCenterY
	sceneGroup_settings_home:insert(scrollView)
	multiText = display.newText('OneHope:\n\nIn 2014, OneHope reached its billionth child—a young girl in China—with a relevant Gospel message. This year OneHope will reach nearly one hundred million additional young people with Scripture programs that are age - and culturally - specific based on research it conducts among children and youth, leaders and educators in each country it works. Since 1987, OneHope has helped kids experience God’s Story by collaborating with churches and ministries—and working with local governments, schools and non-governmental organizations—to bring a message of Hope to children and youth in more than 125 countries.\nwww.OneHope.net.\n\nRescued:\n\nThe Rescued app is a fun digital way for kids to engage with the content of the Rescued book from OneHope. Guided by the narrator lion, Areli, kids will experience the book’s 10 Bible stories in a whole new way, and have the opportunity to engage with additional fun games and activities!', 25, 0, display.contentWidth-(display.contentWidth/2.5), 0, "Averia", 15 ) 
	multiText1 = display.newText('Design and Development by Fingent, and Animation by Timbuktoons.\n\nSpecial thanks to Omri Lahav, Avior Rokah & Marta Mc\'cave for the "Honor Bound" soundtrack featured in "0 A​.​D", the open-source ancient warfare game.\n\nVersion: 2.0', 25, 0, display.contentWidth-(display.contentWidth/2.5), 0, "Averia", 15 ) 
	multiText1.alpha=0
	multiText.anchorX = 0
	multiText.anchorY = 0
	multiText.x = 15
	multiText.y=headertext.y+30
	multiText:setFillColor(89/255, 51/255, 44/255)
	multiText1.anchorX = 0
	multiText1.anchorY = 0
	multiText1.x = 15
	multiText1.y = headertext.y+10
	sceneGroup_settings_home:insert(multiText)
	sceneGroup_settings_home:insert(multiText1)
	multiText1:setFillColor(89/255, 51/255, 44/255)
	scrollView:insert(headertext)
	scrollView:insert( multiText )
	headertext1.y=multiText.y+multiText.contentHeight+30
	multiText1.y=headertext1.y+30
	scrollView:insert( headertext1 )
	scrollView:insert( multiText1 )
	closeButton = widget.newButton({
		    fontSize = 16,
		    top = 0,
		    labelYOffset = -5,
		    labelAlign = "center",
		    font = 'Averia',
		    labelColor = { default = { 89/255, 51/255, 44/255}, over = { 89/255, 51/255, 44/255} },
		    cornerRadius = 2,
		    --width=60,
		    --height=30,
		    width = display.contentHeight/10 * 1.8,
	    	height = display.contentHeight/11* 1.8,
			label="OK",
			defaultFile = "assets/images/button_1.png",
			onEvent = closeWindow
		})
	closeButton.x = display.contentCenterX
	closeButton.y = display.contentHeight-30 
	closeButton.isVisible = true
	closeButton.alpha=0	
	sceneGroup_settings_home:insert(closeButton)
	options={
		text="Rate this App",
		x=display.contentWidth-display.contentHeight/5,
		y=seperation1.y+20,
		width=100,
		font="Averia",
		fontSize=13,
		align="left",
	}
 	Rate=display.newText(options)
	Rate:setFillColor( .60784,.21568,.019607)
	Rate.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	Rate.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	Rate_bg = display.newRect(0, 0, 100, 30)
	Rate_bg.anchorX = 0
	Rate_bg.alpha = 0
	Rate_bg.isHitTestable = true
	Rate_bg.x = Rate.x-Rate.contentWidth/2-5
	Rate_bg.y = seperation1.y+20,
	Rate_bg:addEventListener( "touch", on_rate_click )
	overlay_group:insert(Rate_bg)
	overlay_group:insert(Rate )
	seperation1=display.newImageRect("assets/images/divition.png",display.contentHeight/2,7)
   	seperation1.anchorX=0
   	seperation1.anchorY=0
    seperation1.x=display.contentWidth-bg.contentWidth*3.5/4
   	seperation1.y=Rate.y+20
  	overlay_group:insert(seperation1)
  	popupgroup=display.newGroup( )
  	sceneGroup_settings_home:insert( popupgroup)
  --[[	rect_popup=display.newRect(0,0,display.contentWidth,display.contentHeight)
  	rect_popup.x=display.contentCenterX
  	rect_popup.y=display.contentCenterY
  	rect_popup.alpha=.1
  	rect_popup:addEventListener("touch",onbgtouch)
  	popupgroup:insert(rect_popup)--]]
  	bg_popup=display.newImageRect("assets/images/popup_scroll.png",display.contentHeight/1.5*1.66,display.contentHeight/1.5)
    bg_popup.x=display.contentCenterX
    bg_popup.y=display.contentCenterY
    bg_popup:addEventListener( "touch",close_rate )
    popupgroup:insert( bg_popup)
    circle = widget.newButton({
		    --fontSize = 16,
		   -- top = 0,
		    --labelYOffset = -5,
		   -- labelAlign = "center",
		    --font = 'Averia',
		    --labelColor = { default = { 89/255, 51/255, 44/255}, over = { 89/255, 51/255, 44/255} },
		    --cornerRadius = 2,
		    --width=60,
		    --height=30,
		    width = display.contentHeight/5,
	    	height = display.contentHeight/5,
			--label="OK",
			defaultFile = "assets/images/circle.png",
			overFile = "assets/images/circle_ds.png",
			onEvent = Rate_bgListener
		})
   -- circle=display.newImageRect("assets/images/circle.png",display.contentHeight/6,display.contentHeight/6)
   circle.id="circle"
   circle.x=bg_popup.x
    circle.y=bg_popup.y+display.contentHeight/14
    popupgroup:insert(circle)
  	triangle= widget.newButton({
		    --fontSize = 16,
		   -- top = 0,
		    --labelYOffset = -5,
		   -- labelAlign = "center",
		    --font = 'Averia',
		    --labelColor = { default = { 89/255, 51/255, 44/255}, over = { 89/255, 51/255, 44/255} },
		    --cornerRadius = 2,
		    --width=60,
		    --height=30,
		    width = display.contentHeight/5,
	    	height = display.contentHeight/5,
			--label="OK",
			defaultFile = "assets/images/triangle.png",
			overFile = "assets/images/triangle_ds.png",
			onEvent = Rate_bgListener1
		})
    --triangle=display.newImageRect("assets/images/triangle.png",display.contentHeight/6,display.contentHeight/6)
    triangle.id="triangle"
    triangle.x=bg_popup.x-triangle.contentWidth*1.2
    triangle.y=bg_popup.y+display.contentHeight/14
    popupgroup:insert(triangle)
    square = widget.newButton({
		    --fontSize = 16,
		   -- top = 0,
		    --labelYOffset = -5,
		   -- labelAlign = "center",
		    --font = 'Averia',
		    --labelColor = { default = { 89/255, 51/255, 44/255}, over = { 89/255, 51/255, 44/255} },
		    --cornerRadius = 2,
		    --width=60,
		    --height=30,
		    width = display.contentHeight/5,
	    	height = display.contentHeight/5,
			--label="OK",
			defaultFile = "assets/images/square.png",
			overFile = "assets/images/square_ds.png",
			onEvent = Rate_bgListener1
		})
   -- square=display.newImageRect("assets/images/square.png",display.contentHeight/6,display.contentHeight/6)
    square.id="square"
    square.x=bg_popup.x+triangle.contentWidth*1.2
    square.y=bg_popup.y+display.contentHeight/14
    popupgroup:insert(square)
    options={
		text="To continue we need to ensure that you are an adult or have guidance from an adult. Please press and hold the circle for 3 seconds. Thanks!",
		x=bg_popup.x,
		y=bg_popup.y-display.contentHeight/8,
		width=290,
		font="Averia",
		fontSize=12,
		align="center",
	}
qstn=display.newText(options)
    qstn:setFillColor(89/255, 51/255, 44/255)
    popupgroup:insert(qstn)
    popupgroup.alpha=0

end

function scrollListener( event )
	local phase = event.phase
	local direction = event.direction
	if "began" == phase then
		--print( "Began" )
	elseif "moved" == phase then
		--print( "Moved" )
	elseif "ended" == phase then
		--print( "Ended" )
	end
	if event.limitReached then
		if "up" == direction then
			print( "Reached Top Limit" )
		elseif "down" == direction then
			print( "Reached Bottom Limit" )
		elseif "left" == direction then
			print( "Reached Left Limit" )
		elseif "right" == direction then
			print( "Reached Right Limit" )
		end
	end
	return true
end
function scene:show( event )
    local overlay_group= self.view
 	parent1 = event.parent 
end
function scene:hide( event )
    local overlay_group = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object
    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
        mydata.flag=1
        if (mydata.click==2) then
	        parent:resume()
	      	transition.cancel( )
    	end
    end
end
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