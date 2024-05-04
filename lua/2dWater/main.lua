function love.load()
  blocks = {}
  grid_generate()
  
  
  for i in pairs(grid) do
      if grid[i].x / 21 == 5 and grid[i].y / 21 == 1 then 
          grid[i].status.block = true
        end
    end
  
  
--  table.insert(blocks, {x = 2, y = 9})
--  table.insert(blocks, {x = 5, y = 1})
end

function love.update()
end
--                    table.insert(blocks, {x = grid[collidedCell].x / 21, y = grid[collidedCell].y / 21})


function love.mousereleased(x,y,button)
  local xPos, yPos = love.mouse.getPosition()
  if button == 1 then
      if mouse_grid_collision_check() then
        print(collidedCell)
            if grid[collidedCell].status.block then
--              love.event.quit()
              grid[collidedCell].status.block = false
            elseif  grid[collidedCell].status.block == false then
              grid[collidedCell].status.block = true
              end
--        print(xPos, yPos)
        end
    end
end

function love.draw()
  for i in pairs(grid) do
      love.graphics.setColor(1,1,1)
        if grid[i].status.block then
          love.graphics.setColor(1,0,0)
        end
      love.graphics.rectangle('fill', grid[i].x, grid[i].y, grid[i].l, grid[i].w)
    end
end
function circle_draw()
  
end
function mouse_grid_collision_check()
  local mouseX, mouseY = love.mouse.getPosition()
  for i in pairs(grid) do
    if mouseX > grid[i].x and mouseX < grid[i].x + grid[i].w and mouseY > grid[i].y and mouseY < grid[i].y + grid[i].l then
        collidedCell = i
        return true, collidedCell, grid[i].status
      end
  end
end

function grid_generate()
  grid = {}
  local _x = 0
  local _y = 0
  local gridWidth = 20
  local gridHeight = 20
  
  for x = 1,gridHeight do
    _y = _y + 21
    _x = 0
    for y = 1,gridWidth do
      table.insert(grid, {x = _x, y = _y, w = 20, l = 20, status = {
            block = false
          }})
      
      _x = _x + 21
    end
  end
end
