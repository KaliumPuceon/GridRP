local token = {

    x=0,
    y=0,
    width=0,
    img=nil,
    border={255,255,255},
}

local token_mt = {

    x=0,
    y=0,
    width=0,
    img=nil,
    border={255,255,255}
}

function token_mt:__index(key)
    return self.__baseclass[key]
end

token = setmetatable({ __baseclass = {} },token_mt)

function token:new(x, y, width, img, border)

    local out = {}
    out.__baseclass = self
    setmetatable(out,getmetatable(self))
    
    out.x = x
    out.y = y
    out.width = width
    out.img = img or nil
    out.border = border or {255, 255, 255}

    return out
end

function token:draw()

    diam = self.img:getWidth()
    scale = self.width / diam
    radius = self.width / 2 
    love.graphics.draw(self.img,self.x,self.y,0,scale,scale)
    love.graphics.setColor(unpack(self.border))
    love.graphics.setLineWidth(4)
    love.graphics.circle("line",self.x+radius,self.y+radius,self.width/2)

end

function token:isPressed(mx,my)
 
    if mx>=self.x and mx<=self.x+self.width and
        my>=self.y and my<=self.y+self.width then
        return true
    end
    
end

return token
