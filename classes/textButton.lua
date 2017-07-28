local button = {

    x=0,
    y=0,
    width=0,
    height=0,
    text="",
    fg={0,0,0},
    bg={255,255,255},
    accent={200,200,200},
    accentMargin=0

}

local button_mt = {

    x=0,
    y=0,
    width=0,
    height=0,
    text="",
    fg={0,0,0},
    bg={255,255,255},
    accent={200,200,200},
    accentMargin=0

}

function button_mt:__index(key)
    return self.__baseclass[key]
end

button = setmetatable({ __baseclass = {} },button_mt)

function button:new(x, y, width, height, text, fg, bg, accent, accentMargin)

    local out = {}
    out.__baseclass = self
    setmetatable(out,getmetatable(self))
    
    out.x = x
    out.y = y
    out.width = width
    out.height = height
    out.text = text or ""
    out.fg = fg or {0,0,0}
    out.bg = bg or {255, 255, 255}
    out.accent = accent or {200, 200, 200}
    out.accentMargin = accentMargin or 0

    return out
end

function button:draw()

    love.graphics.setColor(unpack(self.accent))
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    
    love.graphics.setColor(unpack(self.bg))
    love.graphics.rectangle("fill",self.x+self.accentMargin,self.y+self.accentMargin,
        self.width-(2*self.accentMargin),self.height-(2*self.accentMargin))

    love.graphics.setColor(unpack(self.fg))
    love.graphics.printf({ self.fg,self.text},self.x+self.accentMargin,self.y+self.accentMargin,
        self.width-(2*self.accentMargin),"center")

end

function button:isPressed(mx,my)
 
    if mx>=self.x and mx<=self.x+self.width and
        my>=self.y and my<=self.y+self.height then
        return true
    end
    
end

return button
