class HowToPlayScene extends Scene{

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
		text("How To Play", 100, 100);

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
