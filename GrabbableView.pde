public abstract class GrabbableView extends Animatable {
  private boolean _pressed;
  private boolean _hovered;
  private float _radius;
  
  GrabbableView(float x, float y, float radius) {
    super(x, y, radius*2, radius*2);
    _pressed = false;
    _hovered = false;
    _radius = radius;
  }
  
  GrabbableView(float x, float y) {
    this(x, y, 50);
  }
  
  void setPressed(boolean isPressed) { _pressed = isPressed; }
  void setHovered(boolean isHovered) { _hovered = isHovered; }
  boolean isPressed() { return _pressed; }
  boolean isHovered() { return _hovered; }
  float getRadius() { return _radius; }
}