boolean velocitySaved = false;
int saveVelocities = 108000;
int ADD_PARTICLE_INDEX = 0;
int ADD_WALL_INDEX = 0;
color ROOM_PARTICLE_COLOR;
color COFFEE_PARTICLE_COLOR;
color CREAMER_PARTICLE_COLOR;
ArrayList<Particle> LR_particles = new ArrayList<Particle>();
ArrayList<Particle> LRC_particles = new ArrayList<Particle>();
ArrayList<Particle> RR_particles = new ArrayList<Particle>();
ArrayList<Particle> RRC_particles = new ArrayList<Particle>();
ArrayList<Particle> RRCREAMER_particles = new ArrayList<Particle>();
ArrayList<Particle> leftRoomParticles = new ArrayList<Particle>();
ArrayList<Particle> rightRoomParticles = new ArrayList<Particle>();
Integer[][] walls = new Integer[10][4];
Integer[] leftCoffeeCupInvisibleWallCupContents;
Integer[] leftCoffeeCupInvisibleWallAir;
Integer[] rightCoffeeCupInvisibleWallCupContents;
Integer[] rightCoffeeCupInvisibleWallAir;
Integer[] rightCreamerCupInvisibleWallCupContents;
Integer[] rightCreamerCupInvisibleWallAir;
int xCreamerCup;
int xCupLeftSide;
int xCupRightSide;
int yCup;

void saveVelocities() {
  JSONObject json = new JSONObject();
  json.setString("Left room particles velocity", ""+velocityToKelvin(averageVelocity(LR_particles)));
  json.setString("Left room coffee particles velocity", ""+velocityToKelvin(averageVelocity(LRC_particles)));
  json.setString("Right room particles velocity", ""+velocityToKelvin(averageVelocity(RR_particles)));
  json.setString("Right room coffee particles velocity", ""+velocityToKelvin(averageVelocity(RRC_particles)));
  json.setString("Right room creamer particles velocity", ""+velocityToKelvin(averageVelocity(RRCREAMER_particles)));
  saveJSONObject(json, "data/ParticleVelocities_" + month() + "-" + day() + "-" + year());
}

void setup() {
  frameRate(60);
}

void settings() {
  size(1400, 800);

  ROOM_PARTICLE_COLOR = color(171, 255, 241);
  COFFEE_PARTICLE_COLOR = color(117, 62, 18);
  CREAMER_PARTICLE_COLOR = color(255, 251, 215);

  // Create walls
  xCreamerCup = width/2+width/2/10;
  xCupLeftSide = (width/2)/5;
  xCupRightSide = (width/2)+3*(width/2/6);
  yCup = height/5*4;
  
  leftCoffeeCupInvisibleWallCupContents = new Integer[] {xCupLeftSide, yCup-2*(height/5), width/2-width/2/5, yCup-2*(height/5)};
  rightCoffeeCupInvisibleWallCupContents = new Integer[] {xCupRightSide, yCup-2*(height/5), (width-width/2/5), yCup-2*(height/5)};
  rightCreamerCupInvisibleWallCupContents = new Integer[] {xCreamerCup, yCup-height/5, (xCupRightSide-width/2/7), yCup-height/5};
  
  walls[ADD_WALL_INDEX++] = new Integer[] {width/2, -50, width/2, height+50};
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
    LR_particles.add(new Particle(
                                random(ROOM.PARTICLE_DIAMETER/2, width/2-ROOM.PARTICLE_DIAMETER/2),
                                random(ROOM.PARTICLE_DIAMETER/2, (yCup-2*(height/5))-ROOM.PARTICLE_DIAMETER/2),
                                ROOM.PARTICLE_DIAMETER/2,
                                ROOM_PARTICLE_COLOR)
                  .setMass(ROOM.MASS)
                  .setTemperature(303) // Kelvin
                  );
  // Create particles in the left room
  for (int rp = 0; rp < ROOM.NUMBER_OF_PARTICLES; rp++)
    RR_particles.add(new Particle(
                                random(width/2+ROOM.PARTICLE_DIAMETER/2, width-ROOM.PARTICLE_DIAMETER/2),
                                random(ROOM.PARTICLE_DIAMETER/2, (yCup-2*(height/5))-ROOM.PARTICLE_DIAMETER/2),
                                ROOM.PARTICLE_DIAMETER/2,
                                ROOM_PARTICLE_COLOR)
                  .setMass(ROOM.MASS)
                  .setTemperature(303) // Kelvin
                  );
  // Create coffee particles in the left room coffee cup
  for (int rp = 0; rp < COFFEE.NUMBER_OF_PARTICLES; rp++)
    LRC_particles.add(new Particle(
                                random(xCupLeftSide+COFFEE.PARTICLE_DIAMETER/2, (width/2-width/2/5)-COFFEE.PARTICLE_DIAMETER/2),
                                random((yCup-2*(height/5))+COFFEE.PARTICLE_DIAMETER/2, yCup-COFFEE.PARTICLE_DIAMETER/2),
                                COFFEE.PARTICLE_DIAMETER/2,
                                COFFEE_PARTICLE_COLOR)
                  .setMass(COFFEE.MASS)
                  .setTemperature(363) // Kelvin
                  );
  // Create creamer particles in the left room coffee cup
  for (int rp = 0; rp < COFFEE.NUMBER_OF_PARTICLES; rp++)
    LRC_particles.add(new Particle(
                                random(xCupLeftSide+CREAMER.PARTICLE_DIAMETER/2, (width/2-width/2/5)-CREAMER.PARTICLE_DIAMETER/2),
                                random((yCup-2*(height/5))+CREAMER.PARTICLE_DIAMETER/2, yCup-CREAMER.PARTICLE_DIAMETER/2),
                                CREAMER.PARTICLE_DIAMETER/2,
                                CREAMER_PARTICLE_COLOR)
                  .setMass(CREAMER.MASS)
                  .setTemperature(283.15) // Kelvin
                  );
  // Create particles in the right room coffee cup
  for (int rp = 0; rp < COFFEE.NUMBER_OF_PARTICLES; rp++)
    RRC_particles.add(new Particle(
                                random(xCupRightSide+COFFEE.PARTICLE_DIAMETER/2, (width-width/2/5)-COFFEE.PARTICLE_DIAMETER/2),
                                random((yCup-2*(height/5))+COFFEE.PARTICLE_DIAMETER/2, yCup-COFFEE.PARTICLE_DIAMETER/2),
                                COFFEE.PARTICLE_DIAMETER/2,
                                COFFEE_PARTICLE_COLOR)
                  .setMass(COFFEE.MASS)
                  .setTemperature(363) // Kelvin
                  );
  // Create particles in the right room creamer cup
  for (int rp = 0; rp < CREAMER.NUMBER_OF_PARTICLES; rp++)
    RRCREAMER_particles.add(new Particle(
                                random(xCreamerCup+CREAMER.PARTICLE_DIAMETER/2, (xCupRightSide-width/2/7)-CREAMER.PARTICLE_DIAMETER/2),
                                random((yCup-height/5)+CREAMER.PARTICLE_DIAMETER/2, yCup-CREAMER.PARTICLE_DIAMETER/2),
                                CREAMER.PARTICLE_DIAMETER/2,
                                CREAMER_PARTICLE_COLOR)
                  .setMass(CREAMER.MASS)
                  .setTemperature(283.15) // Kelvin
                  );
                  
                  
  leftRoomParticles.addAll(LR_particles);
  leftRoomParticles.addAll(LRC_particles);
  rightRoomParticles.addAll(RR_particles);
  rightRoomParticles.addAll(RRC_particles);
  rightRoomParticles.addAll(RRCREAMER_particles);
}

void draw() {
  strokeWeight(1);
  background(255);
  
  if (!velocitySaved && frameCount >= saveVelocities) {
    thread("saveVelocities");
    velocitySaved = true;
  }
  
  for (int i = 0; i < walls.length; i++)
    line(walls[i][0], walls[i][1],walls[i][2], walls[i][3]);
  for (Particle p : LR_particles) {
    p.show();
    p.update();
  }
  for (Particle p : LRC_particles) {
    p.show();
    p.update(leftCoffeeCupInvisibleWallCupContents);
  }
  
  for (Particle p : RR_particles) {
    p.show();
    p.update();
  }
  for (Particle p : RRC_particles) {
    p.show();
    p.update(rightCoffeeCupInvisibleWallCupContents);
  }
  for (Particle p : RRCREAMER_particles) {
    p.show();
    p.update(rightCreamerCupInvisibleWallCupContents);
  }

  checkCollision(leftRoomParticles, walls);
  checkCollision(rightRoomParticles, walls);
  
  fill(0);
  textSize(24);
  text("Average LR velocity:               " + velocityToKelvin(averageVelocity(LR_particles)), 25, 30);
  text("Average RR velocity:               " + velocityToKelvin(averageVelocity(RR_particles)), 25, 54);
  text("Average LRC velocity:             " + velocityToKelvin(averageVelocity(LRC_particles)), 25, 78);
  text("Average RR Coffee velocity:    " + velocityToKelvin(averageVelocity(RRC_particles)), 25, 102);
  text("Average RR Creamer velocity: " + velocityToKelvin(averageVelocity(RRCREAMER_particles)), 25, 126);
  noFill();
  // Right side of the room: Coffee and creamer in the room for 30 minutes and then mixed
}
