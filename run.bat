@echo off
yue program/
if errorlevel 1 goto fuck
odin run .
exit /b
:fuck
echo Build failed.