local screen = Vector2(guiGetScreenSize())

local cursor = {}

cursor.update = function()
    cursor.state = isCursorShowing()

    if cursor.state then
        local x, y = getCursorPosition()
        cursor.x, cursor.y = x * screen.x, y * screen.y
    else
        cursor.x, cursor.y = -1, -1
    end
end

cursor.onBox = function(x, y, w, h)
    return cursor.x >= x and cursor.x <= x + w and cursor.y >= y and cursor.y <= y + h
end

local clamp = function(value, min, max)
    return math.max(min, math.min(max, value))
end

-- ColorPicker class

ColorPicker = {}
ColorPicker.__index = ColorPicker

local circle = svgCreate(12, 12, [[
    <svg width='12' height='12' viewBox='0 0 12 12' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <rect x='1' y='1' width='10' height='10' rx='5' fill='white'/>
    </svg>    
]])

local stroke = svgCreate(12, 12, [[
    <svg width='12' height='12' viewBox='0 0 12 12' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <rect x='1.5' y='1.5' width='9' height='9' rx='4.5' stroke='black'/>
    </svg>
]])

function ColorPicker.new(pallet)
    local self = setmetatable({}, ColorPicker)

    self.texture = DxTexture(pallet)
    self.pixels = self.texture:getPixels()
    self.palletW, self.palletH = dxGetPixelsSize(self.pixels)

    self.width = 0
    self.height = 0

    self.selected = {0, 0}
    self.mouse = false
    self.actived = false

    return self
end

function ColorPicker:draw(x, y, width, height)
    cursor.update()

    self.x, self.y, self.width, self.height = x, y, width, height

    if getKeyState('mouse1') then
        if cursor.onBox(x, y, width, height) and not self.mouse then
            self.mouse = true
            self.actived = true
        end
    else
        self.mouse = false
        self.actived = false
    end

    if self.actived then
        self.selected = {cursor.x - x, cursor.y - y}
    end

    local r, g, b = self:getColor()

    if (not r or not g or not b) or (r == 0 and g == 0 and b == 0) then
        self.actived = false
        self.selected = {width / 2, height / 2}

        r, g, b = self:getColor()
    end

    dxDrawImage(x, y, width, height, self.texture, 0, 0, 0, tocolor(255, 255, 255, 255))

    local circleSize = 12
    local circleHalf = circleSize / 2

    dxSetBlendMode('add')
    dxDrawImage(x + self.selected[1] - circleHalf, y + self.selected[2] - circleHalf, circleSize, circleSize, circle, 0, 0, 0, tocolor(r, g, b, 255))
    dxDrawImage(x + self.selected[1] - circleHalf, y + self.selected[2] - circleHalf, circleSize, circleSize, stroke, 0, 0, 0, tocolor(255, 255, 255, 255))
    dxSetBlendMode('blend')
end

function ColorPicker:getColor(opacity)
    local x, y = self.selected[1], self.selected[2]
    local relativeX, relativeY = self.width / self.palletW, self.height / self.palletH

    local r, g, b = dxGetPixelColor(self.pixels, x / relativeX, y / relativeY)

    if opacity then
        opacity = clamp(opacity, 0, 1)

        r = math.floor(r * opacity)
        g = math.floor(g * opacity)
        b = math.floor(b * opacity)
    end

    return r, g, b
end

function ColorPicker:setPallet(pallet)
    self.texture:destroy()

    self.texture = DxTexture(pallet)
    self.pixels = self.texture:getPixels()
    self.palletW, self.palletH = dxGetPixelsSize(self.pixels)

    return true
end

function ColorPicker:destroy()
    self.texture:destroy()
    self = nil

    collectgarbage()

    return true
end
