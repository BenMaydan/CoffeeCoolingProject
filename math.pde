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

float velocity(int dx, int dy){
  return sqrt(dy*dx + dy*dy);
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
  return (dist(p1.x, p1.y, p2.x, p2.y) < p1.radius + p2.radius);
}
