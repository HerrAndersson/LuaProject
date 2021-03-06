screenWidth = 1200;
screenHeight = 800;
player = {}
player["velX"] = 0
player["velY"] = 0
playerSpeed = 3
lockRender = false;
lockKeys = false;
currentLevel = 1;
startCoord = {}
endCoord = {}
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
			if(var == 3 or var == 72) then
				if(isKeyDown) then
					player["velX"] = playerSpeed
				else
					player["velX"] = 0
				end
			elseif(var == 0 or var == 71) then
				if(isKeyDown) then
					player["velX"] = -playerSpeed
				else
					player["velX"] = 0
				end
			elseif(var == 22 or var == 73) then	
				if(isKeyDown) then
					player["velY"] = -playerSpeed
				else
					player["velY"] = 0
				end
			elseif(var == 18 or var == 74) then
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
			if(var == 3 or var == 72) then
				if(worldPos["x"] < worldWidth) then
					worldPos["x"] = worldPos["x"] + 1
			end
			elseif(var == 0 or var == 71) then
				if(worldPos["x"] > 1) then
					worldPos["x"] = worldPos["x"] - 1
				end
			elseif(var == 22 or var == 73) then	
				if(worldPos["y"] > 1) then
					worldPos["y"] = worldPos["y"] - 1
				end
			elseif(var == 18 or var == 74) then
				if(worldPos["y"] < worldHeight) then
					worldPos["y"] = worldPos["y"] + 1
				end
			elseif(var > 26 and var < 31) then
				if(worldPos["y"] ~= startCoord["y"] or worldPos["x"] ~= startCoord["x"]) then
					if(worldPos["y"] ~= endCoord["y"] or worldPos["x"] ~= endCoord["x"]) then
						local tileType = var - 26
						if(tileType == 3) then
							world[startCoord["y"]][startCoord["x"]] = 2
							startCoord["x"] = worldPos["x"]
							startCoord["y"] = worldPos["y"]
						elseif(tileType == 4) then
							world[endCoord["y"]][endCoord["x"]] = 2
							endCoord["x"] = worldPos["x"]
							endCoord["y"] = worldPos["y"]
						end
						world[worldPos["y"]][worldPos["x"]] = tileType
					end
				end
			elseif(var == 60) then	
				gamemode = gamemodes[1]
				saveLevel(levelnum)
				place((startCoord["x"] - 1) * dimensions + playerOffset, (startCoord["y"] - 1) * dimensions + playerOffset)
			end
		end 
	end
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
		if(topCoordY < 1 or bottomCoordY > worldHeight or leftCoordX < 1 or rightCoordX > worldWidth ) then
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
				playerOffset = dimensions / 2 - player["radius"]
				place((x - 1) * dimensions + playerOffset, (y - 1) * dimensions + playerOffset)
				startCoord["x"] = x
				startCoord["y"] = y
			elseif(world[y][x] == 4) then
				endCoord["x"] = x
				endCoord["y"] = y
			end
		end
	end
	
	levelnum = int;
	lockRender = false;
end

function init(playerRadius)
	player["radius"] = playerRadius
	playerOffset = dimensions / 2 - player["radius"]
	loadLevel(1)
end

function saveLevel(lnum)
	file = io.open(lnum, "w")
	file:write([[world = {}]])
	file:close()
	file = io.open(lnum, "a")
	for i = 1, worldHeight, 1 do
		file:write("\n" .. "world[" .. i .. "]" .. " = " .. table.tostring(world[i]))
	end
	file:close()
end

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end