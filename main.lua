--package.path = package.path .. ';../lib/?.lua;../lib/?'
--JSON = (loadfile "JSON")()
love.filesystem.load ("lib/JSON.lua")()
love.filesystem.load ("lib/colors.lua")()
love.filesystem.load ("lib/menu.lua")()

function love.load()
	--starting test windows
	windows = {	
		{title = "Window1", cn = 1, x = 10, y = 10+20, w = 100, h = 100},
		{title = "Window2", cn = 4, x = 10, y = 120+20, w = 100, h = 100},
		{title = "Window3", cn = 7, x = 10, y = 230+20, w = 100, h = 100},
		{title = "Window4", cn = 10, x = 10, y = 340+20, w = 100, h = 100},
		{title = "Window5", cn = 13, x = 10, y = 450+20, w = 100, h = 100}
	}

	--starting Z level for windows
	winZLvl = {}
	local i = 1
	for k,v in pairs(windows) do
		winZLvl[i] = k
		i = i+1
	end

	colorScheme = color.scheme.warm
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")
	love.graphics.setBackgroundColor(colorScheme[1])

	
	fontWin = love.graphics.newFont("fonts/UbuntuMono-R.ttf", 14)
	love.graphics.setFont( fontWin )

	allowWinOverlap = false
	allowDragging = true

	--allowLineOverlap = false --if true, have lines run over the same pixels when possible, if false, Lines must not do that.

	dragging = false
	dragWin = nil
	dragX = 0
	dragY = 0

	--isMenuOpen = false
	--isDialOpen = false

	--print(color.rgb2hex(color.hsv2rgb({59.791666666667,72.039473684211,100,100})))

	menu.load(colorScheme)
	menu.font = love.graphics.newFont("fonts/UbuntuMono-B.ttf", 20)


	debugline = "debugline"

end

function love.draw()
	

	for i=1,#winZLvl, 1 do
		for k,v in  pairs(windows) do
			if winZLvl[i] == k then
				drawwindow(v.x,v.y,v.w,v.h,v.cn,v.title)
				--print(winZLvl[i] .. ":" .. k .. ":" .. v.title)
			end
		end
	end

	--draw lines next

	menu.draw() --menu is always on top of windows and lines

	love.graphics.print(debugline, 10, love.graphics.getHeight() - 20)
end

function love.mousepressed(x, y, button)
	--debugline = "mousepressed: " .. x .. y .. button

	if menu.onClick(x,y,button) then -- if menu is clicked don't worry about other stuff
	else
	  	if button == "l" then
	  		if allowDragging then
		  		for i=#winZLvl,1, -1 do
		  			--debugline = ( x .. " " .. y .. " " .. button .. "," .. winZLvl[i] .. " " .. windows[winZLvl[i]].title ..
		  			--	":" .. windows[winZLvl[i]].x .. " " .. windows[winZLvl[i]].x + windows[winZLvl[i]].w  .. "," ..
		  			--		   windows[winZLvl[i]].y .. " " .. windows[winZLvl[i]].y + windows[winZLvl[i]].h)

					if x > windows[winZLvl[i]].x and x < windows[winZLvl[i]].x + windows[winZLvl[i]].w 
						and y > windows[winZLvl[i]].y and y < windows[winZLvl[i]].y + windows[winZLvl[i]].h 
					then
						dragging = true
						dragWin = winZLvl[i]
						dragX = x - windows[winZLvl[i]].x
		  				dragY = y - windows[winZLvl[i]].y

		  				table.insert(winZLvl, #winZLvl, table.remove(winZLvl, i))
		  				debugline = "WindowOrder: " .. winZLvl[1] .. winZLvl[2] .. winZLvl[3] .. winZLvl[4] .. winZLvl[5]
		  				break
					end
				end
			end
		end
	end
end

function love.update(dt)
	if dragging then
		windows[dragWin].x = love.mouse.getX() - dragX
		windows[dragWin].y = love.mouse.getY() - dragY
	end
	local winX, winY = love.window.getPosition()
	debugline = "mainwindow " ..  winX .. "," .. winY .."    mouse " .. love.mouse.getX() ..","..love.mouse.getY() 
	menu.update(dt)
end

function love.mousereleased(x, y, button)
	if button == "l" then
		dragging = false
	end
	menu.mousereleased(x,y,button)
end

function drawwindow(x,y,h,w,cn,t)
	love.graphics.setLineWidth(1)
	love.graphics.setColor( colorScheme[cn])
	love.graphics.rectangle("fill", x, y, w, h)
	love.graphics.setColor( colorScheme[cn+1])
	love.graphics.rectangle("fill", x+5, y+5, w-10, h-90)
	love.graphics.rectangle("line", x, y, w, h)
	love.graphics.setColor( colorScheme[cn+2])
	love.graphics.rectangle("fill", x+5, y+20, w-10, h-25)
	love.graphics.setFont( fontWin )
	if t ~= nil then love.graphics.print(t, x+5+2, y+5) end
	--TODO add component drawing here
	--Change cn to color?
end

function love.keypressed(k)
   if k == 'escape' then
      love.event.quit()
   end
end