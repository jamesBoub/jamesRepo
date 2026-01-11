math.randomseed(os.time())

player = {}
--~ speed = 1

for x = 1,5000 do
	table.insert(player, {x = math.random(800), y = math.random(600), moving = true, speedMult = 1, color = {r = 1, g = 0, b = 1}})
end

target = {}
target.x = love.graphics.getWidth() / 2
target.y = love.graphics.getHeight() / 2
attract = 1
pause = false

function love.draw()
	for i in pairs(player) do
		
		local dx = target.x - player[i].x
		local dy = target.y - player[i].y
		
		local hypotenuse = math.sqrt(dx*dx+dy*dy)
		
		if player[i].x < 0 then 
			player[i].x = player[i].x + 1
		elseif player[i].x + 10 > 800 then
			player[i].x = player[i].x - 1
		end
		
		if player[i].y < 0 then
			player[i].y = player[i].y + 1
		elseif player[i].y + 10 > 600 then
			player[i].y = player[i].y - 1
		end
		
		if math.abs(dy) < 1 and math.abs(dx) < 1 then

			player[i].x = math.random(800)
			player[i].y = math.random(600)
		else
			player[i].moving = true
		end

		if player[i].moving and not pause then
			theta = math.atan2((target.y - player[i].y), (target.x - player[i].x))
			player[i].x = player[i].x - math.cos(theta) * player[i].speedMult * attract
			player[i].y = player[i].y - math.sin(theta) * player[i].speedMult * attract
		end
		
		--~ love.graphics.print(hypotenuse, 100,0)
		local colorChange = hypotenuse / 100
		love.graphics.setColor(player[i].color.r - colorChange,player[i].color.g,player[i].color.b)
		love.graphics.rectangle("fill", player[i].x, player[i].y, 5,5)
	end
	
	love.graphics.setColor(1,1,1)
	
	--~ love.graphics.print("theta: " .. math.floor(math.deg(theta)), 100,0)
	--~ love.graphics.print("dy " .. target.y - player.y, 100,20)
	--~ love.graphics.print("dx " .. target.x - player.x, 100,40)
	
	for i in pairs(player) do
	
		--~ love.graphics.setColor(player[i].color.r,player[i].color.g,player[i].color.b)
		--~ love.graphics.rectangle("fill", player[i].x, player[i].y, 5,5)
	end
	
	love.graphics.setColor(1,0,0)
	love.graphics.rectangle("fill", target.x, target.y, 10,10)
	
	if love.keyboard.isDown("w") then
		target.y = target.y - 2
	elseif love.keyboard.isDown("a") then
		target.x = target.x - 2
	elseif love.keyboard.isDown("s") then
		target.y = target.y + 2
	elseif love.keyboard.isDown("d") then
		target.x = target.x + 2
	end
end

function love.keyreleased(key)
	if key == "space" then
		if attract == -1 then
			attract = 1
		else
			attract = -1
		end
	elseif key == "lctrl" then
		if pause then
			pause = false
		else
			pause = true
		end
	end
end
