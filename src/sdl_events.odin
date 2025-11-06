package YueCat

import lua "vendor:lua/5.4"
import sdl "vendor:sdl2"

process_event :: proc(state: ^lua.State, event: sdl.Event) {
	#partial switch event.type {
		case .CONTROLLERDEVICEADDED:
			controller_device_added(state, event.cdevice)
		case .CONTROLLERDEVICEREMOVED:
			controller_device_disconnected(state, event.cdevice)
		case .CONTROLLERBUTTONDOWN:
			controller_button_down_event(state, event.cbutton)
		case .CONTROLLERBUTTONUP:
			controller_button_up_event(state, event.cbutton)
	}
}

poll_events :: proc(state: ^lua.State) {
	event: sdl.Event
	for sdl.PollEvent(&event) {
		process_event(state, event)
	}
}