class GridSelector
{
  int dim, x_offset, y_offset;
  float[][][] arr;
  float w;

  //grid is created with array storing dim x dim coordinates
  GridSelector(int dimensions, float wid, int x_offset, int y_offset)
  {
    dim = dimensions;
    arr = new float[dim][dim][3];
    w = wid/dim;
    this.x_offset = x_offset;
    this.y_offset = y_offset;
  }

  //returns dimensions of array
  public int getDim()
  {
    return dim;
  }

  //returns dim x dim array with coordinates and if it exists at index 2
  public float[][][] getArr()
  {
    return arr;
  }
  
  public float getW()
  {
    return w;
  }

  //fills array with square object's parameters
  public void fillArray()
  {
    for (int i = 0; i < dim; i++)
    {
      for (int j = 0; j < dim; j++)
      {
        arr[i][j][0] = i * w;
        arr[i][j][1] = j * w;
        arr[i][j][2] = 1;
      }
    }
  }

  //receives x, y coordinates then converts to indices and if they are within boundaries of array will select appropriate square
  public void update(int i, int j)
  {
    if ((i + 1 <= dim) && (j + 1 <= dim))
    {
      if (arr[i][j][2] == 1)
      {
        arr[i][j][2] = 0;
      } else
      {
        arr[i][j][2] = 1;
      }
    } else
    {
      println("outside of boundary");
    }
  }

  //loops through array and draws squares with colour depensing whether it was selected or not
  public void show()
  {

    for (int i = 0; i < dim; i++)
    {
      for (int j = 0; j < dim; j++)
      {
        if (arr[i][j][2] == 1)
        {
          stroke(0);
          fill(255);
        } else
        {
          stroke(255);
          fill(0);
        }
        square(arr[i][j][0] - x_offset, arr[i][j][1] - y_offset, w);
      }
    }
  }
}
