circle1 = {x = 150, y = 100, rad =20}
circle2 = {x = 50, y = 100, rad = 6}
grid = {}

function love.update()
end

function love.draw()
    circle_point_collide()
    for i in pairs(grid) do
      reset(i)
    end
  love.graphics.setColor(1,1,1)
  love.graphics.circle("fill", circle2.x, circle2.y, circle2.rad)
  love.graphics.setColor(1,0,0)
  love.graphics.circle("fill", circle1.x, circle1.y, circle1.rad)
  
  for i in pairs(grid) do
      love.graphics.draw(grid[i].kanvas)
                        grid[i].kanvas:release()

  end
  
if love.keyboard.isDown("d") then
  circle1.x = circle1.x + 1
elseif love.keyboard.isDown("a") then
  circle1.x = circle1.x - 1
end

if love.keyboard.isDown("w") then
    circle1.y = circle1.y - 1
  elseif love.keyboard.isDown("s") then
    circle1.y = circle1.y + 1
  end
  
if love.keyboard.isDown("space") then
  

end


end

function love.keyreleased(key)
  if key == "space" then
      for i in pairs(grid) do
      grid[i].kanvas:release()
      grid[i] = nil
    end
          grid_spawn()
    end
end

function distance_between_2_points(x1,y1,x2,y2)
  return math.sqrt((x2-x1)^2+(y2-y1)^2)
end

function circle_point_collide()

  for i in pairs(grid) do
    if circle1.x > grid[i].x and circle1.x < grid[i].x + 110 and circle1.y > grid[i].y and circle1.y < grid[i].y + 110 then
      grid[i].kanvas = love.graphics.newCanvas()
    for u in pairs(grid[i].blocks) do
     dist = distance_between_2_points(circle1.x,circle1.y,grid[i].blocks[u].x + 1.5,grid[i].blocks[u].y + 1.5)
     if dist < circle1.rad then
--        grid[i].kanvas:release()
        table.remove(grid[i].blocks, u)
        
        end
      end
    end
  end
end

function circle_collide(x1,y1,x2,y2,r1,r2)
  local dist = distance_between_2_points(x1,y1,x2,y2)
  local sumOfRadii = r1 + r2
  
  if sumOfRadii > dist then
    return false
  else return true
    end
end

function chunk_make(startX, startY)
   table.insert(grid, {blocks = {}, x = startX, y = startY, kanvas = love.graphics.newCanvas()})
   local xoff = startX
   local yoff = startY
  for y = 1,50 do
      yoff = yoff + 1
      xoff = startX
  for x = 1,50 do
      table.insert(grid[#grid].blocks, {x = xoff, y = yoff})
      xoff = xoff + 1
      love.graphics.setColor(1,1,1) 
    end
  end
    love.graphics.setCanvas()
end

function grid_spawn()

chunk_make(0,200)
chunk_make(55,200)
chunk_make(110,200)
chunk_make(165,200)
chunk_make(220,200)
chunk_make(275,200)

chunk_make(0,255)
chunk_make(55,255)
chunk_make(110,255)
chunk_make(165,255)
chunk_make(220,255)
chunk_make(275,255)

chunk_make(0,310)
chunk_make(55,310)
chunk_make(110,310)
chunk_make(165,310)
chunk_make(220,310)
chunk_make(275,310)

chunk_make(0,365)
chunk_make(55,365)
chunk_make(110,365)
chunk_make(165,365)
chunk_make(220,365)
chunk_make(275,365)
end

function reset(index)
grid[index].kanvas = love.graphics.newCanvas()

    love.graphics.setCanvas(grid[index].kanvas)
  for u in pairs(grid[index].blocks) do
    love.graphics.rectangle('fill',grid[index].blocks[u].x,grid[index].blocks[u].y,1,1)
  end
    love.graphics.setCanvas()

end

function grid_draw_on_start()
  for i in pairs(grid) do
    grid[i].kanvas:release()
    grid[i].kanvas = love.graphics.newCanvas()
    love.graphics.setCanvas(grid[i].kanvas)
      for u in pairs(grid[i].blocks) do
        love.graphics.rectangle('fill',grid[i].blocks[u].x,grid[i].blocks[u].y,1,1)
      end
    love.graphics.setCanvas()
  end
end
grid_spawn()  
grid_draw_on_start()
