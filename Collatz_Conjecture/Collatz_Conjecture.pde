//how many lines should be drawn
int iterations = 40000;
//how much a line should turn if odd/even
float angle = 0.12;
//angle multiplier for even/odd
float xangle = 1.1;
float yangle = 1.2;

import processing.pdf.*;

void setup() {
  size(1200, 600);
  colorMode(HSB, 360, 255, 255);
  //fullScreen();
  beginRecord(PDF, "collatz.pdf");
  background(0);
  for (int i = 1; i < iterations; i++) {
    IntList sequence = new IntList();
    int n = i;
    do {
      sequence.append(n);
      n = collatz(n);
    } while (n != 1);
    sequence.append(1);
    sequence.reverse();
    float len = height/100.0;
    
    resetMatrix();
    translate(width/2, height);
    for (int j = 0; j < sequence.size(); j++) {
      int value = sequence.get(j);
      if (value % 2 == 0) {
        rotate(xangle * angle);
      } else {
        rotate(yangle * -angle);
      }
      strokeWeight(2);
      stroke(0, 6);
      float h = map(j, 0, sequence.size(), 0, 360);
      stroke(h, 255, 255, 2);
      line(0, 0, 0, -len);
      translate(0, -len);
    }
    // Visualize the list
  }
  endRecord();
}
int collatz(int n) {
  // even
  if (n % 2 == 0) {
    return n / 2;
    // odd
  } else {
    return (n * 3 + 1)/2;
  }
}
