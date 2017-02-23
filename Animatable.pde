public abstract class Animatable extends Drawable {
  
  final private class Animation {
    PImage[] images;
    int[] indices;
    int duration;
    
    Animation(PImage[] images, int[] indices, int duration) {
      this.images   = images;
      this.indices  = indices;
      this.duration = duration;
    }
  }  
  
  private HashMap<String, Animation> _animations;
  private float _scale;
  private boolean _animating;
  private int _startTime; 
  private Animation _current_animation;
  
  Animatable(float x, float y, float scale) {
    super(x, y);
    _animations = new HashMap();
    _scale = scale;
    _animating = false;
  }
  
  void addAnimation(String id, String[] fileNames, int[] indices, float duration) {
    PImage[] images = new PImage[fileNames.length]; 
    for (int i = 0; i < fileNames.length; i++) {
      PImage image = loadImage(fileNames[i]);
      image.resize((int)(image.width * _scale), 
                   (int)(image.height * _scale));
      images[i] = image;
    }
    
    _animations.put(id, new Animation(images, indices, (int)(duration*1000)));
  }
  
  void start(String id) {
    _current_animation = _animations.get(id);
    _animating = true;
    _startTime = millis();
  }
  
  void stop() {
    _animating = false;
  }
  
  void render() {
    if (_animating) {
      int elapsed = (millis() - _startTime) % _current_animation.duration;
      int index = (int)Math.floor((float)elapsed / _current_animation.duration * _current_animation.indices.length);
      
      image(_current_animation.images[_current_animation.indices[index]], getX(), getY());
    }
  }
}