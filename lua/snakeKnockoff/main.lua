function love.load()
  player = {x =5, y = 5, segments = {}}
  grid = {size = 25}
  grid_generate()
  timer = .5
  direction = "right"
end

function love.update(dt)
  player_move_timer(50,dt)
end

function love.draw()
  love.graphics.print(timer, 600,0)
  for z = 1,#grid do
    if player.x  == grid[z].x / 26 and player.y == grid[z].y / 26 then
      love.graphics.setColor(1,0,0)
    end
    
    for i in pairs(player.segments) do
      if player.segments[i].segX == grid[z].x / 26 and player.segments[i].segY == grid[z].y / 26 then
        love.graphics.setColor(0,0,1)
      end
    end
    love.graphics.rectangle("fill", grid[z].x, grid[z].y, grid.size, grid.size)
    love.graphics.setColor(1,1,1)
  end
end

function grid_generate()
  local xOff = 0
  local yOff = 0
 for x = 1,20 do
    yOff = yOff + grid.size + 1
    xOff = 0
  for y = 1,20 do
    xOff = xOff + grid.size + 1
    table.insert(grid, {x = xOff, y = yOff, grid.size, grid.size})
  end
 end
end

function player_move_timer(duration, dt)
  if timer >= 0 then
    timer = timer - 1 * dt
  else
    table.insert(player.segments, {segX = player.x, segY = player.y})

    player_move(direction)
    timer = .3
  end
end

function love.keyreleased(key)
  if key == "up" then
   direction = "up"
  elseif key == "down" then
    direction = "down"
  elseif key == "left" then
    direction = "left"
  elseif key == "right" then
    direction = "right"
  end
end

function player_move(direction)
    if direction == "up" then
    player.y = player.y - 1
    
  elseif direction == "left" then
    player.x = player.x - 1
  elseif direction == "down" then
    player.y = player.y + 1
   
  elseif direction == "right" then
    player.x = player.x + 1
   
  end
end
