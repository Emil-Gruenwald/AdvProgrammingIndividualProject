boolean pauseScreen = true;
boolean isPaused = true;
ArrayList<Force> forces = new ArrayList<>();
ArrayList<Object> objects = new ArrayList<>();


public void settings() {
  size(640, 360, P3D);
}

public void setup() {
  background(0);
  surface.setResizable(true);
  surface.setLocation(100, 100);
}

public void draw() {
  if (pauseScreen) {
    displayPauseScreen();
  } else {
    displaySimulation();
  }
}

public void displayPauseScreen() {
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("Click to Start Simulation", width / 2, height / 2);
}
public void displaySimulation() {
  
  background(0);
  lights();
  fill(255);
  pushMatrix();
  translate(130, height/2, 0);
  rotateY(1.25);
  rotateX(-0.4);
  noStroke();
  box(100);
  popMatrix();

}
