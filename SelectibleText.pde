class SelectibleText{

	String text;
	boolean selected = false;
	int x;
	int y;

	int selectionXOffset = 180;
	int selectionYOffset = -8;

	Animator selector;

	// x, y in the center of branch
	SelectibleText(int _x, int _y, String _text) {
		x = _x;
		y = _y;
		text = _text;

		selector = new Animator(0, 0, "crystal.png", 1, 1);
		selector.createAnimation("idle", new int[]{0}, new int[]{99});
		selector.setAnimation("idle");

		selector.y = y + selectionYOffset;

	}

	void draw() {
		textSize(26);
		if(selected) {
			fill(globals.c2);
			selector.x = x - selectionXOffset;
			selector.draw();
			selector.x = x + selectionXOffset;
			selector.draw();
		} else {
			fill(globals.c3);
		}
		text(text, x, y);
	}

}
