-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

---Global class for all SenUI classes to inherit from
---@class BaseClass
SenUI.Common.BaseClass = {
    ---@section new Creates a new object
    ---@param class object Class to create an object of
    ---@return object object New object
    new = function(class)
        --copy both the provided class and baseclass into this and return this
        local this = {}
        this = SenUI.Common.BaseClass.copy(this, SenUI.Common.BaseClass)
        this = SenUI.Common.BaseClass.copy(this, class)
        this.__c = class.__c
        return this
    end,
    ---@endsection

    ---@section typeof Returns the type of the object
    ---@param self BaseClass
    ---@return string type Type of the object
    typeof = function(self)
        return self.__c
    end,
    ---@endsection

    ---@section copy Copies data from (from) to (to)
    ---@param self BaseClass
    ---@param to? any destination to copy into
    ---@return table to Destination table
    copy = function(self, to)
        to = to or {}
        for k, v in pairs(self) do
            to[k] = v
        end
        return to
    end,
    ---@endsection

    ---@section length Returns the length of the object
    ---@param self BaseClass
    ---@return number length Length of the object
    length = function(self, recursive)
        local count = 0
        for _ in pairs(self) do
            count = count + 1
            if recursive then
                count = count + self:length(true)
            end
        end
        return count
    end,
    ---@endsection
}