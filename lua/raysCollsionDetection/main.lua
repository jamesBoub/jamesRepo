function set_up_rays()
	raysGroup = {
		info = {r = 800, a = 0, u = 5},
		origin = {x = 200, y = 200},
		rays = {}
		}
		
		dummyLine = {
		{x1 = 400, y1 = 100, x2 = 400, y2 = 800},
		{x1 = 400, y1 = 100, x2 = 800, y2 = 100},
		{x1 = 50, y1 = 200, x2 = 300, y2 = 200},
		{x1 = 50, y1 = 300, x2 = 300, y2 = 300},
		{x1 = 350, y1 = 300, x2 = 400, y2 = 300},
		{x1 = 350, y1 = 300, x2 = 350, y2 = 200},
		{x1 = 650, y1 = 300, x2 = 650, y2 = 200} -- moves
		}
		
		movingObject = true
		
		
	function create_rays(numberOfLines)
		local angle = 0

		while angle < math.rad(360) do
			angle = angle + math.rad(numberOfLines)
			_x = raysGroup.origin.x + math.cos(angle) * raysGroup.info.r
			_y = raysGroup.origin.y + math.sin(angle) * raysGroup.info.r
			table.insert(raysGroup.rays, {x = _x,y = _y, a = angle})
		end
	end
	
	create_rays(raysGroup.info.u)
	
end

function rays_render()
		function rays_update()
			local mouseX, mouseY = mouse_position()
				raysGroup.origin.x = mouseX
				raysGroup.origin.y = mouseY
			for u in pairs(raysGroup.rays) do
				_x = raysGroup.origin.x + math.cos(raysGroup.rays[u].a) * raysGroup.info.r
				_y = raysGroup.origin.y + math.sin(raysGroup.rays[u].a) * raysGroup.info.r
				raysGroup.rays[u].x = _x
				raysGroup.rays[u].y = _y
			end
		end
	for i in pairs(raysGroup.rays) do
		love.graphics.line(raysGroup.origin.x, raysGroup.origin.y, raysGroup.rays[i].x, raysGroup.rays[i].y)
	end
	rays_update()
end

function rays_collision_detect()
	for i in pairs(raysGroup.rays) do
		for u in pairs(dummyLine) do
		local collision, sectX, sectY = line_line_intersection(raysGroup.rays[i].x, raysGroup.origin.x, dummyLine[u].x1, dummyLine[u].x2, raysGroup.rays[i].y, raysGroup.origin.y, dummyLine[u].y1, dummyLine[u].y2)
	
		if collision then
		raysGroup.rays[i].x = sectX
		raysGroup.rays[i].y = sectY
		end
		end
	end
end

function line_line_intersection(x1, x2, x3, x4, y1, y2, y3, y4) -- 4 points for line a and b
	local u_a = (((x4 - x3) * (y1 - y3)) - ((y4 - y3) * (x1 - x3))) / (((y4 - y3) * (x2 - x1)) - (x4 - x3) * (y2 - y1))
	local u_b = (((x2 - x1) * (y1 - y3)) - ((y2 - y1) * (x1 - x3))) / (((y4 - y3) * (x2 - x1)) - (x4 - x3) * (y2 - y1))
	
	if (u_a >= 0) and (u_a <= 1) and (u_b >= 0) and (u_b <= 1) then
		intersectX = x1 + (u_a * (x2 - x1))
		intersectY = y1 + (u_a * (y2 - y1))
		--~ love.event.quit()
		--~ love.graphics.circle("fill", intersectX, intersectY, 4)
	
		return true, intersectX, intersectY
	end
end

set_up_rays()
revert = false
function love.draw()
	rays_render()
	
	
	--~ rays_collision_detect()
	for i in pairs(dummyLine) do
	love.graphics.line(dummyLine[i].x1, dummyLine[i].y1, dummyLine[i].x2, dummyLine[i].y2)
	end
	rays_collision_detect()
		
		if revert then
			dummyLine[7].y1 = dummyLine[7].y1 + 1
			dummyLine[7].y2 = dummyLine[7].y2 + 1
		else
			dummyLine[7].y1 = dummyLine[7].y1 - 1
			dummyLine[7].y2 = dummyLine[7].y2 - 1
		end
		
		if dummyLine[7].y1 > 600 then
			revert = false
		end
		
		if dummyLine[7].y2 < 100 then
			revert = true
		end
		
	
end

function love.update()
end

function mouse_position()
	local mouseX, mouseY = love.mouse.getPosition()
	return mouseX, mouseY
	--~ rays_collision_detect()
end
