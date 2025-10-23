# LuaCat

## About

LuaCat is a software development framework, largely focused on games. It allows you to create software entirely in text using Lua.

The API largely mirrors [Raylib](https://www.raylib.com/)'s, with some key differences to make typing simpler.

## Version Info

LuaCat Alpha

Lua 5.4

Raylib 5.5

Odin dev-2025-10-nightly:7237747

## Table of Contents

1. [🔴 OOP?](#oop)
2. [🔨 Building](#building)
3. [⚙️ Config](#config)
4. [🤙 Callbacks](#callbacks)
    1. [🚂 Engine](#engine)
5. [🔌 Functions](#functions)
    1. [🚂 Engine](#engine-1)
    2. [🎨 Draw](#draw)
    3. [🐭 Mouse](#mouse)
    4. [🖼️ Texture](#texture)
    5. [🔊 Audio](#audio)
6. [🏗️ "Structs"](#structs)
    1. [2️⃣ Vector2](#vector2)
    2. [3️⃣ Vector3](#vector3)
    3. [🟥 Rectangle](#rectangle)
    4. [🔵 Circle](#circle)

## 🔴 OOP?

LuaCat does not use any built-in OOP (though YueScript does provide basic classes), as it instead opts to largely mirror Odin's style of separating procedures and data. Basically, this is a mix of functional and procedural programming, to keep the implementation (and typing) relatively simple.

For those still curious, here is an example of how converting a color would work in OOP:

`hsv = Color.White.ToHSV()`

Again, though, LuaCat is designed with procedural programming in mind, so this would end up looking like:

`hsv = Color.ToHSV(Color.White)`

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

### 🎨 Draw

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
position = Vector2.Zero
size = Vector2.Zero
```

### 🔵 Circle

Fields:
```
position = Vector2.Zero
diameter = 0
```
