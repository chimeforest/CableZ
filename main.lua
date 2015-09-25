JSON = (loadfile "JSON.lua")()
color = (loadfile "colors.lua")()

function love.load()
	rect = {
		x = 100,
		y = 100,
		width = 100,
		height = 100,
		dragging = { active = false, diffX = 0, diffY = 0 }
	}


	--JSON.lua testing
	pretty_json_text = JSON:encode_pretty(rect)
	--print(pretty_json_text)
	file = io.open ("pretty.json", "w+")
	io.output(file)
	io.write(pretty_json_text)
	io.close(file)
	--print("File written")

	lua_value = JSON:decode(pretty_json_text) -- decode example
	love.graphics.print(lua_value.x, 400, 300)
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

	local wincolorset = color.set.cool
	local colornum = 4
	love.graphics.setColor( wincolorset[colornum])
	love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
	love.graphics.setColor( wincolorset[colornum+1])
	love.graphics.rectangle("fill", rect.x+5, rect.y+5, rect.width-10, rect.height-90)
	love.graphics.setColor( wincolorset[colornum+2])
	love.graphics.rectangle("fill", rect.x+5, rect.y+20, rect.width-10, rect.height-25)
	love.graphics.print("Window", rect.x+5, rect.y+5)
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
