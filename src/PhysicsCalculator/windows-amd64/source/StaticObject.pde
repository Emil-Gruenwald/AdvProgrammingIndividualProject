public class StaticObject extends Object {
  StaticObject(float x, float y, float z, float width, float height, float depth, color col) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.width = width;
    this.height = height;
    this.depth = depth;
    mass = 0;
    this.type = "Box";
    this.col = col;
    body = new BBox(PhysicsCalculator.this, 0, width, height, depth);
    body.setPosition(x, y, z);
    physics.addBody(body);
  }

  StaticObject(float x, float y, float z, float radius, color col) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    mass = 0;
    this.type = "Sphere";
    this.col = col;
    body = new BSphere(PhysicsCalculator.this, 0, x, y, z, radius);
    physics.addBody(body);
  }
}
