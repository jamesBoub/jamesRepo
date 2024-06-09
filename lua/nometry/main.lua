function love.load()
  circle = {r = 10, x = 100, y = 100}
end

function love.update()
  mouseX, mouseY = love.mouse.getPosition()
  mouse_circle_collision_check(mouseX,mouseY)
  
  hypotenuse = distance_between_2_points(mouseX,circle.x,mouseY,circle.y)
  opposite = distance_between_2_points(mouseX,circle.x,circle.y,circle.y)
  adjacent = distance_between_2_points(mouseX,mouseX,mouseY,circle.y)
  
  
  if love.keyboard.isDown("w") then
      circle.y = circle.y - 2
  end
    if love.keyboard.isDown("a") then
      circle.x = circle.x - 2
      end
    if love.keyboard.isDown("s") then
      circle.y = circle.y + 2
    end
    if love.keyboard.isDown("d") then
      circle.x = circle.x + 2
      end
  
end

function love.draw()
  love.graphics.setColor(1,1,1)
    
  area = (adjacent*opposite) / 2
  perimeter = adjacent / 100 * hypotenuse / 100 * opposite / 100
  slope = math.atan((mouseY - circle.y) / (mouseX - circle.x))

  
  love.graphics.print("mouse position" .. " " .. mouseX .. " " .. mouseY, 0,0)
--  love.graphics.circle("line", circle.x, circle.y, circle.r)
  love.graphics.print("hypotenuse" .. " " .. hypotenuse,0,12)
  love.graphics.print("opposite" .. " " .. opposite,0,24)
  love.graphics.print("adjacent" .. " " .. adjacent,0,36)
  love.graphics.print(area .. " " .. perimeter,0,68)
--  love.graphics.print("hypotenuse slope" .. " " .. slope_calculate(circle.x,mouseX,circle.y,mouseY), 0,80)
--  love.graphics.print("y intercept" .. " " .. y_intercept(circle.x,mouseX,circle.y,mouseY), 0,92)
--  love.graphics.print(area,0,100)
  love.graphics.line(mouseX, mouseY, circle.x, circle.y)
  love.graphics.line(mouseX, mouseY, mouseX, circle.y)
  
--  slope = slope_calculate(circle.x,mouseX,circle.y,mouseY)
  
  
--  glug = y_intercept(circle.x,mouseX,circle.y,mouseY)
  
  love.graphics.line(circle.x, circle.y, mouseX, circle.y)
  
  love.graphics.setColor(1,0,0)
--  love.graphics.line(circle.x, circle.y, slope_calculate(circle.x,mouseX,circle.y,mouseY),y_intercept(circle.x,mouseX,circle.y,mouseY))
  love.graphics.line(circle.x, circle.y, circle.x + math.cos(slope)*50, circle.y + math.sin(slope)*50)
--  love.graphics.line(circle.x, glug, mouseX, glug)
--    if mouseY > circle.y then
--      if mouseX > circle.x then
--            love.graphics.rectangle("line", mouseX - 20, circle.y, 20, 20)
--      elseif mouseX < circle.x then
--        love.graphics.rectangle("line", mouseX, circle.y, 20, 20)
--      end
--    elseif mouseY < circle.y then
--      if mouseX < circle.x then
--            love.graphics.rectangle("line", mouseX , circle.y - 20, 20, 20)
--      elseif mouseX > circle.x then
--        love.graphics.rectangle("line", mouseX - 20, circle.y - 20, 20, 20)
--      end
--    end
    
    
--    love.graphics.rectangle("line", mouseX - 20 * slope,
--      circle.y - 20 * slope,
--      20 * slope,
--      20 * slope)
    
--    love.graphics.rectangle("line",
--      mouseX,
--      circle.y,
--      20 * slope,
--      20 * slope)
    
--  love.graphics.rectangle("line", mouseX - perimeter, circle.y - perimeter, perimeter, perimeter)
  
--  love.graphics.circle("fill",( mouseX / 2 + circle.x / 2), (mouseY / 2 + circle.y / 2), 6)
  love.graphics.print(math.floor(hypotenuse), (mouseX / 2 + circle.x / 2), (mouseY / 2 + circle.y / 2))
  
end

--function slope_calculate(x1,x2,y1,y2)
--  slope = (y2 - y1) / (x2 - x1)
--  return slope
--end


--function y_intercept(x1,x2,y1,y2)
--  local _slope = slope_calculate(x1,x2,y1,y2)
--  --y = -x1*_slope+y1
--  y = -x1*_slope+y1
--  return y
--end


function mouse_circle_collision_check(_x,_y)
  if distance_between_2_points(mouseX,circle.x,mouseY,circle.y) < circle.r then
--    love.event.quit()
  end
end



function distance_between_2_points(x1,x2,y1,y2)
result = math.sqrt((x2-x1)^2+(y2-y1)^2)
 if result ~= nil then
   return result
  end
end
