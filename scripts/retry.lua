local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local mydata=require("scripts.mydata")
local window
local back, play, right
local click=0
local function handleButtonEvent( event )
    if (event.phase=="ended") then
        if ( "retry_button2" == event.target.name ) then
            composer.removeHidden()
            composer.gotoScene("scripts.home")
        end
        if ( "retry_button1" == event.target.name ) then
            click=1
            composer.removeHidden()
            composer.hideOverlay()
        end
    end
end
function scene:create( event )
    local sceneGroup= self.view
    window = display.newRoundedRect ( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight+display.contentHeight/5, 0 )
    window:setFillColor (0,0,0)
    window.alpha = 0.7
    scroll1=display.newImageRect("assets/images/scroll_wh.png",display.contentWidth+display.contentWidth/3,display.contentHeight/2)
    scroll1.anchorX = .5
    scroll1.anchorY = 0.5
    scroll1.x=display.contentCenterX-display.contentWidth/35
    scroll1.y=display.contentCenterY
    if (mydata.isgame==false) then
        scroll1.y=display.contentCenterY
    else
        scroll1.y =display.contentCenterY+display.contentCenterY/3
    end
    sceneGroup:insert(scroll1)
    local msg = display.newText( mydata.messages[mydata.currentmsg], display.contentCenterX, display.contentCenterY-display.contentCenterY/3, 'Averia', 30)
    msg.align = "center"
    msg:setFillColor (246/255, 220/255, 134/255 )
    if (mydata.isgame==false) then
       msg.alpha=0
    else
        msg.alpha=1
    end
    sceneGroup:insert( msg)
    sheetInfo_control = require("scripts.controll_icons")
    myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
    retry_button1 = widget.newButton
    {
        width = display.contentHeight/10,
        height = display.contentHeight/11,
        defaultFile = "assets/images/button_1.png",
        overFile = "assets/images/button_2.png",
        onEvent = handleButtonEvent
    }
    retry_button1.x = display.contentCenterX+display.contentCenterX/6
    retry_button1.y = scroll1.y-- display.contentCenterY+display.contentCenterY/3
    retry_button1.name="retry_button1"
    retry_button1.xScale=1.8
    retry_button1.yScale=1.8
    sceneGroup:insert( retry_button1 )
    settings1 =  display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("reset"), 21,21)
    settings1.x=retry_button1.x
    settings1.y=retry_button1.y-5
    settings1.xScale=1
    settings1.yScale=1
    sceneGroup:insert(settings1)
    retry_button2 = widget.newButton
    {
        width = display.contentHeight/10,
        height =display.contentHeight/11,
        defaultFile = "assets/images/button_1.png",
        overFile = "assets/images/button_2.png",
        onEvent = handleButtonEvent
    }
    retry_button2.name="retry_button2"
    retry_button2.x = display.contentCenterX-display.contentCenterX/6
    retry_button2.y =scroll1.y-- display.contentCenterY+display.contentCenterY/3
    retry_button2.xScale=1.8
    retry_button2.yScale=1.8
    sceneGroup:insert( retry_button2 )
    settings2=  display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)
    settings2.x=retry_button2.x
    settings2.y=retry_button2.y-5
    settings2.xScale=1
    settings2.yScale=1
    sceneGroup:insert(settings2)
    
end
function scene:show( event )
    local sceneGroup= self.view
    if ( phase == "did" ) then

    end
end
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object
    if ( phase == "will" ) then
        if (click==1) then
            parent:resume()
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