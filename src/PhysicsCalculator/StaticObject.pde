public class StaticObject extends Object {
  StaticObject(color col, BObject body) {
    this.col = col;
    this.body = body;
    body.setMass(0);
    physics.addBody(body);
    // body.setStatic(true);
  }
}
