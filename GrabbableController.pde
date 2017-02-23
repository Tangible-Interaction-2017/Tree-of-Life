double distance(double x0, double y0, double x1, double y1) {
  return Math.sqrt(Math.pow(x1-x0, 2) + Math.pow(y1-y0, 2));
}

public abstract class GrabbableController {
  private GrabbableView _view;
  private boolean _pressed;
  private float _dragOffsetX;
  private float _dragOffsetY;
  
  GrabbableController(GrabbableView view) {
    this._view = view;
    this._pressed = false;
  }
  
  boolean isCursorInside() {
    return distance(mouseX, mouseY, _view.getX(), _view.getY()) <= _view.getRadius();
  }
  
  void mouseHover() {
    _view.setHovered(isCursorInside());
  }
  
  void mouseMove() {
    _view.setX(mouseX);
    _view.setY(mouseY);
  }
  
  void mousePress() {
    _pressed = isCursorInside();
    _view.setPressed(_pressed);
    _dragOffsetX = _view.getX() - mouseX;
    _dragOffsetY = _view.getY() - mouseY;
  }
  
  void mouseDrag() {
  if (_pressed) {
    _view.setX(mouseX+this._dragOffsetX);
    _view.setY(mouseY+this._dragOffsetY);
  }
};
  
  void mouseRelease() {
    _view.setPressed(false);
    _pressed = false;
  }
  
}