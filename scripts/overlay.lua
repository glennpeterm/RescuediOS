local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local mydata=require("scripts.mydata")
local json = require("json")
local jsn=require("scripts.jsn")
local toast = require("scripts.toast")
local scene_number=0
local window
local back, play, right
local click=0
local click1=0
mydata.cpoem=0
local length=1
local nextis=true
local frames={"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"}
function handleButtonEvent( event )
    if (event.phase=="ended") then
        if ( "overlay_button2" == event.target.name ) then
            click=1
            composer.removeHidden()
            composer.gotoScene("scripts.home")
        end
        if ( "overlay_button3" == event.target.name ) then
            click=2
            composer.hideOverlay()
        end
        if ( "overlay_button1" == event.target.name ) then
            
            if(mydata.type=="story") then
                if(mydata.lock[mydata.story_positions[mydata.cstory+1]]==1 and mydata.cstory<=9) then
                    mydata.cstory=mydata.cstory+1
                    if (mydata.cstory<=10 and mydata.cstory~=0) then
                        mydata.cbg=mydata.cstory
                        if (mydata.dir==1) then
                            mydata.dir=0
                        else
                            mydata.dir=1
                        end
                        mydata.story=mydata.cstory
                    end
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
                               composer.hideOverlay()
                            else
                                nextis=false
                               print( "File does not exist!" )
                               composer.gotoScene("scripts.download", {effect="fade", params={currentStory=storyIndex}, })
                            end
                            
                        end
                    else
                        composer.gotoScene("scripts.story",{effect="fade"})
                    end 
                else
                    if (mydata.cstory>9) then
                        print( "home called" )
                        composer.removeHidden()
                        composer.gotoScene("scripts.home")
                    else
                        toast.new("Next story is locked",2000,sceneGroup_overlay)
                    end

                end
            elseif(mydata.type=="poem") then
                if(mydata.lock[mydata.poem_positions[mydata.cpoem+1]]==1 and mydata.cpoem<=6) then
                    mydata.cpoem=mydata.cpoem+1
                    if(mydata.cpoem<=7 and mydata.cpoem~=0) then
                        mydata.cbg=mydata.cpoem
                        if (mydata.dir==1) then
                            mydata.dir=0
                        else
                            mydata.dir=1
                        end
                        mydata.poem=mydata.cpoem
                    end
                        composer.hideOverlay()
                else
                    if (mydata.cpoem>6) then
                        print( "home called" )
                        composer.removeHidden()
                        composer.gotoScene("scripts.home")
                    else
                        toast.new("Next poem is locked",2000,sceneGroup_overlay)
                    end
                end            
            elseif(mydata.type=="game") then
                    if(mydata.lock[mydata.game_positions[mydata.cgame+1]]==1 and mydata.cgame<=5 ) then
                        mydata.cgame=mydata.cgame+1
                        if(mydata.cgame<=6 and mydata.cgame~=0) then
                            mydata.game=mydata.cgame
                            composer.removeHidden()
                            composer.gotoScene(mydata.ongame[mydata.cgame])
                        else
                        end
                    else
                        if (mydata.cgame>5) then
                            print( "home called" )
                            composer.removeHidden()
                            composer.gotoScene("scripts.home")
                        else
                            toast.new("Next game is locked",2000,sceneGroup_overlay)
                        end
                    end
            elseif(mydata.type=="fav") then
                print("fav length")
                print(mydata.favlength)
                 mydata.cfavorite=mydata.cfavorite+1
                

                print("current favorite:"..mydata.cfavorite.."")
               if(mydata.cfavorite <= mydata.favlength) then
                    if(mydata.onfavorite_type[mydata.cfavorite] == "story") then
                        mydata.story=mydata.onfavorite_index[mydata.cfavorite]
                        mydata.cbg=mydata.story
                       if(math.fmod( mydata.story, 2)==0)then
                        mydata.dir=0
                       else
                        mydata.dir=1
                       end
                    end
                    if(mydata.onfavorite_type[mydata.cfavorite] == "poem") then
                        mydata.poem=mydata.onfavorite_index[mydata.cfavorite]
                        mydata.cbg=mydata.poem
                        if(math.fmod( mydata.poem, 2)==0)then
                        mydata.dir=0
                       else
                        mydata.dir=1
                       end
                    end
                        if(mydata.onfavorite_type[mydata.cfavorite]==mydata.onfavorite_type[mydata.cfavorite-1]) then
                            composer.hideOverlay()
                        else
                        composer.removeHidden()
                    if(mydata.onfavorite_type[mydata.cfavorite] == "game") then
                        mydata.game=mydata.onfavorite_index[mydata.cfavorite]
                    end
                    if(mydata.onfavorite_type[mydata.cfavorite-1]) then
                        composer.gotoScene(mydata.onfavorite_name[mydata.cfavorite])
                        end
                    end
               else
                        composer.removeHidden()
                        composer.gotoScene("scripts.home")
               end
            elseif (mydata.currentscene<=22 and mydata.currentscene~=0) then
                mydata.currentscene= mydata.currentscene+1
                if (mydata.currentscene==3) then
                    mydata.cbg=1
                    mydata.dir=1
                    mydata.story=1
            
                end
                if (mydata.currentscene==6) then
                    mydata.cbg=2
                    mydata.dir=0
                    mydata.story=2
                   
                end
                if (mydata.currentscene==9) then
                    mydata.cbg=3
                    mydata.dir=1
                    mydata.story=3
                    
                end
                if (mydata.currentscene==12) then
                    mydata.cbg=4
                    mydata.dir=0
                    mydata.story=4
                    
                end
                if (mydata.currentscene==15) then
                    mydata.cbg=5
                    mydata.dir=1
                    mydata.story=5
                    
                end
                if (mydata.currentscene==18) then
                    mydata.cbg=6
                    mydata.dir=0
                    mydata.story=6
                    
                end
                if (mydata.currentscene==19) then
                    mydata.cbg=7
                    mydata.dir=1
                    mydata.story=7
                    
                end
                if (mydata.currentscene==20) then
                    mydata.cbg=8
                    mydata.dir=0
                    mydata.story=8
                    click1=3
                end
                if (mydata.currentscene==21) then
                    mydata.cbg=9
                    mydata.dir=1
                    mydata.story=9
                    click1=3
                end
                if (mydata.currentscene==22) then
                    mydata.cbg=10
                    mydata.dir=0
                    mydata.story=10
                    click1=3
                end
                if (mydata.currentscene==1) then
                    mydata.cbg=1
                    mydata.dir=1
                    mydata.poem=1
                end 
                if (mydata.currentscene==4) then
                    mydata.cbg=2
                    mydata.dir=0
                    mydata.poem=2
                end 
                if (mydata.currentscene==7) then
                    mydata.cbg=3
                    mydata.dir=1
                    mydata.poem=3
                end 
                if (mydata.currentscene==10) then
                    mydata.cbg=4
                    mydata.dir=0
                    mydata.poem=4
                end 
                if (mydata.currentscene==13) then
                    mydata.cbg=5
                    mydata.dir=1
                    mydata.poem=5
                end 
                if (mydata.currentscene==16) then
                    mydata.cbg=6
                    mydata.dir=0
                    mydata.poem=6
                end 
                if (mydata.currentscene==23) then
                    mydata.cbg=1
                    mydata.dir=1
                    mydata.poem=7
                end 
                scene_number=mydata.scene1[ mydata.currentscene]
                print("scene")
                print(mydata.currentscene)
                if(mydata.currentscene==3 or  mydata.currentscene==6 or mydata.currentscene==9 or mydata.currentscene==12 or mydata.currentscene==15 or mydata.currentscene==18 or mydata.currentscene==19 or mydata.currentscene==20 or mydata.currentscene==21 or mydata.currentscene==22)then 
                --
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
                                if(clik1==3)then
                                    composer.hideOverlay()
                                else
                                    nextis=false
                                    composer.gotoScene("scripts.story",{effect="fade"});
                                end
                            else
                            print( "File does not exist!" )
                            nextis=false
                            composer.gotoScene("scripts.download", {effect="fade", params={currentStory=storyIndex}, })
                            end
                    
                        end
                    else
                        composer.gotoScene("scripts.story",{effect="fade"})
                    end 
                    

                else
                nextis=false
                composer.removeHidden()
                composer.gotoScene(scene_number)
                --composer.hideOverlay()

                end
            else
                print( "home called" )
                composer.removeHidden()
                composer.gotoScene("scripts.home")
            end
        end
    end
end
function scene:create( event )
 sceneGroup_overlay= self.view
    overlay_group=display.newGroup()
    sceneGroup_overlay:insert(overlay_group)
    sheetInfo = require("scripts.menu_sprite")
    myImageSheet = graphics.newImageSheet( "assets/images/menu_sprite.png", sheetInfo:getSheet() )
    --mydata.cfavorite=mydata.favorite
    mydata.cstory=mydata.story
    mydata.cpoem=mydata.poem
    mydata.cgame=mydata.game
    window = display.newRoundedRect ( sceneGroup_overlay, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight+display.contentHeight/5, 0 )
    window:setFillColor (0,0,0)
    window.alpha = 0.7
    scroll1=display.newImageRect("assets/images/scroll_wh.png",display.contentWidth+display.contentWidth/3,display.contentHeight)
    scroll1.anchorX = .5
    scroll1.anchorY = 0.5
    scroll1.x=display.contentCenterX-display.contentWidth/35
    scroll1.y=display.contentCenterY
   -- if (mydata.isgame==false) then
        scroll1.y=display.contentCenterY
   -- else
    --    scroll1.y =display.contentCenterY+display.contentCenterY/3
    --end
    sceneGroup_overlay:insert(scroll1)
    local options = {
                                   text = mydata.messages[mydata.currentmsg],
                                   x = display.contentCenterX,
                                   y =display.contentCenterY-display.contentHeight/12,
                                   width = 510,
                                   font="Averia",
                                   fontSize = 13,
                                   align = "center",
                                    }
    local msg = display.newText(options)
    msg.align = "center"
    msg:setFillColor (155/255,55/255,5/255 )
    if (mydata.isgame==false) then
     --   msg.alpha=1
    else
      --  msg.alpha=1
    end
    sceneGroup_overlay:insert( msg)
    sheetInfo_control = require("scripts.controll_icons")
    myImageSheet_control = graphics.newImageSheet( "assets/images/controll_icons.png", sheetInfo_control:getSheet() )
    overlay_button1 = widget.newButton
    {
        width = display.contentHeight/10,
        height = display.contentHeight/11,
        defaultFile = "assets/images/button_1.png",
        overFile = "assets/images/button_2.png",
        onEvent = handleButtonEvent
    }
    overlay_button1.x = display.contentCenterX+display.contentCenterX/3
    overlay_button1.y =scroll1.y+display.contentHeight/7-- display.contentCenterY+display.contentCenterY/3
    overlay_button1.name="overlay_button1"
    overlay_button1.xScale=1.8
    overlay_button1.yScale=1.8
    sceneGroup_overlay:insert( overlay_button1 )
    overlay_settings1 = display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("fwrd_on"), 21,21)
    overlay_settings1.x=overlay_button1.x
    overlay_settings1.y=overlay_button1.y-5
    overlay_settings1.xScale=1
    overlay_settings1.yScale=1
    sceneGroup_overlay:insert(overlay_settings1)
    overlay_button2 = widget.newButton
    {
        width = display.contentHeight/10,
        height =display.contentHeight/11,
        defaultFile = "assets/images/button_1.png",
        overFile = "assets/images/button_2.png",
        onEvent = handleButtonEvent
    }
    overlay_button2.name="overlay_button2"
    overlay_button2.x = display.contentCenterX-display.contentCenterX/3
    overlay_button2.y =scroll1.y+display.contentHeight/7-- display.contentCenterY+display.contentCenterY/3
    overlay_button2.xScale=1.8
    overlay_button2.yScale=1.8
    sceneGroup_overlay:insert( overlay_button2 )
    settings2= display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("home"), 21,21)
    settings2.x=overlay_button2.x
    settings2.y=overlay_button2.y-5
    settings2.xScale=1
    settings2.yScale=1
    sceneGroup_overlay:insert(settings2)
    overlay_button3 = widget.newButton
    {
        width = display.contentHeight/10,
        height =display.contentHeight/11,
        defaultFile = "assets/images/button_1.png",
        overFile = "assets/images/button_2.png",
        onEvent = handleButtonEvent
    }
    overlay_button3.name="overlay_button3"
    overlay_button3.x = display.contentCenterX
    overlay_button3.y =scroll1.y+display.contentHeight/7-- display.contentCenterY+display.contentCenterY/3
    overlay_button3.xScale=1.8
    overlay_button3.yScale=1.8
    sceneGroup_overlay:insert( overlay_button3 )
    settings3= display.newImageRect( myImageSheet_control, sheetInfo_control:getFrameIndex("reset"), 21,21)
    settings3.x=overlay_button3.x
    settings3.y=overlay_button3.y-5
    settings3.xScale=1
    settings3.yScale=1
    sceneGroup_overlay:insert(settings3)
    if( mydata.lock[mydata.currentscene+1]==0 )then
        locked_item= display.newImageRect( myImageSheet, sheetInfo:getFrameIndex(frames[mydata.currentscene+1]), 120, 120 )
        locked_item.x=display.contentCenterX
        locked_item.y=scroll1.y-scroll1.contentHeight/4
        locked_item.fill.effect = "filter.desaturate"
        locked_item.fill.effect.intensity = 1
        sceneGroup_overlay:insert(locked_item)
        unlock_item= display.newImageRect("assets/images/lock_icon.png",display.contentWidth*.1/2,display.contentWidth*.15/2)
        unlock_item.x=locked_item.x
        unlock_item.y=locked_item.y
        sceneGroup_overlay:insert(unlock_item)
        msg.text="Excellent, you have unlocked "..mydata.all_scenes[mydata.currentscene+1]..""
        msg.y=display.contentCenterY
        mydata.lock[mydata.currentscene+1]=1
        jsn.saveTable(mydata.lock,"lock.json")
        transition.to( locked_item.fill.effect, { intensity = 0, time = 2000,delay=1000 })
        transition.to( unlock_item, { alpha=0, time = 2000,delay=1000 })
    else
        msg.alpha=0
        overlay_button1.x = display.contentCenterX+display.contentCenterX/3
        overlay_button1.y =scroll1.y
        overlay_button2.x = display.contentCenterX-display.contentCenterX/3
        overlay_button2.y =scroll1.y
        overlay_button3.x = display.contentCenterX
        overlay_button3.y =scroll1.y
        overlay_settings1.x=overlay_button1.x
        overlay_settings1.y=overlay_button1.y-5
        settings3.x=overlay_button3.x
        settings3.y=overlay_button3.y-5
        settings2.x=overlay_button2.x
        settings2.y=overlay_button2.y-5
    end
end
function scene:show( event )
    local sceneGroup_overlay= self.view
    if ( phase == "did" ) then
                       
    end
end
function scene:hide( event )
    local sceneGroup_overlay = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object
    if ( phase == "will" ) then

       if (click==2) then
            parent:resume()
        end
       if(nextis==true)then
        parent:next()
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