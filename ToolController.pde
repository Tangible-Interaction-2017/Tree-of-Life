public class ToolController extends GrabbableController {
  private Progress _progress;
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
    boolean didFlyOut = false;
    boolean isTimeOut = getView().isTimeOut();
    if (isTimeOut) getView().start("pull_back");
    for (Collidable collidable : _collidables) {
      if (collide(collidable)) {
        switch (getView().getType()) {
          case WATER:
            if (isTimeOut) {
              getView().startTimer(10);
              
              String id = "stage_" + (int)min(_progress.getProgress()*4, 3);
              TreeController treeController = (TreeController)collidable;
              treeController.getView().start(id);
              _progress.addProgressChange("water", 0.0002, 10);
              _progress.removeProgressChange("fire");
            }
            break;
          case FIRE:
            if (collidable instanceof TreeController) {    
              TreeController treeController = (TreeController)collidable;
              String id = "stage_" + (int)min(_progress.getProgress()*4, 3) + "_fire";
              treeController.getView().start(id);
              _progress.addProgressChange("fire", -0.0004, Float.POSITIVE_INFINITY);
              _progress.removeProgressChange("water");
            } else {
              WormController wormController = (WormController)collidable;
              wormController.getView().start("fire");
            }
            break;  
          case WIND:
            if (!didFlyOut) {
              WormController wormController = (WormController)collidable;
              wormController.getView().start("fly_out");
              didFlyOut = true;
            }
            break;
        }
      }
    }
  }
  
  @Override
  ToolView getView() {
    return (ToolView)super.getView();
  }
  
  void setProgress(Progress progress) { _progress = progress; }
}