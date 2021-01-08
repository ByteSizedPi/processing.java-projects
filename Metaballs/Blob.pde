class Blob {
  PVector pos;
  float r;
  PVector vel;
  
  Blob(float x, float y, float radius) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    vel.mult(random(2, 5));
    r = radius;
  }
  
  void update() {
    pos.add(vel);
    
    if(pos.x >= width - r || pos.x <= r) {
      vel.x = -vel.x;
    }
    
    if(pos.y >= height - r || pos.y <= r) {
      vel.y = -vel.y;
    }
  }
  
  void show() {
    noFill();
    stroke(0);
    strokeWeight(2);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
}
