public class ToolView extends GrabbableView {

  ToolView(float x, float y) {
    super(x, y); 
    
    addLinearAnimation("pull_back", x, y, 0.25);
  }
  
  void render() {
    super.render();
    
    stroke(0);
    strokeWeight(2);
    
    if (isHovered())      fill(240);
    else                  fill(180);
    
    final float diameter = 2*getRadius(); 
    ellipse(getPosition().x, getPosition().y, diameter, diameter);
  }
}