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
    simulator:setScreen(1, "3x3")
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

color = SenUI.Color.new(255, 0, 0)
color2 = SenUI.Copy(color, {})

tick = 0

canvas = SenUI.Canvas.new(5, 40)
canvas:addElement(SenUI.Toggle.new(false, "Toggle", SenUI.Color.new(200, 200, 200), SenUI.Color.new(100, 100, 100)))
-- now that i think about it, if you initialize like this there's no way to access the element later, so ideally you'd store it in a variable instead

function onTick()
    color2 = color2:convertToHSV()
    if input.getBool(1) then
        --rainbow mode
        color2.h = (color2.h + 1) % 360
    end
end

function onDraw()
    screen.setColor(255,255,255)
    screen.drawText(0,0,"R:"..color.r)
    screen.drawText(0,14,"MODE:"..color.type)
    screen.drawText(30,0,"H:"..color2.h)
    screen.setColor(color:open())
    screen.drawRectF(20,20,10,10)
    screen.setColor(color2:convertToRGB():open())
    screen.drawRectF(40,20,10,10)

    canvas:draw()
end