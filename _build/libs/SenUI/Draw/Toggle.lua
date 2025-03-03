-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---Toggle class. Used to create a toggle element
---@class SenUIToggle
---@field state boolean Current state of the toggle
---@field text string Text to display on the toggle
---@field backgroundColor STColor Background color of the toggle
---@field textColor STColor Text color of the toggle
---@section Toggle 1 __SENUITOGGLE__
SenUI.Toggle = {
    ---@section new
    ---@param state boolean Default state of the toggle
    ---@param text string Text to display on the toggle
    ---@param backgroundColor STColor Background color of the toggle
    ---@param textColor STColor Text color of the toggle
    ---@return SenUIToggle toggle Toggle element
    new = function(state, text, backgroundColor, textColor)
        local this = SenUI.New(SenUI.Toggle)
        this.state = state
        this.text = text
        this.backgroundColor = backgroundColor
        this.textColor = textColor
        this.type = 1
        return this
    end,
    ---@endsection

    ---@section draw
    ---@param x number X position of the element
    ---@param y number Y position of the element
    ---@param self SenUIToggle
    draw = function(self, x, y)
        SenUI.DrawBase.setColor(self.backgroundColor)
        local textOffset = #self.text * 5 + 5
        SenUI.DrawBase.drawRoundedRect(x, y, textOffset + 10, 8)

        --draw toggle
        y = y + 3
        SenUI.DrawBase.setColor(SenUI.Color.new(100, 100, 100))
        screen.drawLine(textOffset + x + 1, y, textOffset + x + 8, y)
        screen.drawLine(textOffset + x, y + 1, textOffset + x + 9, y + 1)
        screen.drawLine(textOffset + x + 1, y + 2, textOffset + x + 8, y + 2)

        if self.state then
            SenUI.DrawBase.setColor(SenUI.Color.new(100, 200, 100))
            screen.drawLine(textOffset + x + 7, y, textOffset + x + 7, y + 3)
            screen.drawLine(textOffset + x + 6, y + 1, textOffset + x + 9, y + 1)
        else
            SenUI.DrawBase.setColor(SenUI.Color.new(200, 100, 100))
            screen.drawLine(textOffset + x + 1, y, textOffset + x + 1, y + 3)
            screen.drawLine(textOffset + x, y + 1, textOffset + x + 3, y + 1)
        end

        SenUI.DrawBase.setColor(self.textColor)
        screen.drawText(x + 2, y - 1, self.text)
    end,
    ---@endsection

    ---@section toggle
    ---@param self SenUIToggle
    toggle = function(self)
        self.state = not self.state
    end,
    ---@endsection
}
---@endsection __SENUITOGGLE__