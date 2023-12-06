cmake_minimum_required(VERSION 3.17)

project(VGA_test)

set(SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/src/main_shooter.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/servo_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/joystick_wrapper.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/drivers/uart/uart_send_char.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/motor_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/buttons.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/joystick_display.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/joystick_control.c)
set(TARGET_NAME VGA_test.elf)

option(CUSTOM_UART "Use a custom uart_send_char()" ON)

set(SEMIHOSTING OFF)
set(UART ON)

add_executable(${TARGET_NAME} ${SOURCE})

include(${CMAKE_CURRENT_SOURCE_DIR}/../common/Common.cmake)
