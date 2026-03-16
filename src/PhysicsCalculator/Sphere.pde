class Sphere extends Shape {
  float radius;

  Sphere(float radius) {
    this.radius = radius;
  }

  @Override
    void display(float x, float y, float z, float rotX, float rotY, float rotZ) {
    noStroke();
    pushMatrix();
    translate(x, y, z);
    rotateY(rotY);
    rotateX(rotX);
    rotateZ(rotZ);
    sphere(radius);
    popMatrix();

    pushMatrix();
    camera();
    hint(PApplet.DISABLE_DEPTH_TEST);
    
    noFill();
    stroke(0);
    circle(modelToScreen(x, y, z).x, modelToScreen(x, y, z).y, radius * 2);
    
    hint(PApplet.ENABLE_DEPTH_TEST);
    popMatrix();
  }
}
