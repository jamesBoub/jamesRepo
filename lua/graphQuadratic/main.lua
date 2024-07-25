function love.load()

a = 1
b = 0
c = -5

xInt1 = -b+math.sqrt(((b^2)-4*a*c))/(2*a)
xInt2 = -b-math.sqrt(((b^2)-4*a*c))/(2*a)

print(xInt1)

width,height = love.graphics.getDimensions()

xPos = width/2
yPos = height/2
end

function love.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.line(0, height/2, width, height/2)
  love.graphics.line(width/2,0, width/2, height)
  
  love.graphics.setColor(1,0,0)
  
  if xInt1 ~= nil and xInt2 ~= nil then
  love.graphics.print("x1 " .. xInt1 .. " x2 " .. xInt2, 0,300)
  else
  love.graphics.print("DNE", 0,300)
  end
  
  love.graphics.translate(xPos, yPos)
  
   lastX, lastY = nil
  for x = -100,100 do
    local y = -(a * (x/20)^2 + b * (x/20) + c)
  y = y * 20
  
  if lastX ~= nil and lastY ~= nil then
      love.graphics.line(lastX, lastY, x, y)
    end
  lastX = x
  lastY = y
    end
end

function love.keyreleased(key) 
  if key == "1" then
    a=a+1
  elseif key == "2" then
    b=b+1
  elseif key == "w" then
    yPos = yPos - 10
  elseif key == "s" then
    yPos = yPos + 10
  elseif key == "space" then
    gug = gug + 1
  end
end

function love.update()
end
