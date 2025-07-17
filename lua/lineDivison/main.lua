lines = {
--~ {x1 = 50, y1 = 100, x2 = 500, y2 = 100},
{x1 = 50, y1 = 200, x2 = 500, y2 = 200, color = {1,1,1}, split = {}}
}

circles = {}

function line_render(x1,y1,x2,y2)
	love.graphics.line(x1,y1,x2,y2)
end

function divide_line(x1,y1,x2,y2,m,n)

	
	
	local _x = (m * x2 + n * x1) / (m + n)
    local _y = (m * y2 + n * y1) / (m + n)
	
	--~ print(m/n)
	
	return _x, _y
end


function love.draw()
love.graphics.setColor(1,1,1)
	if #lines >= 0 then
		love.graphics.print(#lines, 0,0)
		
		if #lines[#lines].split ~= nil then
		
		love.graphics.print(#lines[1].split,0,20)
		end
	end
	
	for i in pairs(lines) do
		love.graphics.setColor(lines[i].color[1],lines[i].color[2],lines[i].color[3])
		line_render(lines[i].x1, lines[i].y1, lines[i].x2, lines[i].y2)
		
		
			love.graphics.setColor(lines[i].color[1],lines[i].color[2],lines[i].color[3])
			
			
			--~ print(#lines[i].split)
			
				
					if lines[1].split.x1 ~= nil then
						love.graphics.setColor(lines[1].split.color[1],lines[1].split.color[2],lines[1].split.color[3])
						line_render(lines[1].split.x1, lines[1].split.y1, lines[1].split.x2, lines[1].split.y2)
					end
					--~ love.event.quit()
				
				
			
			
			
			
	end

end

function split_line(line, m, n)
	local midX, midY = divide_line(lines[line].x1, lines[line].y1, lines[line].x2, lines[line].y2, m,n)
	
	local oldx1 = lines[line].x1
	local oldy1 = lines[line].y1
	
	local oldx2 = lines[line].x2
	local oldy2 = lines[line].y2
	
	--~ table.remove(lines, #lines)
	lines[line] = nil
	table.insert(lines, {x1 = oldx1, y1 = oldy1, x2 = midX, y2 = midY, color = {1,0,0}, split = {x1 = midX, y1 = midY, x2 = oldx2, y2 = oldy2, color = {0,1,0}}})
	--~ table.insert(lines[line].split, {x1 = midX, y1 = midY, x2 = oldx2, y2 = oldy2, color = {0,1,0}})
	--~ lines[line].split = {x1 = midX, y1 = midY, x2 = oldx2, y2 = oldy2, color = {0,1,0}}
	
	--~ print(lines[line].split.x1)
	--~ print(#lines[line].split)
		--~ print(lines[#lines].split.x1 .. " ass " .. #lines)
end

function love.keyreleased(button)
	if button == "space" then
		--~ love.event.quit()
		--~ divide_circles(#lines, 1, 1)
		split_line(#lines, 1, 1)
	end
end
