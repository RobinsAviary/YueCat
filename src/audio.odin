package YueCat

import lua "vendor:lua/5.4"
import rl "vendor:raylib"
import "core:fmt"
import "base:runtime"

audio_warning :: proc "c" () {
    context = runtime.default_context()
    if !config.audio_active {
        fmt.println("WARNING: Attempted to call audio function, but audio is disabled!")
    }
}

LoadAudio :: proc "c" (state: ^lua.State) -> i32 {
    audio_warning()

    lua.checkstack(state, 1)

    if !config.audio_active {
        lua.pushnil(state)
        return 1
    }
    fileName := lua.L_checkstring(state, 1)

    audio := rl.LoadSound(fileName)

    data := transmute(^rl.Sound)lua.newuserdatauv(state, size_of(audio), 0)
    lua.L_setmetatable(state, AudioUData)

    data.buffer = audio.buffer
    data.channels = audio.channels
    data.frameCount = audio.frameCount
    data.processor = audio.processor
    data.sampleRate = audio.sampleRate
    data.sampleSize = audio.sampleSize
    data.stream = audio.stream

    return 1
}

check_audio :: proc "c" (state: ^lua.State, arg: i32) -> ^rl.Sound {
    user := lua.L_checkudata(state, arg, AudioUData)
    sound := transmute(^rl.Sound)user

    return sound
}

UnloadAudio :: proc "c" (state: ^lua.State) -> i32 {
    audio_warning()

    if config.audio_active {
        audio := check_audio(state, 1)

        rl.UnloadSound(audio^)
    }

    return 0
}