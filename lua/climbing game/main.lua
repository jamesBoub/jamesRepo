world = {termVel = 10}
player = {x = 50, y = 100, w = 10, h = 10, v = 2, collision = false, yVel = 1, jumping = false}
obstacles = {}
falling = true

function love.draw()
  
  input()
  playerGravity()
  
  obstacleMovement()
  player.collision = false
  
  if falling then
  love.graphics.print("falling", 0,50)
  else
  love.graphics.print("not", 0,50)
  end
  
  if collisions(player,obstacles) then
    resolveCollision(player, obstacles)
  else
    falling = true
  end
  
    love.graphics.print(player.x .. " " .. player.y)
    love.graphics.setColor(1,0,0)
  
  for i in pairs(obstacles) do 
    love.graphics.rectangle('fill', obstacles[i].x, obstacles[i].y, obstacles[i].w, obstacles[i].h)
  end
  
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
  
end

table.insert(obstacles, {x = 200, y = 150, w = 50, h = 50})
table.insert(obstacles, {x = 50, y = 150, w = 50, h = 50})
table.insert(obstacles, {x = 50, y = 100, w = 100, h = 5, vel = 2, returning = false, originX = 50})
table.insert(obstacles, {x = 100, y = 150, w = 100, h = 5})
function input()
  
  if love.keyboard.isDown("a") then
    player.x = player.x - player.v
  end
  
--  if player.jumping == false then
--    if love.keyboard.isDown("s") then
--      player.y = player.y + player.v
--    end
--    if love.keyboard.isDown("w") then
--      player.y = player.y - player.v
--    end
--  end
  
  if love.keyboard.isDown("d") then
    player.x = player.x + player.v
  end
end

function love.keyreleased(key)
  if key == 'space' then
    playerJump()
  end
end

function playerGravity()
  if falling or player.jumping then
    player.y = player.y + player.yVel
  end
  

  if player.yVel <= world.termVel then 
    player.yVel = player.yVel + 0.4^2
    
  end
end

function obstacleMovement()
  if obstacles[3].x < 200 and obstacles[3].returning == false  then
    obstacles[3].x = obstacles[3].x + obstacles[3].vel
  elseif  obstacles[3].x >= 200 or obstacles[3].returning then 
    obstacles[3].returning = true
    obstacles[3].x = obstacles[3].x - obstacles[3].vel
    if obstacles[3].x <= obstacles[3].originX then
      obstacles[3].returning = false
    end
  end
  
end


function collisions(a,b)
  for i in pairs(obstacles) do
    if a.x + a.w >= b[i].x and a.x <= b[i].x + b[i].w and a.y + a.h >= b[i].y and a.y <= b[i].y + b[i].h then
      return true, b[i]
    end
  end
end

function playerJump()
  if player.jumping == false and falling == false then
    player.yVel = -5
    player.jumping = true
  end
  
  if player.jumping then
   
    
  end
end

function resolveCollision(player, obstacles)
    for i in pairs(obstacles) do
      
      if player.x + player.w >= obstacles[i].x and player.x <= obstacles[i].x + obstacles[i].w and player.y + player.h >= obstacles[i].y and player.y <= obstacles[i].y + obstacles[i].h then
      
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
                    -- hit right
                    player.x = player.x - FinalxOverlap
                else
                    -- hit left
                    player.x = player.x + overlapX2  
                end
            else
                if overlapY < overlapY2 then
                    -- hit top
                    player.y = player.y - FinalyOverlap  
                    player.collision = true
                    player.jumping = false
                    falling = false
                    player.yVel = 0
                    
                    if obstacles[i].vel ~= nil then
                      player.x = player.x + obstacles[i].vel
                    end
                else
                    -- hit bottom
                    player.y = player.y + overlapY2  
                    player.yVel = player.yVel * -1
                end
            end
        end
    end
end
