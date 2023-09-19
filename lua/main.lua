grid = {}
blocks = {}
currentBlock = 0
shapeSel = 2
lerpHolder = {}
tempLine = {}

function love.draw()
  
  lerps = {}
  
  for i in pairs(lerpHolder) do
   lerpHolder[i].dx = blocks[lerpHolder[i].b2][2].x - blocks[lerpHolder[i].b1][2].x
   lerpHolder[i].dy = blocks[lerpHolder[i].b2][2].y - blocks[lerpHolder[i].b1][2].y
   lerpHolder[i].dist = math.max(math.abs(lerpHolder[i].dx) + math.abs(lerpHolder[i].dy))
   for z = 1,lerpHolder[i].dist do
     table.insert(lerps, {})
     table.insert(lerps[#lerps], {x = lerp(blocks[lerpHolder[i].b2][2].x, blocks[lerpHolder[i].b1][2].x , z / lerpHolder[i].dist), y = lerp(blocks[lerpHolder[i].b2][2].y, blocks[lerpHolder[i].b1][2].y , z / lerpHolder[i].dist)})
    end
 end 
  
  love.graphics.print("current block: " ..  currentBlock, 380, 0)
  love.graphics.print("next shape: " .. shapeSel, 380, 30)
  love.graphics.print("lerps: " .. #lerps, 380, 60)
  
--  print(lerpHolder[currentBlock])
  
  if lerpHolder[currentBlock] ~= nil then
    love.graphics.print("b1: " .. lerpHolder[currentBlock].b1 .. "  b2: " .. lerpHolder[currentBlock].b2 , 380, 90)
  end
  for i in pairs(grid) do
    love.graphics.setColor(1,1,1)
    
    for o in pairs(lerps) do
          for c in pairs(lerps[o]) do
            if  grid[i].x / 12 == lerps[o][c].x and grid[i].y / 12 == lerps[o][c].y then
              love.graphics.setColor(0,1,0)
            end
          end
        end
    for u in pairs(blocks) do
      for z in pairs(blocks[u]) do
        if grid[i].x / 12 == blocks[u][z].x and grid[i].y / 12 == blocks[u][z].y then
          love.graphics.setColor(1,0,0)
            if u == currentBlock then
              love.graphics.setColor(0,0,1)
            end
          end
        end
      end
      love.graphics.rectangle("fill", grid[i].x, grid[i].y, 11, 11)
  end
end

function grid_generate()
  _x = 0
  _y = 0
  for _ = 1,28 do
    _y = _y + 12
    _x = 0
  for y = 1,28 do
    _x = _x + 12
    table.insert(grid, {x = _x, y = _y})
    end
  end
end

function love.keyreleased(key)
  if key == "escape" then
--    love.event.quit()
  elseif key == "space" then
    shape_create(nil, nil, 4)
  elseif key == "w" then
    block_move(0,-1 , currentBlock)
  elseif key == "a" then
    block_move(-1,0, currentBlock)
  elseif key == "s" then
    block_move(0,1, currentBlock)
  elseif key == "d" then
    block_move(1,0, currentBlock)
  elseif key == "1" then
  shapeSel = 1
elseif key == "2" then
  shapeSel = 2
elseif key == "3" then
  shapeSel = 3
elseif key == "4" then
  shapeSel = 4
elseif key == "x" then
  
  for i in ipairs(lerpHolder) do
    if lerpHolder[i].b1 == currentBlock or lerpHolder[i].b2 == currentBlock then
        table.remove(lerpHolder, i)
      end
  end
  
      if #blocks > 0 and love.keyboard.isDown("lctrl") then
      for z = 1,#blocks do
        blocks = {}
        end
        currentBlock = 0
      elseif #blocks > 0 then
      end
  elseif key == "up" then
    if currentBlock < #blocks then
      currentBlock = currentBlock + 1
    end
  elseif key == "down" then
    if currentBlock > 1 then
      currentBlock = currentBlock - 1
    end
  elseif key == "left" then
    block_rotate("clockwise")
  elseif key == "right" then
    block_rotate()
  elseif key == "e" then
    if not pushmode then
      pushmode = true else
      pushmode = false
    end
  elseif key == "space" then
    shape_create(12,1)
  end
end

function lerp(start,last,t)
  return math.floor((start * (1.0 - t) + t * last) + 0.5)
end

function love.mousereleased(x,y,button)
  if button == 1 then
     if mouse_grid_collision_check(x,y) and love.keyboard.isDown("lctrl") and #blocks >= 1 then
        shape_create(clickedGridSquare.x / 12, clickedGridSquare.y / 12 , shapeSel)
        lerp_make(currentBlock - 1, #blocks)
        currentBlock = #blocks
       elseif mouse_block_collision_check(x,y) and love.keyboard.isDown("lshift") then
        currentBlock = clickedBlockSquare2
       elseif mouse_grid_collision_check(x,y) then
         shape_create(clickedGridSquare.x / 12, clickedGridSquare.y / 12 , shapeSel)
         currentBlock = #blocks
       elseif mouse_block_collision_check(x,y) then
        for i in pairs(lerpHolder) do
          if lerpHolder[i].b1 == clickedBlockSquare2 or lerpHolder[i].b2 == clickedBlockSquare2 then 
              print(lerpHolder[i].b1 .. " " .. clickedBlockSquare2)
              print(lerpHolder[i].b2 .. " " .. clickedBlockSquare2)
              print()
              lerpHolder[i] = nil
            end
          end
          clickedBlockSquare[clickedBlockSquare2] = nil
       end
  elseif button == 2 then
     if mouse_block_collision_check(x,y) then
      table.insert(tempLine, {clickedBlockSquare2})
      if #tempLine > 1 then
        if tempLine[1][1] ~= tempLine[2][1] then
            lerp_make(tempLine[1][1], tempLine[2][1])
            print(#tempLine)
        end
          tempLine = {}
      end
    end
  end
end

function block_collide(origXmove, origYmove, blockBeingMoved, blockCollidedWith)
  if origXmove == 1 then
          block_move(1, 0, blockCollidedWith)
  elseif origXmove == -1 then
          block_move(-1, 0, blockCollidedWith)
  elseif origYmove == 1 then
          block_move(0, 1, blockCollidedWith)
  elseif origYmove == -1 then
          block_move(0, -1, blockCollidedWith)
  end
end

function block_rotate(direction)
  if #blocks >= 1 then
  blockLength = #blocks[#blocks]
  offset = blocks[currentBlock][2].x - blocks[currentBlock][2].y
  for z = 2,blockLength  do
    newX = blocks[currentBlock][z].x 
    newY = blocks[currentBlock][z].y
    if direction == "clockwise" then
      blocks[currentBlock][z].x = newY * -1 + (blocks[currentBlock][2].y * 2) + offset
      blocks[currentBlock][z].y = newX - offset
    else
      blocks[currentBlock][z].x = newY + offset
      blocks[currentBlock][z].y = newX * -1 + (blocks[currentBlock][2].y * 2) + offset
      end
    end
  end
end

function mouse_grid_collision_check(mouseX, mouseY)
  for i in pairs(grid) do
      if mouse_block_collision_check(mouseX, mouseY) then
        return false, clickedGridSquare
      else
        if mouseX > grid[i].x and mouseX < grid[i].x + 11 and mouseY > grid[i].y and mouseY < grid[i].y + 11 then
          clickedGridSquare = grid[i]
          return true, clickedGridSquare
      end
    end
  end
end

function mouse_block_collision_check(mouseX, mouseY)
  for i in pairs(blocks) do
    for u = 2,#blocks[i] do
    if mouseX > blocks[i][u].x * 12 and mouseX < blocks[i][u].x * 12 + 11 and mouseY > blocks[i][u].y * 12 and mouseY < blocks[i][u].y * 12 + 11 then
        clickedBlockSquare = blocks
        clickedBlockSquare2 = i
        return true, clickedBlockSquare, clickedBlockSquare2
      end
    end
  end
end

function block_move(_x, _y, movedBlock)
  if #blocks >= 1 then
    for i = 2,blocks[movedBlock][1].length do
          blocks[movedBlock][i].x = blocks[movedBlock][i].x + _x
          blocks[movedBlock][i].y = blocks[movedBlock][i].y + _y
    for u in pairs(blocks) do
      for p = 2,blocks[u][1].length do
      if blocks[movedBlock][i].x == blocks[u][p].x and blocks[movedBlock][i].y == blocks[u][p].y and movedBlock ~= u then
        block_collide(_x, _y, movedBlock, u)
          end
        end
      end
    end
  end
end

function shape_create(originX, originY, shape)
    table.insert(blocks,  {})
  if shape == 1 then
--  table.insert(blocks,  {})
  table.insert(blocks[#blocks],  {length = nil})
  table.insert(blocks[#blocks],  {x = originX, y = originY})
  table.insert(blocks[#blocks],  {x = originX + 1, y = originY})
  blocks[#blocks][1].length = #blocks[#blocks]
elseif shape == 2 then
--  table.insert(blocks,  {})
  table.insert(blocks[#blocks],  {length = nil})
  table.insert(blocks[#blocks],  {x = originX, y = originY})
  blocks[#blocks][1].length = #blocks[#blocks]
elseif shape == 3 then
--  table.insert(blocks,  {})
  table.insert(blocks[#blocks],  {length = nil})
  table.insert(blocks[#blocks],  {x = originX, y = originY})
  table.insert(blocks[#blocks],  {x = originX + 1, y = originY})
  table.insert(blocks[#blocks],  {x = originX, y = originY + 1})
  table.insert(blocks[#blocks],  {x = originX + 1, y = originY + 1})
  blocks[#blocks][1].length = #blocks[#blocks]
elseif shape == 4 then
--    table.insert(blocks,  {})
    table.insert(blocks[#blocks],  {length = nil})
  for q in pairs(lerps) do
    
    table.insert(blocks[#blocks], {x = lerps[q][1].x, y = lerps[q][1].y + 5})
  end
  blocks[#blocks][1].length = #blocks[#blocks]
  print(#blocks[#blocks])
end
  currentBlock = currentBlock + 1
end

function lerp_make(p1, p2)
  table.insert(lerpHolder, {
      b1 = p1,
      b2 = p2,
      dx = blocks[p1][2].x - blocks[p1][2].x,
      dy = blocks[p2][2].y - blocks[p1][2].y,
      dist = nil
    })
  end

grid_generate()
--shape_create(12,1,2)
--shape_create(9,4,2)
--lerp_make(1, 2)