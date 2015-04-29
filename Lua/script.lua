function keyHandler(code)
	local var = code

	if(var == 3) then
		move(5, 0)
	elseif(var == 0) then
		move(-5, 0) 
	elseif(var == 22) then
		move(0, -5)
	elseif(var == 18) then
		move(0, 5)
	else 
		move(0,0)
	end

	return var
end

function move(x, y)
	moveC(x, y)
	return 1
end

function render()

	clearWindowC();

	for i=0, 11, 1
	do
		for j=0, 11, 1
		do
			drawSquareC(j * 50, i * 50, 50, 1);
		end
	end
		
	displayWindowC();

	return 1;
end
