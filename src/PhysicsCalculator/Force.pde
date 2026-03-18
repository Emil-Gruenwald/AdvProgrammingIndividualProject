public abstract class Force {
    float x, y, z, torqueX, torqueY, torqueZ;

    public void applyForce(DynamicObject o) {
        o.velocityX += x/o.mass;
        o.velocityY += y/o.mass;
        o.velocityZ += z/o.mass;
        o.omegaX += torqueX;
        o.omegaY += torqueY;
        o.omegaZ += torqueZ;
    }

    PVector getForceVector() {
        return new PVector(x, y, z);
    }

    PVector getTorqueVector() {
        return new PVector(torqueX, torqueY, torqueZ);
    }
}
