game = {bottomPipeBase = 500,
        topPipeBase = 100,
        score = 0,
        clearing = false,
        scrollSpeed = -4,
        gapDistance = -100,
        pipeColor = {r = 1,g = 1,b = 1},
        scrolling = true,
        ui = {
          scene = {
            {render = true,
                     {x = 0,
                      y = 0,
                      length = 100,
                      height = 50,
                      color = {1,1,1}}
            },
            
            {render = true,
                     {x = 0,
                      y = 500,
                      length = 100,
                      height = 50,
                      color = {1,1,1}}
              }
            }
          }
        }
player = {x = 100, y = 100, vel = 0, alive = true}
obstacles = {
}

ghosts = {}

function love.draw()
  for i in pairs(obstacles) do
    love.graphics.setColor(obstacles[i].pipe.top.color.r,obstacles[i].pipe.top.color.g,obstacles[i].pipe.top.color.b)
    love.graphics.rectangle("fill", obstacles[i].pipe.top.x, obstacles[i].pipe.top.y, 50, obstacles[i].pipe.top.topPipeLength)
    
    love.graphics.rectangle("fill", obstacles[i].pipe.top.x, obstacles[i].pipe.bottom.y, 50, obstacles[i].pipe.bottom.bottomPipeLength)
    
  love.graphics.setColor(0,1,0)
  butt = (obstacles[i].pipe.top.y + obstacles[i].pipe.top.topPipeLength) - obstacles[i].pipe.bottom.y - obstacles[i].pipe.bottom.bottomPipeLength

  love.graphics.rectangle("fill", obstacles[i].pipe.top.x, obstacles[i].pipe.top.y + obstacles[i].pipe.top.topPipeLength, 10,butt * -1)
end

for i in pairs(ghosts) do
  love.graphics.rectangle("fill", ghosts[i].x, ghosts[i].y, 5,5)
  ghosts[i].x = ghosts[i].x + game.scrollSpeed
  if ghosts[i].x + 5 < 0 then
--    table.remove(ghosts, i)
    ghosts[i] = nil
--    print(#ghosts)
  end
end

love.graphics.setColor(1,0,0)
love.graphics.rectangle("fill", player.x, player.y, 15,15)
if player.alive == false then
    player.x = player.x + game.scrollSpeed
  end
player_velocity()
pipe_move()

ui_draw()

if player_wall_collision_check() then
player.alive = false
  end
end

function pipe_create(xoffset)
  local gap = 0
  local pipeX = 800 + xoffset
  local _topPipeLength = 0
  local _bottomPipeLength = 0
  
    while gap ~= game.gapDistance do
      _topPipeLength = love.math.random(1,400)
      _bottomPipeLength = love.math.random(1,400) * -1
      gap = (game.topPipeBase + _topPipeLength) - game.bottomPipeBase - _bottomPipeLength
    end
table.insert(obstacles, {pipe = {top = {x = pipeX, y = game.topPipeBase, topPipeLength = _topPipeLength, color = {r = game.pipeColor.r, g = game.pipeColor.g, b = game.pipeColor.b}, game.pipeColor}, bottom = {x = pipeX, y = game.bottomPipeBase, bottomPipeLength = _bottomPipeLength}}})
end

function pipe_respawn()
  pipe_create(0)
end

function player_velocity()
  if player.alive then
    player_gravity()
--  if player.vel > -5 then
    player.vel = player.vel - 0.4^2 
--  end
  end
end

function player_gravity()
  player.y = player.y - player.vel^1
end

function pipe_move()
  if game.scrolling then
    for i in pairs(obstacles) do
        obstacles[i].pipe.top.x = obstacles[i].pipe.top.x + game.scrollSpeed
        if obstacles[i].pipe.top.x + 50 < 0 then
  --        table.remove(obstacles, i)
          if player.alive then
            obstacles[i] = nil
            pipe_respawn()
          else
            game.scrolling = false
          end
        end
      end
    end
end

function stage_progession()
  if game.score % 5 == 0 then
--      pipeColor = {1,1,1}
      --game.gapDistance = -50
--      game.pipeColor.r = game.pipeColor.r - .1
game.pipeColor.g = game.pipeColor.g - .1
game.pipeColor.b = game.pipeColor.b - .1
print("increment")
    end
end

function player_wall_collision_check()
  for i in pairs(obstacles) do
      if player.x + 15 > obstacles[i].pipe.top.x then
        if player.x < obstacles[i].pipe.top.x + 50 then
          if player.y < obstacles[i].pipe.top.y + obstacles[i].pipe.top.topPipeLength then
            return true
          elseif player.y + 15 > obstacles[i].pipe.bottom.y + obstacles[i].pipe.bottom.bottomPipeLength then
            return true
                end
            end
        end
        if player.x + 15 > obstacles[i].pipe.top.x and player.x < obstacles[i].pipe.top.x + 50 then
            game.clearing = true
          end
        if player.x > obstacles[i].pipe.top.x + 50 and game.clearing == true then
          add_point()
        end
        
        if player.y < game.topPipeBase or player. y + 15 > game.bottomPipeBase then
            return true
        end
    end
end

function add_point()
  if game.clearing then
      game.score = game.score + 1
      game.clearing = false
      stage_progession()
    end
end

function game_reset()
  
    game.score = 0
    player.x = 100
    player.y = 200
    player.vel = 0
    game.gapDistance = -100
    player.alive = true
    game.scrolling = true
    
      for i in pairs(timers) do
        timers[i] = nil
      end
      table.insert(timers, {time = .05, increment = 0.5, running = true})

  for i in pairs(obstacles) do
      obstacles[i] = nil
    end
    
    pipe_create(0)
    pipe_create(300)
    pipe_create(600)
    
end

function love.keyreleased(key)
  if player.alive == false then
      game_reset()
    end
  if key == "space" then
    player.vel = 5
  elseif key == "r" then
    game_reset()
  end
end
function ui_draw()
  for i in pairs(game.ui.scene) do
    love.graphics.setColor(game.ui.scene[i][1].color[1], game.ui.scene[i][1].color[2], game.ui.scene[i][1].color[3])
    love.graphics.rectangle("fill", game.ui.scene[i][1].x, game.ui.scene[i][1].y, 800, 100)
  end
  love.graphics.setColor(1,0,0)
  love.graphics.print(game.score, 100,25,nil,4,4,4,4)
end

timers = {}
table.insert(timers, {time = .05, increment = 0.5, running = true})

function love.update()
  for i in pairs(timers) do
      if timers[i].time > 0 then
          timers[i].time = timers[i].time - timers[i].increment
        else
          timers[i].running = false
        end
    
    if scrolling == false then
      timers[i] = nil
    end
    if timers[i].running == false then
        table.insert(ghosts, {x = player.x, y = player.y})
        timers[i].running = true
        timers[i].time = .3
      end
    end
end

pipe_create(0)
pipe_create(300)
pipe_create(600)
ui_draw()
