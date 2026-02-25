public class PhysicsCalculator extends PApplet {
    public static void main(String[] args) {
        boolean isPaused = true;
        ArrayList<Force> forces = new ArrayList<>();
        ArrayList<Object> objects = new ArrayList<>();
    }

    public void settings() {
        // Set up the window size
        size(500, 500, P3D);
    }

    public void setup() {
        // Set initial background color
        background(255);
    }

    public void draw() {
        // Draw a moving circle
        background(255);
        fill(255, 0, 0);
        translate(mouseX, mouseY, 0);
        ellipse(0, 0, 50, 50);
    }
}
