//keeps track of constant angle the array of cubes are rotating through
float angle = 0;

//variable keeping track of value associated with creating perspective 
float z;

//the distance from the "camera" the projection of the cubes is 
float distance = 8;
int x;
int dim = 5;

//declare create grid, matrix objects
GridSelector grid;
Matrix matrix;

void settings()
{
  size(1000, 500);
}

void setup()
{
  rectMode(CORNER);
  
  //instansiate grid object with dimensions: dim, width of each square: width/2, x_offset: 0, y_offset: 0
  grid = new GridSelector(dim, width/2, 0, 0);
  
  //fills grid objects array of squares with corresponding coordinates
  grid.fillArray();

  //instansiate arrays that store initial points of cubes as well as transformations on those points
  matrix = new Matrix(dim, 3 * width/4, height/2);
  
  //fill arrPoints with points depending on if the corresponding index in object grid is selected or not
  matrix.build3dArray(grid.getArr());
}

//if mouse is pressed the selected square should flip its selected status
void mousePressed()
{
  float w = grid.getW();
  grid.update((int)((mouseX - mouseX % w)/w), (int)((mouseY - mouseY % w)/w));
}

void draw()
{
  //prepare to draw grid
  background(0);
  noFill();
  strokeWeight(3);
  
  //draw grid
  grid.show();
  
  //prepare to draw backgroud of render
  fill(0);
  noStroke();
  square(width/2, 0, width/2);
  
  //draw separator
  stroke(0, 0, 255);
  strokeWeight(4);
  line(width/2, 0, width/2, height);
  
  //prepare to draw render
  stroke(255);
  strokeWeight(1);
  
  //loops through Points Array, perform transformations on those points,  stores transformed points in arrTransformedPoints then draws the points
  matrix.loopTransformation(grid.getArr(), angle);

  //angle = -0.5; 
  angle += 0.01;
}
