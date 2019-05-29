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

		fill(globals.c4);
		textSize(22);
		text("Feito por:", width/2, 100);

		textSize(80);
		fill(globals.c2);
		text("Yugo Anzai", width/2 + 4, 180 + 4);
		fill(globals.c3);
		text("Yugo Anzai", width/2, 180);

		textSize(20);
		fill(globals.c3);
		text("RA:", width/2 - 60, 220 - 10);
		textSize(40);
		fill(globals.c2);
		text("21181866", width/2 + 70 + 4, 220 + 4);
		fill(globals.c3);
		text("21181866", width/2 + 70, 220);

		fill(globals.c4);
		textSize(22);
		text("Trilha Sonora:", width/2, 310);

		fill(globals.c3);
		textSize(22);
		text("Rebels Be - Avgvst - CC-BY", width/2, 340);
		text("The Empire - Avgvst - CC-BY", width/2, 370);

		fill(globals.c4);
		textSize(18);
		text("Enter para voltar", width/2, 470);

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
