public class CursorView extends GrabbableView {
  PImage _opened;
  PImage _closed;
  
  CursorView(float x, float y) {
    super(x, y); 
    _opened = loadImage("images/cursor_opened.png");
    _closed = loadImage("images/cursor_closed.png");
  }
  
  void render() {
    if (isPressed()) image(_closed, getX()-50, getY()-52);
    else             image(_opened, getX()-60, getY()-82);
  }
}