package YueCat

import lua "vendor:lua/5.4"
import sdl "vendor:sdl2"
import "core:fmt"
import os "core:os/os2"

init_sdl :: proc() {
	if sdl.Init({.GAMECONTROLLER}) < 0 {
		fmt.println("Something went wrong while trying to initialize SDL!")
		fmt.println(sdl.GetError())
		throw_error(.SDL_INIT_FAILED)
	}
	
	if config.verbose do fmt.println("SDL initialized!\n")

	sdl.GameControllerAddMappingsFromFile("gamecontrollerdb.txt")
}

Controller :: struct {
	valid: bool,
	sdl_pointer: ^sdl.GameController,
	deadzone: f32,
	pressed: bit_set[sdl.GameControllerButton],
	released: bit_set[sdl.GameControllerButton],
}

controllers: map[uint]Controller

close_controllers :: proc() {
	if config.verbose do fmt.println("Closing leftover controllers...\n")

	for _, controller in controllers {
		sdl.GameControllerClose(controller.sdl_pointer)
	}
}

controller_device_added :: proc(state: ^lua.State, event: sdl.ControllerDeviceEvent) {
	which := event.which

	controller_pointer := sdl.GameControllerOpen(which)

	new_index: uint

	// TODO: Clean up
	for i: uint; true; i += 1 {
		if i not_in controllers {
			if config.verbose do fmt.printfln("Controller connected: index %d", i)

			controller: Controller
			controller.sdl_pointer = controller_pointer
			controller.valid = true
			controller.deadzone = config.default_deadzone

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

find_controller :: proc(which: sdl.JoystickID) -> (found_controller: ^Controller, index: sdl.JoystickID, exists: bool) {
	for i, controller in controllers {
		other_which := sdl.JoystickInstanceID(sdl.GameControllerGetJoystick(controller.sdl_pointer))

		if which == other_which {
			exists = true
			found_controller = &controllers[i]
			index = sdl.JoystickID(i)
			return
		}
	}

	return
}

controller_device_disconnected :: proc(state: ^lua.State, event: sdl.ControllerDeviceEvent) {
	if controller, index, exists := find_controller(sdl.JoystickID(event.which)); exists {
		if config.verbose do fmt.printfln("Controller disconnected: index %d", index)

		sdl.GameControllerClose(controller.sdl_pointer)
		delete_key(&controllers, uint(index))

		lua.checkstack(state, 3)
		lua.getglobal(state, "Controller")
		lua.getfield(state, -1, "Disconnected")
		lua.pushinteger(state, lua.Integer(index))
		pcall(state, 1)
		lua.pop(state, 1)
	}
}

cleanup_sdl :: proc() {
	close_controllers()

	sdl.Quit()
}

controller_button_down_event :: proc(state: ^lua.State, event: sdl.ControllerButtonEvent) {
	button := sdl.GameControllerButton(event.button)

	if controller, _, exists := find_controller(sdl.JoystickID(event.which)); exists {
		controller.pressed |= {button}
	}
}

controller_button_up_event :: proc(state: ^lua.State, event: sdl.ControllerButtonEvent) {
	button := sdl.GameControllerButton(event.button)
	
	if controller, _, exists := find_controller(sdl.JoystickID(event.which)); exists {
		controller.released |= {button}
	}
}