public abstract class Animatable extends Drawable {
  
  private abstract class _Animation {
    int duration;
    
    _Animation(int duration) {
      this.duration = duration;
    }
  }
  
  private class _FrameAnimation extends _Animation {
    PImage[] images;
    int[] indices;
    
    _FrameAnimation(PImage[] images, int[] indices, int duration) {
      super(duration);
      this.images   = images;
      this.indices  = indices;
      this.duration = duration;
    }
  }  
  
  private class _LinearAnimation extends _Animation {
    Vector2 endPoint;
    
    _LinearAnimation(float toX, float toY, int duration) {
      super(duration);
      this.endPoint = new Vector2(toX, toY);
    }
    
  }
  
  private HashMap<String, _Animation> _animations;
  private int _startTime; 
  private ArrayList<String> _currentAnimations;
  
  Animatable(float x, float y, float width, float height) {
    super(x, y, width, height);
    _animations        = new HashMap();
    _currentAnimations = new ArrayList();
  }
  
  void addFrameAnimation(String id, String[] fileNames, int[] indices, float duration) {
    PImage[] images = new PImage[fileNames.length]; 
    for (int i = 0; i < fileNames.length; i++) {
      PImage image = loadImage(fileNames[i]);
      image.resize((int)(getDimensions().x), (int)(getDimensions().y));
      images[i] = image;
    }
    
    _animations.put(id, new _FrameAnimation(images, indices, (int)(duration*1000)));
  }
 
  void addLinearAnimation(String id, float toX, float toY, float duration) {
    _animations.put(id, new _LinearAnimation(toX, toY, (int)(duration*1000)));
  }
  
  void start(String id) {
    _currentAnimations.add(id);
    _startTime = millis();
  }
  
  void stop(String id) {
    _currentAnimations.remove(id);
  }
  
  void render() {
    ArrayList<String> idsToRemove = new ArrayList();
    for (String id : _currentAnimations) {
      _Animation animation = _animations.get(id);
      if (animation instanceof _FrameAnimation) {
        
        _FrameAnimation frameAnimation = (_FrameAnimation)animation;
        int elapsed = (millis() - _startTime) % frameAnimation.duration;
        int index = (int)Math.floor((float)elapsed / frameAnimation.duration * frameAnimation.indices.length);
        image(frameAnimation.images[frameAnimation.indices[index]], getPosition().x, getPosition().y);
        
      } else if (animation instanceof _LinearAnimation) {
        
        _LinearAnimation linearAnimation = (_LinearAnimation)animation;
        int elapsed = (millis() - _startTime);
        if (elapsed < linearAnimation.duration) {
          float t = (float)elapsed / linearAnimation.duration;
          setPosition(getPosition().x*(1-t) + linearAnimation.endPoint.x*t, 
                      getPosition().y*(1-t) + linearAnimation.endPoint.y*t);
        } else {
          setPosition(linearAnimation.endPoint.x, linearAnimation.endPoint.y);
          idsToRemove.add(id);
        }        
      }
    }
    
    for (String id : idsToRemove) stop(id);
  }
  
}