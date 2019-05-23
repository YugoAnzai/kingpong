class CreditsScene extends Scene{

	void setup() {
	}

	void process() {
		super.process();

		if (input.keyEnter.enter) {
			sceneManager.changeScene("MenuScene");
			soundManager.playSound("return");
		}

	}

	void draw(){
		background(0);

		textSize(30);
		fill(255);
		text("Feito Por:", 100, 100);

		textSize(40);
		fill(0, 150, 255);
		text("Carlos Belmiro (21205466)", 100, 150);
		text("Daniela Garcia (20649004)", 100, 250);
		text("Giovanni Raposo (21114061)", 100, 350);
		text("Sofia Defino (20816627)", 100, 450);
		text("Yugo Anzai (21181866)", 100, 550);

		fill(255);
		textSize(30);
		text("Aperte Espaço para voltar", 500, 650);

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
