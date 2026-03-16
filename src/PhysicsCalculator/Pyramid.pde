class Pyramid extends Shape {
    float height, base;
    int sides;

    Pyramid(float height, float base, int sides) {
        this.height = height;
        this.base = base;
        this.sides = sides;
    }

    @Override
    void display(float x, float y, float z, float rotX, float rotY, float rotZ) {
        stroke(0);
        pushMatrix();
        translate(x, y, z);
        rotateY(rotY);
        rotateX(rotX);
        rotateZ(rotZ);
        beginShape(TRIANGLES);
        for (int i = 0; i < sides; i++) {
            float angle1 = TWO_PI / sides * i;
            float angle2 = TWO_PI / sides * (i + 1);
            vertex(0, -height / 2, 0);
            vertex(base * cos(angle1) / 2, height / 2, base * sin(angle1) / 2);
            vertex(base * cos(angle2) / 2, height / 2, base * sin(angle2) / 2);
        }
        endShape();
        popMatrix();
        noStroke();
    }
}