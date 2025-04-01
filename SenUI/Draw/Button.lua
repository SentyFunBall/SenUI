-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall

--Code by STCorp. Do not reuse.--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---Combined button and toggle class to create these fun things
---@class SenUIButton: SenUIDrawable
---@field text string Text to display on the button
---@field pressed boolean If the button is pressed or not
---@field clicked boolean On press, this is true for one tick
---@field backgroundColor STColor Background color of the button
---@field textColor STColor Text color of the button
---@field type number Type of the element. (Internal use only)
---@field id number ID of the element. (Internal use only)
---@field state boolean State of the toggle
---@section Button 1 __SENUIBUTTON__
SenUI.Button = {
    ---@section new
    ---@param text string Text to display on the button
    ---@param backgroundColor STColor Background color of the button
    ---@param textColor STColor Text color of the button
    ---@overload fun(text: string, backgroundColor: STColor, textColor: STColor, type: string, state: boolean): SenUIButton
    ---@return SenUIButton button Button element
    new = function(text, backgroundColor, textColor, type, state)
        local this = SenUI.New(SenUI.Button)
        this.text, this.pressed, this.clicked, this.backgroundColor, this.textColor, this.state, this.id = text, false, false, backgroundColor, textColor, state and state or false, -1
        if type == "toggle" then this.type = 2 else this.type = 1 end
        return this
    end,
    ---@endsection

    ---@section tick
    ---@param self SenUIButton
    ---@param ho number Height offset of the element
    ---@param available boolean
    ---@param canvas SenUICanvas
    ---@param isPointInRectangle function
    --TODO: switch to event driven actions
    tick = function(self, ho, available, canvas, isPointInRectangle)
        if self.type == 1 then --btn
            if canvas.hold then
                if available and isPointInRectangle(canvas.x-1, canvas.y + ho - canvas.scrollPixels - 1, #self.text * 5 + 3) then
                    self.clicked = not self.pressed
                    self.pressed = true
                    canvas.cooldown = 1
                end
            else
                self.pressed = false
            end
        elseif self.type == 2 then --toggle
            if available and canvas.pulse and isPointInRectangle(canvas.x-1, canvas.y + ho - canvas.scrollPixels - 1, #self.text * 5 + 20) then
                self:toggle()
            end
        end
    end,
    ---@endsection

    ---@section draw
    ---@param x number X position of the element
    ---@param y number Y position of the element
    ---@param self SenUIButton
    draw = function(self, x, y)
        SenUI.Draw.setColor(self.backgroundColor)
        local textOffset = #self.text * 5 + (self.type == 1 and 3 or 20)
        SenUI.Draw.drawRoundedRect(x, y, textOffset, 8)

        if self.type == 1 then --btn
            if self.pressed then
                screen.setColor(0, 0, 0, 200)
                SenUI.Draw.drawRoundedRect(x, y, textOffset, 8)
            end
        elseif self.type == 2 then --toggle
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
            y = y - 3
        end

        SenUI.Draw.setColor(self.textColor)
        screen.drawText(x + 2, y + 2, self.text)
    end,
    ---@endsection

    ---@section toggle
    ---@param self SenUIToggle
    toggle = function(self)
        self.state = not self.state
    end
    ---@endsection
}
---@endsection __SENUIBUTTON__