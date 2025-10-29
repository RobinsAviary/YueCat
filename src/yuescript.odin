package YueCat

import "core:fmt"
import os "core:os/os2"
import "core:strings"
import "core:path/filepath"

RESOURCES_FOLDER :: "resources/"
VENDOR_FOLDER :: RESOURCES_FOLDER + "vendor/"
YUESCRIPT_FOLDER :: VENDOR_FOLDER + "YueScript/"

build_yuescripts :: proc() {
	if config.verbose do fmt.println("Building YueScripts...")

	yuescript_folder, folder_allocated := filepath.from_slash(YUESCRIPT_FOLDER)

	yuescript_directory := strings.concatenate({config.runtime_location, yuescript_folder, "windows/x64/"})
	fmt.printfln("YueScript compiler location: \"%s\"", yuescript_directory)

	processState, stdout, stderr, err := os.process_exec({yuescript_directory, {"yue.exe", "..\\..\\..\\..\\..\\" + PROGRAM}, nil, nil, nil, nil}, context.allocator)

	delete(yuescript_directory)
	if folder_allocated do delete(yuescript_folder)

	fmt.println(string(stdout))

	if err != nil {
		fmt.println("Something went wrong trying to run the YueScript compiler. Is it in 'resources/vendor/'?")
		fmt.println(err)
		throw_error(.YUESCRIPT_COMPILER_FAILED)
	}

	// Success flag seemingly isn't triggered properly. Added more specific check, but I'm leaving the first one just in case.
	if !processState.success || processState.exit_code != 0 {
		fmt.println("Something went wrong while trying to compile the scripts!")
		fmt.println(string(stderr))
		os.exit(processState.exit_code)
	}

	delete(stdout)
	delete(stderr)
}