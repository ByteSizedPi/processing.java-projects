int numPoints = 20;
PVector[] points = new PVector[numPoints];
int w = 600;
PVector player;

void setup() {
  player = new PVector(random(w), random(w));
  size(600, 600);
  for (int i = 0; i < numPoints; i++) {
    points[i] = new PVector(random(w), random(w));
  }
}

void draw() {
  background(255);
  strokeWeight(5);
  stroke(255, 0, 0);
  point(player.x, player.y);
  for (int i = 0; i < numPoints; i++) {
    stroke(0);
    point(points[i].x, points[i].y);
  }
  
  int j = minVal(points);
  stroke(125);
  strokeWeight(1);
  line(points[floor(j)].x, points[floor(j)].y, player.x, player.y);
}

int minVal(PVector arr[]) {
  float minDist = sqrt(2 * w * w);
  int minIndex = 0;
  for (int i = 0; i < numPoints; i++) {
    if (dist(arr[i].x, arr[i].y, player.x, player.y) < minDist) {
      minDist = dist(arr[i].x, arr[i].y, player.x, player.y);
      minIndex = i;
    }
  }
  return minIndex;
}
