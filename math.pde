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

boolean circleIntersectsLine(Integer x1, Integer y1, Integer x2, Integer y2, float x3, float y3, float radius) {
  Integer a = y1 - y2;
  Integer b = x2 - x1;
  float dist = abs(a*x3 + b*y3 + (x1*y2 - x2*y1)) / sqrt(a*a + b*b);
  return radius == dist || radius > dist;
}

boolean circleIntersectsCircle(Integer x1, Integer y1, Integer x2, Integer y2, float radsum){
  // Note that radsum is the sum of the circle radii
  Integer xDist = abs(x1 - x2);
  Integer yDist = abs(y1 - y2);
  
  float dist = sqrt(xDist*xDist + yDist * yDist);
  
  if (dist < radsum) {return true;}
  return false;
}
