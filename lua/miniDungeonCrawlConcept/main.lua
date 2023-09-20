world = {
  tilex = 12,
  tiley = 12,
  xoff = 4,
  yoff = 1,
  rows = 60,
  playerx = 65,
  playerDirection = "west",
 tiles = {
        }
  }

segments = {  
}

text = {}
textHistory = {}
print(#textHistory)
scrolltext = {
  {"",300},
  {"",325},
  {"",350},
  {"",375},
  {"",400},
  {"",425},
  {"",450},
  {"",475},
  {"",500},
  {"",525},-- 10
  }
selector = 2
dupe = false
dupecount = 0

function love.keyreleased(key)
  
  table.insert(textHistory, {key})
  
  if key == "d" then
      if not (playerObstructionCheck(1)) then
      playerMove(1)
      world.playerDirection = "east"
      logpush("you move east")
      end
    elseif key == "s" then
      if not (playerObstructionCheck(world.rows)) then
      playerMove(60)
      world.playerDirection = "south"
      logpush("you move south")
      end
    elseif key == "w" then
      if not (playerObstructionCheck(-world.rows)) then
      playerMove(-60)
      world.playerDirection = "north"
      logpush("you move north")
      end
    elseif key == "a" then
      if not (playerObstructionCheck(-1)) then
      playerMove(-1)
      world.playerDirection = "west"
      logpush("you move west")
      end
    end
    
    if key == "space" then
      if world.playerDirection == "north" then
        world.tiles[world.playerx - 60].identity = "wall"
      elseif world.playerDirection == "west" then
        world.tiles[world.playerx - 1].identity = "wall"
      elseif world.playerDirection == "east" then
        world.tiles[world.playerx + 1].identity = "wall"
      elseif world.playerDirection == "south" then
        world.tiles[world.playerx + 60].identity = "wall"
      end
    logpush("you take shit :D")
    print(world.tiles[1].color[1])
    end
end
  


for y = 1, 15 do
    world.yoff = world.yoff + 13
    world.xoff = 0
  for x = 1, world.rows do
      table.insert(world.tiles, {x = world.xoff, y = world.yoff, identity = "empty", color = {1,1,1}})
      world.xoff = world.xoff + 13
  end
end

function love.draw()
  
  love.graphics.print(world.playerx, 0,530)
  world.tiles[world.playerx].identity = "player"
  
  
  
  for z = 1,9 do
      love.graphics.print(scrolltext[z][1], 0, scrolltext[z][2])
    end
  
  
 
     
    
    for i in pairs(world.tiles) do
    
    
    
    if world.tiles[i].identity == "wall" then
      world.tiles[i].color = {0,0,1}
    elseif world.tiles[i].identity == "empty" then
      world.tiles[i].color = {1,1,1}
    elseif world.tiles[i].identity == "player" then
      world.tiles[i].color = {1,0,0}
      end
    
    love.graphics.setColor(world.tiles[i].color)
   
      
     
      
    
    love.graphics.rectangle("fill", world.tiles[i].x, world.tiles[i].y, world.tilex, world.tiley)
    end
  end


--print(world.tiles[1].color[1])
function playerObstructionCheck(dir)
  --world.tiles[world.playerx + 1].color = {0,0,1}
  --print(world.tiles[world.playerx + 2].color[1] .. world.tiles[world.playerx + 2].color[2] .. world.tiles[world.playerx + 2].color[3])
  if world.tiles[world.playerx + dir].identity == "wall" then
      logpush("A wall blocks your path")
      return true
      
    end
end

function playerMove(direction)
  world.playerx = world.playerx + direction
  world.tiles[world.playerx - direction].identity = "empty"
end


function logpush(message)
       if scrolltext[8][1] == message or scrolltext[8][1] == message .. " X " .. dupecount then
        print("dupe")
        --message = message .. " ass"
        dupecount = dupecount + 1
        dupe = true
      else 
        dupe = false
        dupecount = 0
        end
      
      table.insert(text, {message})
      
      if not dupe then
      scrolltext[9][1] = message
      selector = selector + 1
      end
     
      
      if selector > 2 and not dupe then
          for z = 1,9 do
              scrolltext[z][1] = scrolltext[z + 1][1]
            end
        else scrolltext[8][1] = message .. " X " .. dupecount
          
          end
      
   end

function houseDraw()
  houseX = 3
  
  for z = 1,12 do
    if not(z > 6 and z < 8) then
    world.tiles[houseX].identity = "wall"
    end
    houseX = houseX + 60
  end
  
  for z = 1,12 do
    --if not z == 6 then
      world.tiles[houseX].identity = "wall"
    --end
    houseX = houseX + 1
    end
  
   for z = 1,12 do
    if not(z > 6 and z < 8) then
      world.tiles[houseX].identity = "wall"
    end
    houseX = houseX - 60
  end
  
  for z = 1,12 do
    world.tiles[houseX].identity = "wall"
    houseX = houseX - 1
    end
end

--houseDraw()
--world.tiles[1].color = {1,0,0}

