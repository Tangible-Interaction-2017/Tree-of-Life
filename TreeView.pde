public class TreeView extends Animatable {
  TreeView(float x, float y) {
    super(x, y, 0.5, 15);
    
    String[] fileNames = {
      "images/tree_stage_0_0.png", 
      "images/tree_stage_0_1.png", 
      "images/tree_stage_0_2.png", 
      "images/tree_stage_0_3.png",
      "images/tree_stage_0_4.png",
      "images/tree_stage_0_5.png",
      "images/tree_stage_0_6.png"
    };
    int[] indices = {
      0, 1, 2, 3, 4, 5, 6
    };
    addAnimation("stage_0", fileNames, indices, 0.5);
    
    fileNames = new String[] {
      "images/tree_stage_0_dying_0.png", 
      "images/tree_stage_0_dying_1.png", 
      "images/tree_stage_0_dying_2.png", 
      "images/tree_stage_0_dying_3.png"
    };
    indices = new int[] {
      0, 1, 2, 3
    };
    addAnimation("stage_0_dying", fileNames, indices, 0.5);
  }
}