-- Gonna make me a D&D grid manager thingamaheck
-- starting off with a homebrew tiling thing tho
-- gotta learn how tiles work, and this needs to
-- be easy enough for me to hack together a room
-- without having to reach for and use tiled.

-- warning: I have no idea what I am doing

TILE_WIDTH = 128

PORT_X_IN = 16
PORT_Y_IN = 16

portHeight = 10*TILE_WIDTH
portWidth = 12*TILE_WIDTH

tile = {

    x = 0,
    y = 0,
    terrain = nil,
    walkable = true,
    rot = 0,
    img = nil

}

board = {}

testimg = love.graphics.newImage("assets/tiles/floors/plainGrass.png")

function getTileX(x)

end

function getTileY(y)

end

function drawTiles(area, startx, starty)

    for x=startx,startx+portWidth,1 do
        for y=starty,starty+portHeight,1 do
            
            love.graphics.draw(testimg,(x*TILE_WIDTH)+PORT_X_IN,(y*TILE_WIDTH)+PORT_Y_IN)

        end
    end

end

function getNearestCorner(X,Y)

end

function getNearestBlock(X,Y)

    
end

function love.load(arg)


end

function love.update(dt)

end

function love.draw(dt)

end

