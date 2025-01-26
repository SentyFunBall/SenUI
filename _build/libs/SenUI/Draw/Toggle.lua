-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---Toggle class. Used to create a toggle element
---@class SenUIToggle : BaseClass
---@field state boolean Current state of the toggle
---@field text string Text to display on the toggle
---@field backgroundColor STColor Background color of the toggle
---@field textColor STColor Text color of the toggle
SenUI.Toggle = {
    __c = "SenUIToggle",

    ---@section new Creates a new color object as RGB
    ---@param state boolean Default state of the toggle
    ---@param text string Text to display on the toggle
    ---@param backgroundColor STColor Background color of the toggle
    ---@param textColor STColor Text color of the toggle
    ---@returns SenUIToggle toggle Toggle element
    new = function(state, text, backgroundColor, textColor)
        local this = SenUI.Common.BaseClass.new(SenUI.Toggle)
        this.state = state
        this.text = text
        this.backgroundColor = backgroundColor
        this.textColor = textColor
        return this
    end,
    ---@endsection
    
    ---@section draw Draws the element onto the canvas
    ---@param x number X position of the element
    ---@param y number Y position of the element
    ---@param self SenUIToggle
    draw = function(self, x, y)
        SenUI.Common.DrawBase.setColor(self.backgroundColor)
        SenUI.Common.DrawBase.drawRoundedRect(x, y, #self.text * 5 + 15, 8)
        --draw toggle
        SenUI.Common.DrawBase.setColor(SenUI.Color.new(100, 100, 100))
        screen.drawLine(x + 1, y, x + 8, y)
        screen.drawLine(x, y + 1, x + 9, y + 1)
        screen.drawLine(x + 1, y + 2, x + 8, y + 2)
        if self.state then
            SenUI.Common.DrawBase.setColor(SenUI.Color.new(100, 200, 100))
            screen.drawLine(x + 7, y, x + 7, y + 3)
            screen.drawLine(x + 6, y + 1, x + 9, y + 1)
        else
            SenUI.Common.DrawBase.setColor(SenUI.Color.new(200, 100, 100))
            screen.drawLine(x + 1, y, x + 1, y + 3)
            screen.drawLine(x, y + 1, x + 3, y + 1)
        end
        SenUI.Common.DrawBase.setColor(self.textColor)
        screen.drawText(x + 2, y + 2, self.text)
    end
    ---@endsection
}