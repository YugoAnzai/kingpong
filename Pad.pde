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

	int colliderW = 20;
	int colliderH = 100;
	int colliderOffset = 15;

	int player = 1;

	int moveSpeed = 10;


	Pad(int x, int y, int _player) {
		super(x, y, "Pad" + _player);

		player = _player;

		if (player == 2) colliderOffset = -colliderOffset;
		rectCollider = new RectCollider(this, colliderManager.pads, colliderW, colliderH, colliderOffset, 0);

		padInput = new PadInput();

		anim = new Animator(0, 0, "pad" + player + ".png", 1, 1);
		anim.createAnimation("idle", new int[]{0}, new int[]{99});
		anim.setAnimation("idle");

	}

	void process() {

    // Control
		control();

		rectCollider.process();

	}

	void control() {

		updatePadInput();

		if (padInput.pressedUp) {
      pos.y -= moveSpeed;
    }
    if (padInput.pressedDown) {
      pos.y += moveSpeed;
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

	void destroy() {
		rectCollider.removeFromColliderMask();
	}

}
