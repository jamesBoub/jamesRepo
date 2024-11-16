line = {}

table.insert(line, {})

function love.draw()
  
  for i in pairs(line) do
    if #line[i] >= 4 then
    love.graphics.line(line[i])
    end
  end
end

function love.mousereleased(x,y,button)
  if button == 1 then
    local x,y = love.mouse.getPosition()
    table.insert(line[#line], x)
    table.insert(line[#line], y)
  end
  if button == 2 then
    line = {{}}
  end
  if button == 3 then
    table.insert(line, {})
  end
end
