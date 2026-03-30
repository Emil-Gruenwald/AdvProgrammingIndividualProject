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
      b.update();
      b.display();
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
    rect(10, 10, 320, 200);
    fill(0);
    text("Object Info", 65, 25);
    textSize(12);
    text("X:", 50, 90);
    text("Y:", 50, 130);
    text("Z:", 50, 170);
    text("Mass:", 50, 50);
    for (Textbox t : textboxes) {
      t.update();
      t.display();
    }
    selectedObject.body.setPosition(textboxes.get(0).value, textboxes.get(1).value, textboxes.get(2).value);
    selectedObject.body.setMass(textboxes.get(3).value);
    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }
}
