rays = {
	origin = {
				x = 200,
				y = 200,
				r = 100,
				a = math.rad(0)
			 },
lines = {}
}

lineNumSel = 10

function create_lines(numberOfLines)
	local angle = 0

	while angle < math.rad(360) do
		angle = angle + math.rad(numberOfLines)
		
		_x = rays.origin.x + math.cos(angle) * rays.origin.r
		_y = rays.origin.y + math.sin(angle) * rays.origin.r
		table.insert(rays.lines, {x = _x,y = _y, a = angle})
	end
end

function rays_update()

rays.origin.x = mouseX
rays.origin.y = mouseY

	for u in pairs(rays.lines) do
		_x = rays.origin.x + math.cos(rays.lines[u].a) * rays.origin.r
		_y = rays.origin.y + math.sin(rays.lines[u].a) * rays.origin.r
		
		rays.lines[u].x = _x
		rays.lines[u].y = _y
	end
end

function ray_clear()
	for i in pairs(rays.lines) do
		rays.lines[i] = nil
	end
end

function love.draw()
mouseX, mouseY = love.mouse.getPosition()

rays_update()

	for i in pairs(rays.lines) do
		love.graphics.line(rays.origin.x, rays.origin.y, rays.lines[i].x, rays.lines[i].y)
	end
	
	function love.keyreleased(key) 
		if key == "up" then
			lineNumSel = lineNumSel + 1
			ray_clear()
			create_lines(lineNumSel)
		elseif key == "down" then
			if lineNumSel > 1 then
				lineNumSel = lineNumSel - 1
				ray_clear()
				create_lines(lineNumSel)
			end
		end
	end
end

create_lines(10)
print(rays.lines[1].a .. " " .. rays.lines[5].a)
