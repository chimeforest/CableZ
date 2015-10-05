utl = {}
utl.math = {}


--MATH UTILITIES
utl.math.round = function(num)
	local rnd

	if num-math.floor(num) >=.5 then
		rnd = math.ceil(num)
	else
		rnd = math.floor(num)
	end

	return rnd	
end


function utl.math.dec2hex(nValue)
	if type(nValue) == "string" then
		nValue = String.ToNumber(nValue);
	end
	nHexVal = string.format("%X", nValue);  -- %X returns uppercase hex, %x gives lowercase letters
	sHexVal = nHexVal.."";
	return sHexVal;
end



return utl