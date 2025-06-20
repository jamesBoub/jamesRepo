line = {x = 200, y = 200, x2 = 300, y2 = 250}
line2 = {x = 200, y = 200, x2 = 300, y2 = 250}
altitude = {x = 0,y = 0,x2 = 0,y2 = 0}
altitude2 = {x = 0,y = 0,x2 = 0,y2 = 0}
radius = 100
angle = 0
box = 20
rayNum = 1

manyLines = {origin = {x = 400, y = 250, radius = 100, angle = math.rad(0)}, others = {}}


function create_lines(_rayNum)

	local _x = 400
	local _y = 250

	for u = 1,rayNum do
	
	_x = manyLines.origin.x + math.cos(manyLines.origin.angle) * manyLines.origin.radius
	_y = manyLines.origin.y + math.sin(manyLines.origin.angle) * manyLines.origin.radius
	
	table.insert(manyLines.others, {x = _x,y = _y})
	
	manyLines.origin.angle = manyLines.origin.angle + math.rad(10)
		--~ line.x2 = line.x + math.cos(angle) * radius
		--~ line.y2 = line.x + math.sin(angle) * radius
	end
end

function update_radius(_dir)
		local _x = 400
		local _y = 250

	
	
	_x = manyLines.origin.x + math.cos(manyLines.origin.angle) * manyLines.origin.radius
	_y = manyLines.origin.y + math.sin(manyLines.origin.angle) * manyLines.origin.radius
	
	table.insert(manyLines.others, {x = _x,y = _y})
	
	manyLines.origin.angle = manyLines.origin.angle + math.rad(10)
		--~ line.x2 = line.x + math.cos(angle) * radius
		--~ line.y2 = line.x + math.sin(angle) * radius
		
end

function update_lines(_dir)
		
for u = 1,rayNum do
	manyLines.others[u].x = manyLines.others[u].x + _dir
end
end

create_lines()

function love.draw()
	

	line.x2 = line.x + math.cos(angle) * radius
	line.y2 = line.x + math.sin(angle) * radius
	

	vertAltitudeLen = (line.y - line.y2)
	horiAltitudeLen = (line.x - line.x2)
	
	love.graphics.setColor(1,1,1)
	
	love.graphics.print("Vertical: " .. vertAltitudeLen .. " Horizontal: " .. horiAltitudeLen,0,0)
	love.graphics.print(math.cos(angle) .. " " .. math.sin(angle), 0,20)
		
	if manyLines.other ~= nil then
		love.graphics.print(#manyLines.others,0,40)
		end
		
	
	altitude.x = line.x2
	altitude.y = line.y2
	
	altitude2.x = line.x
	altitude2.y = line.y
		
	if math.abs(vertAltitudeLen) < math.abs(horiAltitudeLen) then
		box = math.sqrt(math.abs(vertAltitudeLen * 2))
	else
		box = math.sqrt(math.abs(horiAltitudeLen * 2))
	end

	if vertAltitudeLen > 0 and horiAltitudeLen > 0 then
		love.graphics.rectangle("line", line.x2, line.y - box, box, box)
	elseif vertAltitudeLen < 0 and horiAltitudeLen > 0 then
		love.graphics.rectangle("line", line.x2, line.y, box, box)
	elseif vertAltitudeLen > 0 and horiAltitudeLen < 0 then
		love.graphics.rectangle("line", line.x2 - box, line.y - box, box, box)
	elseif vertAltitudeLen < 0 and horiAltitudeLen < 0 then
		love.graphics.rectangle("line", line.x2 - box, line.y, box, box)
	end
	
	love.graphics.setColor(1,0,0)
	love.graphics.line(altitude.x, altitude.y, line.x2, line.y)
	
	love.graphics.setColor(1,1,1)
	love.graphics.line(line.x, line.y, line.x2, line.y2)
	
	love.graphics.setColor(0,1,0)
	love.graphics.line(altitude2.x, altitude2.y, line.x2, line.y)
	
	
	for i in pairs(manyLines.others) do
		love.graphics.line(manyLines.origin.x, manyLines.origin.y, manyLines.others[i].x, manyLines.others[i].y)
	end
	
	
	if love.keyboard.isDown("up") then
		angle = angle + .05
	elseif love.keyboard.isDown("down") then
		angle = angle - .05
	elseif love.keyboard.isDown("d") then
		manyLines.origin.x = manyLines.origin.x + .5
		update_lines(.5)
	elseif love.keyboard.isDown("a") then
		manyLines.origin.x = manyLines.origin.x - .5
		update_lines(-.5)
	--~ elseif love.keyboard.isDown("w") then
		--~ manyLines.origin.radius = manyLines.origin.radius + .5
		--~ update_radius(.5)
	--~ elseif love.keyboard.isDown("s") then
		--~ manyLines.origin.radius = manyLines.origin.radius - .5
		--~ update_radius(-.5)
	end
end

function love.keyreleased(key)
	if key == "escape" then
		for i in pairs(manyLines.others) do
			manyLines.others[i] = nil
		end
	elseif key == "q" then
		manyLines.others[i] = nil
	elseif key == "w" then
		manyLines.origin.radius = manyLines.origin.radius + .1
		rayNum = rayNum + 1
		update_radius(.5)
	end
end
