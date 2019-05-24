class MenuScene extends Scene{

	ArrayList<SelectibleText> texts = new ArrayList();
	// Animator logo;

	int optionsOffset = 0;
	int firstOptionY = 200;
	int optionsSpacing = 50;

	void setup() {

		texts.add(new SelectibleText(width/2 + optionsOffset, firstOptionY, "Jogar Solo"));
		texts.add(new SelectibleText(width/2 + optionsOffset, firstOptionY + optionsSpacing, "Jogar Multiplayer"));
		texts.add(new SelectibleText(width/2 + optionsOffset, firstOptionY + 2*optionsSpacing, "Como Jogar"));
		texts.add(new SelectibleText(width/2 + optionsOffset, firstOptionY + 3*optionsSpacing, "Creditos"));

		texts.get(0).selected = true;

	}

	void process() {
		super.process();

		if (input.keyEnter.p1up || input.keyEnter.p1down) {

			int index = getSelectedIndex();
			texts.get(index).selected = false;

			if (input.keyEnter.p1down) index++;
			else if (input.keyEnter.p1up) index--;

			if (index < 0) index += texts.size();
			else if (index >= texts.size()) index -= texts.size();

			texts.get(index).selected = true;

		}

		if (input.keyEnter.enter) {
			int index = getSelectedIndex();
			if (index == 0) {
				globals.isSoloGame = true;
				sceneManager.changeScene("GameScene");
			} else if (index == 1) {
				globals.isSoloGame = false;
				sceneManager.changeScene("GameScene");
			} else if (index == 2) {
				sceneManager.changeScene("HowToPlayScene");
			} else if (index == 3) {
				sceneManager.changeScene("CreditsScene");
			}
		}


	}

	int getSelectedIndex() {
		for (int i = 0; i < texts.size(); i++) {
			if (texts.get(i).selected) {
				return i;
			}
		}
		return 0;
	}

	void draw(){

		background(globals.c1);

		textSize(80);
		fill(globals.c2);
		text("King Pong", width/2 + 4, 100 + 4);
		fill(globals.c3);
		text("King Pong", width/2, 100);

		for (SelectibleText text : texts){
			text.draw();
		}

		fill(globals.c3);
		textSize(18);
		text("Use 'w' e 's' para mover e Enter para selecionar", width/2, 470);

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
