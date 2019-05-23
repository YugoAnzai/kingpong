class Transform {
  float x;
  float y;

  Transform(float _x, float _y){
    x = _x;
    y = _y;
  }

  void copyFromTransform(Transform t){
    x = t.x;
    y = t.y;
  }
}
