-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---Gradient class. Creates 1D gradients on the screen
---@class SenUIGradient

SenUI.Gradient = {
    ---@section new Creates an instance of a gradient
    ---@param x number X position of the gradient (Ignores automatic element placement)
    ---@param y number Y position of the gradient (Ignores automatic element placement)
    ---@param w number Width of the gradient
    ---@param h number Height of the gradient
    ---@param segments number Number of segments in the gradient
    ---@param direction boolean Direction of the gradient (false = horizontal, true = vertical)
    ---@param startColor STColor Start color of the gradient
    ---@param endColor STColor End color of the gradient
    ---@return SenUIGradient gradient Gradient element
    new = function(x, y, w, h, segments, direction, startColor, endColor)
        local this = SenUI.New(SenUI.Gradient)
        this.x = x
        this.y = y
        this.w = w
        this.h = h
        this.segments = segments
        this.direction = direction
        this.startColor = startColor
        this.endColor = endColor
        this.type = 0
        return this
    end,
    ---@endsection

    ---@section draw Draws the element onto the canvas
    ---@param self SenUIGradient
    draw = function(self)
        local segmentWidth = self.direction and self.h / self.segments or self.w / self.segments
        for i = 0, self.segments do
            --Draw either vertically or horizontally based on direction
            if self.direction then --vertical
                SenUI.DrawBase.setColor(SenUI.ColLerp(self.startColor, self.endColor, i / self.segments))
                screen.drawRectF(self.x, self.y + i * segmentWidth, self.w, segmentWidth)
            else --horizontal
                SenUI.DrawBase.setColor(SenUI.ColLerp(self.startColor, self.endColor, i / self.segments))
                screen.drawRectF(self.x + i * segmentWidth, self.y, segmentWidth, self.h)
            end
        end
    end,
    ---@endsection
}