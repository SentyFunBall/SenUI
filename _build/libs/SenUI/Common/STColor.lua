-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")

---Simple class for handling colors in a clean and easy way
---@class STColor : BaseClass
---@field r number Red value
---@field g number Green value
---@field b number Blue value
---@field h number Hue value
---@field s number Saturation value
---@field v number Value value
---@field type string Type of color
SenUI.Color = {
    __c = "STColor",

    ---@section new Creates a new color object as RGB
    ---@param r number Red value
    ---@param g number Green value
    ---@param b number Blue value
    ---@overload fun(rgbTable):Color
    ---@return Color color Color object
    new = function(r, g, b)
        local this = SenUI.Common.BaseClass.new(SenUI.Color)
        if type(r) == "table" then
            this.r = r[1]
            this.g = r[2]
            this.b = r[3]
        else
            this.r = r
            this.g = g
            this.b = b
        end
        this.type = "RGB"
        return this
    end,
    ---@endsection
    
    ---@section unpack Unpacks the color object into a table
    ---@param self Color
    ---@param mode string Mode to unpack the color in
    ---@overload fun():table
    ---@return number number Unpacked color R/H
    ---@return number number Unpacked color G/S
    ---@return number number Unpacked color B/V
    open = function(self, mode)
        if mode == "flat" then
            if self.type == "HSV" then
                return self.h/360, self.s/255, self.v/255
            else
                return self.r/255, self.g/255, self.b/255
            end
        else
            if self.type == "HSV" then
                return self.h, self.s, self.v
            else
                return self.r, self.g, self.b
            end
        end
    end,
    ---@endsection

    ---@section convertToHSV Converts RGB to HSV via a table
    ---@param self Color
    ---@return Color color Color object
    convertToHSV = function(self)
        if self.type == "RGB" then
            local r, g, b = self:open("flat")
            self.r,self.g,self.b = nil,nil,nil
            local max, min, d = math.max(r, g, b), math.min(r, g, b), math.max(r, g, b) - math.min(r, g, b)
            local h, s, v = 0, (max == 0 and 0 or d / max), max
            if max ~= min then
                h = (max == r and (g - b) / d + (g < b and 6 or 0)) or (max == g and (b - r) / d + 2) or (max == b and (r - g) / d + 4)
                h = h / 6
            end
            self.h = h * 360
            self.s = s * 255
            self.v = v * 255
            self.type = "HSV"
            return self
        end
        return self
    end,
    ---@endsection
    
    ---@section converToRGB Converts HSV to RGB via a table
    ---@param self Color
    ---@return Color color Color object
    convertToRGB = function(self)
        if self.type == "HSV" then
            local h, s, v = self:open("flat")
            self.h,self.s,self.v = nil,nil,nil
            local f = h * 6 - math.floor(h * 6)
            local i, p, q, t = math.floor(h * 6), v * (1 - s), v * (1 - s * f), v * (1 - s * (1 - f))
            local r, g, b = (i == 0 and v or i == 1 and q or i == 2 and p or i == 3 and p or i == 4 and t or v), (i == 0 and t or i == 1 and v or i == 2 and v or i == 3 and q or i == 4 and p or p), (i == 0 and p or i == 1 and p or i == 2 and t or i == 3 and v or i == 4 and v or q)
            self.r = r * 255
            self.g = g * 255
            self.b = b * 255
            self.type = "RGB"
            return self
        end
        return self
    end,

    ---@section RGBtoHSV Converts RGB table to HSV table
    ---@param rgbTable table RGB table
    ---@return table hsvTable HSV table
    RGBtoHSV = function(rgbTable)
        local r, g, b = table.unpack(rgbTable)
        local max, min, d = math.max(r, g, b), math.min(r, g, b), math.max(r, g, b) - math.min(r, g, b)
        local h, s, v = 0, (max == 0 and 0 or d / max), max
        if max ~= min then
            h = (max == r and (g - b) / d + (g < b and 6 or 0)) or (max == g and (b - r) / d + 2) or (max == b and (r - g) / d + 4)
            h = h / 6
        end
        return {h * 360, s * 255, v * 255}
    end,
    ---@endsection
    
    ---@section HSVtoRGB Converts HSV table to RGB table
    ---@param hsvTable table HSV table
    ---@return table rgbTable RGB table
    HSVtoRGB = function(hsvTable)
        local h, s, v = table.unpack(hsvTable)
        local i, f, p, q, t = math.floor(h * 6), h * 6 - math.floor(h * 6), v * (1 - s), v * (1 - s * f), v * (1 - s * (1 - f))
        local r, g, b = (i == 0 and v or i == 1 and q or i == 2 and p or i == 3 and p or i == 4 and t or v), (i == 0 and t or i == 1 and v or i == 2 and v or i == 3 and q or i == 4 and p or p), (i == 0 and p or i == 1 and p or i == 2 and t or i == 3 and v or i == 4 and v or q)
        return {r * 255, g * 255, b * 255}
    end,
    ---@endsection
}