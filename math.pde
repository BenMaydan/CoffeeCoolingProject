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

boolean circleIntersectsLine(Point p1, Integer[] wall) {
  return true;
}

boolean circleIntersectsCircle(Point p1, Point p2){
  // Note that radsum is the sum of the circle radii
  float xDist = abs(p1.x - p2.x);
  float yDist = abs(p1.y - p2.y);
  float dist = sqrt(xDist*xDist + yDist * yDist);
  return dist < p1.radius+p1.radius;
}
