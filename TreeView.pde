public class TreeView extends Animatable {
  TreeView() {
    super(width/2 - width/10, height/8*5 - 1.392 * width/5 + 20, width/5, 1.392 * width/5);
    
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
    addFrameAnimation("stage_0_dying", fileNames, indices, 0.7);
    
    fileNames = new String[] {
      "images/tree_stage_1_0.png", 
      "images/tree_stage_1_1.png"
    };
    indices = new int[] {
      0, 1
    };
    addFrameAnimation("stage_1", fileNames, indices, 0.7);
    
    fileNames = new String[] {
      "images/tree_stage_1_dying_0.png",  
      "images/tree_stage_1_dying_1.png", 
      "images/tree_stage_1_dying_2.png",
      "images/tree_stage_1_dying_3.png"
    };
    indices = new int[] {
      0, 1, 2, 3
    };
    addFrameAnimation("stage_1_dying", fileNames, indices, 0.7);
    
    fileNames = new String[] {
      "images/tree_stage_2_0.png", 
      "images/tree_stage_2_1.png", 
      "images/tree_stage_2_2.png", 
      "images/tree_stage_2_3.png"
    };
    indices = new int[] {
      0, 1, 2, 3
    };
    addFrameAnimation("stage_2", fileNames, indices, 0.7);
    
    fileNames = new String[] {
      "images/tree_stage_2_dying_0.png",  
      "images/tree_stage_2_dying_1.png", 
      "images/tree_stage_2_dying_2.png",
      "images/tree_stage_2_dying_3.png"
    };
    indices = new int[] {
      0, 1, 2, 3
    };
    addFrameAnimation("stage_2_dying", fileNames, indices, 0.7);
    
    fileNames = new String[] {
      "images/tree_stage_3_0.png", 
      "images/tree_stage_3_1.png", 
      "images/tree_stage_3_2.png"
    };
    indices = new int[] {
      0, 1, 2
    };
    addFrameAnimation("stage_3", fileNames, indices, 0.7);
    
    fileNames = new String[] {
      "images/tree_stage_3_dying_0.png",  
      "images/tree_stage_3_dying_1.png", 
      "images/tree_stage_3_dying_2.png",
      "images/tree_stage_3_dying_3.png"
    };
    indices = new int[] {
      0, 1, 2, 3
    };
    addFrameAnimation("stage_3_dying", fileNames, indices, 0.7);
  }
}