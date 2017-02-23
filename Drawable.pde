public abstract class Drawable {
  private float _x, _y;
  
  Drawable(float x, float y) {
    _x = x;
    _y = y;
  }
  
  abstract void render();

  void setX(float x) { _x = x; }  
  void setY(float y) { _y = y; }
  float getX() { return _x; }
  float getY() { return _y; }
}