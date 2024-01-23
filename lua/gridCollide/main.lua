grid = {}
blocks = {}
block_timers = {}

currentBlock = 0
shapeSel = 1
rotateLim = 0
pushmode = true

function love.draw()
  
  love.graphics.print("blocks " ..  #blocks, 380, 0)
  love.graphics.print("next shape: " .. shapeSel, 380, 30)
  
  for i in pairs(grid) do
    love.graphics.setColor(1,1,1)
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

function love.update(dt)
  for i in pairs(block_timers) do
      if block_timers[i].duration > 0 then
        block_timers[i].duration = block_timers[i].duration - 14 * dt
--        print(block_timers[i].duration)
      else
        block_move(0, 1, block_timers[i].identity)
        if block_timers[i] ~= nil then
          block_timers[i].duration = 3
        end
      end
    end
  end

function grid_generate(selectedRow)
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

function rowCheck()
  for i in pairs(blocks) do
    
      print(grid[blocks[i][3].x].x / 12 .. ' ' ..  blocks[i][3].y)
    end
  end

function love.keyreleased(key)
  limit = 0
  if key == "escape" then
    love.event.quit()
  elseif key == "space" then
    if currentBlock > 0 then
      block_timer(currentBlock)
    end
  elseif key == "w" then
    block_move(0,-1 , currentBlock)
  elseif key == "a" then
    block_move(-1,0, currentBlock)
  elseif key == "s" then
    block_move(0,1, currentBlock)
  elseif key == "d" then
    block_move(1,0, currentBlock)
  elseif key == "e" then
--    rowCheck()
--      print(block_timers[1].identity .. " " .. currentBlock)
    for z in pairs(block_timers) do
                if block_timers[z].identity == currentBlock then
                  block_timers[z] = nil
                  blocks[currentBlock][2].falling = false
                end
              end
  elseif key == "1" then
    shapeSel = 1
  elseif key == "2" then
    shapeSel = 2
  elseif key == "3" then
    shapeSel = 3
  elseif key == "4" then
  elseif key == "x" then
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
--  elseif key == "e" then
--    if not pushmode then
--      pushmode = true else
--      pushmode = false
--    end
  end
end

function block_timer(block)
  table.insert(block_timers, {identity = #blocks, duration = 3})
end

function block_spawn_and_fall(_x,_y,_shape)
  shape_create(_x, _y, _shape)
  block_timer(#blocks)
end

function love.mousereleased(x,y,button)
  if button == 1 then
    if mouse_grid_collision_check(x,y) and love.keyboard.isDown('lctrl') then
--      shape_create(clickedGridSquare.x / 12, clickedGridSquare.y / 12 , shapeSel)
      block_spawn_and_fall(clickedGridSquare.x / 12,clickedGridSquare.y / 12,shapeSel, #blocks)
      currentBlock = #blocks
    elseif mouse_grid_collision_check(x,y) then
      block_spawn_and_fall(clickedGridSquare.x / 12,clickedGridSquare.y / 12,shapeSel, #blocks)
--      shape_create(clickedGridSquare.x / 12, clickedGridSquare.y / 12 , shapeSel)
--            print(clickedGridSquare.x)

    elseif mouse_block_collision_check(x,y) then
      block_timers[clickedBlockSquare2] = nil
      clickedBlockSquare[clickedBlockSquare2] = nil
      currentBlock = #blocks
    end
  end
end

function block_rotate(direction)
  if rotateLim < 1 then
  if #blocks >= 1 then
  blockLength = #blocks[#blocks]
  offset = blocks[currentBlock][3].x - blocks[currentBlock][3].y
  for z = 3,blockLength  do
    newX = blocks[currentBlock][z].x 
    newY = blocks[currentBlock][z].y
    if direction == "clockwise" then
      blocks[currentBlock][z].x = newY * -1 + (blocks[currentBlock][3].y * 2) + offset
      blocks[currentBlock][z].y = newX - offset
      for i in pairs(blocks) do
          if i ~= currentBlock then
            for q = 3,#blocks[i] do
              if blocks[currentBlock][z].x == blocks[i][q].x and blocks[currentBlock][z].y == blocks[i][q].y then
                     block_rotate()
                     rotateLim = rotateLim + 1
                   end
                end
            end
        end
    elseif direction == nil then
--      print('bung')
      blocks[currentBlock][z].x = newY + offset
      blocks[currentBlock][z].y = newX * -1 + (blocks[currentBlock][3].y * 2) + offset
      for i in pairs(blocks) do
          if i ~= currentBlock then
              for q = 3,#blocks[i] do
              if blocks[currentBlock][z].x == blocks[i][q].x and blocks[currentBlock][z].y == blocks[i][q].y then
                     --love.event.quit()
                     block_rotate("clockwise")
                     rotateLim = rotateLim + 1
                   end
                end
            end
        end
      end
    end
end
  else
    rotateLim = 0
  end
  rotateLim = 0
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
    for u = 3,#blocks[i] do
    if mouseX > blocks[i][u].x * 12 and mouseX < blocks[i][u].x * 12 + 11 and mouseY > blocks[i][u].y * 12 and mouseY < blocks[i][u].y * 12 + 11 then
        clickedBlockSquare = blocks
        clickedBlockSquare2 = i
        return true, clickedBlockSquare, clickedBlockSquare2
      end
    end
  end
end
limit = 0
function block_collide(origXmove, origYmove, blockBeingMoved, blockCollidedWith)
  limit = limit + 1
--  print(ass)
  if limit < 10 then
    if origXmove == 1 then
            block_move(1, 0, blockCollidedWith)
    elseif origXmove == -1 then
            block_move(-1, 0, blockCollidedWith)
    elseif origYmove == 1 then
            block_move(0, 1, blockCollidedWith)
    elseif origYmove == -1 then
            block_move(0, -1, blockCollidedWith)
          end
          return true
  else
    return false
  end
end

function block_move(_x, _y, movedBlock)
    if #blocks >= 1 then
      for i = 3,blocks[movedBlock][1].length do
          blocks[movedBlock][i].x = blocks[movedBlock][i].x + _x
          blocks[movedBlock][i].y = blocks[movedBlock][i].y + _y
        for u in pairs(blocks) do
          for p = 3,blocks[u][1].length do
          if pushmode then
            if blocks[movedBlock][i].x == blocks[u][p].x and blocks[movedBlock][i].y == blocks[u][p].y and movedBlock ~= u then
              if not (block_collide(_x, _y, movedBlock, u)) then
    --                love.event.quit()
              end
          elseif blocks[movedBlock][i].x == blocks[u][p].x and blocks[movedBlock][i].y + 1 == blocks[u][p].y and movedBlock ~= u or blocks[movedBlock][i].y + 1 > 28 then

              for r in pairs(block_timers) do
                if block_timers[r].identity == movedBlock then
                  block_timers[r] = nil
                  blocks[movedBlock][2].falling = false
                  rowCheck()
                  
                end
              end
            end
          end
        end
      end 
    end
  end
end

function shape_create(originX, originY, shape)
    table.insert(blocks,  {})
    table.insert(blocks[#blocks],  {length = nil})
    table.insert(blocks[#blocks],  {falling = true})
  if shape == 1 then
--  table.insert(blocks[#blocks], {falling = false})
  table.insert(blocks[#blocks],  {x = originX, y = originY})
  table.insert(blocks[#blocks],  {x = originX + 1, y = originY})
  table.insert(blocks[#blocks],  {x = originX + 2, y = originY})
  table.insert(blocks[#blocks],  {x = originX + 3, y = originY})
  blocks[#blocks][1].length = #blocks[#blocks]
elseif shape == 2 then
  table.insert(blocks[#blocks],  {x = originX, y = originY})
  blocks[#blocks][1].length = #blocks[#blocks]
elseif shape == 3 then
  table.insert(blocks[#blocks],  {x = originX, y = originY})
  table.insert(blocks[#blocks],  {x = originX + 1, y = originY})
  table.insert(blocks[#blocks],  {x = originX, y = originY + 1})
  table.insert(blocks[#blocks],  {x = originX + 1, y = originY + 1})
  blocks[#blocks][1].length = #blocks[#blocks]
elseif shape == 4 then
  table.insert(blocks[#blocks],  {length = nil})
  blocks[#blocks][1].length = #blocks[#blocks]
--  print(#blocks[#blocks])
end
  currentBlock = currentBlock + 1
end

grid_generate()
