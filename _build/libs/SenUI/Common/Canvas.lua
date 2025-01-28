-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
---Class to configure and manage the screen drawing
---@class SenUICanvas
---@field addElement fun(self:SenUICanvas, element:SenUIElement) Adds an element to the canvas to be drawn
---@field draw fun(self:SenUICanvas) Draws all elements on the canvas
---@field processTick fun(self:SenUICanvas) Processes all element touch events, calling any functions and outputting any values
SenUI.Canvas = {
    ---@section new Creates a new canvas object
    ---@return Canvas canvas Canvas object
    ---@param x? number X position of the canvas
    ---@param y? number Y position of the canvas
    ---@return SenUICanvas canvas Canvas object
    new = function(x, y)
        local this = SenUI.New(SenUI.Canvas)
        this.elements = {}
        this.scrollable = 0
        this.scrollPixels = 0
        this.x = x or 0
        this.y = y or 0
        return this
    end,
    ---@endsection

    ---@section processTick Processes all element touch events, calling any functions and outputting any values
    ---@param self Canvas
    ---@param touchX number X position of the touch from screen composite input
    ---@param touchY number Y position of the touch from screen composite input
    processTick = function(self, touchX, touchY)
        local function isPointInRectangle(rx, ry, rw, rh)
            return touchX > rx and touchY > ry and touchX < rx + rw and touchY < ry + rh
        end
        for _, element in ipairs(self.elements) do
            if element.type == 1 then -- SenUIToggle
                if isPointInRectangle(self.x, self.y, #element.text * 5 + 15, 10) then
                    element:toggle()
                end
            end
        end
    end,
    ---@endsection

    ---@section draw Draws all elements on the canvas
    ---@param self Canvas
    draw = function(self)
        --add vertical offset based off each element's type
        local total = 0
        local heightOffsets = {}
        for _, element in ipairs(self.elements) do
            if element.type == 1 then -- SenUIToggle
                total = total + 11
            end
            heightOffsets[_] = total
        end
        for _, element in ipairs(self.elements) do
            element:draw(self.x, heightOffsets + self.y)
        end
    end,
    ---@endsection

    ---@section addElement Adds an element to the canvas to be drawn
    ---@param self Canvas
    ---@param element SenUIElement Element to be added
    ---@return number ID The ID of the element
    addElement = function(self, element)
        table.insert(self.elements, element)
        return #self.elements
    end,
    ---@endsection

    ---@section removeElement Removes an element from the canvas
    ---@param self Canvas
    ---@param id number ID of the element to remove
    removeElement = function(self, id)
        self.elements[id] = nil --removing like this instead of table.remove to prevent ID shifting
    end,
    ---@endsection
}