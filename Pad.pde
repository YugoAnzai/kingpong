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

	int moveSpeed = 6;

	int crystals = 0;
	int crystalsToPlate = 5;
	int crystalsRectW = 4;
	int crystalsRectH = 80;
	int crystalIconColorTotalTimer = 5;
	int crystalIconColorTimer;
	boolean crystalIconTint = false;
	Animator crystalIcon;
	int[] crystalXOffsets = {-30, -30, -30, -30, -30};
	int[] crystalYOffsets = {-50, -25, 0, 25, 50};

	Plate plate;

	// IA variables
	// 1: findingCrystal 2: targettingCrystal; 3: using_plate
	int aiState = 1;
	Crystal aiCrystalTarget;
	int aiMovePrecision = 2;
	int aiBallPredY = 0;
	float aiCrystalAngle = 0;
	int aiAimY = 0;

	Pad(int x, int y, int _player) {
		super(x, y, "Pad" + _player);
		player = _player;

		if (player == 2) {
			colliderOffset = -colliderOffset;
			for (int i = 0; i < crystalXOffsets.length; i++) {
				crystalXOffsets[i] = -crystalXOffsets[i];
			}
		}

		rectCollider = new RectCollider(this, colliderManager.pads, colliderW, colliderH, colliderOffset, 0);

		padInput = new PadInput();

		anim = new Animator(0, 0, "pad" + player + ".png", 1, 1);
		anim.createAnimation("idle", new int[]{0}, new int[]{99});
		anim.setAnimation("idle");

		crystalIcon = new Animator(0, 0, "crystalIcon.png", 1, 1);
		crystalIcon.createAnimation("idle", new int[]{0}, new int[]{99});
		crystalIcon.setAnimation("idle");

		hitTimer = hitTotalTimer;

		crystalIconColorTimer = crystalIconColorTotalTimer;

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
			if (crystalIconColorTimer < 0) {
				crystalIconTint = !crystalIconTint;
				crystalIconColorTimer = crystalIconColorTotalTimer;
			} else {
				crystalIconColorTimer--;
			}
		}

	}

	void draw() {
		super.draw();

		if (crystalIconTint) tint(0);
		for(int i = 0; i < crystals; i ++) {
			crystalIcon.x = pos.x + crystalXOffsets[i];
			crystalIcon.y = pos.y + crystalYOffsets[i];
			crystalIcon.draw();
		}
		noTint();

		plate.draw();

	}

	void getCrystal() {
		if (crystals < crystalsToPlate) {
			crystals++;
		}
	}

	void hitBall(Ball ball) {

		if (player == 1) {
			soundManager.playSound("bounce1");
		} else if (player == 2) {
			soundManager.playSound("bounce2");
		}

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

		if (player == 2 && globals.isSoloGame) {
			aiUpdatePadInput();
		} else {
			updatePadInput();
		}

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

	void aiUpdatePadInput() {
		// Sobrescrever controles com lógica de IA
		padInput.pressedUp = false;
		padInput.pressedDown = false;
		padInput.keyEnterAction = false;

		if (aiState == 1) {

			// Try to find and define a crystal to target

			// find crystal
			if (globals.crystalsManager.crystals.size() > 0) {
				aiCrystalTarget = globals.crystalsManager.crystals.get((int)random(globals.crystalsManager.crystals.size()));
				aiState = 2;
				return;
			}

		} else if (aiState == 2) {

			// Calculate positions to try and hit ball to collect chosen crystal

			// Has enough crystals to use special, change state
			if (crystals == crystalsToPlate) {

			}

			// Lost crystal
			if (aiCrystalTarget == null || !globals.crystalsManager.crystals.contains(aiCrystalTarget)) {
				aiState = 1;
				return;
			}

			if (globals.ball.speed.x > 0) {

				// ball coming, predictY
				float ballSpeedTg = globals.ball.speed.y / globals.ball.speed.x;
				aiBallPredY = (int) (globals.ball.pos.y + (pos.x - globals.ball.pos.x) * ballSpeedTg);

				// fixing aiBallPredY in case of wall bounce
				while(aiBallPredY < globals.ceilingY || aiBallPredY > globals.floorY) {
					if (aiBallPredY < globals.ceilingY) {
						aiBallPredY = abs(aiBallPredY) + 2 * globals.ceilingY + globals.ball.colliderH;
					} else if (aiBallPredY > globals.floorY) {
						aiBallPredY = 2 * globals.floorY + globals.ball.colliderH - aiBallPredY;
					}
				}

				// Angle for crystal
				aiCrystalAngle = degrees(atan((aiBallPredY - aiCrystalTarget.pos.y) / (pos.x - aiCrystalTarget.pos.x)));
				aiAimY = aiBallPredY + (int)((colliderH/2) * (aiCrystalAngle/hitMaxAngle));

				aiMoveToAim();

			} else {
				// ball going, just stay in height
				aiAimY = (int)globals.ball.pos.y;
				aiMoveToAim();
			}

		} else if (aiState == 3) {

			// Find best position and timing to shoot

			// ball going, just stay in height
			aiAimY = (int)globals.ball.pos.y;
			aiMoveToAim();


		}

	}

	void aiMoveToAim() {
		if (aiAimY > pos.y + aiMovePrecision) {
			padInput.pressedDown = true;
		} else if (aiAimY < pos.y - aiMovePrecision) {
			padInput.pressedUp = true;
		}
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

	void launchPlate() {

		soundManager.playSound("plate");

		plate.start((int)pos.x, (int)pos.y);
		crystals = 0;
		crystalIconTint = false;
	}

	void debugDraw() {
		super.debugDraw();
		plate.debugDraw();

		fill(0, 255, 0);
		circle((int)pos.x, aiBallPredY, 5);

		fill(0, 0, 255);
		circle((int)pos.x, aiAimY, 5);

		int crystalX = 0;
		int crystalY = 0;
		if (aiCrystalTarget != null) {
			crystalX = (int)aiCrystalTarget.pos.x;
			crystalY = (int)aiCrystalTarget.pos.y;
			fill(0, 255, 0);
			circle(crystalX, crystalY, 5);
		}

		String[] lines = {
      "aiState: " + aiState,
			"crystalX: " + crystalX,
			"crystalY: " + crystalX,
			"aiBallPredY: " + aiBallPredY,
			"aiCrystalAngle: " + aiCrystalAngle,
    };
    debug.draw(lines, 500, 10);

	}

	void destroy() {
		rectCollider.removeFromColliderMask();
	}

}
