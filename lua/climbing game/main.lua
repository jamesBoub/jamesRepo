function love.load()
  player = {x = 0, y = 150, width = 12, height = 12, moveSpeed = 5, moveDir = nil, color = {1,1,1}}
  obstacles = {}
  obstacle_create()
  print(obstacles[1])
end

function love.draw()
  game_render()
  player_input()
  --obstacle_player_collision_check() 
--  obstacle_move()
  
    if player.moveDir ~= nil then
    love.graphics.print(player.moveDir, 0,0)
  else
    love.graphics.print('nil', 0,0)
    end
end

function game_render()
  obstacles_render()
  player_render()
end

function player_render()
  love.graphics.setColor(player.color[1], player.color[2], player.color[3])
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height) -- player draw
end

function obstacles_render()
  for i = 1,#obstacles do
    love.graphics.setColor(obstacles[i].color[1],obstacles[i].color[2],obstacles[i].color[3])
    love.graphics.rectangle("fill", obstacles[i].x, obstacles[i].y, obstacles[i].width, obstacles[i].height)
  end
end
--x1,x2,y1,y2,xw1,xw2,xh1,xh2
function player_input()
  if love.keyboard.isDown("w") then
        player.moveDir = 'down'

    player.y = player.y - player.moveSpeed
    for i in pairs(obstacles) do
        rectangle_collisions(player, obstacles[i])
    end
  end
if love.keyboard.isDown("a") then
      player.moveDir = 'left'

    player.x = player.x - player.moveSpeed
        for i in pairs(obstacles) do
        rectangle_collisions(player, obstacles[i])
    end

  end
if love.keyboard.isDown("s") then
      player.moveDir = 'up'

    player.y = player.y + player.moveSpeed
        for i in pairs(obstacles) do
        rectangle_collisions(player, obstacles[i])
    end

  end
if love.keyboard.isDown("d") then
      player.moveDir = 'right'

      player.x = player.x + player.moveSpeed

    for i in pairs(obstacles) do
        rectangle_collisions(player, obstacles[i])
    end
  end
  
  
--  if love.keyboard.isDown("w") then
--    obstacle_player_collision_check()
--    player.moveDir = 'down'
  
--elseif love.keyboard.isDown("a") then
--    obstacle_player_collision_check()
--    player.moveDir = 'left'
  
--elseif love.keyboard.isDown("s") then
--    obstacle_player_collision_check()
--    player.moveDir = 'up'
  
--elseif love.keyboard.isDown("d") then
--    obstacle_player_collision_check()
--    player.moveDir = 'right'
--  else
--    player.moveDir = nil
--  end
end
  
  
if love.keyboard.isDown("up") then
  player.width = player.width + .1
  player.height = player.height + .1
elseif love.keyboard.isDown("down") then
  player.width = player.width - .1
  player.height = player.height - .1
end

--function obstacle_player_collision_check()
--  for i in pairs(obstacles) do
--    if player.x + player.width > obstacles[i].x and player.x < obstacles[i].x + obstacles[i].width and player.y + player.height > obstacles[i].y and player.y < obstacles[i].y + obstacles[i].height then
--     if player.moveDir == 'right' then
--       player.x = obstacles[i].x - player.width
--     elseif player.moveDir == 'down' then
--       player.y = obstacles[i].y + obstacles[i].height
--     elseif player.moveDir == 'left' then
--       player.x = obstacles[i].x + obstacles[i].width
--     elseif player.moveDir == 'up' then
--       player.y = obstacles[i].y - player.height
--      end
--    end
--  end
--end

function rectangle_collisions(a,b)
    if player.x + player.width > b.x and player.x < b.x + b.width and player.y + player.height > b.y and player.y < b.y + b.height then
     if player.moveDir == 'right' then
       a.x = b.x - a.width
     elseif player.moveDir == 'down' then
       a.y = b.y + b.height
     elseif player.moveDir == 'left' then
       a.x = b.x + b.width
     elseif player.moveDir == 'up' then
       a.y = b.y - a.height
    end
  end
end

function obstacle_move()
  if obstacles[1].y > 0 then
    obstacles[1].y = obstacles[1].y - 1
  else
    obstacles[1].y = 300
  end
end

function obstacle_create()
 -- table.insert(obstacles, {x = 20, y = 100, width = 100, height = 50, color = {1,0,0}})
 -- table.insert(obstacles, {x = 20, y = 169, width = 100, height = 50, color = {1,0,0}})
  table.insert(obstacles, {x = 50, y = 300, width = 100, height = 25, color = {1,0,0}})
  table.insert(obstacles, {x = 150, y = 450, width = 100, height = 25, color = {1,0,0}})
end
