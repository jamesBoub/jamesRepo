pointA = {x = 100, y = 500}
pointB = {x = 550, y = 500}
pointC = {x = 100, y = 500}

waypoints = {}

function love.draw()
love.graphics.print(pointC.x .. " " .. pointC.y)
if #waypoints > 0 then
			
				pointToPointMovement(waypoints[1].x, waypoints[1].y, pointC.x, pointC.y)
			--~ love.graphics.print(waypoints[1].x .. " " .. waypoints[1].y .. " " .. #waypoints .. " waypoints in queue", 0,50)
			love.graphics.print(math.abs(waypoints[1].x - pointC.x), 0,50)
			love.graphics.print(math.abs(waypoints[1].y - pointC.y), 150,50)
			
			
			ass1 = math.abs(waypoints[1].x - pointC.x)
			ass2 = math.abs(waypoints[1].y - pointC.y)
			
			--~ love.graphics.print(math.floor(waypoints[1].x - pointC.x) .. math.floor())
			
			
			if ass1 < 1 and ass2 < 1 then 
				--~ love.event.quit()
				table.remove(waypoints, 1)
			end
			
		else
			love.graphics.print("no waypoints :(", 0,50)
		end


	love.graphics.setColor(1,0,0)
		--~ love.graphics.rectangle("fill", pointA.x, pointA.y, 15, 15)
		love.graphics.rectangle("fill", pointC.x, pointC.y, 15, 15)
	love.graphics.setColor(1,1,1)
		love.graphics.rectangle("fill", pointB.x, pointB.y, 15, 15)
		
		--~ love.graphics.print(math.floor(pointC.x) .. " " .. math.floor(pointC.y),0,0)
		
end

function pointToPointMovement(ax,ay,bx,by)
	--b... is the object being moved
	
	atanAB = math.atan2((math.floor(ay - by)), (math.floor(ax - bx)))
	
	pointC.x = pointC.x + math.cos(atanAB)
	pointC.y = pointC.y + math.sin(atanAB)
	
	

	
end

function love.update()

	--~ mouseX, mouseY = love.mouse.getPosition()
	
	--~ if love.keyboard.isDown("up") then
	--~ elseif love.keyboard.isDown("down") then
		--~ pointB.y = pointB.y + 1
	--~ elseif love.keyboard.isDown("left") then
		--~ pointB.x = pointB.x - 1
	--~ elseif love.keyboard.isDown("right") then
		--~ pointB.x = pointB.x + 1
	--~ end
	
	
end

function placeWaypoint(_x,_y)
	table.insert(waypoints, {x = _x, y = _y})
end

function love.mousereleased(x,y,button)
	if button == 1 then
		placeWaypoint(x,y)
	elseif button == 2 then
		table.remove(waypoints, 1)
	end
end
