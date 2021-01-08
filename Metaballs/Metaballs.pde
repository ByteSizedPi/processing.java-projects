//Blob b;
Blob[] blobs = new Blob[10];
int r = 40;

void setup() {
  size(750, 750);
  colorMode(HSB);
  for (int i = 0; i < blobs.length; i++) {
    blobs[i] = new Blob(random(r, width - r), random(r, height - r), r);
  }
}

void draw() {
  background(51);
  loadPixels();
  updatePixels();
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;
      float sum = 0;
      
      for (Blob b: blobs) {
        float d = dist(x, y, b.pos.x, b.pos.y);
        sum += 2 * r * b.r/d;
      } 
      pixels[index] = color(sum, 255, 255);
    }
  }
  updatePixels();
  
  for (Blob b : blobs) { 
    b.update();
  }
}
