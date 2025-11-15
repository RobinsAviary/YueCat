package YueCat

import "core:fmt"
import os "core:os/os2"
import "core:strings"
import "core:path/filepath"

RESOURCES_FOLDER :: "resources/"
VENDOR_FOLDER :: RESOURCES_FOLDER + "vendor/"
YUESCRIPT_FOLDER :: VENDOR_FOLDER + "YueScript/"

run_yuescript :: proc(location: string) -> (succeeded: bool) {
	if config.verbose do fmt.println("Building YueScripts in", location)

	yuescript_folder, folder_allocated := filepath.from_slash(YUESCRIPT_FOLDER)

	folder_extension: string
	folder_extension_allocated: bool

	yuescript_filename: string

	if ODIN_OS == .Windows {
		folder_extension, folder_extension_allocated = filepath.from_slash("windows/x64/")
		yuescript_filename = "yue.exe"
	} else if ODIN_OS == .Linux{
		folder_extension, folder_extension_allocated = filepath.from_slash("linux/")
		yuescript_filename = "yue"
	} else {
		fmt.println("This operating system is not supported:", ODIN_OS)
		throw_error(.UNSUPPORTED_OS)
	}

	yuescript_directory := strings.concatenate({config.runtime_location, yuescript_folder, folder_extension})
	if config.verbose do fmt.printfln("YueScript compiler location: \"%s\"", yuescript_directory)

	scripts_folder, scripts_folder_allocated := filepath.from_slash(location)

	process_state, stdout, stderr, err := os.process_exec({"", {yuescript_filename, scripts_folder}, nil, nil, nil, nil}, context.allocator)
	
	if scripts_folder_allocated do delete(scripts_folder)

	delete(yuescript_directory)
	if folder_allocated do delete(yuescript_folder)
	if folder_extension_allocated do delete(folder_extension)

	fmt.println(string(stdout))

	if err != nil {
		fmt.println("Something went wrong trying to run the YueScript compiler. Is it in 'resources/vendor/'?")
		fmt.println(err)
		throw_error(.YUESCRIPT_COMPILER_FAILED)
	} else if !process_state.success || process_state.exit_code != 0 {
		// Success flag seemingly isn't triggered properly. Added more specific check, but I'm leaving the first one just in case.
		fmt.println("Something went wrong while trying to compile scripts!")
		fmt.println(string(stderr))
		os.exit(process_state.exit_code)
	} else {
		succeeded = true
	}

	delete(stdout)
	delete(stderr)

	return
}