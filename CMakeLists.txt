cmake_minimum_required(VERSION 3.13)
project(ThreeOneProject)

set(CMAKE_C_STANDARD 11)

add_executable(ThreeOneProject main.c First/test.h header.h)
add_executable(LittleGame LittleGame/Ball.c)