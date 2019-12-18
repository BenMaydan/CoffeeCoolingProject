int velocityToKelvin(float vel) {
    return (int)(vel*60.0);
  }

float averageVelocity(ArrayList<Particle> particles){
  float sumVelocities = 0;
  float size = 0;
  for (Particle p : particles) {
    sumVelocities += p.velocity();
    size++;
  }
  return sumVelocities/size;
}

void checkCollision(ArrayList<Particle> particles, Integer[][] walls) {
  for (Particle p1 : particles) {
    for (Particle p2 : particles)
      particleParticleCollision(p1, p2);
    for (Integer[] wall : walls)
      particleLineCollision(p1, wall, p1.velocity());
    if (p1.x < 0)       { p1.x = p1.radius;         p1.dx = -p1.dx; }
    if (p1.x > width)   { p1.x = width-p1.radius;   p1.dx = -p1.dx; }
    if (p1.y < 0)       { p1.y = p1.radius;         p1.dy = -p1.dy; }
    if (p1.y > height)  { p1.y = height-p1.radius;  p1.dy = -p1.dy; }
  }
}

boolean particleLineCollision(Particle p, Integer[] seg, float velocityAfterCollision) {
  float distX = seg[0]-seg[2];
  float distY = seg[1]-seg[3];
  float lineLength = sqrt(distX*distX + distY*distY);
  float r = (((p.x-seg[0])*(seg[2]-seg[0]))+((p.y-seg[1])*(seg[3]-seg[1])))/pow(lineLength, 2);
  
  // get x,y points of the closest point
  float closestX = seg[0] + r*(seg[2]-seg[0]);
  float closestY = seg[1] + r*(seg[3]-seg[1]);
  
  if (sqrt(pow(closestX - p.x, 2) + pow(closestY - p.y, 2)) <= p.radius && dist(seg[0], seg[1], closestX, closestY) + dist(closestX, closestY, seg[2], seg[3]) == dist(seg[0], seg[1], seg[2], seg[3])) {
    PVector baseDelta = PVector.sub(new PVector(seg[0], seg[1]), new PVector(seg[2], seg[3])).normalize();
    PVector normal = new PVector(-baseDelta.y, baseDelta.x);
    PVector velocity = new PVector(p.dx, p.dy);
    PVector incidence = PVector.mult(velocity, -1).normalize();
    float dot = incidence.dot(normal);
    velocity.set(2*normal.x*dot - incidence.x, 2*normal.y*dot - incidence.y, 0);
    p.dx = velocity.x * velocityAfterCollision;
    p.dy = velocity.y * velocityAfterCollision;
    return true;
  }
  return false;
}

boolean particleParticleCollision(Particle p1, Particle p2){
  // https://www.daniweb.com/programming/software-development/threads/514942/circle-ball-collision-problem  
  double ra = p1.radius; // radius
  double rb = p2.radius; // radius
  double radiiSquared = (ra + rb) * (ra + rb);  // square sum of radii
  double xDist = (p1.x + ra) - (p2.x + rb);
  double yDist = (p1.y + ra) - (p2.y + rb);
  double distSquared = xDist * xDist + yDist * yDist;
  if (distSquared > radiiSquared) return false; // balls don't touch
  // circles touch (or overlap) so they bounce off each other...
  double xVelocity = p2.dx - p1.dx;
  double yVelocity = p2.dy - p1.dy;
  double dotProduct = xDist * xVelocity + yDist * yVelocity;
  if (dotProduct > 0) { // moving towards each other
      double collisionScale = dotProduct / distSquared;
      double xCollision = xDist * collisionScale;
      double yCollision = yDist * collisionScale;
      //The Collision vector is the speed difference projected on the Dist vector,
      //thus it is the component of the speed difference needed for the collision.
      double combinedMass = (p1.radius*2) * (p1.radius*2) + (p2.radius*2) * (p2.radius*2); // mass porp. to area
      double collisionWeightA = 2* (p2.radius*2) * (p2.radius*2) / combinedMass;
      double collisionWeightB = 2* (p1.radius*2) * (p1.radius*2) / combinedMass;
      p1.dx += collisionWeightA * xCollision;
      p1.dy += collisionWeightA * yCollision;
      p2.dx -= collisionWeightB * xCollision;
      p2.dy -= collisionWeightB * yCollision;
      return true;
  }
  return false;
}
