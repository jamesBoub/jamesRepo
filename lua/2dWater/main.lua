function love.load()
  grid_create()
end

function love.update()
  mouse_grid_collide()
end

function love.draw()
  grid_render()
end

function grid_create()
  grid = {}
  blocks = {}
  _x = 0
  _y = 0
  for y = 1,40 do
    _y = _y + 10
    _x = 10
    for x = 1,40 do
      table.insert(grid, {x = _x, y = _y})
      _x = _x + 10
      end
  end
end
 
function grid_render()
  
  
  
  for i in pairs(grid) do
      love.graphics.setColor(1,1,1)
    
    for u in pairs(blocks) do
        if blocks[u][1].x == grid[i].x and blocks[u][1].y == grid[i].y then
          love.graphics.setColor(1,0,0)
          end
      end
    love.graphics.rectangle("fill", grid[i].x, grid[i].y, 9, 9)
  end
end

function mouse_grid_collide()
  mouseX,mouseY = love.mouse.getPosition()
    for i in pairs(grid) do
        if mouseX > grid[i].x and mouseX < grid[i].x + 9 and mouseY > grid[i].y and mouseY < grid[i].y + 9 then
          gridCollidedWith = i
          for u in pairs(blocks) do
            blockCollidedWith = u
              if grid[i].x == blocks[u][1].x and grid[i].y == blocks[u][1].y then
                removing = true
                return true, gridCollidedWith, blockCollidedWith, removing
              end
            end
            removing = false
          return true, gridCollidedWith, removing
        end
    end
end

function love.keyreleased(key)
end

function love.mousereleased(x,y,button)
  if button == 1 and mouse_grid_collide() and not removing then
    block_create(grid[gridCollidedWith].x, grid[gridCollidedWith].y)
--    print(blocks[#blocks].x / 10 .. " " .. blocks[#blocks].y / 10)
--print(blocks[#blocks][1].x)
elseif button == 2 and mouse_grid_collide() then
      if removing then
      blocks[blockCollidedWith] = nil
      end
  end
--  print(removing)
print(#blocks)
end

function block_create(_x, _y)
  table.insert(blocks, {})
  table.insert(blocks[#blocks], {x = _x, y = _y})
end
