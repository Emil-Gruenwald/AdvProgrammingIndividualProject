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

    if (shape instanceof Rectangle && o.shape instanceof Rectangle) {
      Rectangle r1 = (Rectangle) shape;
      Rectangle r2 = (Rectangle) o.shape;
      return abs(x - o.x) < (r1.width + r2.width) / 2 && abs(y - o.y) < (r1.height + r2.height) / 2 && abs(z - o.z) < (r1.depth + r2.depth) / 2;
    }

    return false;
  }
}
