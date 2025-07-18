lines = {

--~ {x1,y1,x2,y2,M},

}
timesLclicked = 0


function love.draw()
	for i in pairs(lines) do
		if lines[i].r == true then
			--~ love.graphics.lines(lines[i][1].x, lines[i][1].y, lines[i][2].x, lines[i][2].y)
			--~ print(lines[i][1].x .. " " .. lines[i][1].y .. "\n" .. lines[i][2].x .. " " .. lines[i][2].y)
			love.graphics.line(lines[i][1].x, lines[i][1].y, lines[i][2].x, lines[i][2].y)
		end
	end
end




function love.mousereleased(_x,_y,button)
	--~ print("x: " .. x .. " y: " .. y .. " button: " .. button)
	if button == 1 then
		seg_point_create(_x,_y)
	end
end

function seg_point_create(_x,_y)
	if timesLclicked == 0 then
		timesLclicked = timesLclicked + 1
		table.insert(lines, {
			r = false,
			{x = _x,y = _y}, {x,y}
		})
	else
		lines[#lines][2].x = _x
		lines[#lines][2].y = _y
		lines[#lines].r = true
		timesLclicked = 0
		print(lines[#lines].r)
		
		calculate_magnitude(lines[#lines][1].x,lines[#lines][1].y,lines[#lines][2].x,lines[#lines][2].y)
		
		--~ print(lines[#lines][1].x .. " " .. lines[#lines][1].x .. "\n" .. lines[#lines][2].x .. " " .. lines[#lines][2].x)
	end
end

function calculate_magnitude(x1,y1,x2,y2)
	local dx = x2-x1
	local dy = math.abs(y2-y1)
	
	print("magnitude " .. math.sqrt((dx)^2+(dy)^2))
	print(" dx " .. dx .. " dy: " .. dy)
	
end
