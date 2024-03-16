function love.load()
  buttion_create()
end

function love.update()
end

function love.draw()
  button_draw()
end

function buttion_create()
  buttons = {}
  _x = 20
  _y = 50
  _w = 50
  _h = 50
  
  for x = 1,5 do
    _x = 0
    _y = _y + _h + 5
    for z = 1,5 do
      table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "ass"})
      _x = _x + _w + 5
    end
  end
end

function button_draw()
  for i in pairs(buttons) do
      love.graphics.setColor(1,1,1)
      love.graphics.rectangle("fill", buttons[i].x, buttons[i].y, buttons[i].w, buttons[i].h)
      if buttons[i].text ~= nil then
        love.graphics.setColor(1,0,0)
        love.graphics.print(buttons[i].text, buttons[i].x, buttons[i].y)
      end
  end
end
