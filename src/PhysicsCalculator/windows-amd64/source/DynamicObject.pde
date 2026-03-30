public class DynamicObject extends Object {

  DynamicObject(float x, float y, float z, float width, float height, float depth, float mass, color col) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.width = width;
    this.height = height;
    this.depth = depth;
    this.mass = mass;
    this.type = "Box";
    this.col = col;
    body = new BBox(PhysicsCalculator.this, mass, width, height, depth);
    body.setPosition(x, y, z);
    physics.addBody(body);
  }

  DynamicObject(float x, float y, float z, float radius, float mass, color col) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    this.mass = mass;
    this.type = "Sphere";
    this.col = col;
    body = new BSphere(PhysicsCalculator.this, mass, x, y, z, radius);
    physics.addBody(body);
  }

  // DynamicObject(color col, BObject body) {
  //   this.col = col;
  //   this.body = body;
  //   physics.addBody(body);
  // }

  // public void update() {
  //   forces.clear();

  //   forces.add(new NaturalForce("Gravity", 0, mass * 9.81f, 0, 0, 0, 0));

  //   for (Force f : forces) {
  //     f.applyForce(this);
  //   }

  //   float step = 0.1;

  //   for (float i = 0; i < abs(velocityX); i += step) {
  //     x += step * abs(velocityX)/velocityX;
  //     if (velocityX != 0) {
  //       for (Object o : objects) {
  //         if (o != this && collidesWith(o)) {
  //           forces.add(new NaturalForce("Normal", -velocityX * mass, 0, 0, 0, 0, 0));
  //           for (Force f : forces) {
  //             f.applyForce(this);
  //           }
  //           x -= step * abs(velocityX)/velocityX;
  //           break;
  //         }
  //       }
  //     }
  //   }

  //   for (float i = 0; i < abs(velocityY); i += step) {
  //     y += step * abs(velocityY)/velocityY;
  //     if (velocityY != 0) {
  //       for (Object o : objects) {
  //         if (o != this && collidesWith(o)) {
  //           forces.add(new NaturalForce("Normal", 0, -velocityY * mass, 0, 0, 0, 0));
  //           for (Force f : forces) {
  //             f.applyForce(this);
  //           }
  //           y -= step * abs(velocityY)/velocityY;
  //           break;
  //         }
  //       }
  //     }
  //   }

  //   for (float i = 0; i < abs(velocityZ); i += step) {
  //     z += step * abs(velocityZ)/velocityZ;
  //     if (velocityZ != 0) {
  //       for (Object o : objects) {
  //         if (o != this && collidesWith(o)) {
  //           forces.add(new NaturalForce("Normal", 0, 0, -velocityZ * mass, 0, 0, 0));
  //           for (Force f : forces) {
  //             f.applyForce(this);
  //           }
  //           z -= step * abs(velocityZ)/velocityZ;
  //           break;
  //         }
  //       }
  //     }
  //   }
  // }
}
