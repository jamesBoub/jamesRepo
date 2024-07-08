function love.load()
x = .01

gug = 0
a = 1
b = 1
c = 5

width,height = love.graphics.getDimensions()

xPos = width/2
yPos = height/2
end

function love.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.line(0, height/2, width, height/2)
  love.graphics.line(width/2,0, width/2, height)
  
  love.graphics.translate(xPos, yPos)
  
   lastX, lastY = nil
  for x = -100,100 do
    local y = -(a * (x/20)^2 + b * (x/20) + c)
  y = y * 20
  
  if lastX ~= nil and lastY ~= nil then
      love.graphics.setColor(1,0,0)
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
