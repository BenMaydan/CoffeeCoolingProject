int ADD_PARTICLE_INDEX = 0;
int ADD_WALL_INDEX = 0;
color ROOM_PARTICLE_COLOR;
color COFFEE_PARTICLE_COLOR;
color CREAMER_PARTICLE_COLOR;
ArrayList<Particle> LR_particles = new ArrayList<Particle>();
ArrayList<Particle> RR_particles = new ArrayList<Particle>();
Integer[][] walls = new Integer[10][4];

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


  // Create LR_particles in the left room
  for (int rp = 0; rp < ROOM.NUMBER_OF_PARTICLES; rp++)
    LR_particles.add(new Particle(
                                random(ROOM.PARTICLE_DIAMETER/2, width/2-ROOM.PARTICLE_DIAMETER/2),
                                random(ROOM.PARTICLE_DIAMETER/2, (yCup-2*(height/5))-ROOM.PARTICLE_DIAMETER/2),
                                ROOM.PARTICLE_DIAMETER/2,
                                ROOM_PARTICLE_COLOR)
                  .setVelocity(random(-5, 5), random(-5, 5))
                  .setMass(ROOM.MASS)
                  .setSpecificHeat(ROOM.SPECIFIC_HEAT)
                  .setTemperature(20)
                  );
  // Create RR_particles in the left room
  for (int rp = 0; rp < ROOM.NUMBER_OF_PARTICLES; rp++)
    RR_particles.add(new Particle(
                                random(width/2+ROOM.PARTICLE_DIAMETER/2, width-ROOM.PARTICLE_DIAMETER/2),
                                random(ROOM.PARTICLE_DIAMETER/2, (yCup-2*(height/5))-ROOM.PARTICLE_DIAMETER/2),
                                ROOM.PARTICLE_DIAMETER/2,
                                ROOM_PARTICLE_COLOR)
                  .setVelocity(random(-5, 5), random(-5, 5))
                  .setMass(ROOM.MASS)
                  .setSpecificHeat(ROOM.SPECIFIC_HEAT)
                  .setTemperature(20)
                  );
}

void draw() {
  strokeWeight(1);
  background(255);
  for (int i = 0; i < walls.length; i++)
    line(walls[i][0], walls[i][1],walls[i][2], walls[i][3]);
  for (Particle p : LR_particles) {
    p.show();
    p.update(1);
  }
  for (Particle p : RR_particles) {
    p.show();
    p.update(1);
  }

  // Left room particle collision
  checkCollision(LR_particles, walls);
  // Right room particle collision
  checkCollision(RR_particles, walls);
  
  fill(0);
  textSize(24);
  text("Average velocity: " + roundDecimal(averageVelocity(LR_particles), 3), 25, 30);
  noFill();
  // Right side of the room: Coffee and creamer in the room for 30 minutes and then mixed
}
