game = {projectileSpeed = 2}
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

function tank_render()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", tank.x, tank.y, 50, 20, 10) -- draw hull
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", tank.x + tank.hullWidth / 2 - 12, tank.y - 15, 25, 25, 20) -- draw turret
  
  love.graphics.setColor(1,0,0)
  tank.turretX = tank.x + tank.hullWidth / 2 
  tank.turretY = tank.y - 5

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
      projectiles[i].gravity = projectiles[i].gravity + 0.009
  end
end

function love.draw()
  tank_render()
  love.graphics.print(tank.turretAngle, 0,0)
  if love.keyboard.isDown("d") and tank.turretAngle < 0.2 then
      tank.turretAngle = tank.turretAngle + .1
  elseif love.keyboard.isDown("a") and tank.turretAngle > -3.3 then
    tank.turretAngle = tank.turretAngle - .1
  end
  love.graphics.setColor(0,0,1)
  projectile_move()
  for i in pairs(projectiles) do
      love.graphics.rectangle("fill", projectiles[i].x, projectiles[i].y, 6,6)
    end
end