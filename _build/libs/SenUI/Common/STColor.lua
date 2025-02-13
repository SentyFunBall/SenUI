-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")

---Simple class for handling colors in a clean and easy way
---@class STColor
---@field r number Red value
---@field g number Green value
---@field b number Blue value
---@field a number Alpha value
---@field h number Hue value
---@field s number Saturation value
---@field v number Value value
---@field type string Type of color
SenUI.Color = {
    ---@section new Creates a new color object as RGB
    ---@param r number Red value
    ---@param g number Green value
    ---@param b number Blue value
    ---@overload fun(rgb:table):STColor
    ---@overload fun(r:number, g:number, b:number, a:number):STColor
    ---@overload fun(rgba:table):STColor
    ---@return STColor color Color object
    new = function(r, g, b, a)
        local this = SenUI.New(SenUI.Color)
        if type(r) == "table" then
            this.r, this.g, this.b, this.a = r[1], r[2], r[3], r[4] or 255
        else
            this.r, this.g, this.b, this.a = r, g, b, a or 255
        end
        this.type = 0
        return this
    end,
    ---@endsection

    ---@section unpack Unpacks the color object into a table
    ---@param self STColor
    ---@param mode string Mode to unpack the color in: flat - returns the color in 0-1 range (returns 4 values), table - returns the color as a table
    ---@overload fun():table
    ---@return number number Unpacked color R/H
    ---@return number number Unpacked color G/S
    ---@return number number Unpacked color B/V
    ---@return number number Unpacked color A
    open = function(self, mode)
        if mode == "flat" then
            if self.type > 0 then
                return self.h/360, self.s/255, self.v/255, self.a/255
            else
                return self.r/255, self.g/255, self.b/255, self.a/255
            end
        elseif mode == "table" then
            if self.type > 0 then
                return {self.h, self.s, self.v, self.a}
            else
                return {self.r, self.g, self.b, self.a}
            end
        else
            if self.type > 0 then
                return self.h, self.s, self.v, self.a
            else
                return self.r, self.g, self.b, self.a
            end
        end
    end,
    ---@endsection

    ---@section convertToHSV Converts RGB to HSV via a table
    ---@param self STColor
    ---@return STColor color Color object
    convertToHSV = function(self)
        local r, g, b, a = self:open("flat")
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
        self.a = a * 255
        self.type = 1
        return self
    end,
    ---@endsection

    ---@section converToRGB Converts HSV to RGB via a table
    ---@param self STColor
    ---@return STColor color Color object
    convertToRGB = function(self)
        local h, s, v, a = self:open("flat")
        self.h,self.s,self.v = nil,nil,nil
        local f = h * 6 - math.floor(h * 6)
        local i, p, q, t = math.floor(h * 6), v * (1 - s), v * (1 - s * f), v * (1 - s * (1 - f))
        local r, g, b = (i == 0 and v or i == 1 and q or i == 2 and p or i == 3 and p or i == 4 and t or v), (i == 0 and t or i == 1 and v or i == 2 and v or i == 3 and q or i == 4 and p or p), (i == 0 and p or i == 1 and p or i == 2 and t or i == 3 and v or i == 4 and v or q)
        self.r = r * 255
        self.g = g * 255
        self.b = b * 255
        self.a = a * 255
        self.type = 0
        return self
    end,
    ---@endsection

    ---@section gammaCorrect Gamma corrects the color for Stormworks terrible gamma
    ---@param self STColor
    ---@return STColor color Color object
    gammaCorrect= function(self)
        local _ = {}
        _=self:open("table")
        for i in pairs(_) do
            _[i]=_[i]^2.2/255^2.2*_[i]
        end
        return SenUI.Color.new(_)
    end,
    ---@endsection
}