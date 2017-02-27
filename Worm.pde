public class WormView extends Animatable {
  private Direction _direction;
  
  WormView(int x, int y, Direction direction) {
    super(x, y, 89, 25);
    _direction = direction;
    
    if (direction == Direction.RIGHT) {
      String[] fileNames = {
        "images/worm_right_0.png", 
        "images/worm_right_1.png"
      };
      int[] indices = { 0, 1 };
      addFrameAnimation("move", fileNames, indices, 0.4);
    } else {
      String[] fileNames = {
        "images/worm_left_0.png", 
        "images/worm_left_1.png"
      };
      int[] indices = { 0, 1 };
      addFrameAnimation("move", fileNames, indices, 0.4);
    }
  }
  
  void render() {
    super.render();
    
    if (_direction == Direction.RIGHT) {
      if(getPosition().x>(width/2-getDimensions().x)){
        setPosition(getPosition().x, getPosition().y);
      }
      else{ 
      setPosition(getPosition().x+0.5, getPosition().y);
      }
  } else {
    if(getPosition().x<(width/2-getDimensions().x)){
        setPosition(getPosition().x, getPosition().y);
      }
      setPosition(getPosition().x-0.5, getPosition().y);
    }
  }
}

public enum Direction { LEFT, RIGHT }