public abstract class Drawable {
  protected float x, y;
  
  Drawable(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  abstract void draw(float x, float y);
  
  void update() {
    draw(x, y);
  }
}