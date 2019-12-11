void switchVelocities(Particle p1, Particle p2) {
  // Make an elastic collision happen here
  
}

float velocity(float dx, float dy){
  return sqrt(dy*dx + dy*dy);
}

void checkCollision(ArrayList<Particle> particles, Integer[][] walls) {
  for (Particle p1 : particles) {
    particleBoundaryCollision(p1);
    for (Particle p2 : particles) {
      particleParticleCollision(p1, p2);
    }
     for (int wi = 0; wi < walls.length; wi++) {
       particleLineCollision(p1, walls[wi]);
     }
  }
}

boolean particleBoundaryCollision(Particle p) {
    if (p.x > width-p.radius) {
      p.x = width-p.radius;
      p.dx *= -1;
    } else if (p.x < p.radius) {
      p.x = p.radius;
      p.dx *= -1;
    } else if (p.y > height-p.radius) {
      p.y = height-p.radius;
      p.dy *= -1;
    } else if (p.y < p.radius) {
      p.y = p.radius;
      p.dy *= -1;
    }
    return p.x > width-p.radius || p.x < p.radius || p.y > height-p.radius || p.y < p.radius;
  }

boolean particleLineCollision(Particle p, Integer[] seg) {
  // To do
  // Will do later if nobody else will
  // Note, a circle will intersect with a line segment if
  // It intersects with the line segment's line
  // or one of the end Particles is inside the circle
  boolean collision = false;
  return collision;
}

boolean particleParticleCollision(Particle p1, Particle p2){
  boolean collision = dist(p1.x, p1.y, p2.x, p2.y) < p1.radius + p2.radius;
  return collision;
}
