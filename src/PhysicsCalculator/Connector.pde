public class Connector extends DynamicObject {
    boolean isSpring;
    float springConstant, length;

    Connector (float x, float y, float z, float w, float h, float d, float rotX, float rotY, float rotZ) {
        super(x, y, z, rotX, rotY, rotZ, color(0, 255, 0), new Rectangle(w, h, d));
        isSpring = false;
        springConstant = 0;
        length = 0;
    }

    public void update() {
        
    }
}
