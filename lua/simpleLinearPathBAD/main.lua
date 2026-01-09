pointA = {x = 100, y = 500}
pointB = {x = 550, y = 500}
pointC = {x = 100, y = 500}

waypoints = {}

function love.draw()
love.graphics.print(pointC.x .. " " .. pointC.y)
if #waypoints > 0 then
			
			love.graphics.line(pointC.x, pointC.y, waypoints[1].x, waypoints[1].y)
			
			pointToPointMovement(waypoints[1].x, waypoints[1].y, pointC.x, pointC.y)
		
		
		for i = 2,#waypoints do
			love.graphics.line(waypoints[i].x, waypoints[i].y, waypoints[i - 1].x, waypoints[i - 1].y)
		end
		
		
			--~ love.graphics.print(math.abs(waypoints[1].x - pointC.x), 0,50)
			--~ love.graphics.print(math.abs(waypoints[1].y - pointC.y), 150,50)
			
			love.graphics.print(#waypoints, 0, 20)
			
			ass1 = math.abs(waypoints[1].x - pointC.x)
			ass2 = math.abs(waypoints[1].y - pointC.y)
			
			if ass1 < 1 and ass2 < 1 then 
				--~ love.event.quit()
				table.remove(waypoints, 1)
			end
		else
			--~ love.graphics.print("no waypoints :(", 0,50)
		end
		
		
		

	love.graphics.setColor(1,0,0)

		love.graphics.rectangle("fill", pointC.x, pointC.y, 15, 15)
	love.graphics.setColor(1,1,1)
		love.graphics.rectangle("fill", pointB.x, pointB.y, 15, 15)

		
end

function pointToPointMovement(ax,ay,bx,by)
	--b... is the object being moved
	
	atanAB = math.atan2((math.floor(ay - by)), (math.floor(ax - bx)))
	
	pointC.x = pointC.x + math.cos(atanAB)
	pointC.y = pointC.y + math.sin(atanAB)
	
end

function love.update()
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
