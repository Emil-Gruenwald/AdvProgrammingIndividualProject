public class HUD {
  void displaySimulation(ArrayList<Button> simulationButtons, Dropdown addDropdown, boolean isPaused) {
    pushMatrix();
    camera();
    noLights();
    hint(PApplet.DISABLE_DEPTH_TEST);

    if (isPaused) {
      fill(0);
      triangle(width - 40, 20, width - 40, 40, width - 20, 30);
    } else {
      fill(0);
      rect(width - 40, 20, 5, 20);
      rect(width - 25, 20, 5, 20);
    }

    for (Button b : simulationButtons) {
      b.update();
      b.display();
      if (b.isClicked() && b.label.equals("Add")) {
        
      }
    }

    addDropdown.update();
    addDropdown.display();

    for (Button b : addDropdown.options) {
      if (b.isClicked()) {
        String option = b.label;
        if (option.equals("Dynamic Cube")) {
          objects.add(new DynamicObject(0, -100, 0, 50, 50, 50, 1, color(255, 0, 0)));
        } else if (option.equals("Dynamic Sphere")) {
          objects.add(new DynamicObject(0, -100, 0, 50, 1, color(255, 0, 0)));
        } else if (option.equals("Static Cube")) {
          objects.add(new StaticObject(0, -100, 0, 50, 50, 50, color(0, 255, 0)));
        } else if (option.equals("Static Sphere")) {
          objects.add(new StaticObject(0, -100, 0, 50, color(0, 255, 0)));
        }
      }
    }

    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }

  void displayPauseScreen(ArrayList<Button> pauseButtons) {
    pushMatrix();
    camera();
    hint(PApplet.DISABLE_DEPTH_TEST);

    background(100);
    fill(255);
    logo = loadImage("Logo.png");
    logo.resize(width, height);
    image(logo, 0, 0);
    for (Button b : pauseButtons) {
      b.update();
      b.display();
      if (b.isClicked() && b.label.equals("Run Simulation")) {
        pauseScreen = false;
        simulationScreen = true;
        isPaused = true;
      } else if (b.isClicked() && b.label.equals("Settings")) {
        previousScreen = "pause";
        settingsScreen = true;
        pauseScreen = false;
      } else if (b.isClicked() && b.label.equals("Exit")) {
        exit();
      }
    }
    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }

  void displayMenu(ArrayList<Button> menuButtons) {
    pushMatrix();
    camera();
    hint(PApplet.DISABLE_DEPTH_TEST);

    fill(125);
    rect(10, 10, 300, 200);

    fill(0);
    textSize(20);
    text("Paused", 50, 25);
    textSize(12);

    for (Button b : menuButtons) {
      b.update();
      b.display();
      if (b.isClicked() && b.label.equals("Settings")) {
        previousScreen = "menu";
        settingsScreen = true;
        menuScreen = false;
      }
      if (b.isClicked() && b.label.equals("Exit")) {
        menuScreen = false;
        pauseScreen = true;
      }
    }
    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }

  void displaySettings(ArrayList<Button> settingsButtons) {
    pushMatrix();
    camera();
    hint(PApplet.DISABLE_DEPTH_TEST);

    background(100);

    fill(0);
    textSize(20);
    text("Settings", 50, 25);
    textSize(12);
    // timeStepSlider.update();
    // timeStepSlider.display();
    for (Button b : settingsButtons) {
      if (b.label.startsWith("Show Grid")) {
        b.label = "Show Grid: " + (showGrid ? "ON" : "OFF");
      } else if (b.label.startsWith("Show Outlines")) {
        b.label = "Show Outlines: " + (showOutlines ? "ON" : "OFF");
      } else if (b.label.startsWith("Lights")) {
        b.label = "Lights: " + (lights ? "ON" : "OFF");
      }

      b.update();
      b.display();

      if (b.isClicked()) {
        if (b.label.startsWith("Show Grid")) {
          showGrid = !showGrid;
          b.label = "Show Grid: " + (showGrid ? "ON" : "OFF");
        } else if (b.label.startsWith("Show Outlines")) {
          showOutlines = !showOutlines;
          b.label = "Show Outlines: " + (showOutlines ? "ON" : "OFF");
        } else if (b.label.startsWith("Lights")) {
          lights = !lights;
          b.label = "Lights: " + (lights ? "ON" : "OFF");
        } else if (b.label.equals("Back")) {
          settingsScreen = false;
          if (previousScreen.equals("pause")) {
            pauseScreen = true;
          } else if (previousScreen.equals("menu")) {
            menuScreen = true;
          }
        }
      }
    }
    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }

  void displayObjectInfo() {
    pushMatrix();
    camera();
    hint(PApplet.DISABLE_DEPTH_TEST);

    fill(125);
    noStroke();
    textSize(20);
    rect(10, 10, 320, 450);
    fill(0);
    text("Object Info", 65, 25);
    textSize(12);
    text("Mass:", 50, 50);
    text("X:", 50, 90);
    text("Y:", 50, 130);
    text("Z:", 50, 170);
    text("ScaleX:", 50, 210);
    text("ScaleY:", 50, 250);
    text("ScaleZ:", 50, 290);
    text("RotX:", 50, 330);
    text("RotY:", 50, 370);
    text("RotZ:", 50, 410);
    for (Textbox t : textboxes) {
      t.update();
      t.display();
    }

    if (selectedObject != null && textboxes.size() >= 10) {
      float nx = textboxes.get(0).value;
      float ny = textboxes.get(1).value;
      float nz = textboxes.get(2).value;
      float nm = textboxes.get(3).value;
      float nsx = textboxes.get(4).value;
      float nsy = textboxes.get(5).value;
      float nsz = textboxes.get(6).value;
      float nrx = textboxes.get(7).value;
      float nry = textboxes.get(8).value;
      float nrz = textboxes.get(9).value;

      if (selectedObject.body.getPosition().x != nx || selectedObject.body.getPosition().y != ny || selectedObject.body.getPosition().z != nz) {
        selectedObject.body.setPosition(nx, ny, nz);
        selectedObject.x = nx;
        selectedObject.y = ny;
        selectedObject.z = nz;
      }
      if (selectedObject.body.getMass() != nm) {
        selectedObject.body.setMass(nm);
        selectedObject.mass = nm;
      }
      if (selectedObject.type.equals("Box")) {
        if (nsx != previousScaleX) {
          selectedObject.width *= nsx / previousScaleX;
          previousScaleX = nsx;
        }
        if (nsy != previousScaleY) {
          selectedObject.height *= nsy / previousScaleY;
          previousScaleY = nsy;
        }
        if (nsz != previousScaleZ) {
          selectedObject.depth *= nsz / previousScaleZ;
          previousScaleZ = nsz;
        }
      } else if (selectedObject.type.equals("Sphere")) {
        if (nsx != previousScaleX) {
          selectedObject.radius *= nsx / previousScaleX;
          previousScaleX = nsx;
        }
      }

      if (nrx != previousRotX || nry != previousRotY || nrz != previousRotZ) {
        float[] q = eulerToQuaternion(nrx * PI / 180, nry * PI / 180, nrz * PI / 180);
        float qw = q[0];
        float qx = q[1];
        float qy = q[2];
        float qz = q[3];
        float angle = 2 * acos(qw);
        float s = sqrt(1 - qw * qw);
        Vector3f axis;
        if (s < 0.0001f) {
          axis = new Vector3f(1, 0, 0);
        } else {
          axis = new Vector3f(qx / s, qy / s, qz / s);
        }
        selectedObject.body.setRotation(axis, angle);
        previousRotX = nrx;
        previousRotY = nry;
        previousRotZ = nrz;
      }
    }

    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }
}
