package YueCat

import os "core:os/os2"
import "core:strings"
import "core:fmt"

process_console_args :: proc() {
	for arg, i in os.args {
		if strings.starts_with(arg, "--") {
			shortened_arg, was_allocation := strings.remove_all(arg, "--")
			
			switch (shortened_arg) {
				
				case "p":
					fallthrough
				case "program":
					if i >= 1 {
						program_location = os.args[i - 1]
					}
			}

			if was_allocation do delete(shortened_arg)
		}
	}
}