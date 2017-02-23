public class ToolView extends GrabbableView {

  ToolView(float x, float y) {
    super(x, y); 
  }
  
  void render() {
    stroke(0);
    strokeWeight(2);
    
    if (isHovered())      fill(240);
    else                  fill(180);
    
    final float diameter = 2*getRadius(); 
    ellipse(getX(), getY(), diameter, diameter);
  }
}