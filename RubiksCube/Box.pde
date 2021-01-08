class Box {
  PVector pos;
  float len;
  
  Box(float x, float y, float z, float len) {
    pos = new PVector(x, y, z);
    this.len = len;
  }
 
  void show() {
    
    fill(255);
   
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(len);
    popMatrix();
 }
 
 
}
