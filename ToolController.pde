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
    boolean isTimeOut = getView().isTimeOut();
    if (isTimeOut) getView().start("pull_back");
    for (Collidable collidable : _collidables) {
      if (collide(collidable)) {
        switch (getView().getType()) {
          case WATER:
            if (isTimeOut) {
              getView().startTimer(10);
              _progress.addProgressChange(0.0002, 10);
            }
            break;
          case FIRE:
            Controller controller = (Controller)collidable;
            Animatable animatable = (Animatable)controller.getView();
            animatable.start("fire");
            break;  
          case WIND:
            WormController wormController = (WormController)collidable;
            wormController.getView().start("fly_out");
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