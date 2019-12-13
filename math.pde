double truncateDecimal(double num, int numAfterDecimal) {
  String s = ""+num;
  return Double.parseDouble(s.substring(0, s.indexOf(".")+1+numAfterDecimal));
}

double averageVelocity(ArrayList<Particle> particles){
  double sumVelocities = 0;
  int size = 0;
  for (Particle p : particles) {
    sumVelocities += p.velocity();
    size++;
  }
  return sumVelocities/particles.size();
}

void checkCollision(ArrayList<Particle> particles, Integer[][] walls) {
  for (Particle p1 : particles) {
    for (Particle p2 : particles)
      particleParticleCollision(p1, p2);
    for (Integer[] wall : walls)
      particleLineCollision(p1, wall, p1.velocity());
    if (p1.x < 0)       p1.dx = -p1.dx;
    if (p1.x > width)   p1.dx = -p1.dx;
    if (p1.y < 0)       p1.dy = -p1.dy;
    if (p1.y > height)  p1.dy = -p1.dy;
  }
}

boolean particleLineCollision(Particle p, Integer[] seg, float velocityAfterCollision) {
  double dist;
  float v1x = seg[2] - seg[0];
  float v1y = seg[3] - seg[1];
  float v2x = p.x - seg[0];
  float v2y = p.y - seg[1];
  double u = (v2x * v1x + v2y * v1y) / (v1y * v1y + v1x * v1x);
  if (u >= 0 && u <= 1)
      dist = pow((float)(seg[0] + v1x * u - p.x), 2) + pow((float)(seg[1] + v1y * u - p.y), 2);
  else
      dist = u < 0 ? pow(seg[0] - p.x, 2) + pow(seg[1] - p.y, 2) : pow(seg[2] - p.x, 2) + pow(seg[3] - p.y, 2);
  if (dist < p.radius * p.radius || dist(seg[0], seg[1], p.x, p.y) < p.radius || dist(seg[2], seg[3], p.x, p.y) < p.radius) {
    PVector baseDelta = PVector.sub(new PVector(seg[0], seg[1]), new PVector(seg[2], seg[3])).normalize();
    PVector normal = new PVector(-baseDelta.y, baseDelta.x);
    PVector velocity = new PVector(p.dx, p.dy);
    PVector incidence = PVector.mult(velocity, -1).normalize();
    float dot = incidence.dot(normal);
    velocity.set(2*normal.x*dot - incidence.x, 2*normal.y*dot - incidence.y, 0);
    p.dx = velocity.x * velocityAfterCollision;
    p.dy = velocity.y * velocityAfterCollision;
  }
  return dist < p.radius * p.radius;
}

boolean particleParticleCollision(Particle p1, Particle p2){
  // https://www.daniweb.com/programming/software-development/threads/514942/circle-ball-collision-problem
  boolean collision = dist(p1.x, p1.y, p2.x, p2.y) < p1.radius + p2.radius;
  if (collision) {
    double xDist = (p1.x + p1.radius) - (p2.x + p2.radius);
    double yDist = (p1.y + p1.radius) - (p2.y + p2.radius);
    double distSquared = xDist * xDist + yDist * yDist;
    double xVelocity = p2.dx - p1.dx;
    double yVelocity = p2.dy - p1.dy;
    double dotProduct = xDist * xVelocity + yDist * yVelocity;
    if (dotProduct > 0) { // moving towards each other
        double collisionScale = dotProduct / distSquared;
        double xCollision = xDist * collisionScale;
        double yCollision = yDist * collisionScale;
        //The Collision vector is the speed difference projected on the Dist vector,
        //thus it is the component of the speed difference needed for the collision.
        double combinedMass = p1.radius * p1.radius + p2.radius * p2.radius; // mass porp. to area
        double collisionWeightA = 2* p2.radius * p2.radius / combinedMass;
        double collisionWeightB = 2* p1.radius * p1.radius / combinedMass;
        p1.dx += collisionWeightA * xCollision;
        p1.dy += collisionWeightA * yCollision;
        p2.dx -= collisionWeightB * xCollision;
        p2.dy -= collisionWeightB * yCollision;
    }
  }
  return collision;
}
