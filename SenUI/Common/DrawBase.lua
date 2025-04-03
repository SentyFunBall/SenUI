-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.STColor")

---@class SenUIDrawable
---@section Draw 1 __SENUIDRAWABLE__
SenUI.Draw = {
    ---General drawing helper functions
    ---@section setColor
    ---@param color STColor Color to set the display to
    ---@param correctGamma? boolean Whether to correct the gamma of the color (Default true)
    setColor = function(color, correctGamma)
        correctGamma = correctGamma or true
        if color.type > 0 then color = color:toRGB() end
        if correctGamma then color = color:gammaCorrect() end
        screen.setColor(color:open())
    end,
    ---@endsection

    ---@section drawRoundedRect
    ---@param x number X position of the rectangle
    ---@param y number Y position of the rectangle
    ---@param w number Width of the rectangle
    ---@param h number Height of the rectangle
    drawRoundedRect = function(x, y, w, h)
        screen.drawRectF(x + 1, y + 1, w - 1, h - 1)     --body
        screen.drawLine(x + 2, y, x + w - 1, y)         --top
        screen.drawLine(x + 2, y + h, x + w - 1, y + h) --bottom
        screen.drawLine(x, y + 2, x, y + h - 1)         --left
        screen.drawLine(x + w, y + 2, x + w, y + h - 1) --right
    end,
    ---@endsection

    ---@section drawElement
    ---@param canvas SenUICanvas The canvas
    ---@param element SenUIDrawable Element to draw
    ---@param x number X position of the element
    ---@param y number Y position of the element
    drawElement = function(canvas, element, x, y)
        if element.type == -2 then -- SenUIScrollbar
            element:draw(x+canvas.width, canvas.y, canvas.height)
        elseif element.type == 0 then -- SenUIGradient
            element:draw()
        else
            element:draw(x, y)
            if element.type == 1 or element.type == 2 then -- SenUIToggle or SenUIButton
                if canvas.inUse then
                    SenUI.Draw.setColor(SenUI.Color.new(0, 0, 0, 200))
                    SenUI.Draw.drawRoundedRect(x, y, #element.text * 5 + (element.type == 1 and 15 or 3), 8)
                end
            end
        end
    end
    ---@endsection
}
---@endsection __SENUIDRAWABLE__