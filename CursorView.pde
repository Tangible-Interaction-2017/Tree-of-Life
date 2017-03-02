public class CursorView extends GrabbableView {
  PImage _opened;
  PImage _closed;
  
  CursorView(float x, float y) {
    super(x, y); 
    _opened = loadImage("images/cursor_opened.png");
    _closed = loadImage("images/cursor_closed.png");
    _opened.resize(97, 124);
    _closed.resize(81, 85);
  }
  
  void render() {
    if (isPressed()) image(_closed, getPosition().x-40, getPosition().y-32);
    else             image(_opened, getPosition().x-54, getPosition().y-71);
  }
}