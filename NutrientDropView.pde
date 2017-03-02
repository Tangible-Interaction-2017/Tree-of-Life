public class NutrientDropView extends Animatable {
  private PImage _image;
  private boolean _visible;
  
  NutrientDropView(int x, int y) {
    super(x, y, 50, 70);
    
    _visible = false;
    _image = loadImage("images/nutrient_drop.png"); //<>//
    _image.resize(50, 70);
    addLinearAnimation("drop", x, 70+y+50, 0.5);
  }
  
  
  @Override
  void start(String id) {
    super.start(id);
    
    _visible = true;
  }
  
  @Override 
  void stop() {
    super.stop();
    
    _visible = false;
  }
  @Override
  void render() {
    super.render();
    
    if (_visible) {
      image(_image, getPosition().x-50, getPosition().y-70);
    }
  }
}