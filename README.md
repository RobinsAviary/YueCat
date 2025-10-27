# YueCat

# About

YueCat is a software development framework, largely focused on games. It allows you to create software entirely without an editor using a flavor of Lua called [YueScript](https://yuescript.org/).

The API largely mirrors [raylib](https://www.raylib.com/)'s, with some key differences to make typing simpler.

# Table of Contents

[📜 Documentation](#documentation)

1. [🔢 Version Info](#version-info)
2. [💬 A Note on "Typing"](#a-note-on-typing)
3. [🔑 License](#license)
4. [🔴 OOP?](#oop)
5. [月 YueScript (Scripting)](#月-yuescript-scripting)
6. [🔨 Building](#building)
7. [⚙️ Config](#config)
8. [🤙 Callbacks](#callbacks)
    1. [🚂 Engine](#engine)
    2. [🎮 Controller](#controller)
9. [🔌 Functions](#functions)
    1. [🚂 Engine](#engine-1)
    2. [📥 Input]()
        1. [🐭 Mouse](#mouse)
            1. [Mouse.Button](#mousebutton)
        2. [⌨️ Keyboard](#keyboard)
            1. [Keyboard.Key](#keyboardkey)
        3. [🎮 Controller](#controller-1)
            1. [Controller.Button](#controllerbutton)
            2. [Controller.Axis](#controlleraxis)
            3. [Controller.Vector](#controllervector)
    3. [🎞️ Rendering](#rendering)
        1. [🖌️ Draw](#draw)
        2. [🖼️ Texture](#texture)
    4. [🎧 Sound](#sound)
        1. [🔊 Audio](#audio)
10. [🏗️ "Structs"](#structs)
    1. [➡️ Vectors](#vectors)
        1. [2️⃣ Vector2](#vector2)
            1. [Constants](#constants)
        2. [3️⃣ Vector3](#vector3)
            1. [Constants](#constants-1)
    2. [🌈 Colors](#colors)
        1. [🎨 Color](#color)
            1. [Constants](#constants-2)
        2. [🎨🤖 ColorHSV](#colorhsv)
    3. [🔷 Shapes](#shapes)
        1. [🟥🔵 2D](#2d)
            1. [🟥 Rectangle](#rectangle)
            2. [🔵 Circle](#circle)
            3. [📐 Triangle](#triangle)
        2. [🧊🛢️ 3D](#3d)
            1. [🧊 Cube](#cube)
            2. [📦 Box](#box)
            3. [🔮 Sphere](#sphere)
            4. [🛢️ Cylinder](#cylinder)
            5. [🔺 Triangle3D](#triangle3d)
    4. [🎥 Cameras](#cameras)
        1. [🟥🔵 2D](#2d-1)
            1. [🎥🟥 Camera2D](#camera2d)
        2. [🧊🛢️ 3D](#3d-1)
            1. [🎥🧱 Camera3D](#camera3d)

# 📜 Documentation

# 🔢 Version Info

YueCat Alpha

YueScript v0.29.4

Lua 5.4

raylib 5.5

SDL2 (Controllers only)

Odin dev-2025-10-nightly:7237747

# 💬 A Note on "Typing"

When I use the phrase "typing" or "making typing simpler" or something like that, I'm referring to reducing the number of keys the user needs to press in order to program the thing they want. I have hand pain problems, so being able to code as much as possible is important to me. I hope these considerations will be useful to you as well.

# 🔑 License

YueCat is free and open source. It can be used for commerical and non-commerical purposes. It is licensed under the [zlib license](https://codeberg.org/RobinsAviary/YueCat/src/branch/main/LICENSE.md).

# 🔴 OOP?

YueCat does not use any built-in OOP (though YueScript does provide basic classes), as it instead opts to largely mirror Odin's style of separating procedures and data. Basically, this is a mix of functional and procedural programming, to keep the implementation (and typing) relatively simple.

For those still curious, here is an example of how converting a color would work in OOP:

`hsv = Color.White.ToHSV()`

Again, though, YueCat is designed with procedural programming in mind, so this would end up looking like:

`hsv = Color.ToHSV(Color.White)`

# 月 YueScript (Scripting)

YueCat uses [YueScript](https://yuescript.org/) for compiling scripts before running. It is a flavor of MoonScript that compiles down to [Lua](https://www.lua.org/).

Here is the [documentation](https://yuescript.org/doc/). **Fair warning:** the overview on the site makes it look a lot more complicated than it actually is. The gist is that it makes all variables local (generally considered best practice nowadays) and provides a much cleaner syntax for... well, everything.

Assuming there are no major breaking changes, upgrading to a newer version of YueScript should be as simple as replacing the one in `vendor/`.

# 🔨 Building

YueCat has no external dependencies, as it uses bindings actively maintained by the Odin language, which are built-in with the compiler. As such, compiling and modifying YueCat is trivial.

Simply open the main directory and execute `odin build .`, which will compile the host program. In order to run your code, place a file named "main.lua" in the base directory. Use the various engine callbacks to implement the functionality you need.

This repo also includes .vscode tasks to build and run the current version, for testing.

# ⚙️ Config

Define this global table during the "Ready" callback to modify how YueCat launches.

## Fields

```
Config = {
    Window = {
        size: Vector2 = Vector2.New(640, 480),
        title: string = "YueCat <version>",

        Flags = {
            msaa = false, -- Antialiasing
            borderless = false, -- Undecorated window
            topmost = false, -- Window always stays on top
            resizable = false, -- Window is resizable
            vsync = false, -- Vsync
        }
    }

    Audio = {
        active: bool = true,
    }
}
```

# 🤙 Callbacks

Callbacks are functions that you redefine in order to run your own custom behavior. They are listed in order, from initialization, to main loop, to cleanup.

## 🚂 Engine

`Engine.Init()`

Called immediately after the program is started, but before the window is created (as such, be sure to load assets in `Ready()` instead).

Used to modify the Config table.

`Engine.Ready()`

Called immediately after the window is created.

Load assets here.

`Engine.Step()`

Called during the main loop.

Update your program state here, moving objects/otherwise.

`Engine.Draw()`

Called during the main loop.

Draw your program state here.

`Engine.Cleanup()`

Called after the main loop has finished, but just before the program is closed.

Unload your assets here.

## 🎮 Controller

`Controller.Connected(controller: Controller)`

Called when a controller connects. Store the value passed in order to read the controller.

`Controller.Disconnected(index)`

Called when a controller disconnects. Compare the index to any controllers you're tracking with `controller.index == index`.

# 🔌 Functions

These are global tables of functions.

## 🚂 Engine

`Engine.GetTime() -> (timeSinceStart: number)`

`Engine.GetDelta() -> (deltaTime: number)`

`Engine.GetFPS() -> (currentFps: integer)`

`Engine.SetFPSTarget(target: integer)` 

(Unlimited by default)

## 📥 Input

### 🐭 Mouse

`Mouse.GetPosition() -> (mousePosition: Vector2)`

Get the position of the cursor.

`Mouse.GetX() -> (xPosition: integer)`

Get the x position of the cursor.

`Mouse.GetY() -> (yPosition: integer)`

Get the y position of the cursor.

`Mouse.SetX(xPosition: integer)`

Set the x position of the cursor.

`Mouse.SetY(yPostion: integer)`

Set the y position of the cursor.

`Mouse.SetPosition(position: Vector2)`

Set the position of the cursor.

`Mouse.IsButtonPressed(index: Integer = 0) -> boolean`

Checks if the button was just pressed this frame.

`Mouse.IsButtonHeld(index: Integer = 0) -> boolean`

Checks if the button is held down.

`Mouse.IsButtonReleased(index: Integer = 0) -> boolean`

Checks if the button was just released this frame.

`Mouse.IsOnScreen() -> boolean`

#### Mouse.Button

```
Mouse.Left = 0
Mouse.Right = 1
Mouse.Middle = 2
```

### ⌨️ Keyboard

`Keyboard.IsKeyHeld(key: Keyboard.Key) -> boolean`

`Keyboard.IsKeyPressed(key: Keyboard.Key) -> boolean`

`Keyboard.IsKeyReleased(key: Keyboard.Key) -> boolean`

#### Keyboard.Key
```
Null (No key / invalid)
Apostrophe,
Comma,
Minus,
Period,
Slash,
Zero,
One,
Two,
Three,
Four,
Five,
Six,
Seven,
Eight,
Nine,
Semicolon,
Equal,
A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
LeftBracket,
BackSlash,
RightBracket,
Grave,
Space,
Escape,
Enter,
Tab,
Backspace,
Insert,
Delete,
Right,
Left,
Down,
Up,
PageUp,
PageDown,
Home,
End,
CapsLock,
ScrollLock,
NumLock,
PrintScreen,
Pause,
F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12,
LeftShift,
LeftControl,
LeftAlt,
LeftSuper,
RightShift,
RightControl,
RightAlt,
RightSuper,
KBMenu,
Keypad = {
    Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine,
    Decimal,
    Divide, Multiply, Subtract, Add,
    Enter,
    Equal
},
Button = {
    Back,
    Menu
}
```

### 🎮 Controller

[SDL2](https://www.libsdl.org/) is used as an underlying base for the controller system. As such, all programs support rebinding with Steam and other various community-made tools, and almost every controller ([over two-thousand](https://github.com/mdqinc/SDL_GameControllerDB/blob/master/gamecontrollerdb.txt)) will accurate map button names/bindings properly to the simple API.

In order to access information about a controller, you'll need to catch it's "connected" callback and store the passed `Controller`. Then pass that into any functions that you need, and when a controller is disconnected, you can check if it's the same controller by doing `controller.index = index` in the "disconnected" callback.

Attempting to read from an index with no connected gamepad will simply return zero-values (`false`, `0`, etc).

`Controller.IsButtonHeld(controller: Controller, button: Controller.Button) -> (isHeld: boolean)`

Checks if a button is held down on a controller.

`Controller.IsButtonPressed(controller: Controller, button: Controller.Button) -> (isPressed: boolean)`

Checks if a button was just pressed this frame.

`Controller.IsButtonReleased(controller: Controller, button: Controller.Button) -> (isReleased: boolean)`

Checks if a button was just released this frame.

`Controller.GetAxis(controller: Controller, axis: Controller.Axis) -> (axis: number)`

Get the current value of a particular axis on a controller.

`Controller.GetVector(controller: Controller, axis: Controller.Vector) -> (vector: Vector2)`

Get the current value of a vector on a controller.

`Controller.GetName(controller: Controller) -> (name: string)`

Get the internal name of a controller. Marginally useful for identifying specific controllers.

#### Controller.Button

```
A, B, X, Y,
Back,
Guide,
Start,
LeftStick, RightStick,
LeftShoulder,
RightShoulder,
DPad = {
    Up,
    Down,
    Left,
    Right
}
Misc1,
Paddle1,
Paddle2,
Paddle3,
Paddle4,
Touchpad
```

#### Controller.Axis

```
Left,
Right,
Trigger = {
    Left,
    Right
}
```

#### Controller.Vector

```
DPad,
Left,
Right
```

## 🎞️ Rendering

### 🖌️ Draw

`Draw.Clear(color: Color)`

Clear the entire screen to a single color.

It is suggested to call this first in most programs, before you draw anything else. Otherwise, graphics from previous frames will stick around (think out-of-bounds in Source games). You can also recreate this behavior by using a full-screen rectangle.

`Draw.Line(startPosition: Vector2, endPosition: Vector2, color: Color)`

`Draw.Rectangle(rectangle: Rectangle, color: Color)`

`Draw.Circle(circle: Circle, color: Color)`

`Draw.Triangle(triangle: Triangle, color: Color)`

`Draw.Texture(texture: Texture, postion: Vector2 = Vector2.Zero, tint: Color = Color.White)`

`Draw.Begin3D(camera: Camera3D)`

`Draw.End3D()`

`Draw.Cube(cube: Cube, color: Color)`

`Draw.Box(box: Box, color: Color)`

`Draw.Sphere(sphere: Sphere, color: Color)`

`Draw.Cylinder(cylinder: Cylinder, color: Color)`

### 🖼️ Texture

`Texture.Load(fileName: string) -> Texture`

`Texture.Unload(texture: Texture)`

## 🎧 Sound

### 🔊 Audio
`Texture.Load(fileName: string) -> Audio`

`Texture.Unload(audio: Audio)`

# 🏗️ "Structs"

Constructor example:
```
vec = Vector2.New(5, 4)
```

## ➡️ Vectors

### 2️⃣ Vector2

Fields:
```
x: number = 0
y: number = x or 0
```

Supports math operations and length (`#`) operator.

#### Constants

```
Vector2.Zero = Vector2.New()

Vector2.Up = Vector2.New(0, 1)
Vector2.Down = Vector2.New(0, -1)
Vector2.Left = Vector2.New(-1, 0)
Vector2.Right = Vector2.New(1, 0)
```

### 3️⃣ Vector3

Fields:
```
x: number = 0
y: number = x or 0
z: number = y or x or 0
```

Supports math operations and length (`#`) operator.

#### Constants

```
Vector3.Zero = Vector3.New()
```

## 🌈 Colors

### 🎨 Color

Fields: (All `0-1`)
```
r: number = 0           -- Red
g: number = r or 0      -- Green
b: number = g or r or 0 -- Blue
a: number = 1           -- Alpha
```

#### Constants

```
Color.White = Color.New(1)
Color.Black = Color.New()
Color.Gray = Color.New(.510)
Color.LightGray = Color.New(.784)
Color.DarkGray = Color.New(.314)
Color.Yellow = Color.New(.992, .976, 0)
Color.Gold = Color.New(1, .796, 0)
Color.Orange = Color.New(1, .631, 0)
Color.Pink = Color.New(1, .427, .761)
Color.Red = Color.New(.902, .161, .216)
Color.Maroon = Color.New(.745, .129, .216)
Color.Green = Color.New(0, .894, .188)
Color.Lime = Color.New(0, .620, .184)
Color.DarkGreen = Color.New(0, .459, .173)
Color.SkyBlue = Color.New(.4, .749, 1)
Color.Blue = Color.New(0, .475, .945)
Color.DarkBlue = Color.New(0, .322, .675)
Color.Purple = Color.New(.784, .478, 1)
Color.Violet = Color.New(.529, .235, .745)
Color.DarkPurple = Color.New(.439, .122, .494)
Color.Beige = Color.New(.827, .690, .514)
Color.Brown = Color.New(.498, .415, .310)
Color.DarkBrown = Color.New(.298, .247, .184)
Color.Transparent = Color.New(0, 0, 0, 0)
Color.Magenta = Color.New(1, 0, 1)
Color.RayWhite = Color.New(.961)
```

### 🎨🤖 ColorHSV

Fields:
```
h: number = 0 -- Hue [0-360]
s: number = 1 -- Saturation [0-1]
v: number = 1 -- Value [0-1]
a: number = 1 -- Alpha
```

## 🔷 Shapes

### 🟥🔵 2D

#### 🟥 Rectangle

Fields:
```
position: Vector2 = Vector2.Zero
size: Vector2 = Vector2.Zero
```

#### 🔵 Circle

Fields:
```
position: Vector2 = Vector2.Zero
diameter: number = 0
```

#### 📐 Triangle

Fields:
```
firstPoint: Vector2 = Vector2.Zero
secondPoint: Vector2 = Vector2.Zero
thirdPoint: Vector2 = Vector2.Zero
```

### 🧊🛢️ 3D

#### 🧊 Cube

Fields:
```
position: Vector3 = Vector3.Zero
size: number = 0
```

#### 📦 Box

Fields:
```
position: Vector3 = Vector3.Zero
size: Vector3 = Vector3.Zero
```

#### 🔮 Sphere

Fields:
```
position: Vector3 = Vector3.Zero
diameter: number = 0
```

#### 🛢️ Cylinder

Fields:
```
position: Vector3 = Vector3.Zero
diameter: number = 0
height: number = 0
```

#### 🔺 Triangle3D

Fields:
```
firstPoint: Vector3 = Vector3.Zero
secondPoint: Vector3 = Vector3.Zero
thirdPoint: Vector3 = Vector3.Zero
```

## 🎥 Cameras

### 🟥🔵 2D

#### 🎥🟥 Camera2D

### 🧊🛢️ 3D

#### 🎥🧱 Camera3D

Fields:
```
position: Vector3 = Vector3.Zero
target: Vector3 = Vector3.Zero
up: Vector3 = Vector3.Zero
fov: number = 45
projection: Camera3D.Projection = Camera3D.Projection.Perspective
```

Camera3D.Projection:
```
Perspective,
Orthographic
```

# Engine? Objects? Who's she?

YueCat is intentionally designed very loosely. If you want a list of objects every frame, create a table and `table.insert` "object" tables into it, with `step` and `draw` fields, then in the respective callbacks just do a loop like:

```
for obj in *objs
    obj.FUNCTIONNAME()
```

# Special Thanks

Thank you for reading the docs and your interest in YueCat!

Made with 💗 in New England <(˶ᵔᵕᵔ˶)>

Various inspirations for this project:

* [LÖVE2D](https://love2d.org/)
* [Balatro](https://www.playbalatro.com/)
* [stabyourself.net](https://stabyourself.net/)
* [GameMaker](https://gamemaker.io/)
* [UNDERTALE](https://undertale.com/)
* [DELTARUNE](https://deltarune.com/)
* [Cave Story](https://www.cavestory.org/)
* [raylib](https://www.raylib.com/)
* [Godot](https://godotengine.org/)
* [RPG Maker](https://www.rpgmakerweb.com/)
* [Ib](https://www.vgperson.com/games/ib.htm)
* [The Witch's House](https://vgperson.com/games/witchhouse.htm)
* [Basic](https://en.wikipedia.org/wiki/BASIC)
* [Blitz BASIC](https://en.wikipedia.org/wiki/Blitz_BASIC)
* [SCP: Containment Breach](https://www.scpcbgame.com/)
* [Clickteam Fusion](https://www.clickteam.com/clickteam-fusion-2-5)
* [Direct3D](https://learn.microsoft.com/en-us/windows/win32/direct3d)
* [DirectDraw](https://learn.microsoft.com/en-us/windows/win32/directdraw/directdraw)