playerPos = {x = 1,y = 1}

function love.load()
	grid_create()
end

function love.update()
	player()
	input()
end

function love.draw()
	draw_grid()
	grid_manage()
	love.graphics.print(playerPos.x .. " " .. playerPos.y, 100, 600)
end

function draw_grid()
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
		love.graphics.setColor(grid[i][u].color[1],grid[i][u].color[2],grid[i][u].color[3])
		love.graphics.rectangle("fill", grid[i][u].x, grid[i][u].y, cellDimensions,cellDimensions)
		end
	end
	love.graphics.setColor(1,1,1) -- reset color for next frame
end

function grid_create()
	grid = {}
	offset = {x = 10, y = 0}
	cellDimensions = 10
	cellDistance = cellDimensions

	rows = 40
	columns = 59

	for i = 1,rows do
		table.insert(grid, {})
		for u = 1,columns do
			table.insert(grid[i], {x = offset.x, y = offset.y, color = {1,1,1}})
			offset.y = offset.y + cellDistance
		end
		offset.x = offset.x + cellDistance
		offset.y = 0
	end
end

function player()
end

function input()


--~ mouse_grid_collisions()

function love.keyreleased(key)
	if key == "escape" then
		love.event.quit()
	end
	if key == "w" then
		playerPos.y = playerPos.y - 1
	end
	if key == "a" then
		playerPos.x = playerPos.x - 1
	end
	if key == "s" then
		playerPos.y = playerPos.y + 1
	end
	if key == "d" then
		playerPos.x = playerPos.x + 1
	end
	end
end

function mouse_grid_collisions()
	mouseX,mouseY = love.mouse.getPosition()
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
			if mouseX > grid[i][u].x and mouseX < grid[i][u].x + cellDimensions + 1 and mouseY < grid[i][u].y then
				grid[i][u].color = {0,0,1}
			end
		end
	end
end

function grid_manage()
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
			if playerPos.x == i and playerPos.y == u then
				grid[i][u].color = {1,0,0}
			else
				grid[i][u].color = {1,1,1}
			end
		end
	end
end

