@echo off
odin build src/ -out:build/YueCat.exe -build-mode:exe -linker:default -o:speed -show-timings -vet-cast -vet-semicolon -vet-shadowing -vet-style -vet-tabs -vet-unused-variables -warnings-as-errors
if errorlevel 1 goto fail

cd build

YueCat programs/adventure/ --program
exit \b
:fail
echo Building failed.