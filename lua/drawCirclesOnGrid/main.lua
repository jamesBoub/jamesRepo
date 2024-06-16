function love.load()
  circleX = 200
  circleY = 200
  circleR = 100
  circleDim = 5
  
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
  


  for i in pairs(grid) do
            love.graphics.setColor(grid[i].color)
            love.graphics.rectangle("fill", grid[i].x, grid[i].y, circleDim, circleDim)

love.graphics.setColor(1,1,1)
--  love.graphics.circle("fill", circleX, circleY, circleR)


    if  distance_between_2_points(grid[i].x + 11,circleX,grid[i].y,circleY) < circleR and distance_between_2_points(grid[i].x + 11,circleX,grid[i].y,circleY) > circleR - 50 or distance_between_2_points(grid[i].x ,circleX,grid[i].y + 11,circleY) < circleR and distance_between_2_points(grid[i].x,circleX,grid[i].y + 11,circleY) > circleR - 50 or distance_between_2_points(grid[i].x + 11 ,circleX,grid[i].y + 11,circleY) < circleR and distance_between_2_points(grid[i].x + 11,circleX,grid[i].y + 11,circleY) > circleR - 50 or distance_between_2_points(grid[i].x ,circleX,grid[i].y,circleY) < circleR and distance_between_2_points(grid[i].x,circleX,grid[i].y,circleY) > circleR - 50 then
--    love.graphics.setColor(1,0,0)
    
    grid[i].color = {0,1,1}
  else
    grid[i].color = {1,1,1}
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
  
  for x = 1,100 do
    yOff = yOff + circleDim + 1
    xOff = 0
  for y = 1,100 do
    table.insert(grid, {x = xOff, y = yOff, color = {1,0,1}})
xOff = xOff + circleDim + 1
  end
    end
  
end
