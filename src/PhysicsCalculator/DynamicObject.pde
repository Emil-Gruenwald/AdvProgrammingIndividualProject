public class DynamicObject extends Object {
    float velocityX, velocityY, velocityZ, omegaX, omegaY, omegaZ;
    float mass;

    ArrayList<Force> forces = new ArrayList<>();
    
     DynamicObject(float x, float y, float z, float w, float h, float d, float rotX, float rotY, float rotZ) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
        this.h = h;
        this.d = d;
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
    }

    public void update() {
        forces.clear();

        forces.add(new NaturalForce("Gravity", 0, mass * 9.81f, 0, 0, 0, 0));

        for (Force f : forces) {
            f.applyForce(this);
        }
    }
}
