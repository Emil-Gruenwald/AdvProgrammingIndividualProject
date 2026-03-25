import bRigid.*;

public abstract class Object {
  float x, y, z, mass, radius, width, height, depth;

  String type;

  color col;

  BObject body;

  void display() {
    if (type.equals("Box")) {
      BBox b = (BBox) body;
      pushMatrix();
      translate(b.getPosition().x, b.getPosition().y, b.getPosition().z);
      fill(col);
      stroke(0);
      box(width, height, depth);
      popMatrix();
      noStroke();
    } else if (type.equals("Sphere")) {
      BSphere s = (BSphere) body;
      pushMatrix();
      translate(s.getPosition().x, s.getPosition().y, s.getPosition().z);
      fill(col);
      stroke(0);
      sphere(radius);
      popMatrix();
      noStroke();
    }
  }
}
