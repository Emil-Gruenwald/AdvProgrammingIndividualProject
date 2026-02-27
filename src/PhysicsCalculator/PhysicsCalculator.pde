PImage logo = new PImage();

boolean pauseScreen = true;
boolean isPaused = true;
ArrayList<Force> forces = new ArrayList<>();
ArrayList<Object> objects = new ArrayList<>();
ArrayList<Button> pauseButtons = new ArrayList<>();

ArrayList<Character> keysPressed = new ArrayList<>();

int camX, camY, camZ, camRotX, camRotY;

void settings() {
  //size(640, 360, P3D);
  fullScreen(P3D);
  noSmooth();
  pixelDensity(2);
}

void setup() {
  background(0);
  frameRate(60);
  surface.setResizable(true);
  logo = loadImage("Logo.png");
  pauseButtons.add(new Button(10, 350, 200, 40, "Run Simulation"));
  pauseButtons.add(new Button(10, 400, 200, 40, "Settings"));
}

void draw() {
  if (pauseScreen) {
    displayPauseScreen();
  } else {
    displaySimulation();
  }
}

void displayPauseScreen() {
  background(0);
  fill(255);
  logo = loadImage("Logo.png");
  logo.resize(width,height);
  image(logo, 0, 0);
  for (Button b : pauseButtons) {
    b.update();
    b.display();
    if (b.isClicked() && b.label.equals("Run Simulation")) {
      pauseScreen = false;
      isPaused = false;
    }
  }
}
void displaySimulation() {
  background(0);
  lights();
  fill(255);

  if (keysPressed.contains('W')) camZ -= 5;
  if (keysPressed.contains('S')) camZ += 5;
  if (keysPressed.contains('A')) camX -= 5;
  if (keysPressed.contains('D')) camX += 5;
  if (keysPressed.contains('Q')) camY -= 5;
  if (keysPressed.contains('E')) camY += 5;
  if (keysPressed.contains('I')) camRotX -= 0.05;
  if (keysPressed.contains('K')) camRotX += 0.05;
  if (keysPressed.contains('J')) camRotY -= 0.05;
  if (keysPressed.contains('L')) camRotY += 0.05;

  camera(camX, camY, camZ, camRotX, camRotY, 0, 0, 1, 0);
  pushMatrix();
  translate(130, height/2, 0);
  rotateY(1.25);
  rotateX(-0.4);
  noStroke();
  box(100);
  popMatrix();

  displayGrid();
}

void displayGrid() {
  stroke(255);
  for (int i = -500; i <= 500; i += 50) {
    line(i, 0, -500, i, 0, 500);
    line(-500, 0, i, 500, 0, i); 
  }
}

void keyPressed() {
  char upperKey = Character.toUpperCase(key);
  if (!keysPressed.contains(upperKey)) {
    keysPressed.add(upperKey);
  }
}

void keyReleased() {
  char upperKey = Character.toUpperCase(key);
  keysPressed.remove(Character.valueOf(upperKey));
}