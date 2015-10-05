loadfile ("./lib/JSON.lua")()
loadfile ("./lib/utl.lua")()

color = {}

--functions
color.add = function(n,h)
	--takes a hex code and adds it to the color 'class'
	color[n] =  color.hex2rgb(h)
end

color.hex2rgb = function(h)
	--takes a hex color code and converts it to an rgba table
	local nc = {}
	nc[1] = tonumber(string.sub(h,1,2),16)
	nc[2] = tonumber(string.sub(h,3,4),16)
	nc[3] = tonumber(string.sub(h,5,6),16)
	nc[4] = tonumber(string.sub(h,7,8),16)
	if nc[4] == nil then nc[4] = 255 end
	return nc
end

color.rgb2hex = function(rgb)
	local hex = ""

	hex = utl.math.dec2hex(rgb[1]) .. utl.math.dec2hex(rgb[2]) .. utl.math.dec2hex(rgb[3]) .. utl.math.dec2hex(rgb[4])

	return hex
end

function color.adjust(c, h, s, v, a)
	hsvColor = color.rgb2hsv(c)

	hsvColor[1] = hsvColor[1] + h
	if hsvColor[1] > 360 then hsvColor[1] = hsvColor[1] - 360 end
	if hsvColor[1] < 0 then hsvColor[1] = hsvColor[1] + 360 end

	hsvColor[2] = hsvColor[2] * s
	hsvColor[3] = hsvColor[3] * v
	hsvColor[4] = hsvColor[4] * a

	return color.hsv2rgb(hsvColor)
end

color.rgb2hsv = function(rgb, round)
	local hsv = {}

	--normalize the rgb values between 0 and 1
	local red = rgb[1]/255
	local green = rgb[2]/255
	local blue = rgb[3]/255
	local alpha = rgb[4]/255

	local minValue = math.min(red,math.min(green,blue))
	local maxValue = math.max(red,math.max(green,blue))
	local delta = maxValue - minValue

	local h
	local s
	local v = maxValue

	--calculate the hue, degrees between 0 and 360
	if red > green and red > blue then
		if green >= blue then
			if delta == 0 then
				h=0
			else
				h = 60*(green-blue)/delta
			end
		else
			h = 60 * (green-blue)/delta + 360
		end
	elseif green > blue then
		h = 60 * (blue-red)/delta+120
	else  -- blue is max
		h = 60 * (red-green)/delta+240
	end

	--calculate saturation (between 0 and 1)
	if maxValue == 0 then
		s = 0
	else
		s = 1 - (minValue/maxValue)
	end

	--scale saturation to a value between 0 and 11

	s = s * 100
	v = v * 100
	alpha = alpha * 100

	if round then
		h = math.ceil(h)
		s = math.ceil(s)
		v = math.ceil(v)
		alpha = math.ceil(alpha)
	end

	hsv[1] = h
	hsv[2] = s
	hsv[3] = v
	hsv[4] = alpha

	--print(hsv[1] .. " " .. hsv[2] .. " " .. hsv[3] .. " " .. hsv[4])

	return hsv
end

color.hsv2rgb = function(hsv)
	local rgb = {}

	local hue = hsv[1]
	local sat = hsv[2]/100
	local val = hsv[3]/100
	local alpha = hsv[4]/100

	local r
	local g
	local b

	if sat == 0 then
		r,g,b = val
	else
		local sectorPos = hue/60
		local sectorNum = math.floor(sectorPos)

		local fractionalSector = sectorPos - sectorNum

		local p = val * (1 - sat)
		local q = val * (1 - (sat * fractionalSector))
		local t = val * (1 - (sat * (1 - fractionalSector)))

		--print(sectorNum)
		if sectorNum == 0 or sectorNum == 6 then
			r = val
			g = t
			b = p
		elseif sectorNum == 1 then
			r = q
			g = val
			b = p
		elseif sectorNum == 2 then
			r = p
			g = val
			b = t
		elseif sectorNum == 3 then
			r = p
			g = q
			b = val
		elseif sectorNum == 4 then
			r = t
			g = p
			b = val
		elseif sectorNum == 5 then
			r = val
			g = p
			b = q
		end
	end

	rgb[1] = utl.math.round(r*255)
	rgb[2] = utl.math.round(g*255)
	rgb[3] = utl.math.round(b*255)
	rgb[4] = utl.math.round(alpha*255)

	--print(rgb[1] .. " " .. rgb[2] .. " " .. rgb[3] .. " " .. rgb[4])

	return rgb
end


color.getSchemeData = function(t)
	local tData = {}

	local rootColor = color.rgb2hsv(t[1])

	for i=2,#t,1 do
		local curColor = color.rgb2hsv(t[i])
		local curData = {}
		
		for ii=1,4,1 do
			--TODO FIX, hue is okay, but others should be percentages
			if ii== 1 then
				curData[ii] = rootColor[ii] - curColor[ii]
			else
				curData[ii] = curColor[ii]/rootColor[ii]
			end
			--print("tData["..i.."]: " .. )
		end
		tData[i-1] = curData
	end

	tData.sat = rootColor[2]
	tData.val = rootColor[3]

	return tData
end

color.schemeFromData = function(rootColor,themeData, useOrigSV)
	local set = {}

	hsvColor = color.rgb2hsv(rootColor)

	if useOrigSV then
		hsvColor[2] = themeData.sat
		hsvColor[3] = themeData.val
	end
	

	set[1] = color.hsv2rgb(hsvColor)

	for i=1,#themeData,1 do
		local curData = themeData[i]
		local curColor = {}

		print(i)

		for ii=1,4,1 do
			if ii == 1 then
				--value must be between 0 and 360
				--print(ii)
				--print (hsvColor[ii])
				--print (curData[ii])
				curColor[ii] = hsvColor[ii] + curData[ii]
				if curColor[ii] > 360 then curColor[ii] = curColor[ii] - 360 end
				if curColor[ii] < 0 then curColor[ii] = curColor[ii] + 360 end
			else
				--value must be between 0 and 100
				curColor[ii] = hsvColor[ii] * curData[ii]
				if curColor[ii] > 100 then curColor[ii] = 100 end
				if curColor[ii] < 0 then curColor[ii] = 0 end
			end
		end
		-- on the 12 iteration: Error: colors.lua:154: attempt to perform arithmetic on local 'r' (a nil value)
		-- on 12, it's the first time that curdata[ii] is less than 180...
		print("curColor: " .. curColor[1] .. "," .. curColor[2] .. "," .. curColor[3] .. "," .. curColor[4])
		set[i+1] = color.hsv2rgb(curColor)
	end

	return set
end

function color.schemeFromHexTable(hexTable)
	set = {}

	for i=1,#hexTable,1 do
		set[i] = color.hex2rgb(hexTable[i])
	end

	return set
end

--X11

----Pinks
color.add("Pink","ffc0cb")
color.add("LightPink","ffb6c1")
color.add("HotPink","ff69b4")
color.add("DeepPink","ff1493")
color.add("PaleVioletRed","db7093")
color.add("MediumVioletRed","c71585")

----Reds
color.add("LightSalmon","ffa07a")
color.add("Salmon","fa8072")
color.add("DarkSalmon","e9967a")
color.add("LightCoral","f08080")
color.add("IndianRed","cd5c5c")
color.add("Crimson","dc143c")
color.add("FireBrick","b22222")
color.add("DarkRed","8b0000")
color.add("Red","ff0000")

--Oranges
color.add("OrangeRed","ff4500")
color.add("Tomato","ff6347")
color.add("Coral","ff7f50")
color.add("DarkOrange","ff8c00")
color.add("Orange","ffa500")

--Yellows
color.add("Yellow","ffff00")
color.add("LightYellow","ffffe0")
color.add("LemonChiffon","fffacd")
color.add("LightGoldenrodYellow","fafad2")
color.add("PapayaWhip","ffefd5")
color.add("Moccasin","ffe4b5")
color.add("PeachPuff","ffdab9")
color.add("PaleGoldenrod","eee8aa")
color.add("Khaki","f0e68c")
color.add("DarkKhaki","bdb76b")
color.add("Gold","ffd700")

--Browns
color.add("Cornsilk","fff8dc")
color.add("BlanchedAlmond","ffebcd")
color.add("Bisque","ffe4c4")
color.add("NavajoWhite","ffdead")
color.add("Wheat","f5deb3")
color.add("BurlyWood","deb887")
color.add("Tan","d2b48c")
color.add("RosyBrown","bc8f8f")
color.add("SandyBrown","f4a460")
color.add("Goldenrod","daa520")
color.add("DarkGoldenrod","b8860b")
color.add("Peru","cd853f")
color.add("Chocolate","d2691e")
color.add("SaddleBrown","8b4513")
color.add("Sienna","a0522d")
color.add("Brown","a52a2a")
color.add("Maroon","800000")

--Greens
color.add("DarkOliveGreen","556b2f")
color.add("Olive","808000")
color.add("OliveDrab","6b8e23")
color.add("YellowGreen","9acd32")
color.add("LimeGreen","32cd32")
color.add("Lime","00ff00")
color.add("LawnGreen","7cfc00")
color.add("Chartreuse","7fff00")
color.add("GreenYellow","adff2f")
color.add("SpringGreen","00ff7f")
color.add("MediumSpringGreen","00fa9a")
color.add("LightGreen","90ee90")
color.add("PaleGreen","98fb98")
color.add("DarkSeaGreen","8fbc8f")
color.add("MediumSeaGreen","3cb371")
color.add("SeaGreen","2e8b57")
color.add("ForestGreen","228b22")
color.add("Green","008000")
color.add("DarkGreen","006400")

----Cyans
color.add("MediumAquamarine","66CDAA")
color.add("Cyan","00FFFF")
color.add("LightCyan","E0FFFF")
color.add("PaleTurqouise","AFEEEE")
color.add("Aquamarine","7FFFD4")
color.add("Turquoise","40E0D0	")
color.add("MediumTurquoise","48D1CC")
color.add("DarkTurquoise","00CED1")
color.add("LightSeaGreen","20B2AA")
color.add("CadetBlue","5F9EA0")
color.add("DarkCyan","008B8B")
color.add("Teal","008080")

----Blues
color.add("LightSteelBlue","B0C4DE")
color.add("PowderBlue","B0E0E6")
color.add("LightBlue","ADD8E6")
color.add("SkyBlue","87CEEB")
color.add("LightSkyBlue","87CEFA")
color.add("DeepSkyBlue","00BFFF")
color.add("DodgerBlue","1E90FF")
color.add("CornflowerBlue","6495ED")
color.add("SteelBlue","4682B4")
color.add("RoyalBlue","4169E1")
color.add("Blue","0000FF")
color.add("MediumBlue","0000CD")
color.add("DarkBlue","00008B")
color.add("Navy","000080")
color.add("MidnightBlue","191970")

----Purples
color.add("Lavender","E6E6FA")
color.add("Thistle","D8BFD8")
color.add("Plum","DDA0DD")
color.add("Violet","EE82EE")
color.add("Orchid","DA70D6")
color.add("Fuchsia","FF00FF")
color.add("Magenta","FF00FF")
color.add("MediumOrchid","BA55D3")
color.add("MediumPurple","9370DB")
color.add("BlueViolet","8A2BE2")
color.add("DarkViolet","9400D3")
color.add("DarkOrchid","9932CC")
color.add("DarkMagenta","8B008B")
color.add("Purple","800080")
color.add("Indigo","4B0082")
color.add("DarkSlateBlue","483D8B")
color.add("RebeccaPurple","663399")
color.add("SlateBlue","6A5ACD")
color.add("MediumSlateBlue","7B68EE")

----Whites
color.add("White","ffffff")
color.add("Snow","FFFAFA")
color.add("Honeydew","F0FFF0")
color.add("MintCream","F5FFFA")
color.add("Azure","F0FFFF")
color.add("AliceBlue","F0F8FF")
color.add("GhostWhite","F8F8FF")
color.add("WhiteSmoke","F5F5F5")
color.add("Seashell","FFF5EE")
color.add("Beige","F5F5DC")
color.add("OldLace","FDF5E6")
color.add("FloralWhite","FFFAF0")
color.add("Ivory","FFFFF0")
color.add("AntiqueWhite","FAEBD7")
color.add("Linen","FAF0E6")
color.add("LavenderBlush","FFF0F5")
color.add("MistyRose","FFE4E1")

----Greys
color.add("Gainsboro","DCDCDC")
color.add("LightGrey","D3D3D3")
color.add("Silver","C0C0C0")
color.add("DarkGray","A9A9A9")
color.add("Gray","808080")
color.add("DimGray","696969")
color.add("LightSlateGray","778899")
color.add("SlateGray","708090")
color.add("DarkSlateGray","2F4F4F")
color.add("Black","000000")

--creativecolorschemes.com
color.add("ccs04901","0099CC")
color.add("ccs04903","E1058C")


--ColorThemes/Sets from creativecolorschemes.com
color.scheme = {}

--set scheme one by one
color.scheme.earthtone = {}
color.scheme.earthtone[1] = color.hex2rgb("493829")
color.scheme.earthtone[2] = color.hex2rgb("816c5b")
color.scheme.earthtone[3] = color.hex2rgb("a9a18c")
color.scheme.earthtone[4] = color.hex2rgb("613318")
color.scheme.earthtone[5] = color.hex2rgb("855723")
color.scheme.earthtone[6] = color.hex2rgb("b99c6b")
color.scheme.earthtone[7] = color.hex2rgb("8f3b1b")
color.scheme.earthtone[8] = color.hex2rgb("d57500")
color.scheme.earthtone[9] = color.hex2rgb("dbca60")
color.scheme.earthtone[10] = color.hex2rgb("404f24")
color.scheme.earthtone[11] = color.hex2rgb("668d3c")
color.scheme.earthtone[12] = color.hex2rgb("bdd09f")
color.scheme.earthtone[13] = color.hex2rgb("4e6172")
color.scheme.earthtone[14] = color.hex2rgb("93929f")
color.scheme.earthtone[15] = color.hex2rgb("a3adb8")

--set scheme using a table and converting hex values to rgb
color.scheme.cool = {color.hex2rgb("004159"),color.hex2rgb("65a8c4"),color.hex2rgb("aacee2"),
				color.hex2rgb("8c65d3"),color.hex2rgb("9a93ec"),color.hex2rgb("cab9f1"),
				color.hex2rgb("0052a5"),color.hex2rgb("413bf7"),color.hex2rgb("81cbf8"),
				color.hex2rgb("00adce"),color.hex2rgb("59d8f1"),color.hex2rgb("9ee7fa"),
				color.hex2rgb("00c590"),color.hex2rgb("73ebae"),color.hex2rgb("b5f9d3")}

--set scheme using a funtion which reads hex values
color.scheme.artdeco = color.schemeFromHexTable({"ef3e5b","f26279","f68fa0",
												"4b265d","6f5495","a09ed6",
												"3f647e","688fad","9fc1d3",
												"00b0b2","52ccce","95d47a",
												"677c8a","b2a296","c9c9c9",})

color.scheme.warm = color.schemeFromHexTable({"973f0d","ac703d","c38e63",
											"e49969","e5ae86","eec5a9",
											"6e7649","9d9754","c7c397",
											"b4a851","dfd27c","e7e3b5",
											"846d74","b7a6ad","d3c9ce",})

--set scheme using data from another scheme and a new root color
color.scheme.oceantone =color.schemeFromData(color.MediumBlue, color.getSchemeData(color.scheme.earthtone),true)
color.scheme.foresttone=color.schemeFromData(color.ForestGreen, color.getSchemeData(color.scheme.earthtone),true)

return color