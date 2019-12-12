double roundDecimal(double num, int numAfterDecimal) {
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
  double dist;
  float v1x = seg[2] - seg[0];
  float v1y = seg[3] - seg[1];
  float v2x = p.x - seg[0];
  float v2y = p.y - seg[1];
  // get the unit distance along the line of the closest point to
  // circle center
  double u = (v2x * v1x + v2y * v1y) / (v1y * v1y + v1x * v1x);
  
  
  // if the point is on the line segment get the distance squared
  // from that point to the circle center
  if(u >= 0 && u <= 1){
      dist = pow((float)(seg[0] + v1x * u - p.x), 2) + pow((float)(seg[1] + v1y * u - p.y), 2);
  } else {
      // if closest point not on the line segment
      // use the unit distance to determine which end is closest
      // and get dist square to circle
      dist = u < 0 ?
            pow(seg[0] - p.x, 2) + pow(seg[1] - p.y, 2) :
            pow(seg[2] - p.x, 2) + pow(seg[3] - p.y, 2);
  }
  
  if (dist < p.radius * p.radius) {
    p.dx = -p.dx;
    p.dy = -p.dy;
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
