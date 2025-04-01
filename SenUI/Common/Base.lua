-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

---@section New
---@param class table Class to create
---@return table Class object
SenUI.New = function(class)
    local newClass = SenUI.Copy(class)
    newClass.new = nil
    return newClass
end
---@endsection

---@section Copy
---@param from table Table to copy from
---@param to? table Table to copy to
---@param overwrite? boolean If true, will overwrite existing values in the to table
SenUI.Copy = function(from, to, overwrite)
    local to = to or {}
    for k, v in pairs(from) do
        to[k] = (overwrite and v) or to[k] or v --underwrites, so the original values are kept if they existed
    end
    return to
end
---@endsection

---@section ColLerp
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