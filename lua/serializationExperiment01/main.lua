 function file_clear(path)
  file = io.open(path, "w") -- r read mode and b binary mode
  if not file then return nil end
    content = file:read "*all" -- *a or *all reads the whole file
    file:close()
    return content
 end
 
 function read_file(path)
     file = io.open(path, "r") -- r read mode and b binary mode
    if not file then return nil end
    content = file:read "*all" -- *a or *all reads the whole file
    file:close()
    return content
end

 function write_file(path, mode, data)
     file = io.open(path, mode)
    if not file then return nil end
     content = file:write(data)
    file:close()
  end

function tableSerialize(table, destinationFile)
    write_file(destinationFile, "a", "table.insert(blugTable,{")
  for i = 1, #table do
    if i ~= #table then
        write_file(destinationFile, "a", "{x=" .. table[i].x .. ",y=" .. table[i].y .. "},")
  else
       write_file(destinationFile, "a", "{x=" .. table[i].x .. ",y=" .. table[i].y .. "}")
    end
  end
  write_file(destinationFile, "a", "})")
end

function love.keyreleased(key)
  if key == "escape" then
    gridUpdate(blugTable, "cereal.txt")
    dofile("main.lua")
  elseif key == "space" then
    file_clear("cereal.txt")
    dofile("main.lua")
elseif key == "e" then
    grid_generate()
    dofile("main.lua")
    end
end

function gridUpdate(table, destinationFile)
    write_file(destinationFile, "w", "table.insert(blugTable,{")
  for i = 1, #table do
    for u in pairs(table[i]) do
      if u ~= #table[i] then
        write_file(destinationFile, "a", "{x=" .. table[i][u].x .. ",y=" .. table[i][u].y .. "},")
      else
        write_file(destinationFile, "a", "{x=" .. table[i][u].x .. ",y=" .. table[i][u].y .. "}")
      end
    end
      write_file(destinationFile, "a", "})")
  end
end

function grid_generate()
  _x = 0
  _y = 0
  grid = {}
  for y = 1,54 do
    _y = _y + 8
    _x = 12
  for x = 1,54 do
    table.insert(grid, {x = _x, y = _y})
    _x = _x + 8
    end
  end
  file_clear("cereal.txt")
  tableSerialize(grid, "cereal.txt")
end

read_file = read_file("cereal.txt")
blugTable = {}
load(read_file)()

  function mouse_grid_collision_check()
    mouseX, mouseY = love.mouse.getPosition()
    for i in pairs(blugTable) do
      for u in pairs(blugTable[i]) do
        if mouseX > blugTable[i][u].x and mouseX < blugTable[i][u].x + 7 and mouseY > blugTable[i][u].y and mouseY < blugTable[i][u].y + 7 then
          tableInd1 = i
          tablInd2 = u
          return true, i, u
        end
      end
    end
  end
  
  function love.mousereleased(x,y,button)
  if button == 2 then
    if mouse_grid_collision_check() then
            table.remove(blugTable[tableInd1], tablInd2)
        end
      end
    end

function love.draw()
  for i in pairs(blugTable) do
    for u in pairs(blugTable[i]) do
      love.graphics.rectangle("fill", blugTable[i][u].x, blugTable[i][u].y, 7, 7)
        end
    end
end
