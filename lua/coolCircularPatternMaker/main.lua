
--~ math.randomseed(os.time())

target = {}
target.x = love.graphics.getWidth() / 2
target.y = love.graphics.getHeight() / 2

ring = {}

theta = 0
radiusX = 200
radiusY = 200
angleOffset = 0

trail = {}

for i = 1,50 do

		table.insert(ring, {
			x = target.x + math.cos(theta + angleOffset) * radiusX,
			y = target.y + math.sin(theta + angleOffset) * radiusY,
			angle = theta + angleOffset,
			color = {r = 1, g = 0, b = 0}
		})
		
		angleOffset = angleOffset + .4
end

function love.draw()
	
	love.graphics.setColor(1,1,1)
	love.graphics.print(target.y)
	love.graphics.rectangle("fill", target.x, target.y, 10,10)
	
	for i in pairs(trail) do
		love.graphics.rectangle("fill",trail[i].x,trail[i].y,5,5)
	end
	
	for i in pairs(ring) do
		ring[i].x = target.x + math.cos(ring[i].angle) * radiusX
		ring[i].y = target.y + math.sin(ring[i].angle) * radiusY
		
		love.graphics.setColor(ring[i].color.r, ring[i].color.g, ring[i].color.b)
		print(ring[i].color.r)
		love.graphics.rectangle("fill", ring[i].x, ring[i].y, 5,5)
	end
	
	print(ring[1].x)
	
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
	
	if love.keyboard.isDown("space") then
		for i in pairs(ring) do
			table.insert(trail, {x = ring[i].x, y = ring[i].y})
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
		if love.keyboard.isDown("lshift") then
			radiusY = radiusY - 1
		else
			radiusX = radiusX - 1
		end
	elseif love.keyboard.isDown("right") then
		if love.keyboard.isDown("lshift") then
			radiusY = radiusY + 1
		else
			radiusX = radiusX + 1
		end
	end
end
