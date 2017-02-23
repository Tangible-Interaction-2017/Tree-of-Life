// Views
TreeView treeView;
ToolView toolView;
CursorView cursorView;

// Controllers
ToolController toolController;
CursorController cursorController;

void startAnimations() {
  treeView.start("stage_0_dying");
}

void stopAnimations() {
  treeView.stop();
}

void setup() {
  fullScreen();
  
  treeView = new TreeView(0, 0);
  toolView = new ToolView(50, 50);
  cursorView = new CursorView(mouseX, mouseY);
  
  toolController = new ToolController(toolView);
  cursorController = new CursorController(cursorView);
  
  startAnimations();
}

void mouseMoved() {
  cursorController.mouseMove();
  toolController.mouseHover();
}

void mousePressed() {
  toolController.mousePress();
  cursorController.mousePress();
}

void mouseDragged() {
  toolController.mouseDrag();
  cursorController.mouseDrag();
}

void mouseReleased() {
  toolController.mouseRelease();
  cursorController.mouseRelease();
}

void keyPressed() {
  if (key == 'q' || key == 'Q') exit();
}

void draw() {
  background(255);
  treeView.render();
  toolView.render();
  cursorView.render();
}