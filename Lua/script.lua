function keyHandler(code)
	local var = code
	cCallTest(var)
	return var
end

function cCallTest(var)
	testFunc(5)
	return 1
end
