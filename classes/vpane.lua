local vpane = {

    x = nil,
    y = nil,
    width = nil,
    height = nil,
    imgList = {},
    buttonList = {}


}

local vpane_mt = {

    x = nil,
    y = nil,
    width = nil,
    height = nil,
    imgList = {},
    buttonList = {}


}

function vpane_mt:__index(key)
    return self.__baseclass[key]
end

vpane = setmetatable({ __baseclass = {} }, vpane_mt)

textButton = require 'classes.textButton'
imgButton = require 'classes.imgButton'

function vpane:new(x,y,width,height)

    local out = {}
    out.__baseclass = self
    setmetatable(out,getmetatable(self))
    out.buttonList = {}
    out.x = x
    out.y = y
    out.width = width
    out.height = height
    out.imgList = {
        'assets/tiles/floors/plainGrass.png',
        'assets/tiles/floors/plainStone.png',
        'assets/tiles/walls/wallGrass.png',
        'assets/tiles/walls/wallStone.png',
        'assets/tiles/special/void.png',
        'assets/tiles/special/firepit.png'
    }

    count = 0
    imgWidth = 60
    imgMargin = 1
    imgBg = {255,255,255}

    for ind,img in ipairs(out.imgList) do
        
        currImg = love.graphics.newImage(img)

        ix = out.x+(math.floor(count%4)*imgWidth)
        iy = out.y+(math.floor(count/4)*imgWidth)

        table.insert(out.buttonList,imgButton:new(ix,iy,imgWidth,imgWidth,currImg,imgBg,imgMargin))
        count = count + 1

    end

    return(out)

end

function vpane:getSelImg(mx,my)

    for ind,btn in ipairs(self.buttonList) do

        if btn:isPressed(mx,my) then

            return btn.img

        end

    end

    return false

end

function vpane:draw()
    
    for ind,btn in ipairs(self.buttonList) do

       btn:draw()
        
    end

end

return vpane
