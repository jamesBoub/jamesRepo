grid = {}
blocks = {
{{{x = 6,y = 12},{x = 7,y = 12},{x = 8,y = 12},{x = 9,y = 12}}},
{{{x = 6,y = 14},{x = 7,y = 14},{x = 8,y = 14}}},
--~ {{x = 6,y = 14}}
}
offset = {x = 0, y = 50}

selectedBlock = 1
shape = "box"

rows = 43
cols = 40

for i = 1,rows do
	table.insert(grid, {})
	for u = 1,cols do
		table.insert(grid[i], {x = offset.x, y = offset.y, flags = {}})
		offset.y = offset.y + 10
	end
	offset.x = offset.x + 10
	offset.y = 50
end

function grid_blocks_check()
	
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
			grid[i][u].flags = {}
		end
	end
	
		for i in pairs(blocks[1]) do
			for u in pairs(blocks[1][i]) do
				
				if i == selectedBlock then
					grid[blocks[1][i][u].x][blocks[1][i][u].y].flags[1] = "active"
				else
					grid[blocks[1][i][u].x][blocks[1][i][u].y].flags[1] = "wall"
				end
				
			end
		end
end

grid_blocks_check()

function love.draw()
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
		
			local flag = grid[i][u].flags[1]
		
			love.graphics.setColor(1,1,1)
			if flag == "wall" then
				love.graphics.setColor(1,0,0)
			elseif flag == "active" then
				love.graphics.setColor(0,1,0)
			end
			love.graphics.rectangle("fill", grid[i][u].x, grid[i][u].y, 9,9)
		end
	end
	
	love.graphics.print("shape: " .. shape)
	love.graphics.print("selected block: " .. selectedBlock,0,30)
end

function love.update()
end

function block_collision_check(direction, blockMoved)
	if direction == "down" then
		for q = 1,#blocks[1][blockMoved] do
			--~ print(blocks[blockMoved][q].x)
			
			if grid[blocks[1][blockMoved][q].x][blocks[1][blockMoved][q].y + 1].flags[1] == "wall" then
				--~ love.event.quit()
				--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
				return true -- collision
			end
		end
	elseif direction == "up" then
		for q = 1,#blocks[1][blockMoved] do
			--~ print(blocks[blockMoved][q].x)
			
			if grid[blocks[1][blockMoved][q].x][blocks[1][blockMoved][q].y - 1].flags[1] == "wall" then
				--~ love.event.quit()
				--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
				return true -- collision
			end
		end
		elseif direction == "left" then
			for q = 1,#blocks[1][blockMoved] do
				--~ print(blocks[blockMoved][q].x)
				
				if grid[blocks[1][blockMoved][q].x - 1][blocks[1][blockMoved][q].y].flags[1] == "wall" then
					--~ love.event.quit()
					--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
					return true -- collision
				end
			end
		elseif direction == "right" then
			for q = 1,#blocks[1][blockMoved] do
				--~ print(blocks[blockMoved][q].x)
				if grid[blocks[1][blockMoved][q].x + 1][blocks[1][blockMoved][q].y].flags[1] == "wall" then
					return true -- collision
				end
			end
	end
	
	love.graphics.print("shape " .. shape,700,0)
	
	
end

function block_rotate(_blockRotated, direction)
	print("\n")
	--~ print(#blocks[_blockRotated])
	
		local offset = blocks[1][_blockRotated][1].x - blocks[1][_blockRotated][1].y
			for i = 1,#blocks[1][_blockRotated] do	
			local newX = blocks[1][_blockRotated][i].x 
			local newY = blocks[1][_blockRotated][i].y
		
			if direction == "clockwise" then
				blocks[1][_blockRotated][i].x = newY * -1 + (blocks[1][_blockRotated][1].y * 2) + offset
				blocks[1][_blockRotated][i].y = newX - offset
				print(blocks[1][_blockRotated][i].x .. " " .. blocks[1][_blockRotated][i].y)
			else
				blocks[1][_blockRotated][i].x = newY + offset
				blocks[1][_blockRotated][i].y = newX * -1 + (blocks[1][_blockRotated][1].y * 2) + offset
				print(blocks[1][_blockRotated][i].x .. " " .. blocks[1][_blockRotated][i].y)
			
			end
		end
		grid_blocks_check()
end

function love.keyreleased(key)
	if key == "e" then
		print("\n")
		for i in pairs(blocks[selectedBlock]) do
			print(blocks[selectedBlock][i].x .. " " .. blocks[selectedBlock][i].y)
		end
	end
	if key == "d" then
		if not (block_collision_check("right", selectedBlock)) then
			for i in pairs(blocks[1][selectedBlock]) do
				blocks[1][selectedBlock][i].x = blocks[1][selectedBlock][i].x + 1
			end
		end

		grid_blocks_check()
	end
	if key == "a" then
		if not (block_collision_check("left", selectedBlock)) then
			for i in pairs(blocks[1][selectedBlock]) do
				blocks[1][selectedBlock][i].x = blocks[1][selectedBlock][i].x - 1
			end
		end

		grid_blocks_check()
	end
	if key == "w" then
		
		if not (block_collision_check("up", selectedBlock)) then
			for i in pairs(blocks[1][selectedBlock]) do
				blocks[1][selectedBlock][i].y = blocks[1][selectedBlock][i].y - 1
			end
		end

		grid_blocks_check()
	end
	if key == "s" then
		
		if not (block_collision_check("down", selectedBlock)) then
			for i in pairs(blocks[1][selectedBlock]) do
				blocks[1][selectedBlock][i].y = blocks[1][selectedBlock][i].y + 1
			end
		end

		grid_blocks_check()
	end
	if key == "up" then
		if selectedBlock < #blocks[1] then
			selectedBlock = selectedBlock + 1
			grid_blocks_check()
		end
	end
	if key == "down" then
		
		if selectedBlock > 1 then
			selectedBlock = selectedBlock - 1
			grid_blocks_check()
		end
	end
	if key == "right" then
		block_rotate(selectedBlock, "clockwise")
	end
	if key == "left" then
		block_rotate(selectedBlock)
	end
	
	if key == "1" then
		shape = "box"
	end
	if key == "2" then
		shape = "line"
	end
	if key == "3" then
		shape = "tee"
	end
	if key == "4" then
		shape = "ell"
	end 
	
	if key == "backspace" then
		blocks[1][selectedBlock] = nil
		grid_blocks_check()
		
	end
	
end

function mouse_grid_collision(_x,_y)
	for i in pairs(grid) do
			for u in pairs(grid[i]) do
				if _x > grid[i][u].x and _x < grid[i][u].x + 9 and _y > grid[i][u].y and _y < grid[i][u].y + 9 then
					return true,i,u
				end
			end
		end
end

--~ function block_add(x,y)
	--~ table.insert(blocks, {
	
	
	
	--~ })
--~ end

function block_add(shape,originX,originY)
	if shape == "box" then
		table.insert(blocks[1], {
		{x = originX, y = originY},
		{x = originX + 1, y = originY},
		{x = originX, y = originY + 1},
		{x = originX + 1, y = originY + 1},
		
		})
		
	elseif shape == "line" then
		table.insert(blocks[1], {
		{x = originX, y = originY},
		{x = originX + 1, y = originY},
		{x = originX + 2, y = originY},
		{x = originX + 3, y = originY},
		})
	elseif shape == "tee"then
		table.insert(blocks[1], {
		{x = originX, y = originY},
		{x = originX + 1, y = originY},
		{x = originX + 2, y = originY},
		{x = originX + 1, y = originY + 1},
		})
	elseif shape == "ell" then
		--~ table.insert(blocks, {
		--~ {x = originX, y = originY},
		--~ {x = originX + 1, y = originY},
		--~ {x = originX, y = originY + 1},
		--~ {x = originX + 1, y = originY + 1}
		--~ })
	end
end

function is_occupied(_x,_y)
	for i in pairs(blocks[1]) do
				for u in pairs(blocks[1][i]) do
				--~ print(blocks[1][i][u].x .. " " .. blocks[1][i][u].y)
					if _x == blocks[1][i][u].x and _y == blocks[1][i][u].y then
						blocks[1][i] = nil
						grid_blocks_check()
					return true
					end
				end
			end
end

function love.mousereleased(x,y,button)
	if button == 1 then
		
		collision,orX,orY = mouse_grid_collision(x,y)
		
		if collision then

			
			occupied,ocX,ocY = is_occupied(orX, orY)
			
			if not occupied then
				block_add(shape,orX,orY)
				grid_blocks_check()
			end
			
		end
	end
end

--~ print(#blocks)
