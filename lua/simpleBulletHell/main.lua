bulletSource = {}
bulletSource.x = love.graphics.getWidth() / 2
bulletSource.y = love.graphics.getHeight() / 2

lineX = 0
lineY = 0

angle = 0

projectiles = {}
projectileSpeed = 2

function love.draw()
	lineX = bulletSource.x + math.cos(angle) * 20
	lineY = bulletSource.y + math.sin(angle) * 20
	
	love.graphics.setColor(1,1,1)
	--~ love.graphics.rectangle("fill", bulletSource.x, bulletSource.y, 20,20)
	
	love.graphics.setColor(1,0,0)
	love.graphics.line(bulletSource.x + 10, bulletSource.y + 10, lineX + 10, lineY + 10)

	love.graphics.print(#projectiles)

	for i in pairs(projectiles) do
		
		--~ dx = math.abs(projectiles[i].x - bulletSource.x)
		--~ dy = math.abs(projectiles[i].y - bulletSource.y)
		
		--~ hyp = math.sqrt(dx*dx+dy*dy)
		
		--~ love.graphics.print("dx " .. dx .. " dy " .. dy,0,25)
		--~ love.graphics.print(hyp,0,40)
		
		love.graphics.rectangle("fill", projectiles[i].x, projectiles[i].y, projectiles[i].size, projectiles[i].size)
		projectiles[i].x = projectiles[i].x + math.cos(projectiles[i].angle) * projectileSpeed
		projectiles[i].y = projectiles[i].y + math.sin(projectiles[i].angle) * projectileSpeed
		 
		projectileCull(i)
	end
	
	if love.keyboard.isDown("space") then
		table.insert(projectiles, 
					{
					 x = bulletSource.x + 5,
					 y = bulletSource.y + 5,
					 angle = math.atan2((lineY - bulletSource.y), (lineX - bulletSource.x)),
					 size = 5
					})
	end
	
	
	if love.keyboard.isDown("up") then
		angle = angle - .1
	elseif love.keyboard.isDown("down") then
		angle = angle + .1
	end
end

function projectileCull(u)
	if projectiles[u].x < - 100 or projectiles[u].x > love.graphics.getWidth() or projectiles[u].y < - 100 or projectiles[u].y + 5 > love.graphics.getHeight() then
		projectiles[u] = nil
	end
end

function love.keyreleased(key)
	--~ if key == "space" then
	
	--~ table.insert(projectiles, 
					--~ {
					 --~ x = bulletSource.x + 5,
					 --~ y = bulletSource.y + 5,
					 --~ angle = math.atan2((lineY - bulletSource.y), (lineX - bulletSource.x)),
					 --~ size = 5
					--~ })
	--~ end
end


