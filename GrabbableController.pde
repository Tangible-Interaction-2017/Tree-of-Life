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
    double distance = Math.sqrt(Math.pow(mouseX-_view.getX(), 2) + Math.pow(mouseY-_view.getY(), 2));
    return distance <= _view.getRadius();
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