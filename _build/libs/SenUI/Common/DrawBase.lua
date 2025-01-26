-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.STColor")

---General drawing helper functions
---@class DrawBase : BaseClass
SenUI.Common.DrawBase = {
    ---@section setColor Sets the color of the display
    ---@param color STColor Color to set the display to
    setColor = function(color)
        if color.type == "RGB" then
            local correctColor = color:gammaCorrect()
            screen.setColor(correctColor:open("flat"))
        else
            color = color:convertToRGB()
            local correctColor = color:gammaCorrect()
            screen.setColor(correctColor:open("flat"))
        end
    end,
    ---@endsection
    
    ---@section drawRoundedRect Draws a rounded rectangle
    ---@param x number X position of the rectangle
    ---@param y number Y position of the rectangle
    ---@param w number Width of the rectangle
    ---@param h number Height of the rectangle
    drawRoundedRect = function(x, y, w, h)
        screen.drawRect(x + 1, y + 1, w - 1, h - 1)     --body
        screen.drawLine(x + 2, y, x + w - 1, y)         --top
        screen.drawLine(x + 2, y + h, x + w - 1, y + h) --bottom
        screen.drawLine(x, y + 2, x, y + h - 1)         --left
        screen.drawLine(x + w, y + 2, x + w, y + h - 1) --right
    end,
    ---@endsection
}