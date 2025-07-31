player = {x = 300, y = 240, r = 5}
line = {{300, 300, 400, 250}}

function love.draw()
	for i in pairs(line) do
		love.graphics.line(line[i][1],line[i][2],line[i][3],line[i][4])
	end
		love.graphics.circle("line", player.x, player.y, player.r)
end

function love.update()
	keyboard_input()
	for i in pairs(line) do
		--~ if circle_point_collision(line[i][1],line[i][2],player.x,player.y,player.r) or circle_point_collision(line[i][3],line[i][4],player.x,player.y,player.r) then
		--~ end
		--~ if circle_line_collision(line[i][1],line[i][2],line[i][3],line[i][4],player.x,player.y,player.r) then
			--~ player.x = player.x + 5
		--~ end
		if circle_line_collision(line[i][1],line[i][2],line[i][3],line[i][4],player.x,player.y,player.r) then
			player.x = player.x + 5
		end
	end
end

function keyboard_input()
	if love.keyboard.isDown("w") then
		player.y = player.y - 1
	elseif love.keyboard.isDown("a") then
		player.x = player.x - 1
	elseif love.keyboard.isDown("s") then
		player.y = player.y + 1
	elseif love.keyboard.isDown("d") then
		player.x = player.x + 1
	end
end

function collisions()
	
	function point_circle()
		
	end
	
end

function mathFuncs()
	
	function distance(x1,y1,x2,y2)
		-- calculates the distance between two points and returns the result
		local distX = x1 - x2
		local distY = y1 - y2
		
		local dist = math.sqrt((distX ^ 2) + (distY ^ 2))
		return dist
	end
	
	function circle_point_collision(cx,cy,x,y,r)
		-- returns true when radius of circle c is less than distance from point
		if distance(cx,cy,x,y) < r then
			return true
		end
	end
	
	function line_point_collision(x1,y1,x2,y2,px,py)
		
		local d1 = distance(px,py,x1,y1)
		local d2 = distance(px,py,x2,y2)
		
		local lineLen = distance(x1,y1,x2,y2)
		
		if d1+d2 >= lineLen - .1 and d1+d2 <= lineLen + .1 then
			return true
		end
	end
	
	function circle_line_collision(x1,y1,x2,y2,cx,cy,r)
		
		local inside1 = circle_point_collision(x1,y1,cx,cy,r)
		local inside2 = circle_point_collision(x2,y2,cx,cy,r)
		
		if inside1 or inside2 then
			return true
		end
		
		local distX = x1 - x2
		local distY = y1 - y2
		local len = math.sqrt((distX ^ 2) + (distY ^ 2))
		
		local dot = (((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1))) / len ^ 2
		
		local closestX = x1 + (dot * (x2-x1))
		local closestY = y1 + (dot * (y2-y1))
		
		local onLine = line_point_collision(x1,y1,x2,y2,closestX, closestY)
			if not onLine then return false end
		
		
		distX = closestX - cx
		distY = closestY - cy
		
		local distance = math.sqrt((distX ^ 2) + (distY ^ 2))
		
		if distance <= r then
			return true
		end
	end
end

mathFuncs()


