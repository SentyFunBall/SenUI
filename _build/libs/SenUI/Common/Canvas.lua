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
---@field hold boolean If screen is currently being held (Internal use only)
---@field pulse boolean If the screen was pulsed (Internal use only)
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
        this.hold = false
        this.pulse = false
        return this
    end,
    ---@endsection

    ---@section processTick
    ---@param self SenUICanvas
    ---@param touchX number X position of the touch
    ---@param touchY number Y position of the touch
    ---@param touch boolean If the screen is being touched
    processTick = function(self, touchX, touchY, touch) --this is a hellish function that I wish I could simplify
        self.pulse = touch and not self.hold
        self.hold = touch
        self.cooldown = math.max(self.cooldown - 1, 0) --cooldown for the canvas elements for clicking (yes I know table lookups are slow but I don't care)

        local function isPointInRectangle(rx, ry, rw, rh)
            return touchX > rx and touchY > ry and touchX < rx + rw and touchY < ry + (rh and rh or 9)
        end

        --pulse elements (toggle, dropdown)
        if self.pulse then
            for _, element in ipairs(self.elements) do
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
                end
            end
        end

        --hold elements
        if touch then
            for _, element in ipairs(self.elements) do
                local ho = (self.heightOffsets[_] and self.heightOffsets[_] or 0)
                local available = not self.inUse and self.cooldown == 0
                if available then
                    if element.type == 3 then -- SenUIButton
                        --click if click on element
                        if isPointInRectangle(self.x-1, self.y + ho - self.scrollPixels-1, #element.text * 5 + 15) then
                            element.clicked = not element.pressed
                            element.pressed = true
                            self.cooldown = 1
                        end
                    elseif element.type == -2 then --SenUIScrollbar
                        --top part
                        if isPointInRectangle(self.x+self.width-7, self.y, 8, self.height/2+1) then
                            self.scrollPixels = self.scrollPixels - (self.scrollPixels > 0 and 1 or 0)
                            element.up = true
                        end
                        --bottom part
                        if isPointInRectangle(self.x+self.width-7, self.y + self.height/2, 8, self.height/2+1) then
                            self.scrollPixels = self.scrollPixels + (self.scrollPixels < self.heightOffsets[#self.heightOffsets] and 1 or 0)
                            element.down = true
                        end
                    end
                end
            end
        end

        --release elements
        if not touch then
            for _, element in pairs(self.elements) do
                if element.type == -2 then --SenUIScollbar
                    element.up = false
                    element.down = false
                elseif element.type == 3 then -- SenUIButton
                    element.pressed = false
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
            for i, element in pairs(drawable) do
                if element.open then
                    table.remove(drawable, i)
                    table.insert(drawable, element)
                    break
                end
            end
        end

        --draw elements, taking both scroll and heightOffsets into account
        for _, element in pairs(drawable) do
            local ho = (self.heightOffsets[element.id] and self.heightOffsets[element.id] or 0)
            local y = self.y + ho - self.scrollPixels
            SenUI.drawElement(self, element, self.x, y)
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

        --get height offsets. elements with types < 0 are not subject to moving
        local total = 0
        self.heightOffsets = {}
        for _, element in ipairs(self.elements) do
            if element.type > 0 then
                total = total + 11
                self.heightOffsets[element.id] = total
            end
        end

        --add scrollbar if needed
        if #self.heightOffsets > 1 and self.heightOffsets[#self.heightOffsets] + 11 > self.height then
            if not self.scrollable then
                self.scrollable = true
                self.sid = self:addElement(SenUI.Scrollbar.new(SenUI.Color.new(200, 200, 200)))
            end
        else
            if self.scrollable then
                self.elements[self.sid] = nil
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