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

  void setSpeed(float magnitude) {
    int rand = (int)random(0,2);
    if (rand == 1) {
      speed.x = magnitude;
			speed.y = 0;
    } else {
      speed.x = -magnitude;
			speed.y = 0;
    }
  }

	void process() {

    collided = rectCollider.process();

    pos.x += speed.x;
    pos.y += speed.y;

    // Walls
		float absSpeed = abs(speed.y);
    if ((pos.y - colliderH/2) < globals.ceilingY) {
			speed.y = absSpeed;
		} else if((pos.y + colliderH/2) > globals.floorY) {
      speed.y = - absSpeed;
    }

		collided = rectCollider.process();
		if (collided.length > 0) {
			Crystal crystal = (Crystal)collided[0].gameObject;
			if (crystal != null) {
				crystal.collect(lastHitPlayer);
			}
		}

	}

	void destroy() {
		rectCollider.removeFromColliderMask();
	}

}
