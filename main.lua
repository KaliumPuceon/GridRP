-- Gonna make me a D&D grid manager thingamaheck
-- starting off with a homebrew tiling thing tho
-- gotta learn how tiles work, and this needs to
-- be easy enough for me to hack together a room
-- without having to reach for and use tiled.

-- warning: I have no idea what I am doing

TILE_WIDTH = 128

PORT_X_IN = 16
PORT_Y_IN = 16

portHeight = 4
portWidth = 6

function getTileX(x)

    return (x*TILE_WIDTH)+PORT_X_IN

end

function getTileY(y)

    return (y*TILE_WIDTH)+PORT_Y_IN

end

function drawTiles(area,startx, starty)

    for x=startx,startx+portWidth,1 do
        for y=starty,starty+portHeight,1 do
            
            love.graphics.draw(testimg,getTileX(x-startx),getTileY(y-starty))

        end
    end

end

function getNearestCorner(x,y)

    output = {
    xout = math.floor(((x-PORT_X_IN)/TILE_WIDTH)+0.5),
    yout = math.floor(((y-PORT_Y_IN)/TILE_WIDTH)+0.5)
    }
    
    return (output)

end

function getNearestBlock(x,y)

    return getNearestCorner(x-(TILE_WIDTH/2),y-(TILE_WIDTH/2))
    
end

function love.load(arg)

    board = {}
    testimg = love.graphics.newImage("assets/tiles/floors/plainGrass.png")

    tile = {

        x = 0,
        y = 0,
        terrain = nil,
        walkable = true,
        rot = 0,
        img = nil

    }

end

function love.update(dt)

    corner = getNearestCorner(love.mouse.getX(),love.mouse.getY())
    cornerX = corner.xout
    cornerY = corner.yout

    print("closest corner: " .. tostring(cornerX).." ".. tostring(cornerY))

    nearBlock = getNearestBlock(love.mouse.getX(),love.mouse.getY())
    blockX = nearBlock.xout
    blockY = nearBlock.yout

    print("closest block: " .. tostring(blockX).." ".. tostring(blockY))

end

function love.draw(dt)

    drawTiles(0,3,8)

end

