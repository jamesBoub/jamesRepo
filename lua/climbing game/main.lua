world = {termVel = 10}
player = {x = 100, y = 0, w = 10, h = 10, v = 2, collision = false, yVel = 0, xVel = 0, jumping = false, relVelx = nil, obstacleX = 0, relVely = nil, wallJump = false}
obstacles = {}
falling = true
bub = 0.4^1.5

function love.draw()
  if player.xVel < 0.1 and player.xVel > 0 then
  player.xVel = 0
elseif player.xVel > -0.1 and player.xVel < 0 then
  player.xVel = 0
  end
  
--    player.x = player.x + player.xVel
  player.x = player.x + player.xVel + player.obstacleX
  playerGravity()

  obstacleMovement()
  player.collision = false
  
  if falling then
  love.graphics.print("falling", 0,50)
  else
  love.graphics.print("not", 0,50)
  end

  if player.wallJump then
  love.graphics.print("walljump", 0,100)
  else
  love.graphics.print("not", 0,100)
  end


  
  if collisions(player,obstacles) then
   resolveCollision(player, obstacles)
  else
    falling = true
  end
    input()

    love.graphics.print(player.obstacleX)
    love.graphics.print(player.xVel, 0, 40)
    love.graphics.setColor(1,0,0)
    
    
    if player.relVelx ~= nil then
      player.x = player.x + player.relVelx
    end
    
    
  for i in pairs(obstacles) do 
    love.graphics.rectangle('fill', obstacles[i].x, obstacles[i].y, obstacles[i].w, obstacles[i].h)
  end
  
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end

table.insert(obstacles, {x = 200, y = 150, w = 50, h = 50})
table.insert(obstacles, {x = 50, y = 150, w = 50, h = 50})

table.insert(obstacles, {x = 100, y = 150, w = 100, h = 5})
table.insert(obstacles, {x = 000, y = 200, w = 500, h = 5})

function input()
  
  if player.collision then
  if love.keyboard.isDown("a") then
    
    if player.xVel >= -3 then
      if player.relVelx ~= nil then
      player.xVel = player.xVel - bub
    else
      player.xVel = player.xVel - bub
      end
  else
    player.xVel = -3
  end
  
  end
  if love.keyboard.isDown("d") then
    
    if player.xVel <= 3 then
      if player.relVelx ~= nil then
    player.xVel = player.xVel + bub
--    love.event.quit()
  else
    player.xVel = player.xVel + bub
    end
  else
    player.xVel = 3
    end
    end
end
if love.keyboard.isDown("lshift") then
    player.wallJump = true
  else
    player.wallJump = false
  end
end

function love.mousereleased(x,y,button)
  local mouseX, mouseY = love.mouse.getPosition()
  
  if button == 1 then
    table.insert(obstacles, {x = mouseX, y = mouseY, w = 100, h = 50, xVel = 1, yVel = nil, returning = false, originX = mouseX, travelLength = mouseX + 150, mover = true})
  elseif button == 2 then
    table.insert(obstacles, {x = mouseX, y = mouseY, w = 50, h = 50})
  end
  
  
end


function love.keyreleased(key)
  if key == 'space' then
      if player.jumping == false and falling == false then
      playerJump()
      end
  end
end

function playerGravity()
  if falling or player.jumping then
    player.y = player.y + player.yVel
  end

  if player.yVel <= world.termVel then 
    player.yVel = player.yVel + 0.4^2
  end
  
  if player.collision  then
    if player.xVel > 0 then
      player.xVel = player.xVel - 0.4^2.2
    elseif
      player.xVel < 0 then
      player.xVel = player.xVel + 0.4^2.2
    end
end

end

function obstacleMovement()
--  repetitiousMovement(obstacles[3])
  for i in pairs(obstacles) do
    if obstacles[i].mover then
      repetitiousMovement(obstacles[i])
    end
    end
  
  
end


function repetitiousMovement(object, direction)
  if object.x < object.travelLength and object.returning == false  then
   object.x = object.x + object.xVel
  elseif  object.x >= object.travelLength or object.returning then 
    if not object.returning then
      object.xVel = object.xVel * -1
      end
      object.returning = true
      object.x = object.x + object.xVel
    if object.x <= object.originX then
      if object.returning then
        object.xVel = object.xVel * -1
      end
      object.returning = false
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
    player.yVel = -5
    player.jumping = true
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
                    player.x = player.x - FinalxOverlap - 1
                    falling = true
                    
                    
                    if player.wallJump == false then
                      player.xVel = player.xVel * -1/8
                    else
                      player.xVel = player.xVel * -1
                      playerJump()
                    end
                    
                    if obstacles[i].xVel ~= nil then

                        player.xVel = player.xVel + obstacles[i].xVel - .5
                    else
    
                    end
                else
                    -- hit left
                    player.x = player.x + overlapX2 + 1
                    falling = true
                    
                    if player.wallJump == false then
                      player.xVel = player.xVel * -1/8
                    else
                      player.xVel = player.xVel * -1
                      playerJump()
                    end
                    
                    if obstacles[i].xVel ~= nil then

                        player.xVel = player.xVel + obstacles[i].xVel + .5
                    end
                    
                    
                    
                    
                    
                end
            else
                if overlapY < overlapY2 then
                    -- hit top
                    player.y = player.y - FinalyOverlap  
                    player.collision = true
                    player.jumping = false
                    falling = false
                    player.yVel = 0
                    
                    if obstacles[i].xVel ~= nil then
--                      player.obstacleX = obstacles[i].x * 2
--                      player.xVel = obstacles[i].xVel
player.obstacleX = obstacles[i].xVel
                  else
                    player.obstacleX = 0
                    end
                else
                  player.obstacleX = 0
                    -- hit bottom
                    player.y = player.y + overlapY2  
                    player.yVel = player.yVel * -1/8
                end
            end
        end
    end
end
