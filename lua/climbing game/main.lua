player = {x = 550, y = 500, w = 20, h = 20, speed = 1, dir = "down"}
obstacles = {}


function obstacleGenerate()
  table.insert(obstacles, {x = 50,y = 100,w = 200,h = 100, moveable = false})
  table.insert(obstacles, {x = 300,y = 200,w = 240,h = 235, moveable = false})
  table.insert(obstacles, {x = 250,y = 300,w = 10,h = 100, dir = "left", speed = 5, moveable = false})
  table.insert(obstacles, {x = 20,y = 410,w = 10,h = 100, dir = "right", speed = 1, moveable = false})
  table.insert(obstacles, {x = 550,y = 410,w = 40,h = 40, moveable = true})
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
    collisions(player,obstacles)
    
  end
  
   if obstacles[3].x > 20 then obstacles[3].x = obstacles[3].x - obstacles[3].speed else obstacles[3].x = 250 end
   if obstacles[4].x < 250 then obstacles[4].x = obstacles[4].x + obstacles[4].speed else obstacles[4].x = 20 end
   
end

function playerInput()
  if love.keyboard.isDown("w") then
      player.y = player.y - player.speed
    elseif love.keyboard.isDown("a") then
      player.x = player.x - player.speed
    elseif love.keyboard.isDown("s") then
      player.y = player.y + player.speed
    elseif love.keyboard.isDown("d") then
      player.x = player.x + player.speed
  end
end

function collisions(a,b)
    -- a is moved by b
    for i in pairs(obstacles) do

      if a.x + a.w > b[i].x and a.x < b[i].x + b[i].w and a.y + a.h > b[i].y and a.y < b[i].y + b[i].h then
        
        
        if b[i].moveable ~= true then
        
        
                              if b[i].dir ~= nil and b[i].speed ~= nil then
                                -- top collide
                                if a.y + a.h > b[i].y and  not (a.y + a.h > b[i].y + b[i].h) and not (a.y + a.h - b[i].speed > b[i].y ) then
                                  a.y = b[i].y - a.h
                                end
                                
                                if a.y < b[i].y + b[i].h and not (a.y < b[i].y) and not (a.y + a.h < b[i].y) and not (a.y + b[i].speed < b[i].y + b[i].h) then
                                  a.y = b[i].y + b[i].h
                                end
                                  
                                if a.x + a.w > b[i].x and not (a.x > b[i].x) and not (a.x + a.w - b[i].speed - 2 > b[i].x) then
                                  a.x = b[i].x - a.w
                                end
                                
                                if a.x < b[i].x + b[i].w and not (a.x + a.w < b[i].x + b[i].w) and not (a.x + b[i].speed + 2 < b[i].x + b[i].w) and not (a.x < b[i].x) then
                                  a.x = b[i].x + b[i].w          
                                end
                                
                              else
                                
                                  if a.y + a.h > b[i].y and  not (a.y + a.h > b[i].y + b[i].h) and not (a.y + a.h - player.speed > b[i].y ) then
                                    a.y = b[i].y - a.h
                                  end
                                  
                                  if a.y < b[i].y + b[i].h and not (a.y < b[i].y) and not (a.y + a.h < b[i].y) and not (a.y + player.speed < b[i].y + b[i].h) then
                                    a.y = b[i].y + b[i].h
                                  end
                                    
                                  if a.x + a.w > b[i].x and not (a.x > b[i].x) and not (a.x + a.w - player.speed - 2 > b[i].x) then
                                    a.x = b[i].x - a.w
                                  end
                                  
                                  if a.x < b[i].x + b[i].w and not (a.x + a.w < b[i].x + b[i].w) and not (a.x + player.speed + 2 < b[i].x + b[i].w) and not (a.x < b[i].x) then
                                    a.x = b[i].x + b[i].w          
                                  end
                                  
                                  end
                                  
                                  
                                  
      
    elseif b[i].moveable then
                      if a.y + a.h > b[i].y and  not (a.y + a.h > b[i].y + b[i].h) and not (a.y + a.h - player.speed > b[i].y ) then
                                    --a.y = b[i].y - a.h
                                    b[i].y = a.y - a.h + b[i].h
                                  end
                                  
                                  if a.y < b[i].y + b[i].h and not (a.y < b[i].y) and not (a.y + a.h < b[i].y) and not (a.y + player.speed < b[i].y + b[i].h) then
--                                    a.y = b[i].y + b[i].h
b[i].y = a.y - b[i].h
                                  end
                                    
                                  if a.x + a.w > b[i].x and not (a.x > b[i].x) and not (a.x + a.w - player.speed - 2 > b[i].x) then
                                    --a.x = b[i].x - a.w
                                    b[i].x = a.x + b[i].w - a.w
                                  end
                                  
                                  if a.x < b[i].x + b[i].w and not (a.x + a.w < b[i].x + b[i].w) and not (a.x + player.speed + 2 < b[i].x + b[i].w) and not (a.x < b[i].x) then
--                                    a.x = b[i].x + b[i].w
                                      b[i].x = a.x - b[i].w
                                  end
      end
    end
  end
end
