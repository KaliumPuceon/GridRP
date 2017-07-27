vpane = {

    x = nil,
    y = nil,
    width = nil,
    height = nil,
    mainimg = nil,
    subimg = nil,

}

function vpane:new(x,y,width,height)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

end

return vpane
