class Particle {
  float x;
  float y;
  float dx;
  float dy;
  float radius;
  color c;
  double MASS;
  double SPECIFIC_HEAT;
  double TEMPERATURE;

  Particle(float nx, float ny, float r, color colour) {
    x = nx;
    y = ny;
    radius = r;
    c = colour;
  }
  
  Particle setVelocity(float ndx, float ndy) { dx = ndx; dy = ndy; return this; }
  Particle setMass(double nmass) { MASS = nmass; return this; }
  Particle setSpecificHeat(double nspecificheat) { SPECIFIC_HEAT = nspecificheat; return this; }
  Particle setTemperature(double ntemp) { TEMPERATURE = ntemp; return this; }

  Particle update(int amount) {
    x += dx;
    y += dy;
    return this;
  }
  
  void show() {
    fill(c);
    circle(x, y, radius*2);
    noFill();
  }

  void checkBoundaryCollision() {
    if (x > width-radius) {
      x = width-radius;
      dx *= -1;
    } else if (x < radius) {
      x = radius;
      dx *= -1;
    } else if (y > height-radius) {
      y = height-radius;
      dy *= -1;
    } else if (y < radius) {
      y = radius;
      dy *= -1;
    }
  }
}

void checkCollision(ArrayList<Particle> particles, Integer[][] walls) {
  for (Particle p1 : particles) {
    p1.checkBoundaryCollision();
    for (Particle p2 : particles) {
      particleParticleCollision(p1, p2);
    }
     for (int wi = 0; wi < walls.length; wi++) {
       particleLineCollision(p1, walls[wi]);
     }
  }
}
