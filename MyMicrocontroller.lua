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
        simulator:setInputBool(2, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
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
color2 = SenUI.Copy(color)

canvas = SenUI.Canvas.new(5, 40)

--be sure to keep track of the elements. SenUI does, you should as well.
canvas:addElement(SenUI.Gradient.new(0, 0, 96, 96, 32, false, SenUI.Color.new(47, 51, 78), SenUI.Color.new(128, 95, 164)))
toggleId = canvas:addElement(SenUI.Toggle.new(false, "Toggle", SenUI.Color.new(200, 200, 200), SenUI.Color.new(100, 100, 100)))
canvas:addElement(SenUI.Toggle.new(false, "Toggle2", SenUI.Color.new(200, 200, 200), SenUI.Color.new(100, 100, 100)))

drop = SenUI.Dropdown.new("Dropdown", {"Option1", "Option2", "Option3"}, SenUI.Color.new(200, 200, 200), SenUI.Color.new(100, 100, 100))
dropId = canvas:addElement(drop)

canvas:addElement(SenUI.Toggle.new(false, "Toggle3", SenUI.Color.new(200, 200, 200), SenUI.Color.new(100, 100, 100)))
btn = SenUI.Button.new("Button", SenUI.Color.new(200, 200, 200), SenUI.Color.new(100, 100, 100))
btnId = canvas:addElement(btn)

function onTick()
    press = input.getBool(1) and not down
    down = input.getBool(1)
    touchX = input.getNumber(3)
    touchY = input.getNumber(4)

    if press then --Always run the processTick only during a touch.
        canvas:processTick(touchX, touchY)
    end

    -- Externally toggle an element
    externalToggle = input.getBool(2) --Assume pulse input
    if externalToggle then
        canvas.elements[toggleId]:toggle()
    end

    --Playing with colors
    if down then
        --rainbow mode
        color2 = color2:toHSV() --If you have issues with these functions, it's probably because the STColor is already in the form you're converting to
        color2.h = (color2.h + 1) % 360
        color2:toRGB()
    end
end

function onDraw()
    canvas:draw()

    --Just drawing some debug stuff
    screen.setColor(color:open())
    screen.drawRectF(20,20,10,10)

    screen.setColor(color2:open())
    screen.drawRectF(40,20,10,10)
    screen.drawText(1, 1, color2.r)

    --Demonstration on how to have regular screen drawing interact with SenUI
    textHeight = 30
    scroll = canvas.scrollPixels
    screen.drawText(0, textHeight - scroll, "Ha!")
end

