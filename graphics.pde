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

  double velocity() { return sqrt(dx*dx + dy*dy); }

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
  
  void showVelocity() {
    fill(0);
    strokeWeight(2);
    stroke(200, 0, 0);
    line(x, y, x+10*dx, y+10*dy);
    stroke(0);
    strokeWeight(1);
    noFill();
  }
}
