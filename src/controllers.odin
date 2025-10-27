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

	//populate_controllers()
}

controllers: map[uint]^sdl.GameController

// Populate the controllers list when the program is first started
/*populate_controllers :: proc() {
	fmt.print("Populating controllers...\n")

	for i: i32; i < sdl.NumJoysticks(); i += 1 {
		if sdl.IsGameController(i) {
			if VERBOSE do fmt.printf("Controller found at: %d\n", i)

			controllers[i] = sdl.GameControllerOpen(i)
		}
	}
	
	fmt.println("")
}*/

close_controllers :: proc() {
	if VERBOSE do fmt.println("Closing leftover controllers...\n")

	for _, controller in controllers {
		sdl.GameControllerClose(controller)
	}
}

controller_device_added :: proc(state: ^lua.State, event: sdl.Event) {
	which := event.cdevice.which

	controller := sdl.GameControllerOpen(which)

	new_index: uint

	// TODO: Clean up
	for i: uint; true; i += 1 {
		if i not_in controllers {
			if VERBOSE do fmt.printfln("Controller connected: index %d", i)

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
		other_which := sdl.JoystickInstanceID(sdl.GameControllerGetJoystick(controller))
		if which == i32(other_which) {
			if VERBOSE do fmt.printfln("Controller disconnected: index %d", i)
			sdl.GameControllerClose(controllers[i])
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