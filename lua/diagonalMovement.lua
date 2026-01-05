pointA = {x = 100, y = 500}
pointB = {x = 550, y = 500}
pointC = {x = 100, y = 500}

function love.draw()
		love.graphics.setColor(1,0,0)
	love.graphics.rectangle("fill", pointA.x, pointA.y, 15, 15)
	love.graphics.rectangle("fill", pointC.x, pointC.y, 15, 15)
	love.graphics.print(math.deg(math.atan((pointB.y - pointA.y) / (pointB.x - pointA.x))),0,0)
		love.graphics.setColor(1,1,1)
	love.graphics.rectangle("fill", pointB.x, pointB.y, 15, 15)
end

function pointToPointMovement(ax,ay,bx,by)

	--b is the object being moved
	
	atanAB = math.atan2((ay - by), (ax - bx))
	
	pointC.x = pointC.x + math.cos(atanAB)
	pointC.y = pointC.y + math.sin(atanAB)
	
	pointC.x = pointC.x + math.cos(atanAB)
	pointC.y = pointC.y + math.sin(atanAB)
end

function love.update()

	mouseX, mouseY = love.mouse.getPosition()
	
	--~ atanAB = math.atan((pointB.y - pointC.y) / (pointB.x - pointC.x))
	--~ atanAB = math.atan2((pointB.y - pointC.y), (pointB.x - pointC.x))
	--~ atanAB = math.atan2((mouseY - pointC.y), (mouseX - pointC.x))
	
	if love.keyboard.isDown("up") then
		pointB.y = pointB.y - 1
	elseif love.keyboard.isDown("down") then
		pointB.y = pointB.y + 1
	elseif love.keyboard.isDown("left") then
		pointB.x = pointB.x - 1
	elseif love.keyboard.isDown("right") then
		pointB.x = pointB.x + 1
	end
	
	
	pointToPointMovement(mouseX, mouseY, pointC.x, pointC.y)
	
	--~ if love.keyboard.isDown("space") then
		--~ pointC.x = pointC.x + math.cos(atanAB)
		--~ pointC.y = pointC.y + math.sin(atanAB)
	--~ end
	
end
