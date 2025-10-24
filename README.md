# YueCat

# About

YueCat is a software development framework, largely focused on games. It allows you to create software entirely without an editor using a flavor of Lua called [YueScript](https://yuescript.org/).

The API largely mirrors [Raylib](https://www.raylib.com/)'s, with some key differences to make typing simpler.

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
9. [🔌 Functions](#functions)
    1. [🚂 Engine](#engine-1)
    2. [📥 Input]()
        1. [🐭 Mouse](#mouse)
        2. [⌨️ Keyboard](#keyboard)
        3. [🎮 Gamepad](#gamepad)
    3. [🎞️ Rendering](#rendering)
        1. [🖌️ Draw](#draw)
        2. [🖼️ Texture](#texture)
    4. [🎧 Sound](#sound)
        1. [🔊 Audio](#audio)
10. [🏗️ "Structs"](#structs)
    1. [➡️ Vectors](#vectors)
        1. [2️⃣ Vector2](#vector2)
        2. [3️⃣ Vector3](#vector3)
    2. [🌈 Colors](#colors)
        1. [🎨 Color](#color)
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

Raylib 5.5

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

`windowSize: Vector2 = Vector2.New(640, 480)`

`windowTitle: string = "YueCat <version>"`

`audioActive: bool = true`

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

# 🔌 Functions

These are global tables of functions.

## 🚂 Engine

`Engine.GetTime() -> (timeSinceStart: Number)`

`Engine.GetDelta() -> (deltaTime: Number)`

`Engine.GetFPS() -> (currentFps: Integer)`

`Engine.SetFPSTarget(target: Integer)` 

(Unlimited by default)

## 📥 Input

### 🐭 Mouse

`Mouse.GetPosition() -> (mousePosition: Vector2)`

Get the position of the cursor.

`Mouse.GetX() -> (xPosition: Integer)`

Get the x position of the cursor.

`Mouse.GetY() -> (yPosition: Integer)`

Get the y position of the cursor.

`Mouse.SetX(xPosition: Integer)`

Set the x position of the cursor.

`Mouse.SetY(yPostion: Integer)`

Set the y position of the cursor.

`Mouse.SetPosition(position: Vector2)`

Set the position of the cursor.

`Mouse.IsButtonPressed(index: Integer = 0) -> boolean`

Checks if the button was just pressed this frame.

`Mouse.IsButtonHeld(index: Integer = 0) -> boolean`

Checks if the button is held down.

`Mouse.IsButtonReleased(index: Integer = 0) -> boolean`

Checks if the button was just released this frame.

Index button constants:
```
Mouse.Left = 0
Mouse.Right = 1
Mouse.Middle = 2
```

### ⌨️ Keyboard

### 🎮 Gamepad

## 🎞️ Rendering

### 🖌️ Draw

`Draw.Clear(color: Color)`

Clear the entire screen to a single color.

It is reccomended to call this first in most programs, before you draw anything else. Otherwise, graphics from previous frames will stick around (think out-of-bounds in Source games). You can also recreate this behavior by using a full-screen rectangle.

`Draw.Line(startPosition: Vector2, endPosition: Vector2, color: Color)`

`Draw.Rectangle(rectangle: Rectangle, color: Color)`

`Draw.Circle(circle: Circle, color: Color)`

`Draw.Triangle(triangle: Triangle, color: Color)`

`Draw.Texture(texture: Texture, postion: Vector2 = Vector2.Zero, tint: Color = Color.White)`

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

### 3️⃣ Vector3

Fields:
```
x: number = 0
y: number = x or 0
z: number = y or x or 0
```

Supports math operations and length (`#`) operator.

## 🌈 Colors

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

# Engine? Objects?

YueCat is intentionally designed to be very loose. If you want a list of objects every frame, create a table and `table.insert` "objects" into it, with `step` and `draw` fields, then in the respective callbacks just do a loop like:

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
* [Raylib](https://www.raylib.com/)
* [Godot](https://godotengine.org/)
* [RPG Maker](https://www.rpgmakerweb.com/)
* [Ib](https://www.vgperson.com/games/ib.htm)
* [The Witch's House](https://vgperson.com/games/witchhouse.htm)