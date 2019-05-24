class CreditsScene extends Scene{

	void setup() {
	}

	void process() {
		super.process();

		if (input.keyEnter.enter) {
			soundManager.playSound("bounce2");
			sceneManager.changeScene("MenuScene");
		}

	}

	void draw(){

		background(globals.c1);

		fill(globals.c3);
		textSize(22);
		text("Feito por:", width/2, 100);

		textSize(80);
		fill(globals.c2);
		text("Yugo Anzai", width/2 + 4, 270 + 4);
		fill(globals.c3);
		text("Yugo Anzai", width/2, 270);

		fill(globals.c3);
		textSize(18);
		text("Enter para voltar", width/2, 470);

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
