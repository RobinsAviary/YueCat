package YueCat

import "core:fmt"
import os "core:os/os2"

build_yuescript :: proc() {
    if VERBOSE do fmt.println("Building YueScripts...")

	processState, stdout, stderr, err := os.process_exec({"resources\\vendor\\YueScript\\", {"yue.exe", "..\\..\\..\\" + PROGRAM}, nil, nil, nil, nil}, context.allocator)

	fmt.println(string(stdout))

	if err != nil {
		fmt.println("Something went wrong trying to run the YueScript compiler. Is it in 'vendor\\'?")
		fmt.println(err)
		os.exit(1)
	}

	// Success flag seemingly isn't triggered properly. Added more specific check, but I'm leaving the first one just in case.
	if !processState.success || processState.exit_code != 0 {
		fmt.println(string(stderr))
		os.exit(processState.exit_code)
	}

	delete(stdout)
	delete(stderr)
}