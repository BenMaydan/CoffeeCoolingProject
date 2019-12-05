class Point {
  float x, y;
  float dx, dy;
  float diameter;
  color c;
  Point(float startingX, float startingY, float dia, color col) {
    x = startingX;
    y = startingY;
    diameter = dia;
    c = col;
  }
  
  void multDX(float amount) { dx *= amount; }
  void multDY(float amount) { dy *= amount; }
  void addDX(float amount) { dx += amount; }
  void addDY(float amount) { dy += amount; }
  
  void updatePosition() { x += dx; y += dy; }
}




void drawParticle(Point p, color c) {
    fill(c);
    circle(p.x, p.y, p.diameter);
    noFill();
}

void particlesColliding(Point[] particles) {
  int iP1 = 2;
  Point p1 = particles[0];
  Point p2 = particles[1];
  for (int i = 0; i < particles.length; i++) {
    if (i == iP1)
      p1 = particles[i];
    if (i >= iP1) {
      p2 = particles[i];
    }
    if (i == particles.length-1)
      iP1++;

    if (p1 != p2) {
      // Particle collides with another particle
      if (pow(p2.x-p1.x, 2) + pow(p1.y-p2.y, 2) <= pow((p1.diameter/2)+(p2.diameter/2), 2))
        adjustVelocities(p1, p2);
      // Particle collides with wall
      // else if () {
      //   
      // }
    }
  }
}
