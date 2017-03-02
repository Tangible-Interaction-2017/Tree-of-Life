public class PitView extends Drawable {
  private PImage _image;
  
  PitView() {
    super(width/2 - 37, height/8*5 - 5, 75, 50); 
    
    _image = loadImage("images/pit.png");
    _image.resize(75, 50);
  }
  
  void render() {
    image(_image, getPosition().x, getPosition().y); 
  }
}