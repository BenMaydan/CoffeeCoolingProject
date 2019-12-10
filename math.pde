void switchVelocities(Point p1, Point p2) {
  // Adjust dx and dy for both particles to create an elastic collision
  // Write code here to do that
  float dxMiddle = p1.dx;
  float dyMiddle = p1.dy;
  p1.dx = p2.dx;
  p1.dy = p2.dy;
  p2.dx = dxMiddle;
  p2.dy = dyMiddle;
}

float getDist(float x1, float y1, float x2, float y2){
  float xDist = abs(x1 - x2);
  float yDist = abs(y1 - y2);
  float dist = sqrt(xDist*xDist + yDist*yDist);
  return dist;
}

boolean circleIntersectsLine(Point center, Integer[] seg) {
  // To do
  // Will do later if nobody else will
  // Note, a circle will intersect with a line segment if
  // It intersects with the line segment's line
  // or one of the end points is inside the circle
  return false;
}

boolean circleIntersectsCircle(Point p1, Point p2){
  float dist = getDist(p1.x, p1.y, p2.x, p2.y);
  return (dist < p1.radius + p2.radius);
}
