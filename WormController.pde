public class WormController extends Collidable implements Controller {
  private WormView _view;
  
  WormController(WormView view) {
    _view = view;
  }
  
  Vector2 getPosition() { 
    Vector2 position   = _view.getPosition(); 
    Vector2 dimensions = _view.getDimensions(); 
    return new Vector2(position.x, position.y + (dimensions.y-dimensions.x)/2); 
  }
  float getRadius()     { return getView().getDimensions().x; }
  WormView getView()    { return _view; }
} 