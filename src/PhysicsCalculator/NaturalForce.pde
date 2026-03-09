public class NaturalForce extends Force {

    String type;
    
    NaturalForce(String type, float x, float y, float z, float torqueX, float torqueY, float torqueZ) {
        this.type = type;
        this.x = x;
        this.y = y;
        this.z = z;
        this.torqueX = torqueX;
        this.torqueY = torqueY;
        this.torqueZ = torqueZ;
    }
}
