//3d matrix functions


class Matrix
{
  int dim, x_off, y_off;
  //arrPoints is a dim x dim (2D) collection of 8 3D PVectors each
  //store array of array of points representing each cube, as with associated transformed vectors in arrTransformedPoints
  //PVector[][][] arrPoints, arrTransformedPoints;
  PVector[][][] arrPoints, arrTransformedPoints;

  Matrix(int dim, int x_off, int y_off)
  {
    this.dim = dim;
    this.x_off = x_off;
    this.y_off = y_off;
    arrPoints = new PVector[dim][dim][8];
    arrTransformedPoints = new PVector[dim][dim][8];
  }

  //function that returns square 3D array of point vectors evenly spaced from relative origin
  void build3dArray(float[][][] arr)
  {
    for (int i = 0; i < dim; i++)
    {
      for (int j = 0; j < dim; j++)
      {
        if (arr[i][j][2] == 1)
        {
          //represents 2D array of cube points, where each spot contains 8 3D vectors 
          arrPoints[i][j] = points3dCube(2*(i-(dim-1)/2), 0, 2*(j-(dim-1)/2));
        }
        //println(arrPoints[i][j]);
      }
    }
  }

  //returns array of 3D unit vectors at relative origin
  PVector[] points3dCube()
  {
    PVector[] v = new PVector[8];
    v[0] = new PVector(-1, -1, -1);
    v[1] = new PVector(1, -1, -1);
    v[2] = new PVector(1, 1, -1);
    v[3] = new PVector(-1, 1, -1);
    v[4] = new PVector(-1, -1, -1);
    v[5] = new PVector(1, -1, -1);
    v[6] = new PVector(1, 1, -1);
    v[7] = new PVector(-1, 1, -1);
    return v;
  }

  //return array of 3D unit vectors with offsets with respect to relative origin
  PVector[] points3dCube(float x_off, float y_off, float z_off)
  {
    PVector[] v = new PVector[8];
    v[0] = new PVector(-1 + x_off, -1 + y_off, -1 + z_off);
    v[1] = new PVector(1 + x_off, -1 + y_off, -1 + z_off);
    v[2] = new PVector(1 + x_off, 1 + y_off, -1 + z_off);
    v[3] = new PVector(-1 + x_off, 1 + y_off, -1 + z_off);
    v[4] = new PVector(-1 + x_off, -1 + y_off, 1 + z_off);
    v[5] = new PVector(1 + x_off, -1 + y_off, 1 + z_off);
    v[6] = new PVector(1 + x_off, 1 + y_off, 1 + z_off);
    v[7] = new PVector(-1 + x_off, 1 + y_off, 1 + z_off);
    return v;
  }

  //changes a 3d vector to its corresponding 3d matrix
  float[][] vecToMatrix(PVector v)
  {
    float[][] m = new float[3][1];
    m[0][0] = v.x;
    m[1][0] = v.y;
    m[2][0] = v.z;
    return m;
  }

  //changes a 3d matrix to its corresponding 3d vector
  PVector matrixTo3dVec(float[][] m)
  {
    return new PVector(m[0][0], m[1][0], m[2][0]);
  }



  //formulae for 3D rotation by respective axes
  float[][] rotation3dX(float angle)
  {
    float[][] result = {{1, 0, 0}, {0, cos(angle), -sin(angle)}, {0, sin(angle), cos(angle)}};
    return result;
  }

  float[][] rotation3dY(float angle)
  {
    float[][] result = {{cos(angle), 0, -sin(angle)}, {0, 1, 0}, {sin(angle), 0, cos(angle)}};
    return result;
  }

  float[][] rotation3dZ(float angle)
  {
    float[][] result = {{cos(angle), -sin(angle), 0}, {sin(angle), cos(angle), 0}, {0, 0, 1}};
    return result;
  }



  //projection scaling each vector by same scalar as well as projecting onto R^2 -> x, y
  float[][] projection3d(float z)
  {
    float[][] result = {{z, 0, 0}, {0, z, 0}, {0, 0, 0}};
    return result;
  }

  //multiply a 3x3 transormation matrix with 3x1 vector for 3x1 vector return
  PVector matMul(float[][] a, PVector b)
  {
    if (a[0].length != 3)
    {
      println("Dimensions incorrect");
      return null;
    }
    PVector result = new PVector();
    result.x += a[0][0] * b.x + a[0][1] * b.y + a[0][2] * b.z;
    result.y += a[1][0] * b.x + a[1][1] * b.y + a[1][2] * b.z;
    result.z += a[2][0] * b.x + a[2][1] * b.y + a[2][2] * b.z;
    return result;
  }

  //matrix multiply two matrices with corresponding output matrix
  float[][] matMul(float[][] a, float[][] b)
  {
    int colA = a[0].length;
    int rowA = a.length;
    int colB = b[0].length;
    int rowB = b.length;
    float sum = 0;

    if (colA != rowB)
    {
      println("Dimensions incorrect");
      return null;
    }
    float[][] result = new float[rowA][colB];

    for (int i = 0; i < rowA; i++)
    {
      for (int j = 0; j < colB; j++)
      {
        sum = 0;
        for (int k = 0; k < colA; k++)
        {
          sum += a[i][k] * b[k][j];
        }
        result[i][j] = sum;
      }
    }
    return result;
  }

  //draws lines between edges of vectors
  void connect3d(PVector a, PVector b)
  {
    line(a.x + x_off, a.y + y_off, b.x + x_off, b.y + y_off);
    //println("a.x: " + a.x + " a.y: " + a.y + " a.z: " + a.z); 
  }

  //algorithm for connecting vertices of cube vectors
  void draw3dCube(PVector[] matrix)
  {
    for (int j = 0; j < 4; j++)
    {
      //connect3d receives 2 PVectors
      connect3d(matrix[j], matrix[(j + 1)%4]);
      connect3d(matrix[j + 4], matrix[(j+1)%4 + 4]);
      connect3d(matrix[j], matrix[j+4]);
    }
  }

  //some custom matrix transformations on base vecors of the cubes rotating, scaling and projecting
  void customTransformation(int i, int j, float angle)
  {
    int count = 0;

    for (PVector v : arrPoints[i][j]) 
    {
      if (arrPoints[i][j][count] != null)
      {
        //println("found at i:" + i + " j:" + j);
        //applying rotation matrices to base vector
        arrTransformedPoints[i][j][count] = matMul(rotation3dX(angle), v);
        //arrTransformedPoints[i][j][count] = matMul(rotation3dY(angle), arrTransformedPoints[i][j][count]);
        //arrTransformedPoints[i][j][count] = matMul(rotation3dZ(angle), arrTransformedPoints[i][j][count]);

        //calculating distance matrix
        z = 1/(distance - arrTransformedPoints[i][j][count].z);

        //applying the projection matrix of parameter z on base vector
        arrTransformedPoints[i][j][count] = matMul(projection3d(z), arrTransformedPoints[i][j][count]);

        //scaling base vector
        arrTransformedPoints[i][j][count].mult(100);

        //drawing point at calculated coordinate by projecting onto x, y plane
        //point(arrTransformedPoints[i][j][count].x, arrTransformedPoints[i][j][count].y);
        //count keeps track of arrTransformedPoints[i][j] index as we used a for each loop -> cant index
        count++;
      }
    }
  }

  //loop through each presentation of each cube in arrTransformedPoints
  void loopTransformation(float[][][] arr, float angle)
  {
    for (int i = 0; i < dim; i++)
    {
      for (int j = 0; j < dim; j++)
      {
        if (arr[i][j][2] == 1)
        {
          customTransformation(i, j, angle);
          //draw3dCube receives array of PVcetors and calls connect() that draws lines between arrTransformedPoint[i][j]s' elements
          draw3dCube(arrTransformedPoints[i][j]);
        }
      }
    }
  }
}
