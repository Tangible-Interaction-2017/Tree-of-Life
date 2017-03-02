public class Progress {
  private float _progress;
  private HashMap<String, ArrayList<Float[]>> _progressChanges;
  
  Progress() {
    _progress = 0;
    _progressChanges = new HashMap();
  }
  
  void applyProgressChanges() { 
    ArrayList<String> idsToRemove = new ArrayList();
    for (String dataId : _progressChanges.keySet()) {
      ArrayList<Float[]> dataList = _progressChanges.get(dataId);
      for (int i = dataList.size()-1; i >= 0; i--) {
        Float[] data         = dataList.get(i);
        Float startTime      = data[0];
        Float duration       = data[1];
        Float progressChange = data[2];
        
        if ((float)millis()/1000 - startTime < duration) {
          changeProgressBy(progressChange);
        } else {
          dataList.remove(i);
        }
      }
      if (dataList.size() == 0) idsToRemove.add(dataId);
    }
    for (String id : idsToRemove) _progressChanges.remove(id);
  }
  
  void addProgressChange(String id, float progressChange, float duration) { 
    if (!_progressChanges.containsKey(id)) {
      _progressChanges.put(id, new ArrayList());
    } 
    _progressChanges.get(id).add(new Float[] { (float)millis()/1000, duration, progressChange });
  }
  
  void removeProgressChange(String id) {
    if (_progressChanges.containsKey(id)) {
      _progressChanges.get(id).remove(_progressChanges.get(id).size()-1);
      if (_progressChanges.get(id).size() == 0) _progressChanges.remove(id);
    }
  }
  
  float getTotalProgressChange() {
    float total = 0;
    for (String id : _progressChanges.keySet()) {
      for (Float[] data : _progressChanges.get(id)) {
        total += data[2];
      }
    }
    return total;
  }
  
  void resetProgress() { 
    _progress = 0;
    _progressChanges.clear(); 
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