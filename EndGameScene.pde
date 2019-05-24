class EndGameScene extends Scene{

	ArrayList<SelectibleText> texts = new ArrayList();
	// Animator logo;

	int optionsOffset = 0;
	int firstOptionY = 400;
	int optionsSpacing = 50;

	Animator pad;

	void setup() {

		texts.add(new SelectibleText(width/2 + optionsOffset, firstOptionY, "Jogar Novamente"));
		texts.add(new SelectibleText(width/2 + optionsOffset, firstOptionY + optionsSpacing, "Voltar ao Menu"));

		texts.get(0).selected = true;

		pad = new Animator(0, 0, "pad" + globals.wonLastGame + ".png", 1, 1);
		pad.createAnimation("idle", new int[]{0}, new int[]{99});
		pad.setAnimation("idle");
		pad.x = width/2;
		pad.y = height/2;

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
				sceneManager.changeScene("GameScene");
			} else if (index == 1) {
				sceneManager.changeScene("MenuScene");
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

		textSize(60);
		fill(globals.c2);
		text("Jogador " + globals.wonLastGame + " venceu!", width/2 + 4, 100 + 4);
		fill(globals.c3);
		text("Jogador " + globals.wonLastGame + " venceu!", width/2, 100);

		pad.draw();

		for (SelectibleText text : texts){
			text.draw();
		}

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
