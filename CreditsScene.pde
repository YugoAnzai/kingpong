class CreditsScene extends Scene{

	void setup() {
	}

	void process() {
		super.process();

		if (input.keyEnter.enter) {
			sceneManager.changeScene("MenuScene");
		}

	}

	void draw(){
		background(0);

		textSize(30);
		fill(255);
		text("Feito Por:", 100, 100);

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
