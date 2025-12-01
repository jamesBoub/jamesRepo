
grid = {}
gridSizeSquared = 25

player = {x = 1, y = 1}

function love.update()
	player_input()
end

function love.draw()
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
		
			if player.x == grid[i][u].x and player.y == grid[i][u].y then
				love.graphics.setColor(1,0,0)
				else
				love.graphics.setColor(1,1,1)
			end
		
			love.graphics.rectangle("fill", grid[i][u].x * 21 - 20,grid[i][u].y * 21 - 20,20,20)
		end
	end
end

function player_input()
	function love.keyreleased(key)
		if key == "w" then
			if player.y > 1 then
				player.y = player.y - 1
			end
		elseif key == "a" then
			if player.x > 1 then
				player.x = player.x - 1
			end
		elseif key == "s" then
			if player.y < gridSizeSquared then
				player.y = player.y + 1
			end
		elseif key == "d" then
			if player.x < gridSizeSquared then
				player.x = player.x + 1
			end
		end
	end
end


function grid_generate()
	
	xPos = 0
	yPos = 0
	
	for x = 1,gridSizeSquared do
			grid[x] = {}
			xPos = xPos + 1
			yPos = 0
		for y = 1,gridSizeSquared do
			yPos = yPos + 1
			grid[x][y] = {x = xPos, y = yPos,}
		end
	end
end

grid_generate()
