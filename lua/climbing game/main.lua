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
      player.y = player.y - 2
      collisions(player,obstacles,"up")
      player.dir = "up"
    elseif love.keyboard.isDown("a") then
      player.x = player.x - 2
      collisions(player,obstacles,"left")
      player.dir = "left"
    elseif love.keyboard.isDown("s") then
      player.y = player.y + 2
      collisions(player,obstacles,"down")
      player.dir = "down"
    elseif love.keyboard.isDown("d") then
      player.x = player.x + 2
      collisions(player,obstacles,"right")
      player.dir = "right"
  end
end

function collisions(a,b,aDir,bDir)
    -- a is moved by b
    for i in pairs(obstacles) do
    if a.x + a.w > b[i].x and a.x < b[i].x + b[i].w and a.y + a.h > b[i].y and a.y < b[i].y + b[i].h then
      
      if b[i].dir ~= nil then
        if b[i].dir == "up" then
          a.y = a.y - 1
        elseif b[i].dir == "down" then
          a.y = a.y + 1
        elseif b[i].dir == "left" then
          a.x = a.x - 1
        elseif b[i].dir == "right" then
          a.x = a.x + 1
        end
      else
        if a.dir == "up" then
          a.y = a.y + 1
        elseif a.dir == "down" then
          a.y = a.y - 1
        elseif a.dir == "left" then
          a.x = a.x + 1
        elseif a.dir == "right" then
          a.x = a.x - 1
        end
      end
      
--      a.x = a.x - 1
    end
  end
end

