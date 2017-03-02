public class NutrientDrop extends Animatable {
  private PImage _image;
  
  NutrientDrop(int x, int y) {
    super(x, y, 25, 35);
    println("drop created");
    PImage _image = loadImage("images/nutrient_drop.png");
    _image.resize(25, 35);
    //addLinearAnimation("drop", x, height, 1);
  }
  
  @Override
  void render() {
    super.render();
    println("drop rendered");
    image( _image, getPosition().x-25, getPosition().y-35);
  }
}
  
  