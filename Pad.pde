class PadInput {

	boolean pressedUp = false;
	boolean pressedDown = false;
	boolean pressedAction = false;
	boolean keyEnterUp = false;
	boolean keyEnterDown = false;
	boolean keyEnterAction = false;
	boolean keyExitUp = false;
	boolean keyExitDown = false;
	boolean keyExitAction = false;

	PadInput(){

	}

}

class Pad extends GameObject {

	PadInput padInput;

	int colliderW = 5;
	int colliderH = 100;
	int colliderOffset = 20;
	RectCollider[] collided;
	int hitTotalTimer = 20;
	int hitTimer;
	float hitMaxAngle = 40;

	int player = 1;

	int moveSpeed = 10;

	int crystals = 0;
	int crystalsToPlate = 5;
	int crystalsRectW = 4;
	int crystalsRectH = 80;
	int crystalsBarColorTotalTimer = 4;
	int crystalsBarColorTimer;
	color crystalsBarColor;

	Plate plate;

	Pad(int x, int y, int _player) {
		super(x, y, "Pad" + _player);
		player = _player;

		if (player == 2) colliderOffset = -colliderOffset;
		rectCollider = new RectCollider(this, colliderManager.pads, colliderW, colliderH, colliderOffset, 0);

		padInput = new PadInput();

		anim = new Animator(0, 0, "pad" + player + ".png", 1, 1);
		anim.createAnimation("idle", new int[]{0}, new int[]{99});
		anim.setAnimation("idle");

		hitTimer = hitTotalTimer;

		crystalsBarColor = globals.c2;
		crystalsBarColorTimer = crystalsBarColorTotalTimer;

		plate = new Plate(0, 0, player);

	}

	void process() {

		plate.process();

		if (hitTimer <= 0) {
			collided = rectCollider.process();
			if (collided.length > 0) {
				hitBall((Ball)collided[0].gameObject);
				hitTimer = hitTotalTimer;
			}
		} else {
			hitTimer--;
		}

		control();

    pos.y = constrain(pos.y, globals.ceilingY + colliderH/2, globals.floorY - colliderH/2);

		// crystals bar color
		if (crystals == crystalsToPlate) {
			if (crystalsBarColorTimer < 0) {
				if (crystalsBarColor == globals.c2) {
					crystalsBarColor = globals.c3;
				} else {
					crystalsBarColor = globals.c2;
				}
				crystalsBarColorTimer = crystalsBarColorTotalTimer;
			} else {
				crystalsBarColorTimer--;
			}
		}

	}

	void draw() {
		super.draw();

		fill(crystalsBarColor);
		rect(pos.x + colliderOffset, pos.y, crystalsRectW, (int) crystalsRectH * ((float)crystals/crystalsToPlate));

		plate.draw();

	}

	void getCrystal() {
		if (crystals < crystalsToPlate) {
			crystals++;
		}
	}

	void hitBall(Ball ball) {
		float speedMagnitude = sqrt(sq(ball.speed.x ) + sq(ball.speed.y));
		float angle = hitMaxAngle * ((ball.pos.y - pos.y)/(colliderH/2));
		if (ball.speed.x > 0) {
			ball.speed.x = - cos(radians(angle)) * speedMagnitude;
		} else {
			ball.speed.x = cos(radians(angle)) * speedMagnitude;
		}
		ball.speed.y = sin(radians(angle)) * speedMagnitude;

		ball.lastHitPlayer = player;

	}

	void control() {

		updatePadInput();

		if (padInput.pressedUp) {
      pos.y -= moveSpeed;
    }
    if (padInput.pressedDown) {
      pos.y += moveSpeed;
    }

		if (crystals == crystalsToPlate && padInput.keyEnterAction) {
			launchPlate();
		}

	}

	void launchPlate() {
		plate.start((int)pos.x, (int)pos.y);
		crystals = 0;
		crystalsBarColor = globals.c2;
	}

	void updatePadInput() {
		if (player == 1) {
			padInput.pressedUp = input.pressed.p1up;
			padInput.pressedDown = input.pressed.p1down;
			padInput.pressedAction = input.pressed.p1action;
			padInput.keyEnterUp = input.keyEnter.p1up;
			padInput.keyEnterDown = input.keyEnter.p1down;
			padInput.keyEnterAction = input.keyEnter.p1action;
		} else {
			padInput.pressedUp = input.pressed.p2up;
			padInput.pressedDown = input.pressed.p2down;
			padInput.pressedAction = input.pressed.p2action;
			padInput.keyEnterUp = input.keyEnter.p2up;
			padInput.keyEnterDown = input.keyEnter.p2down;
			padInput.keyEnterAction = input.keyEnter.p2action;
		}
	}

	void debugDraw() {
		super.debugDraw();
		plate.debugDraw();
	}

	void destroy() {
		rectCollider.removeFromColliderMask();
	}

}
