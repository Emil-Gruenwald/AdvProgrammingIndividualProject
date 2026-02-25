boolean isPaused = true;
ArrayList<Force> forces = new ArrayList<>();
ArrayList<Object> objects = new ArrayList<>();


public void settings() {
  size(640, 360, P3D);
}

public void setup() {
  background(0);
}

public void draw() {
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
