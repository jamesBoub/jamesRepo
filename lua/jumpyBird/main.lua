game = {bottomPipeBase = 500,
        topPipeBase = 100,
        score = 0,
        clearing = false,
        
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
player = {x = 100, y = 100, vel = 0}
obstacles = {
}

function love.draw()
  for i in pairs(obstacles) do
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", obstacles[i].pipe.top.x, obstacles[i].pipe.top.y, 50, obstacles[i].pipe.top.topPipeLength)
    
    love.graphics.rectangle("fill", obstacles[i].pipe.top.x, obstacles[i].pipe.bottom.y, 50, obstacles[i].pipe.bottom.bottomPipeLength)
    
  love.graphics.setColor(0,1,0)
  butt = (obstacles[i].pipe.top.y + obstacles[i].pipe.top.topPipeLength) - obstacles[i].pipe.bottom.y - obstacles[i].pipe.bottom.bottomPipeLength

  love.graphics.rectangle("fill", obstacles[i].pipe.top.x, obstacles[i].pipe.top.y + obstacles[i].pipe.top.topPipeLength, 10,butt * -1)
end

love.graphics.setColor(1,0,0)
love.graphics.rectangle("fill", player.x, player.y, 15,15)
player_velocity()
pipe_move()

ui_draw()

if player_wall_collision_check() then
    love.event.quit()
  end
end

function pipe_create(xoffset)
  local gap = 0
  local pipeX = 800 + xoffset
  local _topPipeLength = 0
  local _bottomPipeLength = 0
  
    while gap ~= -100 do
      _topPipeLength = love.math.random(1,400)
      _bottomPipeLength = love.math.random(1,400) * -1
      gap = (game.topPipeBase + _topPipeLength) - game.bottomPipeBase - _bottomPipeLength
    end
    
table.insert(obstacles, {pipe = {top = {x = pipeX, y = game.topPipeBase, topPipeLength = _topPipeLength}, bottom = {x = pipeX, y = game.bottomPipeBase, bottomPipeLength = _bottomPipeLength}}})
end

function pipe_respawn()
  pipe_create(0)
end

function player_velocity()
  player_gravity()
  if player.vel > -4 then
    player.vel = player.vel - 0.4^2
  end
end

function player_gravity()
  player.y = player.y - player.vel
end

function pipe_move()
  for i in pairs(obstacles) do
      obstacles[i].pipe.top.x = obstacles[i].pipe.top.x - 3
      if obstacles[i].pipe.top.x + 50 < 0 then
        table.remove(obstacles, i)
        pipe_respawn()
      end
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
    end
end

function add_point()
  if game.clearing then
      game.score = game.score + 1
      game.clearing = false
    end
end

function love.keyreleased(key) 
  if key == "space" then
    player.vel = 5
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
pipe_create(0)
pipe_create(400)
ui_draw()