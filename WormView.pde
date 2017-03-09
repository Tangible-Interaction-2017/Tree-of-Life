public class WormView extends Animatable {
  private Direction _direction;
  private int _burnStartTime;
  private boolean _move, _flying, _burning;
  private boolean _reachedTree;
  private NutrientDropView _dropView;
  private PImage _image;

  WormView(int x, int y, Direction direction) { //<>//
    super(x, y, 89, 25); //<>//
    _direction = direction;
    _move = false;
    _reachedTree = false;
    _burnStartTime = 0;
    _dropView = new NutrientDropView(width/2+25,  y+10);

    String directionString = "";
    if (direction == Direction.RIGHT) {
      directionString = "right";
      addLinearAnimation("fly_out", -89, -25, 0.7);
    } else {
      directionString = "left";
      addLinearAnimation("fly_out", width, -25, 0.7);
    }
    
    _image = loadImage("images/worm_" + directionString +"_0.png");
    String[] fileNames = {
      "images/worm_" + directionString + "_0.png",
      "images/worm_" + directionString + "_1.png"
    };
    int[] indices = { 0, 1 };
    addFrameAnimation("move", fileNames, indices, 0.4);
      
    fileNames = new String[]{
      "images/worm_" + directionString + "_burn_0.png",
      "images/worm_" + directionString + "_burn_1.png"
    };
    indices = new int[]{ 0, 1 };
    addFrameAnimation("fire", fileNames, indices, 0.4);
  }

  @Override
  void start(String id) {
    if (!_burning) {
      super.start(id);

      _flying  = id.equals("fly_out");
    
      _burning = id.equals("fire");
      if (_burning) {
        _burnStartTime = millis();
      }
      _move = id.equals("move");
    }
  }
  
  void reset() {
    if (_direction == Direction.RIGHT) {
      setPosition(-89, height/8*5 + (int)random(25));
    } else {
      setPosition(width, height/8*5 + (int)random(25));
    }
    _dropView.setPosition(width/2+_dropView.getDimensions().x/2, getPosition().y+25);
    _reachedTree = false;
    _move = _flying = _burning = false;
  }

  @Override
  void stop() {
    super.stop();

    if (_flying  || _burning) reset();
    _move = false;
  }

  boolean reachedTree() { return _reachedTree; }
  boolean isMoving() { return _move; }
  boolean isOnFire() { return _burning; }

  NutrientDropView getDropView() { return _dropView; }

  void render() {
    if (_flying) {
      image(_image, getPosition().x, getPosition().y);
      _image.resize(89, 25);
    }

    super.render();
    
    if (_burning && (millis()-_burnStartTime) > 3000) {
      stop();
    }

    if (!_reachedTree && _move) {
      if (_direction == Direction.RIGHT) {
        if (getPosition().x > width/2 - getDimensions().x) {
          _reachedTree = true;
          _dropView.start("drop");
        } else {
          setPosition(getPosition().x+1.25, getPosition().y);
        }
    } else {
      if (getPosition().x < width/2) {
          _reachedTree = true;
          _dropView.start("drop");
        } else {
          setPosition(getPosition().x-1.25, getPosition().y);
        }
      }
    }
  }
}

public enum Direction { LEFT, RIGHT }