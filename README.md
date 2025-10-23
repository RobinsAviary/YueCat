# LuaCat

## About

LuaCat is a software development framework, largely focused on games. It allows you to create software entirely without an editor using Lua.

The API largely mirrors [Raylib](https://www.raylib.com/)'s, with some key differences to make typing simpler.

## Version Info

LuaCat Alpha

Lua 5.4

Raylib 5.5

Odin dev-2025-10-nightly:7237747

## Table of Contents

1. [🔑 License](#license)
2. [🔴 OOP?](#oop)
3. [月 YueScript (Scripting)](#月-yuescript-scripting)
4. [🔨 Building](#building)
5. [⚙️ Config](#config)
6. [🤙 Callbacks](#callbacks)
    1. [🚂 Engine](#engine)
7. [🔌 Functions](#functions)
    1. [🚂 Engine](#engine-1)
    2. [🖌️ Draw](#draw)
    3. [🐭 Mouse](#mouse)
    4. [🖼️ Texture](#texture)
    5. [🔊 Audio](#audio)
8. [🏗️ "Structs"](#structs)
    1. [2️⃣ Vector2](#vector2)
    2. [3️⃣ Vector3](#vector3)
    3. [🟥 Rectangle](#rectangle)
    4. [🔵 Circle](#circle)
    5. [📐 Triangle](#triangle)
    6. [🎥 Camera](#camera)
    7. [🎨 Color](#color)
    8. [🎨🤖 ColorHSV](#colorhsv)

## A Note on "Typing"

When I use the phrase "typing" or "making typing simpler" or something like that, I'm referring to reducing the number of keys the user needs to press in order to program the thing they want. I have hand pain problems, so being able to code as much as possible is important to me. I hope these considerations will be useful to you as well.

## 🔑 License

LuaCat is free and open source. It can be used for commerical and non-commerical purposes. It is licensed under the [zlib license](https://codeberg.org/RobinsAviary/LuaCat/src/branch/main/LICENSE.md).

## 🔴 OOP?

LuaCat does not use any built-in OOP (though YueScript does provide basic classes), as it instead opts to largely mirror Odin's style of separating procedures and data. Basically, this is a mix of functional and procedural programming, to keep the implementation (and typing) relatively simple.

For those still curious, here is an example of how converting a color would work in OOP:

`hsv = Color.White.ToHSV()`

Again, though, LuaCat is designed with procedural programming in mind, so this would end up looking like:

`hsv = Color.ToHSV(Color.White)`

## 月 YueScript (Scripting)

LuaCat uses YueScript for compiling scripts before running. It is a flavor of MoonScript that compiles down to [Lua](https://www.lua.org/).

Here is the [documentation](https://yuescript.org/doc/). **Fair warning:** the overview on the site makes it look a lot more complicated than it actually is. The gist is that it makes all variables local (generally considered best practice nowadays) and provides a much cleaner syntax for... well, everything.

Assuming there are no major breaking changes, upgrading to a newer version of YueScript should be as simple as replacing the one in `vendor/`.

## 🔨 Building

LuaCat has no external dependencies, as it uses bindings actively maintained by the Odin language, which are built-in with the compiler. As such, compiling and modifying LuaCat is trivial.

Simply open the main directory and execute `odin build .`, which will compile the host program. In order to run your code, place a file named "main.lua" in the base directory. Use the various engine callbacks to implement the functionality you need.

This repo also includes .vscode tasks to build and run the current version, for testing.

## ⚙️ Config

Define this global table during the "Ready" callback to modify how LuaCat launches.

### Fields

`windowSize: Vector2 = Vector2.New(640, 480)`

`windowTitle: string = "LuaCat <version>"`

`audioActive: bool = true`

## 🤙 Callbacks

### 🚂 Engine

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

## 🔌 Functions

These are global tables of functions.

### 🚂 Engine

`Engine.GetTime() -> (timeSinceStart: Number)`

`Engine.GetDelta() -> (deltaTime: Number)`

`Engine.GetFPS() -> (currentFps: Integer)`

`Engine.SetFPSTarget(target: Integer)` 

(Unlimited by default)

### 🖌️ Draw

`Draw.Clear(color: Color)`

`Draw.Line(startPosition: Vector2, endPosition: Vector2, color: Color)`

`Draw.Rectangle(rectangle: Rectangle, color: Color)`

`Draw.Circle(circle: Circle, color: Color)`

`Draw.Triangle(triangle: Triangle, color: Color)`

`Draw.Texture(texture: Texture, postion: Vector2 = Vector2.Zero, tint: Color = Color.White)`

### 🐭 Mouse

`Mouse.GetPosition() -> (mousePosition: Vector2)`

`Mouse.GetX() -> (xPosition: Integer)`

Get the x position of the cursor.

`Mouse.GetY() -> (yPosition: Integer)`

Get the y position of the cursor.

`Mouse.SetX(xPosition: Integer)`

Set the x position of the cursor.

`Mouse.SetY(yPostion: Integer)`

Set the y position of the cursor.

`Mouse.SetPosition(position: Vector2)`

`Mouse.IsButtonPressed(index: Integer = 0) -> boolean`

Checks if the button was just pressed this frame.

`Mouse.IsButtonHeld(index: Integer = 0) -> boolean`

`Mouse.IsButtonReleased(index: Integer = 0) -> boolean`

Checks if the button was just released this frame.

Index button constants:
```
Mouse.Left = 0
Mouse.Right = 1
Mouse.Middle = 2
```

### 🖼️ Texture

`Texture.Load(fileName: string) -> Texture`

`Texture.Unload(texture: Texture)`

### 🔊 Audio
`Texture.Load(fileName: string) -> Audio`

`Texture.Unload(audio: Audio)`

## 🏗️ "Structs"

Constructor example:
```
vec = Vector2.New(5, 4)
```

### 2️⃣ Vector2

Fields:
```
x: number = 0
y: number = x or 0
```

Supports math operations and length (`#`) operator.

### 3️⃣ Vector3

Fields:
```
x: number = 0
y: number = x or 0
z: number = y or x or 0
```

Supports math operations and length (`#`) operator.

### 🟥 Rectangle

Fields:
```
position: Vector2 = Vector2.Zero
size: Vector2 = Vector2.Zero
```

### 🔵 Circle

Fields:
```
position: Vector2 = Vector2.Zero
diameter: number = 0
```

### 📐 Triangle

Fields:
```
firstPoint: Vector2 = Vector2.Zero
secondPoint: Vector2 = Vector2.Zero
thirdPoint: Vector2 = Vector2.Zero
```

### 🎥 Camera

Fields:
```
position: Vector3 = Vector3.Zero
target: Vector3 = Vector3.Zero
up: Vector3 = Vector3.Zero
fov: number = 45
projection: Camera.Projection = Camera.Projection.Perspective
```

### 🎨 Color

Fields: (All `0-1`)
```
r: number = 0           -- Red
g: number = r or 0      -- Green
b: number = g or r or 0 -- Blue
a: number = 1           -- Alpha
```

### 🎨🤖 ColorHSV

Fields:
```
h: number = 0 -- Hue [0-360]
s: number = 1 -- Saturation [0-1]
v: number = 1 -- Value [0-1]
a: number = 1 -- Alpha
```