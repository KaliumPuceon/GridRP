local tile = {

    terrain = nil,
    walkable = true,
    rot = 0,
    img = "../assets/tiles/special/void.png"

}

local tile_mt = {

    terrain = nil,
    walkable = true,
    rot = 0,
    img = "../assets/tiles/special/void.png"

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

return tile
