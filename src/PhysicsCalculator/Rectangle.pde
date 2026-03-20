class Rectangle extends Shape {
  float width, height, depth;

  Rectangle(float width, float height, float depth) {
    this.width = width;
    this.height = height;
    this.depth = depth;
  }

  @Override
    void display(float x, float y, float z, float rotX, float rotY, float rotZ) {
    stroke(0);
    pushMatrix();
    translate(x, y, z);
    rotateY(rotY);
    rotateX(rotX);
    rotateZ(rotZ);
    fill(150);
    box(width, height, depth);
    popMatrix();
    noStroke();
  }
}
