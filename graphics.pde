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
  Point multDX(float amount) { dx *= amount; return this; }
  Point multDY(float amount) { dy *= amount; return this; }
  Point addDX(float amount) { dx += amount; return this; }
  Point addDY(float amount) { dy += amount; return this; }
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
        if (dist(p1.x, p1.y, p2.x, p2.y) <= min(p1.radius, p2.radius))
          switchVelocities(p1, p2);
      }
    }
    for (int wi = 0; wi < walls.length; wi++) {
      // check for collision
      Integer[] w = walls[wi];
      //float theta = atan(p1.dy/p1.dx);
      //print(theta);
      //float nx = p1.x+(p1.radius*cos(theta));
      //float ny = p1.x+(p1.radius*sin(theta));
      //fill(100);
      //circle(nx, ny, p1.radius*2);
      if (
    }
  }
}

float[] pointOnCircle(int x, int y, float rad, float radians) {
  return new float[] {x+(rad * cos(radians)), y+(rad * sin(radians))};
}
