-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")

---Simple class for handling colors in a clean and easy way
---@class Color : BaseClass
---@field r number Red value
---@field g number Green value
---@field b number Blue value
---@field h number Hue value
---@field s number Saturation value
---@field v number Value value
---@field type string Type of color
SenUI.Color = {
    ---@section new Creates a new color object as RGB
    ---@param r number Red value
    ---@param g number Green value
    ---@param b number Blue value
    ---@overload fun(rgbTable):Color
    ---@return Color color Color object
    new = function(r, g, b)
        local this = SenUI.Common.BaseClass.copy(SenUI.Color, {})
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
        this.__c = "Color"
        return this
    end,
    ---@endsection
    
    ---@section unpack Unpacks the color object into a table
    ---@param this Color
    ---@param mode string Mode to unpack the color in
    ---@overload fun():table
    ---@return number number Unpacked color R/H
    ---@return number number Unpacked color G/S
    ---@return number number Unpacked color B/V
    open = function(this, mode)
        if mode == "flat" then
            if this.type == "HSV" then
                return this.h/360, this.s/255, this.v/255
            else
                return this.r/255, this.g/255, this.b/255
            end
        else
            if this.type == "HSV" then
                return this.h, this.s, this.v
            else
                return this.r, this.g, this.b
            end
        end
    end,
    ---@endsection

    ---@section convertToHSV Converts RGB to HSV via a table
    ---@param this Color
    ---@return Color color Color object
    convertToHSV = function(this)
        local r, g, b = table.unpack(this:open("flat"))
        this.r,this.g,this.b = nil,nil,nil
        local max, min, d = math.max(r, g, b), math.min(r, g, b), math.max(r, g, b) - math.min(r, g, b)
        local h, s, v = 0, (max == 0 and 0 or d / max), max
        if max ~= min then
            h = (max == r and (g - b) / d + (g < b and 6 or 0)) or (max == g and (b - r) / d + 2) or (max == b and (r - g) / d + 4)
            h = h / 6
        end
        this.h = h * 360
        this.s = s * 255
        this.v = v * 255
        this.type = "HSV"
        return this
    end,
    ---@endsection
    
    ---@section converToRGB Converts HSV to RGB via a table
    ---@param this Color
    ---@return Color color Color object
    convertToRGB = function(this)
        local h, s, v = table.unpack(this:open("flat"))
        this.h,this.s,this.v = nil,nil,nil
        local i, f, p, q, t = math.floor(h * 6), h * 6 - math.floor(h * 6), v * (1 - s), v * (1 - s * f), v * (1 - s * (1 - f))
        local r, g, b = (i == 0 and v or i == 1 and q or i == 2 and p or i == 3 and p or i == 4 and t or v), (i == 0 and t or i == 1 and v or i == 2 and v or i == 3 and q or i == 4 and p or p), (i == 0 and p or i == 1 and p or i == 2 and t or i == 3 and v or i == 4 and v or q)
        this.r = r * 255
        this.g = g * 255
        this.b = b * 255
        this.type = "RGB"
        return this
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