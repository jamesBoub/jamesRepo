lines = {
{x1 = 50, y1 = 100, x2 = 500, y2 = 100}, {x1 = 50, y1 = 200, x2 = 500, y2 = 200}
}

function line_render(x1,y1,x2,y2)
	love.graphics.line(x1,y1,x2,y2)
end

function divide_line(x1,y1,x2,y2,m,n)

	
	
	local _x = (m * x2 + n * x1) / (m + n)
    local _y = (m * y2 + n * y1) / (m + n)
	
	print(m/n)
	
	return _x, _y
end


function love.draw()
	for i in pairs(lines) do
		line_render(lines[i].x1, lines[i].y1, lines[i].x2, lines[i].y2)
	end
	
	divide_and_draw_circles(1, 1, 1)
	
	--~ local midX, midY = divide_line(lines[1].x1, lines[1].y1, lines[1].x2, lines[1].y2, 2,1)
	--~ love.graphics.circle("fill", midX, midY, 20)
end

function divide_and_draw_circles(line, m, n)
	local midX, midY = divide_line(lines[line].x1, lines[line].y1, lines[line].x2, lines[line].y2, m,n)
	love.graphics.circle("fill", midX, midY, 20)
end
