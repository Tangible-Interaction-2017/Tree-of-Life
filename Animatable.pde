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
    Vector2 startPoint;
    Vector2 endPoint;
    
    _LinearAnimation(float toX, float toY, int duration) {
      super(duration);
      this.endPoint = new Vector2(toX, toY);
    }
  }
  
  private class _ColorAnimation extends _Animation {
    int startR, startG, startB, endR, endG, endB;
    
    
    _ColorAnimation(int fromR, int fromG, int fromB, int toR, int toG, int toB, int duration) {
      super(duration);
      this.startR = fromR;
      this.startG = fromG;
      this.startB = fromB;
      this.endR   = toR;
      this.endG   = toG;
      this.endB   = toB;
    }
  }
  
  private HashMap<String, _Animation> _animations;
  private int _startTime; 
  private int _transitionStartTime;
  private int _transitionDuration;
  private boolean _animating;
  private _Animation _currentAnimation;
  private _FrameAnimation _nextFrameAnimation;
  
  Animatable(float x, float y, float width, float height) {
    super(x, y, width, height);
    _animations = new HashMap();
    _animating  = false;
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
  
  void addColorAnimation(String id, int fromR, int fromG, int fromB, int toR, int toG, int toB, float duration) {
    _animations.put(id, new _ColorAnimation(fromR, fromG, fromB, toR, toG, toB, (int)(duration*1000)));
  }
  
  void start(String id) {
    _animating = true;
    _currentAnimation = _animations.get(id);
    if (_currentAnimation instanceof _LinearAnimation) {
      ((_LinearAnimation)_currentAnimation).startPoint = getPosition().clone();
    }
    _startTime = millis();
  }
  
  boolean transition(String id, float duration) {
    _Animation animation = _animations.get(id);
    if (animation instanceof _FrameAnimation) {
      _nextFrameAnimation = (_FrameAnimation)animation;
      if (_currentAnimation == null) {
        _currentAnimation = new _FrameAnimation(new PImage[]{new PImage()}, new int[]{0}, 1);
      }
      _animating = true;
      _transitionDuration = (int)(duration*1000);
      _transitionStartTime = millis();
      return true;
    }
    return false;
  }
  
  void stop() {
    _animating = false;
    if (_currentAnimation instanceof _LinearAnimation) {
      _LinearAnimation linearAnimation = (_LinearAnimation)_currentAnimation;
       setPosition(linearAnimation.endPoint.x, linearAnimation.endPoint.y);
    }
    _currentAnimation = null;
    _nextFrameAnimation = null;
  }
  
  void render() {
    if (_animating) {
      if (_currentAnimation instanceof _FrameAnimation) {
        
        // frame animation
        _FrameAnimation frameAnimation = (_FrameAnimation)_currentAnimation;
        int elapsed = (millis() - _startTime) % frameAnimation.duration;
        int index = floor((float)elapsed / frameAnimation.duration * frameAnimation.indices.length);
         
        if (_nextFrameAnimation == null) {
          image(frameAnimation.images[frameAnimation.indices[index]], getPosition().x, getPosition().y);
        } else {
          int nextAnimationElapsed = (millis() - _startTime) % _nextFrameAnimation.duration;
          int nextAnimationIndex = floor((float)nextAnimationElapsed / _nextFrameAnimation.duration * _nextFrameAnimation.indices.length);
          int transitionElapsed = millis() - _transitionStartTime;
          
          int progress = 255;
          if (transitionElapsed < _transitionDuration)  {
            progress = (int)((float)transitionElapsed / _transitionDuration * 255);   
          }
          
          tint(255, 255-progress);
          image(frameAnimation.images[frameAnimation.indices[index]], getPosition().x, getPosition().y);
          tint(255, progress);
          image(_nextFrameAnimation.images[_nextFrameAnimation.indices[nextAnimationIndex]], getPosition().x, getPosition().y);
          tint(255, 255); 
          
          if (transitionElapsed >=_transitionDuration)  {
            _currentAnimation = _nextFrameAnimation;
            _nextFrameAnimation = null;
          }
        }       
        
      } else if (_currentAnimation instanceof _LinearAnimation) {
        
        // linear path animation
        _LinearAnimation linearAnimation = (_LinearAnimation)_currentAnimation;
        int elapsed = (millis() - _startTime);
        if (elapsed < linearAnimation.duration) {
          float t = (float)elapsed / linearAnimation.duration;
          setPosition(linearAnimation.startPoint.x*(1-t) + linearAnimation.endPoint.x*t, 
                        linearAnimation.startPoint.y*(1-t) + linearAnimation.endPoint.y*t);
        } else {
          setPosition(linearAnimation.endPoint.x, linearAnimation.endPoint.y);
          stop();
        }
      } else if (_currentAnimation instanceof _ColorAnimation) {
        _ColorAnimation colorAnimation = (_ColorAnimation)_currentAnimation;
        int elapsed = (millis() - _startTime);
        if (elapsed < colorAnimation.duration) {
          float t = (float)elapsed / colorAnimation.duration;
          int r = (int)(colorAnimation.startR * (1-t) + colorAnimation.endR * t);
          int g = (int)(colorAnimation.startG * (1-t) + colorAnimation.endG * t);
          int b = (int)(colorAnimation.startB * (1-t) + colorAnimation.endB * t);
          setColor(r, g, b);
        } else {
          setColor(colorAnimation.endR, colorAnimation.endG, colorAnimation.endB);
          stop();
        }
      }
    }
  }
  
}