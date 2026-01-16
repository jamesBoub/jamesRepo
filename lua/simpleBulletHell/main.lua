math.randomseed(os.time())

player = {}
playerSize = 4
playerSpeed = 2

player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2

projectiles = {}
projectileSize = 5

timers = {}

function love.draw()
	love.graphics.setColor(1,1,1)
	love.graphics.print(#projectiles)
	love.graphics.print(#timers,0,20)
	
	for i in pairs(timers) do
		love.graphics.print(timers[i].duration, 0, 40)
	end
	
	
	player_render()
	player_input()
	--~ timer_tick()
	projectile_render()
	projectiles_move()
	projectile_collisions()
	projectile_cull()
end

function love.update(dt)
	timer_tick(dt)
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
		player.y = player.y - playerSpeed
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - playerSpeed
	end
	if love.keyboard.isDown("s") then
		player.y = player.y + playerSpeed
	end
	if love.keyboard.isDown("d") then
		player.x = player.x + playerSpeed
	end
end

function explosion_create(__x,__y,amount,radius,_angle,_dispersion)
	for i = 1,amount do
		_x = __x + math.cos(_angle) * radius
		_y = __y + math.sin(_angle) * radius
		table.insert(projectiles, {x = _x, y = _y, a = _angle})
		_angle = _angle + _dispersion
	end
end

function love.mousereleased(x,y,button)
	if button == 1 then
		--~ explosion_create(x,y,8,0,math.rad(math.random(90)),math.rad(45))
		timer_create(5)
	end
end

function projectile_cull()
	for i in pairs(projectiles) do
		if projectiles[i].x < 0 or projectiles[i].x > love.graphics.getWidth() or projectiles[i].y < 0 or projectiles[i].y > love.graphics.getHeight() then
			table.remove(projectiles, i)
		end
	end
end

function distance(x1,y1,x2,y2)
	
	local dx = x2 - x1
	local dy = y2 - y1
	local dist = math.sqrt((dx*dx)+(dy*dy))
	
	return dist
end

function projectile_collisions()
	for i in pairs(projectiles) do
		local dist = distance(player.x, player.y, projectiles[i].x, projectiles[i].y) 
			if dist < projectileSize + playerSize then
				love.event.quit()
			end
	end
end

function timer_create(_duration, _action)
	table.insert(timers, {duration = _duration, action = _action, finished = false})
end

function timer_tick(dt)
	for x = 1,#timers do
	
		if not timers[x].finished then
			
			timers[x].duration = timers[x].duration - 1 * dt
			
			if timers[x].duration <= 0 then
				timers[x].finished = true
			end
			else
				love.event.quit()
			end
		end
	end
