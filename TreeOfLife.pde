boolean toggle = false;

// Views
TreeView treeView;
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
  treeView.setPosition((width-treeView.getDimensions().x)/2,
                       height/8*5-treeView.getDimensions().y+20);
  treeController = new TreeController(treeView);

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
  
  // tools
  waterToolView.render();
  fireToolView.render();
  windToolView.render();
  
  // cursor
  cursorView.render();
}