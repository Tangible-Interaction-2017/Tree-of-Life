import processing.serial.*;
//import bluetoothDesktop.*;
Serial glove;
boolean clicked = false;
int time = 181;
float startTime;
boolean gameOver = true;

Progress progress;
int stage = 0;
boolean isDying = false;
float nextWormTime = 0;
int currentWormIndex = 0;
int previousWormsAtTree = 0;
float frequency = 0;

// Views
PitView pitView;
SeedView seedView;
TreeView treeView;
WormView[] wormViews = new WormView[10];
ProgressView progressView;
ToolView waterToolView;
ToolView fireToolView;
ToolView windToolView;
CursorView cursorView;

// Controllers
PitController pitController;
SeedController seedController;
TreeController treeController;
WormController[] wormControllers = new WormController[10];
ToolController waterToolController;
ToolController fireToolController;
ToolController windToolController;
CursorController cursorController;

void connect() {
  boolean connected = false;
  do {
    for (String device : Serial.list()) {
      if (device.equals("/dev/tty.HC-06-DevB")) {
        try {
          glove = new Serial(this, device, 9600);
          connected = true;
        } catch (Exception e) {}
      }
    }
    if (!connected) {
      println("Falled to find device \'/dev/tty.HC-06-DevB\'");
      delay(1000);
    }
  } while (!connected);

  println("Found device \'/dev/tty.HC-06-DevB\'");
  delay(1000);
}

void handleAnimations() {
  int currentStage = min(floor(progress.getProgress() * 4), 3);
  float totalProgressChange = progress.getTotalProgressChange();

  if (!isDying && totalProgressChange < 0) {
    isDying = true;
    if (!treeView.isOnFire()) treeView.start("stage_" + stage + "_dying");
  } else if (isDying && totalProgressChange >= 0) {
    isDying = false;
    if (!treeView.isOnFire()) treeView.start("stage_" + stage);
  }

  if (currentStage != stage) {
    stage = currentStage;
    treeView.transition("stage_" + stage + (treeView.isOnFire() ? "_fire" : (isDying ? "_dying" : "")), 0.5);
  }
}

void setup() {
  connect();
  
  fullScreen();
  noCursor();
  
  progress = new Progress();

  pitView = new PitView();
  pitController = new PitController(pitView);

  seedView = new SeedView();
  seedController = new SeedController(seedView, pitController);
  
  treeView = new TreeView();
  treeController = new TreeController(treeView);
  treeController.setProgress(progress);
  
  for (int i = 0; i < wormViews.length; i++) {
    Direction direction = Direction.RIGHT;
    int x = -89; // 89, 25
    int y = height/8*5;
    if (random(1) < 0.5) {
      direction = Direction.LEFT;
      x = width;
    }
    wormViews[i] = new WormView(x, y + (int)random(25), direction);
    wormControllers[i] = new WormController(wormViews[i]);
  }

  waterToolView = new ToolView(ToolType.WATER, width/2-300, height-100);
  fireToolView  = new ToolView(ToolType.FIRE,  width/2,     height-100);
  windToolView  = new ToolView(ToolType.WIND,  width/2+300, height-100);
  waterToolController = new ToolController(waterToolView, new Collidable[]{treeController});
  waterToolController.setProgress(progress);
  
  Collidable[] fireToolCollidables = new Collidable[wormControllers.length+1];
  for (int i = 0; i < wormControllers.length; i++) {
    fireToolCollidables[i] = wormControllers[i];
  }
  fireToolCollidables[wormControllers.length] = treeController;
  fireToolController  = new ToolController(fireToolView, fireToolCollidables);
  fireToolController.setProgress(progress);
  windToolController  = new ToolController(windToolView, wormControllers);

  progressView = new ProgressView(progress);

  cursorView = new CursorView(mouseX, mouseY);
  cursorController = new CursorController(cursorView);
}

void mouseMoved() {
  println("Moved");
  cursorController.mouseMove();
  waterToolController.mouseDrag();
  fireToolController.mouseDrag();
  windToolController.mouseDrag();
  cursorController.mouseDrag();
  seedController.mouseDrag();
}

void mousePressed() {
  println("Pressed");
  cursorController.mousePress();
  if (!gameOver) {
    waterToolController.mousePress();
    fireToolController.mousePress();
    windToolController.mousePress();
  } else {
    seedController.mousePress();
  }
}

void mouseReleased() {
  println("Released");
  cursorController.mouseRelease();
  if (!gameOver) {
    waterToolController.mouseRelease();
    fireToolController.mouseRelease();
    windToolController.mouseRelease();
  } else {
    seedController.mouseRelease();
    if (seedController.isActivated()) reset();
  }
}

void keyPressed() {
  if (key == 'q' || key == 'Q') exit();
}

void gameOver() {
  gameOver = true;
  seedController.deactivate();
}

void reset() {
  gameOver = false;
  
  progress.resetProgress();
  progress.changeProgressBy(0.001);
  progress.addProgressChange("general", -0.0001, Float.POSITIVE_INFINITY);
  progress.addProgressChange("start", 0.005, 0.5);
  progressView.start("boost");
  
  for (WormView wormView : wormViews) wormView.reset();
  
  treeView.start("stage_0");
  nextWormTime = (float)millis()/1000 + 10 + random(10);
  startTime = (float)millis()/1000;
}

void draw() {
  background(255);

  // handle input
  int readValue = glove.read();
  if (readValue == 1 && !clicked) {
    clicked = true;
    println("Grasped");
    mousePressed();
  } else if (readValue == 0 && clicked) {
    clicked = false;
    println("Released");
    mouseReleased();
  }

  // handle animations
  handleAnimations();

  // hover
  if (!gameOver) {
    waterToolController.mouseHover();
    fireToolController.mouseHover();
    windToolController.mouseHover();
  }

  // grass
  noStroke();
  fill(100, 200, 100);
  rect(0, height/8*5, width, height/2);

  if (!gameOver) {
    // tree
    treeView.render();
  
    // worms
    if ((float)millis()/1000 > nextWormTime) {
      wormViews[currentWormIndex].start("move");
      nextWormTime = (float)millis()/1000 + 5 - frequency * 0.5 + random(4 - frequency * 0.5);
      currentWormIndex = (currentWormIndex + 1) % wormControllers.length;
      frequency = min(frequency + 0.5, 6);
    }
  
    int currentWormsAtTree = 0;
    for (int i = 0; i < wormViews.length; i++) {
      WormView wormView = wormViews[i];
      wormView.render();
      wormView.getDropView().render();
      if (wormView.reachedTree()) {
        currentWormsAtTree++;
      }
      
      WormController wormController = wormControllers[i];
      for (int j = i+1; j < wormControllers.length; j++) {
        WormController otherWormController = wormControllers[j];
        if (wormController.collide(otherWormController)) {
          if (!wormController.isOnFire() && otherWormController.isOnFire()) {
            wormController.getView().start("fire");
          } else if (wormController.isOnFire() && !otherWormController.isOnFire()) {
            otherWormController.getView().start("fire");
          }
        }
        if (wormController.collide(treeController)) {
          if (!wormController.isOnFire() && treeController.isOnFire()) {
            wormController.getView().start("fire");
          } else if (wormController.isOnFire() && !treeController.isOnFire()) {
            treeController.getView().start("fire");
          }
        }
      }
    }
    if (currentWormsAtTree > previousWormsAtTree) {
      for (int i = 0; i < currentWormsAtTree - previousWormsAtTree; i++) {
        progress.addProgressChange("worm", -0.00005, Float.POSITIVE_INFINITY);
        progress.addProgressChange("nutrient", 0.001, 0.5);
        progressView.start("boost");
      }
      previousWormsAtTree = currentWormsAtTree;
    } else if (currentWormsAtTree < previousWormsAtTree) {
      for (int i = 0; i < previousWormsAtTree - currentWormsAtTree; i++) {
        progress.removeProgressChange("worm");
      }
      previousWormsAtTree = currentWormsAtTree;
    }
  
    // progress bar
    progressView.render();
  
    // tools
    waterToolView.render();
    fireToolView.render();
    windToolView.render();
  
    // timer
    float timeLeft = time-((float)millis()/1000 - startTime);
    if (timeLeft < 0) gameOver();
    else {
      int minutes = floor(timeLeft / 60);
      int seconds = floor(timeLeft % 60);
      textSize(40);
      fill(0);
      text(minutes + ":" + (seconds < 10 ? "0" : "") + seconds, width/2-40, 110);
    }
    
    if (progress.getProgress() <= 0.0001) gameOver();
  } else {
    pitView.render();
    seedView.render();
  }

  // cursor
  cursorView.render();
}