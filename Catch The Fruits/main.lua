 -- Catch The Fruits Project by Sheikh Asad Muneer

------------------------------------------------------------
-- Variables
local creditScreen
local menu
local  replay
local ball
local group
local dTime = 1500
local dTimer = system.getTimer()
local gameIsActive = false
local picVar = false
local whenBug = audio.loadSound("audio/wrong.mp3")
local whenFruit = audio.loadSound("audio/correct.mp3")
local whenPlay = audio.loadSound("audio/tapsound.wav")
local _W = display.contentWidth
local _H = display.contentHeight
local scoreDisplay = 0
local chances = 4
local score = 0
local defaultWidth = 1024
local defaultHeight = 768
local displayWidth = display.viewableContentWidth
local displayHeight = display.viewableContentHeight
local yMargin = 130
local yMargin2 = -15
local asadMargin = -40 
local bukketMargin = 270
local centerX = defaultWidth/2;
local centerY = defaultHeight/2;
local xAdjust = (defaultWidth - display.viewableContentWidth)/2
local yAdjust = (defaultHeight - display.viewableContentHeight)/2
local playButton
local oldScreen
local newScreen
local homeEnabled = true
local bukketEnabled = true
local playEnabled = true
local bukket
local creditEnabled = true
local infoEnabled = true
local physics = require("physics")
--physics.start()

local background
local title 
local playButton
local credits
local info
------------------------------------------------------------
-- Game Functions

function launch()
	-- hide status bar of mobile--
	display.setStatusBar(display.HiddenStatusBar)	
	-- create launch screen
	addLaunchScreen()
	newScreen = launchScreen
	
end

function addLaunchScreen()



	--oldScreen = newScreen


	launchScreen = display.newGroup()
	launchScreen.x = centerX
	launchScreen.y = centerY
	 --print("display width = "..displayWidth);
	-- add background
	 background = display.newImageRect("images/graphics/polar.png", 1024, 768, true)
	launchScreen:insert(background)

	-- add title
	  title = display.newImageRect("images/graphics/logo.png", 970, 185, true)
	launchScreen:insert(title)
	title.y = -displayHeight/2 + title.height/2 - yMargin2


 	-- add playbutton
	  playButton = display.newImageRect("images/graphics/play.png", 565, 419, true)
	playButton.y = -displayHeight/2 + playButton.height/2 + yMargin
	playButton:addEventListener("touch", onPlayTouch)
	launchScreen:insert(playButton)

	-- add credits button --
 	  credits = display.newImageRect("images/graphics/credit.png", 154, 102, true)
	credits.x = -defaultWidth/2 + yMargin
	credits.y =displayHeight/2 + credits.height/2 + yMargin2-80
	credits:addEventListener("touch", onCreditsTouch)
 	launchScreen:insert(credits)
 
 	--  add info button --
	info = display.newImageRect("images/graphics/info.png", 154, 102, true)
	info.x = defaultWidth/2 - yMargin
	info.y =displayHeight/2 + info.height/2 + yMargin2-80
	info:addEventListener("touch", onInfoTouch)
  	launchScreen:insert(info)
 	 



 	--transitionIn(launchScreen)
	--transitionOut(oldScreen)


end
 
 function lastTry()
 	-- body

 	oldScreen = newScreen

 	addLaunchScreen()
	newScreen = launchScreen


	-- do transitions
	transitionIn(background)
	transitionIn(title)--logo
	transitionIn(playButton)
	transitionIn(info)
	transitionIn(credits)
	transitionOut(creditScreen)
	


	-- enable play button
	playEnabled = true



 end


function addWoodenBukket()
	bukketEnabled = true
	bukket = display.newImage("images/graphics/wooden bucket1.png",210, 104)	
	bukket.y= displayHeight/2 + bukket.height/2 + bukketMargin
	bukket.x = defaultWidth/2;
	
	physics.addBody( bukket, "static",{friction = 0.8,bounce = 0.5})
	--{ density=0.6, friction=0.6, bounce=0.6, radius=19 } 
		---physics.addBody( bukket,  "dynamic",{ density=3.0, friction=0.5, bounce=0.3 } )
	bukket.id = 'myBucket'
	bukket.myName = "bukket"
 
	-- add touch event on bucket --
    bukket.touch = moveBucket
    bukket:addEventListener( "touch", bukket )
 
end

--touch listener function on bucekt --

 function moveBucket( self , event )
  if event.phase == "began" then
  	 
    -- first we set the focus on the object
    display.getCurrentStage():setFocus( self, event.id )
    self.isFocus = true
 
    -- then we store the original x and y position
    self.markX = self.x
   -- self.markY = self.y
 	
   --local speed = 1500/_W;

  elseif self.isFocus then
 
    if event.phase == "moved" then
      -- then drag our object 
      if(event.x>115 and event.x<925)then

      self.x = (event.x - event.xStart )+ self.markX
      --print("chala")
     -- print(event.x)
  end
     
     -- self.y = event.y - event.yStart + self.markY

    elseif event.phase == "ended" or event.phase == "cancelled" then
      -- we end the movement by removing the focus from the object
      display.getCurrentStage():setFocus( self, nil )
      self.isFocus = false
    end
 
  end
 
-- return true so Corona knows that the touch event was handled propertly
 return true
end


--catch the fruits main gameLoop

local gameLoop = function ()  -- put this below randomBall function

  if gameIsActive then


 
    local t = system.getTimer() 
 	-- :P --
 	  	if(chances ==0)then

			--bukket.y = 1800
			menu.alpha = 1
			replay.alpha = 1
			ovi.alpha = 1
			finalScoreDisplay.alpha=1
			--finalScoreDisplay.alpha=1
		finalScoreDisplay.text = "You Scored "..score

  			Runtime:removeEventListener("enterFrame" , gameLoop)
		   	display.remove(ball)
		   	ball = nil
		   	display.remove(bukket)
		   	bukket = nil

 
	

			-- gameover logic here -- 

        --onGameOver()
        end




    if t - dTimer > dTime then
  
        dTimer = system.getTimer()

        
		randomBall()
        --game over logic here --
       
        -- fruit falling speed logic here --

        if (score>100 and score<200) then
        	dTime = 800

        elseif (score>200 and score<300) then
        	dTime = 750

        	elseif(score>300 and score<400 ) then
        		dTime = 700

        		elseif(score>400 and score<500) then
        			dTime = 650

        			elseif(score>500 and score<600) then
        				dTime =600
        				elseif(score>600 and score<700) then
        					dTime = 550
        					elseif(score>700 and score<900)then
        						dTime = 500
        					elseif(score>900 and score <1100)then
        							dTime = 450
        					elseif(score>1100 and score <1500 )then
        							dTime = 400

        					elseif(score>1500 )then
        								dTime = 300

        					end

       
    end
 
  end
  
end -- function ends here -- 


------------ GAME PLAY SCREEN ----------- 
    
function nQuestion()
	-- update screen var
	oldScreen = newScreen
	gamePlay = display.newGroup()
	-- add new image (background image)
	newScreen = display.newImageRect("images/graphics/try2.jpg",1280, 840,true)
	newScreen.x = centerX
	newScreen.y = centerY
	gamePlay:insert(newScreen)



	 -- (ground image for object detection)
	ground = display.newImage("images/graphics/ground.png",1100,20)	
	ground.y= displayHeight/2 + ground.height/2 + bukketMargin + 100
	--ground.y = displayHeight/2 - ground.height/2
	ground.x = defaultWidth/2;
	ground.alpha = 0.0
	physics.addBody( ground, "static",{friction = 0.8})
	ground.id = 'ground'
	ground.myName = "ground"
	gamePlay:insert(ground)

 
 	-- red hearts on top right 
	L1 = display.newImage("images/graphics/life.png",60,60)	
	--L1.y= displayHeight/2 + ground.height/2 + bukketMargin + 100
	L1.y = yAdjust + L1.height/2
	L1.x = L1.x + 750
	L1.alpha = 1
	gamePlay:insert(L1)
	--L1.x = defaultWidth/2;

	L2 = display.newImage("images/graphics/life.png",60,60)	
	L2.y = yAdjust + L2.height/2
	L2.x = L1.x + 60
	L2.alpha = 1
	gamePlay:insert(L2)

	L3 = display.newImage("images/graphics/life.png",60,60)	
	L3.y = yAdjust + L3.height/2
	L3.x = L2.x + 60
	L3.alpha = 1
	gamePlay:insert(L3)

	L4 = display.newImage("images/graphics/life.png",60,60)	
	L4.y = yAdjust + L4.height/2
	L4.x = L3.x + 60
	L4.alpha = 1
	gamePlay:insert(L4)


	
 
	-- do transitions
	transitionIn(newScreen)
	transitionOut(oldScreen)


	------------------------------------------------------------
	-- Simple scoring display during gameplay
    scoreDisplay = display.newText( "SCORE :", 100, 100, "Segoe Script", 40 ) -- no need to use extension here
 	scoreDisplay.alpha = .9
	scoreDisplay.y = yAdjust + scoreDisplay.height/2
	--print("x axis :"..homeButton.x)
	scoreDisplay.x = scoreDisplay.x + 35

 	score  = 0 
 	chances = 4




	--copyright.y = displayHeight/2 - copyright.height/2
 


 			--no need  use extension here
    finalScoreDisplay = display.newText( "YOU SCORED : ", 100, 100, "Segoe Script", 70 ) 
    finalScoreDisplay.text = "YOU SCORED : "..score
  	finalScoreDisplay.x  = centerX 
  	finalScoreDisplay.y = 	centerY  


  	     	-- add new image
	ovi = display.newImageRect("images/graphics/overlay.png",950, 400,true)
	ovi.x = centerX
	ovi.y = centerY	 -30

			-- add credits button --
 	replay = display.newImageRect("images/graphics/replay.png", 154, 102, true)
	replay.x = centerX + 102
	replay.y =centerY + 102 
	replay:addEventListener("touch", onReplay )


  			-- add credits button --
 	menu = display.newImageRect("images/graphics/menu.png", 154, 102, true)
	menu.x = centerX -102--950/2 + yMargin
	menu.y =centerY + 102--400/2 + menu.height/2 + yMargin2-80
	menu:addEventListener("touch", goHome )
			--ground:removeSelf()

	-- initially hide gameover screen vars--
	menu.alpha = 0
	replay.alpha = 0
	ovi.alpha = 0
	finalScoreDisplay.alpha=0


	-- add gameover vars into a group --
 	group = display.newGroup()
	group:insert(ovi)
	group:insert(finalScoreDisplay)
	group:insert(menu)
	group:insert(replay)


	-- do transitions
	--transitionIn(newScreen)
	--transitionOut(oldScreen)
 
 
	--bring bucket to front--
	bukket:toFront()
	--addPauseButton()
	-- whenBug = audio.loadSound("audio/wrong.mp3")
    --print(dTimer)
    -- game over logic here --
    --if(chances ==0)then

     -- make gameplay TRUE  	
	 gameIsActive = true 


	 -- ******							-- ******
	 -- ******							-- ******
	 -- ******							-- ******
	 Runtime:addEventListener("enterFrame",gameLoop)  
 	-- ******							-- ******
 	-- ******							-- ******
 	-- ******							-- ******

end
 
function makeCreditsScreen()
	-- body


	oldScreen = newScreen


	 creditScreen = display.newGroup()
	creditScreen.x = centerX
	creditScreen.y = centerY
	  
	-- add background
	local bg = display.newImageRect("images/graphics/creditsOverlay.jpg", 1024, 768, true)
	creditScreen:insert(bg)


	local backbtn = display.newImageRect("images/graphics/back.png", 154, 102, true)
	backbtn.x = -defaultWidth/2 + yMargin  
	backbtn.y =displayHeight/2 + backbtn.height/2 + yMargin2-80
	backbtn:addEventListener("touch", onbackbtnTouch)
 	creditScreen:insert(backbtn)
 

 transitionIn(creditScreen)
	transitionOut(oldScreen)



end
 

 -- function to drop random fruits
 function randomBall( )
 	 
 	choice = math.random( 10)
	
 	
 	 --choice = 8
		--print("else chala ")
      
		if ( choice ==1	)then
       		ball = display.newImage( "images/fruits/fruit_banana.png",100,100,true )
	   		ball.id = '1'
        
   		 elseif ( choice ==2 ) then
        	ball = display.newImage( "images/fruits/fruit_grape.png" ,100,100,true )
		  	ball.id = '1'
         


		elseif ( choice ==3 ) then
	    	ball = display.newImage( "images/fruits/fruit_pineapple.png",100,100,true )
		  	ball.id = '1'
         
 

		elseif ( choice ==4 ) then
	   	 ball = display.newImage( "images/fruits/fruit_or.png" ,100,100,true)
		 ball.id = '1'
        
        elseif ( choice ==5 ) then
	   	 ball = display.newImage( "images/fruits/fruit_coc.png" ,100,100,true)
		 ball.id = '1'

		 elseif ( choice ==6 ) then
	   	 ball = display.newImage( "images/fruits/fruit_water.png" ,100,100,true)
		 ball.id = '1'


		 elseif ( choice ==7 ) then
	   	 ball = display.newImage( "images/fruits/fruit_appr.png" ,100,100,true)
		 ball.id = '1'

 
	else

	    ball = display.newImage( "images/fruits/ladybug.png",100,100,true)
		ball.id = '0'

 
	end

 	 ball.x = 40 + math.random( 40,650 )
   	 ball.y = -40
	 physics.addBody( ball, { density=0.6, friction=0.6, bounce=0.6, radius=19 } )
	 ball.myName = "ball"
	 --ball.angularVelocity = math.random(800) - 400

 

	-- ball:addEventListener("collision",ball)
	

  	 ball.collision = onGlobalCollision
  	 ball:addEventListener( "collision", ball )

		--print("ball id :"..ball.id);
		
	end -- else ends
 

local function onGlobalCollision(  event )
	

	local t = event.object2
	local check = event.object1
	--print(t.id)

	-- local phase = event.phase

	if ( event.phase == "began" ) then

		--print( "Global report: " .. event.object1.myName .. " & " .. event.object2.myName .. " collision began" )
		if(check.myName == "bukket")then

				-- fruit touches bucket --

				if(t.id == '1')then

					-- audio.play(whenFruit)
			 -- print("chaala")
			--scoreDisplay = scoreDisplay + 1
				score = score + 10
				scoreDisplay.text = "SCORE : "..score
				-- remove fruit -- 
				t:removeSelf() -- destroy object

  
				showMe = display.newText( "+ 10 ", 100, 100, "Segoe Script", 60 ) 
				showMe.x = t.x
    	    	showMe.y = t.y - 50
    	   	

    	   			local w = math.random( 10)

    	   		if(w==1)then
    	   			tareef = display.newImageRect("images/graphics/wow.png",197, 60, true)
    	   			picVar = true
    	   			elseif(w==2)then
    	   				tareef = display.newImageRect("images/graphics/great.png",228, 50, true)
    	   				picVar = true
    	   				elseif (w==3)then
    	   					tareef = display.newImageRect("images/graphics/champ.png",399, 50, true)
    	   					picVar = true
    	   		end

    	   		if(picVar == true)then
				tareef.x = t.x
    	    	tareef.y = t.y - 200
    	    	end

    	   		 

    	   		showMe:setTextColor(250, 250, 0)


				local anim;

				anim = transition.to(showMe,{
					

				time = 2000,
				y = t.y - 250,
				transition = easing.outQuad,
				alpha=0.0
				--showMe = u

 

				});



					anim = transition.to(tareef,{
					

				time = 2000,
				y = t.y - 400,
				transition = easing.outQuad,
				alpha=0.0
				--showMe = u

 

				});

 
 
			 -- bug meets bucket -- :P 
			elseif(t.id == '0')then

			--	media.playSound("audio/wrong.mp3")
				audio.play(whenBug)



				score = score - 10
				scoreDisplay.text = "SCORE :"..score

				t:removeSelf() -- destroy object

				showMe =display.newText( "-  10 ", 100, 100, "Segoe Script", 60 ) 
				showMe.x = t.x
    	    	showMe.y = t.y - 50
    	    	--showMe:setFillColor( red )
    	    	--showMe:setFillColor( 0.5, 0.2, 0.2 )
    	    	showMe:setTextColor(250, 0, 0)



    	   

				local anim;

				anim = transition.to(showMe,{
				time = 2000,
				y = t.y - 400,
				transition = easing.outQuad,
				alpha=0.0
				});

				-- make heart a bit transparent -- 
				if(chances == 4 )then
					L4.alpha = 0.5
					chances = chances -1
				elseif(chances == 3 )then
					L3.alpha = 0.5
					chances = chances -1
				elseif(chances == 2 )then
					L2.alpha = 0.5
					chances = chances -1
				elseif(chances == 1 )then
					L1.alpha = 0.5
					chances = chances -1
				 end
				  

			end
		 

	end -- // check condition if ends //


		


	elseif(check.myName == "ground")then  -- // phase  condition if ends //

	--print("Yeahh")


		-- fruit falls on ground --
		if(t.id == '1')then

				 --audio.play(whenBug)

			 -- print("chaala")
			--scoreDisplay = scoreDisplay + 1
				score = score - 10
				--scoreDisplay.text = score
				scoreDisplay.text = "SCORE :"..score

				t:removeSelf() -- destroy object

				showMe = display.newText( "- 10 ", 0, 0, "Segoe Script", 60 )
				showMe.x = t.x
    	    	showMe.y = t.y - 50

    	    	showMe:setTextColor(250, 0, 0)
    	   

				local anim;

				anim = transition.to(showMe,{


				time = 2000,
				y = t.y - 400,
				transition = easing.outQuad,
				alpha=0.0

 

				});
			 --transition.to( showMe, {time=490, alpha=0.1})

			
 

			elseif(t.id == '0')then
				 

				t:removeSelf() -- destroy object
 
    	    


			end




	end


	-- Stop further propagation of touch event
	return true
end

 Runtime:addEventListener( "collision", onGlobalCollision )
 
function goHome()

native.requestExit()

end
 

-- TRANSITIONS

function transitionIn(target)
	transition.from(target, {time = transitionDuration, x = defaultWidth + centerX, transition=easing.inOutExpo})
end

function transitionOut(target)
	transition.to(target, {time = transitionDuration, x = -centerX, transition=easing.inOutExpo, onComplete = demo})
end

function onTransitionOutComplete(target)
	target:removeSelf()
	target = nil
end
function transitionOutDEMO(target)
	transition.to(target, {time = transitionDuration, x = -centerX, transition=easing.inOutExpo})
end

 

------------------------------------------------------------
-- EVENTS

function  goBack()
	 
	oldScreen = newScreen
	addLaunchScreen()

	newScreen = launchScreen

	-- do transitions
	transitionIn(newScreen)
	transitionIn(title)
	transitionIn(playButton)
	transitionIn(credits)
	transitionIn(info)
	transitionOut(oldScreen)
	--transitionOut(homeButton)

	

end


function onbackbtnTouch( event)

	if "ended" == event.phase  then
 		    audio.play(whenPlay)

 	 		--transitionOut(creditScreen)
			 lastTry()


	end

	 


end


function onPlayTouch(event)


	

	if "ended" == event.phase and playEnabled == true then
		
		    audio.play(whenPlay)
		    playEnabled = false		
	 		physics.start()
			-- add wodden bukket
			addWoodenBukket()
			-- :P


			transitionOut(title)
			transitionOut(credits)
			transitionOut(info)
			transitionOut(playButton)
			nQuestion()
	end
end

function onReplay(event)
		-- make them disappear
		menu.alpha = 0
		replay.alpha = 0
		ovi.alpha = 0
		finalScoreDisplay.alpha=0
		finalScoreDisplay.text = score

	if "ended" == event.phase  then
		-- print("asad")
		-- removes overlay 
	    display.remove( group )
	    -- adds bucekt --
		addWoodenBukket()
		-- reset vals--
	 	chances=4
		score=0
		dTime = 1500
		--calls gameloop func --
		nQuestion()
		 		 
	end
end





function onCreditsTouch(event)


	if "ended" == event.phase  then
 	audio.play(whenPlay)

 	 		transitionOut(title)
			transitionOut(credits)
			transitionOut(info)
			transitionOut(playButton)
			makeCreditsScreen()


	end

	 
 	--transitionOut(background)
 	--transitionIn(creditScreen)

 
  
end


function makeInfoScreen()
	-- body

	oldScreen = newScreen


	 creditScreen = display.newGroup()
	creditScreen.x = centerX
	creditScreen.y = centerY
	  
	-- add background
	local bg = display.newImageRect("images/graphics/infooverlay.jpg", 1024, 768, true)
	creditScreen:insert(bg)


	local backbtn = display.newImageRect("images/graphics/back.png", 154, 102, true)
	backbtn.x = -defaultWidth/2 + yMargin  
	backbtn.y =displayHeight/2 + backbtn.height/2 + yMargin2-80
	backbtn:addEventListener("touch", onbackbtnTouch)
 	creditScreen:insert(backbtn)
 

 transitionIn(creditScreen)
	transitionOut(oldScreen)


end


function onInfoTouch(event)


	if "ended" == event.phase  then
 	audio.play(whenPlay)

 	 		transitionOut(title)
			transitionOut(credits)
			transitionOut(info)
			transitionOut(playButton)
			makeInfoScreen()


	end

	 
 	--transitionOut(background)
 	--transitionIn(creditScreen)

 
  
end
 
 ------------------------------------------------------------
-- Start app

launch()
