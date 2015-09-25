JSON = (loadfile "JSON.lua")()
color = (loadfile "colors.lua")()

function love.load()
	windows = {}

	windows[1] = {
		title = "window1",
		cn = 1,
		x = 100,
		y = 100,
		w = 100,
		h = 100,
		dragging = { active = false, diffX = 0, diffY = 0 }
	}
	windows[2] = {
		title = "window2",
		cn = 4,
		x = 300,
		y = 100,
		w = 100,
		h = 100,
		dragging = { active = false, diffX = 0, diffY = 0 }
	}


	rect = {
		x = 100,
		y = 100,
		width = 100,
		height = 100,
		dragging = { active = false, diffX = 0, diffY = 0 }
	}

	colortheme = color.set.earthtone
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")
	--[[
	--JSON.lua testing
	pretty_json_text = JSON:encode_pretty(rect)
	--print(pretty_json_text)
	file = io.open ("pretty.json", "w+")
	io.output(file)
	io.write(pretty_json_text)
	io.close(file)
	--print("File written")
	

	lua_value = JSON:decode(pretty_json_text) -- decode example
	--]]

	--love.graphics.print(lua_value.x, 400, 300)
	love.graphics.setBackgroundColor(colortheme[1])

end

function love.draw()
	--lua_value.x = rect.x
	--love.graphics.print(lua_value.x, 400, 300)

	--[[
	local wincolor = color.SpringGreen
	love.graphics.setColor( color.brightness(wincolor,.75))
	love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
	love.graphics.setColor( wincolor)
	love.graphics.rectangle("fill", rect.x+5, rect.y+5, rect.width-10, rect.height-90)
	love.graphics.setColor( color.brightness(wincolor,1.25))
	love.graphics.rectangle("fill", rect.x+5, rect.y+20, rect.width-10, rect.height-25)
	--]]

	--local wincolorset = color.set.cool
	local colornum = 1
	love.graphics.setColor( colortheme[colornum])
	love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
	love.graphics.setColor( colortheme[colornum+1])
	love.graphics.rectangle("fill", rect.x+5, rect.y+5, rect.width-10, rect.height-90)
	love.graphics.rectangle("line", rect.x, rect.y, rect.width, rect.height)
	love.graphics.setColor( colortheme[colornum+2])
	love.graphics.rectangle("fill", rect.x+5, rect.y+20, rect.width-10, rect.height-25)
	love.graphics.print("Window", rect.x+5, rect.y+5)

	for k,v in  pairs(windows) do
		print(v.cn)
		drawwindow(v.x,v.y,v.w,v.h,v.cn,v.title)
	end
	--[[
	drawwindow(10,10,100,100,1)
	drawwindow(120,10,100,100,2)
	drawwindow(230,10,100,100,3)
	drawwindow(340,10,100,100,4)
	drawwindow(450,10,100,100,5)
	--]]
end

function love.mousepressed(x, y, button)
	if button == "l"
	and x > rect.x and x < rect.x + rect.width
	and y > rect.y and y < rect.y + rect.height
	then
		rect.dragging.active = true
		rect.dragging.diffX = x - rect.x
		rect.dragging.diffY = y - rect.y
  	end
end

function love.update(dt)
	if rect.dragging.active then
		rect.x = love.mouse.getX() - rect.dragging.diffX
		rect.y = love.mouse.getY() - rect.dragging.diffY
	end
end

function love.mousereleased(x, y, button)
	if button == "l" then rect.dragging.active = false end
end

function drawwindow(x,y,h,w,cn,t)
	love.graphics.setColor( colortheme[cn])
	love.graphics.rectangle("fill", x, y, w, h)
	love.graphics.setColor( colortheme[cn+1])
	love.graphics.rectangle("fill", x+5, y+5, w-10, h-90)
	love.graphics.rectangle("line", x, y, w, h)
	love.graphics.setColor( colortheme[cn+2])
	love.graphics.rectangle("fill", x+5, y+20, w-10, h-25)
	if t ~= nil then love.graphics.print(t, x+5, y+5) end
end