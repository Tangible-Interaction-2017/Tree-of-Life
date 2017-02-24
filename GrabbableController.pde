public class GrabbableController {
  private GrabbableView _view;
  private boolean _pressed;
  private Vector2 _dragOffset;
  
  GrabbableController(GrabbableView view) {
    this._view = view;
    this._pressed = false;
    this._dragOffset = new Vector2(0, 0);
  }
  
  boolean isCursorInside() {
    return dist(mouseX, mouseY, _view.getPosition().x, _view.getPosition().y) <= _view.getRadius();
  }
  
  boolean canDrag() { return true; };
  
  boolean canHover() { return true; };
  
  void willPress() {};
  
  void didPress() {};
  
  void mouseHover() {
    _view.setHovered(canHover() && isCursorInside());
  }
  
  void mouseMove() {
    _view.setPosition(mouseX, mouseY);
  }
  
  void mousePress() {
    _pressed = isCursorInside();
    if (_pressed) willPress();
    _view.setPressed(_pressed);
    _dragOffset.x = _view.getPosition().x - mouseX;
    _dragOffset.y = _view.getPosition().y - mouseY;
  }
  
  void mouseDrag() {
  if (canDrag() && _pressed) {
    _view.setPosition(mouseX + _dragOffset.x, mouseY + _dragOffset.y);
  }
};
  
  void mouseRelease() {
    if (_pressed) didPress();
    _view.setPressed(false);
    _pressed = false;
  }
  
  GrabbableView getView() { return _view; }
  
}