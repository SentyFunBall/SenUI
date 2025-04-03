# SenUI: A revolutionary new UI framework for Stormworks
## The Power of Simplicity
SenUI is a lighweight, simple and easy to use object-oriented (If you don't know what that means, don't worry about it) UI library and framework designed to make creating sophisticated and interactive displays with complex elements significantly easier in Stormworks Lua. Instead of having to manually draw every screen component with `screen.draw*`, SenUI makes this incredibly easy with just a handful of lines of object-oriented code. SenUI empowers you to create clean, responsive, and consistent UIs while keeping your code readable and small.

SenUI features several impressive UI elements at first, Push buttons, Toggle switches, and Dropdown menus, with Sliders, Checkboxes, Progress bars, Animations, and more planned. SenUI is powerful and efficient, drawing as few shapes to the screen as possible to maintain incredibly high performance with complex displays.

![SenUI with a simple demo including buttons, toggle switches, a gradient, and dropdowns](/imgs/20250403141725_1.jpg)

For detailed documentation on each function and information on how SenUI works, click [here](https://github.com/sentyfunball/senui/tree/main/docs.md).

A changelog is also availble [here](https://github.com/sentyfunball/senui/tree/main/changelog.md).

---

## Quick Start
Getting SenUI in a ready-to-use state is as easy as four simple steps:
### 1. Import SenUI
1. In Visual Studio Code after instaling the LifeBoatAPI extension, click `File -> New File...` and create a new Microcontroller Project. Place the project anywhere on your computer.
2. Go to the releases tab (or click [here](https://github.com/sentyfunball/senui/releases/), download the latest version of SenUI.zip (Currently SenUI-v1.0.zip), extract it, and copy the enclosing SenUI folder into your project's `_build/lips` folder. Altnative option: download and unzip this repository by clicking the `<> Code` button near the top, and copy the `SenUI` folder inside the unzipped folder into your project's `_build/libs` folder. Either way, the project structure should look like this:
    ```
    project/
    `-- _build/
    |   `-- libs/
    |       `-- LifeBoatAPI/
    |       `-- SenUI/
    `-- MyMicrocontroller.lua
    ```

3. From there in `MyMicrocontroller.lua`, add the following code snippet above the `onTick()` function:

	```lua
	require("SenUI")
    ```
### 2. Create Canvas
1. After importing the library, the next step is to use it. The main structure of SenUI is Canvases, which store elements. The Canvas will automatically manage elements, element placement, element touch management, and element drawing. To create one is as simple as writing the following near the top of the code:

    ```lua
    myCanvas = SenUI.Canvas.new(x, y, width, height)
    ```

2. The parameters (all optional) include:
    1. `x` - The X coordinate of the Canvas. Will place all elements starting at this upper-left corner. Screen space (Top left of the screen is (0,0)).
    2. `y` - The Y coordinate of the Canvas. Will place all elements starting at this upper-left corner. Screen space (Top left of the screen is (0,0)).
    3. `width` - The width of the Canvas. It is recommened to make it at least as wide as the elements, or just as wide as the screen.
    4. `height` - Height of the canvas. Recommended to make it as high as the screen, scrolling may not function correctly otherwise.

3. Other examples of creating a Canvas:

    ```lua
    myCanvas = SenUI.Canvas.new()

    myCanvas = SenUI.Canvas.new(1, 1, 288, 160)

    myCanvas = SenUI.Canvas.new(32, 1)
    ```

4. And the full code should now look something like this:

    ```lua
    require("SenUI")

    myCanvas = SenUI.Canvas.new()

    function onTick()
        --code
    end
    ```

### 3. Create Colors & Elements
1. Add buttons, dropdowns, toggle switches, and more:

    ```lua
    --Create colors
    backgroundColor = SenUI.Color.new(100, 100, 100) --R, G, B, and optional Alpha
    textColor = SenUI.Color.new(50, 50, 50)

    --Create elements
    myToggleSwitch = SenUI.Button.new("Lightswitch", backgroundColor, textColor, "toggle", true)
    myPushButton = SenUI.Button.new("Push me!", backgroundColor. textColor) --Defaults to push buttons

    --Add elements
    toggleID = myCanvas:addElement(myToggleSwitch) --This function returns an ID which can be used to keep track of elements
    buttonID = myCanvas:addElement(myPushButton)
    ```

### 4. Use Elements
1. Process the touch inputs and draw the Elements:

    ```lua
    function onTick()
        --Get monitor inputs
        press = input.getBool(1)
        touchX = input.getNumber(3)
        touchY = input.getNumber(4)

        --Ask the Canvas to process touch inputs
        myCanvas:processTick(touchX, touchY, press)
        
        --Output states of buttons and toggles
        output.setBool(1, myToggleSwitch.state)
        output.setBool(2, myPushButton.pressed)
    end

    function onDraw()
        --Draw all elements
        myCanvas:draw()
    end
    ```

2. Drawing and processing elements with SenUI is as simple as writing a few lines of code.

---
## Contributing & Issues
SenUI, being a free and open source code library, is free for contributing to as well. If you'd like to contribute to SenUI, please fork the repository, make any changes yourself, and create a [pull request](https://github.com/SentyFunBall/SenUI/pulls). Changes may or may not be accepted and merged in an update.

If you discover an issue in SenUI, you are encouraged to report it with the [Issues](https://github.com/sentyfunball/senui/issues) tab above.

SenUI is licenced under the 