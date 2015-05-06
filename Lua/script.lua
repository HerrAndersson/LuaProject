screenWidth = 1200;
screenHeight = 800;
player = {}
player["velX"] = 0
player["velY"] = 0
playerSpeed = 3

dimensions = 40
worldWidth = 30
worldHeight = 20

levelnum = 0 --if this is 0, make the used choose a level
gamemodes = { "game", "editor", "won" } --game until player reaches goal, then won. won takes the game back to level select. editor when space is pressed
gamemode = gamemodes[1]

world = {}
world[1] =  {3, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 1, 2, 2, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 1}
world[2] =  {2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 1, 2, 1}
world[3] =  {2, 1, 2, 2, 1, 2, 2, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1}
world[4] =  {2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 1, 1, 2, 2, 1, 1, 2, 2, 2, 2}
world[5] =  {2, 2, 2, 2, 1, 2, 2, 2, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 1, 1, 2, 2, 1, 1, 2}
world[6] =  {1, 1, 2, 2, 1, 1, 1, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 1, 2, 2, 1, 2}
world[7] =  {1, 1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 1, 1, 2, 1, 1}
world[8] =  {2, 2, 1, 1, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 1, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2}
world[9] =  {1, 2, 1, 2, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 2, 1, 2, 2, 2, 2, 1, 1, 2, 1, 2, 1, 1, 1, 2}
world[10] = {1, 2, 2, 2, 1, 1, 2, 2, 2, 1, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 1, 1}
world[11] = {1, 1, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 1, 2, 2, 2, 1, 2, 2, 1}
world[12] = {2, 2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1}
world[13] = {2, 1, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 2, 2}
world[14] = {2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1}
world[15] = {1, 1, 1, 2, 2, 2, 1, 2, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 2, 2, 1, 2, 1, 1, 1}
world[16] = {2, 2, 1, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 2, 2, 2, 1, 2, 1, 2, 2, 2, 1}
world[17] = {1, 2, 2, 2, 1, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 2}
world[18] = {1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 1, 1, 2, 2, 2, 1, 2, 1, 2, 2, 2, 1, 1, 2}
world[19] = {2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 2, 2, 2, 2}
world[20] = {1, 2, 2, 2, 1, 2, 1, 2, 2, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 1, 1, 2, 4}

function keyHandler(code, isKeyDown)
	local var = code

	if(var == 3) then
		if(isKeyDown) then
			player["velX"] = playerSpeed
		else
			player["velX"] = 0
		end
	elseif(var == 0) then
		if(isKeyDown) then
			player["velX"] = -playerSpeed
		else
			player["velX"] = 0
		end
	elseif(var == 22) then
		if(isKeyDown) then
			player["velY"] = -playerSpeed
		else
			player["velY"] = 0
		end
	elseif(var == 18) then
		if(isKeyDown) then
			player["velY"] = playerSpeed
		else
			player["velY"] = 0
		end
	elseif(var == 11) then
		local int = "1"
		loadLevel(int)
	elseif(var == 57) then
		if(gamemode == gamemodes[1]) then
			gamemode = gamemodes[2]
		elseif(gamemode == gamemodes[2]) then
			gamemode = gamemodes[1]
		else
		end
	end

	return var
end

function collisionTesting(x, y, type)
	local centerCoordX = math.floor((player["x"] + x + player["radius"]) / dimensions) + 1
	local centerCoordY = math.floor((player["y"] + y + player["radius"]) / dimensions) + 1
	if(world[centerCoordY][centerCoordX] == 4) then
		-- call "you is winner" function
	end
	
	local leftCoordX = math.floor((player["x"] + x) / dimensions) + 1
	local rightCoordX = math.floor(((player["x"] + x) + player["radius"] * 2) / dimensions) + 1
	local topCoordY = math.floor((player["y"] + y) / dimensions) + 1
	local bottomCoordY = math.floor(((player["y"] + y) + player["radius"] * 2) / dimensions) + 1
	
	if(x ~= 0) then
		if(leftCoordX < 1 or rightCoordX > worldWidth ) then
			x = 0
		elseif(world[bottomCoordY][rightCoordX] == type or world[topCoordY][rightCoordX] == type or world[bottomCoordY][leftCoordX] == type or world[topCoordY][leftCoordX] == type) then
			x = 0
		end
	end
	
	if(y ~= 0) then
		if(topCoordY < 1 or bottomCoordY > worldHeight) then
			y = 0
		elseif(world[bottomCoordY][leftCoordX] == type or world[bottomCoordY][rightCoordX] == type or world[topCoordY][leftCoordX] == type or world[topCoordY][rightCoordX] == type) then
			y = 0
		end
	end
	return x, y
end

function move(x, y)
	x,y = collisionTesting(x, y, 1)
	moveC(x, y)
	return 1
end

function update(playerPosX, playerPosY, playerRadius)
	player["x"] = playerPosX
	player["y"] = playerPosY
	player["radius"] = playerRadius
	
	move(player["velX"], player["velY"])
end

function render()

	clearWindowC();

	for i=1, worldHeight, 1
	do
		for j=1, worldWidth, 1
		do
			drawSquareC((j-1) * dimensions, (i-1) * dimensions, dimensions, world[i][j]);
		end
	end

	if(gamemode == gamemodes[1]) then
		drawPlayerC()
	end

	drawTextC("Hello", (screenWidth/2) - 20, (screenHeight/2) - 20)
		
	displayWindowC();

	return 1;
end

function fileExists(int)
   local f=io.open(int,"r")
   if f~=nil then io.close(f) return true else return false end
end

function loadLevel(int)
	file = fileExists(int)
	if file == false then 
		clearLvl = assert(loadfile("clearLvl.lua"))
		clearLvl(int)
	end
	file = io.open(int,"r")
	file:read	 
end
