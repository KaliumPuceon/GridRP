-- Gonna make me a D&D grid manager thingamaheck
-- starting off with a homebrew tiling thing tho
-- gotta learn how tiles work, and this needs to
-- be easy enough for me to hack together a room
-- without having to reach for and use tiled.

-- warning: I have no idea what I am doing

-- I'm gonna guess that globals are bad practice but I'm also gonna guess that I 
-- don't actually care. 

TILE_WIDTH = 128 --pixel width of tileset

PORT_X_IN = 16 --border on map window in x
PORT_Y_IN = 16 --border on map window in y

portHeight = 5 --tile height of window
portWidth = 5 --tile width of window

portx = 1 -- which block is in the top left corner x
porty = 1 -- which block is in the top left corner y

function getTileX(x) --get x placement value for a given tile

    return ((x-portx)*TILE_WIDTH)+PORT_X_IN

end

function getTileY(y) --get y placement value for a given tile

    return ((y-porty)*TILE_WIDTH)+PORT_Y_IN

end

function drawTiles(area,startx, starty) --draw area starting at given coords

    for x=startx,startx+portWidth,1 do
        for y=starty,starty+portHeight,1 do
            
            if not (area[x][y] == nil) then

                love.graphics.draw(area[x][y].img)
            end
            --love.graphics.draw(testimg,getTileX(x),getTileY(y))

        end
    end

end

function getNearestCorner(x,y,startx,starty) --find nearest corner to point

    output = {
    xout = math.floor(((x-PORT_X_IN)/TILE_WIDTH)+0.5)+startx,
    yout = math.floor(((y-PORT_Y_IN)/TILE_WIDTH)+0.5)+starty
    }
    
    return (output)

end

function getNearestBlock(x,y,startx,starty) --nearest block coord to point

    return getNearestCorner(x-(TILE_WIDTH/2),y-(TILE_WIDTH/2),startx,starty)
    
end

function love.load(arg)

    board = {}
    testimg = love.graphics.newImage("assets/tiles/floors/plainGrass.png")
    
    unifont = love.graphics.newFont("assets/fonts/unifont.ttf",16)

    tile = {

        x = 1,
        y = 1,
        terrain = nil,
        walkable = true,
        rot = 0,
        img = testimg

    }

    for x=1,8,1 do

        board[x] = {}
        
        for y=1,8,1 do
            
            board[x][y] = tile
            board[x][y].x = x
            board[x][y].y = y
            board[x][y].img = testimg

        end
    end

    for i,line in pairs(board) do
        for j,point in pairs(line) do
        
            io.write(tostring(point.x).. " " ..tostring(point.y))

        end
        print()
    end

end

function love.update(dt)

    corner = getNearestCorner(love.mouse.getX(),love.mouse.getY(),portx,porty)
    cornerX = corner.xout
    cornerY = corner.yout

    cornerbug=("cornr: " .. tostring(cornerX).." ".. tostring(cornerY))

    nearBlock = getNearestBlock(love.mouse.getX(),love.mouse.getY(),portx,porty)
    blockX = nearBlock.xout
    blockY = nearBlock.yout

    blockbug=("block: " .. tostring(blockX).." ".. tostring(blockY))

end

function love.draw(dt)

    drawTiles(board,portx,porty)
    love.graphics.setFont(unifont)
    love.graphics.print (  { {255,0,255} ,cornerbug .. "\n" .. blockbug},20,20)

end

