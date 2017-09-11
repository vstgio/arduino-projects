nt btValue;

void setup() {
  
  Serial.begin(9600);
  
}

void loop() {
  
  if(Serial.available()) {
    btValue = Serial.read();
    Serial.println(btValue);
    
    if (btValue == 'a') {

    }
    
    else if (btValue == 'b') {
      
    }

    else if (btValue == 'c') {
      
    }

    else if (btValue == 'd') {
      
    }

    delay(30);

  }
}
