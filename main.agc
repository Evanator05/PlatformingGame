// Project: Test Game 
// Created: 2020-09-30

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "Platformer Game" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts


//    Vars     //

//Player Stuff
x = GetVirtualWidth()/2+pSize*32/2
y = GetVirtualHeight()
spd = 10 //the players movement speed
maxspd = 30 //max player speed
grav = 3
jumpforce = 25
xvol = 0 // the x volocity for the player
yvol = 0// the y volocity for the player
pSize = 2 //player size
pColour = MakeColor(0,0,255) // Player Colour
alive = 1

//Coin Stuff
coins = 0
cX = Random(0,GetVirtualWidth())
cY = Random(0,GetVirtualWidth())
cColour = MakeColor(255,255,0)
cSize = 1
cDirX = 1 // Coin X direction
cDirY = 1 // Coin Y direction

//Enemy Stuff
eX = x
eY = y-500
espd = 5
eColour = MakeColor(255,0,0)
eSize = 2

backGroundColour = MakeColor(107,107,107)

//       Code starts here      //

do
	DrawBox(0,0,GetVirtualWidth(),GetVirtualHeight(),backGroundColour,backGroundColour,backGroundColour,backGroundColour,1)
    //Player Stuff
    
    //Draw Player
	DrawBox(x,y,x+pSize*32,y+pSize*32,pColour,pColour,pColour,pColour,1)
	
	if alive = 1
		if GetRawKeyState(39) = 1 //Make Player Move Right
			xvol = spd
		elseif GetRawKeyState(37) = 1 //Make Player Move Left
			xvol = -spd
		else
			xvol = 0
		endif
	
		if GetRawKeyPressed(38) = 1 //Make Player Jump
			yvol = yvol - jumpforce
		endif
	endif
	if yvol < maxspd //Gravity
		yvol = yvol + grav
	endif

	//Collisions
	if x+xvol < 0
		xvol = 0
		x = 0
	endif
	
	if x + pSize*32+xvol > GetVirtualWidth()
		xvol = 0
		x = GetVirtualWidth() - pSize*32
	endif
	
	if y + pSize*32+yvol > GetVirtualHeight()
		yvol = 0
		y = GetVirtualHeight() - pSize*32
	endif
	
	if y+yvol < 0
		yvol = 0
		y = 0
	endif
	
	//Move Player
	x = x+xvol
	y = y+yvol
	
	//Coin Stuff
	
	//Draw Coin
	Print(coins)
	DrawBox(cX,cY,cX+cSize*32,cY+cSize*32,cColour,cColour,cColour,cColour,1)
	
	//Collisions
	if x+pSize*32 > cX and x < cX+cSize*32 and y+pSize*32 > cY and y < cY+cSize*32
		coins = coins + 1
		cX = Random(0,GetVirtualWidth())
		cY = Random(0,GetVirtualWidth())
	endif
	
	// Bounce Coin Off Walls
	
	if cX+cSize*32 > GetVirtualWidth()
		cDirX = -1
	endif
	if cX < 0
		cDirX = 1
	endif
	if cY+cSize*32 > GetVirtualHeight()
		cDirY = -1
	endif
	if cY < 0
		cDirY = 1
	endif
	
	// Change Coin X and Y
	cX = cX + 5*cDirX
	cY = cY + 5*cDirY

	//Enemy Stuff
	
	//Draw Enemy
	DrawBox(eX,eY,eX+eSize*32,eY+eSize*32,eColour,eColour,eColour,eColour,1)
	
	//Move Enemy
	if (x+pSize*32)/2 < (eX+eSize*32)/2
		eX = eX-espd
	endif
	if (x+pSize*32)/2 > (eX+eSize*32)/2
		eX = eX+espd
	endif
	if (y+pSize*32)/2 < (eY+eSize*32)/2
		eY = eY-espd
	endif
	if (y+pSize*32)/2 > (eY+eSize*32)/2
		eY = eY+espd	
	endif

	//Collisions
	if x+pSize*32 > eX and x < eX+eSize*32 and y+pSize*32 > eY and y < eY+eSize*32
		alive = 0
		pColour = MakeColor(255,100,50)
		xvol = 0
	endif
	
    Sync()
loop
