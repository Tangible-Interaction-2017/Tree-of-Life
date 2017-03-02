public class WormView extends Animatable {
  private Direction _direction;
  private boolean _move, _flying;
  private boolean _reachedTree;
  private NutrientDropView _dropView;
  private PImage _image;

  WormView(int x, int y, Direction direction) {
    super(x, y, 89, 25); //<>//
    _direction = direction;
    _move = false;
    _reachedTree = false;
    _dropView = new NutrientDropView(width/2+25,  y+10);

    if (direction == Direction.RIGHT) {
      _image = loadImage("images/worm_right_0.png");
      String[] fileNames = {
        "images/worm_right_0.png",
        "images/worm_right_1.png"
      };
      int[] indices = { 0, 1 };
      addFrameAnimation("move", fileNames, indices, 0.4);
      addLinearAnimation("fly_out", -89, -25, 0.7);
    } else {
      _image = loadImage("images/worm_left_0.png");
      String[] fileNames = {
        "images/worm_left_0.png",
        "images/worm_left_1.png"
      };
      int[] indices = { 0, 1 };
      addFrameAnimation("move", fileNames, indices, 0.4);
      addLinearAnimation("fly_out", width, -25, 0.7);
    }
  }

  @Override
  void start(String id) {
    super.start(id);

    _flying = id == "fly_out";
    _move = id.equals("move");
  }

  @Override
  void stop() {
    super.stop();

    if (_flying) {
      if (_direction == Direction.RIGHT) {
        setPosition(-89, height/8*5 + (int)random(25));
      } else {
        setPosition(width, height/8*5 + (int)random(25));
      }
      _dropView.setPosition(width/2+_dropView.getDimensions().x/2, getPosition().y+25);
      _reachedTree = false;
      _flying = false;
    }
    _move = false;
  }

  boolean reachedTree() {
    return _reachedTree;
  }

  NutrientDropView getDropView() { return _dropView; }

  void render() {
    if (_flying) {
      image(_image, getPosition().x, getPosition().y);
      _image.resize(89, 25);
    }

    super.render();

    if (!_reachedTree && _move) {
      if (_direction == Direction.RIGHT) {
        if(getPosition().x>(width/2-getDimensions().x)){
          _dropView.start("drop");
        }
        else{
        setPosition(getPosition().x+5, getPosition().y);
        }
    } else {
      if (getPosition().x<width/2){
          _reachedTree = true;
          _dropView.start("drop");
        } else {
          setPosition(getPosition().x-5, getPosition().y);
        }
      }
    }
  }
}

public enum Direction { LEFT, RIGHT }