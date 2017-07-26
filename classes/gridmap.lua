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

    portBaseWidth = 4,
    portBaseHeight = 7,
    portHeight = 4,
    portWidth = 7,

    x = 0,
    y = 0

}

function gridmap:getTileX(xin)

    return((xin-self.x)*self.TILE_WIDTH*self.scale)+self.PORT_X_IN

end

function gridmap:getTileY(yin)

    return ((yin-self.y)*self.TILE_WIDTH*self.scale)+self.PORT_Y_IN

end

function gridmap:drawMap(area)

    for x=self.x,self.x+self.portWidth,1 do
        for y=self.y,self.y+self.portHeight,1 do
            if(x>=0 and x<=self.mapWidth and y>=0 and y<=self.mapHeight) then
                love.graphics.draw(area[x][y].img,gridmap.getTileX(x),self.getTileY(y),
                area[x][y].rot,self.scale)
            end
        end
    end
end

function gridmap:update(dt,ticks)

    if love.keyboard.isDown("=") and self.scale < 2 then
        self.scale = self.scale + 0.5 * dt
        self.portHeight = math.ceil(self.portBaseHeight/self.scale) + 1/self.scale
        self.portWidth = math.ceil(self.portBaseWidth/self.scale) + 1/self.scale

    elseif love.keyboard.isDown("-") and scale_factor > 0.2 then
        
        self.scale = self.scale - 0.5*dt
        self.portHeight = math.ceil(self.portBaseHeight/self.scale) + 1/self.scale
        self.portWidth = math.ceil(self.portBaseWidth/self.scale) + 1/self.scale
    end

    if (ticks <=0.01) then
        if love.keyboard.isDown("up") then
            self.porty = porty-(1)
            ticks = 0.1
        elseif love.keyboard.isDown("down") then
            self.porty = porty+(1)
            ticks = 0.1
        end
        if love.keyboard.isDown("left") then
            self.portx = portx-(1)
            ticks = 0.1
        elseif love.keyboard.isDown("right") then
            self.portx = portx+(1)
            ticks = 0.1
        end
    elseif ticks >0 then
        ticks = ticks - dt
    end

    return ticks

end


return gridmap
