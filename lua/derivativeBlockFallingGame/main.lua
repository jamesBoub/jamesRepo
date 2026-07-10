grid = {}
blocks = {
{{x = 6,y = 12},{x = 7,y = 12},{x = 8,y = 12},{x = 9,y = 12}},
{{x = 6,y = 14},{x = 7,y = 14},{x = 8,y = 14}},
--~ {{x = 6,y = 14}}
}
offset = {x = 0, y = 0}

selectedBlock = 1

rows = 43
cols = 40

for i = 1,rows do
	table.insert(grid, {})
	for u = 1,cols do
		table.insert(grid[i], {x = offset.x, y = offset.y, flags = {}})
		offset.y = offset.y + 10
	end
	offset.x = offset.x + 10
	offset.y = 0
end

function grid_blocks_check()
	
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
			grid[i][u].flags = {}
		end
	end
	
		for i in pairs(blocks) do
			for u in pairs(blocks[i]) do
				
				if i == selectedBlock then
					grid[blocks[i][u].x][blocks[i][u].y].flags[1] = "active"
				else
					grid[blocks[i][u].x][blocks[i][u].y].flags[1] = "wall"
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
	
	love.graphics.print(selectedBlock, 450, 100)
	
end

function love.update()
	
		--~ for u in pairs(blocks) do
			
			--~ if grid[blocks[selectedBlock][u].x][blocks[selectedBlock][u].y - 1].flags[1] == "wall" or grid[blocks[selectedBlock][u].x][blocks[selectedBlock][u].y + 1].flags[1] == "wall" then
				--~ love.event.quit()
			--~ end
	--~ end
end

function block_collision_check(direction, blockMoved)
	if direction == "down" then
		for q = 1,#blocks[blockMoved] do
			print(blocks[blockMoved][q].x)
			
			if grid[blocks[blockMoved][q].x][blocks[blockMoved][q].y + 1].flags[1] == "wall" then
				--~ love.event.quit()
				--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
				return true -- collision
			end
		end
	elseif direction == "up" then
		for q = 1,#blocks[blockMoved] do
			print(blocks[blockMoved][q].x)
			
			if grid[blocks[blockMoved][q].x][blocks[blockMoved][q].y - 1].flags[1] == "wall" then
				--~ love.event.quit()
				--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
				return true -- collision
			end
		end
		elseif direction == "left" then
			for q = 1,#blocks[blockMoved] do
				print(blocks[blockMoved][q].x)
				
				if grid[blocks[blockMoved][q].x - 1][blocks[blockMoved][q].y].flags[1] == "wall" then
					--~ love.event.quit()
					--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
					return true -- collision
				end
			end
		elseif direction == "right" then
			for q = 1,#blocks[blockMoved] do
				print(blocks[blockMoved][q].x)
				if grid[blocks[blockMoved][q].x + 1][blocks[blockMoved][q].y].flags[1] == "wall" then
					return true -- collision
				end
			end
	end
end




function love.keyreleased(key)
	if key == "d" then
		if not (block_collision_check("right", selectedBlock)) then
			for i in pairs(blocks[selectedBlock]) do
				blocks[selectedBlock][i].x = blocks[selectedBlock][i].x + 1
			end
		end

		grid_blocks_check()
	end
	if key == "a" then
		if not (block_collision_check("left", selectedBlock)) then
			for i in pairs(blocks[selectedBlock]) do
				blocks[selectedBlock][i].x = blocks[selectedBlock][i].x - 1
			end
		end

		grid_blocks_check()
	end
	if key == "w" then
		
		if not (block_collision_check("up", selectedBlock)) then
			for i in pairs(blocks[selectedBlock]) do
				blocks[selectedBlock][i].y = blocks[selectedBlock][i].y - 1
			end
		end

		grid_blocks_check()
	end
	if key == "s" then
		
		if not (block_collision_check("down", selectedBlock)) then
			for i in pairs(blocks[selectedBlock]) do
				blocks[selectedBlock][i].y = blocks[selectedBlock][i].y + 1
			end
		end

		grid_blocks_check()
	end
	if key == "up" then
		if selectedBlock < #blocks then
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
end
--~ print(#blocks)
