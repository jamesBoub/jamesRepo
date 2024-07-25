function love.load()

a = 1
b = 0
c = -4
width,height = love.graphics.getDimensions()

gridLines = {}
xoff = 0
xoff2 = 0
for x = 1,40 do
   
    table.insert(gridLines, {x1 = xoff,y1 = 0,x2 = xoff,y2 = 800})
    xoff = xoff + 20
--    print(xoff)
for y = 1,40 do
    table.insert(gridLines, {x1 = 0,y1 = xoff2,x2 = 800,y2 = xoff2})
    xoff2 = xoff2 + 20
  end
  end

xInt1 = -b+math.sqrt(((b^2)-4*a*c))/(2*a)
xInt2 = -b-math.sqrt(((b^2)-4*a*c))/(2*a)

--print(xInt1)


xPos = width/2
yPos = height/2
end

function love.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.line(0, height/2, width, height/2)
  love.graphics.line(width/2,0, width/2, height)
--love.graphics.line(0,10,100,10)
  for i in pairs(gridLines) do
    love.graphics.line(gridLines[i].x1, gridLines[i].y1, gridLines[i].x2, gridLines[i].y2)
  end
  
  love.graphics.setColor(1,0,0)
  
  if xInt1 ~= nil and xInt2 ~= nil then
  love.graphics.print("x1 " .. xInt1 .. " x2 " .. xInt2, 0,300)
  else
  love.graphics.print("DNE", 0,300)
  end
  
  love.graphics.translate(xPos, yPos)
--  print(xPos)
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
