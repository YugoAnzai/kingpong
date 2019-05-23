class GameScene extends Scene{

	Ball ball;
	Animator bg;

	void setup() {
		bg = new Animator(width/2, height/2, "field.png", 1, 1);
		bg.createAnimation("idle", new int[]{0}, new int[]{99});
		bg.setAnimation("idle");

		ball = new Ball(width/2, height/2);
		ball.setSpeed(1, 1);

	}

	void process() {
		super.process();

		ball.process();

		if (input.keyEnter.esc) {
			sceneManager.changeScene("MenuScene");
		}

	}

	void draw(){

		bg.draw();

		ball.draw();

	}

	void debugDraw() {
	}

	void destroy(){
		super.destroy();
	}

}
