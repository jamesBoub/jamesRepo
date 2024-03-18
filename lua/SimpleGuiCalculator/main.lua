function love.load()
  buttion_create()
  displayedNumber = nil
end

function love.update()
end

function love.draw()
  button_draw()
  output_draw()
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
      table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = num, keyFunc = num, number = true})
      num = num + 1
    else
      if it == 0 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "+", keyFunc = function() love.event.quit() end, number = false})
      elseif it == 1 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "-", keyFunc = subtraction, number = false})
      elseif it == 2 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "÷", keyFunc = division, number = false})
      elseif it == 3 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "x", keyFunc = multiplication, number = false})
      elseif it == 4 then
        table.insert(buttons, {x = _x, y = _y, w = _w, h = _h, text = "=", keyFunc = ret, number = false})
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

function output_draw()
  if displayedNumber ~= nil then
    love.graphics.print(displayedNumber, 50, 20)
  end
end

function mouse_block_collision_check()
  local mouseX, mouseY = love.mouse.getPosition()
  for i in pairs(buttons) do
    if mouseX > buttons[i].x and mouseX < buttons[i].x + buttons[i].w and mouseY > buttons[i].y and mouseY < buttons[i].y + buttons[i].h then
      clickedButton = i
      return true, clickedButton
      end
  end
end

function love.mousereleased(x,y,button)
  if mouse_block_collision_check() then
    if button == 1 and mouse_block_collision_check() and buttons[clickedButton].keyFunc ~= nil and buttons[clickedButton].number and displayedNumber ~= nil then
        displayedNumber =  displayedNumber .. buttons[clickedButton].keyFunc
      elseif buttons[clickedButton].number == false and displayedNumber ~= nil then
        buttons[clickedButton].keyFunc()
      elseif displayedNumber == nil then
        displayedNumber = buttons[clickedButton].keyFunc
      end
    end
end
