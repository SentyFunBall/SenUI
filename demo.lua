-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Workshop: 

--Code by STCorp. Do not reuse.--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "9x5")
    simulator:setProperty("ExampleNumberProperty", 123)

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.width)
        simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)

        -- NEW! button/slider options from the UI
        simulator:setInputBool(31, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
        simulator:setInputNumber(31, simulator:getSlider(1))        -- set input 31 to the value of slider 1

        simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
        simulator:setInputNumber(32, simulator:getSlider(2) * 50)   -- set input 32 to the value from slider 2 * 50
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

require("SenUI")

local bgColor = SenUI.Color.new(200,200,200)
local txColor = SenUI.Color.new(100,100,100)
local lightsCanvas = SenUI.Canvas.new(5, 5, 141, 155)
local rgbCanvas = SenUI.Canvas.new(142, 5, 141, 155)

gradientStart = SenUI.Color.new(0, 53, 169) -- Dark Blue
gradientEnd = SenUI.Color.new(215, 0, 113) -- Pinkish Red

lightsCanvas:addElement(
    SenUI.Gradient.new(
        0,
        0,
        288,
        160,
        288/2,
        false,
        gradientStart,
        gradientEnd
    )
)


local names = {
    "Yellow",
    "Teal",
    "Light Blue",
    "Red?",
    "Dark Blue",
    "Pink!"
}
for i = 1, 6 do
    lightsCanvas:addElement(
        SenUI.Toggle.new(
            false,
            names[i],
            bgColor,
            txColor
        )
    )
end

drop1 = SenUI.Dropdown.new(
    "RGB Light 1",
    {"Red", "Green", "Blue"},
    bgColor,
    txColor
)
drop2 = SenUI.Dropdown.new(
    "RGB Light 2",
    {"Cyan", "Yellow", "Purple", "White", "Black"},
    bgColor,
    txColor
)

rgbCanvas:addElement(drop1)
rgbCanvas:addElement(drop2)

local drop2Colors = {
    {0, 255, 255}, -- Cyan
    {255, 255, 0}, -- Yellow
    {255, 0, 255}, -- Purple
    {255, 255, 255}, -- White
    {0, 0, 0} -- Black
}

function onTick()
    down = input.getBool(1)
    touchX = input.getNumber(3)
    touchY = input.getNumber(4)

    lightsCanvas:processTick(touchX, touchY, down)
    rgbCanvas:processTick(touchX, touchY, down)

    if input.getBool(2) then
        lightsCanvas.elements[4]:toggle()
    end
    if input.getBool(3) then
        lightsCanvas.elements[5]:toggle()
    end

    for i = 1, 6 do
        output.setBool(i, lightsCanvas.elements[i+1].state)
    end

    if drop1.selected == 1 then
        output.setNumber(1, 1)
        output.setNumber(2, 0)
        output.setNumber(3, 0)
        drop1.backgroundColor = SenUI.Color.new(255, 0, 0)
    elseif drop1.selected == 2 then
        output.setNumber(1, 0)
        output.setNumber(2, 1)
        output.setNumber(3, 0)
        drop1.backgroundColor = SenUI.Color.new(0, 255, 0)
    elseif drop1.selected == 3 then
        output.setNumber(1, 0)
        output.setNumber(2, 0)
        output.setNumber(3, 1)
        drop1.backgroundColor = SenUI.Color.new(0, 0, 255)
    end

    local selectedColor = drop2Colors[drop2.selected]
    output.setNumber(4, selectedColor[1] / 255)
    output.setNumber(5, selectedColor[2] / 255)
    output.setNumber(6, selectedColor[3] / 255)
    drop2.backgroundColor = SenUI.Color.new(selectedColor[1], selectedColor[2], selectedColor[3])

    gradientStart = gradientStart:toHSV()
    gradientEnd = gradientEnd:toHSV()

    -- Cycle the gradient colors over time for a dynamic effect
    gradientStart.h = (gradientStart.h + 1) % 360
    gradientEnd.h = (gradientEnd.h + 1) % 360

    -- Convert back to RGB to update the gradient
    gradientStart:toRGB()
    gradientEnd:toRGB()
end

function onDraw()
    lightsCanvas:draw()
    rgbCanvas:draw()
    screen.setColor(100, 100, 100)
    screen.drawText(5, 1, "Lights")
    screen.drawText(141, 1, "RGB Lights")
end