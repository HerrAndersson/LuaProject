dimensions = 50
worldWidth = 24
worldHeight = 16
player = {}
player["velX"] = 0
player["velY"] = 0
playerSpeed = 3

--[[
world  = {2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2
		  1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2};
	 --]]	  



--[[
world{w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,ww12,w13,w14,w15}
w1  = {2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w2  = {2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w3  = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w4  = {1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w5  = {1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w6  = {1, 1, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w7  = {1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w8  = {1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w9  = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w10 = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w11 = {1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w12 = {1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w13 = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1}
w14 = {1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1}
w15 = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2}
 --]]
 
world = {}
world[1] = {3, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[2] = {2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[3] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[4] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[5] = {1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[6] = {1, 1, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[7] = {1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[8] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[9] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[10] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[11] = {1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[12] = {1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[13] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1}
world[14] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1}
world[15] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2}
world[16] = {1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 4}


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
	end

	return var
end

function collision(x, y, type)
	centerCoordX = math.floor((player["x"] + x + player["radius"]) / 50) + 1
	centerCoordY = math.floor((player["y"] + y + player["radius"]) / 50) + 1
	
	local leftCoordX = math.floor((player["x"] + x) / 50) + 1
	local rightCoordX = math.floor(((player["x"] + x) + player["radius"] * 2) / 50) + 1
	
	local topCoordY = math.floor((player["y"] + y) / 50) + 1
	local bottomCoordY = math.floor(((player["y"] + y) + player["radius"] * 2) / 50) + 1
	
	if(leftCoordX < 1 or rightCoordX > worldWidth ) then
		x = 0
	elseif(topCoordY < 1 or bottomCoordY > worldHeight) then
		y = 0
	else
		if(world[centerCoordY][rightCoordX] == type or world[centerCoordY][leftCoordX] == type) then
			x = 0
		end
		
		if(world[topCoordY][centerCoordX] == type or world[bottomCoordY][centerCoordX] == type) then
			y = 0
		end
	end
	return x, y
end

function move(x, y)
	x,y = collision(x, y, 1)
	moveC(x, y)
	return 1
end

function update(playerPosX, playerPosY, playerRadius)
	player["x"] = playerPosX
	player["y"] = playerPosY
	player["radius"] = playerRadius
	
	move(player["velX"], player["velY"])
	
	if(world[centerCoordY][centerCoordX] == 4) then
		-- you is winner
	end
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

	drawPlayerC()
		
	displayWindowC();

	return 1;
end
	