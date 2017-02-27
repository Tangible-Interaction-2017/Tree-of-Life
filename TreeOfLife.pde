//import bluetoothDesktop.*;
//Bluetooth bt;

Progress progress;
int stage = 0;
boolean isDying = false;
float nextWormTime = 0;
int currentWormIndex = 0;
int previousWormsAtTree = 0;

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
ToolController waterToolController;
ToolController fireToolController;
ToolController windToolController;
CursorController cursorController;

///void connect() {
//  try {
//    bt = new Bluetooth(this, Bluetooth.UUID_RFCOMM);
//    bt.start("simpleService");
//    bt.find();
//  } catch (Exception e) {
//    e.printStackTrace();
//  }
//}

void handleAnimations() {
  int currentStage = min(floor(progress.getProgress() * 4), 3);
  float totalProgressChange = progress.getTotalProgressChange();
  
  if (!isDying && totalProgressChange < 0) {
    isDying = true;
    treeView.start("stage_" + stage + "_dying");
  } else if (isDying && totalProgressChange > 0) {
    isDying = false; 
    treeView.start("stage_" + stage);
  }
 
  if (currentStage != stage) {
    stage = currentStage;
    treeView.transition("stage_" + stage + (isDying ? "_dying" : ""), 0.5);
  }
}

void setup() {
  fullScreen();
  noCursor();
  
  progress = new Progress();
  progress.addProgressChange(-0.0001, Float.POSITIVE_INFINITY);
  
  treeView = new TreeView();
  treeController = new TreeController(treeView);
  
  for (int i = 0; i < 10; i++) {
    Direction direction = Direction.RIGHT;
    int x = -89; // 89, 25
    int y = height/8*5;
    if (random(1) < 0.5) {
      direction = Direction.LEFT;
      x = width;
    }
    wormViews[i] = new WormView(x, y + (int)random(25), direction);
  }

  waterToolView = new ToolView(ToolType.WATER, width/2-300, height-100);
  fireToolView  = new ToolView(ToolType.FIRE,  width/2,     height-100);  
  windToolView  = new ToolView(ToolType.WIND,  width/2+300, height-100);
  waterToolController = new ToolController(waterToolView, new Collidable[]{treeController});
  waterToolController.setProgress(progress);
  fireToolController  = new ToolController(fireToolView);
  windToolController  = new ToolController(windToolView);
  
  progressView = new ProgressView(progress);
  
  cursorView = new CursorView(mouseX, mouseY);
  cursorController = new CursorController(cursorView);
  
  nextWormTime = (float)millis()/1000 + 10 + random(10);
  
  treeView.start("stage_0");
}

void mouseMoved() {
  cursorController.mouseMove();
}

void mousePressed() {
  waterToolController.mousePress();
  fireToolController.mousePress();
  windToolController.mousePress();
  cursorController.mousePress();
}

void mouseDragged() {
  waterToolController.mouseDrag();
  fireToolController.mouseDrag();
  windToolController.mouseDrag();
  cursorController.mouseDrag();
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
  if ((float)millis()/1000 > nextWormTime && currentWormIndex < 10) {
    wormViews[currentWormIndex].start("move");
    nextWormTime = (float)millis()/1000 + 10 - (float)currentWormIndex/2 + random(10 - (float)currentWormIndex/2);
    currentWormIndex++;
  }
  
  int currentWormsAtTree = 0;
  for (WormView wormView : wormViews) {
    if (wormView.reachedTree()) currentWormsAtTree++;
    wormView.render();
  }
  if (currentWormsAtTree > previousWormsAtTree) {
    previousWormsAtTree = currentWormsAtTree;
    progress.addProgressChange(-0.00005, Float.POSITIVE_INFINITY);
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