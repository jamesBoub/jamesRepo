function set_up_rays()
	raysGroup = {
		info = {r = 100, a = 0, u = 30},
		origin = {x = 200, y = 200},
		rays = {}
		}
		
		
		dummyLine = {x1 = 400, y1 = 100, x2 = 400, y2 = 800}
		
		
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
	rays_update()
		love.graphics.line(raysGroup.origin.x, raysGroup.origin.y, raysGroup.rays[i].x, raysGroup.rays[i].y)
	end
end

function rays_collision_detect()
	for i in pairs(raysGroup.rays) do
		local collision, sectX, sectY = line_line_intersection(raysGroup.rays[i].x, raysGroup.origin.x, dummyLine.x1, dummyLine.x2, raysGroup.rays[i].y, raysGroup.origin.y, dummyLine.y1, dummyLine.y2)
	end
end

function line_line_intersection(x1, x2, x3, x4, y1, y2, y3, y4) -- 4 points for line a and b
	local u_a = (((x4 - x3) * (y1 - y3)) - ((y4 - y3) * (x1 - x3))) / (((y4 - y3) * (x2 - x1)) - (x4 - x3) * (y2 - y1))
	local u_b = (((x2 - x1) * (y1 - y3)) - ((y2 - y1) * (x1 - x3))) / (((y4 - y3) * (x2 - x1)) - (x4 - x3) * (y2 - y1))
	
	if (u_a >= 0) and (u_a <= 1) and (u_b >= 0) and (u_b <= 1) then
		intersectX = x1 + (u_a * (x2 - x1))
		intersectY = y1 + (u_a * (y2 - y1))
		
		love.graphics.circle("fill", intersectX, intersectY, 4)
		return true, intersectX, intersectY
	end
end

set_up_rays()

function love.draw()
	rays_render()
	love.graphics.line(dummyLine.x1, dummyLine.y1, dummyLine.x2, dummyLine.y2)
	rays_collision_detect()
end

function love.update()
end

function mouse_position()
	local mouseX, mouseY = love.mouse.getPosition()
	return mouseX, mouseY
end


