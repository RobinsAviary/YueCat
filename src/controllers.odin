package YueCat

import lua "vendor:lua/5.4"
import sdl "vendor:sdl2"
import "core:fmt"
import os "core:os/os2"

init_sdl :: proc() {
	if sdl.Init({.GAMECONTROLLER}) < 0 {
		fmt.println("Something went wrong while trying to initialize SDL!")
		fmt.println(sdl.GetError())
		os.exit(1)
	}
	
	if VERBOSE do fmt.println("SDL initialized!\n")

	sdl.GameControllerAddMappingsFromFile("gamecontrollerdb.txt")
}

Controller :: struct {
	valid: bool,
	sdl_pointer: ^sdl.GameController,
	deadzone: f32,
}

controllers: map[uint]Controller

close_controllers :: proc() {
	if VERBOSE do fmt.println("Closing leftover controllers...\n")

	for _, controller in controllers {
		sdl.GameControllerClose(controller.sdl_pointer)
	}
}

controller_device_added :: proc(state: ^lua.State, event: sdl.Event) {
	which := event.cdevice.which

	controller_pointer := sdl.GameControllerOpen(which)

	new_index: uint

	// TODO: Clean up
	for i: uint; true; i += 1 {
		if i not_in controllers {
			if VERBOSE do fmt.printfln("Controller connected: index %d", i)

			controller: Controller
			controller.sdl_pointer = controller_pointer
			controller.valid = true

			controllers[i] = controller
			new_index = i
			break
		}
	}

	// Get callback
	lua.checkstack(state, 2)
	lua.getglobal(state, "Controller")
	lua.getfield(state, -1, "Connected")

	// Set up return value
	lua.checkstack(state, 2)
	lua.createtable(state, 0, 1)
	lua.pushinteger(state, lua.Integer(new_index))
	lua.setfield(state, -2, "index")
	lua.L_setmetatable(state, "Controller")

	pcall(state, 1)
	lua.pop(state, 1)
}

controller_device_disconnected :: proc(state: ^lua.State, event: sdl.Event) {
	which := event.cdevice.which

	for i, controller in controllers {
		other_which := sdl.JoystickInstanceID(sdl.GameControllerGetJoystick(controller.sdl_pointer))
		if which == i32(other_which) {
			if VERBOSE do fmt.printfln("Controller disconnected: index %d", i)
			sdl.GameControllerClose(controllers[i].sdl_pointer)
			delete_key(&controllers, i)

			lua.checkstack(state, 3)
			lua.getglobal(state, "Controller")
			lua.getfield(state, -1, "Disconnected")
			lua.pushinteger(state, lua.Integer(i))
			pcall(state, 1)
			lua.pop(state, 1)
			break
		}
	}
}

cleanup_sdl :: proc() {
	close_controllers()

	sdl.Quit()
}