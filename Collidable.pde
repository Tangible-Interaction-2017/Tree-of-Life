public abstract class Collidable {
  boolean collide(Collidable collider) {
    return dist(getPosition().x, getPosition().y, collider.getPosition().x, collider.getPosition().y) <= getRadius() + collider.getRadius();
  } 
  
  abstract Vector2 getPosition();
  abstract float getRadius();
} 