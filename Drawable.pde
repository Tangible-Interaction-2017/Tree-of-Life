public abstract class Drawable {
  private Vector2 _position, _dimensions;
  
  Drawable(float x, float y, float width, float height) {
    _position   = new Vector2(x, y);
    _dimensions = new Vector2(width, height);
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
  Vector2 getPosition() { return _position; }
  Vector2 getDimensions() { return _dimensions; }
}

public class Vector2 {
  float x, y;
  
  Vector2(float x, float y) {
    this.x = x;
    this.y = y;
  }
}