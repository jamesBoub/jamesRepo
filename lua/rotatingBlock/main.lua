--~ math.randomseed(os.time())

target = {}
target.x = love.graphics.getWidth() / 2
target.y = love.graphics.getHeight() / 2

ring = {}
--~ ring.x = math.random(800)
--~ ring.y = math.random(600)

theta = 0

function love.draw()

	ring.x = target.x + math.cos(theta) * 100
	ring.y = target.y + math.sin(theta) * 100

	love.graphics.setColor(1,1,1)
	love.graphics.rectangle("fill", target.x, target.y, 10,10)
	
	love.graphics.setColor(1,0,0)
	love.graphics.rectangle("fill", ring.x, ring.y, 10,10)
	
	love.graphics.print(math.deg(theta))
	
	if love.keyboard.isDown("w") then
		target.y = target.y - 5
	elseif love.keyboard.isDown("a") then
		target.x = target.x - 5
	elseif love.keyboard.isDown("s") then
		target.y = target.y + 5
	elseif love.keyboard.isDown("d") then
		target.x = target.x + 5
	end
	
	if love.keyboard.isDown("up") then
		theta = theta + .1
	elseif love.keyboard.isDown("down") then
		theta = theta - .1
	end
end

