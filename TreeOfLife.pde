// Views
CursorView cursorView;
ToolView toolView;

// Controllers
CursorController cursorController;
ToolController toolController;

void setup() {
  size(500, 500);
  
  cursorView = new CursorView(mouseX, mouseY);
  toolView = new ToolView(250, 250);
  
  cursorController = new CursorController(cursorView);
  toolController = new ToolController(toolView);
}

void mouseMoved() {
  cursorController.mouseMove();
  toolController.mouseHover();
}

void mousePressed() {
  cursorController.mousePress();
  toolController.mousePress();
}

void mouseDragged() {
  cursorController.mouseDrag();
  toolController.mouseDrag();
}

void mouseReleased() {
  cursorController.mouseRelease();
  toolController.mouseRelease();
}

void draw() {
  background(55);
  toolView.render();
  cursorView.render();
}