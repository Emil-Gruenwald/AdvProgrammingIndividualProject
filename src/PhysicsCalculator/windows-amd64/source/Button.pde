public class Button {
    int x, y, w, h;
    String label;
    boolean hovered = false;

    Button(int x, int y, int w, int h, String label) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.label = label;
    }

    void display() {
        stroke(0);
        fill(hovered ? 150 : 200);
        rect(x, y, w, h);
        fill(0);
        textAlign(CENTER, CENTER);
        text(label, x + w / 2, y + h / 2);
        noStroke();
    }

    void update() {
        hovered = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
    }

    boolean isClicked() {
        return hovered && mouseJustReleased;
    }
}
