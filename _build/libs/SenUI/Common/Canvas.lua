-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")

---Class to configure and manage the screen drawing
---@class SenUICanvas
---@field elements table Elements to be drawn on the canvas
---@field addElement fun(self:SenUICanvas, element:SenUIElement) Adds an element to the canvas to be drawn
---@field draw fun(self:SenUICanvas) Draws all elements on the canvas
---@field processTick fun(self:SenUICanvas) Processes all element touch events, calling any functions and outputting any values
SenUI.Canvas = {
    elements = {},
    scrollable = 0,
    scrollPixels = 0,

    ---@section new Creates a new canvas object
    ---@return Canvas canvas Canvas object
    new = function()
        local this = SenUI.New(SenUI.Canvas)
        return this
    end,
    ---@endsection

    ---@section processTick Processes all element touch events, calling any functions and outputting any values
    ---@param self Canvas
    processTick = function(self)
        
    end,
    ---@endsection
    
    ---@section draw Draws all elements on the canvas
    ---@param self Canvas
    draw = function(self)
        for _, element in ipairs(self.elements) do
            element:draw(15, 40)
        end
    end,
    ---@endsection

    ---@section addElement Adds an element to the canvas to be drawn
    ---@param self Canvas
    ---@param element SenUIElement Element to be added
    addElement = function(self, element)
        table.insert(self.elements, element)
    end
    ---@endsection
}