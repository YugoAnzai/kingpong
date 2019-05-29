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

	int crystals = 5;
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

	int aiState = 1;
	// 1: findingCrystal
	// 2: targettingCrystal
	// 3: positioningForPlate
	// 4: moveAndWaitingToShoot
	// 5: defend with crystals

	Crystal aiCrystalTarget;
	int aiMovePrecision = 2;
	int aiBallPredY = 0;
	int yPredictionSecurityWindow = 4;
	float aiCrystalAngle = 0;
	int aiAimY = 0;
	int aiShootXPred = 450;
	int aiShootYPosWindow = 3;
	int aiTimeToShoot = 0;

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
				aiState = 3;
				return;
			}

			// Lost crystal
			if (aiCrystalTarget == null || !globals.crystalsManager.crystals.contains(aiCrystalTarget)) {
				aiState = 1;
				return;
			}

			if (globals.ball.speed.x > 0) {
				// ball coming, predictY

				aiBallPredY = aiBallYPredict(pos.x);

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

			if (globals.ball.speed.x > 0) {
				// ball coming

				// if ball is already in front
				if (globals.ball.pos.x > aiShootXPred) {
					aiState = 5;
					return;
				};

				// Calculate time for ball to reach
				int ballTimeToReachX = (int)((aiShootXPred - globals.ball.pos.x) / globals.ball.speed.x);

				// Calculate when need to shoot
				int plateTimeToReachX = (int)abs(((pos.x - aiShootXPred) / plate.moveSpeed));

				// if still has time to shoot
				if (plateTimeToReachX < ballTimeToReachX) {
					println("ballTime: " + ballTimeToReachX + " platetime: " + plateTimeToReachX);

					int hittingY = aiBallYPredict(aiShootXPred);

					// calculating time to move
					int padTimeToReachY = (int)abs(((hittingY - pos.y) / moveSpeed));
					println("padTime: " + padTimeToReachY);

					// if time for pad to reach position, and shoot, move to position
					if (ballTimeToReachX >= (padTimeToReachY + plateTimeToReachX)) {
						println("To wait to shoot state");
						aiAimY = hittingY;
						aiTimeToShoot = ballTimeToReachX - plateTimeToReachX - 1;
						aiState = 4;
						return;
					} else {
						println("To wait defend with crystals");
						aiState = 5;
						return;
					}

				}

			} else {
				// ball going, just stay in height
				aiAimY = (int)globals.ball.pos.y;
				aiMoveToAim();
			}

		} else if (aiState == 4) {

			// Waiting to shoot
			aiMoveToAim();

			if (aiTimeToShoot <= 0) {
				padInput.keyEnterAction = true;
				aiState = 1;
				return;
			} else {
				aiTimeToShoot--;
			}

		} else if (aiState == 5) {

			aiAimY = (int)globals.ball.pos.y;
			aiMoveToAim();

			if (globals.ball.speed.x < 0) {
				aiState = 3;
				return;
			}

		}

	}

	int aiBallYPredict(float x) {
		// Given x value, simulate y position of ball in that x value, even with bounces

		float ballSpeedTg = globals.ball.speed.y / globals.ball.speed.x;
		int ballPredY = (int) (globals.ball.pos.y + (x - globals.ball.pos.x) * ballSpeedTg);

		// fixing aiBallPredY in case of wall bounce
		int securityCounter = 0;
		while((ballPredY < globals.ceilingY || ballPredY > globals.floorY) && securityCounter < 5) {
			if (ballPredY < globals.ceilingY - yPredictionSecurityWindow) {
				ballPredY = abs(ballPredY) + 2 * globals.ceilingY + globals.ball.colliderH;
			} else if (ballPredY > globals.floorY + yPredictionSecurityWindow) {
				ballPredY = 2 * globals.floorY + globals.ball.colliderH - ballPredY;
			}
			securityCounter++;
		}

		return ballPredY;

	}

	void aiMoveToAim() {
		// if aiAimY is defined, inputs to move pad to that position

		if (aiAimY > pos.y + aiMovePrecision) {
			padInput.pressedDown = true;
		} else if (aiAimY < pos.y - aiMovePrecision) {
			padInput.pressedUp = true;
		}
	}

	void updatePadInput() {
		// updateInput according to keyboard input

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

		// draw things for debugging AP. Press 'P' to see debug info in game
		fill(0, 255, 0);
		ellipse((int)pos.x, aiBallPredY, 5, 5);

		fill(0, 0, 255);
		ellipse((int)pos.x, aiAimY, 5, 5);

		int crystalX = 0;
		int crystalY = 0;
		if (aiCrystalTarget != null) {
			crystalX = (int)aiCrystalTarget.pos.x;
			crystalY = (int)aiCrystalTarget.pos.y;
			fill(0, 255, 0);
			ellipse(crystalX, crystalY, 5, 5);
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
