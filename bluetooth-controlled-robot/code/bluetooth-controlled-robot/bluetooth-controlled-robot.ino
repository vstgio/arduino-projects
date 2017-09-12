#include <AFMotor.h>

int btValue;

AF_DCMotor motor_d(1);
AF_DCMotor motor_e(2);

void setup() {
  
  Serial.begin(9600);
  
}

void loop() {
  
  if(Serial.available()) {
    btValue = Serial.read();
    //Serial.println(btValue);
    
    if (btValue == 'a') {
        motor_d.setSpeed(255);
        motor_e.setSpeed(255);
        motor_d.run(FORWARD);
        motor_e.run(FORWARD);

        delay(300);

        motor_d.setSpeed(0);
        motor_e.setSpeed(0);
        motor_e.run(RELEASE);
        motor_d.run(RELEASE);
    }
    
    else if (btValue == 'b') {
        motor_d.setSpeed(255);
        motor_e.setSpeed(255);
        motor_d.run(BACKWARD);
        motor_e.run(BACKWARD);

        delay(300);

        motor_d.setSpeed(0);
        motor_e.setSpeed(0);
        motor_e.run(RELEASE);
        motor_d.run(RELEASE);
    }

    else if (btValue == 'c') {
        motor_d.setSpeed(255);
        motor_e.setSpeed(255);
        motor_d.run(FORWARD);
        motor_e.run(BACKWARD);

        delay(300);

        motor_d.setSpeed(0);
        motor_e.setSpeed(0);
        motor_e.run(RELEASE);
        motor_d.run(RELEASE);
    }

    else if (btValue == 'd') {
        motor_d.setSpeed(255);
        motor_e.setSpeed(255);
        motor_d.run(BACKWARD);
        motor_e.run(FORWARD);

        delay(300);

        motor_d.setSpeed(0);
        motor_e.setSpeed(0);
        motor_e.run(RELEASE);
        motor_d.run(RELEASE);
    }

    delay(50);

  }
}