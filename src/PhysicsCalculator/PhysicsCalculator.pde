PImage logo = new PImage();

HUD hud = new HUD();

boolean pauseScreen = true;
boolean isPaused = true;
ArrayList<Force> forces = new ArrayList<>();
ArrayList<Object> objects = new ArrayList<>();
ArrayList<Button> pauseButtons = new ArrayList<>();
ArrayList<Button> simulationButtons = new ArrayList<>();
ArrayList<Button> settingsButtons = new ArrayList<>();
ArrayList<Button> menuButtons = new ArrayList<>();

ArrayList<Character> keysPressed = new ArrayList<>();

float camX, camY, camZ, camRotX, camRotY;

void settings() {
  //size(640, 360, P3D);
  fullScreen(P3D);
  noSmooth();
  // pixelDensity(2);
}

void setup() {
  background(100);
  frameRate(60);
  surface.setResizable(true);
  logo = loadImage("Logo.png");
  pauseButtons.add(new Button(10, 350, 200, 40, "Run Simulation"));
  pauseButtons.add(new Button(10, 400, 200, 40, "Settings"));
  pauseButtons.add(new Button(10, 450, 200, 40, "Exit"));

  simulationButtons.add(new Button(10, 10, 50, 40, "Add"));

  objects.add(new StaticObject(0, 0, 0, 1000, 0, 1000, 0, 0, 0));
}

void draw() {
  if (pauseScreen) {
    hud.displayPauseScreen(pauseButtons);
  } else {
    if (!isPaused) {
      updateSimulation();
    }
    displaySimulation();
  }
}

void updateSimulation() {
  if (keysPressed.contains('W')) {
    camX += 5 * sin(camRotY);
    camZ += 5 * cos(camRotY);
  }
  if (keysPressed.contains('S')) {
    camX -= 5 * sin(camRotY);
    camZ -= 5 * cos(camRotY);
  }
  if (keysPressed.contains('A')) {
    camX += 5 * cos(camRotY);
    camZ -= 5 * sin(camRotY);
  }
  if (keysPressed.contains('D')) {
    camX -= 5 * cos(camRotY);
    camZ += 5 * sin(camRotY);
  }

  if (keysPressed.contains(' ')) camY -= 5;
  if (keysPressed.contains('⇧')) camY += 5;

  if (keysPressed.contains('I')) camRotX += .05;
  if (keysPressed.contains('K')) camRotX -= .05;
  if (keysPressed.contains('J')) camRotY += .05;
  if (keysPressed.contains('L')) camRotY -= .05;

  if (camRotY > 2*PI) camRotY -= 2*PI;
  if (camRotY < 0) camRotY += 2*PI;
  if (camRotX >= PI/2) camRotX = PI/2 - 0.01;
  if (camRotX <= -PI/2) camRotX = -PI/2 + 0.01;

  camera(camX, camY, camZ, camX + cos(camRotX) * sin(camRotY), camY + sin(camRotX), camZ + cos(camRotX) * cos(camRotY), 0, 1, 0);
}

void displaySimulation() {
  background(100);
  lights();
  fill(255);

  for (Object o : objects) {
    o.display();
  }

  displayGrid();

  hud.displaySimulation(simulationButtons, isPaused);
}

void displayGrid() {
  stroke(200, 20);
  line(0, -3000, 0, 0, 3000, 0);

  float gridRadius = 3000;
  float step = 50;

  float startX = camX - gridRadius;
  startX -= startX % step;
  float endX = camX + gridRadius;
  endX -= endX % step;

  float startZ = camZ - gridRadius;
  startZ -= startZ % step;
  float endZ = camZ + gridRadius;
  endZ -= endZ % step;

  for (float x = startX; x <= endX; x += step) {
    stroke(200, map(abs(x - camX), 0, gridRadius, 20, -10));
    line(x, 0, startZ, x, 0, endZ);
  }

  for (float z = startZ; z <= endZ; z += step) {
    stroke(200, map(abs(z - camZ), 0, gridRadius, 20, -10));
    line(startX, 0, z, endX, 0, z);
  }
}

void keyPressed() {
  char upperKey = Character.toUpperCase(key);
  if (!keysPressed.contains(upperKey)) {
    keysPressed.add(upperKey);
  }
  if (keyCode == ENTER) {
    if (pauseScreen) {
      pauseScreen = false;
      isPaused = false;
    }
  }
  if (keyCode == ESC) {
    key = 0;
    if (!pauseScreen) {
      pauseScreen = true;
      isPaused = true;
    } else {
      exit();
    }
  }
  if (keyCode == SHIFT) {
    keysPressed.add('⇧');
  }
  if ((key == 'P' || key == 'p') && !pauseScreen) {
    isPaused = !isPaused;
  }
}

void keyReleased() {
  char upperKey = Character.toUpperCase(key);
  keysPressed.remove(Character.valueOf(upperKey));
  if (keyCode == SHIFT) {
    keysPressed.remove(Character.valueOf('⇧'));
  }
}

void mouseDragged() {
  if (!pauseScreen && !isPaused) {
    camRotY += (pmouseX - mouseX) * 0.005;
    camRotX += (pmouseY - mouseY) * -0.005;
  }
}