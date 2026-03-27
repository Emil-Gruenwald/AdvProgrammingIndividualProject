import bRigid.*;
import bRigid.util.*;
import bRigid.test.*;
import javax.vecmath.Vector3f;

BPhysics physics;

PImage logo = new PImage();

HUD hud = new HUD();

int fps = 60;

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
ArrayList<Textbox> textboxes = new ArrayList<>();

ArrayList<Character> keysPressed = new ArrayList<>();

Dropdown addDropdown = new Dropdown(70, 15, 100, 40, "Add");

Object selectedObject = null;
Textbox selectedTextbox = null;
//Slider timeStepSlider = new Slider(200, 10, 100, 40, 2.0f, 0.1f, 0.1f, 1.0f);

String previousScreen = "pause";

float camX, camY, camZ, camRotX, camRotY;

float simulationSpeed = 1.0;
float timeStep = 0.01666;

boolean mouseJustReleased = false;
boolean typing = false;

void settings() {
  //size(640, 360, P3D);
  fullScreen(P3D);
  noSmooth();
  // pixelDensity(2);
}

void setup() {
  background(100);
  frameRate(fps);

  physics = new BPhysics();
  physics.world.setGravity(new Vector3f(0, 9.81 * fps, 0));
  //surface.setResizable(true);
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

  // objects.add(new StaticObject(0, 0, 0, 0, 0, 0, color(0, 255, 0), new Rectangle(1000, 0, 1000)));
  // objects.add(new DynamicObject(0, -200, 0, 0, 0, 0, color(255, 0, 0), new Rectangle(50, 50, 50), new BBox(this, 1, 15, 60, 15)));
  // objects.add(new DynamicObject(0, -100, 0, 0, 0, 0, color(255, 0, 0), new Sphere(25), new BSphere(this, 2, 0, 0, 0, 20)));

  objects.add(new StaticObject(0, 0, 0, 1000, 1, 1000, color(0, 255, 0)));
  objects.add(new DynamicObject(0, -100, 0, 50, 2, color(255, 0, 0)));
  objects.add(new DynamicObject(10, -200, 0, 50, 50, 50, 2, color(255, 0, 0)));

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
      physics.update();
    }
    displaySimulation(true, true);
  }
  mouseJustReleased = false;
}

void updateCamera() {
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

  // for (Object o : objects) {
  //   if (o instanceof DynamicObject) {
  //     ((DynamicObject) o).update();
  //   }
  // }
}

void displaySimulation(boolean updateHUD, boolean showGrid) {
  background(100);
  updateCamera();
  camera(camX, camY, camZ, camX + cos(camRotX) * sin(camRotY), camY + sin(camRotX), camZ + cos(camRotX) * cos(camRotY), 0, 1, 0);
  //lights();
  fill(150);

  for (Object o : objects) {
    o.display();
    // o.displayBRigid();
  }

  if (showGrid) {
    displayGrid();
  }

  if (updateHUD) {
    hud.displaySimulation(simulationButtons, addDropdown, isPaused);
  }

  if (selectedObject != null) {
    hud.displayObjectInfo();
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

boolean isMouseOver(Object o) {
  if (o.type.equals("Box")) {
    BBox b = (BBox) o.body;
    Vector3f pos = b.getPosition();
    float sx = screenX(pos.x, pos.y, pos.z);
    float sy = screenY(pos.x, pos.y, pos.z);

    float size = max(o.width, o.height);
    float edgeX = screenX(pos.x + size/2, pos.y, pos.z);
    float edgeY = screenY(pos.x + size/2, pos.y, pos.z);
    float sr = dist(sx, sy, edgeX, edgeY);

    if (dist(mouseX, mouseY, sx, sy) < sr) {
      return true;
    }
  } else if (o.type.equals("Sphere")) {
    BSphere s = (BSphere) o.body;
    Vector3f pos = s.getPosition();

    float sx = screenX(pos.x, pos.y, pos.z);
    float sy = screenY(pos.x, pos.y, pos.z);

    float edgeX = screenX(pos.x + o.radius, pos.y, pos.z);
    float edgeY = screenY(pos.x + o.radius, pos.y, pos.z);
    float sr = dist(sx, sy, edgeX, edgeY);

    if (dist(mouseX, mouseY, sx, sy) < sr) {
      return true;
    }
  }
  return false;
}

void keyPressed() {
  char upperKey = Character.toUpperCase(key);
  if (!keysPressed.contains(upperKey)) {
    keysPressed.add(upperKey);
  }

  if (keyCode == ENTER) {
    if (typing) {
      selectedTextbox.enter();
    } else if (pauseScreen) {
      pauseScreen = false;
      simulationScreen = true;
      isPaused = false;
    }
  }
  if (keyCode == ESC) {
    key = 0;
    if (typing) {
      selectedTextbox.escape();
    } else if (selectedObject != null) {
      selectedObject = null;
      textboxes.clear();
    } else if (pauseScreen) {
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

  if (keyCode == BACKSPACE && typing) {
    if (selectedTextbox.label.length() > 0) {
      selectedTextbox.label = selectedTextbox.label.substring(0, selectedTextbox.label.length() - 1);
    }
  }
  if (typing) {
    if ((key >= '0' && key <= '9') || key == '.' || key == '-') {
      selectedTextbox.label += key;
    }
  } else {
    if ((key == 'P' || key == 'p') && simulationScreen) {
      isPaused = !isPaused;
    }
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
      if (simulationScreen) {
        for (Object o : objects) {
          if (isMouseOver(o)) {
            selectedObject = o;
            textboxes.add(new Textbox(200, 50, 80, 30, String.format("%.1f", o.mass)));
            textboxes.add(new Textbox(200, 90, 80, 30, String.format("%.1f", o.x)));
            textboxes.add(new Textbox(200, 130, 80, 30, String.format("%.1f", o.y)));
            textboxes.add(new Textbox(200, 170, 80, 30, String.format("%.1f", o.z)));
            break;
          }
        }
      }
    }
  }
}

void mouseReleased() {
  mouseJustReleased = true;
}

void mouseDragged() {
  if (simulationScreen && mouseButton == RIGHT) {
    camRotY += (pmouseX - mouseX) * 0.005;
    camRotX += (pmouseY - mouseY) * -0.005;
  }
}
