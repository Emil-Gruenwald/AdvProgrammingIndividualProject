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
    }
}
