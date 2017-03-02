public class TreeController extends Collidable implements Controller {
  private TreeView _view;
  private Progress _progress;
  
  TreeController(TreeView view) {
    _view = view;
  }
  
  boolean isOnFire() { return getView().isOnFire(); }
  
  void setProgress(Progress progress) { _progress = progress; }
  
  Vector2 getCenter() { 
    Vector2 position   = _view.getPosition(); 
    Vector2 dimensions = _view.getDimensions(); 
    return new Vector2(position.x + dimensions.x/2, 
                       position.y + dimensions.y - getRadius()); 
  }
  float getRadius() { 
    return getView().getDimensions().y / 2 * (float)(1 + min(floor(_progress.getProgress() * 4), 3)) / 4;
  }
  TreeView getView()    { return _view; }
} 