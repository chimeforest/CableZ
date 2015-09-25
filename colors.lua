JSON = (loadfile "JSON.lua")()
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


color.brightness = function(c, p) --color.adjust(c, h, s, b/v, a)
	local nc = {}

	for k,v in  pairs(c) do
		if v == 0 then v = 100 end
			nc[k] = v * p
			if nc[k]>255 then nc[k]=255 end
			if nc[k]<0 then nc[k]=0 end
	end
	return nc
end

color.rgb2hex = function(r)
	local h = {}

	return h
end

color.hex2rpg = function(h)
	local r = {}

	return r
end

color.getthemedata = function(t)
	local tData = {}

	return tData
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
color.set = {}

color.set.earthtone = {}
color.set.earthtone[1] = color.hex2rgb("493829")
color.set.earthtone[2] = color.hex2rgb("816c5b")
color.set.earthtone[3] = color.hex2rgb("a9a18c")
color.set.earthtone[4] = color.hex2rgb("613318")
color.set.earthtone[5] = color.hex2rgb("855723")
color.set.earthtone[6] = color.hex2rgb("b99c6b")
color.set.earthtone[7] = color.hex2rgb("8f3b1b")
color.set.earthtone[8] = color.hex2rgb("d57500")
color.set.earthtone[9] = color.hex2rgb("dbca60")
color.set.earthtone[10] = color.hex2rgb("404f24")
color.set.earthtone[11] = color.hex2rgb("668d3c")
color.set.earthtone[12] = color.hex2rgb("bdd09f")
color.set.earthtone[13] = color.hex2rgb("4e6172")
color.set.earthtone[14] = color.hex2rgb("93929f")
color.set.earthtone[15] = color.hex2rgb("a3adb8")

color.set.cool = {color.hex2rgb("004159"),color.hex2rgb("65a8c4"),color.hex2rgb("aacee2"),
				color.hex2rgb("8c65d3"),color.hex2rgb("9a93ec"),color.hex2rgb("cab9f1"),
				color.hex2rgb("0052a5"),color.hex2rgb("413bf7"),color.hex2rgb("81cbf8"),
				color.hex2rgb("00adce"),color.hex2rgb("59d8f1"),color.hex2rgb("9ee7fa"),
				color.hex2rgb("00c590"),color.hex2rgb("73ebae"),color.hex2rgb("b5f9d3"),}
--]]

return color