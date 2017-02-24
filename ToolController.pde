public class ToolController extends GrabbableController {
  private final Collidable[] _collidables;
  
  ToolController(ToolView view, Collidable[] collidables) {
    super(view);
    _collidables = collidables;
  }
  
  ToolController(ToolView view) {
    this(view, new Collidable[0]);
  }
  
  boolean canDrag() {
    return getView().isTimeOut();
  }
  
  boolean canHover() {
    return getView().isTimeOut();
  }
  
  void willPress() {
    getView().stop();
  }
  
  void didPress() {
    boolean isTimeOut = getView().isTimeOut();
    if (isTimeOut) getView().start("pull_back");
    for (Collidable collidable : _collidables) {
      if (collide(collidable)) {
        if (isTimeOut && getView().getType() == ToolType.WATER) getView().startTimer(10);
      }
    }
  }
  
  @Override
  ToolView getView() {
    return (ToolView)super.getView();
  }
}