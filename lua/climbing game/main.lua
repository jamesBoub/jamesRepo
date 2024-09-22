player = {x = 0, y = 0, w = 20, h = 20, dir = "down"}
obstacles = {}

function obstacleGenerate()
  table.insert(obstacles, {x = 50,y = 100,w = 200,h = 100})
  table.insert(obstacles, {x = 300,y = 200,w = 240,h = 235})
  table.insert(obstacles, {x = 250,y = 300,w = 10,h = 100, dir = "left"})
  table.insert(obstacles, {x = 20,y = 410,w = 10,h = 100, dir = "right"})
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
    collisions(player,obstacles,player.direction)
    
  end
  
   if obstacles[3].x > 20 then obstacles[3].x = obstacles[3].x - 1 else obstacles[3].x = 250 end
   if obstacles[4].x < 250 then obstacles[4].x = obstacles[4].x + 1 else obstacles[4].x = 20 end
   
end

function playerInput()
  if love.keyboard.isDown("w") then
      player.y = player.y - 1
    elseif love.keyboard.isDown("a") then
      player.x = player.x - 1
    elseif love.keyboard.isDown("s") then
      player.y = player.y + 1
    elseif love.keyboard.isDown("d") then
      player.x = player.x + 1
  end
end

function collisions(a,b,aDir,bDir, input)
    -- a is moved by b
    for i in pairs(obstacles) do
    if a.x + a.w > b[i].x and a.x < b[i].x + b[i].w and a.y + a.h > b[i].y and a.y < b[i].y + b[i].h  then
      
      -- top collide
      if a.y + a.h > b[i].y and  not (a.y + a.h > b[i].y + b[i].h) and not (a.y + a.h - 5 > b[i].y ) then
          a.y = b[i].y - a.h
        end
      
      if a.y < b[i].y + b[i].h and not (a.y < b[i].y) and not (a.y + a.h < b[i].y) and not (a.y + 5 < b[i].y + b[i].h) then
          a.y = b[i].y + b[i].h
        end
      
    end
  end
end

