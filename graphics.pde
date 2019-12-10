class Particle {
  PVector position;
  PVector velocity;
  color c;
  float radius, m;

  Particle(float x, float y, float r_, color colour) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    radius = r_;
    m = radius*.1;
    c = colour;
  }
  
  Particle multVelocity(float amount) {
    velocity.mult(amount);
    return this;
  }

  Particle update() {
    position.add(velocity);
    return this;
  }

  void checkBoundaryCollision() {
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
    }
  }

  void particleParticleCollision(Particle other) {
    // https://processing.org/examples/circlecollision.html
    //   for more information
    PVector distanceVect = PVector.sub(other.position, position);
    float distanceVectMag = distanceVect.mag();
    float minDistance = radius + other.radius;
    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.add(correctionVector);
      position.sub(correctionVector);
      float theta  = distanceVect.heading();
      float sine = sin(theta);
      float cosine = cos(theta);
      PVector[] bTemp = { new PVector(), new PVector() };
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;
      PVector[] vTemp = { new PVector(), new PVector() };
      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;
      PVector[] vFinal = { new PVector(), new PVector() };
      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;
      PVector[] bFinal = { new PVector(), new PVector() };
      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;
      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;
      position.add(bFinal[0]);
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }
  
  void particleLineCollision(Integer[] seg) {
    // https://github.com/jeffThompson/CollisionDetectionFunctionsForProcessing/blob/master/ballLine/ballLine.pde
    //   for more info
    // first get the length of the line using the Pythagorean theorem
    float distX = seg[0]-seg[2];
    float distY = seg[1]-seg[3];
    float lineLength = sqrt((distX*distX) + (distY*distY));
  
    // then solve for r
    float r = (((position.x-seg[0])*(seg[2]-seg[0]))+((position.y-seg[1])*(seg[3]-seg[1])))/pow(lineLength, 2);
  
    // get x,y points of the closest point
    float closestX = seg[0] + r*(seg[2]-seg[0]);
    float closestY = seg[1] + r*(seg[3]-seg[1]);
  
    // to get the length of the line, use the Pythagorean theorem again
    float distToPointX = closestX - position.x;
    float distToPointY = closestY - position.y;
    float distToPoint = sqrt(pow(distToPointX, 2) + pow(distToPointY, 2));

    if (distToPoint <= radius && dist(seg[0], seg[1], closestX, closestY) + dist(closestX, closestY, seg[2], seg[3]) == dist(seg[0], seg[1], seg[2], seg[3])) {
      velocity.x = -velocity.x;
      velocity.y = -velocity.y;
      for (int i = 0; i < 3; i++)
        update();
    }
  }
}


void drawParticle(Particle p) {
    fill(p.c);
    circle(p.position.x, p.position.y, p.radius*2);
    noFill();
}

void checkCollision(ArrayList<Particle> particles, Integer[][] walls) {
  for (Particle p1 : particles) {
    p1.checkBoundaryCollision();
    for (Particle p2 : particles) {
      p1.particleParticleCollision(p2);
    }
     for (int wi = 0; wi < walls.length; wi++) {
       p1.particleLineCollision(walls[wi]);
     }
  }
}
