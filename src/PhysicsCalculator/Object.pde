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
    else if (shape instanceof Sphere && o.shape instanceof Sphere) {
      Sphere s1 = (Sphere) shape;
      Sphere s2 = (Sphere) o.shape;
      return dist(x, y, z, o.x, o.y, o.z) < s1.radius + s2.radius;
    }
    else if (shape instanceof Sphere && o.shape instanceof Rectangle) {
      Sphere s = (Sphere) shape;
      Rectangle r = (Rectangle) o.shape;
      float closestX = constrain(x, o.x - r.width / 2, o.x + r.width / 2);
      float closestY = constrain(y, o.y - r.height / 2, o.y + r.height / 2);
      float closestZ = constrain(z, o.z - r.depth / 2, o.z + r.depth / 2);
      return dist(x, y, z, closestX, closestY, closestZ) < s.radius;
    }
    else if (shape instanceof Rectangle && o.shape instanceof Sphere) {
      Rectangle r = (Rectangle) shape;
      Sphere s = (Sphere) o.shape;
      float closestX = constrain(o.x, x - r.width / 2, x + r.width / 2);
      float closestY = constrain(o.y, y - r.height / 2, y + r.height / 2);
      float closestZ = constrain(o.z, z - r.depth / 2, z + r.depth / 2);
      return dist(o.x, o.y, o.z, closestX, closestY, closestZ) < s.radius;
    }


    return false;
  }
}
