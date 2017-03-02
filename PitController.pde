public class PitController extends Collidable implements Controller {
  private PitView _view;
  
  PitController(PitView seedView) {
    _view = seedView;
  }
  
  Vector2 getCenter() { return new Vector2(getView().getPosition().x + getView().getDimensions().x/2 - getRadius(),
                                           getView().getPosition().y + getRadius()); }
  float getRadius() { return getView().getDimensions().y/2+10; };
  
  PitView getView() { return _view; }
}