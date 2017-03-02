public abstract class Drawable {
  private Vector2 _position, _dimensions;
  private int _r, _g, _b;
  
  Drawable(float x, float y, float width, float height) {
    _position   = new Vector2(x, y);
    _dimensions = new Vector2(width, height);
    _r = 0;
    _g = 0;
    _b = 0;
  }
  
  abstract void render();

  void setPosition(float x, float y) { 
    _position.x = x;
    _position.y = y;
  }  
  void setDimensions(float width, float height) { 
    _dimensions.x = width; 
    _dimensions.y = height;
  }
  void setColor(int r, int g, int b) { 
    _r = r;
    _g = g;
    _b = b;
  }
  Vector2 getPosition() { return _position; }
  Vector2 getDimensions() { return _dimensions; }
  int getRed()   { return _r; }
  int getGreen() { return _g; }
  int getBlue()  { return _b; }
   
}

public class Vector2 {
  float x, y;
  
  Vector2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  Vector2 clone() {
    return new Vector2(x, y);
  }
}