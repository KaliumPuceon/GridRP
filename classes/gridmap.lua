-- map drawing object for drawing maps
-- also contains a ton of draw params because I need me some draw params
-- hopefully I can separate these intelligently and not mess any of it up

local gridmap = {

    TILE_WIDTH = 128,
    
    scale = 1,
    
    PORT_X_IN = 8,
    PORT_Y_IN = 8,

    mapWidth = 32,
    mapHeight = 32,

    portBaseHeight = 5,
    portBaseWidth = 9,
    portHeight = 5,
    portWidth = 9,

    x = 0,
    y = 0

}

function gridmap:getTileX(xin)

    return ((xin-gridmap.x)*gridmap.TILE_WIDTH*gridmap.scale)+gridmap.PORT_X_IN

end

function gridmap:getTileY(yin)

    return ((yin-gridmap.y)*gridmap.TILE_WIDTH*gridmap.scale)+gridmap.PORT_Y_IN

end

function gridmap:getpxWidth()

    return (self.PORT_X_IN+(self.TILE_WIDTH*(self.portBaseWidth+1)))

end

function gridmap:getpxHeight()

    return (self.PORT_Y_IN+(self.TILE_WIDTH*(self.portBaseHeight+1)))

end

function getNearestCorner(mx,my) --find nearest corner to point

    output = {
    xout = math.floor(((x-gridmap.PORT_X_IN)/(gridmap.TILE_WIDTH*gridmap.scale))+0.5)+startx,
    yout = math.floor(((y-gridmap.PORT_Y_IN)/(gridmap.TILE_WIDTH*gridmap.scale))+0.5)+starty
    }
    
    return (output)

end

function getNearestBlock(mx,my) --nearest block coord to point

    return getNearestCorner(
        x-((gridmap.TILE_WIDTH*gridmap.scale)/2),
        y-((gridmap.TILE_WIDTH*gridmap.scale)/2),
        startx,
        starty
        )
end

function gridmap:drawMapMask(pane_width,pane_height)

    width = (self.portBaseWidth+1)*self.TILE_WIDTH+self.PORT_X_IN
    height = (self.portBaseHeight+1)*self.TILE_WIDTH+self.PORT_Y_IN

    love.graphics.rectangle(
        "fill",
        width,
        self.PORT_Y_IN,
        pane_width-width,
        pane_height
    )
    
    love.graphics.rectangle(
        "fill",
        self.PORT_X_IN,
        height,
        pane_width,
        pane_height-height
    )

end

function gridmap:drawMap(area)

    startx = gridmap.x
    starty = gridmap.y

    halfWide = math.floor(self.portWidth/2)
    halfHigh = math.floor(self.portHeight/2)

    for x=startx,startx+gridmap.portWidth,1 do

        for y=starty,starty+gridmap.portHeight,1 do

            if(x>=0 and x<=gridmap.mapWidth and y>=0 and y<=gridmap.mapHeight) then
                
                love.graphics.draw(area[x][y].img,gridmap:getTileX(x),gridmap:getTileY(y),
                area[x][y].rot,gridmap.scale)

            end
        end
    end

    

    love.graphics.rectangle("line",gridmap.PORT_X_IN,gridmap.PORT_Y_IN,
    (gridmap.portBaseWidth+1)*gridmap.TILE_WIDTH,(gridmap.portBaseHeight+1)*gridmap.TILE_WIDTH)
    
    
end

function gridmap:update(dt,ticks)

    if love.keyboard.isDown("=") and gridmap.scale < 2 then
        gridmap.scale = gridmap.scale + 0.5 * dt
        gridmap.portHeight = math.ceil(gridmap.portBaseHeight/gridmap.scale) + 1/gridmap.scale
        gridmap.portWidth = math.ceil(gridmap.portBaseWidth/gridmap.scale) + 1/gridmap.scale

    elseif love.keyboard.isDown("-") and gridmap.scale > 0.1 then
        
        gridmap.scale = gridmap.scale - 0.5*dt
        gridmap.portHeight = math.ceil(gridmap.portBaseHeight/gridmap.scale) + 1/gridmap.scale
        gridmap.portWidth = math.ceil(gridmap.portBaseWidth/gridmap.scale) + 1/gridmap.scale
    end

    if (ticks <=0.01) then
        if love.keyboard.isDown("up") then
            gridmap.y = gridmap.y-(1)
            ticks = 0.1
        elseif love.keyboard.isDown("down") then
            gridmap.y = gridmap.y+(1)
            ticks = 0.1
        end
        if love.keyboard.isDown("left") then
            gridmap.x = gridmap.x-(1)
            ticks = 0.1
        elseif love.keyboard.isDown("right") then
            gridmap.x = gridmap.x+(1)
            ticks = 0.1
        end
    elseif ticks >0 then
        ticks = ticks - dt
    end

    return ticks

end


return gridmap
