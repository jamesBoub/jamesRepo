player = {x = 20, y = 120, w = 10, h = 10}
obstacles = {}

table.insert(obstacles, {x = 100, y = 200, w = 100, h = 100})

function love.draw()
  obstacle_render()
  player_render()
end

function love.update()
  player_input()
  
  for i in pairs(obstacles) do
  if collision_detect(player, obstacles[i]) then
    resolve_collision(player, obstacles[i])
  end
end
end

function player_input()
  if love.keyboard.isDown("w") then
    player.y = player.y - 5
  end
  if love.keyboard.isDown("a") then
    player.x = player.x - 5
  end
  if love.keyboard.isDown("s") then
    player.y = player.y + 5
  end
  if love.keyboard.isDown("d") then
    player.x = player.x + 5
  end
end

function player_render()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end

function obstacle_render()
  love.graphics.setColor(1,0,0)
    for i in pairs(obstacles) do
    love.graphics.rectangle('fill', obstacles[i].x, obstacles[i].y, obstacles[i].w, obstacles[i].h)
  end
end

function collision_detect(a,b)
  if a.x + a.w >= b.x and a.x <= b.x + b.w and a.y + a.h >= b.y and a.y <= b.y + b.h then
    return true
  end
end

function resolve_collision(a,b)
  local xOverlap_l
  local xOverlap_r
  
  xOverlap_l = a.x + a.w - b.x
  xOverlap_r = b.x + b.w - a.x
  
  local yOverlap_u
  local yOverlap_d
  
  yOverlap_u = a.y + a.w - b.y
  yOverlap_d = b.y + b.w - a.y
  
  local xOverlapFinal = math.min(xOverlap_l,xOverlap_r)
  local yOverlapFinal = math.min(yOverlap_d,yOverlap_u)
  
  print(xOverlapFinal .. " " .. yOverlapFinal)
  
  if xOverlapFinal < yOverlapFinal then
    if xOverlap_l <= xOverlap_r then
      player.x = player.x - xOverlapFinal
    else
      player.x = player.x + xOverlapFinal
    end
  else
    if yOverlap_d <= yOverlap_u then
      player.y = player.y + yOverlapFinal
    else
      player.y = player.y - yOverlapFinal
    end
  end
end

