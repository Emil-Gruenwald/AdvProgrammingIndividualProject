public abstract class Force {
    float x, y, z, torqueX, torqueY, torqueZ;

    public void applyForce(Object o) {
        o.x += x;
        o.y += y;
        o.z += z;
        o.rotX += torqueX;
        o.rotY += torqueY;
        o.rotZ += torqueZ;
    }
}
