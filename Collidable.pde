public abstract class Collidable {
  boolean collide(Collidable collider) {
    return dist(getCenter().x, getCenter().y, collider.getCenter().x, collider.getCenter().y) <= getRadius() + collider.getRadius();
  } 
  
  abstract Vector2 getCenter();
  abstract float getRadius();
} 