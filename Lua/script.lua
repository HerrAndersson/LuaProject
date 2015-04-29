function keyHandler(code)
	local var = code

	if(var == 3) then
		cCallTest(5)
	elseif(var == 0) then
		cCallTest(-5) 
	elseif(var == 22) then
		cCallTest(-1)
	elseif(var == 18) then
		cCallTest(-1)
	else 
		cCallTest(0)
	end

	return var
end

function cCallTest(var)
	testFunc(var)
	return 1
end
