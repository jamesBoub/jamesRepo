function love.load()
  grid_create()
  block_create(10, 80, "line", 4)
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
      for q in pairs(blocks[u]) do
        if blocks[u][q].x == grid[i].x and blocks[u][q].y == grid[i].y then
          love.graphics.setColor(1,0,0)
              end
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
            for q in pairs(blocks[u]) do
            blockCollidedWith = u
              if grid[i].x == blocks[u][q].x and grid[i].y == blocks[u][q].y then
                removing = true
                return true, gridCollidedWith, blockCollidedWith, removing
                end
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
    block_create(grid[gridCollidedWith].x, grid[gridCollidedWith].y, "dot")
--    print(blocks[#blocks].x / 10 .. " " .. blocks[#blocks].y / 10)
--print(blocks[#blocks][1].x)
elseif button == 2 and mouse_grid_collide() then
      if removing then
      blocks[blockCollidedWith] = nil
      end
  end
--  print(removing)
--print(#blocks)
end

function block_create(_x, _y, shape, length)
  table.insert(blocks, {})
  if shape == "dot" then
    table.insert(blocks[#blocks], {x = _x, y = _y})
  elseif shape == "line" and length ~= nil then
    offset = 0
    x = _x
    y = _y
    for x = 1,length do
      table.insert(blocks[#blocks], {x = _x + offset, y = _y})
      offset = offset + 10
      print(_x, _y)
        
    end
  end
end
