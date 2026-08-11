grid = {}
blocks = {
{{x = 35,y = 12,},{x = 36,y = 12},{x = 37,y = 12},{x = 38,y = 12},color = {1,0,0}},



{{x = 6,y = 14},{x = 7,y = 14},{x = 8,y = 14},color = {1,0,0}},
}


--~ print(blocks[1].color)
--~ print(#blocks[4])


--~ print(#blocks[1].color)

for i in pairs(blocks) do
	--~ for u in pairs(blocks[i]) do
	for u = 1,#blocks[i] do
		print(blocks[i][u].x)
	end
end

offset = {x = 0, y = 50}
timers = {}

selectedBlock = 1
shape = "box"

rows = 43
cols = 40

canmove = true
canrotate = true

--~ print(blocks[1][1].color[1])

--~ print(blocks[2])
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
	
		for i in pairs(blocks) do
			for u = 1,#blocks[i] do
				
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


	for i in pairs(timers) do
		love.graphics.print(timers[i].duration, i * 100, 25)
	end
	
	for i in pairs(grid) do
		for u in pairs(grid[i]) do
		
			local flag = grid[i][u].flags[1]
		
			love.graphics.setColor(1,1,1)
			if flag == "wall" then
				love.graphics.setColor(1,0,0)
				--~ print(i .. " " .. u)
				
				for z in pairs(blocks) do
					for zz in pairs(blocks[z]) do
						if blocks[z][zz].x == i and blocks[z][zz].y == u then
							--~ print(blocks[z][1].color[1])
							
							love.graphics.setColor(blocks[z].color[1],blocks[z].color[2],blocks[z].color[3])
						end
					end
				end
				
				
			elseif flag == "active" then
				love.graphics.setColor(0,1,0)
			end
			love.graphics.rectangle("fill", grid[i][u].x, grid[i][u].y, 9,9)
		end
	end
	
	love.graphics.print("shape: " .. shape)
	
end

function love.update(dt)
	timer_decrement(dt)
end

function block_collision_check(direction, blockMoved)
	if direction == "down" then
		for q = 1,#blocks[blockMoved] do
			--~ print(blocks[blockMoved][q].x)
			if blocks[blockMoved][q].y < 40 then 
				if grid[blocks[blockMoved][q].x][blocks[blockMoved][q].y + 1].flags[1] == "wall" then
				--~ love.event.quit()
				--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
				return true -- collision
			end
		end
	end
		
	elseif direction == "up" then
		for q = 1,#blocks[blockMoved] do
			--~ print(blocks[blockMoved][q].x)
			if blocks[blockMoved][q].y > 1 then 
				if grid[blocks[blockMoved][q].x][blocks[blockMoved][q].y - 1].flags[1] == "wall" then
				--~ love.event.quit()
				--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
				return true -- collision
			end
		end
	end

		elseif direction == "left" then
			for q = 1,#blocks[blockMoved]  do
				--~ print(blocks[blockMoved][q].x)		
				if blocks[blockMoved][q].x > 1 then
					if grid[blocks[blockMoved][q].x - 1][blocks[blockMoved][q].y].flags[1] == "wall" then
						--~ love.event.quit()
						--~ blocks[selectedBlock][q].y = blocks[selectedBlock][q].y - 3
						return true -- collision
					end
				end
			end
			
		elseif direction == "right" then
			for q = 1,#blocks[blockMoved]  do
				--~ print(blocks[blockMoved][q].x)
				if blocks[blockMoved][q].x < 42 then
				if grid[blocks[blockMoved][q].x + 1][blocks[blockMoved][q].y].flags[1] == "wall" then
					return true -- collision
				end
			end
		end
		
		
	end
	
	love.graphics.print("shape " .. shape,700,0)
	
end

function block_rotate(_blockRotated, direction)
canrotate = true
	--~ print("\n")
	--~ print(#blocks[_blockRotated])
	
		local offset = blocks[_blockRotated][1].x - blocks[_blockRotated][1].y
		
		if direction == "clockwise" then
			--~ love.event.quit()
			for i = 1,#blocks[_blockRotated] do
			
				local _newX = blocks[_blockRotated][i].x 
				local _newY = blocks[_blockRotated][i].y
				
				rotatedX =  _newX - offset
				rotatedY = _newY * -1 + (blocks[_blockRotated][1].y * 2) + offset
				
				if _newY * -1 + (blocks[_blockRotated][1].y * 2) + offset > 43 or _newX - offset > 40 or _newY * -1 + (blocks[_blockRotated][1].y * 2) + offset < 1 or _newX - offset < 1 then
					canrotate = false
				else
					if grid[rotatedY][rotatedX].flags[1] == "wall" then
						canrotate = false
					end
				end
				
				
				
			end
		else
			for i = 1,#blocks[_blockRotated] do
					
					local _newX = blocks[_blockRotated][i].x 
					local _newY = blocks[_blockRotated][i].y
					
					rotatedX =  _newX * -1 + (blocks[_blockRotated][1].y * 2) + offset
					rotatedY = _newY + offset
					
					if _newY + offset > 43 or _newX * -1 + (blocks[_blockRotated][1].y * 2) + offset > 40 or _newY + offset < 1 or _newX * -1 + (blocks[_blockRotated][1].y * 2) + offset < 1 then
						canrotate = false
					else
						if grid[rotatedY][rotatedX].flags[1] == "wall" then
							canrotate = false
						end
					end	
				end
		end
		
			for i = 1,#blocks[_blockRotated] do	
			local newX = blocks[_blockRotated][i].x 
			local newY = blocks[_blockRotated][i].y
		
			if direction == "clockwise" and canrotate then		
			
					blocks[_blockRotated][i].x = newY * -1 + (blocks[_blockRotated][1].y * 2) + offset
					blocks[_blockRotated][i].y = newX - offset
					
			elseif canrotate then
			
				blocks[_blockRotated][i].x = newY + offset
				blocks[_blockRotated][i].y = newX * -1 + (blocks[_blockRotated][1].y * 2) + offset
				
			end
		end
		grid_blocks_check()
end

function move_down()

	--~ for i in pairs(blocks[selectedBlock]) do
	for i = 1,#blocks[selectedBlock]  do
	
	
			if blocks[selectedBlock][i].y >= 40 then
			
				canmove = false
				
			end
		end
		
		if not (block_collision_check("down", selectedBlock)) then
									--~ for i in pairs(blocks[selectedBlock]) do
									for i = 1,#blocks[selectedBlock]  do
										if blocks[selectedBlock][i].y < 40 and canmove then
											blocks[selectedBlock][i].y = blocks[selectedBlock][i].y + 1
										else
											--~ love.event.quit()
											break
										end
									end
		else
			--~ love.event.quit()
			timers[#timers].currentRep = timers[#timers].maxRep
		end
		canmove = true
		grid_blocks_check()
end

function move_up()
	--~ for i in pairs(blocks[selectedBlock]) do
	for i = 1,#blocks[selectedBlock]  do
			if blocks[selectedBlock][i].y <= 1 then
				canmove = false
			end
		end
		
		if not (block_collision_check("up", selectedBlock)) then
			--~ for i in pairs(blocks[selectedBlock]) do
			for i = 1,#blocks[selectedBlock]  do
				if blocks[selectedBlock][i].y > 1 and canmove then
					blocks[selectedBlock][i].y = blocks[selectedBlock][i].y - 1
				else
					break
				end
			end
		end
		canmove = true
		grid_blocks_check()
end

function move_left()
	--~ for i in pairs(blocks[selectedBlock]) do
	 for i = 1,#blocks[selectedBlock]  do
			if blocks[selectedBlock][i].x <= 1 then
				canmove = false
			end
		end
		
		if not (block_collision_check("left", selectedBlock)) then
			--~ for i in pairs(blocks[selectedBlock]) do
			for i = 1,#blocks[selectedBlock]  do
				if blocks[selectedBlock][i].x > 1 and canmove then
				blocks[selectedBlock][i].x = blocks[selectedBlock][i].x - 1
				else
					break -- at edge, stop
				end
			end
		end
		canmove = true
		grid_blocks_check()
end

function move_right()
	--~ for i in pairs(blocks[selectedBlock]) do
	for i = 1,#blocks[selectedBlock]  do
			if blocks[selectedBlock][i].x >= 43 then
				canmove = false
			end
		end
	
	
		if not (block_collision_check("right", selectedBlock)) then
			--~ for i in pairs(blocks[selectedBlock]) do
			for i = 1,#blocks[selectedBlock]  do
				if blocks[selectedBlock][i].x < 43 and canmove then
				blocks[selectedBlock][i].x = blocks[selectedBlock][i].x + 1
				end
			end
		end
		canmove = true
		grid_blocks_check()
end

function love.keyreleased(key)
canrotate = true
	
	if key == "space" then
		--~ print(#timers)
		--~ love.event.quit()
		--~ for x = 1,rows do
			--~ print(grid[x][1].flags[1])
		--~ end
		timer_create(5,bupkis)
		--~ print(#timers)
	end
	
	
	if key == "e" then
		print("\n")
		for i in pairs(blocks[selectedBlock]) do
			print(blocks[selectedBlock][i].x .. " " .. blocks[selectedBlock][i].y)
		end
	end
	if key == "d" then
		timer_create(.1, move_right)
	--~ for i in pairs(blocks[selectedBlock]) do
			--~ if blocks[selectedBlock][i].x >= 43 then
				--~ canmove = false
			--~ end
		--~ end
	
	
		--~ if not (block_collision_check("right", selectedBlock)) then
			--~ for i in pairs(blocks[selectedBlock]) do
				--~ if blocks[selectedBlock][i].x < 43 and canmove then
				--~ blocks[selectedBlock][i].x = blocks[selectedBlock][i].x + 1
				--~ end
			--~ end
		--~ end
		--~ canmove = true
		--~ grid_blocks_check()
	end
	if key == "a" then
		timer_create(.1, move_left)
		--~ for i in pairs(blocks[selectedBlock]) do
			--~ if blocks[selectedBlock][i].x <= 1 then
				--~ canmove = false
			--~ end
		--~ end
		
		--~ if not (block_collision_check("left", selectedBlock)) then
			--~ for i in pairs(blocks[selectedBlock]) do
				--~ if blocks[selectedBlock][i].x > 1 and canmove then
				--~ blocks[selectedBlock][i].x = blocks[selectedBlock][i].x - 1
				--~ else
					--~ break -- at edge, stop
				--~ end
			--~ end
		--~ end
		--~ canmove = true
		--~ grid_blocks_check()
	end
	if key == "w" then
		timer_create(.1, move_up)
		--~ for i in pairs(blocks[selectedBlock]) do
			--~ if blocks[selectedBlock][i].y <= 1 then
				--~ canmove = false
			--~ end
		--~ end
		
		--~ if not (block_collision_check("up", selectedBlock)) then
			--~ for i in pairs(blocks[selectedBlock]) do
				--~ if blocks[selectedBlock][i].y > 1 and canmove then
					--~ blocks[selectedBlock][i].y = blocks[selectedBlock][i].y - 1
				--~ else
					--~ break
				--~ end
			--~ end
		--~ end
		--~ canmove = true
		--~ grid_blocks_check()
	end
	if key == "s" then
		timer_create(.1, move_down)
		--~ move_down()
		--~ for i in pairs(blocks[selectedBlock]) do
			--~ if blocks[selectedBlock][i].y >= 40 then
				--~ canmove = false
			--~ end
		--~ end
		
		--~ if not (block_collision_check("down", selectedBlock)) then
			--~ for i in pairs(blocks[selectedBlock]) do
				--~ if blocks[selectedBlock][i].y < 40 and canmove then
					--~ blocks[selectedBlock][i].y = blocks[selectedBlock][i].y + 1
				--~ else
					--~ break
				--~ end
			--~ end
		--~ end
		--~ canmove = true
		--~ grid_blocks_check()
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
	
	if key == "lctrl" then
		--~ love.event.quit()
		os.execute("clear")
		--~ gug = 0
		
		markedForDeath = {}
		
		for y = 1,40 do
		gug = 0
			for x = 1,43 do
				--~ print(grid[x][1].flags[1])
				
				if grid[x][y].flags[1] ~= nil then
					gug = gug + 1
					
					if gug >= 4 then
						-- work backwards
						--~ for yy = y,1, -1 do
							--~ print(yy)
							
							table.insert(markedForDeath, {y})
							
							
						--~ end
						
					end
					
				end
				
			end
			--~ print("in row" .. y .. " there were " .. gug .. " occupied cells")
			
			
			--~ print(#markedForDeath)
		end
		
		for i in pairs(markedForDeath) do
			for u in pairs(blocks) do
				for z in pairs(blocks[u]) do
					
					if blocks[u][z].y ==  markedForDeath[i][1] then
						--~ print(u)
						--~ blocks[u][z] = nil
						--~ table.remove(blocks[u], z)
						--~ table.remove(blocks, u)
						
						grid_blocks_check()
					end
				
				end
			end
		end
		
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

function block_add(shape,originX,originY)
	if shape == "box" then
		table.insert(blocks, {
		{x = originX, y = originY, color = {1,0,0}},
		{x = originX + 1, y = originY},
		{x = originX, y = originY + 1},
		{x = originX + 1, y = originY + 1},
		
		})
		
	elseif shape == "line" then
		table.insert(blocks, {
		{x = originX, y = originY, color = {1,0,1}},
		{x = originX + 1, y = originY},
		{x = originX + 2, y = originY},
		{x = originX + 3, y = originY},
		})
	elseif shape == "tee"then
		table.insert(blocks, {
		{x = originX, y = originY, color = {0,0,1}},
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

function love.mousereleased(x,y,button)
	if button == 1 then
		
		collision,orX,orY = mouse_grid_collision(x,y)
		
		if collision then
			--~ print(x)
			block_add(shape,orX,orY)
			selectedBlock = #blocks
			grid_blocks_check()
			--~ for x = 1,2 do
				timer_create(.5, move_down, true, 43)
			--~ end
		end
	end
end


function timer_create(_duration, _action, _repeats, _maxRep)
	table.insert(timers, {duration = _duration, completed = "false", action = _action, repeats = _repeats, currentRep = 0, maxRep = _maxRep})
end

function timer_decrement(_dt)
	--~ love.event.quit()
	
	for i in pairs(timers) do
			if timers[i].duration <= 0 then
				--~ timers[i].completed = true
				
				
				if timers[i].repeats then
					timers[i].currentRep = timers[i].currentRep + 1
					timers[i].action()
					timers[i].duration = .5
					if timers[i].currentRep >= timers[i].maxRep then
						timers[i] = nil
					end
				else
					timers[i].action()
					timers[i] = nil
				end
				
			else
				timers[i].duration = timers[i].duration - 1 * _dt
			end
			
	end
	
end

function bupkis()
	print("bupkis :)")
end

