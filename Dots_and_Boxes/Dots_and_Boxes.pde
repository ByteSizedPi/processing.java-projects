int count = 50;
float r = 0.125;
float w;
Box[][] boxes = new Box[count][count];

float formula(int i, int j, float i_offset, float j_offset)
{
  return pow(pow(i - i_offset - 1, 2) + pow(j - j_offset - 1, 2), r);
}

void setup()
{
  noStroke();
  size(500, 500);
  w = width/count;
  
  for (int i = 0; i < count; i++)
  {
    for (int j = 0; j < count; j++)
    {
      float radius = map(formula(i + 1, j + 1, 0, 0), 0, formula(count, count, 0, 0), 0, w);
      boxes[i][j] = new Box(i, j, count, radius);
      if ((i + j) % 2 == 2)
      {
        boxes[i][j].invert();
      }
      boxes[i][j].show();
    }
  }
}

void draw()
{
 for (int i = 0; i < count; i++)
  {
    for (int j = 0; j < count; j++)
    {
      float i_offset = (mouseX - mouseX % w)/w;
      float j_offset = (mouseY - mouseY % w)/w;
      float radius = map(formula(i + 1, j + 1, i_offset, j_offset), 0, formula(count, count, 0, 0), w, 0);
      boxes[i][j].setRadius(radius);
      boxes[i][j].show();
    }
  }
}
