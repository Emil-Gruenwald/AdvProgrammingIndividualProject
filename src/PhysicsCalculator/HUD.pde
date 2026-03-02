public static class HUD {
  static void display(PApplet p, boolean isPaused) {
    p.pushMatrix();
    p.camera();
    p.hint(PApplet.DISABLE_DEPTH_TEST);
    
    if (isPaused) {
      p.fill(0);
      p.triangle(p.width - 40, 20, p.width - 40, 40, p.width - 20, 30);
    } else {
      p.fill(0);
      p.rect(p.width - 40, 20, 5, 20);
      p.rect(p.width - 25, 20, 5, 20);
    }
    
    p.hint(PApplet.ENABLE_DEPTH_TEST);
    p.popMatrix();
  }
}
