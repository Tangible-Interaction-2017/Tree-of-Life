Enemy enemy;
EnemyDirection direction = EnemyDirection.RIGHT;

void setup() {
  size(500, 500);
  enemy = new Enemy(-100, 0, direction);
}

void mouseReleased() {
  if (direction == EnemyDirection.LEFT) {
    direction = EnemyDirection.RIGHT;
    enemy = new Enemy(-100, 0, direction);
  } else {
    direction = EnemyDirection.LEFT;
    enemy = new Enemy(500, 0, direction);
  }
}

void draw() {
  background(55);
  enemy.update();
}