import processing.serial.*;
//import bluetoothDesktop.*;
Serial glove;
boolean clicked = false;

Progress progress;
int stage = 0;
boolean isDying = false;
float nextWormTime = 0;
int currentWormIndex = 0;
int previousWormsAtTree = 0;
float frequency = 0;

// Views
TreeView treeView;
WormView[] wormViews = new WormView[10];
ProgressView progressView;
ToolView waterToolView;
ToolView fireToolView;
ToolView windToolView;
CursorView cursorView;

// Controllers
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
        glove = new Serial(this, device, 96000);
        connected = true;
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
    treeView.start("stage_" + stage + "_dying");
  } else if (isDying && totalProgressChange >= 0) {
    isDying = false;
    treeView.start("stage_" + stage);
  }

  if (currentStage != stage) {
    stage = currentStage;
    treeView.transition("stage_" + stage + (isDying ? "_dying" : ""), 0.5);
  }
}

void setup() {
  //connect();

  fullScreen();
  noCursor();

  progress = new Progress();
  progress.addProgressChange(-0.0001, Float.POSITIVE_INFINITY);

  treeView = new TreeView();
  treeController = new TreeController(treeView);

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
  windToolController  = new ToolController(windToolView, wormControllers);

  progressView = new ProgressView(progress);

  cursorView = new CursorView(mouseX, mouseY);
  cursorController = new CursorController(cursorView);

  nextWormTime = (float)millis()/1000 + 10 + random(10);

  treeView.start("stage_0");
}

void mouseMoved() {
  cursorController.mouseMove();
  /*
  waterToolController.mouseDrag();
  fireToolController.mouseDrag();
  windToolController.mouseDrag();
  cursorController.mouseDrag();
  */
}

void mouseDragged() {

  waterToolController.mouseDrag();
  fireToolController.mouseDrag();
  windToolController.mouseDrag();
  cursorController.mouseDrag();
}

void mousePressed() {
  waterToolController.mousePress();
  fireToolController.mousePress();
  windToolController.mousePress();
  cursorController.mousePress();
}

void mouseReleased() {
  waterToolController.mouseRelease();
  fireToolController.mouseRelease();
  windToolController.mouseRelease();
  cursorController.mouseRelease();
}

void keyPressed() {
  if (key == 'q' || key == 'Q') exit();
}

void draw() {
  background(255);

  // handle input
  /*
  int readValue = glove.read();
  if (readValue == 1 && !clicked) {
    clicked = true;
    mousePressed();
  } else if (readValue == 0 && clicked) {
    clicked = false;
    mouseReleased();
  }
  */

  // handle animations
  handleAnimations();

  // hover
  waterToolController.mouseHover();
  fireToolController.mouseHover();
  windToolController.mouseHover();

  // grass
  noStroke();
  fill(100, 200, 100);
  rect(0, height/8*5, width, height/2);

  // tree
  treeView.render();

  // worms
  if ((float)millis()/1000 > nextWormTime) {
    wormViews[currentWormIndex].start("move");
    nextWormTime = (float)millis()/1000 + 5 - frequency * 0.5 + random(5 - frequency * 0.5);
    currentWormIndex = (currentWormIndex + 1) % wormControllers.length;
    frequency = min(frequency + 7, 7);
  }

  int currentWormsAtTree = 0;
  for (WormView wormView : wormViews) {
    wormView.render();
    wormView.getDropView().render();
    if (wormView.reachedTree()) {
      currentWormsAtTree++;
    }
  }
  if (currentWormsAtTree > previousWormsAtTree) {
    for (int i = 0; i < currentWormsAtTree - previousWormsAtTree; i++) {
      progress.addProgressChange(-0.00005, Float.POSITIVE_INFINITY);
      progress.addProgressChange(0.001, 0.5);
      progressView.start("boost");
    }
    previousWormsAtTree = currentWormsAtTree;
  } else if (currentWormsAtTree < previousWormsAtTree) {
    for (int i = 0; i < previousWormsAtTree - currentWormsAtTree; i++) {
      progress.addProgressChange(0.00005, Float.POSITIVE_INFINITY);
    }
    previousWormsAtTree = currentWormsAtTree;
  }

  // progress bar
  progressView.render();

  // tools
  waterToolView.render();
  fireToolView.render();
  windToolView.render();

  // cursor
  cursorView.render();
}