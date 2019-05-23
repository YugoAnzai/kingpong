class GameScene extends Scene{

	Ball ball;
	Animator bg;

	void setup() {
		bg = new Animator(width/2, height/2, "field.png", 1, 1);
		bg.createAnimation("idle", new int[]{0}, new int[]{99});
		bg.setAnimation("idle");
	}

	void process() {
		super.process();

		if (input.keyEnter.enter) {
			sceneManager.changeScene("MenuScene");
		}

	}

	void draw(){

		bg.draw();

		textSize(30);
		fill(255);
		text("Game", 100, 100);

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
