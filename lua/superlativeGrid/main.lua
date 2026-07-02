grid = {}

--~ origin = {x = 0, y = 0}
offset = {x = 0, y = 0}

for i = 1,4 do
	table.insert(grid, {})
	for u = 1,4 do
		table.insert(grid[i], {x = offset.x, y = offset.y})
		offset.y = offset.y + 10
	end
	offset.x = offset.x + 10
	offset.y = 0
end

function love.draw()
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
		love.graphics.rectangle("fill", grid[i][u].x, grid[i][u].y, 9,9)
		end
	end
end

for i in pairs(grid) do
	for u in pairs(grid) do
		print(grid[i][u])
	end
end
