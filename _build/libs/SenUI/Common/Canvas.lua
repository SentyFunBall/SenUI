-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

---Class to configure and manage the screen drawing
require("SenUI.Common.Base")
---@class SenUICanvas
---@field elements table<SenUIDrawble> List of elements in the canvas
---@field scrollPixels number Pixels scrolled
---@field x number X position of the canvas
---@field y number Y position of the canvas
---@field width number Height of the canvas
---@field height number Height of the canvas
---@field inUse boolean If any dropdown element is being used
---@field heightOffsets table<number> Height offsets of the elements (Internal use only)
---@field scrollable boolean If the canvas is scrollable (Internal use only)
---@field cooldown number Cooldown for the canvas elements for clicking (Internal use only)
---@section Canvas 1 __SENUICANVAS__
SenUI.Canvas = {
    ---@section new
    ---@param x? number X position of the canvas
    ---@param y? number Y position of the canvas
    ---@param width? number Width of the canvas
    ---@param height? number Height of the canvas
    ---@return SenUICanvas canvas Canvas object
    new = function(x, y, width, height)
        local this = SenUI.New(SenUI.Canvas)
        this.elements = {}
        this.scrollPixels = 0
        this.x = x or 0
        this.y = y or 0
        this.width = width or 64
        this.height = height or 64
        this.inUse = false
        this.heightOffsets = {}
        this.scrollable = false
        this.cooldown = 0
        return this
    end,
    ---@endsection

    ---@section processTick
    ---@param self SenUICanvas
    ---@param touchX number X position of the touch
    ---@param touchY number Y position of the touch
    processTick = function(self, touchX, touchY)
        local function isPointInRectangle(rx, ry, rw, rh)
            rh = rh or 9
            return touchX > rx and touchY > ry and touchX < rx + rw and touchY < ry + rh
        end

        if self.cooldown > 0 then
            self.cooldown = self.cooldown - 1
        end

        for _, element in ipairs(self.elements) do
            local isInBounds = SenUI.DrawBase.isInBounds(self, element)
            if isInBounds then
                local ho = (self.heightOffsets[_] and self.heightOffsets[_] or 0)
                local available = not self.inUse and self.cooldown == 0
                if element.type == 1 and available then -- SenUIToggle
                    --toggle if click on element (the Y and W are hell)
                    if isPointInRectangle(self.x-1, self.y + ho - self.scrollPixels-1, #element.text * 5 + 15) then
                        element:toggle()
                    end
                elseif element.type == 2 then -- SenUIDropdown
                    --open/close if click on title :thumbs_up:
                    if isPointInRectangle(self.x-1, self.y + ho - self.scrollPixels-1, #element.title * 5 + 20) then
                        element.open = not element.open
                        self.inUse = element.open
                        if not element.open then
                            self.cooldown = 1
                        end
                    end

                    if element.open then
                        for i = 1, #element.options do
                            if isPointInRectangle(self.x-1, self.y + ho - self.scrollPixels-1 + i * 8, #element.options[i] * 5 + 20) then
                                element.selected = i
                                element.open = false
                                self.inUse = false
                                self.cooldown = 1
                            end
                        end
                    end
                elseif element.type == 3 and available then -- SenUIButton
                    --click if click on element
                    if isPointInRectangle(self.x-1, self.y + ho - self.scrollPixels-1, #element.text * 5 + 15) then
                        element.clicked = element.clicked and not element.pressed
                        element.pressed = not true
                        self.cooldown = 1
                    else
                        element.pressed = false
                    end
                elseif element.type == -2 and available then --SenUIScrollbar
                    --top part
                    if isPointInRectangle(self.x-6, self.y, 6, self.height/2) then
                        self.scrollPixels = self.scrollPixels - 1
                    end
                    --bottom part
                    if isPointInRectangle(self.x-6, self.y + self.height/2, 6, self.height/2) then
                        self.scrollPixels = self.scrollPixels + 1
                    end
                end
            end
        end
    end,
    ---@endsection

    ---@section draw
    ---@param self SenUICanvas
    draw = function(self)
        local drawable = SenUI.Copy(self.elements, {}, true)
        --if any element is open, remove it from the list, shift the rest up, and add it to the end
        if self.inUse then
            for i = 1, #drawable do
                if drawable[i].open then
                    local el = drawable[i]
                    table.remove(drawable, i)
                    table.insert(drawable, el)
                    break
                end
            end
        end

        --draw elements, taking both scroll and heightOffsets into account
        for _, element in pairs(drawable) do
            local isInBounds = SenUI.DrawBase.isInBounds(self, element)
            if isInBounds then
                local ho = (self.heightOffsets[element.id] and self.heightOffsets[element.id] or 0)
                if element.type == 0 then -- SenUIGradient
                    element:draw()
                elseif element.type == 1 then -- SenUIToggle
                    element:draw(self.x, self.y + ho - self.scrollPixels)
                    if self.inUse then
                        SenUI.DrawBase.setColor(SenUI.Color.new(0, 0, 0, 200))
                        SenUI.DrawBase.drawRoundedRect(self.x, self.y + ho - self.scrollPixels, #element.text * 5 + 15, 8)
                    end
                elseif element.type == 2 then -- SenUIDropdown
                    element:draw(self.x, self.y + ho - self.scrollPixels)
                elseif element.type == 3 then -- SenUIButton
                    element:draw(self.x, self.y + ho - self.scrollPixels)
                end
            end
        end
    end,
    ---@endsection

    ---@section addElement
    ---@param self SenUICanvas
    ---@param element SenUIDrawable Element to be added
    ---@return number ID The ID of the element
    addElement = function(self, element)
        element.id = #self.elements + 1
        table.insert(self.elements, element)

        local moveableElements = {}
        for _, element in pairs(self.elements) do
            if element.type > 0 then
                table.insert(moveableElements, element)
            end
        end

        local total = 0
        self.heightOffsets = {}
        for _, element in ipairs(moveableElements) do
            if _ > 1 then
                if element.type == 1 then -- SenUIToggle
                    total = total + 11
                elseif element.type == 2 then -- SenUIDropdown
                    total = total + 11
                end
            end
            self.heightOffsets[element.id] = total
        end

        --add/remove scrollbar if needed
        if self.heightOffsets[#self.heightOffsets] > self.height then
            if not self.scrollable then
                self.sid = self:addElement(SenUI.Scrollbar.new(SenUI.Color.new(200, 200, 200)))
                self.scrollable = true
            end
        else
            if self.scrollable then
                self:removeElement(self.sid)
                self.scrollable = false
            end
        end

        return element.id
    end,
    ---@endsection

    ---@section removeElement
    ---@param self SenUICanvas
    ---@param id number ID of the element to remove
    removeElement = function(self, id)
        self.elements[id] = nil --removing like this instead of table.remove to prevent ID shifting
    end,
    ---@endsection
}
---@endsection __SENUICANVAS__