-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall

--Code by STCorp. Do not reuse.--

require("SenUI.Common.STColor")

SenUI.draw = {
    ---@section drawRoundedRect
    ---@param x number
    ---@param y number
    ---@param w number
    ---@param h number
    ---@param color table
    drawRoundedRect = function(x, y, w ,h, color)
        
        screen.drawRectF(x+1, y+1, w-1, h-1) --body
        screen.drawLine(x+2, y, x+w-1, y) --top
        screen.drawLine(x, y+2, x, y+h-1) --left
        screen.drawLine(x+w, y+2, x+w, y+h-1) --right
        screen.drawLine(x+2, y+h, x+w-1, y+h) --bottom
    end,


}