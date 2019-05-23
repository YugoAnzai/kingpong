class MenuScene extends Scene{

	ArrayList<SelectibleText> texts = new ArrayList();
	// Animator logo;

	void setup() {

		texts.add(new SelectibleText(470, 300, "Jogar"));
		texts.add(new SelectibleText(470, 400, "Creditos"));

		texts.get(0).selected = true;

		// logo = new Animator(0, 0, "logo.png", 1, 1);
		// logo.createAnimation("idle", new int[]{0}, new int[]{99});
		// logo.setAnimation("idle");

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
			soundManager.playSound("select");
			int index = getSelectedIndex();
			if (index == 0) {
				sceneManager.changeScene("GameScene");
			} else if (index == 1) {
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

		for (SelectibleText text : texts){
			text.draw();
		}

		fill(globals.c3);
		textSize(25);
		textAlign(CENTER);
		text("Use 'w' e 's' para mover e Enter para selecionar", width/2, 400);
		textAlign(LEFT);

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
