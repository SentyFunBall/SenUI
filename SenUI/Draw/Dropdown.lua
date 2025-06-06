-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---Dropdown class. Creates a dropdown with customizable text options to select from.
---@class SenUIDropdown: SenUIDrawable
---@field title string Title of the dropdown
---@field options table<string> Options to display in the dropdown. List of strings
---@field backgroundColor STColor Background color of the dropdown
---@field textColor STColor Text color of the dropdown
---@field selected number Selected option index. 1 by default
---@field open boolean If the dropdown is open or not
---@field type number Type of the element. (Internal use only)
---@field id number ID of the element. (Internal use only)
---@section Dropdown 1 __SENUIDROPDOWN__
SenUI.Dropdown = {
    ---@section new
    ---@param name string Name of the dropdown
    ---@param options table<string> Options to display in the dropdown. List of strings
    ---@param backgroundColor STColor Background color of the dropdown
    ---@param textColor STColor Text color of the dropdown
    ---@param selected? number Selected option index. 1 by default
    ---@return SenUIDropdown dropdown Dropdown element
    new = function(name, options, backgroundColor, textColor, selected)
        local this = SenUI.New(SenUI.Dropdown)
        this.title = name
        this.options = options
        this.backgroundColor = backgroundColor
        this.textColor = textColor
        this.selected = selected or 1
        this.open = false
        this.type = 3
        return this
    end,
    ---@endsection

    ---@section tick
    ---@param self SenUIDropdown
    ---@param ho number Height offset of the element
    ---@param available boolean
    ---@param canvas SenUICanvas
    ---@param isPointInRectangle function
    tick = function(self, ho, available, canvas, isPointInRectangle)
        --open/close if click on title :thumbs_up:
        if canvas.pulse then
            if isPointInRectangle(canvas.x-1, canvas.y + ho - canvas.scrollPixels - 1, #self.title * 5 + 20) then
                self.open = not self.open
                canvas.inUse = self.open
                if not self.open then
                    canvas.cooldown = 1
                end
            end

            --if open, check if click on option and select it
            if self.open then
                for i, option in ipairs(self.options) do
                    if isPointInRectangle(canvas.x-1, canvas.y + ho - canvas.scrollPixels - 1 + i * 8, #option * 5 + 20) then
                        self.selected = i
                        self.open = false
                        canvas.inUse = false
                        canvas.cooldown = 1
                        break
                    end
                end
            end
        end
    end,
    ---@endsection

    ---@section draw
    ---@param self SenUIDropdown
    draw = function(self, x, y)
        --draw background rect with height dependant on open or not (and #options)
        SenUI.Draw.setColor(self.backgroundColor)
        local width = #self.title * 5 + 15
        SenUI.Draw.drawRoundedRect(x, y, width, self.open and #self.options * 9 + 5 or 8)

        --draw static UI
        SenUI.Draw.setColor(self.textColor)
        screen.drawText(x + 9, y + 2, self.title)
        screen.drawText(x + 2, y + 2, self.open and "-" or "+")
        screen.drawLine(x + 7, y, x + 7, y + 9)

        --draw text
        if self.open then
            screen.drawLine(x, y + 8, x + width + 1, y + 8)
            for i = 1, #self.options do
                screen.drawText(x + 2, y + 2 + i * 8, self.options[i])
                if self.selected == i then
                    SenUI.Draw.setColor(SenUI.Color.new(50, 50, 50, 200))
                    screen.drawRectF(x, y + 1 + i * 8, width + 1, 7)
                    SenUI.Draw.setColor(self.textColor)
                end
            end
        end
    end
    ---@endsection
}
---@endsection __SENUIDROPDOWN__