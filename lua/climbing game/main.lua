player = {x = 50, y = 100, w = 10, h = 10, v = 10, last = {nil,nil}}
obstacles = {}

function love.draw()
  print(player.last[2])
  input()
  if collisions(player,obstacles) then
    player.x = player.last[1]
    player.y = player.last[2]
  else
    player.last = {player.x, player.y}
  end
  
    love.graphics.print(player.x .. " " .. player.y)
    love.graphics.setColor(1,0,0)
  
  for i in pairs(obstacles) do 
    love.graphics.rectangle('fill', obstacles[i].x, obstacles[i].y, obstacles[i].w, obstacles[i].h)
  end
  
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end

table.insert(obstacles, {x = 200, y = 300, w = 100, h = 100})
table.insert(obstacles, {x = 50, y = 150, w = 50, h = 50})

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

function collisions(a,b)
  for i in pairs(obstacles) do
    if a.x + a.w > b[i].x and a.x < b[i].x + b[i].w and a.y + a.h > b[i].y and a.y < b[i].y + b[i].h then
      return true
    end
  end
end
