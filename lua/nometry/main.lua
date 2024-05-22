function love.load()
  circle = {r = 10, x = 100, y = 100}
end

function love.update()
  mouseX, mouseY = love.mouse.getPosition()
  mouse_circle_collision_check(mouseX,mouseY)
  mouseCircDist = distance_between_2_points(mouseX,circle.x,mouseY,circle.y)
  
  
  if love.keyboard.isDown("w") then
      circle.y = circle.y - 2
    elseif love.keyboard.isDown("a") then
      circle.x = circle.x - 2
    elseif love.keyboard.isDown("s") then
      circle.y = circle.y + 2
    elseif love.keyboard.isDown("d") then
      circle.x = circle.x + 2
      end
  
end

function love.draw()
  
  love.graphics.setColor(1,1,1)
  
  love.graphics.print(mouseX .. " " .. mouseY, 0,0)
  love.graphics.circle("line", circle.x, circle.y, circle.r)
  love.graphics.print(mouseCircDist,0,12)
  
  love.graphics.line(mouseX, mouseY, circle.x, circle.y)
  love.graphics.line(mouseX, mouseY, mouseX, circle.y)
  
  love.graphics.line(circle.x, circle.y, mouseX, circle.y)
  
  love.graphics.setColor(1,0,0)
  
--  love.graphics.circle("fill",( mouseX / 2 + circle.x / 2), (mouseY / 2 + circle.y / 2), 6)
  love.graphics.print(math.floor(mouseCircDist), (mouseX / 2 + circle.x / 2), (mouseY / 2 + circle.y / 2))
  
end

function mouse_circle_collision_check(_x,_y)
  if distance_between_2_points(mouseX,circle.x,mouseY,circle.y) < circle.r then
    love.event.quit()
  end
end



function distance_between_2_points(x1,x2,y1,y2)
result = math.sqrt((x2-x1)^2+(y2-y1)^2)
 if result ~= nil then
   return result
  end
end