//how many lines should be drawn
int iterations = 50000;
//how much a line should turn if odd/even
float angle = 0.12;
//angle multiplier for even/odd
float xangle = 1.15;
float yangle = 1.3;

int speed = 1;
int order = 5;
int N = int(pow(2, order));
int total = N * N;
int counter = 0;
int frame = 0;

PVector[] path = new PVector[total];

import processing.pdf.*;

void setup() {
  //size(1024, 1024);
  colorMode(HSB, 360, 255, 255);
  fullScreen();
  //beginRecord(PDF, "collatz.pdf");
  background(0);
  
  float len = width / N;

  for (int i = 0; i < total; i++) {
    path[i] = hilbert(i);
    path[i].mult(len);
    path[i].add(len/2, len/2);
  }
  
  counter = path.length;
  stroke(255);
  strokeWeight(1);
  noFill();
  //beginShape();
  for (int i = 1; i < counter; i++) {
    float h = map(i, 0, path.length, 0, 360);
    stroke(h, 255, 255);
    line(path[i].x, path[i].y, path[i-1].x, path[i-1].y);
  }
  //endShape();

  //frame += 10;
  //counter = (frame - frame%speed)/speed;
  counter += 20;
  
  if (counter >= path.length) {
    //frame = 0;
    counter  = 0;
  }
  
  
  for (int i = 1; i < iterations; i++) {
    IntList sequence = new IntList();
    int n = i;
    do {
      sequence.append(n);
      n = collatz(n);
    } while (n != 1);
    sequence.append(1);
    sequence.reverse();
    float leng = height/100.0;
    
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
      stroke(h, 255, 255, 5);
      line(0, 0, 0, -leng);
      translate(0, -leng);
    }
    // Visualize the list
  }
  //endRecord();
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

PVector hilbert(int i) {
  PVector[] points = {
    new PVector(0, 0), 
    new PVector(0, 1), 
    new PVector(1, 1), 
    new PVector(1, 0)
  };

  int index = i & 3;
  PVector v = points[index];

  for (int j = 1; j < order; j++) {
    i = i >>> 2;
    index = i & 3;
    float len = pow(2, j);
    if (index == 0) {
      float temp = v.x;
      v.x = v.y;
      v.y = temp;
    } else if (index == 1) {
      v.y += len;
    } else if (index == 2) {
      v.x += len;
      v.y += len;
    } else if (index == 3) {
      float temp = len - 1 - v.x;
      v.x = len - 1 - v.y;
      v.y = temp;
      v.x += len;
    }
  }
  return v;
}
