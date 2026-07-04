grid = {}
blocks = {
{{x = 3,y = 4},{x = 4,y = 4}},
{{x = 3,y = 8},{x = 4,y = 8},{x = 5,y = 8}},
}
offset = {x = 0, y = 0}

selectedBlock = 2

rows = 40
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
		for u in pairs(grid) do
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
			love.graphics.setColor(1,1,1)
			if grid[i][u].flags[1] == "wall" then
				love.graphics.setColor(1,0,0)
			elseif grid[i][u].flags[1] == "active" then
				love.graphics.setColor(0,1,0)
			end
			love.graphics.rectangle("fill", grid[i][u].x, grid[i][u].y, 9,9)
		end
	end
	
	love.graphics.print(selectedBlock, 450, 100)
	
end

function love.update()
	--~ for i in pairs(blocks) do
		--~ for u in pairs(blocks) do
			
		--~ end
	--~ end
end



function love.keyreleased(key)
	if key == "d" then
		for i in pairs(blocks[selectedBlock]) do
			blocks[selectedBlock][i].x = blocks[selectedBlock][i].x + 1
		end
		grid_blocks_check()
	end
	if key == "a" then
		for i in pairs(blocks[selectedBlock]) do
			blocks[selectedBlock][i].x = blocks[selectedBlock][i].x - 1
		end
		grid_blocks_check()
	end
	if key == "w" then
		for i in pairs(blocks[selectedBlock]) do
			blocks[selectedBlock][i].y = blocks[selectedBlock][i].y - 1
		end
		grid_blocks_check()
	end
	if key == "s" then
		for i in pairs(blocks[selectedBlock]) do
			blocks[selectedBlock][i].y = blocks[selectedBlock][i].y + 1
		end
		grid_blocks_check()
	end
	if key == "up" then
		if selectedBlock < #blocks then
			selectedBlock = selectedBlock + 1
		end
	end
	if key == "down" then
		
		if selectedBlock > 1 then
			selectedBlock = selectedBlock - 1
		end
	end
end
print(#blocks)
