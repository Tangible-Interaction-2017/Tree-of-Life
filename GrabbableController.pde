public abstract class GrabbableController {
  private GrabbableView _view;
  private boolean _pressed;
  private Vector2 _dragOffset;
  
  GrabbableController(GrabbableView view) {
    this._view = view;
    this._pressed = false;
    this._dragOffset = new Vector2(0, 0);
  }
  
  boolean isCursorInside() {
    double distance = Math.sqrt(Math.pow(mouseX-_view.getPosition().x, 2) + Math.pow(mouseY-_view.getPosition().y, 2));
    return distance <= _view.getRadius();
  }
  
  void mouseHover() {
    _view.setHovered(isCursorInside());
  }
  
  void mouseMove() {
    _view.setPosition(mouseX, mouseY);
  }
  
  void mousePress() {
    _pressed = isCursorInside();
    _view.setPressed(_pressed);
    _dragOffset.x = _view.getPosition().x - mouseX;
    _dragOffset.y = _view.getPosition().y - mouseY;
  }
  
  void mouseDrag() {
  if (_pressed) {
    _view.setPosition(mouseX + _dragOffset.x, mouseY + _dragOffset.y);
  }
};
  
  void mouseRelease() {
    _view.setPressed(false);
    _pressed = false;
  }
  
}