PImage logo = new PImage();

boolean pauseScreen = true;
boolean isPaused = true;
ArrayList<Force> forces = new ArrayList<>();
ArrayList<Object> objects = new ArrayList<>();
ArrayList<Button> pauseButtons = new ArrayList<>();


public void settings() {
  //size(640, 360, P3D);
  fullScreen(P3D);
  noSmooth();
  pixelDensity(2);
}

public void setup() {
  background(0);
  surface.setResizable(true);
  logo = loadImage("Logo.png");
  pauseButtons.add(new Button(10, 350, 200, 40, "Run Simulation"));
  pauseButtons.add(new Button(10, 400, 200, 40, "Settings"));
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

