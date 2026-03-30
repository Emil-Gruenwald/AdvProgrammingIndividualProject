class Dropdown {
    float x, y, w, h;
    String label;
    ArrayList<Button> options;
    boolean isOpen = false;

    Dropdown(float x, float y, float w, float h, String label) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.label = label;
        options = new ArrayList<Button>();
    }

    void addOption(String optionLabel) {
        options.add(new Button((int)x, (int)(y + h * (options.size() + 1)), (int)w, (int)h, optionLabel));
    }

    void display() {
        fill(200);
        stroke(0);
        rect(x, y, w, h);
        fill(0);
        triangle(x+w-15, y+h/2-2, x+w-10, y+h/2+5, x+w-5, y+h/2-2);
        textAlign(CENTER, CENTER);
        text(label, x + w / 2, y + h / 2);

        if (isOpen) {
            for (Button option : options) {
                option.display();
            }
        }
        noStroke();
    }

    void update() {
        // if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
        //     if (mousePressed) {
        //         isOpen = !isOpen;
        //     }
        // }

        if (isOpen) {
            for (Button option : options) {
                option.update();
            }
        }
    }

    boolean press() {
        if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
            isOpen = !isOpen;
            return true;
        }
        return false;
    }
}
