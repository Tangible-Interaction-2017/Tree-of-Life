public class ToolView extends GrabbableView {
  private ToolType _type;
  private float _timer;
  private int _startTime;
  private boolean _timeOut;
  private PImage _image;
  
  ToolView(ToolType type, float x, float y) {
    super(x, y, 75); 
    _type = type;
    
    switch (_type) {
      case WATER: _image = loadImage("images/tool_water.png"); break;
      case FIRE:  _image = loadImage("images/tool_fire.png");  break;
      case WIND:  _image = loadImage("images/tool_wind.png");  break;
    }
    
    _image.resize(150, 150);
    addLinearAnimation("pull_back", x, y, 0.25);
  }
  
  void startTimer(float duration) {
    _timeOut = false;
    _timer = duration;
    _startTime = millis();
  }
  
  void render() {
    super.render();
    
    final float diameter = 2*getRadius(); 
    
    float elapsed = (float)(millis()-_startTime)/1000;
    _timeOut = elapsed >= _timer;
    if (!_timeOut) tint(255, 50);
    image(_image, getPosition().x-75, getPosition().y-75);
    tint(255, 255);
    
    if (isHovered()) {
    }
    
    noFill();
    if (!_timeOut) {
      stroke(230, 230, 255);
      strokeWeight(10);
      arc(getPosition().x, getPosition().y, diameter, diameter, -PI/2, 2*PI*elapsed/_timer-PI/2);
    } else if (isHovered()) {
      stroke(0);
      strokeWeight(5);
      ellipse(getPosition().x, getPosition().y, diameter, diameter);
    }
  }
  
  ToolType getType() { return _type; }
  boolean isTimeOut() { return _timeOut; }
}

public enum ToolType { WATER, FIRE, WIND }