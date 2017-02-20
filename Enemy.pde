public class Enemy extends Drawable {
  final float size = 100;
  final float speed = 1;
  EnemyDirection direction;
  
  Enemy(float x, float y, EnemyDirection direction) {
    super(x, y); 
    this.direction = direction;
  }
  
  void draw(float x, float y) {
    ellipse(x + size/2, y + size/2, size, size);
    this.x += direction.rawValue() * speed;
  }
}

public enum EnemyDirection { 
  LEFT  (-1), 
  RIGHT (1);
  
  int rawValue;
  
  private EnemyDirection(int rawValue){
    this.rawValue = rawValue;
  }
  
  int rawValue() { return rawValue; }; 
};