public class TreeController extends Collidable implements Controller {
  private TreeView _view;
  
  TreeController(TreeView view) {
    _view = view;
  }
  
  Vector2 getPosition() { 
    Vector2 position   = _view.getPosition(); 
    Vector2 dimensions = _view.getDimensions(); 
    return new Vector2(position.x, position.y + (dimensions.y-dimensions.x)/2); 
  }
  float getRadius()     { return getView().getDimensions().x; }
  TreeView getView()    { return _view; }
} 