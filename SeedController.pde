public class SeedController extends GrabbableController {
  private Collidable _activator;
  private boolean _activated;
  
  SeedController(SeedView seedView, Collidable activator) {
    super(seedView);
    _activator = activator;
    _activated = false;
  }
  
  void didPress() {
    if (collide(_activator)) {
      _activated = true;
    }
  }
  
  Vector2 getCenter() { return new Vector2(getView().getPosition().x+getRadius(), getView().getPosition().y+getRadius()); }
  float getRadius() { return getView().getDimensions().x/2+20; };
  
  boolean isActivated() { return _activated; }
  void deactivate() { 
    _activated = false; 
    getView().setPosition(width/4*3, height/8*5+20);
  }
}