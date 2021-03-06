-- Gonna make me a D&D grid manager thingamaheck
-- starting off with a homebrew tiling thing tho
-- gotta learn how tiles work, and this needs to
-- be easy enough for me to hack together a room
-- without having to reach for and use tiled.

-- warning: I have no idea what I am doing

-- I'm gonna guess that globals are bad practice but I'm also gonna guess that I 
-- don't actually care. 

vpane = require 'classes.vpane'
tile = require 'classes.tile'
gridmap = require 'classes.gridmap'
textButton = require 'classes.textButton'
imgButton = require 'classes.imgButton'
token = require 'classes.token'

WINDOW_WIDTH = 1600
WINDOW_HEIGHT = 900
--[[
function getNearestCorner(x,y,startx,starty) --find nearest corner to point

    output = {
    xout = math.floor(((x-gridmap.PORT_X_IN)/(gridmap.TILE_WIDTH*gridmap.scale))+0.5)+startx,
    yout = math.floor(((y-gridmap.PORT_Y_IN)/(gridmap.TILE_WIDTH*gridmap.scale))+0.5)+starty
    }
    
    return (output)

end

function getNearestBlock(x,y,startx,starty) --nearest block coord to point

    return getNearestCorner(
        x-((gridmap.TILE_WIDTH*gridmap.scale)/2),
        y-((gridmap.TILE_WIDTH*gridmap.scale)/2),
        startx,
        starty
        )

end
]]
function love.load(arg)

    selImg = love.graphics.newImage("assets/tiles/special/void.png")
    altImg = love.graphics.newImage("assets/tiles/floors/plainGrass.png")

    gridmap.portBaseWidth = 9
    gridmap.portBaseHeight = 5
    gridmap.mapWidth = 256
    gridmap.mapHeight=256

    board = {}
    testimg = love.graphics.newImage("assets/tiles/floors/plainGrass.png")

    unifont = love.graphics.newFont("assets/fonts/unifont.ttf",16)

    for x=0,gridmap.mapWidth,1 do

        board[x] = {}
        
        for y=0,gridmap.mapHeight,1 do
            
            board[x][y] = tile:new()
            board[x][y].img = testimg
            board[x][y].walkable = true

        end
    end

    ticks = 0

    testpane = vpane:new(gridmap:getpxWidth()+gridmap.PORT_X_IN,
        gridmap.PORT_Y_IN,
        WINDOW_WIDTH-gridmap:getpxWidth(),
        WINDOW_HEIGHT)

end

function sign(x)
    if x >= 0 then
        return true
    else
        return false
    end
end

function love.update(dt)

    mx = love.mouse.getX()
    my = love.mouse.getY()

    corner = gridmap:getNearestCorner(
        mx, 
        my 
    )

    cornerX = corner.xout
    cornerY = corner.yout

    cornerbug=("cornr: " .. tostring(cornerX).." ".. tostring(cornerY))

    nearBlock = gridmap:getNearestBlock(
        mx,
        my
    )

    blockX = nearBlock.xout
    blockY = nearBlock.yout

    blockbug=("block: " .. tostring(blockX).." ".. tostring(blockY))

    scalebug=("scale: " .. tostring(gridmap.scale))

    onGrid = gridmap:blockVisible(blockX,blockY)
    
    if love.mouse.isDown(1) and onGrid then
        board[blockX][blockY].img = selImg
    elseif love.mouse.isDown(2) and onGrid then
        board[blockX][blockY].img = altImg
    end

    if love.mouse.isDown(1) and not onGrid then
        selection = testpane:getSelImg(mx,my)
        if selection then
            selImg = selection
        end
    end
    
    if love.mouse.isDown(2) and not onGrid then
        selection = testpane:getSelImg(mx,my)
        if selection then
            altImg = selection
        end
    end

    if love.keyboard.isDown("r") then
        love.load()
    end

    ticks = gridmap:update(dt,ticks)

    fpsbug = "FPS: " .. tostring(love.timer.getFPS())

end

function love.draw(dt)

    love.graphics.setColor(50,50,50)
    love.graphics.rectangle("fill",0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    
    love.graphics.setColor(255,255,255)
    gridmap:drawMap(board)
    
    love.graphics.setColor(50,50,50)
    gridmap:drawMapMask(WINDOW_WIDTH,WINDOW_HEIGHT)
    
    love.graphics.setColor(255,255,255)

    testpane:draw()

    love.graphics.setFont(unifont)

    -- next line is my garbage monolithic debug print in bright purple ---------
    love.graphics.print (  { {255,0,255} ,cornerbug .. "\n" .. blockbug .. "\n" .. scalebug .. "\n" .. fpsbug},20,20)

end
