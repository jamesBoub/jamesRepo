function love.load()
  circleX = 200
  circleY = 200
  circleR = 100
  
  grid_generate()
end

function love.update()
--  mouseX, mouseY = love.mouse.getPosition()
--  if distance_between_2_points(mouseX,circleX,mouseY,circleY) < 100 then
--    love.event.quit()
--  end
end

function love.draw()
  
  circleX,circleY = love.mouse.getPosition()
--  love.graphics.circle("fill", circleX, circleY, circleR)

  for i in pairs(grid) do

        love.graphics.rectangle("fill", grid[i].x, grid[i].y, 10, 10)
        love.graphics.setColor(1,1,1)

    if  distance_between_2_points(grid[i].x,circleX,grid[i].y,circleY) < circleR then
    love.graphics.setColor(1,0,0)
    end
end
end

function distance_between_2_points(x1,x2,y1,y2)
result = math.sqrt((x2-x1)^2+(y2-y1)^2)
 if result ~= nil then
   return result
  end
end

function grid_generate()
  grid = {}
  local xOff = 0
  local yOff = 0
  for x = 1,50 do
    xOff = xOff + 11
    yOff = 0
  for y = 1,50 do
      yOff = yOff + 11
      table.insert(grid, {x = xOff, y = yOff})
    end
  end
end