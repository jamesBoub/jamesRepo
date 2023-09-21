player = {x = 0, y = 500, xspeed = 0, yspeed = 0, angle = 0, player_speed = .1, angle_line_length = 500, turn_speed = .05, bulletOffset = 12}
projectileSpeed = 2 
blocks = {}
projectiles = {}
bounce = "none"
xoff = 1
yoff = 1
--table.insert(blocks, {x = 50, y = 100})
--table.insert(blocks, {x = 100, y = 200})
--table.insert(blocks, {x = 150, y = 150})
for y = 1,15 do
    yoff = yoff + 21
    xoff = 0
for x = 1,40 do
  table.insert(blocks, {x = xoff, y = yoff} )
  xoff = xoff + 21
  
  end
end

function love.draw()
  mousex, mousey = love.mouse.getPosition()
--  print(#blocks)
  love.graphics.setColor(1,0,0)
  --love.graphics.line(player.x, player.y, mousex, mousey)
  love.graphics.line(player.x, player.y, player.x + math.cos(player.angle)*player.angle_line_length, player.y - math.sin(player.angle)*player.angle_line_length)
  
  if #projectiles > 0 then
      love.graphics.print(projectiles[#projectiles].oldAngle .. " anglex: " .. projectiles[#projectiles].anglex .. " angley: " .. projectiles[#projectiles].angley, 0,0)
      love.graphics.print(projectiles[#projectiles].switch .. " " .. bounce, 0,50)
    end



  for i in pairs(blocks) do
   
      love.graphics.setColor(1,1,1)
      love.graphics.rectangle("fill", blocks[i].x, blocks[i].y, 20,20)
    
  end
  
  function projectile_bounce(xv, yv, indexOfProj, indexOfCollidedBlock, lastDirection, lastCollided)

projectile = projectiles[indexOfProj]
collidedBlock = blocks[indexOfCollidedBlock]
currentCollided = indexOfCollidedBlock

if projectile.x + 6 > collidedBlock.x and not(projectile.x > collidedBlock.x + 2) and not (projectile.y + 6 > collidedBlock.y + 20) and not (projectile.y < collidedBlock.y) then
  projectile.x = projectile.x - 1
  projectile.anglex = projectile.anglex * -1
elseif projectile.x < collidedBlock.x + 20 and not(projectile.x < collidedBlock.x + 17) and not (projectile.y + 6 > collidedBlock.y + 20) and not (projectile.y < collidedBlock.y)  then
  projectile.x = projectile.x + 1
  projectile.anglex = projectile.anglex * -1
elseif projectile.y < collidedBlock.y + 20 and not(projectile.y < collidedBlock.y + 17) and projectile.angley > 0 then
  projectile.y = projectile.y + 1
  projectile.angley = projectile.angley * -1
  print("bottom")
elseif projectile.y + 6 > collidedBlock.y and not(projectile.y > collidedBlock.y + 2) and projectile.angley < 0 then
  projectile.y = projectile.y - 1
  projectile.angley = projectile.angley * -1
  print("top")
  end
--    table.remove(blocks, indexOfCollidedBlock)
    print("d")
  end
  
  for i in pairs(projectiles) do
    for u in pairs(blocks) do
      if collision_evaluate(projectiles[i].x, projectiles[i].y, blocks[u].x, blocks[u].y, 6, 20 )then
          projectile_bounce(projectiles[i].anglex, projectiles[i].angley, i, u)
          break

      end
     end 
  end
  
  
  for i in pairs(projectiles) do
    
  
 if projectiles[i].x < 0 or projectiles[i].x > 800 then
        projectiles[i].anglex = projectiles[i].anglex * -1
        if projectiles[i].x > 800 then
            projectiles[i].xspeed = -1
            --projectiles[i].angley = projectiles[i].angley * 1
          end
          
          if projectiles[i].x < 0 then
             projectiles[i].xspeed = 1
            --projectiles[i].angley = projectiles[i].angley * 1
          end
   end
   
  if projectiles[i].y < 0 or projectiles[i].y > 600 then
      projectiles[i].angley = projectiles[i].angley * -1
      if projectiles[i].y < 0 then
          projectiles[i].yspeed = 1
        end
      if projectiles[i].y > 600 then
          projectiles[i].yspeed = -1
        end
    end
  
  
    
end
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", player.x, player.y, 6, 6)
  --love.graphics.print(switch, 0, 100)
  
  for i in pairs(projectiles) do
    if #projectiles > 0 then
      love.graphics.setColor(projectiles[i].color)
      love.graphics.rectangle("fill", projectiles[i].x, projectiles[i].y, 6, 6)
      projectiles[i].x = projectiles[i].x + projectiles[i].anglex 
      projectiles[i].y = projectiles[i].y - projectiles[i].angley
      
      projectiles[i].x = projectiles[i].x + projectiles[i].xspeed
      projectiles[i].y = projectiles[i].y + projectiles[i].yspeed
      end
  end

  if love.keyboard.isDown("w") then
    player.xspeed = player.xspeed + math.cos(player.angle)*player.player_speed
    player.yspeed = player.yspeed - math.sin(player.angle)*player.player_speed
  end
  
  if love.keyboard.isDown("d") then
    player.angle = player.angle - player.turn_speed
  end
  
  if love.keyboard.isDown("a") then
    player.angle = player.angle + player.turn_speed
  end
  
  if love.keyboard.isDown("s") then
    player.xspeed = player.xspeed - math.cos(player.angle)*player.player_speed
    player.yspeed = player.yspeed + math.sin(player.angle)*player.player_speed
  end
  
  if love.keyboard.isDown("lctrl") then
    player.xspeed = 0
    player.yspeed = 0
  end
  
  if love.keyboard.isDown("e") then
    for i in pairs(projectiles) do
        table.remove(projectiles, i)
        switch = 0
      end
    end
  
  if love.keyboard.isDown("f") then
    for i in pairs(projectiles) do
        projectiles[i].switch = 0
      end
    end
  
  function love.mousereleased(x, y, button)
   if button == 1 then
      table.insert(blocks, {x = mousex, y = mousey})
   end
end
  player.x = player.x + player.xspeed
  player.y = player.y + player.yspeed
end


function collision_evaluate(One_x, One_y, Two_x, Two_y, One_Length, Two_Length )
  for i in pairs(projectiles) do
     if One_x + One_Length > Two_x and One_y + One_Length > Two_y and One_y < Two_y + Two_Length and One_x < Two_x + Two_Length then
        --
        return true
          end
        end
    end

function love.keyreleased(key)
  if key == "space" then
      table.insert(projectiles, {x = player.x + math.cos(player.angle)*player.bulletOffset, y = player.y - math.sin(player.angle)*player.bulletOffset, xspeed = player.xspeed, yspeed = player.yspeed, anglex = math.cos(player.angle)*projectileSpeed, angley = math.sin(player.angle)*projectileSpeed, oldAngle = player.angle, switch = 0, color = {1,0,1}, collisionDirection = {""}, lastCollided = ""})
 for i in pairs(projectiles) do
  --print(projectiles[i].color[1])
  end
  elseif key == "up" then
      player.player_speed = player.player_speed - 1
  elseif key == "down" then
      player.player_speed = player.player_speed + 1
    end
end