int valor = 0;

void setup() {
  Serial.begin(9600);
  pinMode(A0, INPUT);
}

void loop() {
  if (digitalRead(2)){
    valor = valor + 1;  
  }
  Serial.println(valor);
  delay(20);
}
