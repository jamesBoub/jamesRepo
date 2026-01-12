
--~ math.randomseed(os.time())

target = {}
target.x = love.graphics.getWidth() / 2
target.y = love.graphics.getHeight() / 2

ring = {}
--~ ring.x = math.random(800)
--~ ring.y = math.random(600)

theta = 0
radiusX = 100
radiusY = 100
angleOffset = 0

for i = 1,16 do
		--~ ring[1].x = target.x + math.cos(theta) * 100
		--~ ring[1].y = target.y + math.sin(theta) * 100
		
		table.insert(ring, {x = target.x + math.cos(theta + angleOffset) * radiusX, y = target.y + math.sin(theta + angleOffset) * radiusY, angle = theta + angleOffset})
		angleOffset = angleOffset + .4
end


function love.draw()
	
	love.graphics.setColor(1,1,1)
	love.graphics.rectangle("fill", target.x, target.y, 10,10)
	love.graphics.setColor(1,0,0)
	
	for i in pairs(ring) do
		ring[i].x = target.x + math.cos(ring[i].angle) * radiusX
		ring[i].y = target.y + math.sin(ring[i].angle) * radiusY
		love.graphics.rectangle("fill", ring[i].x, ring[i].y, 10,10)
	end
	
	print(ring[1].x)
	
	love.graphics.print(math.deg(theta))
	
	if love.keyboard.isDown("w") then
		target.y = target.y - 5
	elseif love.keyboard.isDown("a") then
		target.x = target.x - 5
	elseif love.keyboard.isDown("s") then
		target.y = target.y + 5
	elseif love.keyboard.isDown("d") then
		target.x = target.x + 5
	end
	
	if love.keyboard.isDown("lctrl") then
		for i in pairs(ring) do
			ring[i].angle = ring[i].angle + .02
			ring[i].x = target.x + math.cos(ring[i].angle) * radiusX
			ring[i].y = target.y + math.sin(ring[i].angle) * radiusY
		end
	end
	
	if love.keyboard.isDown("up") then
		radiusX = radiusX + 2
		radiusY = radiusY + 2
	elseif love.keyboard.isDown("down") then
		radiusX = radiusX - 2
		radiusY = radiusY - 2
	end
	
	if love.keyboard.isDown("left") then
		radiusY = radiusY - 1
	elseif love.keyboard.isDown("right") then
		radiusY = radiusY + 1
	end
	
	
end

function love.keyreleased(key)
	if key == "space" then
		--~ love.event.quit()
		for i in pairs(ring) do
			ring[i].angle = ring[i].angle + .1
			ring[i].x = target.x + math.cos(ring[i].angle) * 100
			ring[i].y = target.y + math.sin(ring[i].angle) * 100
		end
	end
end
