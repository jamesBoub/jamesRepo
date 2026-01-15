math.randomseed(os.time())

player = {}
playerSize = 10

player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2

projectiles = {}
projectileSize = 5

function love.draw()
	player_render()
	projectile_render()
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

function explosion_create(__x,__y,radius)
	--~ table.insert(projectiles, {x = _x, y = _y})
	angle = 0
	
	for i = 1,16 do
		
		_x = __x + math.cos(angle) * radius
		_y = __y + math.sin(angle) * radius
		
		table.insert(projectiles, {x = _x, y = _y})
		
		angle = angle + .4
	end
end

function love.mousereleased(x,y,button)
	if button == 1 then
		explosion_create(x,y,50)
	end
end
