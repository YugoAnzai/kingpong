class Ball extends GameObject {

	int colliderW = 22;
	int colliderH = 22;

  RectCollider[] collided;

  int lastHitPlayer = 0;

	Ball(int x, int y) {
		super(x, y, "Ball");
		rectCollider = new RectCollider(this, colliderManager.ball, colliderW, colliderH);

		anim = new Animator(0, 0, "ball.png", 1, 1);
		anim.createAnimation("idle", new int[]{0}, new int[]{99});
		anim.setAnimation("idle");

	}

  void setSpeed(float x, float y) {
    speed.x = x;
    speed.y = y;
  }

	void process() {

    collided = rectCollider.process();

    pos.x += speed.x;
    pos.y += speed.y;

    // Walls
    if ((pos.y - colliderH/2) < globals.ceilingY || (pos.y + colliderH/2) > globals.floorY) {
      speed.y = - speed.y;
    }

	}

	void destroy() {
		rectCollider.removeFromColliderMask();
	}

}
