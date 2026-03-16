public abstract class Object {
  float x, y, z, rotY, rotX, rotZ;
  Shape shape;
  color col;

  void display() {
    // stroke(0);
    // pushMatrix();
    // translate(x, y, z);
    // rotateY(rotY);
    // rotateX(rotX);
    // rotateZ(rotZ);
    // box(w, h, d);
    // popMatrix();
    // noStroke();
    shape.display(x, y, z, rotX, rotY, rotZ);
  }

  boolean collidesWith(Object o) {
    return false;
  }
}
