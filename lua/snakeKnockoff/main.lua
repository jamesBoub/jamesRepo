function love.load()
  love.window.setTitle("snake knockoff")
  gridCreate(50,50,0,0,10,0)
  player = {x = 1, y = 1, length = 0, direction = "right"}
  timer = 1
end

function love.update(dt)
  player_move_timer(50,dt)
end

function love.draw()
  love.graphics.setColor(1,1,1)
  player_position()
  grid_draw()
  love.graphics.print(timer, 600,0)
end

function gridCreate(gridLength, gridHeight,originX, originY, _cellSize, cellSpacing)
  
  grid = {}
  grid = {cellSize}
  grid.cellSize = _cellSize
  local Xoffset = 0
  local Yoffset = 0
  
  for y = 1,gridHeight do
    Xoffset = 11
      Yoffset = Yoffset + _cellSize + 1
  for x = 1,gridLength do
      table.insert(grid, {x = originX + Xoffset, y = originY + Yoffset})
      Xoffset = Xoffset + _cellSize + 1
    end
  end
end

function grid_draw()
  for x = 1,#grid do
      love.graphics.rectangle("fill", grid[x].x, grid[x].y, grid.cellSize, grid.cellSize)
      love.graphics.setColor(1,1,1)
    end
end

function player_position()
--  for z = 1,#grid do
--    if player.x == grid[z].x / 11 then
--        love.graphics.setColor(1,0,0)
--    end
--  end
  for i in pairs(grid) do
      if grid ~= 
        print(grid[i].x)
    end
end

function love.keyreleased(key)
  if key == "up" then
    player.direction = "up"
  elseif key == "down" then
    player.direction = "down"
  elseif key == "left" then
    player.direction = "left"
  elseif key == "right" then
    player.direction = "right"
  end
end

function player_move_timer(duration, dt)
  if timer >= 0 then
      timer = timer - 1 * dt
    else
      player_move(player.direction)
    end
end

function player_move(direction)
--  if direction == "up" then
--    player.y = player.y - 11
--  elseif direction == "left" then
--    player.x = player.x - 11
--  elseif direction == "down" then
--    player.y = player.y + 11
--  elseif direction == "right" then
--    player.x = player.x + 11
--  end
end
