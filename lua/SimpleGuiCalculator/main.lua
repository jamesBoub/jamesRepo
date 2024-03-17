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
  local _x = 100
  local _y = 50
  local _w = 70
  local _h = 70
  local num = 0
  local it = 0
  
  for x = 1,5 do
    _x = 100
    _y = _y + _h + 5
    for z = 1,5 do
      if x <= 2 then
      table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = num, keyFunc = num})
      num = num + 1
    else
      if it == 0 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "+", keyFunc = num})
      elseif it == 1 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "-", keyFunc = num})
      elseif it == 2 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "÷", keyFunc = num})
      elseif it == 3 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "x", keyFunc = num})
      elseif it == 4 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "=", keyFunc = num})
      end
      it = it + 1
    end
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
        love.graphics.print(buttons[i].text, buttons[i].x + buttons[i].w / 2, buttons[i].y + buttons[i].w / 1.5)
      end
  end
end

function mouse_block_collision_check()
  local mouseX, mouseY = love.mouse.getPosition()
  for i in pairs(buttons) do
    if mouseX > buttons[i].x and mouseX < buttons[i].x + buttons[i].w and mouseY > buttons[i].y and mouseY < buttons[i].y + buttons[i].h then
      return true
      end
  end
end

function love.mousereleased(x,y,button)
  if button == 1 and mouse_block_collision_check() then
      love.event.quit()
    end
end
