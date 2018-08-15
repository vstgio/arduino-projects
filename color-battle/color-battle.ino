void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);
  pinMode(3, INPUT);
}

void loop() {
  if (digitalRead(2) == true && digitalRead(3) == true){
    Serial.println("1,1");
  }

  else if (digitalRead(2) == true && digitalRead(3) == false) {
    Serial.println("1,0");
  }

  else if (digitalRead(2) == false && digitalRead(3) == true) {
    Serial.println("0,1");
  }
  
  delay(20);
}
