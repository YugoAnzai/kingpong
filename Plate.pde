class Plate extends GameObject {

	int colliderW = 5;
	int colliderH = 50;
	int colliderOffset = 20;
	RectCollider[] collided;

	float hitMaxAngle = 40;
	float hitSpeedMultiplier = 1.1;

	boolean isAlive = false;
	int lifeTotalTimer = 60;
	int lifeTimer = 0;

	int player = 1;

	int moveSpeed = 8;

	Plate(int x, int y, int _player) {
		super(x, y, "Plate");
		player = _player;

		if (player == 2) {
			colliderOffset = -colliderOffset;
			moveSpeed = - moveSpeed;
		}
		rectCollider = new RectCollider(this, colliderManager.pads, colliderW, colliderH, colliderOffset, 0);

		anim = new Animator(0, 0, "plate" + player + ".png", 1, 1);
		anim.createAnimation("idle", new int[]{0}, new int[]{99});
		anim.setAnimation("idle");

		die();

	}

	void process() {

		collided = rectCollider.process();

		if (!isAlive) return;

		pos.x += moveSpeed;

		if (collided.length > 0) {
			hitBall((Ball)collided[0].gameObject);
			die();
		}

		if (lifeTimer < 0) {
			die();
		} else {
			lifeTimer --;
		}

	}

	void hitBall(Ball ball) {
		float speedMagnitude = sqrt(sq(ball.speed.x ) + sq(ball.speed.y));
		speedMagnitude *= hitSpeedMultiplier;
		float angle = hitMaxAngle * ((ball.pos.y - pos.y)/(colliderH/2));
		if (ball.speed.x > 0) {
			ball.speed.x = - cos(radians(angle)) * speedMagnitude;
		} else {
			ball.speed.x = cos(radians(angle)) * speedMagnitude;
		}
		ball.speed.y = sin(radians(angle)) * speedMagnitude;

		ball.lastHitPlayer = player;

	}

	void start(int x, int y) {
		pos.x = x;
		pos.y = y;
		isAlive = true;
	}

	void die() {
		lifeTimer = lifeTotalTimer;
		pos.x = -300;
		isAlive = false;
	}

	void destroy() {
		rectCollider.removeFromColliderMask();
	}

}
