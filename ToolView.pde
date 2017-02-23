public class ToolView extends GrabbableView {
  private float _speed = 1;
  
  ToolView(float x, float y) {
    super(x, y); 
  }
  
  void render() {
    stroke(0);
    strokeWeight(2);
    
    if (isHovered())      fill(120);
    else                  fill(100);
    
    final float diameter = 2*getRadius(); 
    ellipse(getX(), getY(), diameter, diameter);
  }
}