-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

SenUI.New = function(class)
    return SenUI.Copy(class, {})
end

SenUI.Copy = function(from, to, overwrite)
    local to = to or {}
    for k, v in pairs(from) do
        to[k] = (overwrite and v) or to[k] or v --underwrites, so the original values are kept if they existed
    end
    return to
end

---@section lerp Linearly interpolates between two colors
---@param start STColor
---@param endColor STColor Color to interpolate to
---@param t number Interpolation value
---@return STColor color Interpolated color
SenUI.ColLerp = function(start, endColor, t)
    local r = start.r + (endColor.r - start.r) * t
    local g = start.g + (endColor.g - start.g) * t
    local b = start.b + (endColor.b - start.b) * t
    local a = start.a + (endColor.a - start.a) * t
    return SenUI.Color.new(r, g, b, a)
end
---@endsection