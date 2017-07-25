-- Gonna make me a D&D grid manager thingamaheck
-- starting off with a homebrew tiling thing tho
-- gotta learn how tiles work, and this needs to
-- be easy enough for me to hack together a room
-- without having to reach for and use tiled.

-- warning: I have no idea what I am doing

-- I'm gonna guess that globals are bad practice but I'm also gonna guess that I 
-- don't actually care. 

TILE_WIDTH = 128 --pixel width of tileset
scale_factor = 1

PORT_X_IN = 8 --border on map window in x
PORT_Y_IN = 8 --border on map window in y

portBaseHeight = 3
portBaseWidth = 7
portHeight = portBaseHeight --tile height of window
portWidth = portBaseWidth--tile width of window

portx = 0 -- which block is in the top left corner x
porty = 0 -- which block is in the top left corner y

function getTileX(x) --get x placement value for a given tile

    return ((x-portx)*TILE_WIDTH*scale_factor)+PORT_X_IN

end

function getTileY(y) --get y placement value for a given tile

    return ((y-porty)*TILE_WIDTH*scale_factor)+PORT_Y_IN

end

function drawTiles(area,startx, starty) --draw area starting at given coords

    for x=startx,startx+portWidth,1 do
        for y=starty,starty+portHeight,1 do
            
            if (x>=0 and x <=1024 and y >= 0 and y <= 1024) then

                love.graphics.draw(area[x][y].img,getTileX(x),getTileY(y),
                area[x][y].rot,scale_factor)

            end

        end
    end

end

function getNearestCorner(x,y,startx,starty) --find nearest corner to point

    output = {
    xout = math.floor(((x-PORT_X_IN)/(TILE_WIDTH*scale_factor))+0.5)+startx,
    yout = math.floor(((y-PORT_Y_IN)/(TILE_WIDTH*scale_factor))+0.5)+starty
    }
    
    return (output)

end

function getNearestBlock(x,y,startx,starty) --nearest block coord to point

    return getNearestCorner(x-((TILE_WIDTH*scale_factor)/2),y-((TILE_WIDTH*scale_factor)/2)
    ,startx,starty)
    
end

-- Tile object stuff goes here -------------------------------------------------

tile = {

    terrain = nil,
    walkable = true,
    rot = 0,
    img = testimg

}

tile_mt = {

    terrain = nil,
    walkable = false,
    rot = 0,
    img = "assets/tiles/walls/grassCrossWall.png"

}

function tile_mt:__index(key)
    return self.__baseclass[key]
end

tile = setmetatable({ __baseclass = {} }, tile_mt)

function tile:new(...)
    local out = {}
    out.__baseclass = self
    setmetatable(out,getmetatable(self))
    if out.init then
        out:init(...)
    end
    return out
end

-- Tile object stuff ends here -------------------------------------------------

function love.load(arg)

    board = {}
    testimg = love.graphics.newImage("assets/tiles/floors/plainGrass.png")
    
    unifont = love.graphics.newFont("assets/fonts/unifont.ttf",16)

    for x=0,1024,1 do

        board[x] = {}
        
        for y=0,1024,1 do
            
            board[x][y] = tile:new()
            board[x][y].img = testimg
            board[x][y].walkable = true

        end
    end

    ticks = 0

end

selImg = love.graphics.newImage("assets/tiles/walls/grassPillar.png")

function sign(x)
    if x >= 0 then
        return true
    else
        return false
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

    scalebug=("scale: " .. tostring(scale_factor))

    if love.mouse.isDown(1) and blockX >= portx and blockX <= portx+portWidth
        and blockY >= porty and blockY <= porty+portHeight then
        board[blockX][blockY].img = selImg
    end

    if love.keyboard.isDown("r") then
        love.load()
    end

    if love.keyboard.isDown("=") and scale_factor < 2 then
        scale_factor = scale_factor + 0.5 * dt
        portHeight = math.ceil(portBaseHeight/scale_factor) + 1/scale_factor
        portWidth = math.ceil(portBaseWidth/scale_factor) + 1/scale_factor

    elseif love.keyboard.isDown("-") and scale_factor > 0.2 then
        
        scale_factor = scale_factor - 0.5*dt
        portHeight = math.ceil(portBaseHeight/scale_factor) + 1/scale_factor
        portWidth = math.ceil(portBaseWidth/scale_factor) + 1/scale_factor
    end

    if (ticks <=0.01) then
        if love.keyboard.isDown("up") then
            porty = porty-(1)
            ticks = 0.2
        elseif love.keyboard.isDown("down") then
            porty = porty+(1)
            ticks = 0.2
        elseif love.keyboard.isDown("left") then
            portx = portx-(1)
            ticks = 0.2
        elseif love.keyboard.isDown("right") then
            portx = portx+(1)
            ticks = 0.2
        end
    elseif ticks >0 then
        ticks = ticks - dt
    end

end

function drawMapMask(width,height)

    love.graphics.rectangle("fill",width,PORT_Y_IN,1600-width,900)
    love.graphics.rectangle("fill",PORT_X_IN,height,1600,900-height)

end

function love.draw(dt)


    love.graphics.setColor(255,100,100)
    love.graphics.rectangle("fill",0,0,1600,900)
    love.graphics.setColor(255,255,255)
    drawTiles(board,portx,porty)
    love.graphics.setColor(50,50,50)
    drawMapMask((portBaseWidth+1)*TILE_WIDTH,(portBaseHeight+1)*TILE_WIDTH)
    love.graphics.setColor(255,255,255)

    love.graphics.setFont(unifont)
    love.graphics.print (  { {255,0,255} ,cornerbug .. "\n" .. blockbug.."\n"..scalebug},20,20)

end

