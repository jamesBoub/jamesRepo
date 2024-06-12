function love.load()
  player = {x =5, y = 5, segments = {}}
  grid = {size = 25}
  grid_generate()
  timer = .5
  direction = "right"
  length = 1
  apples = {}
  apple_create()
  rate = 5
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
    
    for u = 1,#apples do
        if apples[u].x == grid[z].x / 26 and apples[u].y == grid[z].y / 26 then
            love.graphics.setColor(0,1,0)
          end
          if player.x == apples[u].x and player.y == apples[u].y then
            table.remove(apples, u)
            length = length + 1
--            rate = rate + .2
            apple_create()
            end
      end
      
  if player.x > 20 or player.x <= 0 or player.y > 20 or player.y <= 0 then
      love.event.quit()
    end
    
    for i in pairs(player.segments) do
      if player.segments[i].segX == grid[z].x / 26 and player.segments[i].segY == grid[z].y / 26 then
        love.graphics.setColor(0,0,1)
      end
      
      if player.x == player.segments[i].segX and player.y == player.segments[i].segY then
          love.event.quit()
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
    timer = timer - rate * dt
  else
      table.insert(player.segments, {segX = player.x, segY = player.y})
      if #player.segments >= length then
        table.remove(player.segments, 1)
      end
  
    player_move(direction)
    timer = .5
  end
end

function love.keyreleased(key)
  if key == "up" and direction ~= "down" then
   direction = "up"
  elseif key == "down" and direction ~= "up" then
    direction = "down"
  elseif key == "left" and direction ~= "right" then
    direction = "left"
  elseif key == "right" and direction ~= "left" then
    direction = "right"
  elseif key == "space" then
    table.remove(player.segments, 1)
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

function apple_create()
  local appleX = love.math.random(1,20)
  local appleY = love.math.random(1,20)
  table.insert(apples, {x = appleX, y = appleY})
end
