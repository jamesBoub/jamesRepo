player = {x = 0, y = 0, w = 20, h = 20}
obstacles = {}

function obstacleGenerate()
  table.insert(obstacles, {x = 50,y = 100,w = 200,h = 100})
  table.insert(obstacles, {x = 300,y = 200,w = 240,h = 235})
end

obstacleGenerate()


function love.update()
end

function love.draw()

for i in pairs(obstacles) do
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill", obstacles[i].x, obstacles[i].y, obstacles[i].w, obstacles[i].h)
    
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
    

    playerInput()
--          collisions()

  end
end

function playerInput()
  if love.keyboard.isDown("w") then
      player.y = player.y - 5
      collisions("up")
    elseif love.keyboard.isDown("a") then
      player.x = player.x - 5
      collisions("left")
    elseif love.keyboard.isDown("s") then
      player.y = player.y + 5
      collisions("down")
    elseif love.keyboard.isDown("d") then
      player.x = player.x + 5
      collisions("right")
  end
end

function collisions(direction)
    for i in pairs(obstacles) do
    if player.x + player.w > obstacles[i].x and player.x < obstacles[i].x + obstacles[i].w and player.y + player.h > obstacles[i].y and player.y < obstacles[i].y + obstacles[i].h then
      if direction == "up" then
          player.y = obstacles[i].y + obstacles[i].h
      elseif direction == "down" then
        player.y = obstacles[i].y - player.h
      elseif direction == "left" then
        player.x = obstacles[i].x + obstacles[i].w
      elseif direction == "right" then
        player.x = obstacles[i].x - player.w
        end
    end
  end
end




