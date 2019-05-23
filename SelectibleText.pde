class SelectibleText{

	String text;
	boolean selected = false;
	int x;
	int y;

	int selectionXOffset = -20;
	int selectionYOffset = -5;

	Animator selector;

	// x, y in the center of branch
	SelectibleText(int _x, int _y, String _text) {
		x = _x;
		y = _y;
		text = _text;

		selector = new Animator(0, 0, "crystal.png", 1, 1);
		selector.createAnimation("idle", new int[]{0}, new int[]{99});
		selector.setAnimation("idle");

		selector.x = x + selectionXOffset;
		selector.y = y + selectionXOffset;

	}

	void draw() {
		textSize(30);
		if(selected) {
			fill(globals.c2);
			selector.draw();
		} else {
			fill(globals.c3);
		}
		text(text, x, y);
	}

}
