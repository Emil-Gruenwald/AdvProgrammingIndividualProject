class Slider {
    float x, y, width, height;
    float minValue, maxValue, step;
    float currentValue;
    boolean isDragging = false;

    Slider(float x, float y, float width, float height, float minValue, float maxValue, float step, float initialValue) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.minValue = minValue;
        this.maxValue = maxValue;
        this.step = step;
        this.currentValue = initialValue;
    }

    void display() {
        fill(200);
        rect(x, y, width, height);
        fill(100);
        ellipse(map(currentValue, minValue, maxValue, x, x + width), y + height / 2, height, height);
    }

    void update() {
        if (isDragging && mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
            float mouseValue = map(mouseX, x, x + width, minValue, maxValue);
            currentValue = round(mouseValue / step) * step;
            currentValue = constrain(currentValue, minValue, maxValue);
            isDragging = true;
        } else if (mouseJustReleased) {
            isDragging = false;
        }
    }
}
