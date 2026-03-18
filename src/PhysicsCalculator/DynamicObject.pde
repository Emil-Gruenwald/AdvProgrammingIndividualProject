public class DynamicObject extends Object {
  float velocityX, velocityY, velocityZ, omegaX, omegaY, omegaZ;
  float mass;

  ArrayList<Force> forces = new ArrayList<>();

  DynamicObject(float x, float y, float z, float rotX, float rotY, float rotZ, color col, Shape shape) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.rotY = rotY;
    this.rotX = rotX;
    this.rotZ = rotZ;
    velocityX = 0;
    velocityY = 0;
    velocityZ = 0;
    omegaX = 0;
    omegaY = 0;
    omegaZ = 0;
    mass = 1.0;
    this.col = col;
    this.shape = shape;
  }

  public void update() {
    forces.clear();

    forces.add(new NaturalForce("Gravity", 0, mass * 9.81f, 0, 0, 0, 0));

    for (Force f : forces) {
      f.applyForce(this);
    }

    float step = 0.1;

    for (float i = 0; i < abs(velocityX); i += step) {
      x += step * abs(velocityX)/velocityX;
      if (velocityX != 0 && collidesWith(objects.get(0))) {
        forces.add(new NaturalForce("Normal", -velocityX * mass, 0, 0, 0, 0, 0));
        for (Force f : forces) {
          f.applyForce(this);
        }
        x -= step * abs(velocityX)/velocityX;
        break;
      }
    }

    for (float i = 0; i < abs(velocityY); i += step) {
      y += step * abs(velocityY)/velocityY;
      if (velocityY != 0 && collidesWith(objects.get(0))) {
        forces.add(new NaturalForce("Normal", 0, -velocityY * mass, 0, 0, 0, 0));
        for (Force f : forces) {
          f.applyForce(this);
        }
        y -= step * abs(velocityY)/velocityY;
        break;
      }
    }

    for (float i = 0; i < abs(velocityZ); i += step) {
      z += step * abs(velocityZ)/velocityZ;
      if (velocityZ != 0 && collidesWith(objects.get(0))) {
        forces.add(new NaturalForce("Normal", 0, 0, -velocityZ * mass, 0, 0, 0));
        for (Force f : forces) {
          f.applyForce(this);
        }
        z -= step * abs(velocityZ)/velocityZ;
        break;
      }
    }
  }
}
