public class WormController extends Collidable implements Controller {
  private WormView _view;
  
  WormController(WormView view) {
    _view = view;
  }
  
  boolean isMoving() { return getView().isMoving(); }
  boolean isOnFire() { return getView().isOnFire(); }
  
  Vector2 getCenter() { 
    Vector2 position   = _view.getPosition(); 
    Vector2 dimensions = _view.getDimensions(); 
    return new Vector2(position.x + dimensions.x/2, position.y + dimensions.y/2); 
  }
  float getRadius()     { return getView().getDimensions().x/2; }
  WormView getView()    { return _view; }
} 