player = {x = 50, y = 100, w = 10, h = 10, v = 15}
obstacles = {}

lastPosition = {player.x, player.y}

function love.draw()
  input()
  if collisions() then
    player.x = lastPosition[1]
    player.y = lastPosition[2]
  else
    lastPosition = {player.x, player.y}
  end
  
    love.graphics.print(player.x .. " " .. player.y)
    love.graphics.print(lastPosition[1] .. " " .. lastPosition[2], 0, 100)
  
    love.graphics.setColor(1,0,0)
  
  for i in pairs(obstacles) do 
    love.graphics.rectangle('fill', obstacles[i].x, obstacles[i].y, obstacles[i].w, obstacles[i].h)
  end
  
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
  
end

table.insert(obstacles, {x = 200, y = 300, w = 100, h = 100})

function input()
  if love.keyboard.isDown("w") then
    player.y = player.y - player.v
  end
  if love.keyboard.isDown("a") then
    player.x = player.x - player.v
  end
  if love.keyboard.isDown("s") then
    player.y = player.y + player.v
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + player.v
  end
end

function collisions()
  if player.x + player.w > obstacles[1].x and player.x < obstacles[1].x + obstacles[1].w and player.y + player.h > obstacles[1].y and player.y  < obstacles[1].y + obstacles[1].h then
    return true
  end
end
