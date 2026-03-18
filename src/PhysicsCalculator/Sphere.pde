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
  }
}
