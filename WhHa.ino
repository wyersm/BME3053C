//#include <SPI.h>
//#include <RF24.h>

#include <Wire.h>
#include <I2Cdev.h>
#include <MPU6050.h>

MPU6050 mpu(0x68);
//RF24 rad(7,8);

int16_t x[6];
char val = 0;

void setup() {

  Wire.begin();
  Serial.begin(115200);
  delay(1000);
  mpu.initialize();
  delay(1000);
  if(!mpu.testConnection()){
    Serial.println("not running...");
  }
  
}

void loop() {

// check the serial connection for messages
  if(Serial.available())
  {
    // read the value
    val = Serial.read();

    // do something if there is a match
    if(val=='R') // from the matlab code

    // talk to the component to get data
      mpu.getMotion6(&x[0],&x[1],&x[2],&x[3],&x[4],&x[5]);
      
      for(int i;i<6;i++){
        //send data back to MATLAB through the serial connection
        Serial.println(x[i]);
      }
  }

  // don't lock up the arduino
  delay(20);
  
}
