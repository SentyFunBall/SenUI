# SenUI Full Documentation

## Table o' Contents
- [Canvas](#senuicanvas)
- [Color](#senuicolor)
- [Button](#senuibutton)
- [Dropdown](#senuidropdown)
- [Gradient](#senuigradient)
- [Internal Util](#internal-utility-functions)

---
## SenUI.Canvas
The canvas is the most essential class to SenUI. It manages every element on the screen. The canvas is capable of drawing all added elements to the screen, processing touch input to interact with elements, and placing elements automatically.

### Notes
- It is recommended to set the height of the canvas to the height of the connected display.
- The canvas will automatically add a scrollbar to scroll elements if the total element height of added elements is greater than the declared height of the canvas. The automatic scrollbar is added or removed when `addElement()` or `removeElement()` are called. This behavior cannot be disabled.
- The canvas ensures that dropdowns, buttons, and toggle switches do not interfere with each other during interactions.

### Methods
- `new(x?, y?, width?, height?)` Create a new canvas.
  - **Returns:** SenUICanvas to draw and add element to.
  - **Pre-condition:** SenUI is required in the project.
  - `x` (number): X position of the upper-left corner of the canvas (default 0).
  - `y` (number): Y position of the upper-left corner of the canvas (default 0).
  - `width` (number): Width of the canvas (default: 64).
  - `height` (number): Height of the canvas (default: 64).

- `addElement(element)` Add elements to the canvas.
  - **Returns:** ID (number) of the element for later interactions and output.
  - **Pre-condition:** A SenUI Canvas is created.
  - `element` (SenUIDrawable): The element to add.

- `removeElement(id)` Remove an existing element from the canvas.
  - **Pre-condition:** There is at least 1 element on the canvas (Check with `#canvas.elements > 1`).
  - `id` (number): Id of the element to remove.

- `draw()` Draw the canvas with all elements.
  - **Pre-condition:** There is at least 1 element on the canvas (Check with `#canvas.elements > 1`)

- `processTick(touchX, touchY, touch)` Interact with elements based on touch input
  - **Pre-condition:** There is at least 1 element on the canvas (Check with `#canvas.elements > 1`).
  - `touchX` (number): X position of the touch from the monitor's composite input.
  - `touchY` (number): Y position of the touch from the monitor's composite input.
  - `touch` (boolean): Whether the screen is being touched from the monitor's composite input.

### Properties
- `elements` (table: SenUIDrawable): The table of stored elements.
- `scrollPixels` (number): The current amount of pixels scrolled vertically from 0.
- `inUse` (boolean): True if any dropdown element is opened up on the canvas. Prevents accidental interacts with other dropdowns, buttons, and toggle switches while using a dropdown.
- `heightOffsets` (table: Number): Compounded element height for vertical placement during drawing stage. Calculated on element add/remove.
- `scrollable` (boolean): Whether the canvas has a scroll bar rendered or not.
- `cooldown` (number): After an interaction, a cooldown is instantiated to prevent rapid touches (For example, clicking a toggle under a dropdown after selecting a dropdown element).
- `hold, pulse` (boolean): If the screen is being held, and the pulsed version of that

---

## SenUI.Color
Handles color creation and manipulation. All elements require `STColor` objects and will not accept raw RGB codes directly.

### Notes
- Colors can be created in RGB or HSV format.
- Colors can be converted between RGB and HSV formats using the provided methods.
- Gamma correction is applied to colors to ensure proper rendering in Stormworks.
- The `open()` method allows unpacking color values in different formats for flexibility.

### Methods
- `new(r, g, b, a?)` Creates a new color.
  - **Returns:** `STColor` object.
  - `r` (number): Red value (0-255).
  - `g` (number): Green value (0-255).
  - `b` (number): Blue value (0-255).
  - `a` (number): Alpha value (default: 255).

- `open(mode?)` Unpacks the colors values.
  - **Returns:** Either a table of values, 4 values, or 4 normalized 0-1 values in a table depending on mode. 
  - `mode` (string): `"flat"` for normalized 0-1 values, `"table"` for a table, or `nil` (don't supply) for raw values.

- `toHSV()` Converts the color to HSV format.
  - **Returns:** The updated `STColor` object.
  - **Pre-condtion:** The color is not already in HSV format. Use `color.type == 1` to check if already HSV.

- `toRGB()` Converts the color to RGB format.
  - **Returns:** The updated `STColor` object.
  - **Pre-condtion:** The color is not already in RGB format. Use `color.type == 0` to check if already RGB.

- `gammaCorrect()` Applies gamma correction to the color for Stormworks.
  - **Returns:** The updated `STColor` object.

### Properties
- `r` (number): The red value of the color (If in RGB mode, nil in HSV mode).
- `g` (number): The green value of the color (If in RGB mode, nil in HSV mode).
- `b` (number): The blue value of the color (If in RGB mode, nil in HSV mode).
- `h` (number): The hue of the color (If in HSV mode, nil in RGB mode).
- `s` (number): The saturation of the color (If in HSV mode, nil in RGB mode).
- `v` (number): The value of the color (If in HSV mode, nil in RGB mode).
- `a` (number): The alpha value of the color (Mode does not matter).
- `type` (number): Type of the color. `0` for RGB, `1` for HSV.

---

## SenUI.Button
The button class is used to create interactive buttons and toggles. Buttons can detect clicks, while toggles maintain an on/off state.

### Notes
- Buttons can be created as either standard buttons or toggles.
- Toggles maintain their state (on/off) until explicitly changed.
- Buttons and toggles require background and text colors to be specified.

### Methods
- `new(text, backgroundColor, textColor, type?, state?)` Creates a new button or toggle.
  - **Returns:** `SenUIButton` object.
  - `text` (string): Text to display on the button.
  - `backgroundColor` (STColor): Background color of the button.
  - `textColor` (STColor): Text color of the button.
  - `type?` (string): `"toggle"` to create a toggle, or omit for a standard button (default `"button"`).
  - `state` (boolean): Initial state of the toggle (default: `false`).

- `tick(ho, available, canvas, isPointInRectangle)` Updates the button state based on user interaction.
  - **Pre-condition:** The button is added to a canvas.
  - `ho` (number): Height offset of the element.
  - `available` (boolean): Whether the button is interactable.
  - `canvas` (SenUICanvas): The canvas containing the button.
  - `isPointInRectangle` (function): Function to check if a point is within the button's bounds.

- `draw(x, y)` Draws the button on the screen.
  - **Pre-condition:** The button is added to a canvas.
  - `x` (number): X position of the button.
  - `y` (number): Y position of the button.

- `toggle()` Toggles the state of a toggle button.
  - **Pre-condition:** The button is of type `"toggle"`.

### Properties
- `pressed` (boolean): If the button is actively being pressed (Button type only).
- `clicked` (boolean): When the button is pressed, this is true for a single tick.
- `id` (number): The internal ID for the element. Not really of any use.
- `state` (boolean): State of the toggle switch (Toggle type only).

---

## SenUI.Dropdown
The dropdown class is used to create interactive dropdown menus with customizable options. Dropdowns allow users to select one option from a list.

### Notes
- Dropdowns can be opened or closed by clicking on their title.
- When open, clicking on an option will select it and close the dropdown.
- Dropdowns require a title, a list of options, and background/text colors.

### Methods
- `new(name, options, backgroundColor, textColor, selected?)` Creates a new dropdown.
  - **Returns:** `SenUIDropdown` object.
  - `name` (string): Title of the dropdown.
  - `options` (table: string): List of options to display in the dropdown.
  - `backgroundColor` (STColor): Background color of the dropdown.
  - `textColor` (STColor): Text color of the dropdown.
  - `selected?` (number): Index of the initially selected option (default: `1`).

- `tick(ho, available, canvas, isPointInRectangle)` Updates the dropdown state based on user interaction.
  - **Pre-condition:** The dropdown is added to a canvas.
  - `ho` (number): Height offset of the element.
  - `available` (boolean): Whether the dropdown is interactable.
  - `canvas` (SenUICanvas): The canvas containing the dropdown.
  - `isPointInRectangle` (function): Function to check if a point is within the dropdown's bounds.

- `draw(x, y)` Draws the dropdown on the screen.
  - **Pre-condition:** The dropdown is added to a canvas.
  - `x` (number): X position of the dropdown.
  - `y` (number): Y position of the dropdown.

### Properties
- `title` (string): Title of the dropdown.
- `options` (table: string): List of options in the dropdown.
- `backgroundColor` (STColor): Background color of the dropdown.
- `textColor` (STColor): Text color of the dropdown.
- `selected` (number): Index of the currently selected option.
- `open` (boolean): Whether the dropdown is currently open.
- `id` (number): The internal ID for the element. Not really of any use.

---

## SenUI.Gradient
The gradient class is used to create 1D gradients on the screen. Gradients can be horizontal or vertical and are customizable with start and end colors.

### Notes
- Gradients are drawn as a series of segments, with colors interpolated between the start and end colors.### Methods
- Gradients ignore automatic element placement and require explicit positioning.

### Methods
- `new(x, y, w, h, segments, direction, startColor, endColor)` Creates a new gradient.
  - **Returns:** `SenUIGradient` object.
  - `x` (number): X position of the gradient. Note this **IGNORES** the canvas coordinates, and are screen coordinates instead.
  - `y` (number): Y position of the gradient. Note this **IGNORES** the canvas coordinates, and are screen coordinates instead.
  - `w` (number): Width of the gradient.
  - `h` (number): Height of the gradient.
  - `segments` (number): Number of segments in the gradient.
  - `direction` (boolean): Direction of the gradient (`false` for horizontal, `true` for vertical).
  - `startColor` (STColor): Start color of the gradient.
  - `endColor` (STColor): End color of the gradient.
  - `draw()` Draws the gradient on the screen.
  - **Pre-condition:** The gradient is properly initialized.

### Properties
- `x` (number): X position of the gradient.
- `y` (number): Y position of the gradient.
- `w` (number): Width of the gradient.
- `h` (number): Height of the gradient.
- `segments` (number): Number of segments in the gradient.
- `direction` (boolean): Direction of the gradient (`false` for horizontal, `true` for vertical).
- `startColor` (STColor): Start color of the gradient.
- `endColor` (STColor): End color of the gradient.
- `id` (number): The internal ID for the element. Not really of any use.

---

## Internal Utility Functions
These are helper functions used internally by SenUI to perform common operations such as object creation, copying, and color interpolation.

### Notes
- These functions are not meant to be used directly by the user.
- They provide essential functionality for the framework's internal operations.

### Methods
- `New(class)` Creates a new instance of a class.
  - **Returns:** A new instance of the specified class.
  - `class` (table): The class to create an instance of.

- `Copy(from, to?, overwrite?)` Copies the contents of one table to another.
  - **Returns:** The destination table with copied values.
  - `from` (table): The table to copy from.
  - `to?` (table): The table to copy to (optional, creates a new table if not provided).
  - `overwrite?` (boolean): Whether to overwrite existing values in the destination table (default: `false`).

- `ColLerp(start, endColor, t)` Interpolates between two colors.
  - **Returns:** An interpolated `STColor` object.
  - `start` (STColor): The starting color.
  - `endColor` (STColor): The ending color.
  - `t` (number): The interpolation value (0-1).

---

<sub>Disclaimer: This SenUI docs.md file was primarily generated by GitHub Copilot AI. The information is still however accurate and reviewed and revised by a human (me, Senty).</sub>