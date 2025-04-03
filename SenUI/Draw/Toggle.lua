-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---(DEPRECATED, USE BUTTON CLASS) Toggle class. Used to create a toggle element
---@class SenUIToggle: SenUIDrawable
---@field state boolean State of the toggle
---@field text string Text to display on the toggle
---@field backgroundColor STColor Background color of the toggle
---@field textColor STColor Text color of the toggle
---@field type number Type of the element. (Internal use only)
---@field id number ID of the element. (Internal use only)
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
        this.id = -1
        return this
    end,
    ---@endsection

    ---@section tick
    ---@param self SenUIToggle
    ---@param ho number Height offset of the element
    ---@param available boolean
    ---@param canvas SenUICanvas
    ---@param isPointInRectangle function
    tick = function(self, ho, available, canvas, isPointInRectangle)
        if available and canvas.pulse and isPointInRectangle(canvas.x-1, canvas.y + ho - canvas.scrollPixels - 1, #self.text * 5 + 10) then
            self:toggle()
        end
    end,
    ---@endsection

    ---@section draw
    ---@param x number X position of the element
    ---@param y number Y position of the element
    ---@param self SenUIToggle
    draw = function(self, x, y)
        SenUI.Draw.setColor(self.backgroundColor)
        local textOffset = #self.text * 5 + 5
        SenUI.Draw.drawRoundedRect(x, y, textOffset + 10, 8)

        --draw toggle
        y = y + 3
        SenUI.Draw.setColor(SenUI.Color.new(100, 100, 100))
        screen.drawLine(textOffset + x + 1, y, textOffset + x + 8, y)
        screen.drawLine(textOffset + x, y + 1, textOffset + x + 9, y + 1)
        screen.drawLine(textOffset + x + 1, y + 2, textOffset + x + 8, y + 2)

        if self.state then
            SenUI.Draw.setColor(SenUI.Color.new(100, 200, 100))
            screen.drawLine(textOffset + x + 7, y, textOffset + x + 7, y + 3)
            screen.drawLine(textOffset + x + 6, y + 1, textOffset + x + 9, y + 1)
        else
            SenUI.Draw.setColor(SenUI.Color.new(200, 100, 100))
            screen.drawLine(textOffset + x + 1, y, textOffset + x + 1, y + 3)
            screen.drawLine(textOffset + x, y + 1, textOffset + x + 3, y + 1)
        end

        SenUI.Draw.setColor(self.textColor)
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