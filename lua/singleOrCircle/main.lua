player = {x = 1, y = 1}
grid = {}

gridX = 20
gridY = 20

cellDim = 9

mode = "single"
lighting = false

flags = {
-- {name, color}
{name = "player", color = {1,0,0}},
{name = "wall", color = {0,0,1}}
}

function love.draw()
	
	if player_within_bounds() then
		grid[player.x][player.y].flags = "player"
	end
	
	
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
			love.graphics.setColor(1,1,1) -- grid background color
			for z in pairs(flags) do
				if grid[i][u].flags == flags[z].name then
					love.graphics.setColor(flags[z].color[1],flags[z].color[2],flags[z].color[3])
				end
			end
				if grid[i][u].bright or not lighting then
				love.graphics.rectangle("fill", grid[i][u].x, grid[i][u].y, cellDim , cellDim)
				end
		end
	end
	

end

function love.update()
end

function grid_generate(rowLen,colLen,xPlacement,yPlacement)

local xOff = xPlacement
local yOff = yPlacement 

for x = 1,rowLen do
	yOff = yPlacement
	grid[x] = {}
	xOff = xOff + cellDim + 1
	for y = 1,colLen do
		grid[x][y] = {}
		grid[x][y] = {x = xOff, y = yOff, flag = {}, bright = true}
		yOff = yOff + cellDim + 1
	end
	end	
end

motionKeys = {"w","a","s","d"}

function love.keyreleased(key)
	 local motKeyBool, motKey =  motion_key_pressed(key) 
		if motKeyBool then
		if player_within_bounds() then
		grid[player.x][player.y].flags = {}
		
		--~ local modKey = false

			
		
			if motKey == "w" then
				if player.y > 1 and not modKey then
				player.y = player.y - 1
				end
			elseif motKey == "a" and not modKey then
				if player.x > 1 then
				player.x = player.x - 1
				end
			elseif motKey == "s" and not modKey then
				if player.y < gridY then
				player.y = player.y + 1
				end
			elseif motKey == "d" and not modKey then
				if player.x < gridX then 
				player.x = player.x + 1
				--~ print(modkey)
				end
			end
			shitfuck()
		
		end
	else
	
	if key == "1" then
		mode = "single"
	elseif key == "2" then
		mode = "circle"
	elseif key == "q" then
		for i in pairs(grid) do
			for u in pairs(grid[i]) do
				grid[i][u].flags = nil
			end
		end	
	elseif key == "l" then
		if lighting then
			lighting = false
		else
			lighting = true
		end
	end
	
	end


end

function distance_between_2_points(x1,x2,y1,y2)
result = math.sqrt((x2-x1)^2+(y2-y1)^2)
 if result ~= nil then
   return result
  end
end

function love.mousereleased(x,y,button)
	
	
	local modKey = false
	
	if love.keyboard.isDown("lshift") then
		modKey = true
	else
		modKey = false
	end


	if button == 1 then
		onGrid, cellRolled = mouse_is_on_cell()
		
		if onGrid then
			if modKey == false then
				cellRolled.flags = "wall"
			else
				cellRolled.flags = nil
			end
			
		end
		
	end
end



circleR = 50


function shitfuck()

local mouseX, mouseY = love.mouse.getPosition()
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
				grid[i][u].bright = true
				if distance_between_2_points(grid[player.x][player.y].x,grid[i][u].x,grid[player.x][player.y].y,grid[i][u].y) > circleR then
					grid[i][u].bright = false
				end
				
				
			end
		end
end

function mouse_is_on_cell()

	local mouseX, mouseY = love.mouse.getPosition()


if mode == "single" then

	for i in pairs(grid) do
		for u in pairs(grid[i]) do
			if mouseX > grid[i][u].x and mouseX < grid[i][u].x + 10 and mouseY > grid[i][u].y and mouseY < grid[i][u].y + 10 then
				local cellRolledOver = grid[i][u]
				return true, cellRolledOver
				end
			end
		end
elseif mode == "circle" then
shitfuck()
	--~ for i in pairs(grid) do
		--~ for u in pairs(grid[i]) do
				
				--~ if distance_between_2_points(mouseX,grid[i][u].x,mouseY,grid[i][u].y) > circleR then
					--~ grid[i][u].flags = "wall"
				--~ end
				
				
			--~ end
		--~ end
	end
end



function motion_key_pressed(_key)
	for i = 1,#motionKeys do
		if motionKeys[i] == _key then
			return true, motionKeys[i]
		end
	end
end

--~ function player_within_bounds()
	--~ if grid[player.x] ~= nil then
			--~ if grid[player.x][player.y] ~= nil then
				--~ return true
			--~ else
					--~ return false
			--~ end
		--~ end
--~ end

function player_within_bounds()
	if grid[player.x] ~= nil then
			if grid[player.x][player.y] ~= nil then
				return true
			else
					return false
			end
		end
end

grid_generate(gridX,gridY,0,0)


