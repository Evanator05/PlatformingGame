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


x = 150
y = 10
spd = 10 //the players movement speed
maxspd = 30 //max player speed
grav = 3
jumpforce = 25
xvol = 0 // the x volocity for the player
yvol = 0// the y volocity for the player
pSize = 2 //player size
do
    
	DrawBox(x,y,x+pSize*32,y+pSize*32,MakeColor(255,0,0),MakeColor(255,0,0),MakeColor(255,0,0),MakeColor(255,0,0),1)
	if GetRawKeyState(39) = 1
		xvol = spd
	elseif GetRawKeyState(37) = 1
		xvol = -spd
	else
		xvol = 0
	endif
	if GetRawKeyPressed(38) = 1
		yvol = yvol - jumpforce
	endif
	
	if yvol < maxspd
		yvol = yvol + grav
	endif
	
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
	
	x = x+xvol
	y = y+yvol
    Sync()
loop
