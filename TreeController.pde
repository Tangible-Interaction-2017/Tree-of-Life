public class TreeController extends Collidable implements Controller {
  private TreeView _view;
  
  TreeController(TreeView view) {
    _view = view;
  }
  
  Vector2 getPosition() { return getView().getPosition(); }
  float getRadius()     { return width*0.15; }
  TreeView getView()    { return _view; }
} 