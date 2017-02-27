import bluetoothDesktop.*;

boolean toggle = false;
Bluetooth bt;

// Views
TreeView treeView;
WormView[] wormViews = new WormView[10];
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

void connect() {
  try {
    bt = new Bluetooth(this, Bluetooth.UUID_RFCOMM);
    bt.start("simpleService");
    bt.find();
  } catch (Exception e) {
    e.printStackTrace();
  }
}

void startAnimations() {
  if (!toggle) {
    treeView.start("stage_0");
  } else {
    treeView.start("stage_0_dying");
  }
}

void setup() {
  fullScreen();
  noCursor();
  
  treeView = new TreeView();
  treeController = new TreeController(treeView);
  
  for (int i = 0; i < 10; i++) {
    wormViews[i] = new WormView(width/2-300, height/8*5+i*25, Direction.RIGHT);
  }

  waterToolView = new ToolView(ToolType.WATER, width/2-300, height-100);
  fireToolView  = new ToolView(ToolType.FIRE,  width/2,     height-100);  
  windToolView  = new ToolView(ToolType.WIND,  width/2+300, height-100);
  
  Collidable[] collidables = {treeController};
  waterToolController = new ToolController(waterToolView, collidables);
  
  fireToolController  = new ToolController(fireToolView);
  
  windToolController  = new ToolController(windToolView);

  
  cursorView = new CursorView(mouseX, mouseY);
  cursorController = new CursorController(cursorView);
  
  treeView.start("stage_0");
  for (WormView wormView : wormViews) {
    wormView.start("move");
  }
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
  else if (key == 't' || key == 'T') { 
    toggle = !toggle;
    startAnimations();
  }
}

void draw() {
  background(255);
  
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
  
  // worm
  for (WormView wormView : wormViews) {
    wormView.render();
  }
  
  // tools
  waterToolView.render();
  fireToolView.render();
  windToolView.render();
  
  // cursor
  cursorView.render();
}