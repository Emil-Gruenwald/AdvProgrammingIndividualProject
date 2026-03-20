public abstract class Force {
    float x, y, z, torqueX, torqueY, torqueZ;

    public void applyForce(DynamicObject o) {
        o.velocityX += x/o.mass * timeStep;
        o.velocityY += y/o.mass * timeStep;
        o.velocityZ += z/o.mass * timeStep;
        o.omegaX += torqueX * timeStep;
        o.omegaY += torqueY * timeStep;
        o.omegaZ += torqueZ * timeStep;
    }

    PVector getForceVector() {
        return new PVector(x, y, z);
    }

    PVector getTorqueVector() {
        return new PVector(torqueX, torqueY, torqueZ);
    }
}
