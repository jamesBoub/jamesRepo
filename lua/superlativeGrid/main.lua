grid = {}
blocks = {
{{x = 3,y = 4},{x = 4,y = 4}},
{{x = 3,y = 8},{x = 4,y = 8},{x = 5,y = 8}},

}
offset = {x = 0, y = 0}

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

--~ grid[1][1].flags[1] = "wall"


function grid_blocks_check()
	
	for i in pairs(grid) do
		for u in pairs(grid) do
			grid[i][u].flags = {}
		end
	end
	
		for i in pairs(blocks) do
		for u in pairs(blocks[i]) do
			grid[blocks[i][u].x][blocks[i][u].y].flags[1] = "wall"
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
			end
			love.graphics.rectangle("fill", grid[i][u].x, grid[i][u].y, 9,9)
		end
	end
end
selectedBlock = 2
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
end
