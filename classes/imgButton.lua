local button = {

    x=0,
    y=0,
    width=0,
    height=0,
    img=nil,
    bg={255,255,255},
    bgMargin=0

}

local button_mt = {

    x=0,
    y=0,
    width=0,
    height=0,
    img=nil,
    bg={255,255,255},
    bgMargin=0

}

function button_mt:__index(key)
    return self.__baseclass[key]
end

button = setmetatable({ __baseclass = {} },button_mt)

function button:new(x, y, width, height, img, bg, bgMargin)

    local out = {}
    out.__baseclass = self
    setmetatable(out,getmetatable(self))
    
    out.x = x
    out.y = y
    out.width = width
    out.height = height
    out.img = img or nil
    out.bg = bg or {255, 255, 255}
    out.bgMargin = bgMargin or 0

    return out
end

function button:draw()

    love.graphics.setColor(unpack(self.bg))
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    
    imgWidth = self.img:getWidth()
    imgHeight = self.img:getHeight()
    
    wideScale = (self.width-(2*self.bgMargin))/imgWidth
    highScale = (self.height-(2*self.bgMargin))/imgHeight

    love.graphics.setColor(255,255,255)
    love.graphics.draw(self.img,self.x+self.bgMargin,self.y+self.bgMargin,
        0,wideScale,heighScale)

end

function button:isPressed(mx,my)
 
    if mx>=self.x and mx<=self.x+self.width and
        my>=self.y and my<=self.y+self.height then
        return true
    end
    
end

return button
