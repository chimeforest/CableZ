JSON = (loadfile "JSON.lua")()
color = (loadfile "colors.lua")()

function love.load()
	--starting test windows
	windows = {	
		{
		title = "window1", cn = 1, x = 10, y = 10, w = 100, h = 100, 
		dragging = { active = false, diffX = 0, diffY = 0 }
		},
		{
		title = "window2", cn = 4, x = 10, y = 120, w = 100, h = 100,
		dragging = { active = false, diffX = 0, diffY = 0 }
		},
		{
		title = "window3", cn = 7, x = 10, y = 230, w = 100, h = 100,
		dragging = { active = false, diffX = 0, diffY = 0 }
		},
		{
		title = "window4", cn = 10, x = 10, y = 340, w = 100, h = 100,
		dragging = { active = false, diffX = 0, diffY = 0 }
		},
		{
		title = "window5", cn = 13, x = 10, y = 450, w = 100, h = 100,
		dragging = { active = false, diffX = 0, diffY = 0 }
		}
	}

	--starting Z level for windows
	winZLvl = {}
	local i = 1
	for k,v in pairs(windows) do
		winZLvl[i] = k
		i = i+1
	end

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
	--dragging = false

	debugline = "debugline"

end

function love.draw()
	--[[
	for k,v in  pairs(windows) do
		drawwindow(v.x,v.y,v.w,v.h,v.cn,v.title)
	end
	--]]
	for i=1,#winZLvl, 1 do
		for k,v in  pairs(windows) do
			if winZLvl[i] == k then
				drawwindow(v.x,v.y,v.w,v.h,v.cn,v.title)
				--print(winZLvl[i] .. ":" .. k .. ":" .. v.title)
			end
		end
	end

	--draw lines next

	love.graphics.print(debugline, 10, love.graphics.getHeight() - 20)
end

function love.mousepressed(x, y, button)
	debugline = "mousepressed: " .. x .. y .. button
  	if button == "l"
  		then
  		for i=1,#winZLvl, 1 do
  			debugline = ( x .. " " .. y .. " " .. button .. "," .. winZLvl[i] .. " " .. windows[winZLvl[i]].title ..
  				":" .. windows[winZLvl[i]].x .. " " .. windows[winZLvl[i]].x + windows[winZLvl[i]].w  .. "," ..
  					   windows[winZLvl[i]].y .. " " .. windows[winZLvl[i]].y + windows[winZLvl[i]].h)

			if x > windows[winZLvl[i]].x and x < windows[winZLvl[i]].x + windows[winZLvl[i]].w 
				and y > windows[winZLvl[i]].y and y < windows[winZLvl[i]].y + windows[winZLvl[i]].h 
			then
  				--print( x .. y .. button .. ":" .. winZLvl[i] .. " " .. windows[winZLvl[i]].title)

  				windows[winZLvl[i]].dragging.active = true
  				windows[winZLvl[i]].dragging.diffX = x - windows[winZLvl[i]].x
  				windows[winZLvl[i]].dragging.diffY = y - windows[winZLvl[i]].y

  				table.insert(winZLvl, #winZLvl, table.remove(winZLvl, i))
  				debugline = "WindowOrder: " .. winZLvl[1] .. winZLvl[2] .. winZLvl[3] .. winZLvl[4] .. winZLvl[5]
  				break
			end
		end

  		--[[
  		for k,v in  pairs(windows) do
  			if x > v.x and x < v.x + v.w and y > v.y and y < v.y + v.h
  				then
  				v.dragging.active = true
  				v.dragging.diffX = x - v.x
  				v.dragging.diffY = y - v.y
  				--[[
  				for k1,v1 in pairs(winZLvl) do
  					if v1==k then
  						table.insert(winZLvl, #winZLvl, table.remove(winZLvl, v1))
  					break
  					end
  				end
  				
  				debugline = "WindowOrder: " .. winZLvl[1] .. winZLvl[2] .. winZLvl[3] .. winZLvl[4] .. winZLvl[5]
  				break
  			end
  		end
  		--]]
	end
end

function love.update(dt)
	for k,v in  pairs(windows) do
  		if v.dragging.active == true
  			then
  			v.x = love.mouse.getX() - v.dragging.diffX
			v.y = love.mouse.getY() - v.dragging.diffY
		end
  	end
end

function love.mousereleased(x, y, button)
	if button == "l" then
		for k,v in  pairs(windows) do
  				v.dragging.active = false
  		end
	end
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
	--TODO add component drawing here
end