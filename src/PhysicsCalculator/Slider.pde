class Slider {
    float x, y, width, height;
    float minValue, maxValue;
    float currentValue;
    boolean isDragging = false;

    Slider(float x, float y, float width, float height, float minValue, float maxValue, float initialValue) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.minValue = minValue;
        this.maxValue = maxValue;
        this.currentValue = initialValue;
    }
}