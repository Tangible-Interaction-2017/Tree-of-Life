public class TreeView extends Animatable {
  TreeView() {
    super(0, 0, width/10, 1.392 * width/10);
    
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
    addFrameAnimation("stage_0", fileNames, indices, 0.7);
    
    fileNames = new String[] {
      "images/tree_stage_0_dying_0.png", 
      "images/tree_stage_0_dying_1.png", 
      "images/tree_stage_0_dying_2.png", 
      "images/tree_stage_0_dying_3.png"
    };
    indices = new int[] {
      0, 1, 2, 3
    };
    addFrameAnimation("stage_0_dying", fileNames, indices, 1.0);
  }
}