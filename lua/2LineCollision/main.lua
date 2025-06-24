line = {x1 = 0, x2 = 0, y1 = 0, y2 = 0}
rectangle = {x = 100, y = 100, w = 50, h = 50}

function love.draw()

	mouseX, mouseY = love.mouse.getPosition()
	
	line.x2 = mouseX
	line.y2 = mouseY
	
	
	love.graphics.setColor(1,1,1)
	--~ love.graphics.rectangle("fill", rectangle.x, rectangle.y, rectangle.w, rectangle.h)
	love.graphics.line(50, 100, 500, 250)
	
	love.graphics.setColor(1,0,0)
	love.graphics.line(line.x1, line.y1, line.x2, line.y2)
	
	
	player_input()
	
	line_line_intersection(50, 500, line.x1, line.x2, 100, 250, line.y1, line.y2)
	

	
end

function line_line_intersection(x1, x2, x3, x4, y1, y2, y3, y4)
	local u_a = (((x4 - x3) * (y1 - y3)) - ((y4 - y3) * (x1 - x3))) / (((y4 - y3) * (x2 - x1)) - (x4 - x3) * (y2 - y1))
	local u_b = (((x2 - x1) * (y1 - y3)) - ((y2 - y1) * (x1 - x3))) / (((y4 - y3) * (x2 - x1)) - (x4 - x3) * (y2 - y1))
	
	if (u_a >= 0) and (u_a <= 1) and (u_b >= 0) and (u_b <= 1) then
		intersectX = x1 + (u_a * (x2 - x1))
		intersectY = y1 + (u_a * (y2 - y1))
		
		love.graphics.circle("fill", intersectX, intersectY, 4)
		
	end
end

function player_input()
	if love.keyboard.isDown("w") then
		line.y1 = line.y1 - 1
	elseif love.keyboard.isDown("a") then
		line.x1 = line.x1 - 1
	elseif love.keyboard.isDown("s") then
		line.y1 = line.y1 + 1
	elseif love.keyboard.isDown("d") then
		line.x1 = line.x1 + 1
	end
end
