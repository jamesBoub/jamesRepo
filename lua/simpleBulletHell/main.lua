math.randomseed(os.time())

player = {}
playerSize = 10

player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2

projectiles = {}
projectileSize = 5

function love.draw()
	player_render()
	player_input()
	projectile_render()
	projectiles_move()
end

function player_render()
	love.graphics.setColor(1,1,1)
	love.graphics.circle("fill", player.x, player.y, playerSize)
end

function projectile_render()
	for i in pairs(projectiles) do
		love.graphics.setColor(1,0,0)
		love.graphics.circle("fill", projectiles[i].x, projectiles[i].y, projectileSize)
	end
end

function projectiles_move()
	for i in pairs(projectiles) do
		projectiles[i].x = projectiles[i].x + math.cos(projectiles[i].a) * 1
		projectiles[i].y = projectiles[i].y + math.sin(projectiles[i].a) * 1
	end
end

function player_input()
	if love.keyboard.isDown("w") then
		player.y = player.y - 1
	elseif love.keyboard.isDown("a") then
		player.x = player.x - 1
	elseif love.keyboard.isDown("s") then
		player.y = player.y + 1
	elseif love.keyboard.isDown("d") then
		player.x = player.x + 1
	end
end

function explosion_create(__x,__y,amount,radius,_angle,_dispersion)
	
	--~ local angle = 0
	
	for i = 1,amount do
		_x = __x + math.cos(_angle) * radius
		_y = __y + math.sin(_angle) * radius
		table.insert(projectiles, {x = _x, y = _y, a = _angle})
		_angle = _angle + _dispersion
	end
end

function love.mousereleased(x,y,button)
	if button == 1 then
		--~ explosion_create(x,y,4,0,math.random(40),1)
		explosion_create(x,y,8,0,0,math.rad(45))
	end
end

function distance(x1,y1,x2,y2)
	
	local dx = x2 - x1
	local dy = y2 - y1
	local dist = math.sqrt((dx*dx)+(dy*dy))
	
	return dist
end
