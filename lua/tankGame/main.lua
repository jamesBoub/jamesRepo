offsetX = 0
offsetY = 0
game = {projectileSpeed = 15, aimSpeed = .08, gravity = 0.1, groundWidth = 50}
tank = {
  x = 200,
  y = 500,
  hullWidth = 50,
  hullHeight = 20,
  
  turretX = nil,
  turretY = nil,
  turretAngle = 0
}

projectiles = {}
ground = {}

function tank_render()
  love.graphics.push()
    
    tank.turretX = tank.x + tank.hullWidth / 2 
    tank.turretY = tank.y - 5
    
    love.graphics.translate(offsetX, offsetY)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", tank.x, tank.y, 50, 20, 10) -- draw hull
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", tank.x + tank.hullWidth / 2 - 12, tank.y - 15, 25, 25, 20) -- draw turret
  love.graphics.pop()


        love.graphics.push()
        love.graphics.translate(tank.turretX, tank.turretY - 1.5)
        love.graphics.rotate(tank.turretAngle)
        love.graphics.translate(-tank.turretX, -tank.turretY - 1.5)
        love.graphics.rectangle("fill", tank.turretX, tank.turretY, 20, 3 ) -- draw barrel
      love.graphics.pop()
end
function love.keyreleased(key)
  if key == "space" then
    projectile_create()
  end
end

function projectile_create()
    table.insert(projectiles, {x = (tank.turretX + math.cos(tank.turretAngle)*20) - 3, y = (tank.turretY - math.sin(tank.turretAngle)*-20) - 4, anglex = math.cos(tank.turretAngle)*game.projectileSpeed, angley = math.sin(tank.turretAngle)*game.projectileSpeed, gravity = 0})
end

function projectile_move()
  for i in pairs(projectiles) do
      projectiles[i].x = projectiles[i].x + projectiles[i].anglex 
      projectiles[i].y = projectiles[i].y - projectiles[i].angley * -1
      
      projectiles[i].y = projectiles[i].y + projectiles[i].gravity
      projectiles[i].gravity = projectiles[i].gravity + game.gravity
  end
end

function player_input()
if love.keyboard.isDown("d") and tank.turretAngle < 0.2 then
      tank.turretAngle = tank.turretAngle + game.aimSpeed
  elseif love.keyboard.isDown("a") and tank.turretAngle > -3.3 then
    tank.turretAngle = tank.turretAngle - game.aimSpeed
  elseif love.keyboard.isDown("up") then
    offsetX = offsetX + 0.2
  elseif love.keyboard.isDown("w") then
    tank.x = tank.x + 0.5
  elseif love.keyboard.isDown("s") then
    tank.x = tank.x - 0.5
  elseif love.keyboard.isDown("e") then
    camera_reset()
  end
end

function ground_generate()
  xOff = 0
  for x = 1,120 do
    if x % 2 == 0 then
      table.insert(ground, {x = xOff, y = 520, color = {0,1,0}})
    elseif x % 2 == 1 then
      table.insert(ground, {x = xOff, y = 520, color = {0,.5,0}})
    end
    xOff = xOff + game.groundWidth
  end
  
end

function projectile_render()
        love.graphics.setColor(1,1,1)

  for i in pairs(projectiles) do
      love.graphics.rectangle("fill", projectiles[i].x, projectiles[i].y, 6,6)
    end
end

function ground_render()
--  love.graphics.rectangle("fill", 0,520, 2500, 100)
  for i in pairs(ground) do
      love.graphics.setColor(ground[i].color[1],ground[i].color[2],ground[i].color[3])
      love.graphics.rectangle("fill", ground[i].x, ground[i].y, game.groundWidth, 100)
    end
end

function game_render()
  tank_render()
  ground_render()
  projectile_move()
end

function love.draw()
    player_input()
  if #projectiles > 0 then
    love.graphics.push()
    
    love.graphics.translate(projectiles[#projectiles].x * -1 + tank.turretX, 0)
        game_render()
        love.graphics.pop()
        love.graphics.print(projectiles[#projectiles].x .. " " .. projectiles[#projectiles].y, 0, 50)
          
          
          love.graphics.push()
          love.graphics.translate(projectiles[#projectiles].x * -1 + tank.turretX, 0)
            projectile_render()
          love.graphics.pop()
  else
    game_render()
  end
  love.graphics.print(tank.turretAngle, 0,0)
  
  love.graphics.setColor(0,0,1)
  
end
ground_generate()
