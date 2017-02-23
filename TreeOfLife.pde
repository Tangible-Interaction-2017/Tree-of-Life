boolean toggle = false;

// Views
TreeView treeView;
ToolView[] toolViews;
CursorView cursorView;

// Controllers
ToolController[] toolControllers;
CursorController cursorController;

void startAnimations() {
  if (!toggle) {
    treeView.stop("stage_0_dying");
    treeView.start("stage_0");
  } else {
    treeView.stop("stage_0");
    treeView.start("stage_0_dying");
  }
}

void setup() {
  fullScreen();
  
  treeView = new TreeView();
  toolControllers = new ToolController[5];
  treeView.setPosition((width-treeView.getDimensions().x)/2,
                       height/8*5-treeView.getDimensions().y+20);
  
  toolViews = new ToolView[5];
  for (int i = 0; i < 5; i++) {
    ToolView toolView = new ToolView(width/2-200*(i-2), height-100);
    toolViews[i] = toolView;
    toolControllers[i] = new ToolController(toolView);
  }
  
  cursorView = new CursorView(mouseX, mouseY);
  cursorController = new CursorController(cursorView);
  
  startAnimations();
}

void mouseMoved() {
  for (ToolController toolController : toolControllers) {
    toolController.mouseHover();
  }
  
  cursorController.mouseMove();
}

void mousePressed() {
  for (ToolController toolController : toolControllers) {
    toolController.mousePress();
  }
  
  cursorController.mousePress();
}

void mouseDragged() {
  for (ToolController toolController : toolControllers) {
    toolController.mouseDrag();
  }
  
  cursorController.mouseDrag();
}

void mouseReleased() {
  for (ToolController toolController : toolControllers) {
    toolController.mouseRelease();
  }
  for (ToolView toolView : toolViews) {
    toolView.start("pull_back");
  }
  
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
  
  // grass
  noStroke();
  fill(100, 200, 100);
  rect(0, height/8*5, width, height/2);
  
  // tree
  treeView.render();
  
  // tools
  for (ToolView toolView : toolViews) {
    toolView.render();
  }
  
  // cursor
  cursorView.render();
}