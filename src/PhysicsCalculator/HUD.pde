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
        isPaused = false;
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

    fill(100, 20);
    rect(0, 0, width, height);
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
    for (Button b : settingsButtons) {
      b.update();
      b.display();
    }
    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }
}
