public class Progress {
  private float _progress;
  private ArrayList<Float[]> _progressChanges;
  
  Progress() {
    _progress = 0.375;
    _progressChanges = new ArrayList();
  }
  
  void applyProgressChanges() { 
    for (int i = _progressChanges.size()-1; i >= 0; i--) {
      Float[] data         = _progressChanges.get(i); 
      Float startTime      = data[0];
      Float duration       = data[1];
      Float progressChange = data[2];
      
      if ((float)millis()/1000 - startTime < duration) {
        changeProgressBy(progressChange);
      } else {
        _progressChanges.remove(i);
      }
    }
  }
  
  void addProgressChange(float progressChange, float duration) { 
    _progressChanges.add(new Float[] { (float)millis()/1000, duration, progressChange });
  }
  
  float getTotalProgressChange() {
    float total = 0;
    for (Float[] data : _progressChanges) {
      total += data[2];
    }
    return total;
  }
  
  void changeProgressBy(float delta) { _progress = min(max(_progress+delta, 0), 1); }
  float getProgress() { return _progress; }
}

public class Pair<T1, T2> {
  T1 first;
  T2 second;
  
  Pair(T1 v1, T2 v2) {
    first = v1;
    second = v2;
  }
}