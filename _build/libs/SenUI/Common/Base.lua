-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)

--Code by STCorp. Do not reuse.--

SenUI.New = function(class)
    --copy both the provided class and baseclass into this and return this
    local this = {}
    this = SenUI.Copy(class, this)
    this.__c = class.__c
    return this
end

SenUI.Copy = function(from, to, overwrite)
    local to = to or {}
    for k, v in pairs(from) do
        to[k] = (overwrite and v) or to[k] or v --underwrites, so the original values are kept if they existed
    end
    return to
end
