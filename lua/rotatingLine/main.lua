line = {x = 200, y = 200, x2 = 300, y2 = 250}
line2 = {x = 200, y = 200, x2 = 300, y2 = 250}
altitude = {x = 0,y = 0,x2 = 0,y2 = 0}
altitude2 = {x = 0,y = 0,x2 = 0,y2 = 0}
radius = 100
angle = 0
box = 20

function love.draw()
	line.x2 = line.x + math.cos(angle) * radius
	line.y2 = line.x + math.sin(angle) * radius
	

	vertAltitudeLen = (line.y - line.y2)
	horiAltitudeLen = (line.x - line.x2)
	
	love.graphics.setColor(1,1,1)
	
	love.graphics.print("Vertical: " .. vertAltitudeLen .. " Horizontal: " .. horiAltitudeLen,0,0)
	love.graphics.print(math.cos(angle) .. " " .. math.sin(angle), 0,20)
	
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
	
	if love.keyboard.isDown("up") then
		angle = angle + .05
	elseif love.keyboard.isDown("down") then
		angle = angle - .05
	end
end
