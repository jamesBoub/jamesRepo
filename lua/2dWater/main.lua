function love.load()
  grid_create()
  block_create(10, 80, "line", 5)
  currentBlock = #blocks
  blockShape = 1
end

function love.update()
  mouse_grid_collide()
end

function love.draw()
  grid_render()
  love.graphics.print(blockShape, 450, 100)
  love.graphics.circle("line")
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
        if blocks[u][q].x == grid[i].x and blocks[u][q].y == grid[i].y and i > 1 then
          love.graphics.setColor(1,0,0)

          if u == currentBlock then
              love.graphics.setColor(0,1,0)
            end
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
  if key == "escape" then
      love.event.quit()
    end
    
  if key == "1" then
    blockShape = 1
  elseif key == "2" then
    blockShape = 2
  end
  
    
  if key == "up" then
    if currentBlock < #blocks then
      currentBlock = currentBlock + 1
    end
  elseif key == "down" then
    if currentBlock > 1 then
      currentBlock = currentBlock - 1
    end
  elseif key == "right" then
    block_rotate(currentBlock, "clockwise")
  elseif key == "left" then
    block_rotate(currentBlock, "counterclockwise")
  end
    
  if key == "a" then
      block_move(currentBlock, "left")
    elseif key == "d" then
      block_move(currentBlock, "right")
    elseif key == "w" then
      block_move(currentBlock, "up")
    elseif key == "s" then
      block_move(currentBlock, "down")
    end
end

function love.mousereleased(x,y,button)
  if button == 1 and mouse_grid_collide() and not removing then
--    block_create(grid[gridCollidedWith].x, grid[gridCollidedWith].y, "dot")
    
  if blockShape == 1 then
      block_create(grid[gridCollidedWith].x, grid[gridCollidedWith].y, "dot", 1)
      currentBlock = #blocks
    elseif blockShape == 2 then
      block_create(grid[gridCollidedWith].x, grid[gridCollidedWith].y, "line", 5)
      currentBlock = #blocks
      end
--    print(blocks[#blocks].x / 10 .. " " .. blocks[#blocks].y / 10)
--print(blocks[#blocks][1].x)
elseif button == 2 and mouse_grid_collide() then
      if removing then
      blocks[blockCollidedWith] = nil
      currentBlock = #blocks
      end
  end
end

function block_move(movedBlock, direction)
  for z = 2,#blocks[movedBlock] do
   if direction == "right" then
     blocks[movedBlock][z].x = blocks[movedBlock][z].x + 10
    elseif direction == "left" then
      blocks[movedBlock][z].x = blocks[movedBlock][z].x - 10
    elseif direction == "down" then
      blocks[movedBlock][z].y = blocks[movedBlock][z].y + 10
    elseif direction == "up" then
      blocks[movedBlock][z].y = blocks[movedBlock][z].y - 10
    end
  end
end

function block_rotate(rotatedBlock, direction)
  rotatedBlockLength = blocks[rotatedBlock][1].length
    for z = 2,rotatedBlockLength + 1 do
      
          offset = blocks[rotatedBlock][2].x - blocks[rotatedBlock][2].y
          newX = blocks[rotatedBlock][z].x 
          newY = blocks[rotatedBlock][z].y
      
      if direction == "clockwise" then
          
          blocks[rotatedBlock][z].x = newY * -1 + (blocks[rotatedBlock][2].y * 2) + offset
          blocks[rotatedBlock][z].y = newX - offset
        
      elseif direction == "counterclockwise" then
        
          blocks[rotatedBlock][z].x = newY + offset
          blocks[rotatedBlock][z].y = newX * -1 + (blocks[rotatedBlock][2].y * 2) + offset
        
        end
      end
end

function block_create(_x, _y, shape, _length)
  table.insert(blocks, {})
  table.insert(blocks[#blocks], {length = _length})
  if shape == "dot" then
    table.insert(blocks[#blocks], {x = _x, y = _y})
  elseif shape == "line" and _length ~= nil then
    offset = 0
    x = _x
    y = _y
    for x = 1,_length do
      table.insert(blocks[#blocks], {x = _x + offset, y = _y})
      offset = offset + 10
    end
  end
--  print(blocks[1][1].length)
end
