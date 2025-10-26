package YueCat

import lua "vendor:lua/5.4"
import sdl "vendor:sdl2"

process_event :: proc(state: ^lua.State, event: sdl.Event) {
	#partial switch event.type {
		case .CONTROLLERDEVICEADDED:
			controller_device_added(state, event)
		case .CONTROLLERDEVICEREMOVED:
			controller_device_disconnected(state, event)
	}
}

poll_events :: proc(state: ^lua.State) {
	event: sdl.Event
	for sdl.PollEvent(&event) {
		process_event(state, event)
	}
}