-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require "composer"
local mydata=require("scripts.mydata")
local json = require("json")
local jsn=require("scripts.jsn")
-- Analytics
analytics = require("analytics")
local timeSpentInsideApp = 0
local appTimer
mydata.type="all"
mydata.flag=1
mydata.click=1
mydata.click1=1
mydata.previous=1
mydata.config=jsn.loadTable("config.json")
if (mydata.config==nil) then
	mydata.config={1,1}
	jsn.saveTable(mydata.config,"config.json")
end
mydata.fave=jsn.loadTable("favorite.json")
if (mydata.fave==nil) then
	mydata.fave={{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0}}
	jsn.saveTable(mydata.fave,"favorite.json")
else
	if (type(mydata.fave[1]) == 'number') then
		mydata.fave={{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0},{id=0,type=0,index=0}}
		jsn.saveTable(mydata.fave,"favorite.json")
	end	
end


mydata.lock=jsn.loadTable("lock.json")
if (mydata.lock==nil) then
	mydata.lock={1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	jsn.saveTable(mydata.lock,"lock.json")
end
mydata.story_positions={3,6,9,12,15,18,19,20,21,22}
mydata.poem_positions={1,4,7,10,13,16,23}
mydata.game_positions={2,5,8,11,14,17}
mydata.favorite_positions={}
mydata.music_status=mydata.config[1]
mydata.narration_status=mydata.config[2]
mydata.messages={"Excellent","Try Again",""}
mydata.currentmsg=1
mydata.isgame=true
mydata.key=0
down_phase=0
mydata.scene_show=false
mydata.bg={"assets/images/1.jpg","assets/images/2.jpg","assets/images/3.jpg","assets/images/4.jpg","assets/images/5.jpg","assets/images/6.jpg","assets/images/7.jpg","assets/images/8.jpg","assets/images/9.jpg","assets/images/10.jpg"}
mydata.onfavorite_name={}
mydata.onfavorite_type={}
mydata.onfavorite_index={}
local function timeCounterMethod()
	timeSpentInsideApp = timeSpentInsideApp + 1
	--print ("Total time spent in app = " .. timeSpentInsideApp)
end	
local function exitApp(event)
	--
	local logParams = {}
	logParams['exit'] = "Exit from application."

	analytics.logEvent("DROP-OFF", logParams)
	for i,v in pairs(logParams) do
	 	print(i, v)
	end

	native.requestExit()
end	
local function lastDropFeature()
    local logParams = {}
    logParams['feature'] = mydata.lastScene
 
    analytics.logEvent("DROP-OFF-FEATURE", logParams)
    for i,v in pairs(logParams) do
        print(i, v)
    end
 
    timer.performWithDelay(700, exitApp)
end  
appTimer = timer.performWithDelay(1000,timeCounterMethod, 0 )
local function onKeyEvent( event )
    
   if ( event.keyName == "back" and event.phase=="down" ) then
   		down_phase=1
   		return true
   end
  	if ( event.keyName == "back" and event.phase=="up" and down_phase==1) then
   		if (mydata.scene_show==true) then
			   	
		   	if (composer.getSceneName( "current" )=="scripts.home" ) then
	   		   local function onComplete( event )
	    			if "clicked" == event.action then
	       				local i = event.index
				        if 1 == i then
				          native.cancelAlert( alert )
				        elseif 2 == i then
				           timer.cancel(appTimer)
				            local logParams = {}
							logParams['time'] = timeSpentInsideApp

							analytics.logEvent("TOTALTIME-IN-APP", logParams)
							for i,v in pairs(logParams) do
							 	print(i, v)
							end
							timer.performWithDelay(700, lastDropFeature)	
				            
				       end
	    			end
				end
				 alert = native.showAlert( "Exit", "Are You Sure?", { "CANCEL", "OK" }, onComplete )
		   	else
	   			local titleScene = composer.getScene( composer.getSceneName( "current" ))
		   		titleScene.on_back()
		   	end
  		end
  
	 	return true
	end
return false
end
Runtime:addEventListener( "key", onKeyEvent )
-- Initialise the Flurry analytics (Rescued)
--local flurryApiKey = "2DTRV5J748XFR7TVGWZJ"
  local flurryApiKey = "RMRVC27MXSH9ZWM2H3GF"
if (analytics.init) then
	analytics.init( flurryApiKey )
	print ("Flurry initialised")
else  
	print("Flurry not initialised")	
end

local releaseBuild = true   -- Set to true to suppress popup message

-- Error handler
--[[local function myUnhandledErrorListener( event )

    if releaseBuild then
        print( "Handling the unhandled error >>>\n", event.errorMessage )
       
       local text1 = display.newText( "ERR".. event.errorMessage, 30, 1, native.systemFont, 5)
        text1.x = 30
        text1.y = 30
        text1.anchorX = 0
        text1.anchorY = 0
        text1:setTextColor(1,0,0)

    else
        print( "Not handling the unhandled error >>>\n", event.errorMessage )
    end
    
    return releaseBuild
end--]]

--Runtime:addEventListener("unhandledError", myUnhandledErrorListener)
composer.gotoScene( "scripts.splash" )