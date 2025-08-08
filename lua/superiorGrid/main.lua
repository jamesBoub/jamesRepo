player = {x = 1, y = 1}
world = {}


function love.draw()
	
	grid_cell_color_change()
	love.graphics.print(player.x .. " " .. player.y, 500,0)
	textbox_render()
	
end

function love.update(dt)
	player_input()
	if player_on_grid(40,40) then
		world[player.x][player.y].id = "player"
	end
end



gridW = 40
gridH = 40

function grid_create(rows,cols)
	-- creates the grid and cells
local xOff = 0
local yOff = 0
	for _x = 1, rows do
		yOff = 0
		world[_x] = {}
		xOff = xOff + 11
		for _y = 1, cols do
			world[_x][_y] = {}	
			world[_x][_y] = {x = xOff, y = yOff, id = {}, flags = {}}
			yOff = yOff + 11
		end
	end
end

function player_input()
	function love.keyreleased(key)
		if key == "w" then
			player_move("up")
		elseif key == "a" then
			player_move("left")
		elseif key == "s" then
			player_move("down")
		elseif key == "d" then
			player_move("right")
		end
	end
	
	
	function love.mousereleased(x,y,key)
		if key == 1 then
			local mouseOnCell, cellReturned = mouse_is_on_cell()
				if mouseOnCell then
					if love.keyboard.isDown("lshift") then
						cell_modify(cellReturned,"box")
					else
						cell_modify(cellReturned,"solid")
						push_text("wall placed at " .. cellReturned.x .. " " .. cellReturned.y)
					end
				end
		elseif key == 2 then
			local mouseOnCell, cellReturned = mouse_is_on_cell()
				if mouseOnCell then
					cell_modify(cellReturned)
					push_text("cell cleared")
				end
		end
	end
end

function player_on_grid(w,h)
	-- checks whether the player is on the grid or not
	if player.x >= 1 and player.x <= 40 and player.y >= 1 and player.y <= 40 then
		return true
	end
end

function player_move(direction)
	world[player.x][player.y].id = {}
	
		if direction == "up" then
			if player.y > 1 then 
				isFree, obColliding = cell_is_free(world[player.x][player.y - 1]) 
					if isFree then
						player.y = player.y - 1
						push_text("moved up", true)
					else
						if obColliding.flags == "box" then
							print(obColliding.x / 11 .. " " .. obColliding.y / 11)
						end
					end
			end
		elseif direction == "down" then
			if player.y < gridH then 
				isFree, obColliding = cell_is_free(world[player.x][player.y + 1]) 
					if isFree then
						player.y = player.y + 1
						push_text("moved up", true)
					else
						if obColliding.flags == "box" then
							print(obColliding.x / 11 .. " " .. obColliding.y / 11)
						end
					end
			end
		elseif direction == "left" then
			if player.x > 1 then 
				isFree, obColliding = cell_is_free(world[player.x - 1][player.y]) 
					if isFree then
						player.x = player.x - 1
						push_text("moved up", true)
					else
						if obColliding.flags == "box" then
							print(obColliding.x / 11 .. " " .. obColliding.y / 11)
						end
					end
			end
		elseif direction == "right" then
			if player.x < gridW then 
				isFree, obColliding = cell_is_free(world[player.x + 1][player.y]) 
					if isFree then
						player.x = player.x + 1
						push_text("moved up", true)
					else
						if obColliding.flags == "box" then
							print(obColliding.x / 11 .. " " .. obColliding.y / 11)
						end
					end
			end
	end
end

function push_box()
	
end

function cell_is_free(cell)
 -- checks whether the cell is unoccupied
	if type(cell.flags) == "string" then
		push_text("Hit " .. cell.flags .. " at " .. cell.x / 11 .. " " .. cell.y / 11, true)
		return false, cell
	else
		return true
	end
end

function grid_cell_color_change()
	for i in pairs(world) do
		for u in pairs(world[i]) do
			if world[i][u].id == "player" then
				love.graphics.setColor(1,0,0)
			elseif world[i][u].flags == "solid" then
				love.graphics.setColor(0,0,1)
			elseif world[i][u].flags == "box" then
				love.graphics.setColor(0,1,0)
			else
				love.graphics.setColor(1,1,1)
			end
				love.graphics.rectangle("fill", world[i][u].x, world[i][u].y, 10,10)
			end
		end
end

function mouse_is_on_cell()

	local mouseX, mouseY = love.mouse.getPosition()

	for i in pairs(world) do
		for u in pairs(world[i]) do
			if mouseX > world[i][u].x and mouseX < world[i][u].x + 10 and mouseY > world[i][u].y and mouseY < world[i][u].y + 10 then
				local cellRolledOver = world[i][u]
				return true, cellRolledOver
			end
		end
	end
end

function cell_modify(cell,modification)
	-- changes a cell based on modification. leave parameter 2 empty to remove flag, leaving cell empty
	cell.flags = modification
	print(cell.flags)
end



function textbox()

	
	local textBoxOrigin = 0
	
	function create_textbox()
		textbox = {
			current = 1,
			lines = {
				--~ {words = "",x = 600, y = 0},
				
			}
		}
		
		for u = 1,8 do
			textbox.lines[u] = {words = "",x = 600, y = textBoxOrigin}
			textBoxOrigin = textBoxOrigin + 25
		end
	end
		
	
		local lastMessage
		local reps = 2
	function push_text(message)
		-- pushes parameter 1 to the textbox. if last message pushed is the same as the message being pushed currently the string will be string .. x .. n
		if lastMessage == message then
			textbox.lines[8].words = message .. " x" .. reps
			reps = reps + 1
		else
			for _x = 1,7 do
				textbox.lines[_x].words = textbox.lines[_x + 1].words
			end
				textbox.lines[8].words = message
				reps = 2
		end
		lastMessage = message
	end
	
		function textbox_render()
			-- renders the textbox
			for i in pairs(textbox.lines) do
				love.graphics.print(textbox.lines[i].words, textbox.lines[i].x, textbox.lines[i].y)
			end
	end
end

textbox()
grid_create(gridW,gridH)
create_textbox()

print(textbox.lines[1].x)
print(textbox.lines[2].words)
