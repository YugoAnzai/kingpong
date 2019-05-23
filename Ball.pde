class Ball extends GameObject {

	int colliderW = 13;
	int colliderH = 13;

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
    super.process();

		rectCollider.process();
	}

	void destroy() {
		rectCollider.removeFromColliderMask();
	}

}
