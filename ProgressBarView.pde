public class ProgressView extends Animatable {
  private Progress _progress;
  
  ProgressView(Progress progress) {
    super(width/8, 30, width/4*3, 35);
    _progress = progress;
    setColor(250, 175, 175);
    
    addColorAnimation("boost", 175, 250, 175, 250, 175, 175, 0.5);
  }
  
  void render() {
    super.render();
    
    Vector2 pos = getPosition();
    Vector2 dim = getDimensions();
    
    // update progress
    _progress.applyProgressChanges();
    
    // progress bar
    noStroke();
    fill(getRed(), getGreen(), getBlue());
    rect(pos.x, pos.y, dim.x*_progress.getProgress(), dim.y);
    
    // frame
    noFill();
    stroke(127);
    strokeWeight(3);
    
    rect(pos.x, pos.y, dim.x, dim.y);
    for (int i = 1; i < 4; i++) {
      line(pos.x+dim.x/4*i, pos.y, pos.x+dim.x/4*i, pos.y+dim.y);
    }
  }
}