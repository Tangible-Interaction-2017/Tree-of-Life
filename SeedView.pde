public class SeedView extends GrabbableView {
  private PImage _image;
  
  SeedView() {
    super(width/4*3, height/8*5+20); 
    
    _image = loadImage("images/seed.png");
    _image.resize(50, 50);
    
    addLinearAnimation("pull_back", getPosition().x, getPosition().y, 0);
  }
  
  void render() {
    super.render();
   
    image(_image, getPosition().x, getPosition().y); 
  }
}