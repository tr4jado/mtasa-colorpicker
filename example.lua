local screen = Vector2(guiGetScreenSize())

local pallet = ColorPicker.new('colorpalette.png')

local palletX, palletY = screen.x / 2, screen.y / 2

addEventHandler('onClientRender', root, function()
    pallet:draw(palletX, palletY, 200, 200)

    local r, g, b = pallet:getColor()
    dxDrawText('R: ' .. r .. '\nG: ' .. g .. '\nB: ' .. b, palletX, palletY)
end)
