-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.STColor")

---General drawing helper functions
---@class SenUIDrawable
---@section DrawBase 1 __SENUIDRAWABLE__
SenUI.DrawBase = {
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

    ---@section isInBounds
    ---@param canvas SenUICanvas Element to check
    ---@return boolean inBounds If the element is in bounds
    isInBounds = function(canvas, index)
        local ho = (canvas.heightOffsets[index] and canvas.heightOffsets[index] or 0)
        return canvas.y + ho - canvas.scrollPixels-1 > 0 and canvas.y + ho - canvas.scrollPixels-1 < canvas.height
    end
    ---@endsection
}
---@endsection __SENUIDRAWABLE__