-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

require("SenUI.Common.Base")
require("SenUI.Common.DrawBase")

---Dropdown class. Creates a dropdown with customizable text options to select from.
---@class SenUIDropdown

SenUI.Dropdown = {
    ---@section new Creates a new dropdown element
    ---@param name string Name of the dropdown
    ---@param options table<string> Options to display in the dropdown. List of strings
    ---@param backgroundColor STColor Background color of the dropdown
    ---@param textColor STColor Text color of the dropdown
    ---@return SenUIDropdown dropdown Dropdown element
    new = function(name, options, backgroundColor, textColor)
        local this = SenUI.New(SenUI.Dropdown)
        this.name = name
        this.options = options
        this.backgroundColor = backgroundColor
        this.textColor = textColor
        this.type = 2
        return this
    end,
    ---@endsection

    ---@section draw Draws the element onto the canvas
    ---@param self SenUIDropdown
    draw = function(self, x, y)
        
    end,
    ---@endsection
}