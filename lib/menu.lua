menu = {}


--all the stuff to do during love.load
function menu.load()
	menu.font = love.graphics.getFont()
	menu.colorScheme = {{150,150,150,255},{222,222,222,255},{75,75,75,255}}

	--add options for close min max booleans
	menu.min = true
	menu.max = false
	menu.exit = true

	menu.dragging = false
end

-- If menu is clicked then figure out what to do and return true
function menu.onClick(x,y,mouseBtn)
	local clicked = false
		if y < 20 then
  			--clicked on the menu
  			if mouseBtn == "l" then
  				if x > love.graphics.getWidth() - 20 then love.event.quit() --clicked on the X to close
  				elseif x > love.graphics.getWidth() - 40 and x < love.graphics.getWidth() - 20 then love.window.minimize() --clicked on the - to minimize 
  				else
  					--clicked on the bar
  					--drag game window
  					menu.dragging = true
  					menu.windowX, menu.windowY = love.window.getPosition()
  					menu.dragX = x
  					menu.dragY = y
  				end
  			end
  			clicked = true
  		end

	return clicked
end

-- stuff to do during love.update
function menu.update(dt)
	if menu.dragging then
		if love.mouse.getX() ~= dragX then--or love.mouse.getY() ~= dragY then
			menu.windowX, menu.windowY = love.window.getPosition()
			local xDif = love.mouse.getX() - dragX 

			love.window.setPosition(menu.windowX - xDif , menu.windowY)
		end
	end
end

function menu.mousereleased(x,y,mouseBtn)
	menu.dragging = false
end


-- stuff to do during love.draw
function menu.draw(cn)
	if cn == nil then cn = 1 end

	love.graphics.setLineWidth(3)
	love.graphics.setColor( menu.colorScheme[cn])
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 20)
	

	--draw [X] close
	love.graphics.setColor( menu.colorScheme[cn+2])
	love.graphics.line(love.graphics.getWidth()-20, 0, love.graphics.getWidth()-2, 20-1)
	love.graphics.line(love.graphics.getWidth(), 0, love.graphics.getWidth()-20, 20)

	--draw [-] minimize
	
	love.graphics.line(love.graphics.getWidth()-40, 10, love.graphics.getWidth()-20, 10)

	--draw accents
	love.graphics.setColor( menu.colorScheme[cn+1])
	love.graphics.rectangle("line", 2, 1, love.graphics.getWidth()-2, 20-1)
	love.graphics.line(love.graphics.getWidth()-20, 0, love.graphics.getWidth()-20, 20)
	love.graphics.line(love.graphics.getWidth()-40, 0, love.graphics.getWidth()-40, 20)

	--draw title
	love.graphics.setColor( menu.colorScheme[cn+2])
	love.graphics.setFont( menu.font )
	love.graphics.printf( "CableZ", 0, 0+2, love.graphics.getWidth(), "center" )

	--Change cn to color?
end

-- stuff to do during love.keypressed
-- menu shortcuts for example
function menu.keypressed(k)
end

return  menu