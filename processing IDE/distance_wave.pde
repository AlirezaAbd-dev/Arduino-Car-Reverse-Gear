import processing.serial.*;

Serial myPort;

// Attributes for wave
float angle = 0;
float frequency = 0.1;
float amplitude = 50;
float offset = 200;

// Distance that comes from Serial
String distance = "";

// When the first siganl comes it'll be true
boolean isStarted = false;

void setup() {
  // First Serial port
  String portName = Serial.list()[0];
  // Serial instance
  myPort = new Serial(this, portName, 115200);

  // Making the window
  size(800, 400);
  textAlign(CENTER);
  textSize(24);
}

void draw() {
  background(color(#111111));
  stroke(color(#ff0000));
  strokeWeight(2);
  noFill();

  // If data is comming from Serial
  if (myPort.available() > 0) {
    // in first incomming data it'll run and isStarted will be true
    if (isStarted == false) isStarted = true;
    //Reading the data from Serial
    String data = myPort.readString();
    if (data != null) {
      // changing the height of the wave depend on Serial data
      amplitude = float(data) * 2;
      distance = data + "centimeters";
    }
  } else {
    if (isStarted == false) {
      // Don't show the wave if isStarted is false, which means that the Serial haven't sent yet
      amplitude = 1000;
    }
  }

  // Showing the distance in top of the window
  fill(200, 200, 0);
  text(distance, 400, 30);

  // starting the animation of the wave
  beginShape();
  noFill();
  // loop for making the curve that is in the wave
  for (float x = 0; x < width; x++) {
    if (amplitude < 200) {
      float y = sin(angle + x * frequency) * amplitude + offset;
      vertex(x, y);
    }
  }
  endShape();

  angle += 0.1;
}
