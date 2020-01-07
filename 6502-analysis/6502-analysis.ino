//const char ADDR[] = {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52};
const char ADDR[] = {52, 50, 48, 46, 44, 42, 40, 38, 36, 34, 32, 30, 28, 26, 24, 22};
const char DATA[] = {39, 41, 43, 45, 47, 49, 51, 53};
#define CLOCK 2
#define READ_WRITE 3

void setup() {
  for (int n = 0; n < 16; n += 1) {
    pinMode(ADDR[n], INPUT);
  }
  for (int n = 0; n < 8; n += 1) {
    pinMode(DATA[n], INPUT);
  }
  pinMode(CLOCK, INPUT);
  pinMode(READ_WRITE, INPUT);

  attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);

  Serial.begin(57600);
}

int clockCount = 0;

void onClock() {
  char output[60];

  unsigned int address = 0;
  for (int n = 0; n < 16; n += 1) {
    int bit = digitalRead(ADDR[n]) ? 1 : 0;
    Serial.print(bit);
    address = (address << 1) + bit;
  }
  Serial.print("    ");
  unsigned int data = 0;
  for (int n = 0; n < 8; n += 1) {
    int dataBit = digitalRead(DATA[n]) ? 1 : 0;
    Serial.print(dataBit);
    data = (data << 1) + dataBit;
  }

  sprintf(output, "    %04x  %c  %02x", address, digitalRead(READ_WRITE) ? 'r' : 'W', data);
  Serial.println(output);

  //char output[32];
  //sprintf(output, "%d CLOCK", clockCount);
  //Serial.println(output);
  //clockCount++;
}

void loop() {
}
