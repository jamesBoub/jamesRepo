player = {}
world = {}

function love.draw()
	for i in pairs(world) do
		for u in pairs(world[i]) do
			love.graphics.rectangle("fill", world[i][u].x, world[i][u].y, 10,10)
		end
	end
end

function love.update()
end

function grid_create(rows,cols)
local xOff = 0
local yOff = 0
	for _x = 1, rows do
		yOff = 0
		world[_x] = {}
		xOff = xOff + 11
		for _y = 1, cols do
			world[_x][_y] = {}	
			world[_x][_y] = {x = xOff, y = yOff}
			yOff = yOff + 11
			end
		end
	end

grid_create(40,40)
print(world[1][2].x)

