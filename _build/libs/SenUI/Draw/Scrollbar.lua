-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall

--Code by STCorp. Do not reuse.--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---Internal scrollbar class
---@class SenUIScrollbar: SenUIDrawable
---@field color STColor Color of the scrollbar
---@field type number Type of the element. (Internal use only)
---@field id number ID of the element. (Internal use only)
---@section Scrollbar 1 __SENUISCROLLBAR__
SenUI.Scrollbar = {
    ---@section new
    ---@param color STColor Color of the scrollbar
    ---@return SenUIScrollbar button Button element
    new = function(color)
        local this = SenUI.New(SenUI.Scrollbar)
        this.color = color
        this.type = -2
        this.id = -1
        return this
    end,
    ---@endsection

    ---@section draw
    ---@param x number X position of the element
    ---@param y number Y position of the element
    ---@param height number Height of the scrollbar
    ---@param self SenUIScrollbar
    draw = function(self, x, y, height)
        SenUI.DrawBase.setColor(self.color)
        screen.drawRect(x-6, y, 6, height/2)
        screen.drawRect(x-6, y + height/2, 6, height/2)

        --up arrow
        screen.drawRectF(x-5, y + height/4+1, 5, 1)
        screen.drawRectF(x-4, y + height/4, 3, 1)
        screen.drawRectF(x-3, y + height/4-1, 1, 1)

        --down arrow
        screen.drawRectF(x-5, y + height*3/4-1, 5, 1)
        screen.drawRectF(x-4, y + height*3/4, 3, 1)
        screen.drawRectF(x-3, y + height*3/4+1, 1, 1)
    end,
    ---@endsection
}
---@endsection __SENUISCROLLBAR__