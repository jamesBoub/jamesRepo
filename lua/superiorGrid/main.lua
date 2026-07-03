grid = {}
blocks = {
{{x = 1, y = 1},{x = 2, y = 1},{x = 3, y = 1}},
{{x = 1, y = 4},{x = 2, y = 4},{x = 3, y = 4}}
}
offset = {x = 100, y = 0}

for i = 1,40 do
	table.insert(grid, {})
	for u = 1,40 do
		table.insert(grid[i], {x = offset.x, y = offset.y, color = {0,1,1}})
		offset.y = offset.y + 10
	end
	offset.x = offset.x + 10
	offset.y = 0
end

--~ grid[2][1].color = {1,1,1}

for i in pairs(blocks) do
	for u in pairs(blocks[i]) do
		grid[blocks[i][u].x][blocks[i][u].y].color = {1,1,1}
	end
end

function love.draw()
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
		
			love.graphics.setColor(grid[i][u].color[1],grid[i][u].color[2],grid[i][u].color[3])
			
			
		
		love.graphics.rectangle("fill", grid[i][u].x, grid[i][u].y, 9,9)
		end
	end
end

