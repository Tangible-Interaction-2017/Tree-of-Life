public class ToolController extends GrabbableController {
  ToolController(ToolView view) {
    super(view);
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
    if (getView().isTimeOut()) {
      getView().start("pull_back");
      if (getView().getType() == ToolType.WATER) getView().startTimer(10);
    }
  }
  
  @Override
  ToolView getView() {
    return (ToolView)super.getView();
  }
}