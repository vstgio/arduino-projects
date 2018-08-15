int player01_state = 0;
int player02_state = 0;
int player01_last_state = 0;
int player02_last_state = 0;

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);
  pinMode(3, INPUT);
}

void loop() {
  if (digitalRead(2) != player01_last_state) {
    if (digitalRead(2) == true) {
      player01_last_state = true;
      player01_state = true;
    }
    
    else {
      player01_last_state = false;
      player01_state = false;
    }
  }
  
  else {
      player01_state = false;
  }

  if (digitalRead(3) != player02_last_state) {
    if (digitalRead(3) == true) {
      player02_last_state = true;
      player02_state = true;
    }
  
    else {
      player02_last_state = false;
      player02_state = false;
    }
  }
  
  else {
      player02_state = false;
  }
  
  sendData(player01_state, player02_state);
}

void sendData(int player01, int player02) {
  if (player01 == true && player02 == true) {
    Serial.println("1,1");
  }
  
  else if (player01 == true && player02 == false) {
    Serial.println("1,0");
  }
  
  else if (player01 == false && player02 == true) {
    Serial.println("0,1");
  }
  
  delay(20);  
}
