public abstract class Object {
  float x, y, z, w, h, d, rotY, rotX, rotZ;

  void display() {
    stroke(0);
    pushMatrix();
    translate(x, y, z);
    rotateY(rotY);
    rotateX(rotX);
    rotateZ(rotZ);
    box(w, h, d);
    popMatrix();
    noStroke();
  }

  boolean collidesWith(Object o) {
    return false;
  }
}
