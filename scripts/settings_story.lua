local composer = require( "composer" )
local scene = composer.newScene()
local parent1 
local mydata=require("scripts.mydata")
local click_indicator=0
local json = require("json")
local jsn=require("scripts.jsn")
local musicOnBg, narrationOnBg
function soundcontrol(event)
	if (event.phase=="ended") then
		if (mydata.music_status==1) then
			mydata.music_status=0
			parent1:music_mute_function()
			transition.to( sound_control_stone, {x=sound_control.x+15,time=300})
		else
			mydata.music_status=1
			parent1:music_mute_function()
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
			parent1:narration_mute_function()
			transition.to( narration_control_stone, {x=narration_control.x+15,time=300})
		else
			mydata.narration_status=1
			parent1:narration_mute_function()
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
		transition.to( overlay_group, {x=display.contentWidth+bg.contentWidth,time=3000,delay=1} )
		function moveoverlay()
			composer.hideOverlay()
		end
		timer.performWithDelay( 800,moveoverlay )
    end
end
function on_pauseclick(event )
	if (event.phase=="ended") then
		if (mydata.isgame==false) then
			if (mydata.onpause==false) then
				if (mydata.play==1) then
					mydata.onpause=true
					pause_ntf.fill.effect = "filter.desaturate"
					pause_ntf.fill.effect.intensity = 0
					filter_pause.fill.effect = "filter.desaturate"
					filter_pause.fill.effect.intensity = 0
					filter_pause.alpha=1
					parent1:pauselistener()
				end
			else
				if (mydata.play==1) then
					mydata.onpause=false
					pause_ntf.fill.effect = "filter.desaturate"
					pause_ntf.fill.effect.intensity = 1
					filter_pause.fill.effect = "filter.desaturate"
					filter_pause.fill.effect.intensity = 1
					filter_pause.alpha=0
					parent1:pauselistener()
				end
			end
		end
	end
	return true
end
function on_favbuttonclick(event )
	if (event.phase=="ended") then
		local match=0
		f=mydata.currentscene
	
			if (mydata.fave[f].id==1)then
    			match=1
    		end

		if (match==0) then
			mydata.fave[f].id=1
			if(mydata.isstory==true) then
				mydata.fave[f].type="story"
				mydata.fave[f].index=mydata.story
			elseif(mydata.ispoem==true)then
				mydata.fave[f].type="poem"
				mydata.fave[f].index=mydata.poem
			elseif(mydata.isgame==true)then
				mydata.fave[f].type="game"
				mydata.fave[f].index=mydata.game
		    end
			jsn.saveTable(mydata.fave,"favorite.json")
			favorite_ntf.fill.effect.intensity = 0
			filter_fav.fill.effect.intensity = 0
			filter_fav.alpha=1
		end
		if (match==1) then
			mydata.fave[f].id=0
			jsn.saveTable(mydata.fave,"favorite.json")
			favorite_ntf.fill.effect.intensity = 1
			filter_fav.fill.effect.intensity = 1
			filter_fav.alpha=0
		end
	end
	return true
end
function scene:create( event )
    overlay_group= self.view
    parent = event.parent  --reference to the parent scene object
    rect=display.newRect(0,0,display.contentWidth-display.contentHeight/2,display.contentHeight)
    rect:addEventListener( "touch", close_function )
    rect.anchorX=0
   	rect.anchorY=0
   	rect.alpha=0.01
	overlay_group:insert(rect)
   	bg=display.newImageRect("assets/images/overlay_settings.png",display.contentHeight/2,display.contentHeight)
   	bg.x=display.contentWidth-bg.contentWidth
   	bg.anchorX=0
   	bg.anchorY=0
   	overlay_group:insert(bg)
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
		text="Pause",
		x=display.contentWidth-display.contentHeight/5,
		y=display.contentHeight/2-15,
		width=100,
		font="Averia",
		fontSize=17,
		align="Right",
	}
    pause_ntf= display.newText(options)
	pause_ntf:setFillColor( .60784,.21568,.019607)
	pause_ntf.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	pause_ntf.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	pause_ntf.type="story"
	filter_pause=display.newImageRect("assets/images/menu_tick.png",22,22)
	filter_pause.x=display.contentWidth-filter_pause.contentWidth/1.5--story_ntf.x+story_ntf.contentWidth/3
	filter_pause.y=pause_ntf.y
	overlay_group:insert(pause_ntf)
	overlay_group:insert(filter_pause)
	if (mydata.onpause==true) then
		pause_ntf.fill.effect = "filter.desaturate"
		pause_ntf.fill.effect.intensity = 0
		filter_pause.fill.effect = "filter.desaturate"
		filter_pause.fill.effect.intensity = 0
		filter_pause.alpha=1
	else
		filter_pause.alpha=0
		pause_ntf.fill.effect = "filter.desaturate"
		pause_ntf.fill.effect.intensity = 1
		filter_pause.fill.effect = "filter.desaturate"
		filter_pause.fill.effect.intensity = 1
	end
	pause_ntf:addEventListener( "touch", on_pauseclick )
	if (mydata.isgame==true) then
		pause_ntf.alpha=.5
		filter_pause.alpha=0
		pause_ntf.fill.effect = "filter.desaturate"
		pause_ntf.fill.effect.intensity = 1
	end
	options={
		text="Favorite",
		x=display.contentWidth-display.contentHeight/5,
		y=display.contentHeight/2+15,
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
	filter_fav=display.newImageRect("assets/images/menu_tick.png",22,22)
	filter_fav.x=filter_pause.x-- display.contentWidth-filter_fav.contentWidth/1.5--story_ntf.x+story_ntf.contentWidth/3
	filter_fav.y=favorite_ntf.y
	overlay_group:insert(favorite_ntf)
	overlay_group:insert(filter_fav)
	f=mydata.currentscene
	match=0
	--for i=1,#mydata.fave do
		if (mydata.fave[f].id==1)then
	    	match=1
	    end
	--end
	if (match==1) then
		favorite_ntf.fill.effect = "filter.desaturate"
		favorite_ntf.fill.effect.intensity = 0
		if (mydata.type=="fav") then
			temp=mydata.previous
			mydata.previous=mydata.previous-1
			if (mydata.previous==0) then
				mydata.previous=temp
			end
		end
		filter_fav.fill.effect = "filter.desaturate"
		filter_fav.fill.effect.intensity = 0
		filter_fav.alpha=1
	else
		favorite_ntf.fill.effect = "filter.desaturate"
		favorite_ntf.fill.effect.intensity = 1
		filter_fav.fill.effect = "filter.desaturate"
		filter_fav.fill.effect.intensity = 1
		filter_fav.alpha=0
	end
	favorite_ntf:addEventListener( "touch", on_favbuttonclick )
	options={
	text="About Rescued",
	x=display.contentWidth-display.contentHeight/5,
	y=seperation1.y+30,
	width=100,
	font="Averia",
	fontSize=10,
	align="left",
	}
 	about=display.newText(options)
	about:setFillColor( .60784,.21568,.019607)
	about.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	about.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	about.alpha=0
	about.fill.effect = "filter.desaturate"
	about.fill.effect.intensity = 1
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
	credit.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	credit.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	credit.alpha=0
	credit.fill.effect = "filter.desaturate"
	credit.fill.effect.intensity = 1
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
	sound_text.xScale=1.2--display.contentCenterX/display.contentCenterX+100
	sound_text.yScale=1.2--display.contentCenterX/display.contentCenterX+100
	overlay_group:insert(sound_text )
	musicOnBg = display.newRect(0, 0, 125, 30)
	musicOnBg.anchorX = 0
	musicOnBg.alpha = 0
	musicOnBg.isHitTestable = true
	musicOnBg.x = sound_text.x-10
	musicOnBg.y = sound_text.y
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
	if (mydata.music_status==0) then
		sound_control_stone.x=sound_text.x+45
	else
	sound_control_stone.x=sound_text.x+15
	end
	sound_control_stone.y=sound_text.y
	sound_control_stone.xScale=.1
	sound_control_stone.yScale=.1
	overlay_group:insert(sound_control_stone )
	overlay_group:insert(musicOnBg)
	musicOnBg:addEventListener("touch", soundcontrol)
	narration_control_stone=display.newImage("assets/images/sound_controll_stone.png")
	if (mydata.narration_status==0) then
		narration_control_stone.x=narration_text.x+45
	else
		narration_control_stone.x=narration_text.x+15
	end
	narration_control_stone.y=narration_text.y
	narration_control_stone.xScale=.1
	narration_control_stone.yScale=.1
	overlay_group:insert(narration_control_stone )
	overlay_group:insert(narrationOnBg )
	narrationOnBg:addEventListener( "touch",narrationcontrol )
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
        mydata.flag=1
        if (mydata.click==2) then
    end
    end
end

-- By some method (a "resume" button, for example), hide the overlay


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