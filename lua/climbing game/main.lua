player = {x = 50, y = 100, w = 10, h = 10, v = 2}
obstacles = {}

function love.draw()
  input()
  
  if collisions(player,obstacles) then
    resolveCollision(player, obstacles)
  end
  
    love.graphics.print(player.x .. " " .. player.y)
    love.graphics.setColor(1,0,0)
  
  for i in pairs(obstacles) do 
    love.graphics.rectangle('fill', obstacles[i].x, obstacles[i].y, obstacles[i].w, obstacles[i].h)
  end
  
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end

table.insert(obstacles, {x = 50, y = 150, w = 50, h = 50})
table.insert(obstacles, {x = 110, y = 150, w = 50, h = 50})

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
      return true, b[i]
    end
  end
end

function resolveCollision(player, obstacles)
    for i in pairs(obstacles) do
      
      if player.x + player.w > obstacles[i].x and player.x < obstacles[i].x + obstacles[i].w and player.y + player.h > obstacles[i].y and player.y < obstacles[i].y + obstacles[i].h then
      
        local t = obstacles[i]
        
           
          local overlapX = (player.x + player.w) - t.x -- left collision check
          local overlapX2 = (t.x + t.w) - player.x -- right collision check
          
          local overlapY = (player.y + player.h) - t.y -- up collision check
          local overlapY2 = (t.y + t.h) - player.y -- down collision check
          
            
            -- take left and right overlap values, setting the local variable to the smallest of the two values.
            -- the smaller value represents the side collided with. This process is repeated for the y axis.
            
          local FinalxOverlap = math.min(overlapX, overlapX2)
          local FinalyOverlap = math.min(overlapY, overlapY2) 
            
--            print(FinalxOverlap .. " " .. FinalyOverlap)
            
            if FinalxOverlap < FinalyOverlap then
                if overlapX < overlapX2 then
                    player.x = player.x - FinalxOverlap  
                else
                    player.x = player.x + overlapX2  
                end
            else
                if overlapY < overlapY2 then
                    player.y = player.y - FinalyOverlap  
                else
                    player.y = player.y + overlapY2  
                end
              end
        end
    end
end
