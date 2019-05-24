class HowToPlayScene extends Scene{

	Animator tutorial;

	int controlsX = 200;
	int crystalsX = 600;

	void setup() {

		tutorial = new Animator(width/2, height/2, "tutorial.png", 1, 1);
		tutorial.createAnimation("idle", new int[]{0}, new int[]{99});
		tutorial.setAnimation("idle");

	}

	void process() {
		super.process();

		if (input.keyEnter.enter) {
			sceneManager.changeScene("MenuScene");
		}

	}

	void draw(){

		tutorial.draw();

		fill(globals.c3);
		textSize(50);
		text("Controles", controlsX, 80);
		text("Cristais", crystalsX, 80);

		textSize(16);
		text("Colete cristais rebatendo o disco", crystalsX, 260);
		text("Use 5 cristais para lançar plataforma", crystalsX, 430);

		fill(globals.c3);
		textSize(18);
		text("Enter para voltar", width/2, 493);

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
