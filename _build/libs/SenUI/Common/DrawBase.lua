-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.STColor")

---General drawing helper functions
---@class DrawBase
---@section DrawBase 1 __DRAWBASE__
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
    
    ---@section calculateHeightOffsets
    ---@param elements table<SenUIGradient|SenUIDropdown|SenUIToggle> List of elements to calculate the height offsets for
    ---@return table<number> Height offsets of the elements
    calculateHeightOffsets = function(elements)
        local total = 0
        local heightOffsets = {}
        for _, element in ipairs(elements) do
            if _ > 1 then
                if element.type == 1 then -- SenUIToggle
                    total = total + 11
                elseif element.type == 2 then -- SenUIDropdown
                    total = total + 11
                end
            end
            heightOffsets[element.id] = total
        end
        return heightOffsets
    end,
}
---@endsection __DRAWBASE__