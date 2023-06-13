#include "SRF05.h"

const int trigger = 7;
const int echo = 6;

SRF05 SRF(trigger, echo);

int buzzer = 12;
int limit = 40;

void setup() {
  pinMode(buzzer, OUTPUT);
  Serial.begin(115200);

  SRF.setCorrectionFactor(1.035);
}

void loop() {
  float distance = SRF.getCentimeter();
  Serial.println(String(int(distance)));

  if (distance < limit && distance > limit / 2) {
    tone(buzzer, 330, 500);
  }

  if (distance < limit / 2 && distance > limit / 4) {
    tone(buzzer, 330, 700);
  }

  if (distance < limit / 4) {
    tone(buzzer, 330, 900);
  }

  delay(800);
  noTone(buzzer);
}
