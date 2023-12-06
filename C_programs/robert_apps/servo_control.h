#ifndef SERVO_CONTROL_H
#define SERVO_CONTROL_H

#include <stdint.h>

void servoMoveCW(uint32_t width_min, uint32_t width_max, unsigned long delay_per_step);
void servoMoveCCW(uint32_t width_min, uint32_t width_max, unsigned long delay_per_step);
void servoStop();

#endif // SERVO_CONTROL_H
