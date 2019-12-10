class Point {
  float x, y;
  float dx, dy;
  float radius;
  color c;
  Point(float startingX, float startingY, float dia, color col) {
    x = startingX;
    y = startingY;
    radius = dia/2;
    c = col;
  }
  
  Point setDXY(float xv, float yv) { dx = xv; dy = yv; return this; }
  Point updatePosition() { x += dx; y += dy; return this; }
}




void drawParticle(Point p) {
    fill(p.c);
    circle(p.x, p.y, p.radius*2);
    noFill();
}

void particleCollision(ArrayList<Point> particles, Integer[][] walls) {
  for (Point p1 : particles) {
    for (Point p2 : particles) {
      if (p1 != p2) {
        if (circleIntersectsCircle(p1, p2))
          switchVelocities(p1, p2);
      }
    }
    for (int wi = 0; wi < walls.length; wi++) {
      // Circle line collision
      if (circleIntersectsLine(p1, walls[wi]))
        // Do code here
        p1.dx = -p1.dx;
        p1.dy = -p1.dy;
    }
  }
}
