int ADD_PARTICLE_INDEX = 0;
int ADD_WALL_INDEX = 0;
color ROOM_PARTICLE_COLOR;
color COFFEE_PARTICLE_COLOR;
color CREAMER_PARTICLE_COLOR;
ArrayList<Particle> particles = new ArrayList<Particle>();
Integer[][] walls = new Integer[14][4];

void settings() {
  size(1400, 800);
  ROOM_PARTICLE_COLOR = color(171, 255, 241);
  COFFEE_PARTICLE_COLOR = color(117, 62, 18);
  CREAMER_PARTICLE_COLOR = color(255, 251, 215);


  // Create walls
  int xCreamerCup = width/2+width/2/10;
  int xCupLeftSide = (width/2)/5;
  int xCupRightSide = (width/2)+3*(width/2/6);
  int yCup = height/5*4;
  walls[ADD_WALL_INDEX++] = new Integer[] {0, height-1, width, height-1};
  walls[ADD_WALL_INDEX++] = new Integer[] {width-1, height, width-1, 0};
  walls[ADD_WALL_INDEX++] = new Integer[] {0, 1, width, 1};
  walls[ADD_WALL_INDEX++] = new Integer[] {1, 0, 1, height};
  walls[ADD_WALL_INDEX++] = new Integer[] {width/2, 0, width/2, height};

  walls[ADD_WALL_INDEX++] = new Integer[] {xCupLeftSide, yCup, xCupLeftSide, yCup-2*(height/5)};
  walls[ADD_WALL_INDEX++] = new Integer[] {xCupLeftSide, yCup, width/2-width/2/5, yCup};
  walls[ADD_WALL_INDEX++] = new Integer[] {width/2-width/2/5, yCup, width/2-width/2/5, yCup-2*(height/5)};
  walls[ADD_WALL_INDEX++] = new Integer[] {xCupRightSide, yCup, xCupRightSide, yCup-2*(height/5)};
  walls[ADD_WALL_INDEX++] = new Integer[] {xCupRightSide, yCup, width-width/2/5, yCup};
  walls[ADD_WALL_INDEX++] = new Integer[] {width-width/2/5, yCup, width-width/2/5, yCup-2*(height/5)};

  walls[ADD_WALL_INDEX++] = new Integer[] {xCreamerCup, yCup, xCreamerCup, yCup-height/5};
  walls[ADD_WALL_INDEX++] = new Integer[] {xCreamerCup, yCup, xCupRightSide-width/2/7, yCup};
  walls[ADD_WALL_INDEX++] = new Integer[] {xCupRightSide-width/2/7, yCup, xCupRightSide-width/2/7, yCup-height/5};


  // Create particles in the left room
  for (int rp = 0; rp < ROOM.NUMBER_OF_PARTICLES; rp++)
    particles.add(new Particle(random(ROOM.PARTICLE_DIAMETER/2, width/2-ROOM.PARTICLE_DIAMETER/2), random(ROOM.PARTICLE_DIAMETER/2, (yCup-2*(height/5))-ROOM.PARTICLE_DIAMETER/2), ROOM.PARTICLE_DIAMETER, ROOM_PARTICLE_COLOR).multVelocity(random(-3, 3)));
}

void draw() {
  background(255);
  for (int i = 0; i < walls.length; i++)
    line(walls[i][0], walls[i][1],walls[i][2], walls[i][3]);
  for (Particle p : particles) {
    drawParticle(p);
    p.update();
  }
  checkCollision(particles, walls);
  // Right side of the room: Coffee and creamer in the room for 30 minutes and then mixed
}
