offsetX = 0
offsetY = 0
timer = 1
game = {projectileSpeed = 0, aimSpeed = .08, gravity = 0.1, groundWidth = 50, playerMoveSpeed = 3, projectileFollow = false}
tank = {
  x = 200,
  y = 500,
  hullWidth = 50,
  hullHeight = 20,
  
  turretX = 0,
  turretY = 0,
  turretAngle = 0
}

projectiles = {}
projectileTrails = {}
ground = {}

function tank_render()
    
    
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", tank.x, tank.y, 50, 20, 10) -- draw hull
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", tank.x + tank.hullWidth / 2 - 12, tank.y - 15, 25, 25, 20) -- draw turret

    tank.turretX = tank.x + tank.hullWidth / 2 
    tank.turretY = tank.y - 5

        love.graphics.translate(tank.turretX, tank.turretY - 1.5)
        love.graphics.rotate(tank.turretAngle)
        love.graphics.translate(-tank.turretX, -tank.turretY - 1.5)
        love.graphics.rectangle("fill", tank.turretX, tank.turretY, 20, 3 ) -- draw barrel
end
function love.keyreleased(key)
  if key == "space" then
    __x = (tank.turretX + math.cos(tank.turretAngle)*20) - 3
    __y = (tank.turretY - math.sin(tank.turretAngle)*-20) - 4
    __anglex = math.cos(tank.turretAngle)*game.projectileSpeed
    __angley = math.sin(tank.turretAngle)*game.projectileSpeed
    __gravity = 0
    
    
    
    projectile_create(__x, __y, __anglex, __angley, __gravity)
  elseif key == "e" then
    if game.projectileFollow then
        game.projectileFollow = false
      else
        game.projectileFollow = true
      end
  end
end

gaugeX = 40
gaugeY = 540
gaugeWidth = 200
gaugeHeight = 50

function power_gauge()
  love.graphics.rectangle("fill", gaugeX, gaugeY, gaugeWidth, gaugeHeight, _gravity)
end

function projectile_create(_x, _y, _anglex, _angley, _gravity)
    table.insert(projectiles, {x = _x, y = _y, anglex = _anglex, angley = _angley, gravity = _gravity, moving = true})
end

function projectile_move()
  for i in pairs(projectiles) do
    if projectiles[i].moving then
        projectiles[i].x = projectiles[i].x + projectiles[i].anglex 
        projectiles[i].y = projectiles[i].y - projectiles[i].angley * -1
        
        projectiles[i].y = projectiles[i].y + projectiles[i].gravity
        projectiles[i].gravity = projectiles[i].gravity + game.gravity
      end
  end
end

function player_input()
if love.keyboard.isDown("space") and game.projectileSpeed < 65 then
  gaugeWidth = gaugeWidth + 5
  game.projectileSpeed = game.projectileSpeed + 0.5
else
  gaugeWidth = 0
  game.projectileSpeed = 0
end
if love.keyboard.isDown("d") and tank.turretAngle < 0.2 then
      tank.turretAngle = tank.turretAngle + game.aimSpeed
  elseif love.keyboard.isDown("a") and tank.turretAngle > -3.3 then
    tank.turretAngle = tank.turretAngle - game.aimSpeed
  elseif love.keyboard.isDown("up") then
    offsetX = offsetX + 0.2
  end
  
  if love.keyboard.isDown("w") then
    tank.x = tank.x + game.playerMoveSpeed
    tank.turretX = tank.x + tank.hullWidth / 2 
    tank.turretY = tank.y - 5
  elseif love.keyboard.isDown("s") then
    tank.x = tank.x - game.playerMoveSpeed
    tank.turretX = tank.x + tank.hullWidth / 2 
    tank.turretY = tank.y - 5
  end
end

function ground_generate()
  xOff = 0
  for x = 1,212000 do
    if x % 2 == 0 then
      table.insert(ground, {x = xOff, y = 520, color = {0,1,0}})
    elseif x % 2 == 1 then
      table.insert(ground, {x = xOff, y = 520, color = {0,.5,0}})
    end
    xOff = xOff + game.groundWidth
  end
end

function projectile_render()
        love.graphics.setColor(1,1,0)
  for i in pairs(projectiles) do
      love.graphics.rectangle("fill", projectiles[i].x, projectiles[i].y, 6,6)
    end
end

function ground_render()
  for i in pairs(ground) do
          love.graphics.setColor(ground[i].color[1],ground[i].color[2],ground[i].color[3])
    if ground[i].x < tank.x + 700 and ground[i].x > tank.x or #projectiles > 0 and  ground[i].x < projectiles[#projectiles].x + 700 and ground[i].x > projectiles[#projectiles].x then
            love.graphics.rectangle("fill", ground[i].x, ground[i].y, game.groundWidth, 100)
    end
    end
end

--function game_render()
--  tank_render()
--  projectile_move()
--end

function projectile_camera_follow()
  
  glug = projectiles[#projectiles].x - tank.x
  
  love.graphics.push()
    love.graphics.translate(projectiles[#projectiles].x * -1 - 37, 0)
    ground_render()
    projectile_move()
    explosion_render()
  love.graphics.pop()
    
  love.graphics.push()
    love.graphics.translate(projectiles[#projectiles].x * -1 + tank.turretX, 0)
    love.graphics.translate(-tank.x + 240,0)
    projectile_render()
    projectileTrailDraw()
    tank_render()
  love.graphics.pop()
end

function projectile_camera_notFollow()
love.graphics.push()
    love.graphics.translate(tank.x * -1, 0)
    ground_render()
    projectile_move()
      explosion_render()
  love.graphics.pop()
      
  love.graphics.push()
    love.graphics.translate(-tank.x + 200,0)
    projectile_render()
    projectileTrailDraw()
    tank_render()
  love.graphics.pop()
end

function projectile_collisions()
  for i in pairs(projectiles) do
      if projectiles[i].y + 6 >= 520 then

if projectiles[i].anglex < .3 and projectiles[i].angley < 3 and projectiles[i].anglex > 0 or projectiles[i].anglex > -.3 and projectiles[i].angley > - .3 and projectiles[i].anglex < 0 and #projectiles > 0 then
--    table.remove(projectiles, i)
projectiles[i].moving = false

projectiles[i].y = 513
print('ass')

    game.projectileSpeed = 12

    __x = (tank.turretX + math.cos(tank.turretAngle)*20) - 3
    __y = (tank.turretY - math.sin(tank.turretAngle)*-20) - 4
    __anglex = math.cos(tank.turretAngle)*game.projectileSpeed
    __angley = math.sin(tank.turretAngle)*game.projectileSpeed
    __gravity = 0
    
    
    
    projectile_create(__x, __y, __anglex, __angley, __gravity)




else
projectiles[i].y = 514
projectiles[i].gravity = 0 
projectiles[i].anglex = projectiles[i].anglex * .7
projectiles[i].angley = projectiles[i].angley * .7
end

--projectiles[i].anglex = projectiles[i].anglex * 1
        end
    end
end

function projectileTrailDraw()
  timer = timer - 11
  if timer <= 0 then
    for i in pairs(projectiles) do
          timer = 1
--          table.insert(projectileTrails, {x = projectiles[i].x, y = projectiles[i].y})
    end
  end
  
  for u in pairs(projectileTrails) do
      love.graphics.rectangle("fill", projectileTrails[u].x, projectileTrails[u].y, 5,5)
    end
end

function explosion_render()
--  for i in pairs(effects[1]) do
--      love.event.quit()
--    end
end

effects = {}

function fuse_activate(_x, _y)
  table.insert(effects, {      
    explosion = {x = _x, y = _y}
  
                        })

--love.event.quit()
  
end
function love.draw()
  love.graphics.setColor(1,1,1)
  for i in pairs(projectiles) do
    if #projectiles > 0 then
      love.graphics.print(projectiles[#projectiles].anglex, 0, 50)
      love.graphics.print(projectiles[#projectiles].angley, 0, 70)
    else
      love.graphics.print("...", 0, 50)
      love.graphics.print("...", 0, 70)
    end
  end
    player_input()
    projectile_collisions()
  if #projectiles > 0 and game.projectileFollow then
    projectile_camera_follow()
else
    projectile_camera_notFollow()
  end
      power_gauge()
      love.graphics.setColor(0,0,1)
--      love.graphics.print(tank.x .. " " .. tank.turretX, 0, 50)

  
end
ground_generate()
