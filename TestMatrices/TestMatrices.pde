float count = 0;

void setup() {
  size(500, 500, P3D);
  noFill();
  noStroke();
}

void draw() {
  background(255);
  translate(250, 250, 0); 
  rotateX(count);

  //box(200);
  quad(-100, -100, -100, 100, 100, 100, 100, -100);
  fill(255, 0, 0);
  count += 0.01;
}
