class Box
{
  int i, j, f, count, w; 
  float radius;
  boolean inverted = false;
  Box(int i, int j, int c, float r)
  {
    this.i = i;
    this.j = j;
    this.count = c;
    w = width/c;
    this.radius = r;
  }
  
  public void invert()
  {
    this.inverted = true;
  }
  
  public void setRadius(float radius)
  {
    this.radius = radius;
  }
  
  public void show()
  {
    if (inverted)
    {
      f = 255;
    }
    else
    {
      f = 0;
    }
    fill(f);
    square(i * w, j * w, w);
    fill(255 - f);
    ellipse(i * w + w/2, j * w  + w/2, radius, radius);
  }
}
