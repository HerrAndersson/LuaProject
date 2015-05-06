screenWidth = 1200;
screenHeight = 800;
player = {}
player["velX"] = 0
player["velY"] = 0
playerSpeed = 3
lockRender = false;
lockKeys = false;
currentLevel = 1;
worldPos={}
worldPos["x"] = 1
worldPos["y"] = 1
dimensions = 40
worldWidth = 30
worldHeight = 20

levelnum = 0 --if this is 0, make the used choose a level
gamemodes = { "game", "editor", "won" } --game until player reaches goal, then won. won takes the game back to level select. editor when space is pressed
gamemode = gamemodes[1]

world = {}

function keyHandler(code, isKeyDown)
	local var = code
	if(lockKeys == false) then
		if(gamemode==gamemodes[1]) then
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
			elseif(var == 60) then	
				gamemode = gamemodes[2]
			elseif(var > 25 and var < 36) then
				currentLevel = tostring(var - 26)
				loadLevel(currentLevel)
			end
		elseif(gamemode==gamemodes[2]) then			
			if(var == 3) then
				if(worldPos["x"] < worldWidth) then
					worldPos["x"] = worldPos["x"] + 1
			end
			elseif(var == 0) then
				if(worldPos["x"] > 1) then
					worldPos["x"] = worldPos["x"] - 1
				end
			elseif(var == 22) then	
				if(worldPos["y"] > 1) then
					worldPos["y"] = worldPos["y"] - 1
				end
			elseif(var == 18) then
				if(worldPos["y"] < worldHeight) then
					worldPos["y"] = worldPos["y"] + 1
				end
			elseif(var >26 and var < 31) then
				world[worldPos["y"]][worldPos["x"]]= var -26
			elseif(var == 60) then	
				gamemode = gamemodes[1]
			end
		end 
	end
	return var
end

function collisionTesting(x, y, type)
	local centerCoordX = math.floor((player["x"] + x + player["radius"]) / dimensions) + 1
	local centerCoordY = math.floor((player["y"] + y + player["radius"]) / dimensions) + 1
	if(world[centerCoordY][centerCoordX] == 4) then
		gameWon()
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

function gameWon()
	lockKeys = true;
	drawTextC("YOU WON!", (screenWidth/2), (screenHeight/2))
	displayWindowC();
	sleepFuncC(2)
	loadLevel(currentLevel)
	lockKeys = false;
end

function place(x, y)
	placeC(x, y)
	return 1
end

function move(x, y, testForCollisions)
	if(testForCollisions) then
		x,y = collisionTesting(x, y, 1)
	end
	moveC(x, y)
	return 1
end

function update(playerPosX, playerPosY)
	player["x"] = playerPosX
	player["y"] = playerPosY
	
	move(player["velX"], player["velY"], true)
end

function render()

	clearWindowC();

	if(lockRender == false) then
		for i=1, worldHeight, 1
		do
			for j=1, worldWidth, 1
			do
				drawSquareC((j-1) * dimensions, (i-1) * dimensions, dimensions, world[i][j]);
			end
		end

		if(gamemode == gamemodes[1]) then
			drawPlayerC()
		elseif(gamemode == gamemodes[2]) then
			drawSquareC(((worldPos["x"] - 1) * dimensions) + 15, ((worldPos["y"] - 1) * dimensions) + 15, 10, 0);
		end			
		displayWindowC();
	end
	return 1;
end

function fileExists(int)
   local f=io.open(int,"r")
   if f~=nil then io.close(f) return true else return false end
end

function loadLevel(int)
	lockRender = true;
	file = fileExists(int)
	if file == false then 
		clearLvl = assert(loadfile("clearLvl.lua"))
		clearLvl(int)
	end
	lvl = assert(loadfile(int))
	lvl()
	
	for y = 1, worldHeight, 1 do
		for x = 1, worldWidth, 1 do
			if(world[y][x] == 3) then
				local playerOffset = dimensions / 2 - player["radius"]
				place((x - 1) * dimensions + playerOffset, (y - 1) * dimensions + playerOffset)
				local b = 1
				break
			end
		end
		if (b == 1) then break end
	end
	
	lockRender = false;
end

function init(playerRadius)
	player["radius"] = playerRadius
	loadLevel(1)
end