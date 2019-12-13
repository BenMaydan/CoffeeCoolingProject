class Particle {
  float x;
  float y;
  float dx;
  float dy;
  float radius;
  color c;
  double MASS;
  double specific_heat;
  double temperature;

  Particle(float nx, float ny, float r, color colour) {
    x = nx;
    y = ny;
    radius = r;
    c = colour;
  }

  Particle setMass(double nmass) { MASS = nmass; return this; }
  Particle setSpecificHeat(double nspecificheat) { specific_heat = nspecificheat; return this; }
  Particle setTemperature(double tempInKelvin) {
    temperature = tempInKelvin/60;
    float randRadians = radians(random(0, 360));
    dx = cos(randRadians)*(float)temperature;
    dy = sin(randRadians)*(float)temperature;
    return this;
  }

  float velocity() { return sqrt(dx*dx + dy*dy); }

  Particle update() {
    x += dx;
    y += dy;
    return this;
  }
  Particle multiply(float amount) {
    dx *= amount;
    dy *= amount;
    return this;
  }
  
  Particle update(Integer[] cupWall) {
    particleLineCollision(this, cupWall, velocity());
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
