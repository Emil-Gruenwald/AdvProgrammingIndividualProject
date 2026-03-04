public class HUD {
  void displaySimulation(ArrayList<Button> simulationButtons, boolean isPaused) {
    pushMatrix();
    camera();
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
        isPaused = false;
      } else if (b.isClicked() && b.label.equals("Settings")) {
        
      } else if (b.isClicked() && b.label.equals("Exit")) {
        exit();
      }
    }
    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }
}
