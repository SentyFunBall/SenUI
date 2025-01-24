-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

---Global class for all SenUI classes to inherit from
---@class BaseClass
SenUI.Common.BaseClass = {
    ---@section typeof Returns the type of the object
    ---@param this BaseClass
    ---@return string type Type of the object
    typeof = function(this)
        return this.__c
    end,
    ---@endsection

    ---@section copy Copies data from (from) to (to)
    ---@param from BaseClass
    ---@param to any destination to copy into
    ---@return table to Destination table
    copy = function(from, to)
        for k, v in pairs(from) do
            to[k] = v
        end
        return to
    end,
    ---@endsection

    ---@section length Returns the length of the object
    ---@param this BaseClass
    ---@return number length Length of the object
    length = function(this, recursive)
        local count = 0
        for _ in pairs(this) do
            count = count + 1
            if recursive then
                count = count + this:length(true)
            end
        end
        return count
    end,
    ---@endsection
}