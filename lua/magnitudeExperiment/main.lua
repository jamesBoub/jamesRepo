lines = {

--~ {x1,y1,x2,y2,M},

}
timesLclicked = 0

cursor = {x = 0,y = 0, r = 5}

player = {x = 100, y = 100,r = 10}

function love.draw()
	for i in pairs(lines) do
		if lines[i].r == true then
			--~ love.graphics.setColor(lines[i].c[1],lines[i].c[2],lines[i].c[3])
			love.graphics.line(lines[i][1].x, lines[i][1].y, lines[i][2].x, lines[i][2].y)
			
		end
	end
	

		if #lines >= 1 and lines[#lines].r == true then
			love.graphics.print(((lines[#lines][2].y-lines[#lines][1].y) / (lines[#lines][2].x-lines[#lines][1].x)) * 5)
			line_circle_collisions(player.x, player.y, lines[#lines])
		end
	--~ end
	
	love.graphics.circle("line",player.x,player.y,player.r)
	love.graphics.setColor(1,1,1)
	love.graphics.circle("fill", cursor.x, cursor.y, cursor.r)
	love.graphics.circle("fill",200,400,1)
end

function love.update()
	cursor.x,cursor.y = love.mouse.getPosition()
	
	
	if love.keyboard.isDown("w") then
		lines[#lines][2].y = lines[#lines][2].y - 1
	elseif love.keyboard.isDown("a") then
		lines[#lines][2].x = lines[#lines][2].x - 1
	elseif love.keyboard.isDown("s") then
		lines[#lines][2].y = lines[#lines][2].y + 1
	elseif love.keyboard.isDown("d") then
		lines[#lines][2].x = lines[#lines][2].x + 1
	elseif love.keyboard.isDown("up") then
		player.y = player.y - 1
	elseif love.keyboard.isDown("left") then
		player.x = player.x - 1
	elseif love.keyboard.isDown("down") then 
		player.y = player.y + 1
	elseif love.keyboard.isDown("right") then
		player.x = player.x + 1
	end
	
	
	
end


function love.mousereleased(_x,_y,button)
	if button == 1 then
		seg_point_create(_x,_y)
	end
end

function love.keyreleased(key)
	if key == "escape" then
		
		for i in pairs(lines) do
			lines[i] = nil
		end
	end
end

function line_point_collision(x1,y1,x2,y2,r)
	local xDistance = x2 - x1
	local yDistance = y2 - y1
	
	local hypDistance = math.sqrt((xDistance ^ 2) + (yDistance ^ 2))
	
	if hypDistance < r then
		return true
	end
	
end

function seg_point_create(_x,_y)
	if timesLclicked == 0 then
		timesLclicked = timesLclicked + 1
		table.insert(lines, {
			r = false,
			{x = _x,y = _y}, {x,y}, c = {}, m = {}
		})
	else
		lines[#lines][2].x = _x
		lines[#lines][2].y = _y
		lines[#lines].r = true
		timesLclicked = 0
		print(lines[#lines].r)
		
		 _dy = calculate_magnitude(lines[#lines][1].x,lines[#lines][1].y,lines[#lines][2].x,lines[#lines][2].y)
		
		--~ print(_dy)
		
		lines[#lines].m = {dy = _dy}
		print(lines[#lines].m.dy)
		
		
	end
end

function line_circle_collisions(x1,y1,ltab)
	--if line_point_collision(player.x,player.y,lines[#lines][1].x,lines[#lines][1].y,player.r) or line_point_collision(player.x,player.y,lines[#lines][2].x,lines[#lines][2].y,player.r) then
	if line_point_collision(x1,y1,lines[#lines][1].x,lines[#lines][1].y,player.r) or line_point_collision(x1,y1,lines[#lines][2].x,lines[#lines][2].y,player.r) then
		love.event.quit()
	end
	
	-- ^ check ends for collision ^
end

function calculate_magnitude(x1,y1,x2,y2)
	--~ local dx = x2-x1
	--~ local dy = math.abs(y2-y1)
	
	--~ print("magnitude " .. math.sqrt((dx)^2+(dy)^2))
	--~ print(" dx " .. dx .. " dy: " .. dy)
	--~ print(dy / 100)
	--~ love.event.quit()
	local dy = ((y2-y1) / (x2-x1))
	--~ print(dy)
	
	return dy
	
end

