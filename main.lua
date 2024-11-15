--[[
	Backend stuff
]]

panel = {}
panel.table = {}
panel.width = 39 -- has to be multiple of 3
panel.height = 18

function panel.flip(x, y, value)
  if panel.table[ ( y * panel.width ) + x ] == 1 then
    panel.table[ ( y * panel.width ) + x ] = 0
  else
    panel.table[ ( y * panel.width ) + x ] = 1
  end
end

function panel.get(x, y)
  return panel.table[ ( y * panel.width ) + x ]
end

for x=1, panel.width do
  for y=1, panel.height do
    panel.table[ ( y * panel.width ) + x ] = 0
  end
end

gui = {}
gui.scale = 16 -- size of draw panel cell

logo = love.graphics.newImage("sublogo.png")
logo:setFilter("nearest")

--[[
	LOVE stuff
]]

function love.load()
  love.window.setMode(640, 480)

  -- Left eye
  panel.flip(4, 4)
  panel.flip(4, 5)
  -- Right eye
  panel.flip(8, 4)
  panel.flip(8, 5)
  -- Smoil
  panel.flip(2, 8)
  for i=3,9 do
    panel.flip(i, 9)
  end
  panel.flip(10, 8)
end

function love.update()
  mx, my = love.mouse.getPosition()
end

function love.mousepressed(x, y)
  if x < gui.scale * panel.width and x > gui.scale then
  if y < gui.scale * panel.height and y > gui.scale then
      panel.flip(math.floor(x / gui.scale), math.floor(y / gui.scale))
  end
  end
end


function love.draw()
  -- Draw background
  love.graphics.setBackgroundColor(0, 0, 0)
  love.graphics.setColor(1, 1, 1)
  -- Draw logo
  love.graphics.draw(logo, gui.scale * 28 , gui.scale * 26, 0, 6, 6)
  -- border
  love.graphics.rectangle("line", gui.scale - 1, gui.scale - 1, ( gui.scale * panel.width ) - ( gui.scale - 3 ), ( gui.scale * panel.height ) - ( gui.scale - 3 ) )
  -- pixels
  for x=1, panel.width do
    for y=1, panel.height do
      if panel.get(x, y) == 1 then
        love.graphics.rectangle("fill", ( gui.scale * x ) + 1 , ( gui.scale * y ) + 1, gui.scale - 1, gui.scale - 1)
      end
    end
  end
  -- Draw subpixels
  -- love.graphics.rectangle("line", gui.scale - 2, gui.scale * ( panel.height + 1 ), ( gui.scale * panel.width ) - ( gui.scale - 3 ), ( gui.scale * panel.height ) - ( gui.scale - 3 ) )
  for x=1, panel.width, 3 do
    for y=1, panel.height do
      love.graphics.setColor(panel.get(x, y), panel.get(x+1, y), panel.get(x+2, y))
      love.graphics.rectangle("fill", ( x / 3 ) + gui.scale , y + ( gui.scale * ( panel.height + 1 ) ), 1, 1)
    end
  end
end
