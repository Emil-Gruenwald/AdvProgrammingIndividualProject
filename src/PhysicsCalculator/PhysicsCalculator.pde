PImage logo = new PImage();

HUD hud = new HUD();

boolean pauseScreen = true;
boolean isPaused = true;
boolean settingsScreen = false;
boolean menuScreen = false;
boolean simulationScreen = false;
ArrayList<Force> forces = new ArrayList<>();
ArrayList<Object> objects = new ArrayList<>();
ArrayList<Button> pauseButtons = new ArrayList<>();
ArrayList<Button> simulationButtons = new ArrayList<>();
ArrayList<Button> settingsButtons = new ArrayList<>();
ArrayList<Button> menuButtons = new ArrayList<>();

ArrayList<Character> keysPressed = new ArrayList<>();

Dropdown addDropdown = new Dropdown(70, 10, 100, 40, "Add");
//Slider timeStepSlider = new Slider(200, 10, 100, 40, 2.0f, 0.1f, 0.1f, 1.0f);

String previousScreen = "pause";

float camX, camY, camZ, camRotX, camRotY;

float simulationSpeed = 1.0;
float timeStep = 0.01666;

boolean mouseJustReleased = false;

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
  textAlign(CENTER);
  textSize(12);
  noStroke();
  sphereDetail(18);
  pauseButtons.add(new Button(10, 350, 200, 40, "Run Simulation"));
  pauseButtons.add(new Button(10, 400, 200, 40, "Settings"));
  pauseButtons.add(new Button(10, 450, 200, 40, "Exit"));

  addDropdown.addOption("Dynamic Object");
  addDropdown.addOption("Static Object");
  addDropdown.addOption("Force");

  menuButtons.add(new Button(20, 70, 200, 40, "Settings"));
  menuButtons.add(new Button(20, 120, 200, 40, "Exit"));

  objects.add(new StaticObject(0, 0, 0, 0, 0, 0, color(0, 255, 0), new Rectangle(1000, 0, 1000)));
  objects.add(new DynamicObject(0, -200, 0, 0, 0, 0, color(255, 0, 0), new Rectangle(50, 50, 50)));
  objects.add(new DynamicObject(0, -100, 0, 0, 0, 0, color(255, 0, 0), new Sphere(25)));

  camX = 0;
  camRotX = 0;
  camRotY = 0;

  camZ = -500;
  camY = -100;
  
}

void draw() {
  if (settingsScreen) {
    hud.displaySettings(settingsButtons);
  } else if (pauseScreen) {
    hud.displayPauseScreen(pauseButtons);
  } else if (menuScreen) {
    displaySimulation(false, true);
    hud.displayMenu(menuButtons);
  } else if (simulationScreen) {
    background(100);
    if (!isPaused) {
      updateSimulation();
    }
    displaySimulation(true, true);
  }
  mouseJustReleased = false;
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

  //camera(camX, camY, camZ, camX + cos(camRotX) * sin(camRotY), camY + sin(camRotX), camZ + cos(camRotX) * cos(camRotY), 0, 1, 0);

  for (Object o : objects) {
    if (o instanceof DynamicObject) {
      ((DynamicObject) o).update();
    }
  }
}

void displaySimulation(boolean updateHUD, boolean showGrid) {
  background(100);
  camera(camX, camY, camZ, camX + cos(camRotX) * sin(camRotY), camY + sin(camRotX), camZ + cos(camRotX) * cos(camRotY), 0, 1, 0);
  //lights();
  fill(150);

  for (Object o : objects) {
    o.display();
  }

  if (showGrid) {
    displayGrid();
  }

  if (updateHUD) {
    hud.displaySimulation(simulationButtons, addDropdown, isPaused);
  }
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
      simulationScreen = true;
      isPaused = false;
    }
  }
  if (keyCode == ESC) {
    key = 0;
    if (pauseScreen) {
      exit();
    } else if (simulationScreen) {
      simulationScreen = false;
      menuScreen = true;
      isPaused = true;
    } else if (menuScreen) {
      menuScreen = false;
      simulationScreen = true;
      isPaused = false;
    } else if (settingsScreen) {
      settingsScreen = false;
      if (previousScreen.equals("pause")) {
        pauseScreen = true;
      } else if (previousScreen.equals("menu")) {
        menuScreen = true;
      }
    }
  }
  if (keyCode == SHIFT) {
    keysPressed.add('⇧');
  }
  if ((key == 'P' || key == 'p') && simulationScreen) {
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

void mousePressed() {
  if (mouseButton == LEFT) {
    if (!addDropdown.press()) {
      // float testX = camX;
      // float testY = camY;
      // float testZ = camZ;
      // for (int i = 0; i < 1000; i++) {
      //   testX += sin(camRotY);
      //   testZ += cos(camRotY);
      //   testY += sin(camRotX);
      //   for (Object o : objects) {
      //     if (o.collidesWith(new StaticObject(testX, testY, testZ, 0, 0, 0, color(255), new Sphere(5)))) {
      //       // isPaused = true;
      //       return;
      //     }
      //   }
      // }
    }
  }
}

void mouseReleased() {
  mouseJustReleased = true;
}

void mouseDragged() {
  if (simulationScreen && !isPaused && mouseButton == RIGHT) {
    camRotY += (pmouseX - mouseX) * 0.005;
    camRotX += (pmouseY - mouseY) * -0.005;
  }
}

