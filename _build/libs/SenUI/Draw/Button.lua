-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall

--Code by STCorp. Do not reuse.--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---Button class to make Fun and Easy:tm: buttons
---@class SenUIButton: SenUIDrawable
---@field text string Text to display on the button
---@field pressed boolean If the button is pressed or not
---@field clicked boolean On press, this is true for one tick
---@field backgroundColor STColor Background color of the button
---@field textColor STColor Text color of the button
---@field type number Type of the element. (Internal use only)
---@field id number ID of the element. (Internal use only)
---@section Button 1 __SENUIBUTTON__
SenUI.Button = {
    ---@section new
    ---@param text string Text to display on the button
    ---@param backgroundColor STColor Background color of the button
    ---@param textColor STColor Text color of the button
    ---@return SenUIButton button Button element
    new = function(text, backgroundColor, textColor)
        local this = SenUI.New(SenUI.Button)
        this.text = text
        this.pressed = false
        this.clicked = false
        this.backgroundColor = backgroundColor
        this.textColor = textColor
        this.type = 3
        this.id = -1
        return this
    end,
    ---@endsection

    ---@section draw
    ---@param x number X position of the element
    ---@param y number Y position of the element
    ---@param self SenUIButton
    draw = function(self, x, y)
        SenUI.DrawBase.setColor(self.backgroundColor)
        local textOffset = #self.text * 5 + 5
        SenUI.DrawBase.drawRoundedRect(x, y, textOffset, 8)

        --draw button
        SenUI.DrawBase.setColor(self.textColor)
        screen.drawText(x + 2, y - 1, self.text)
    end,
    ---@endsection
}
---@endsection __SENUIBUTTON__