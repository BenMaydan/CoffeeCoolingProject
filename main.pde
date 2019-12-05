color COFFEE_COLOR;
color CREAMER_COLOR;
Point[] particles = new Point[ROOM.NUMBER_OF_PARTICLES + COFFEE.NUMBER_OF_PARTICLES + CREAMER.NUMBER_OF_PARTICLES];

void settings() {
  size(800, 800);
  COFFEE_COLOR = color(117, 62, 18);
  CREAMER_COLOR = color(255, 251, 215);
  // Create particles
}

void draw() {
  // Separate the room into two parts
  line(width/2, 0, width/2, height);
  
  // Left side of the room: Coffee + Creamer mixed immediately
  int xCupLeftSide = (width/2)/5;
  int yCupLeftSide = height/5*4;
  line(xCupLeftSide, yCupLeftSide, xCupLeftSide, yCupLeftSide-2*(height/5));
  line(xCupLeftSide, yCupLeftSide, xCupLeftSide+3*((width/2)/5), yCupLeftSide);
  line(xCupLeftSide+3*((width/2)/5), yCupLeftSide, xCupLeftSide+3*((width/2)/5), yCupLeftSide-2*(height/5));
  
  // Right side of the room: Coffee and creamer in the room for 30 minutes and then mixed
}
