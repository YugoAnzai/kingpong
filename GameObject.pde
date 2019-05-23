class GameObject {

  Transform pos;
  Transform speed;
  String name;
  Animator anim;
  RectCollider rectCollider;

  GameObject(int x, int y, String _name){
    name = _name;
    pos = new Transform(x, y);
    speed = new Transform(0, 0);
  }

  void hit() {

  }

  void setup() {

  }

  void process() {

  }

  void draw() {
    anim.x = (int)pos.x;
    anim.y = (int)pos.y;
    anim.draw();
  }

  void debugDraw() {
    if (rectCollider!= null) {
        rectCollider.debugDraw();
    }
  }

  void finalize() {
    println(name + " cleared");
  }

}
