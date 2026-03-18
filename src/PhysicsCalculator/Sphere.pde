class Sphere extends Shape {
  float radius;

  Sphere(float radius) {
    this.radius = radius;
  }

  @Override
    void display(float x, float y, float z, float rotX, float rotY, float rotZ) {
    pushMatrix();
    translate(x, y, z);
    rotateY(rotY);
    rotateX(rotX);
    rotateZ(rotZ);
    // noFill();
    // stroke(0);
    // sphere(radius+1);
    noStroke();
    fill(200);
    sphere(radius);
    popMatrix();
  }
}
