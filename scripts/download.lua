-- Home scene
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local zip = require( "plugin.zip" )
local toast = require("scripts.toast");

local homeButton, homeIcon
local sheetInfo_control, myImageSheet_control

-- Local variables 
local netWorkReqId
local catImage
local progressvalue = 0
local downloadButton
local headText
local pgbar, downloadBar, pgbarText
local currentStory
local sheetInfo={}
local myImageSheet={}
local character={}
local mydata = require("scripts.mydata")
local storyTitle = {"The Man From Dust","The Rescuer Who Commanded The Sea","The Warrior and the Giant","The Peacemaker and the King's Throne","A Hero Escapes Death","The Man from Heaven","The Rescuer Who Walked on the Sea","The Warrior on the Cross","A Hero Defeats Death","The Peacemaker and Heaven's Throne"}
local seq={"seq1","seq2","seq3","seq4","seq5"}
local function zipListener(event)
	if (event.isError) then
		print ("Unzip Error")
	else	
		print ("Event name=".. event.name.."\n Event type =".. event.type)
		if ( event.response and type(event.response) == "table" ) then
          for i = 1, #event.response do
          	print( event.response[i] )
          end
      	end
      	print ("Unzip completed")
      	function gotostory()
      	composer.removeHidden()
		composer.gotoScene("scripts.story",{effect="fade"})
	end
timer.performWithDelay(1800,gotostory)
		character:setSequence( seq[5] )  --switch to "fastRun" sequence
character:play()
	character:removeEventListener( "sprite", mySpriteListener )

	end	
end

local function networkeventListener(event)
	if (event.isError) then
		--print("Network error - download failed")	
		downloadBar.isVisible = false
		toast.new("no network",2000,sceneGroup)
		downloadButton.isVisible = true
		pgbarText.isVisible=false
		pgbar.isVisible = false
		downloadBar.isVisible = false
	elseif (event.phase == "began") then
		print("Download started from here")
		print ("Bytes to download :- " .. event.bytesEstimated)
	elseif (event.phase == "progress") then
		
		print ("Downloaded bytes in percentage=".. (event.bytesTransferred/event.bytesEstimated)*100)
		progressvalue = math.floor((event.bytesTransferred/event.bytesEstimated)*100)
		print ("Downloading = "..progressvalue.."%,".. ((pgbar.contentWidth-6.5)*progressvalue)/100)
		pgbarText.text = "Downloading "..progressvalue.."%"
		if (downloadBar.isVisible == false) then
			if (((pgbar.contentWidth-6.5)*progressvalue)/100 > 6) then 
			 	downloadBar.width = ((pgbar.contentWidth-6.5)*progressvalue)/100
			 	downloadBar.isVisible = true
			end	
		else
			downloadBar.width = ((pgbar.contentWidth-6.5)*progressvalue)/100
		end

	elseif (event.phase == "ended") then	
		--print("Response"..event.response)
		--print(event.bytesEstimated)
		print("Downloaded Completed.")	
		--pgbarText.text = "Downloading  "..math.floor((event.bytesTransferred/event.bytesEstimated)*100).."%"
		pgbarText.text = "Downloading completed."
		--catImage = display.newImage("loaded1.jpg", system.DocumentsDiectory )		
		downloadBar.width = (pgbar.contentWidth-6.5)
		--viewImagetext.isVisible = true
		-- Print image display 
		--catImage = display.newImageRect("loaded1.jpg", system.TemporaryDirectory )		
		--catImage.x = display.contentCenterX
		--catImage.y = display.contentCenterY
		--catImage:scale(0.25, 0.25)
		print ("File name=".. event.response.filename)
		print (event.response.baseDirectory)
		print (system.DocumentsDirectory)
		-- Unzip  the file 
		local options = {
            zipFile = event.response.filename,
            zipBaseDir = event.response.baseDirectory,
            dstBaseDir = system.DocumentsDirectory,
            listener = zipListener,
         }
        zip.uncompress( options ) 
        -- Go to downloaded story 
	end	
end	
local function handleButtonClick(event)
	if (event.phase == "ended") then
		print("Clicked")
		local params = {}
		params.progress = true
		downloadButton.isVisible = false
		pgbar.isVisible = true
		pgbarText.text="Downloading 0%"
		pgbarText.isVisible = true
		downloadBar.isVisible = false
		if (currentStory == 1) then
			netWorkReqId = network.download('https://www.dropbox.com/s/ati24yhmu2bor6u/story1.zip?dl=1', "GET", networkeventListener, params, "story1.zip", system.TemporaryDirectory )
		elseif (currentStory == 2) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368620/story2.zip', "GET", networkeventListener, params, "story2.zip", system.TemporaryDirectory )
		elseif (currentStory == 3) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368625/story3.zip', "GET", networkeventListener, params, "story3.zip", system.TemporaryDirectory )
		elseif (currentStory == 4) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368626/story4.zip', "GET", networkeventListener, params, "story4.zip", system.TemporaryDirectory )
		elseif (currentStory == 5) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368627/story5.zip', "GET", networkeventListener, params, "story5.zip", system.TemporaryDirectory )
		elseif (currentStory == 6) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368628/story6.zip', "GET", networkeventListener, params, "story6.zip", system.TemporaryDirectory )
		elseif (currentStory == 7) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368629/story7.zip', "GET", networkeventListener, params, "story7.zip", system.TemporaryDirectory )					
		elseif (currentStory == 8) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368880/story8.zip', "GET", networkeventListener, params, "story8.zip", system.TemporaryDirectory )
		elseif (currentStory == 9) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368631/story9.zip', "GET", networkeventListener, params, "story9.zip", system.TemporaryDirectory )
		elseif (currentStory == 10) then	
			netWorkReqId = network.download('https://system.linguadms.com/file/368632/story10.zip', "GET", networkeventListener, params, "story10.zip", system.TemporaryDirectory )
		end		
	end
end
local function viewImageClick(event)
	if (event.phase == "ended") then
		composer.removeHidden()
		composer.gotoScene('scene2')
	end
end	
local function handleButtonEvent1( event )
    if ("ended" == event.phase ) then
        
    	network.cancel( netWorkReqId )
	    composer.removeHidden()
	    composer.gotoScene("scripts.home")
    end
end
-- Create 
function scene:create(event)
	 sceneGroup = self.view
	print ("CS=".. (event.params.currentStory))
	currentStory = event.params.currentStory
    background=display.newImageRect(mydata.bg[mydata.cbg],display.contentWidth*2,display.contentHeight)
	if (mydata.dir == 1) then
		background.anchorX=1
		background.fill.effect = "filter.desaturate"
		background.fill.effect.intensity = .7
		background.x=display.contentWidth
		background.y=display.contentCenterY
	else
		background.anchorX=1
		background.fill.effect = "filter.desaturate"
		background.fill.effect.intensity = .7
		background.x=display.contentWidth+background.contentWidth/2
		background.y=display.contentCenterY
	end
	sceneGroup:insert(background)

	sheetInfo_control = require("scripts.controll_icons")
	myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )

	homeButton = widget.newButton{
	    width = display.contentHeight/10,
	    height = display.contentHeight/11,
	    defaultFile = "assets/images/button_1.png",
	    overFile = "assets/images/button_2.png",
	    onEvent = handleButtonEvent1
	}
	homeButton.x = (homeButton.contentWidth/2)+15
	homeButton.y = (homeButton.contentHeight/2)+15
	homeButton.xScale = 1.8
	homeButton.yScale = 1.8
	sceneGroup:insert( homeButton )
	
	homeIcon = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)
	homeIcon.x = homeButton.x
	homeIcon.y = homeButton.y-5
	homeIcon.xScale = 1
	homeIcon.yScale = 1
	sceneGroup:insert( homeIcon )


    local bg = display.newImage("assets/images/poem_scroll.png")
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	bg:scale(0.35, 0.35)

	sceneGroup:insert(bg)

	local options = {
	   text = storyTitle[mydata.cbg],
	   x = display.contentCenterX,
	   y = display.contentCenterY- display.contentHeight/8,--+display.contentCenterY*images[i].yScale/3,
	   width = 250,
	   font="Averia",
	   fontSize = 25, -- 30
	   align = "center"
	}
	headText = display.newText(options)
	headText:setFillColor( .60784,.21568,.019607 )

	sceneGroup:insert(headText)

	pgbar = display.newImage("assets/images/progressbar.png")
	pgbar.x = display.contentCenterX
	pgbar.y = display.contentCenterY + display.contentCenterY/3
	pgbar:scale(0.75, 0.75)

	

	downloadBar = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 6, pgbar.contentHeight-7, 4)
	downloadBar.anchorX = 0
	downloadBar.width = 6
	downloadBar.x = pgbar.x - (pgbar.contentWidth/2)+3.5
	downloadBar.y = pgbar.y 
	downloadBar.strokeWidth = 1
	downloadBar:setFillColor(.60784,.21568,.019607)
	downloadBar:setStrokeColor(.60784,.21568,.019607 )

	sceneGroup:insert( downloadBar )
	sceneGroup:insert( pgbar )
	pgbarText = display.newText("Downloading 0%", display.contentCenterX, display.contentCenterY, native.systemFont, 16)
	pgbarText.x = pgbar.x
	pgbarText.y = pgbar.y 
	pgbarText:setFillColor(0, 0, 0)


	sceneGroup:insert( pgbarText )

	 --display.newImage("assets/download.png")


	pgbar.isVisible = false
	pgbarText.isVisible = false
	downloadBar.isVisible = false

	-- local options2 = {
	--    text = "View Image",
	--    x = display.contentCenterX,
	--    y = downloadBar.y + 50,--+display.contentCenterY*images[i].yScale/3,
	--    width = 200,
	--    font="Averia",
	--    fontSize = 20,
	--    align = "center"
	-- }

	-- viewImagetext = display.newText(options2)
	-- viewImagetext:setFillColor(.60784,.21568,.019607)
	-- sceneGroup:insert( viewImagetext )
	-- viewImagetext:addEventListener('touch', viewImageClick)

	-- viewImagetext.isVisible = false

	-- .60784,.21568,.019607
	
	downloadButton  = widget.newButton({
		width = 207,
		height= 98,
		label ="Download",
		font="Averia",
		fontSize = 25,
		--0labelColor = { default={ 68/255,29/255,6/255,90 }, over={ 158/255,74/255,25/255, 20} },
		labelColor = { default={ 68/255,29/255,6/255,90 }, over={ 158/255,74/255,25/255, 20} },
		--.60784,.21568,.019607
		defaultFile = "assets/images/download.png",
		overFile = "assets/images/download.png",
		onEvent = handleButtonClick
	})
	downloadButton.x = pgbar.x
	downloadButton.y = pgbar.y
	downloadButton:scale(0.75, 0.75)

	sceneGroup:insert( downloadButton )
	for i=1,5 do
		sheetInfo[i] =  require("assets.images.sheet_"..i.."")
			myImageSheet[i] = graphics.newImageSheet("assets/images/sheet_"..i..".png",sheetInfo[i]:getSheet() )
		
	end
 	sequenceData = {
                	{ name="seq1", sheet=myImageSheet[1], start=1, count=30, time=1500,loopCount=1 },
           			{ name="seq2", sheet=myImageSheet[2], start=1, count=30, time=1500,loopCount=1 },
             		{ name="seq3", sheet=myImageSheet[3], start=1, count=30, time=1500,loopCount=1 },
                	{ name="seq4", sheet=myImageSheet[4], start=1, count=30, time=1500,loopCount=1 },
                	{ name="seq5", sheet=myImageSheet[5], start=1, count=30, time=1500,loopCount=1 },
            	   }
    character= display.newSprite( myImageSheet[1], sequenceData)
	character.x=display.contentCenterX-display.contentCenterX/3
	character.y=display.contentHeight-110
	character.xScale=.8
	character.yScale=.8
	character:addEventListener( "sprite", mySpriteListener )
	sceneGroup:insert(character)
	character:setSequence( seq[n] )  --switch to "fastRun" sequence
    		character:play() 
	n=0

end
-- Show 
function mySpriteListener( event )
 	if (event.phasae=="began") then
 	end
  	if ( event.phase == "ended" ) then
   		local thisSprite = event.target
    	n=n+1
		
   		if (n<=4) then
    		thisSprite:setSequence( seq[n] )  --switch to "fastRun" sequence
    		thisSprite:play()  
   		else
    		n=1
    		thisSprite:setSequence( seq[n] )  --switch to "fastRun" sequence
    		thisSprite:play() 
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
    end

end
-- Hide
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	 if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end	
function scene:destroy(event)
	local sceneGroup = self.view
	-- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end	
-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene