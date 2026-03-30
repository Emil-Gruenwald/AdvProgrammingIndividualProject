public class Textbox extends Button {

    Button leftButton, rightButton;

    boolean selected;

    float value;

    String tempLabel;

    Textbox(int x, int y, int w, int h, String label) {
        super(x, y, w, h, label);
        leftButton = new Button(x - 30, y, 30, h, "-");
        rightButton = new Button(x + w, y, 30, h, "+");
        selected = false;

        value = Float.parseFloat(label);
        tempLabel = label;
    }

    @Override
    void display() {
        super.display();
        leftButton.display();
        rightButton.display();
    }

    @Override
    void update() {
        super.update();
        leftButton.update();
        rightButton.update();
        if (isClicked()) {
            selected = true;
            tempLabel = label;
            label = "";
            typing = true;
            selectedTextbox = this;
        }

        if (leftButton.isClicked()) {
            value -= 10.0;
            label = String.format("%.1f", value);
        }
        if (rightButton.isClicked()) {
            value += 10.0;
            label = String.format("%.1f", value);
        }

    }

    void escape() {
        selected = false;
        typing = false;
        selectedTextbox = null;
        label = tempLabel;
    }

    void enter() {
        try {
            value = Float.parseFloat(label);
            label = String.format("%.1f", value);
        } catch (NumberFormatException e) {
            label = tempLabel;
        }
        selected = false;
        typing = false;
        selectedTextbox = null;
    }
}