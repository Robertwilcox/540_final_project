cmake_minimum_required(VERSION 3.17)

project(FinalProject-App C)

set(SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/src/app.c ${CMAKE_CURRENT_SOURCE_DIR}/../common/drivers/uart/uart_send_char.c)

set(TARGET_NAME app.elf)

option(CUSTOM_UART "Use a custom uart_send_char()" ON)

set(SEMIHOSTING OFF)
set(UART ON)

add_executable(${TARGET_NAME} ${SOURCE})

include(${CMAKE_CURRENT_SOURCE_DIR}/../common/Common.cmake)