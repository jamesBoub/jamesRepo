function love.load()
  player = {x = 0, y = 150, width = 20, height = 20, moveSpeed = 1, moveDir = nil, color = {1,1,1}}
  obstacles = {}
  
  obstacle_create()
  print(obstacles[1])
end

function love.draw()
  game_render()
  player_input()
  
   obstacle_player_collision_check() 
    

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

function player_input()
  if love.keyboard.isDown("w") then
    obstacle_player_collision_check('down')
    player.y = player.y - 1
    player.moveDir = 'down'
  end
if love.keyboard.isDown("a") then
    obstacle_player_collision_check('left')
    player.x = player.x - 1
    player.moveDir = 'left'
  end
if love.keyboard.isDown("s") then
    obstacle_player_collision_check('up')
    player.y = player.y + 1
    player.moveDir = 'up'
  end
if love.keyboard.isDown("d") then
    obstacle_player_collision_check('right')
    player.x = player.x + 1
    player.moveDir = 'right'
  end
end

function obstacle_player_collision_check(direction)
  for i = 1,#obstacles do
    if player.x + player.width > obstacles[i].x and player.x < obstacles[i].x + obstacles[i].width and player.y + player.height > obstacles[i].y and player.y < obstacles[i].y + obstacles[i].height then
     for i in pairs(obstacles) do
     if player.moveDir == 'right' then
       player.x = obstacles[i].x - player.width
     elseif player.moveDir == 'down' then
       player.y = obstacles[i].y + obstacles[i].height
     elseif player.moveDir == 'left' then
       player.x = obstacles[i].x + obstacles[i].width
     elseif player.moveDir == 'up' then
       player.y = obstacles[i].y - player.height
       end
      end
     
      
      
    end
  end
end


function obstacle_create()
  table.insert(obstacles, {x = 20, y = 100, width = 100, height = 50, color = {1,0,0}})
end