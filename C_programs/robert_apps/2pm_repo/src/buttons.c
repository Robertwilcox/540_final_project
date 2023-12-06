#include <stdio.h>
#include <stdbool.h>

// Address definitions
#define GPIO_BTNs 0x80001800

// Register read functionality
#define READ_PER(dir) (*(volatile unsigned *)dir)

bool isButtonPressed0() {
    return (READ_PER(GPIO_BTNs) & 0x1) != 0;
}

bool isButtonPressed1() {
    return (READ_PER(GPIO_BTNs) & 0x2) != 0;
}

bool isButtonPressed2() {
    return (READ_PER(GPIO_BTNs) & 0x4) != 0;
}

bool isButtonPressed3() {
    return (READ_PER(GPIO_BTNs) & 0x8) != 0;
}
